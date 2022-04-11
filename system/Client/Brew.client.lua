local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Shared = ReplicatedStorage.syncSession

local warn = require(Shared.Warn)

local Remotes = Shared.Remotes
local SendSession = Remotes.SendSession
local FilterText = Remotes.FilterText

SendSession.OnClientEvent:Connect(function(Information, Text, Time)
    for _, Object in pairs(Information:GetChildren()) do
        if Object:IsA('Frame') then
            local FilteredText = FilterText:InvokeServer(Object.Text.Text)
            Object.Text.Text = FilteredText
        end
    end

    Time = DateTime.fromIsoDate(Time):ToLocalTime()

    local Minute = Time.Minute
    if Minute == 0 then
        Minute = '00'
    end

    Text.Text = string.format('%s %s\n%s:%s', Time.Day, os.date('%B', Time.Month), Time.Hour, Minute)
end)