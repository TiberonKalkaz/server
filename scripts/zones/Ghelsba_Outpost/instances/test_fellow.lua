-----------------------------------
-- Ghelsba_Outpost instance hilarity
-----------------------------------
require("scripts/globals/instance")
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
-----------------------------------
local instanceObject = {}

instanceObject.afterInstanceRegister = function(player)
    print("test_fellow - afterInstanceRegister")
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instanceObject.onInstanceCreated = function(instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    print("test_fellow - onInstanceCreatedCallback")
    if instance then
        player:setInstance(instance)
        player:setPos(-177, -10.5, 59, 106, instance:getZone():getID())
    end
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    printf("test_fellow - onInstanceTimeUpdate")
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        --v:startEvent(102)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

instanceObject.onInstanceComplete = function(instance)
end

instanceObject.onEventUpdate = function(player, csid, option)
end

instanceObject.onEventFinish = function(player, csid, option)
end

return instanceObject
