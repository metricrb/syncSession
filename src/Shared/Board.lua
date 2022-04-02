local Templates = {
    Board = script.Board,
    Session = script.Session,
    Value = script.Value,
    Button = script.Button
}

local Board = {
    Boards = {},
    Sessions = {}
}
Board.__index = Board

function Board.New(Object: Instance)
    local Data = {
        Interface = nil
    }

    Data.Interface = Templates.Board:Clone()
    Data.Interface.Parent = Object

    Board.Boards[Object] = Data
end

function Board:ShowSessions()
    for _, Data in pairs(Board.Boards) do
        Data.Interface.Container.Main.Visible = true
    end
end

function Board:ShowError()
    for _, Data in pairs(Board.Boards) do
        Data.Interface.Container.Error.Visible = true
    end
end

function Board:ClearSessions()
    for _, Data in pairs(Board.Boards) do
        local Interface = Data.Interface
        local Container = Interface.Container.Main

        for _, Object in pairs(Container:GetChildren()) do
            if Object:IsA('Frame') then
                Object:Destroy()
            end
        end
    end
end

function Board:NewSession(Title: string, Information: table, Time: table)
    -- [!] This could eventually cause problems with timezones, but eh..
    if Time.Minute == 0 then
        Time.Minute = 00
    end

    Time = string.format('%s:%s', Time.Hour, Time.Minute)

    for _, Data in pairs(Board.Boards) do
        local Interface = Data.Interface
        local Container = Interface.Container.Main

        local Session = Templates.Session:Clone()
        local Information_Container = Session.Information

        for _, Table in pairs(Information) do
            local Clone = Templates.Value:Clone()
            Clone.Icon.Image = Table.Image or 'rbxassetid://7072717759'
            Clone.Text.Text = Table.Value or 'No <b>data</b> has been found.'

            Clone.Icon.ImageColor3 = Table.ImageColor or Color3.new(0, 150, 136)

            Clone.Parent = Information_Container
        end

        Session.Text.Title.Text = Title or 'Session'
        Session.Time.Title.Text = Time or 'Unknown'

        Session.Parent = Container
    end
end

return Board