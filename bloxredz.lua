-- 最终版：外部脚本加载 + 翻译系统（无加载画面/音乐）
print("🎮 启动 Redz Hub + 翻译系统...")

-- ========== 翻译表（只展示开头，实际用你的完整表格） ==========
local Translations = {
    ["redz hub : Blox Fruits by real_redz"] = "Redz中心 : 果实风暴 by real_redz",
    ["Farm"] = "刷怪",
    ["Main Farm"] = "主刷怪",
    -- ... 你的其余翻译条目 ...
}

-- ========== 翻译系统 ==========
local translationCache = {}
local processedElements = {}

local function translateText(text)
    if type(text) ~= "string" or text == "" then return text end
    if translationCache[text] then return translationCache[text] end
    local translated = Translations[text] or text
    translationCache[text] = translated
    return translated
end

local function safeTranslateGuiElement(gui)
    if not gui or not gui.Parent or processedElements[gui] then return end
    local isTextElement = gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")
    if not isTextElement then return end
    local text = gui.Text
    if text == "" then processedElements[gui] = true; return end
    local translated = translateText(text)
    if translated ~= text then
        pcall(function() gui.Text = translated end)
        print("[翻译] " .. text .. " -> " .. translated)  -- 调试用，可删除
    end
    processedElements[gui] = true
end

local function scanGui(container)
    for _, child in ipairs(container:GetChildren()) do
        pcall(safeTranslateGuiElement, child)
        scanGui(child)
    end
end

local function startTranslation()
    pcall(scanGui, game:GetService("CoreGui"))
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(scanGui, player.PlayerGui)
    end
    
    local function onDescendantAdded(descendant)
        task.wait(0.1)
        pcall(safeTranslateGuiElement, descendant)
    end
    game:GetService("CoreGui").DescendantAdded:Connect(onDescendantAdded)
    if player and player.PlayerGui then
        player.PlayerGui.DescendantAdded:Connect(onDescendantAdded)
    end
    print("✅ 翻译系统已启动")
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
    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- 状态提示 UI
    local statusGui = Instance.new("ScreenGui")
    statusGui.Name = "StatusUI"
    statusGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(0.5, -150, 0.5, -40)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = statusGui
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextScaled = true
    text.Font = Enum.Font.GothamBold
    text.Text = "正在加载 Redz Hub..."
    text.Parent = frame
    
    -- 1. 加载外部脚本
    local success, err = loadExternalScript()
    if not success then
        text.Text = "❌ 加载失败: " .. tostring(err)
        print("❌ 外部脚本加载失败: " .. tostring(err))
        task.wait(5)
        statusGui:Destroy()
        return
    end
    
    text.Text = "✅ 脚本已加载，等待界面出现..."
    print("✅ 外部脚本加载成功，等待 GUI 初始化...")
    
    -- 2. 智能等待：扫描界面文字是否存在（最多等待 20 秒）
    local guiReady = false
    local keywords = {"Farm", "Main Farm", "redz hub", "Discord"}  -- Redz Hub 界面会出现的文字
    for i = 1, 20 do
        task.wait(0.5)  -- 每 0.5 秒检测一次，提高响应速度
        
        -- 扫描 CoreGui 和 PlayerGui 中所有 TextLabel/TextButton 的文本
        local function containsKeyword(container)
            for _, obj in ipairs(container:GetChildren()) do
                if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                    local txt = obj.Text
                    if txt and txt ~= "" then
                        for _, kw in ipairs(keywords) do
                            if txt:find(kw, 1, true) then  -- 简单文本包含检测
                                return true
                            end
                        end
                    end
                end
                if #obj:GetChildren() > 0 and containsKeyword(obj) then
                    return true
                end
            end
            return false
        end
        
        local coreGui = game:GetService("CoreGui")
        local playerGui = player:FindFirstChild("PlayerGui")
        if containsKeyword(coreGui) or (playerGui and containsKeyword(playerGui)) then
            guiReady = true
            print("✅ 检测到 Redz Hub 界面文字，启动翻译...")
            break
        end
        
        if i % 4 == 0 then  -- 每 2 秒输出一次
            print("⏳ 等待界面文字出现... (" .. i*0.5 .. "/20 秒)")
        end
    end
    
    if not guiReady then
        print("⚠️ 超时未检测到界面文字，仍尝试启动翻译（可能文字未被扫描到）")
    end
    
    -- 3. 启动翻译系统
    startTranslation()
    text.Text = "✅ Redz Hub 已加载，翻译已启用"
    print("🎉 翻译系统已启用，界面文本将自动翻译")
    
    -- 4. 5 秒后关闭状态提示
    task.wait(5)
    statusGui:Destroy()
end

task.spawn(main)
print("脚本已启动，请耐心等待 Redz Hub 界面...")
