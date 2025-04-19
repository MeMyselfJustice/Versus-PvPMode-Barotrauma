if CLIENT then return end 

modPath = ...
require("serverFunctions")
require("monsters")
-- Game.OverrideRespawnSub(true)
local timer = 50
local spawnInterval = 60 -- Interval (in seconds) to check for spawning

Hook.Add("roundStart", "roundStart", function()  
    playerString = table.concat(updatePlayerList(), ";")
    local sendPlayerList = Networking.Start("sendPlayerList")
    sendPlayerList.WriteString(playerString)
    Networking.Send(sendPlayerList)
end)

Networking.Receive("noClient", function(message, client)
    local errorPlayerMsg = "No player was chosen. Pick a player to control Yibaka or click Random buttom next to players' list"
    local chatMessage = ChatMessage.Create("Server", errorPlayerMsg, ChatMessageType.MessageBox, nil, nil)
    chatMessage.Color = Color(255, 255, 255, 255)
    Game.SendDirectChatMessage(chatMessage, client)
end)

Networking.Receive("incLevelEvent", function(message, client)
    if client == Client.ClientList[1] then
        local msgReceived = message.ReadString()
        if msgReceived == "incLevel" then
            incLevel()
            giveExp()
        end
    end
end)

Networking.Receive("startVersusEvent", function(message, client)
    if client ~= Client.ClientList[1] then
        local errorClientMsg = "Only host is permitted to start Versus event"
        local chatMessage = ChatMessage.Create("Server", errorClientMsg, ChatMessageType.MessageBox, nil, nil)
        chatMessage.Color = Color(255, 255, 255, 255)
        Game.SendDirectChatMessage(chatMessage, client)
        return nil
    end

    local msgReceived = message.ReadString()
    local mon, pla, prob = msgReceived:match("(%S+)%s+(%S+)%s+(%S+)")
    local startMsg = "You feel something's lurking nearby."
    Game.SendMessage(startMsg, 11)

    Hook.Add("think", "SpawnYibakaBackground", function()
        timer = timer + 1 / 60 -- Increment timer (assuming 60 fps)
        if timer >= spawnInterval then
            timer = 0
            local testTick = math.floor(math.random() * 100)
            print("testTick: " .. testTick .. " vs chance: " .. prob)
            if testTick <= tonumber(prob) then
                spawnMonster{monsterName = FindValidMonster(mon), cl = CharacterToClient(FindValidCharacter(pla))}
                Hook.Remove("think", "SpawnYibakaBackground")
                timer = 50
            end
        end
    end)
end)

Hook.Add("roundEnd", "roundEnd", function()  
    Hook.Remove("think", "SpawnYibakaBackground")
end)

--[[
    depricated since v2.0
--]]

-- Game.AddCommand("setMonster")

-- Game.AssignOnClientRequestExecute("setMonster", function(client, mousePos, arg)

--     if client.Character ~= hostClient then
--         local errorHost = "[ERROR]: setMonster command: only host is allowed to spawn The Great Yibaka"
--         Game.SendMessage(errorHost, 6)
--     end
    
--     if #arg ~= 2 then
--         local errorArg = "[ERROR]: setMonster command:  need 2 args:\n - [ string ] monster name\n - [ string ] character name to control it"
--         Game.SendMessage(errorArg, 6)
--         return nil
--     end

--     local monster = FindValidMonster(arg[1])
--     if monster == nil then 
--         local errorMonster = "[ERROR]: setMonster command: incorrect monster name"
--         Game.SendMessage(errorMonster, 6)
--         return nil
--     end

--     local client = Util.FindClientCharacter(FindValidCharacter(arg[2]))
--     if client == nil then 
--         local errorChar = "[ERROR]: setMonster command: player not found"
--         Game.SendMessage(errorChar, 6)
--         return nil
--     end

--     -- local ifEnd = arg[3]

--     -- if ifEnd then
--     --     Hook.Add("character.death", "monsterDeath", function(character)    -- TODO optional EndGame
--     --         if character == monster then 
--     --             Game.SendMessage(character .. " " .. "died", 0)
--     --             Game.EndGame()
--     --         end
--     --     end)
--     -- end

--     spawnMonster{monsterName = monster, cl = client}

-- end)
