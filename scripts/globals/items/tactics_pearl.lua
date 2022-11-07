-----------------------------------------
-- ID: 14811
-- Item: Tactics Pearl
-- Calls forth an adventuring fellow
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getFellow() ~= nil or target:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
        or target:hasStatusEffect(xi.effect.LEVEL_SYNC) or
        xi.settings.main.ENABLE_ADVENTURING_FELLOWS == nil or xi.settings.main.ENABLE_ADVENTURING_FELLOWS == 0 then
            return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if not target:canUseMisc(xi.zoneMisc.FELLOW) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end
    
    local wotg_unlock = target:getFellowValue("wotg_unlock")
    
    if (target:getContinentID()==3 and wotg_unlock == 0) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

itemObject.onItemUse = function(target)
    target:spawnFellow(target:getFellowValue("fellowid"))
    target:setFellowValue("bond", target:getFellowValue("bond")+1)
end

return itemObject