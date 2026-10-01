local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles
Library.ShowToggleFrameInKeybinds = true 
Library.ShowCustomCursor = true
Library.NotifySide = "Right"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local skinsec = "Sparkler"
local autoskin = false

local skinMap = {
    ["烟火"] = "Sparkler",
    ["虚空"] = "Void",
    ["纯金"] = "Solid Gold",
    ["暗物质"] = "Dark Matter",
    ["反物质"] = "Anti Matter",
    ["神秘"] = "Hystic",
    ["虚空神秘"] = "Void Mystic",
    ["战术"] = "Tactical",
    ["纯金战术"] = "Solid Gold Tactical",
    ["白未来"] = "Future White",
    ["黑未来"] = "Future Black",
    ["圣诞未来"] = "Christmas Future",
    ["礼物包装"] = "Gift Wrapped",
    ["猩红"] = "Crimson Blood",
    ["收割者"] = "Reaper",
    ["虚空收割者"] = "Void Reaper",
    ["圣诞玩具"] = "Christmas Toy",
    ["荒地"] = "Wasteland",
    ["隐形"] = "Invisible",
    ["像素"] = "Pixel",
    ["钻石像素"] = "Diamond Pixel",
    ["黄金零下"] = "Frozen-Gold",
    ["绿水晶"] = "Atomic Nature",
    ["生物"] = "Biohazard",
    ["樱花"] = "Sakura",
    ["精英"] = "Elite",
    ["黑樱花"] = "Death Blossom-Gold",
    ["彩虹激光"] = "Rainbowlaser",
    ["蓝水晶"] = "Atomic Water",
    ["紫水晶"] = "Atomic Amethyst",
    ["红水晶"] = "Atomic Flame",
    ["零下"] = "Sub-Zero",
    ["虚空射线"] = "Void-Ray",
    ["冰冻钻石"] = "Frozen Diamond",
    ["虚空梦魇"] = "Void Nightmare",
    ["金雪"] = "Golden Snow",
    ["爱国者"] = "Patriot",
    ["MM2"] = "MM2 Barrett",
    ["声望"] = "Prestige Barnett",
    ["酷化"] = "Skin Walter",
    ["蒸汽"] = "Steampunk",
    ["海盗"] = "Pirate",
    ["玫瑰"] = "Rose",
    ["黑玫瑰"] = "Black Rose",
    ["激光"] = "Hyperlaser",
    ["烟花"] = "Firework",
    ["诅咒背瓜"] = "Cursed Pumpkin",
    ["大炮"] = "Cannon",
    ["财富"] = "Firework",
    ["黄金大炮"] = "Gold Cannon",
    ["四叶草"] = "Lucky Clover",
    ["自由"] = "Freedom",
    ["黑曜石"] = "Obsidian",
    ["赛博朋克"] = "Cyberpunk",
}

local function applySkinToGuns()
    if not autoskin then return end
    pcall(function()
        local it = require(ReplicatedStorage.devv).load("v3item").inventory
        local b1 = require(ReplicatedStorage.devv).load('v3item').inventory.items
        for i, item in next, b1 do
            if item.type == "Gun" then
                it.skinUpdate(item.name, skinsec)
            end
        end
    end)
end

local Window = Library:CreateWindow({
	Title = ' ohio',
	Footer = "Team",
    Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = true,
	NotifySide = "Right",
	TabPadding = 8,
	MenuFadeTime = 0
})

local Tabs = {
	Main = Window:AddTab('主要','house'),
   ["UI Settings"] = Window:AddTab('UI 调试', 'settings')
}

local SkinGroup = Tabs.Main:AddLeftGroupbox("皮肤美化")
local skinNames = {}
for name, _ in pairs(skinMap) do
    table.insert(skinNames, name)
end
table.sort(skinNames)

SkinGroup:AddDropdown("SkinDropdown", {
    Values = skinNames,
    Default = "烟火",
    Text = "选择一个皮肤",
    Callback = function(Value)
        if skinMap[Value] then
            skinsec = skinMap[Value]
            if autoskin then applySkinToGuns() end
        end
    end
})

SkinGroup:AddToggle("AutoSkinToggle", {
    Default = false,
    Text = "开启美化",
    Callback = function(Value)
        autoskin = Value
        if autoskin then applySkinToGuns() end
    end
})

local BalloonGroup = Tabs.Main:AddLeftGroupbox("美化物品")
BalloonGroup:AddButton("黑玫瑰气球", function()
    pcall(function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
                v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Black Rose", 200, true, 0.75, 12, true
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0.5, 0) end
                if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 3 end
                v.canDrop, v.dropCooldown, v.craft = nil
                break
            end
        end
        for _, item in pairs(require(ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Black Rose" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
    end)
end)

BalloonGroup:AddButton("美金气球", function()
    pcall(function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
                v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Dollar Balloon", 200, true, 0.8, 8, true
                if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0) end
                if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 4 end
                v.canDrop, v.dropCooldown, v.craft = nil
                break
            end
        end
        for _, item in pairs(require(ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
            if item.name == "Dollar Balloon" then
                for _, btn in pairs({item.button, item.backpackButton}) do
                    if btn and btn.resetModelSkin then btn:resetModelSkin() end
                end
            end
        end
    end)
end)

BalloonGroup:AddButton("生成 虚空苦无", function()
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        local spiritKunaiData = {
            name = "Spirit Kunai",
            guid = "spirit_kunai_" .. tostring(tick()),
            permanent = true,
            canDrop = true,
            dropCooldown = 120,
            holdableType = "Kunai",
            movespeedAdd = 12,
            TPSOffsets = { hold = CFrame.new(0, -0.3, 0) },
            viewportOffsets = {
                hotbar = { dist = 3, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(0, 1.5707963267948966, 0) },
                ammoHUD = { dist = 2, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.3744467859455345, 0) },
                slotButton = { dist = 1, offset = CFrame.new(-0.1, -0.2, 0), rotoffset = CFrame.Angles(0, -1.5707963267948966, 0) }
            },
            FPSOffsets = {}
        }
        if inventory.add then
            inventory.add(spiritKunaiData, false)
            if inventory.currentItemsData then table.insert(inventory.currentItemsData, spiritKunaiData) end
        end
        if inventory.rerender then inventory:rerender() end
    end)
end)

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Debug")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "shortcut menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "custom cursors",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",
    Text = "informer location",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "UI Size",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddDivider()  
MenuGroup:AddLabel("Menu bind")  
    :AddKeyPicker("MenuKeybind", { 
        Default = "RightShift",  
        NoUI = true,            
        Text = "Menu keybind"    
    })

MenuGroup:AddButton("Destroy UI", function()
    Library:Unload()  
end)

ThemeManager:SetLibrary(Library)  
SaveManager:SetLibrary(Library)   
SaveManager:IgnoreThemeSettings() 

SaveManager:SetIgnoreIndexes({ "MenuKeybind" })  
ThemeManager:SetFolder("MyScriptHub")            
SaveManager:SetFolder("MyScriptHub/specific-game")  
SaveManager:SetSubFolder("specific-place")       
SaveManager:BuildConfigSection(Tabs["UI Settings"])  

ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()