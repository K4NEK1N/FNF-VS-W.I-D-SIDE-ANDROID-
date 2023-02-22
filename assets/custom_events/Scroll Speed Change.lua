function onEvent(name,v1)
    if name == 'Scroll Speed Change' then
        setProperty('songSpeed',v1)
    end
end