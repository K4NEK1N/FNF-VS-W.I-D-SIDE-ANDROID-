function onEvent(name,v1,v2)
    if name == 'cinematic' then
        local bordersSize = '110'
        local easing = 'quartInOut'
        local duration = 0.6
        local comma1v1 = 0
        local comma2v1 = 0
        local comma3v1 = 0
        local comma4v1 = 0
        local comma5v1 = 0
        local comma6v1 = 0

        local comma1v2 = 0
        local comma2v2 = 0
        local enable = 'true'
        local layer = 'hud'
        
        if v1 ~= '' then
            comma1v1,comma2v1 = string.find(v1,',',0,true)
            if comma1v1 ~= nil then
                comma3v1,comma4v1 = string.find(v1,',',comma2v1 + 1)
                if comma3v1 ~= nil then
                    bordersSize = string.sub(v1,comma2v1 + 1,comma3v1 - 1)
                    layer = string.sub(v1,comma4v1 + 1)
                else
                    bordersSize = string.sub(v1,comma2v1 + 1)
                end
                enable = string.sub(v1,0,comma1v1 - 1)
            else
                enable = v1
            end
        end
        if v2 ~= '' then
            comma1v2,comma2v2 = string.find(v2,',',0,true)
            if comma1v2 ~= nil then
                duration = tonumber(string.sub(v2,0,comma1v2 - 1))
                easing = string.sub(v2,comma2v2 + 1)
            else
                if v2 ~= '' then
                    duration = tonumber(v2)
                else
                    duration = 0
                end
            end
        end
        for cinematicBorders = 1,2 do
            if enable == 'true' or enable == '' then
                if cinematicBorders == 1 then
                    makeLuaSprite('cinematicBorders'..cinematicBorders,nil,0,bordersSize * -1)
                else
                    makeLuaSprite('cinematicBorders'..cinematicBorders,nil,0,screenHeight)
                end
                if duration ~= 0 then
                    if cinematicBorders == 1 then
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,0,duration,easing)
                    else
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,screenHeight - bordersSize,duration,easing)
                    end
                else
                    if cinematicBorders == 1 then
                        setProperty('cinematicBorders'..cinematicBorders..'.y',0)
                    else
                        setProperty('cinematicBorders'..cinematicBorders..'.y',screenHeight - bordersSize)
                    end
                end
                makeGraphic('cinematicBorders'..cinematicBorders,screenWidth,bordersSize,'000000')
                setObjectCamera('cinematicBorders'..cinematicBorders,layer)
                addLuaSprite('cinematicBorders'..cinematicBorders,false)
                setObjectOrder('cinematicBorders'..cinematicBorders,3 - cinematicBorders)
            else
                if duration ~= 0 then
                    if cinematicBorders == 1 then
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,bordersSize *-1,duration,easing)
                    else
                        doTweenY('cinematicBordersY'..cinematicBorders,'cinematicBorders'..cinematicBorders,screenHeight,duration,easing)
                    end
                else
                    removeLuaSprite('cinematicBorders'..cinematicBorders,false)
                end
            end

        end
    end
end