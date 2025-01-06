# Versus PvP Mode for Barotrauma

One of the closest analogs of this mod is <b>Left 4 Dead's Versus</b> PvP mode.<br>

## Gamelpay

One team is Human submarine squad and second team is The Great Yibaka (ukr. Велика Їбака) class one-monster pack <b>controlled by another player</b>. There is safety in numbers, right ...<br>
Submarine Vs Big foul creature, to say shortly.

One team has to devastate another. Simple enough.

A PvP mode itself that can be started on top of another mode (sandbox/campaign).

## Mod content

### Custom creature pack

<b>Leviathan</b> - Middle-size assault Yibaka that is armed with chaingun, alien pistol and mininuke launcher. Fast and got decent amount of health.

<b>Overseer</b> - Large-size Yibaka, the Mothercreature that spawns and buffs friendly fauna. Got aility to spawn Leucocytes, Crawlers, Hammerheads and Molochs ... having enough charge of course. And an acid ejecter for easier retreat while being chased.

<b>Clownhead</b> - The silliest of horrors: a surgically improved Hammerhead with torpedo attack and many other deadly tricks.

<b>Endowrm</b> - Stronger and more clever that regular endworm - it has an improved bite attack and a special "barf" attack.

### Custom submarine pack

#### <u>Iron hope</u>
 - Overclocked  weaponry
 - E.N.D.U.R.A.T.R.O.N. - sub invincibility device
 - Sonar guided pair of railguns
 - Nuke torpedo

## Installation
- Install this mode
- Install [Lua for Barotrauma](https://steamcommunity.com/sharedfiles/filedetails/?id=2559634234&searchtext=lua)
- Host a server with <b>Server executable</b> option set to <b>Lua for Barotrauma - DedicatedServer</b>
- Press F3, and type <b>install_cl_lua</b>
- Reboot Barotrauma
- To start Gamemode host a server with <b>Server executable</b> option set to <b>Lua for Barotrauma - DedicatedServer</b>
- Choose sandbox gamemode
- When round started click big <b>Versus</b> on bottom right to start the event

## How to add any creature as a playable in Versus gamemode

1) Edit `/Lua/monsters.lua` file
```lua
monsterDict = {
    ['Leviathan'] = "Leviathan_versus",
    ['Overseer'] = "Overseer_versus",
    ...
    ['New_creature'] = "New_creature_id"
}
```
<i>New_creature</i> name will appear in "Monster choose" drop down in GUI and will spawn entity with <i>New_creature_id</i> identificator if chosen.

2) Add `/Descriptions/New_creature.txt` file with ypur creature decsription.
3) Add `/Icons/New_creature.png` icon with 300x300 resolution.
4) Edit `/Lua/Autorun/customgui.lua`<br>
<b>After</b> this block of code
```lua
LeviathanImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
LeviathanSprite = Sprite(modPath .. "/Icons/Leviathan.png")
LeviathanPic = GUI.Image(GUI.RectTransform(Point(300, 300), LeviathanImageFrame.RectTransform, GUI.Anchor.Center), LeviathanSprite)
LeviathanPic.RectTransform.AbsoluteOffset = Point(10, 15)
LeviathanDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), LeviathanImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("Leviathan"), nil, nil, GUI.Alignment.Center)
LeviathanDesc.RectTransform.AbsoluteOffset = Point(340, 0)
```
add custom block of your creature
```lua
New_creatureImageFrame = GUI.Frame(GUI.RectTransform(Point(300, 300), menuList.Content.RectTransform), nil)
New_creatureSprite = Sprite(modPath .. "/Icons/New_creature.png")
New_creaturePic = GUI.Image(GUI.RectTransform(Point(300, 300), New_creatureImageFrame.RectTransform, GUI.Anchor.Center), New_creatureSprite)
New_creaturePic.RectTransform.AbsoluteOffset = Point(10, 15)
New_creatureDesc = GUI.TextBlock(GUI.RectTransform(Point(250, 300), New_creatureImageFrame.RectTransform, GUI.Anchor.Center), getDescMonster("New_creature"), nil, nil, GUI.Alignment.Center)
New_creatureDesc.RectTransform.AbsoluteOffset = Point(340, 0)
```
This will add description and icon to GUI when you choose monsters.

#### <i>Remember that GUI in Barotrauma is cursed so be ready for the unpredictable.</i>
