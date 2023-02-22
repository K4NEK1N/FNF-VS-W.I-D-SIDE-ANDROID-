function onCreate()
    makeLuaSprite('blammedLight',nil,0,0)
    makeGraphic('blammedLight',screenWidth,screenHeight,'000000')
    setScrollFactor('blammedLight',0,0)
    setProperty('blammedLight.alpha',0)
end
function onEvent(name,v1,v2)
    if name == 'Blammed Lights' then
        local light = tonumber(v1)
        local flashOrder = getObjectOrder('boyfriendGroup')
        local time = 1
        local easing = 'linear'

        local commaStart = 0
        local commaEnd = 0
        if string.find(v2,',',0,true) ~= nil then
            commaStart,commaEnd = string.find(v2,',',0,true)
            time = tonumber(string.sub(v2,0,commaEnd - 1))
            easing = string.sub(v2,commaEnd + 1)
        else
            if v2 ~= '' then
                time = tonumber(v2)
            end
        end
        if flashOrder > getObjectOrder('dadGroup') - 1 then
            flashOrder = getObjectOrder('dadGroup') - 1
        end
        if light == 0 then
            if getProperty('blammedLight.alpha') > 0 then
                if time ~= 0 then
                    doTweenAlpha('blammedLightBye','blammedLight',0,time,easing)
                else
                    setProperty('blammedLight.alpha',0)
                end
                light = -1
            end
        elseif light ~= 0 then
            cancelTween('blammedLightBye')
            setObjectOrder('blammedLight',flashOrder)
            if time ~= 0 then
                doTweenAlpha('blammedLightHello','blammedLight',1,time,easing)
            else
                setProperty('blammedLight.alpha',1)
            end
            addLuaSprite('blammedLight',false)
        end
    end
end
function onUpdate()
    setProperty('blammedLight.x',math.min(0,-100 * ((1 - getProperty('camGame.zoom')) * 10)))
    setProperty('blammedLight.y',math.min(0,-100 * ((1 - getProperty('camGame.zoom')) * 10)))
    scaleObject('blammedLight',math.max(1,1 + ((1 - getProperty('camGame.zoom'))*2)),math.max(1,1 + ((1 - getProperty('camGame.zoom'))*2)))
end
function onTweenCompleted(name)
    if name == 'blammedLightBye' then
        removeLuaSprite('blammedLight',false)
    end
end