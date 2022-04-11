-- ██████╗░██████╗░░█████╗░██████╗░██╗░░░░░███████╗████████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░░░░░██╔════╝╚══██╔══╝
-- ██║░░██║██████╔╝██║░░██║██████╔╝██║░░░░░█████╗░░░░░██║░░░
-- ██║░░██║██╔══██╗██║░░██║██╔═══╝░██║░░░░░██╔══╝░░░░░██║░░░
-- ██████╔╝██║░░██║╚█████╔╝██║░░░░░███████╗███████╗░░░██║░░░
-- ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚══════╝╚══════╝░░░╚═╝░░░
-- Refer to our documentation to set up our product properly: https://droplet-systems.gitbook.io/syncSession

local Players = game:GetService('Players')

return {
    Key = '1a2b3c4d5e6f7g8h9i0j',
    Token = '1a2b3c4d5e6f7g8h9i0j1a2b3c4d5e6f7g8h9i0j',
    BoardName = 'Sessions',

    List = 'Upcoming',

    Fields = {
        {
            Argument = 'Host',

            Image = nil,
            ImageColor = Color3.new(255, 255, 255),
            GetImage = function(Value)
                local Status, Identifier = pcall(function()
                    return Players:GetUserIdFromNameAsync(Value)
                end)

                if not Status then
                    Identifier = nil
                end

                if Identifier then
                    return string.format('rbxthumb://type=AvatarHeadShot&id=%s&w=420&h=420', Identifier)
                else
                    return 'rbxassetid://7072717759'
                end
            end,

            Value = '<b>%s</b> is hosting.',
            GetValue = function(Value)
                local Status, Result = pcall(function()
                    return Players:GetUserIdFromNameAsync(Value)
                end)

                if not Status then
                    Result = nil
                end

                if Result then
                    return Value
                else
                    return 'Unknown user'
                end
            end
        },

        {
            Argument = 'Co-Host',

            Image = nil,
            ImageColor = Color3.new(255, 255, 255),
            GetImage = function(Value)
                local Status, Identifier = pcall(function()
                    return Players:GetUserIdFromNameAsync(Value)
                end)

                if not Status then
                    Identifier = nil
                end

                if Identifier then
                    return string.format('rbxthumb://type=AvatarHeadShot&id=%s&w=420&h=420', Identifier)
                else
                    return 'rbxassetid://7072717759'
                end
            end,

            Value = '<b>%s</b> is co-hosting.',
            GetValue = function(Value)
                local Status, Result = pcall(function()
                    return Players:GetUserIdFromNameAsync(Value)
                end)

                if not Status then
                    Result = nil
                end

                if Result then
                    return Value
                else
                    return 'Unknown user'
                end
            end
        }
    },

    Seperator = ': ',

    Wait = 10
}