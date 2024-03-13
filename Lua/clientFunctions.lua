if SERVER then return end 

function getDescMonster(monster)
    local descMonsterOpen = io.open(modPath .. "/Descriptions/" .. monster .. ".txt", "rb")
    descMonster = descMonsterOpen:read "*a*"
    descMonsterOpen:close()
    return descMonster
end

function setFrameVisibility(monster)
    for name, visibility in pairs(monsterVisibilityDict) do
        if monster == name then
            visibility.Visible = not visibility.Visible
        elseif visibility.Visible then
            visibility.Visible = false
        end
    end
end
