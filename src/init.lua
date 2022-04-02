local RunService = game:GetService('RunService')

if RunService:IsClient() then
    warn('Attempted to deploy on the client! Did you complete the setup properly? Perhaps you should read our documentation.')
end

local Players = game:GetService('Players')

local sessionSync = script
local Server = sessionSync.Server
local Shared = sessionSync.Shared

local warn = require(Shared.Warn)

local Modules = {
    Board = require(Shared.Board),
    Trello = require(Shared.Trello)
}

return function(Configuration, Boards)
    Configuration = require(Configuration)
    
    for _, Board in pairs(Boards:GetChildren()) do
        Modules.Board.New(Board)
        Modules.Board:ShowNoUpcoming()
    end

    local Key = Configuration.Key
    local Token = Configuration.Token

    local Trello = Modules.Trello.New(Key, Token)

    local Board = Trello:GetBoard(Configuration.BoardName)
    local BoardLists = Trello:GetLists()
    local InvalidLists = {}
    local Lists = {}

    if not (Board or BoardLists) then
        warn('Board or lists were not found. This could be a Trello error.')

        Modules.Board:ShowError()

        return
    end

    for _, List in pairs(BoardLists) do
        InvalidLists[List.name] = List.id
    end

    for Value, Name in pairs(Configuration.Lists) do
        local Data = InvalidLists[Name]
        Lists[Value] = Data
    end

    local Interval = Configuration.Wait

    if Interval < 120 then
        Interval = 120
        warn('Interval was below 120, this would cause throttling - interval has been automatically set to 120.')
    end

    while true do task.wait(Interval)
        Modules.Board:ClearSessions()

        local Cards = Trello:GetCards(Lists.Upcoming)

        for _, Card in pairs(Cards or {}) do
            local Date = Card.badges.due

            if not (Date or Card.desc) then
                return
            end

            if Card.badges.dueComplete then
                return
            end

            Date = DateTime.fromIsoDate(Date):ToLocalTime()

            local BadDescription = {}
            local Description = {}

            for Text in string.gmatch(Card.desc, '[^\n]+') do
                local Title, Value = string.match(Text, "(.+): (.+)")
                BadDescription[Title] = Value
            end

            for Value, Name in pairs(Configuration.Fields) do
                local Data = BadDescription[Name]
                Description[Value] = Data
            end

            local Names = {
                Host = Description.Host or 'Unknown user',
                CoHost = Description.CoHost or 'Unknown user'
            }
            local Profiles = {}

            local Status, Result = pcall(function()
                return {
                    Host = Players:GetUserIdFromNameAsync(Names.Host),
                    CoHost = Players:GetUserIdFromNameAsync(Names.CoHost)
                }
            end)

            if Status and Result then
                Profiles.Host = Result.Host or 'rbxassetid://7072717759'
                Profiles.CoHost = Result.CoHost or 'rbxassetid://7072717759'
            end

            Modules.Board:NewSession(
                Description.Type or 'Session',

                {
                    {
                        Image = string.format('rbxthumb://type=AvatarHeadShot&id=%s&w=420&h=420', Profiles.Host or 'rbxassetid://7072717759'),
                        ImageColor = Color3.new(255, 255, 255),
                        Value = string.format('<b>%s</b> is hosting.', Names.Host)
                    },

                    {
                        Image = string.format('rbxthumb://type=AvatarHeadShot&id=%s&w=420&h=420', Profiles.CoHost or 'rbxassetid://7072717759'),
                        ImageColor = Color3.new(255, 255, 255),
                        Value = string.format('<b>%s</b> is co-hosting.', Names.CoHost)
                    },
                },

                Date
            )
        end
    end
end