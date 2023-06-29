return function(syncSession, Shared, Boards, Key, Token, Configuration)
    local Private = syncSession.Private
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local warn = require(Shared.Warn)
    
    local Modules = {
        Board = require(Shared.Board),
        Trello = require(Private.Trello)
    }

    local Trello = Modules.Trello

    local Board = Trello:GetBoard(Configuration.BoardName)
    local BoardLists = Trello:GetLists()
    local List = nil

    if not (Board or BoardLists) then
        Modules.Board:ShowError()
        return
    end

    for _, Data in pairs(BoardLists) do
        if Data.name == Configuration.List then
            List = Data.id
        end
    end
    

    local function getShifts()
        local Cards = Trello:GetCards(List)

        for _, Card in pairs(Cards or {}) do
            local Date = Card.badges.due

            if not Date then
                continue
            end

            if Card.badges.dueComplete then
                continue
            end

            if not Card.desc then
                continue
            end

            local Description = {}

            -- Configuration.ShiftTypeName

            for Text in string.gmatch(Card.desc, '[^\n]+') do
                local Title, Value = string.match(Text, '(.+)'..Configuration.Seperator..'(.+)')
                
                for _, Field in pairs(Configuration.Fields) do
                
                end
            end
        end   
    end

    local function getTrainings()
                    -- Configuration.TrainingTypeName
    end
    
    local BindableFunction = ReplicatedStorage.GetLiveSessions

    BindableFunction.OnInvoke:Connect(function(session)
        if session == "Shift" then
            return getShifts()
        end
        if session == "Trainings" then
            return getTrainings()
        end
    end)
end
