playerList = {}
monsterDict = {
    ['Leviathan'] = "Leviathan",
    ['Charybdis'] = "Charybdis",
    ['Endworm'] = "Endworm",
    ['Doom'] = "Psilotoad",                           -- це якийсь жарт?
    ['Latcher'] = "Latcher",
    ['Overseer'] = "Overseer"
}

for key,client in pairs(Client.ClientList) do
    -- print("Client: ", key, " | Character: ", client.Character.DisplayName)
    if key == 1 then
        hostClient = client.Character
    end
end

function updatePlayerList()
    playerList = {}
    for player in Character.CharacterList do 
        print(player)
        if player.isHuman and not player.IsBot then
            playerInfo = { player, player.DisplayName, player.ID, player.TeamID }
            table.insert(playerList, playerInfo)
        end
    end
    printPlayers()
    return playerList
end

function printPlayers()
    for player in playerList do
        print("==========================")
        print("Player Character: ", player[1])
        print("Player Name: ", player[2])
        print("Player ID: ", player[3])
        print("Player TeamID: ", player[4])
        print("==========================")
    end
end

function FindValidCharacter(targetname)
    for _, entity in pairs(Character.CharacterList) do
        local nameMatch = string.find(entity.DisplayName, targetname)
        if nameMatch and entity.IsHuman then
            return entity
        end
    end
    local errorMsg = "[ERROR]: No clients with name " .. targetname .. " found"
    Game.SendMessage(errorMsg, 6)
    return nil
end

function FindValidMonster(targetname)
    for name, entity in pairs(monsterDict) do
        local nameMatch = string.find(name, targetname)
        if nameMatch then
            return entity
        end
    end
    local errorMsg = "[ERROR]: No monsters with name " .. targetname .. " found"
    Game.SendMessage(errorMsg, 6)
    return nil
end

function spawnMonster(arg)
    local waypoints = Submarine.MainSub.GetWaypoints(true)
    local spawnPositions = {}

    for key, value in pairs(waypoints) do
        local diversityX = math.random(5000, 8000)
        local diversityY = math.random(-4500, -2500)
        vectorAdj = Vector2(diversityX, diversityY)
        if value.CurrentHull == nil then
            local walls = Level.Loaded.GetTooCloseCells(Vector2.Add(value.WorldPosition, vectorAdj), 250)
            if #walls == 0 then
                table.insert(spawnPositions, Vector2.Add(value.WorldPosition, vectorAdj))
            end
        end
    end

    local spawnPosition = spawnPositions[math.random(#spawnPositions)]

    Entity.Spawner.AddCharacterToSpawnQueue(arg.monsterName, spawnPosition, function (monster)
        local text = "The hunt's begun ... but who is the prey?"
        if arg.monsterName == "Psilotoad" then
            text = "RUN, FOOLS!!!"
        end
        Game.SendMessage(text, 11)
        arg.cl.SetClientCharacter(monster)
    end)
end

function CharacterToClient(character)
    if not SERVER then return nil end
    for key,client in pairs(Client.ClientList) do
        if client.Character == character then 
            return client
        end
    end
    return nil
end

Game.AddCommand("setMonster")

Game.AssignOnClientRequestExecute("setMonster", function(client, mousePos, arg)

    if client.Character ~= hostClient then
        local errorHost = "[ERROR]: setMonster command: only host is allowed to spawn The Great Yibaka"
        Game.SendMessage(errorHost, 6)
        return nil
    end
    
    if #arg ~= 2 then
        local errorArg = "[ERROR]: setMonster command:  need 2 args:\n - [ string ] monster name\n - [ string ] character name to control it"
        Game.SendMessage(errorArg, 6)
        return nil
    end

    local monster = FindValidMonster(arg[1])
    if monster == nil then 
        local errorMonster = "[ERROR]: setMonster command: incorrect monster name"
        Game.SendMessage(errorMonster, 6)
        return nil
    end

    local client = Util.FindClientCharacter(FindValidCharacter(arg[2]))
    if client == nil then 
        local errorChar = "[ERROR]: setMonster command: player not found"
        Game.SendMessage(errorChar, 6)
        return nil
    end

    -- local ifEnd = arg[3]

    -- if ifEnd then
    --     Hook.Add("character.death", "monsterDeath", function(character)    -- TODO optional EndGame
    --         if character == monster then 
    --             Game.SendMessage(character .. " " .. "died", 0)
    --             Game.EndGame()
    --         end
    --     end)
    -- end

    spawnMonster{monsterName = monster, cl = client}

end)

updatePlayerList()
