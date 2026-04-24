-- Redz Hub ⼀键加载 + 智能等待 + 完整汉化（⽆界⾯/⾳乐）
print("🎮 启动 Redz Hub 汉化版...")

-- ========== 1. 加载外部脚本 ==========
local Settings = {}
pcall(function()
    local content = game:HttpGet("https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/main.luau", true)
    local func = loadstring(content)
    if func then func(Settings) end
end)
print("✅ 外部脚本已执⾏，等待界⾯初始化...")

-- ========== 2. 智能等待界⾯出现（最多 20 秒）==========
local maxWait = 20
local start = tick()
local guiReady = false
while tick() - start < maxWait do
    -- 检测 CoreGui 或 PlayerGui 中是否出现关键⽂本
    local coreGui = game:GetService("CoreGui")
    local player = game:GetService("Players").LocalPlayer
    local playerGui = player and player:FindFirstChild("PlayerGui")
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
        guiReady = true
        break
    end
    task.wait(0.5)
end

if not guiReady then
    print("⚠️ 超时未检测到 Redz Hub 界⾯，但将继续尝试翻译")
end

-- ========== 3. 完整翻译表（基于你之前成功的那份）==========
local Translations = {
    ["redz hub : Blox Fruits by real_redz"] = "Redz中心 : 果实风暴 by real_redz",
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
    ["Statss"] = "属性",
    ["Esp"] = "透视",
    ["Server"] = "服务器",
    ["Team"] = "队伍",
    ["Race"] = "种族",
    ["Local-Player"] = "本地玩家",
    ["Battle"] = "战斗",
    ["Select Tool"] = "选择工具",
    ["Choose the tool you want to use"] = "选择您要使用的工具",
    ["UI Scale"] = "界⾯缩放",
    ["Adjust the user interface size"] = "调整用户界⾯大小",
    ["Auto Farm Level"] = "自动刷等级",
    ["Farm Level"] = "刷等级",
    ["Auto Farm Nearest"] = "自动刷最近",
    ["Farm Nearest Mobs"] = "刷最近的怪物",
    ["Auto Chest [Tween]"] = "自动宝箱 [缓动]",
    ["Auto Chest [Bypass]"] = "自动宝箱 [绕过]",
    ["Stop When Get Item"] = "获得物品时停⽌",
    ["Kill Player"] = "击杀玩家",
    ["Auto Safe Mode"] = "自动安全模式",
    ["Auto Collect Berry"] = "自动收集浆果",
    ["Berrie"] = "浆果",
    ["Bosses"] = "⾸领",
    ["Boss List"] = "⾸领列表",
    ["Auto Kill Boss Selected"] = "自动击杀选中⾸领",
    ["Take Boss Quest"] = "接取⾸领任务",
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
    ["Teleport Frozen Dimension"] = "传送⾄冰冻维度",
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
    ["Quest Sea 1"] = "第⼀海任务",
    ["Auto Second Sea"] = "自动第⼆海",
    ["Boss Greybeard"] = "⾸领灰胡子",
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
    ["Raids only works in Sea 2 or 3"] = "突袭仅适用于第⼆海或第三海",
    ["Auto Stats"] = "自动分配属性",
    ["Select Points"] = "选择点数",
    ["Select Stats"] = "选择属性",
    ["Defense"] = "防御",
    ["Demon Fruit"] = "恶魔果实",
    ["WindMill"] = "风车",
    ["Travel"] = "旅行",
    ["Marine"] = "海军",
    ["Main"] = "主界⾯",
    ["Middle Town"] = "中镇",
    ["Dressrosa"] = "德雷斯罗萨",
    ["Pirate Village"] = "海盗村",
    ["Desert"] = "沙漠",
    ["Snow Island"] = "雪岛",
    ["MarineFord"] = "海军总部",
    ["Sky Island 1"] = "空岛1",
    ["Teleport to Sea1"] = "传送到第⼀海",
    ["Teleport to Sea2"] = "传送到第⼆海",
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
    ["Enable Roblox Emote Menu"] = "启⽤Roblox表情菜单",
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
    ["Join Server"] = "加⼊服务器",
    ["Job ID"] = "房间ID",
    ["Paste the Job ID here..."] = "在此处粘贴房间ID...",
    ["Join Clipboard"] = "加⼊剪贴板中的房间",
    ["Join server from copied Jobld"] = "从复制的房间ID加⼊服务器",
    ["Config."] = "配置",
    ["Farm Mode"] = "刷怪模式",
    ["Up"] = "上",
    ["Farm Distance"] = "刷怪距离",
    ["Bring Range"] = "牵引范围",
    ["Tween Speed"] = "缓动速度",
    ["Bring Mobs"] = "牵引怪物",
    ["Auto Haki"] = "自动霸气",
    ["Fast Attack"] = "快速攻击",
    ["Not instant kill, may cause lag"] = "并⾮秒杀，可能导致卡顿",
    ["Rejoin Server"] = "重新加⼊服务器",
    ["Anti-reset"] = "防重置",
    ["Server hop every 30 minutes"] = "每30分钟跳转服务器",
    ["Join Pirates Team"] = "加⼊海盗队伍",
    ["Join Marines Team"] = "加⼊海军队伍",
    ["Enable Speed and Jump"] = "启⽤速度和跳跃",
    ["WalkSpeed"] = "行走速度",
    ["JumpPower"] = "跳跃力量",
    ["Open Title Name"] = "展示称号名称",
    ["Codes"] = "兑换码",
    ["Redeem all codes"] = "兑换所有兑换码",
    ["Full Bright"] = "全屏亮度",
    ["Remove Sky Fog"] = "移除天空雾",
    ["Auto Remove Sky Fog"] = "自动移除天空雾",
    ["More FPS"] = "提⾼帧率",
    ["Smooth Mode"] = "平滑模式",
    ["White Screen"] = "白屏",
    ["Remove Damage"] = "移除伤害显示",
    ["Remove Notifications"] = "移除通知",
    ["FPS Boost"] = "帧率提升",
    ["Others"] = "其他",
    ["Delete Lava"] = "删除岩浆",
    ["Walk on Water"] = "水上行走",
    -- 补充你截图中出现但可能遗漏的
    ["REDZ"] = "REDZ中心",
    ["Label"] = "标签",
    ["Auto Attack"] = "自动攻击",
    ["Auto Shoot"] = "自动射击",
    ["Fruits/Raid"] = "果实/突袭",
    ["217级"] = "217级",
    ["Health105/105"] = "生命105/105",
    ["$801,271"] = "$801,271",
    ["v31.1.5-Seal:c aaalce2"] = "v31.1.5-Seal:c aaalce2"
}

-- ========== 4. 执⾏翻译 ==========
local function translateAll()
    local function scan(container)
        for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                local txt = obj.Text
                if txt and txt ~= "" then
                    local translated = Translations[txt]
                    if translated and translated ~= txt then
                        pcall(function() obj.Text = translated end)
                    end
                end
            end
        end
    end
    pcall(scan, game:GetService("CoreGui"))
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        pcall(scan, player.PlayerGui)
    end
end

translateAll()
print("🎉 汉化完成！如有个别英⽂未翻译，请告诉我单词，我会补充到翻译表中。")
