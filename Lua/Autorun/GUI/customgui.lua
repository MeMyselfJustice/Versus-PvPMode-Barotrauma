if SERVER then return end 

-- sleepTime(15) -- TODO try it
modPath = ...
require("clientFunctions")
require("monsters")
monster = "Leviathan" -- by default
updatePlayerList()                           -- TODO fix it to update the list

-- main frame
local frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
frame.CanBeFocused = false

-- menu frame
local menu = GUI.Frame(GUI.RectTransform(Vector2(1, 1), frame.RectTransform, GUI.Anchor.Center), nil)
menu.CanBeFocused = false
menu.Visible = false

-- invisible close button
local closeButton = GUI.Button(GUI.RectTransform(Vector2(1, 1), menu.RectTransform, GUI.Anchor.Center), "", GUI.Alignment.Center, nil)
closeButton.OnClicked = function ()
    menu.Visible = not menu.Visible
end

-- BIG Versus button at bottom right
local button = GUI.Button(GUI.RectTransform(Vector2(0.075, 0.075), frame.RectTransform, GUI.Anchor.BottomRight), "Versus", GUI.Alignment.Center, "GUIButtonLarge")
button.RectTransform.AbsoluteOffset = Point(25, 225)
button.OnClicked = function ()
    menu.Visible = not menu.Visible
end

-- main list
local menuContent = GUI.Frame(GUI.RectTransform(Point(690, 515), menu.RectTransform, GUI.Anchor.Center))
local menuList = GUI.ListBox(GUI.RectTransform(Vector2(1, 1), menuContent.RectTransform, GUI.Anchor.BottomCenter))

-- top title
GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), menuList.Content.RectTransform), "Versus menu", nil, nil, GUI.Alignment.Center)

-- Yibaka dropdown choose
local monsterDropDownFrame = GUI.Frame(GUI.RectTransform(Point(500, 30), menuList.Content.RectTransform), nil)
local monsterChoose = GUI.DropDown(GUI.RectTransform(Point(300, 23), monsterDropDownFrame.RectTransform), "Choose your Reaper", 3, nil, false)
monsterChoose.RectTransform.AbsoluteOffset = Point(10, 0)
for name, hash in pairs(monsterDict) do
    monsterChoose.AddItem(name, name)
end
monsterChoose.OnSelected = function (guiComponent, object)
    monster = object
    setFrameVisibility(object)
end

-- button that randomly chooses Yibaka
local monsterRandomButton = GUI.Button(GUI.RectTransform(Point(120, 20), monsterDropDownFrame.RectTransform, GUI.Anchor.TopRight), "Random", GUI.Alignment.Center, "GUIButtonSmall")
monsterRandomButton.RectTransform.AbsoluteOffset = Point(0, 6)
monsterRandomButton.OnClicked = function ()
    monster = monsterList[math.random(1, #monsterList)]   
end  

-- player to control Yibaka dropdown choose
local playerDropDownFrame = GUI.Frame(GUI.RectTransform(Point(500, 30), menuList.Content.RectTransform), nil)
playerChoose = GUI.DropDown(GUI.RectTransform(Point(300, 23), playerDropDownFrame.RectTransform), "Choose player", 3, nil, false)
playerChoose.RectTransform.AbsoluteOffset = Point(10, 0)
for player in playerList do
    playerChoose.AddItem(player, player)
end
playerChoose.OnSelected = function (guiComponent, object)
    cl = object
end

-- button that randomly chooses player to control Yibaka
local playerRandomButton = GUI.Button(GUI.RectTransform(Point(120, 20), playerDropDownFrame.RectTransform, GUI.Anchor.TopRight), "Random", GUI.Alignment.Center, "GUIButtonSmall")
playerRandomButton.RectTransform.AbsoluteOffset = Point(0, 6)
playerRandomButton.OnClicked = function ()
    cl = playerList[math.random(1, #playerList)]
    -- TODO add "Random" string to player choose list when clicked
end

-- -- update playerData
-- local updateButtonFrame = GUI.Frame(GUI.RectTransform(Point(45, 45), playerDropDownFrame.RectTransform, GUI.Anchor.TopCenter), nil)
-- updateButtonFrame.RectTransform.AbsoluteOffset = Point(100, -5)
-- updateSprite = Sprite(modPath .. "/images/Update.png")
-- updatePic = GUI.Image(GUI.RectTransform(Point(32, 32), updateButtonFrame.RectTransform, GUI.Anchor.Center), updateSprite)
-- local updatePlayerListButton = GUI.Button(GUI.RectTransform(Point(45, 45), updateButtonFrame.RectTransform, GUI.Anchor.TopCenter), "", GUI.Alignment.Right, nil)
-- updatePlayerListButton.OnClicked = function ()
--     updatePlayerList()
-- end

monsterList = {}
for name, _ in pairs(monsterDict) do
    table.insert(monsterList, name)
end

LeviathanImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
LeviathanSprite = Sprite(modPath .. "/images/Leviathan.png")
LeviathanPic = GUI.Image(GUI.RectTransform(Point(300, 300), LeviathanImageFrame.RectTransform, GUI.Anchor.Center), LeviathanSprite)
LeviathanPic.RectTransform.AbsoluteOffset = Point(10, 15)
LeviathanDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), LeviathanImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Leviathan"), nil, nil, GUI.Alignment.Center)
LeviathanDesc.RectTransform.AbsoluteOffset = Point(340, 0)
-- LeviathanImageFrame.Visible = not LeviathanImageFrame.Visible

CharybdisImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
CharybdisSprite = Sprite(modPath .. "/images/Charybdis.png")
CharybdisPic = GUI.Image(GUI.RectTransform(Point(300, 300), CharybdisImageFrame.RectTransform, GUI.Anchor.Center), CharybdisSprite)
CharybdisPic.RectTransform.AbsoluteOffset = Point(10, 15)
CharybdisDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), CharybdisImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Charybdis"), nil, nil, GUI.Alignment.Center)
CharybdisDesc.RectTransform.AbsoluteOffset = Point(340, 0)
CharybdisImageFrame.Visible = not CharybdisImageFrame.Visible

EndwormImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
EndwormSprite = Sprite(modPath .. "/images/lady_justice1.jpg")
EndwormPic = GUI.Image(GUI.RectTransform(Point(300, 300), EndwormImageFrame.RectTransform, GUI.Anchor.Center), EndwormSprite)
EndwormPic.RectTransform.AbsoluteOffset = Point(10, 15)
EndwormDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), EndwormImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Endworm"), nil, nil, GUI.Alignment.Center)
EndwormDesc.RectTransform.AbsoluteOffset = Point(340, 0)
EndwormImageFrame.Visible = not EndwormImageFrame.Visible

DoomImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
DoomSprite = Sprite(modPath .. "/images/lady_justice1.jpg")
DoomPic = GUI.Image(GUI.RectTransform(Point(300, 300), DoomImageFrame.RectTransform, GUI.Anchor.Center), DoomSprite)
DoomPic.RectTransform.AbsoluteOffset = Point(10, 15)
DoomDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), DoomImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Doom"), nil, nil, GUI.Alignment.Center)
DoomDesc.RectTransform.AbsoluteOffset = Point(340, 0)
DoomImageFrame.Visible = not DoomImageFrame.Visible

LatcherImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
LatcherSprite = Sprite(modPath .. "/images/lady_justice1.jpg")
LatcherPic = GUI.Image(GUI.RectTransform(Point(300, 300), LatcherImageFrame.RectTransform, GUI.Anchor.Center), LatcherSprite)
LatcherPic.RectTransform.AbsoluteOffset = Point(10, 15)
LatcherDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), LatcherImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Latcher"), nil, nil, GUI.Alignment.Center)
LatcherDesc.RectTransform.AbsoluteOffset = Point(340, 0)
LatcherImageFrame.Visible = not LatcherImageFrame.Visible

OverseerImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
OverseerSprite = Sprite(modPath .. "/images/Overseer.png")
OverseerPic = GUI.Image(GUI.RectTransform(Point(300, 300), OverseerImageFrame.RectTransform, GUI.Anchor.Center), OverseerSprite)
OverseerPic.RectTransform.AbsoluteOffset = Point(10, 15)
OverseerDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), OverseerImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Overseer"), nil, nil, GUI.Alignment.Center)
OverseerDesc.RectTransform.AbsoluteOffset = Point(340, 0)
OverseerImageFrame.Visible = not OverseerImageFrame.Visible

ClownheadImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
ClownheadSprite = Sprite(modPath .. "/images/lady_justice1.jpg")
ClownheadPic = GUI.Image(GUI.RectTransform(Point(300, 300), ClownheadImageFrame.RectTransform, GUI.Anchor.Center), ClownheadSprite)
ClownheadPic.RectTransform.AbsoluteOffset = Point(10, 15)
ClownheadDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), ClownheadImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Clownhead"), nil, nil, GUI.Alignment.Center)
ClownheadDesc.RectTransform.AbsoluteOffset = Point(340, 0)
ClownheadImageFrame.Visible = not ClownheadImageFrame.Visible

TestImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
TestSprite = Sprite(modPath .. "/images/lady_justice1.jpg")
TestPic = GUI.Image(GUI.RectTransform(Point(300, 300), TestImageFrame.RectTransform, GUI.Anchor.Center), TestSprite)
TestPic.RectTransform.AbsoluteOffset = Point(10, 15)
TestDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), TestImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Test"), nil, nil, GUI.Alignment.Center)
TestDesc.RectTransform.AbsoluteOffset = Point(340, 0)
TestImageFrame.Visible = not TestImageFrame.Visible

monsterVisibilityDict = {
    ['Leviathan'] = LeviathanImageFrame,
    ['Overseer'] = OverseerImageFrame,
    ['Clownhead'] = ClownheadImageFrame, 
    ['Doom'] = DoomImageFrame,
    ['Charybdis'] = CharybdisImageFrame,
    ['Endworm'] = EndwormImageFrame,
    ['Latcher'] = LatcherImageFrame,
    ['Test'] = TestImageFrame
}

-- TODO add increaseLevel and giveExp
-- local tickBoxFrame = GUI.Frame(GUI.RectTransform(Point(100, 30), menuList.Content.RectTransform), nil)
-- local boostTickBox = GUI.TickBox(GUI.RectTransform(Vector2(1, 0.2), tickBoxFrame.RectTransform, GUI.Anchor.BottomLeft), "Give exp to submarine crew")
-- boostTickBox.RectTransform.AbsoluteOffset = Point(14, -19)
-- boostTickBox.Selected = false
-- boostTickBox.OnSelected = function ()
-- end

local footerFrame = GUI.Frame(GUI.RectTransform(Point(620, 85), menuList.Content.RectTransform, GUI.Anchor.TopCenter), nil)
local startButtonFrame = GUI.Frame(GUI.RectTransform(Point(140, 50), footerFrame.RectTransform, GUI.Anchor.BottomRight), nil)
startButtonFrame.RectTransform.AbsoluteOffset = Point(0, 0)
local startButton = GUI.Button(GUI.RectTransform(Point(140, 20), startButtonFrame.RectTransform, GUI.Anchor.Center), "Start", GUI.Alignment.Center, "GUIButtonLarge")

startButton.OnClicked = function ()
    if cl == nil then 
        local noClient = Networking.Start("noClient")
        noClient.WriteString()
        Networking.Send(noClient)
        return nil
    end

    -- eraseListObject()

    local startVersusEvent = Networking.Start("startVersusEvent")
    startVersusEvent.WriteString(monster .. " " .. cl)
    Networking.Send(startVersusEvent)
    menu.Visible = not menu.Visible
end

Hook.Patch("Barotrauma.GameScreen", "AddToGUIUpdateList", function()
    frame.AddToGUIUpdateList()
end)