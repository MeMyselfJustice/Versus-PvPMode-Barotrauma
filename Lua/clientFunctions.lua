if SERVER then return end 

function getDescMonster(monster)
    local descMonsterOpen = io.open(modPath .. "/desc/" .. monster .. ".txt", "rb")
    descMonster = descMonsterOpen:read "*a*"
    descMonsterOpen:close()
    return descMonster
end

-- function sleepTime(seconds)
--     local start = os.clock()
--     print("CLOCK")
--     while os.clock() - start < seconds do end
-- end

function setFrameVisibility(monster)
    for name, visibility in pairs(monsterVisibilityDict) do
        if monster == name then
            visibility.Visible = not visibility.Visible
        elseif visibility.Visible then
            visibility.Visible = false
        end
    end
end

function updatePlayerList()
    playerList = {}
    for player in Character.CharacterList do 
        -- print(player, " ", player.DisplayName)
        if player.isHuman and not player.IsBot then
            table.insert(playerList, player.DisplayName)
        end
    end
    printPlayers()
    return playerData
end

function printPlayers()
    for player in playerList do
        print("==========================")
        print("Player: ", player)
        print("==========================")
    end
end

function eraseListObject()
    playerChoose = nil
end
