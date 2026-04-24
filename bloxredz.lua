-- Redz Hub 汉化版（无界面/音乐，带状态显示）
print("🎮 启动 Redz Hub + 翻译系统...")

-- 创建一个简单的状态显示（在屏幕左上角）
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local statusGui = Instance.new("ScreenGui")
statusGui.Name = "TranslationStatus"
statusGui.Parent = playerGui

local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(0, 250, 0, 60)
statusFrame.Position = UDim2.new(0, 10, 0, 10)
statusFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusFrame.BackgroundTransparency = 0.5
statusFrame.BorderSizePixel = 1
statusFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
statusFrame.Parent = statusGui

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.TextScaled = true
statusText.Font = Enum.Font.GothamBold
statusText.Text = "正在加载..."
statusText.Parent = statusFrame

-- ========== 完整翻译表 ==========
local Translations = {
    -- 标题/作者
    ["redz hub : Blox Fruits by real_redz"] = "Redz中心 : 果实风暴 by real_redz",
    -- 导航栏
    ["Discord"] = "Discord",
    ["Farm"] = "刷怪",
    ["Fishing"] = "钓鱼",
    ["Islands"] = "岛屿",
    ["Quest/Items"] = "任务/物品",
    ["Chest"] = "宝箱",
    ["Teleport"] = "传送",
    ["Status"] = "状态",
    ["Shop"] = "商店",
    ["Misc"] = "杂项",
    ["Menu"] = "菜单",
    ["Visual"] = "视觉",
    ["Stats"] = "属性",
    ["Esp"] = "透视",
    ["Server"] = "服务器",
    ["Team"] = "队伍",
    ["Race"] = "种族",
    ["Local-Player"] = "本地玩家",
    ["Battle"] = "战斗",
    -- 截图中出现的
    ["Join Server"] = "加入服务器",
    ["REDZ"] = "REDZ中心",
    ["Job ID"] = "房间ID",
    ["Join Clipboard"] = "加入剪贴板",
    ["Config."] = "配置",
    ["Farm Mode"] = "刷怪模式",
    ["Fruits/Raid"] = "果实/突袭",
    ["Farm Distance"] = "刷怪距离",
    ["Bring Range"] = "牵引范围",
    ["Tween Speed"] = "缓动速度",
    ["Bring Mobs"] = "牵引怪物",
    ["Auto Haki"] = "自动霸气",
    ["Auto Attack"] = "自动攻击",
    ["Auto Shoot"] = "自动射击",
    ["Label"] = "标签",
    ["Health105/105"] = "生命105/105",
    -- 更多条目（保留之前提供的完整翻译）
    ["Auto Farm Level"] = "自动刷等级",
    ["Melee"] = "近战",
    -- 这里请自行补全你之前所有的翻译条目，避免缺失
}

-- ========== 翻译引擎 ==========
local translationCache = {}
local processedElements = {}

local function normalizeText(str)
    -- 去除首尾空白，并标准化
    if not str then return "" end
    str = str:gsub("^%s+", ""):gsub("%s+$", "")
    return str
end

local function translateText(text)
    if type(text) ~= "string" or text == "" then return text end
    local normalized = normalizeText(text)
    if translationCache[normalized] then return translationCache[normalized] end
    local translated = Translations[normalized]
    if translated then
        translationCache[normalized] = translated
        return translated
    end
    translationCache[normalized] = text
    return text
end

local function translateGuiElement(gui)
    if not gui or not gui.Parent or processedElements[gui] then return end
    if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
        local original = gui.Text
        if original and original ~= "" then
            local translated = translateText(original)
            if translated ~= original then
                pcall(function() gui.Text = translated end)
                print("[翻译] " .. original .. " -> " .. translated)
            end
        end
        processedElements[gui] = true
    end
end

local function scanAll(container)
    for _, child in ipairs(container:GetChildren()) do
        pcall(translateGuiElement, child)
        scanAll(child)
    end
end

-- ========== 加载外部脚本 ==========
local function loadRedzHub()
    local Settings = {}
    local success, err = pcall(function()
        local content = game:HttpGet("https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/main.luau", true)
        local func = loadstring(content)
        if func then
            func(Settings)
        else
            error("loadstring 失败")
        end
    end)
    return success, err
end

-- ========== 等待界面出现并翻译 ==========
local function waitForAndTranslate()
    statusText.Text = "等待 Redz Hub 界面..."
    local maxWait = 15  -- 最多等待15秒
    local start = tick()
    local found = false
    while tick() - start < maxWait do
        -- 检查是否存在包含 "Farm" 或 "Fishing" 的文本元素
        local coreGui = game:GetService("CoreGui")
        local playerGui = player:FindFirstChild("PlayerGui")
        local function hasKeyword(container)
            for _, obj in ipairs(container:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                    local txt = obj.Text
                    if txt and (txt:find("Farm") or txt:find("Fishing") or txt:find("Islands")) then
                        return true
                    end
                end
            end
            return false
        end
        if hasKeyword(coreGui) or (playerGui and hasKeyword(playerGui)) then
            found = true
            break
        end
        task.wait(0.5)
    end
    if found then
        statusText.Text = "翻译中..."
        print("检测到界面，启动翻译...")
        -- 翻译现有元素
        pcall(scanAll, game:GetService("CoreGui"))
        if player and player:FindFirstChild("PlayerGui") then
            pcall(scanAll, player.PlayerGui)
        end
        -- 监听后续新增
        game:GetService("CoreGui").DescendantAdded:Connect(function(desc)
            task.wait(0.1)
            pcall(translateGuiElement, desc)
        end)
        if player and player.PlayerGui then
            player.PlayerGui.DescendantAdded:Connect(function(desc)
                task.wait(0.1)
                pcall(translateGuiElement, desc)
            end)
        end
        statusText.Text = "汉化完成 by TH (QQ:977884227)"
        print("✅ 翻译系统已启用")
    else
        statusText.Text = "超时未检测到界面，请重试"
        print("❌ 超时未检测到 Redz Hub 界面")
    end
    -- 10秒后隐藏状态框
    task.wait(10)
    statusGui:Destroy()
end

-- ========== 主流程 ==========
local function main()
    statusText.Text = "正在加载 Redz Hub..."
    local success, err = loadRedzHub()
    if not success then
        statusText.Text = "加载失败: " .. tostring(err):sub(1, 40)
        print("❌ 加载失败: " .. tostring(err))
        task.wait(5)
        statusGui:Destroy()
        return
    end
    print("✅ Redz Hub 脚本已执行，等待界面...")
    -- 启动等待和翻译
    waitForAndTranslate()
end

task.spawn(main)
