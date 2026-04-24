-- 最终版：外部脚本加载 + 翻译系统（无加载画面/音乐）
print("🎮 启动 Redz Hub + 翻译系统...")

-- ========== 翻译表（这里只保留关键部分，实际使用你的完整表格） ==========
local Translations = {
    -- 标题/作者
    ["redz hub : Blox Fruits by real_redz"] = "Redz中心 : 果实风暴 by real_redz",

    -- 主导航
    ["Discord"] = "Discord",
    ["Farm"] = "刷怪",
    ["Fishing"] = "钓鱼",
    ["Main Farm"] = "主刷怪",
    ["Islands"] = "岛屿",
    ["Quest/Items"] = "任务/物品",
    ["Chest"] = "宝箱",
    ["Teleport"] = "传送",
    ["Status"] = "状态",
    ["Shop"] = "商店",
    ["Misc"] = "杂项",
    ["Menu"] = "菜单",
    ["Visual"] = "视觉",
    ["战斗"] = "战斗",      -- 原图中已出现中文，保留映射
    ["Stats"] = "属性",
    ["Statss"] = "属性",    -- 拼写错误版本
    ["Esp"] = "透视",
    ["Server"] = "服务器",
    ["Team"] = "队伍",
    ["Race"] = "种族",
    ["Local-Player"] = "本地玩家",
    ["Battle"] = "战斗",

    -- 通用控件
    ["Select Tool"] = "选择工具",
    ["Choose the tool you want to use"] = "选择您要使用的工具",
    ["UI Scale"] = "界面缩放",
    ["Adjust the user interface size"] = "调整用户界面大小",
    ["Auto Farm Level"] = "自动刷等级",
    ["Farm Level"] = "刷等级",
    ["Auto Farm Nearest"] = "自动刷最近",
    ["Farm Nearest Mobs"] = "刷最近的怪物",
    ["Auto Chest [Tween]"] = "自动宝箱 [缓动]",
    ["Auto Chest [Bypass]"] = "自动宝箱 [绕过]",
    ["Stop When Get Item"] = "获得物品时停止",
    ["Kill Player"] = "击杀玩家",
    ["Auto Safe Mode"] = "自动安全模式",
    ["Auto Collect Berry"] = "自动收集浆果",
    ["Berrie"] = "浆果",
    ["Bosses"] = "首领",
    ["Boss List"] = "首领列表",
    ["Auto Kill Boss Selected"] = "自动击杀选中首领",
    ["Take Boss Quest"] = "接取首领任务",
    ["Material"] = "材料",
    ["Material List"] = "材料列表",
    ["Magma Ore"] = "岩浆矿石",
    ["Auto Farm Material"] = "自动刷材料",
    ["Melee"] = "近战",
    ["Sword"] = "剑",
    ["Gun"] = "枪",
    ["Blox Fruit"] = "果实",
    ["Auto Fish"] = "自动钓鱼",
    ["Auto use skill of the rod"] = "自动使用鱼竿技能",
    ["Save Fish Position"] = "保存钓鱼位置",
    ["Bait"] = "鱼饵",
    ["Select Bait"] = "选择鱼饵",
    ["Max Baits"] = "最大鱼饵数",
    ["Auto Buy Baits"] = "自动购买鱼饵",
    ["Buy Bait"] = "购买鱼饵",
    ["Quest"] = "任务",
    ["Skip Quests"] = "跳过任务",
    ["Auto Quest [Skip Get, Complete]"] = "自动任务 [跳过接受/完成]",
    ["RedZ"] = "RedZ",
    ["Good Bait"] = "优质鱼饵",
    ["Abyssal Bait"] = "深渊鱼饵",
    ["Frozen Bait"] = "冰冻鱼饵",
    ["Epic Bait"] = "史诗鱼饵",
    ["Carnivore Bait"] = "肉食鱼饵",
    ["All Fish"] = "所有鱼类",
    ["Take Quest Only When Fishing"] = "仅在钓鱼时接取任务",
    ["Rare"] = "稀有",
    ["Legendary"] = "传说",
    ["Select Fish Kind"] = "选择鱼类种类",
    ["Instant Catch"] = "即时上钩",
    ["Leviathan [ BETA ]"] = "利维坦 [测试版]",
    ["Buy Spy"] = "购买侦察",
    ["Auto Attack Leviathan"] = "自动攻击利维坦",
    ["Teleport Frozen Dimension"] = "传送至冰冻维度",
    ["Prehistoric Island"] = "史前岛屿",
    ["Auto Dragon Hunter Quests"] = "自动龙猎人任务",
    ["turn on for farm blaze ember + auto collect blaze ember"] = "开启以刷取烈焰余烬 + 自动收集烈焰余烬",
    ["Craft Volcanic Magnet"] = "制作火山磁铁",
    ["Auto Find Prehistoric"] = "自动寻找史前岛屿",
    ["Islands Stats"] = "岛屿状态",
    ["Mirage Island : not Spawn"] = "幻影岛 : 未生成",
    ["Kitsune Island : not Spawn"] = "狐妖岛 : 未生成",
    ["Prehistoric Island : not Spawn"] = "史前岛屿 : 未生成",
    ["Auto Tween Prehistoric Island"] = "自动缓动前往史前岛屿",
    ["Auto Prehistoric"] = "自动史前岛屿",
    ["Auto Use Melee"] = "自动使用近战",
    ["Auto Use Sword"] = "自动使用剑",
    ["Auto Use Gun"] = "自动使用枪",
    ["Auto Kill Golem"] = "自动击杀傀儡",
    ["Auto Kill Aura Golem"] = "自动击杀光环傀儡",
    ["Auto Collect Bone"] = "自动收集骨头",
    ["Auto Collect Egg"] = "自动收集蛋",
    ["Kitsune Island"] = "狐妖岛",
    ["Defeat 8 Prisoners"] = "击败8名囚犯",
    ["Quest Sea 1"] = "第一海任务",
    ["Auto Second Sea"] = "自动第二海",
    ["Boss Greybeard"] = "首领灰胡子",
    ["Kill Greybeard"] = "击杀灰胡子",
    ["Quest Sword"] = "任务剑",
    ["Auto Get Saber"] = "自动获取佩剑",
    ["Auto Get Sword Pole"] = "自动获取长矛剑",
    ["Auto Get Sword Saw"] = "自动获取锯剑",
    ["Auto Get Sword Warden"] = "自动获取典狱长剑",
    ["Auto Kill Chief Warden"] = "自动击杀典狱长",
    ["Auto Get Sword Trident"] = "自动获取三叉戟剑",
    ["Fruits"] = "果实",
    ["Auto Random Fruits"] = "自动随机果实",
    ["Auto Store Fruits"] = "自动存储果实",
    ["Auto Teleport Fruits"] = "自动传送果实",
    ["Check Stock Fruits"] = "检查果实库存",
    ["Stock"] = "库存",
    ["Raid"] = "突袭",
    ["Raids only works in Sea 2 or 3"] = "突袭仅适用于第二海或第三海",
    ["Auto Stats"] = "自动分配属性",
    ["Select Points"] = "选择点数",
    ["Select Stats"] = "选择属性",
    ["Defense"] = "防御",
    ["Demon Fruit"] = "恶魔果实",
    ["WindMill"] = "风车",
    ["Travel"] = "旅行",
    ["Marine"] = "海军",
    ["Main"] = "主界面",
    ["Middle Town"] = "中镇",
    ["Dressrosa"] = "德雷斯罗萨",
    ["Pirate Village"] = "海盗村",
    ["Desert"] = "沙漠",
    ["Snow Island"] = "雪岛",
    ["MarineFord"] = "海军总部",
    ["Sky Island 1"] = "空岛1",
    ["Teleport to Sea1"] = "传送到第一海",
    ["Teleport to Sea2"] = "传送到第二海",
    ["Teleport to Sea3"] = "传送到第三海",
    ["Select Island"] = "选择岛屿",
    ["Teleport To Island"] = "传送到岛屿",
    ["Aimbot Nearest"] = "自瞄最近",
    ["Aimbot Gun"] = "自瞄枪械",
    ["Aimbot Tap"] = "自瞄点击",
    ["Aimbot Skills"] = "自瞄技能",
    ["Ignore Mobs"] = "忽略小怪",
    ["ESP Players"] = "透视玩家",
    ["ESP Chest"] = "透视宝箱",
    ["ESP Fruits"] = "透视果实",
    ["Esp Berry"] = "透视浆果",
    ["Meteor Rain"] = "流星雨",
    ["Remove Portal Dash Cooldown"] = "移除传送冲刺冷却",
    ["Enable Roblox Emote Menu"] = "启用Roblox表情菜单",
    ["Rain Fruit (Old)"] = "雨果（旧版）",
    ["Kamui"] = "神威",
    ["Fighting Style"] = "战斗风格",
    ["Buy Black Leg"] = "购买黑足",
    ["Exp.(+Melee)"] = "经验（+近战）",
    ["Buy Fishman Karate"] = "购买鱼人空手道",
    ["Buy Superhuman"] = "购买超人",
    ["Buy Death Step"] = "购买死亡之步",
    ["Buy Sharkman Karate"] = "购买鲨鱼空手道",
    ["Buy Electric Claw"] = "购买电爪",
    ["Buy Dragon Talon"] = "购买龙爪",
    ["Buy God Human"] = "购买神人",
    ["Buy Sanguine Art"] = "购买血艺",
    ["Buy Sea Event Crafting"] = "购买海洋事件制作",
    ["Craft Dragonheart"] = "制作龙心",
    ["Craft Dragonstorm"] = "制作龙风暴",
    ["Craft DinoHood"] = "制作恐龙兜帽",
    ["Craft SharkTooth"] = "制作鲨鱼牙",
    ["Craft TerrorJaw"] = "制作恐怖颚",
    ["Craft SharkAnchor"] = "制作鲨鱼锚",
    ["Craft LeviathanCrown"] = "制作利维坦王冠",
    ["Craft LeviathanShield"] = "制作利维坦盾牌",
    ["Craft LeviathanBoat"] = "制作利维坦船",
    ["Craft LegendaryScroll"] = "制作传说卷轴",
    ["Craft MythicalScroll"] = "制作神话卷轴",
    ["Buy Haki,Soru..."] = "购买霸气/剃...",
    ["Buy Geppo"] = "购买月步",
    ["Buy Buso Haki"] = "购买武装色霸气",
    ["Buy Soru"] = "购买剃",
    ["Buy Sword,Gun"] = "购买剑/枪",
    ["Buy Cutlass"] = "购买弯刀",
    ["Buy Katana"] = "购买武士刀",
    ["Buy Iron Mace"] = "购买铁锤",
    ["Buy Dual Katana"] = "购买双武士刀",
    ["Buy Triple Katana"] = "购买三武士刀",
    ["Buy Pipe"] = "购买水管",
    ["Buy Dual-Headed Blade"] = "购买双头刃",
    ["Buy Bisenito"] = "购买比塞尼托",
    ["Buy Soul Cane"] = "购买灵魂手杖",
    ["Buy Pole V2"] = "购买长棍V2",
    ["Buy Slingshot"] = "购买弹弓",
    ["Buy Musket"] = "购买火枪",
    ["Buy Flintlock"] = "购买燧发枪",
    ["Refined Slingshot"] = "精制弹弓",
    ["Buy Refined Flintlock"] = "购买精制燧发枪",
    ["Buy Cannon"] = "购买加农炮",
    ["Buy Kabucha"] = "购买甲虫弓",
    ["Buy Bizarre Rifle"] = "购买怪异步枪",
    ["Buy Black Cape"] = "购买黑色披风",
    ["Swordsman Hat"] = "剑士帽",
    ["Buy Tomoe Ring"] = "购买巴纹戒指",
    ["Reset Stats, Random Race"] = "重置属性，随机种族",
    ["buy Ghoul"] = "购买食尸鬼",
    ["buy Cyborg"] = "购买半机械人",
    ["Reset Stats"] = "重置属性",
    ["Random Race"] = "随机种族",
    ["Join Server"] = "加入服务器",
    ["Job ID"] = "房间ID",
    ["Paste the Job ID here..."] = "在此处粘贴房间ID...",
    ["Join Clipboard"] = "加入剪贴板中的房间",
    ["Join server from copied Jobld"] = "从复制的房间ID加入服务器",
    ["Config."] = "配置",
    ["Farm Mode"] = "刷怪模式",
    ["Up"] = "上",
    ["Farm Distance"] = "刷怪距离",
    ["Bring Range"] = "牵引范围",
    ["Tween Speed"] = "缓动速度",
    ["Bring Mobs"] = "牵引怪物",
    ["Auto Haki"] = "自动霸气",
    ["Fast Attack"] = "快速攻击",
    ["Not instant kill, may cause lag"] = "并非秒杀，可能导致卡顿",
    ["Rejoin Server"] = "重新加入服务器",
    ["Anti-reset"] = "防重置",
    ["Server hop every 30 minutes"] = "每30分钟跳转服务器",
    ["Join Pirates Team"] = "加入海盗队伍",
    ["Join Marines Team"] = "加入海军队伍",
    ["Enable Speed and Jump"] = "启用速度和跳跃",
    ["WalkSpeed"] = "行走速度",
    ["JumpPower"] = "跳跃力量",
    ["Open Title Name"] = "展示称号名称",
    ["Codes"] = "兑换码",
    ["Redeem all codes"] = "兑换所有兑换码",
    ["Full Bright"] = "全屏亮度",
    ["Remove Sky Fog"] = "移除天空雾",
    ["Auto Remove Sky Fog"] = "自动移除天空雾",
    ["More FPS"] = "提高帧率",
    ["Smooth Mode"] = "平滑模式",
    ["White Screen"] = "白屏",
    ["Remove Damage"] = "移除伤害显示",
    ["Remove Notifications"] = "移除通知",
    ["FPS Boost"] = "帧率提升",
    ["Others"] = "其他",
    ["Delete Lava"] = "删除岩浆",
    ["Walk on Water"] = "水上行走"
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
    end
    processedElements[gui] = true
end

-- 启动翻译监听（持续扫描新增元素）
local function startTranslation()
    -- 扫描已存在的 GUI
    local function scanGui(container)
        for _, child in ipairs(container:GetChildren()) do
            pcall(safeTranslateGuiElement, child)
            scanGui(child)
        end
    end
    pcall(scanGui, game:GetService("CoreGui"))
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(scanGui, player.PlayerGui)
    end
    
    -- 监听新增元素
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
    local Settings = {}  -- 空配置，可按需修改
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
    -- 创建简单状态提示
    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
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
    
    -- 加载外部脚本
    local success, err = loadExternalScript()
    if success then
        text.Text = "✅ 加载成功！正在启动翻译..."
        print("✅ 外部脚本加载成功")
        -- 等待 GUI 完全创建（可根据实际情况调整）
        task.wait(3)
        startTranslation()
        text.Text = "✅ Redz Hub 已加载，翻译已启用"
        task.wait(3)
        statusGui:Destroy()
    else
        text.Text = "❌ 加载失败: " .. tostring(err)
        print("❌ 外部脚本加载失败: " .. tostring(err))
        task.wait(5)
        statusGui:Destroy()
    end
end

task.spawn(main)
print("脚本已启动，请等待...")
