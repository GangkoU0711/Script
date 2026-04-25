-- =====================
-- 最终优化版：优先 Hook，失败则降级为智能扫描
-- =====================

-- 📘 翻译表（请在此处补全所有需要翻译的英文）
local Translations = {
    -- 示例，你需要把你所有的词条填进来
    ["Farm"] = "刷级",
    ["Fishing"] = "钓鱼",
    ["Islands"] = "岛屿",
    ["Quest/Items"] = "任务/物品",
    ["Teleport"] = "传送",
    ["Status"] = "状态",
    ["Shop"] = "商店",
    ["Misc"] = "杂项",
    ["Menu"] = "菜单",
    ["Visual"] = "视觉",
    ["Stats"] = "属性",
    ["Join Server"] = "加入服务器",
    ["REDZ"] = "REDZ",
    ["Discord"] = "Discord",
    -- 继续添加...
}

-- 🔤 翻译函数（精确匹配优先，不启用模糊匹配以避免误伤）
local function translateText(text)
    if type(text) ~= "string" then return text end
    local translated = Translations[text]
    if translated then return translated end
    -- 可选：模糊匹配（如需启用请取消注释，但可能影响性能）
    -- for en, cn in pairs(Translations) do
    --     if text:find(en, 1, true) then
    --         return text:gsub(en, cn)
    --     end
    -- end
    return text
end

-- =====================
-- 方案1：Hook __newindex（无性能损耗，推荐）
-- =====================
local hookSuccess = false
local function tryHook()
    local success, err = pcall(function()
        local mt = getrawmetatable(game)
        local old__newindex = mt.__newindex
        setreadonly(mt, false)
        mt.__newindex = newcclosure(function(t, k, v)
            if k == "Text" and type(v) == "string" then
                if t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox") then
                    -- 只处理界面内的文本，避免干扰
                    if t:IsDescendantOf(game:GetService("CoreGui")) or
                       (game:GetService("Players").LocalPlayer and t:IsDescendantOf(game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"))) then
                        v = translateText(v)
                    end
                end
            end
            return old__newindex(t, k, v)
        end)
        setreadonly(mt, true)
    end)
    if success then
        print("✅ 翻译 Hook 已启用（无轮询，省电模式）")
        hookSuccess = true
    else
        warn("⚠️ Hook 失败，将启用轮询扫描: " .. tostring(err))
    end
end

-- =====================
-- 方案2：轮询扫描（仅在 Hook 失败时启动）
-- =====================
local function startPolling()
    local processed = {}  -- 记录已翻译过的对象，避免重复处理
    local function scanOnce()
        local coreGui = game:GetService("CoreGui")
        local player = game:GetService("Players").LocalPlayer
        local playerGui = player and player:FindFirstChild("PlayerGui")
        
        for _, container in ipairs({coreGui, playerGui}) do
            if container then
                for _, obj in ipairs(container:GetDescendants()) do
                    if (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) and not processed[obj] then
                        pcall(function()
                            local original = obj.Text
                            if original and original ~= "" then
                                local translated = translateText(original)
                                if translated ~= original then
                                    obj.Text = translated
                                end
                            end
                        end)
                        processed[obj] = true
                    end
                end
            end
        end
    end
    
    -- 立即扫描一次
    scanOnce()
    
    -- 监听新增元素（避免遗漏动态创建的 UI）
    local function onDescendantAdded(descendant)
        task.wait(0.1)
        if (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) and not processed[descendant] then
            pcall(function()
                local original = descendant.Text
                if original and original ~= "" then
                    local translated = translateText(original)
                    if translated ~= original then
                        descendant.Text = translated
                    end
                end
            end)
            processed[descendant] = true
        end
    end
    
    local coreGui = game:GetService("CoreGui")
    coreGui.DescendantAdded:Connect(onDescendantAdded)
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        player.PlayerGui.DescendantAdded:Connect(onDescendantAdded)
    end
    
    -- 每 5 秒全量扫描一次（处理那些绕过 Hook 的极端情况）
    task.spawn(function()
        while true do
            task.wait(5)
            scanOnce()
        end
    end)
    print("🔄 轮询扫描已启动（每 5 秒一次）")
end

-- =====================
-- 启动翻译引擎
-- =====================
tryHook()
if not hookSuccess then
    startPolling()
end

-- =====================
-- 加载外部 Redz Hub（先启动翻译，再加载）
-- =====================
task.wait(1)  -- 给 Hook 一点稳定时间

-- ✅ 替换为你提供的加载方式（不带 ", true" 参数）
local Settings = {}  -- 空配置表
local loadSuccess, loadErr = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/main.luau"))(Settings)
end)

if loadSuccess then
    print("✅ Redz Hub 加载成功，翻译实时生效")
    -- 可选：发送游戏内通知
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "汉化系统",
            Text = "已启动（省电模式）",
            Duration = 3
        })
    end)
else
    warn("❌ Redz Hub 加载失败: " .. tostring(loadErr))
end
