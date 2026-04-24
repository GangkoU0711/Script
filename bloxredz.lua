-- 最终可靠版：固定延迟 + 强力翻译
print("🎮 启动 Redz Hub + 翻译系统...")

-- ========== 翻译表（只展示关键部分，你自行补全完整表格） ==========
local Translations = {
    ["redz hub : Blox Fruits by real_redz"] = "Redz中心 : 果实风暴 by real_redz",
    ["Discord"] = "Discord",
    ["REDZ"] = "REDZ",
    ["Farm"] = "刷怪",
    ["Fishing"] = "钓鱼",
    ["Islands"] = "岛屿",
    ["Quest/Items"] = "任务/物品",
    ["Teleport"] = "传送",
    ["Status"] = "状态",
    ["Visual"] = "视觉",
    ["Shop"] = "商店",
    ["Misc"] = "杂项",
    ["Menu"] = "菜单",
    ["任务"] = "任务",
    ["击败8危险的囚犯（1/8）"] = "击败8名危险的囚犯（1/8）",
    ["奖励："] = "奖励：",
    ["Go to Server"] = "前往服务器",
    ["$7,500"] = "$7,500",
    ["780,000经验值"] = "780,000经验值",
    -- 你原有的所有翻译项请保留...
}

-- ========== 翻译系统 ==========
local translationCache = {}
local processedElements = {}

local function translateText(text)
    if type(text) ~= "string" or text == "" then return text end
    if translationCache[text] then return translationCache[text] end
    local translated = Translations[text] or text
    if translated ~= text then
        print("[翻译] 原文: '" .. text .. "' -> 译文: '" .. translated .. "'")
    end
    translationCache[text] = translated
    return translated
end

local function safeTranslateGuiElement(gui)
    if not gui or not gui.Parent or processedElements[gui] then return end
    if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox") then
        local text = gui.Text
        if text ~= "" then
            local translated = translateText(text)
            if translated ~= text then
                pcall(function() gui.Text = translated end)
            end
        end
        processedElements[gui] = true
    end
end

-- 递归扫描所有子元素
local function scanAll(container)
    for _, child in ipairs(container:GetChildren()) do
        pcall(safeTranslateGuiElement, child)
        scanAll(child)
    end
end

-- 启动翻译监听
local function startTranslation()
    -- 立即扫描整个 GUI 树
    pcall(scanAll, game:GetService("CoreGui"))
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(scanAll, player.PlayerGui)
    end
    
    -- 监听新增元素
    local function onNew(descendant)
        task.wait(0.1)
        pcall(safeTranslateGuiElement, descendant)
    end
    game:GetService("CoreGui").DescendantAdded:Connect(onNew)
    if player and player.PlayerGui then
        player.PlayerGui.DescendantAdded:Connect(onNew)
    end
    print("✅ 翻译系统已启动，将持续监听界面变化")
end

-- ========== 加载外部脚本 ==========
local function loadExternalScript()
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

-- ========== 主流程 ==========
local function main()
    -- 创建一个极简状态提示（可选）
    local player = game:GetService("Players").LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local statusGui = Instance.new("ScreenGui")
    statusGui.Name = "LoadingStatus"
    statusGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 50)
    frame.Position = UDim2.new(0.5, -130, 0.5, -25)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.6
    frame.BorderSizePixel = 0
    frame.Parent = statusGui
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = "加载中..."
    label.Parent = frame
    
    -- 1. 加载外部脚本
    label.Text = "正在加载 Redz Hub..."
    local success, err = loadExternalScript()
    if not success then
        label.Text = "加载失败: " .. tostring(err)
        print("❌ 加载失败: " .. tostring(err))
        task.wait(5)
        statusGui:Destroy()
        return
    end
    
    label.Text = "脚本已加载，等待界面..."
    print("✅ 外部脚本加载成功，等待 8 秒确保界面完全出现...")
    task.wait(8)  -- 固定等待 8 秒，足够界面完成初始化
    
    -- 2. 启动翻译
    label.Text = "正在应用翻译..."
    startTranslation()
    
    label.Text = "汉化完成 by TH (QQ:977884227)"
    print("🎉 翻译已启用，所有界面文本将自动汉化")
    
    -- 3. 5秒后自动隐藏状态提示
    task.wait(5)
    statusGui:Destroy()
end

task.spawn(main)
print("脚本已启动，请稍等...")
