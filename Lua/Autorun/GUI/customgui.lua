if SERVER then return end 

modPath = ...
require("clientFunctions")
require("monsters")
monster = "Leviathan" -- by default
monsterList = {}
for name, _ in pairs(monsterDict) do
    table.insert(monsterList, name)
end

Networking.Receive("sendPlayerList", function(message, client)
    playerList = {}
    local msg = message.ReadString()
    
    for word in msg:gmatch("([^;]+);?") do
        table.insert(playerList, word)
    end
    -- print(playerList)
    drawGUI()
end)

function drawGUI()

-- main frame
local frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
frame.CanBeFocused = false

-- menu frame
local menu = GUI.Frame(GUI.RectTransform(Vector2(1, 1), frame.RectTransform, GUI.Anchor.Center), nil)
menu.CanBeFocused = false
menu.Visible = false

-- cheats menu frame
local CheatsMenu = GUI.Frame(GUI.RectTransform(Vector2(0.5, 0.5), frame.RectTransform, GUI.Anchor.Center), nil)
CheatsMenu.CanBeFocused = false
CheatsMenu.Visible = false

-- button opens cheats menu to confirm lvl increase and give exp to all human characters
local cheatButton = GUI.Button(GUI.RectTransform(Vector2(0.065, 0.075), frame.RectTransform, GUI.Anchor.BottomRight), "Cheats", GUI.Alignment.Center, "GUIButtonSmall")
cheatButton.RectTransform.AbsoluteOffset = Point(25, 200)
cheatButton.OnClicked = function ()
    CheatsMenu.Visible = not CheatsMenu.Visible
    menu.Visible = false
end

-- cheats list
local cheatsContent = GUI.Frame(GUI.RectTransform(Point(500, 180), CheatsMenu.RectTransform, GUI.Anchor.Center))
local cheatsList = GUI.ListBox(GUI.RectTransform(Point(500, 180), cheatsContent.RectTransform, GUI.Anchor.BottomCenter))

-- top title
local cheatsTitleText = GUI.TextBlock(GUI.RectTransform(Point(460, 35), cheatsList.Content.RectTransform), "Cheats confirmation", nil, nil, GUI.Alignment.Center)
cheatsTitleText.CanBeFocused = false

-- cheats descrition
local cheatsDesc = "By confirming Yes you will apply 100 level to every skill and\n helluva much experience (enough to cover all talents) to all humans.\n You can do it multiple times."
local cheatsDescText = GUI.TextBlock(GUI.RectTransform(Point(460, 60), cheatsList.Content.RectTransform), cheatsDesc, nil, nil, GUI.Alignment.Center)
cheatsDescText.CanBeFocused = false

-- confirmation buttons
cheatsButtonsFrame = GUI.Frame(GUI.RectTransform(Point(400, 55), cheatsList.Content.RectTransform), nil)
local cheatButtonYes = GUI.Button(GUI.RectTransform(Point(100, 15), cheatsButtonsFrame.RectTransform, GUI.Anchor.BottomLeft), "Yes", GUI.Alignment.Center, "GUIButtonLarge")
cheatButtonYes.RectTransform.AbsoluteOffset = Point(65, -5)
cheatButtonYes.OnClicked = function ()
    local incLevelEvent = Networking.Start("incLevelEvent")
    incLevelEvent.WriteString("incLevel")
    Networking.Send(incLevelEvent)
    CheatsMenu.Visible = false
end

local cheatButtonNo = GUI.Button(GUI.RectTransform(Point(100, 15), cheatsButtonsFrame.RectTransform, GUI.Anchor.BottomRight), "No", GUI.Alignment.Center, "GUIButtonLarge")
cheatButtonNo.RectTransform.AbsoluteOffset = Point(0, -5)
cheatButtonNo.OnClicked = function ()
    CheatsMenu.Visible = false
end

-- invisible close button
local closeButton = GUI.Button(GUI.RectTransform(Vector2(1, 1), menu.RectTransform, GUI.Anchor.Center), "", GUI.Alignment.Center, nil)
closeButton.OnClicked = function ()
    menu.Visible = false
    CheatsMenu.Visible = false
end

-- BIG Versus button at bottom right
local button = GUI.Button(GUI.RectTransform(Vector2(0.075, 0.075), frame.RectTransform, GUI.Anchor.BottomRight), "Versus", GUI.Alignment.Center, "GUIButtonLarge")
button.RectTransform.AbsoluteOffset = Point(25, 225)
button.OnClicked = function ()
    menu.Visible = not menu.Visible
    CheatsMenu.Visible = false
end

-- main list
local menuContent = GUI.Frame(GUI.RectTransform(Point(690, 555), menu.RectTransform, GUI.Anchor.Center))
local menuList = GUI.ListBox(GUI.RectTransform(Vector2(1, 1), menuContent.RectTransform, GUI.Anchor.BottomCenter))

-- top title
GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), menuList.Content.RectTransform), "Versus menu", nil, nil, GUI.Alignment.Center)

-- Yibaka dropdown choose
local monsterDropDownFrame = GUI.Frame(GUI.RectTransform(Point(500, 30), menuList.Content.RectTransform), nil)
local monsterChoose = GUI.DropDown(GUI.RectTransform(Point(300, 23), monsterDropDownFrame.RectTransform), "Choose monster", 3, nil, false)
monsterChoose.RectTransform.AbsoluteOffset = Point(10, 0)
for name, _ in pairs(monsterDict) do
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
end

LeviathanImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
LeviathanSprite = Sprite(modPath .. "/Icons/Leviathan.png")
LeviathanPic = GUI.Image(GUI.RectTransform(Point(300, 300), LeviathanImageFrame.RectTransform, GUI.Anchor.Center), LeviathanSprite)
LeviathanPic.RectTransform.AbsoluteOffset = Point(10, 15)
LeviathanDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), LeviathanImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Leviathan"), nil, nil, GUI.Alignment.Center)
LeviathanDesc.RectTransform.AbsoluteOffset = Point(340, 0)
-- LeviathanImageFrame.Visible = not LeviathanImageFrame.Visible

OverseerImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
OverseerSprite = Sprite(modPath .. "/Icons/Overseer.png")
OverseerPic = GUI.Image(GUI.RectTransform(Point(300, 300), OverseerImageFrame.RectTransform, GUI.Anchor.Center), OverseerSprite)
OverseerPic.RectTransform.AbsoluteOffset = Point(10, 15)
OverseerDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), OverseerImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Overseer"), nil, nil, GUI.Alignment.Center)
OverseerDesc.RectTransform.AbsoluteOffset = Point(340, 0)
OverseerImageFrame.Visible = not OverseerImageFrame.Visible

ClownheadImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
ClownheadSprite = Sprite(modPath .. "/Icons/Clownhead.png")
ClownheadPic = GUI.Image(GUI.RectTransform(Point(300, 300), ClownheadImageFrame.RectTransform, GUI.Anchor.Center), ClownheadSprite)
ClownheadPic.RectTransform.AbsoluteOffset = Point(10, 15)
ClownheadDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), ClownheadImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Clownhead"), nil, nil, GUI.Alignment.Center)
ClownheadDesc.RectTransform.AbsoluteOffset = Point(340, 0)
ClownheadImageFrame.Visible = not ClownheadImageFrame.Visible

-- MaraImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
-- MaraSprite = Sprite(modPath .. "/Icons/lady_justice1.jpg")
-- MaraPic = GUI.Image(GUI.RectTransform(Point(300, 300), MaraImageFrame.RectTransform, GUI.Anchor.Center), MaraSprite)
-- MaraPic.RectTransform.AbsoluteOffset = Point(10, 15)
-- MaraDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), MaraImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Mara"), nil, nil, GUI.Alignment.Center)
-- MaraDesc.RectTransform.AbsoluteOffset = Point(340, 0)
-- MaraImageFrame.Visible = not MaraImageFrame.Visible

EndwormImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
EndwormSprite = Sprite(modPath .. "/Icons/Endworm.png")
EndwormPic = GUI.Image(GUI.RectTransform(Point(300, 300), EndwormImageFrame.RectTransform, GUI.Anchor.Center), EndwormSprite)
EndwormPic.RectTransform.AbsoluteOffset = Point(10, 15)
EndwormDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), EndwormImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Endworm"), nil, nil, GUI.Alignment.Center)
EndwormDesc.RectTransform.AbsoluteOffset = Point(340, 0)
EndwormImageFrame.Visible = not EndwormImageFrame.Visible

DoomImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
DoomSprite = Sprite(modPath .. "/Icons/Doom.png")
DoomPic = GUI.Image(GUI.RectTransform(Point(300, 300), DoomImageFrame.RectTransform, GUI.Anchor.Center), DoomSprite)
DoomPic.RectTransform.AbsoluteOffset = Point(10, 15)
DoomDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), DoomImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Doom"), nil, nil, GUI.Alignment.Center)
DoomDesc.RectTransform.AbsoluteOffset = Point(340, 0)
DoomImageFrame.Visible = not DoomImageFrame.Visible

-- CharybdisImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
-- CharybdisSprite = Sprite(modPath .. "/Icons/Charybdis.png")
-- CharybdisPic = GUI.Image(GUI.RectTransform(Point(300, 300), CharybdisImageFrame.RectTransform, GUI.Anchor.Center), CharybdisSprite)
-- CharybdisPic.RectTransform.AbsoluteOffset = Point(10, 15)
-- CharybdisDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), CharybdisImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Charybdis"), nil, nil, GUI.Alignment.Center)
-- CharybdisDesc.RectTransform.AbsoluteOffset = Point(340, 0)
-- CharybdisImageFrame.Visible = not CharybdisImageFrame.Visible

-- LatcherImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
-- LatcherSprite = Sprite(modPath .. "/Icons/lady_justice1.jpg")
-- LatcherPic = GUI.Image(GUI.RectTransform(Point(300, 300), LatcherImageFrame.RectTransform, GUI.Anchor.Center), LatcherSprite)
-- LatcherPic.RectTransform.AbsoluteOffset = Point(10, 15)
-- LatcherDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), LatcherImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Latcher"), nil, nil, GUI.Alignment.Center)
-- LatcherDesc.RectTransform.AbsoluteOffset = Point(340, 0)
-- LatcherImageFrame.Visible = not LatcherImageFrame.Visible

-- TestImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
-- TestSprite = Sprite(modPath .. "/Icons/lady_justice1.jpg")
-- TestPic = GUI.Image(GUI.RectTransform(Point(300, 300), TestImageFrame.RectTransform, GUI.Anchor.Center), TestSprite)
-- TestPic.RectTransform.AbsoluteOffset = Point(10, 15)
-- TestDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), TestImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Test"), nil, nil, GUI.Alignment.Center)
-- TestDesc.RectTransform.AbsoluteOffset = Point(340, 0)
-- TestImageFrame.Visible = not TestImageFrame.Visible

monsterVisibilityDict = {
    ['Leviathan'] = LeviathanImageFrame,
    ['Overseer'] = OverseerImageFrame,
    ['Clownhead'] = ClownheadImageFrame, 
    ['Mara'] = MaraImageFrame,
    ['Endworm'] = EndwormImageFrame,
    ['Doom'] = DoomImageFrame,
    ['Charybdis'] = CharybdisImageFrame,
    ['Latcher'] = LatcherImageFrame,
    ['Test'] = TestImageFrame
}

local footerFrame = GUI.Frame(GUI.RectTransform(Point(620, 100), menuList.Content.RectTransform, GUI.Anchor.TopCenter), nil)
local startButtonFrame = GUI.Frame(GUI.RectTransform(Point(140, 50), footerFrame.RectTransform, GUI.Anchor.TopRight), nil)
startButtonFrame.RectTransform.AbsoluteOffset = Point(0, 0)
local startButton = GUI.Button(GUI.RectTransform(Point(140, 20), startButtonFrame.RectTransform, GUI.Anchor.Center), "Start", GUI.Alignment.Center, "GUIButtonLarge")

local tickBoxFrame = GUI.Frame(GUI.RectTransform(Point(140, 50), footerFrame.RectTransform, GUI.Anchor.TopRight), nil)
tickBoxFrame.RectTransform.AbsoluteOffset = Point(0, 50)
local tickBox = GUI.TickBox(GUI.RectTransform(Vector2(1, 0.2), tickBoxFrame.RectTransform), "Idle mode")
tickBox.Selected = false

local percentageScrollBarFrame = GUI.Frame(GUI.RectTransform(Point(200, 30), footerFrame.RectTransform, GUI.Anchor.BottomRight), nil)
percentageScrollBarFrame.RectTransform.AbsoluteOffset = Point(0, -9)
local percentageScrollBar = GUI.ScrollBar(GUI.RectTransform(Vector2(1, 0.1), percentageScrollBarFrame.RectTransform), 0.1, nil, "GUISlider")
percentageScrollBar.Range = Vector2(0, 100)
percentageScrollBar.BarScrollValue = 35
percentageScrollBarFrame.Visible = false

local textBoxFrame = GUI.Frame(GUI.RectTransform(Point(50, 30), footerFrame.RectTransform, GUI.Anchor.BottomCenter), nil)
textBoxFrame.RectTransform.AbsoluteOffset = Point(-90, -6)
local textBoxText = "With this option Yibaka will spawn with " .. tostring(math.floor(percentageScrollBar.BarScrollValue)) .. " % during\n this round since Start button is clicked."
local textBlock = GUI.TextBlock(GUI.RectTransform(Point(250, 300), textBoxFrame.RectTransform, GUI.Anchor.Center), textBoxText, nil, nil, GUI.Alignment.Center)
textBlock.TextColor = Color(55, 122, 162)
textBlock.RectTransform.AbsoluteOffset = Point(0, 0)
textBoxFrame.Visible = false

percentageScrollBar.OnMoved = function ()
    textBlock.Text = ""
    local textBoxText = "With this option Yibaka will spawn with " .. tostring(math.floor(percentageScrollBar.BarScrollValue)) .. " % during\n this round since Start button is clicked."
    textBlock.Text = textBoxText
end

tickBox.OnSelected = function ()
    if tickBox.Selected then
        percentageScrollBarFrame.Visible = true
        textBoxFrame.Visible = true
    else
        percentageScrollBarFrame.Visible = false
        textBoxFrame.Visible = false
    end
end

startButton.OnClicked = function ()
    if cl == nil then 
        local noClient = Networking.Start("noClient")
        noClient.WriteString()
        Networking.Send(noClient)
        return nil
    end

    local startVersusEvent = Networking.Start("startVersusEvent")
    startVersusEvent.WriteString(monster .. " " .. cl)
    Networking.Send(startVersusEvent)
    menu.Visible = not menu.Visible
    CheatsMenu.Visible = false
end

Hook.Patch("Barotrauma.GameScreen", "AddToGUIUpdateList", function()
    frame.AddToGUIUpdateList()
end)

Hook.Add("roundEnd", "roundEnd", function()  
    frame.Visible = false
end)
    
end
