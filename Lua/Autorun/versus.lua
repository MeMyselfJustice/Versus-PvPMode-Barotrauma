if CLIENT then return end 

modPath = ...
require("serverFunctions")
require("monsters")

Game.ServerSettings.AllowRespawn = false

Networking.Receive("noClient", function(message, client)
    local errorPlayerMsg = "No player was chosen. Pick a player to control Reaper or click Random buttom next to players' list"
    local chatMessage = ChatMessage.Create("Server", errorPlayerMsg, ChatMessageType.MessageBox, nil, nil)
    chatMessage.Color = Color(255, 255, 255, 255)
    Game.SendDirectChatMessage(chatMessage, client)
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
    local mon, pla = msgReceived:match("(%S+)%s+(%S+)")

    -- print(tostring(Game.GameSession.GameMode))
    spawnMonster{monsterName = mon, cl = CharacterToClient(FindValidCharacter(pla))}
    -- if boost == "Selected" then 
    --     incLevel()
    --     giveExp()
    -- end
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
