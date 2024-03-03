if CLIENT then return end 

function updatePlayerList()
    playerList = {}
    for player in Character.CharacterList do 
        -- print(player, " ", player.DisplayName)
        if player.isHuman and not player.IsBot then
            table.insert(playerList, player.DisplayName)
        end
    end
    -- printPlayers()
    return playerList
end

function printPlayers()
    for player in playerList do
        print("==========================")
        print("Player: ", player)
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
    local errorMsg = "[ERROR]: No chosen clients found"

    if arg.cl == nil then
        print(errorMsg)
        return 
    end

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
        print(arg.monsterName, " ", monster)
        local text = "The hunt's begun ... but who is the prey?"
        if arg.monsterName == "Psilotoad" then
            text = "RUN, FOOLS!!!"
        end
        Game.SendMessage(text, 11)
        arg.cl.SetClientCharacter(monster)
    end)
end

function CharacterToClient(character)
    for key, client in pairs(Client.ClientList) do
        if client.Character == character then 
            return client
        end
    end
    return nil
end

function incLevel()                                              -- TODO fix
    for player in Character.CharacterList do 
        if player.isHuman then
            player.Info.IncreaseSkillLevel("helm", 100)
            player.Info.IncreaseSkillLevel("weapons", 100)
            player.Info.IncreaseSkillLevel("medical", 100)
            player.Info.IncreaseSkillLevel("electrical", 100)
            player.Info.IncreaseSkillLevel("mechanical", 100)
        end
    end
end

function giveExp()                                               -- TODO fix
    for player in Character.CharacterList do 
        if player.isHuman then
            player.Info.GiveExperience(160000)
        end
    end
end
