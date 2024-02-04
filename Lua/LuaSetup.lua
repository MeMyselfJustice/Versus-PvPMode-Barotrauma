if CLIENT then return end 


Hook.Add("chatMessage", "chatMessages", function (message, client)
    if message == "test" then 
        Game.SendMessage(errorMonster, 0)
    end
    return true 
end)
