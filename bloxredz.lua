-- 最小化测试：只加载外部脚本，无加载画面、无音乐、无翻译
print("🔧 最小化测试启动...")

-- 创建简单提示UI
local function createSimpleStatus()
    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TestStatus"
    screenGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0.5, -150, 0.5, -50)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextScaled = true
    text.Font = Enum.Font.GothamBold
    text.Text = "正在加载外部脚本..."
    text.Parent = frame
    
    return screenGui, text
end

-- 加载外部脚本
local function loadExternalScript()
    local Settings = {}  -- 空配置
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

-- 主流程
task.spawn(function()
    local statusGui, statusText = createSimpleStatus()
    
    local success, err = loadExternalScript()
    
    if success then
        statusText.Text = "✅ 外部脚本加载成功！"
        print("✅ 外部脚本加载成功")
    else
        statusText.Text = "❌ 加载失败: " .. tostring(err)
        print("❌ 加载失败: " .. tostring(err))
    end
    
    -- 5秒后自动关闭提示
    task.wait(5)
    statusGui:Destroy()
end)

print("最小化测试已启动，请观察界面提示。")
