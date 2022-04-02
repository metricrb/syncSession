return function(Content: string)
    if not Content then return end

    warn(string.format('[syncSession] %s', Content))
end