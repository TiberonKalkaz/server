-----------------------------------
-- Area: Mamook
--  NPC: _1t3 (Ebony Door)
-- Notes: Locked Door.  Opened via Tanscale Key or Thief picking the lock.  Openable from inside the door.
-- !pos -279.999, 6.934, -260.000
-----------------------------------
local mamookGlobal = require('scripts/zones/Mamook/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

local lockedSideOfDoor = function(player)
    return player:getXPos() > -279.999
end

entity.onTrade = function(player, npc, trade)
    mamookGlobal.onTradeEbonyDoor(player, npc, trade, lockedSideOfDoor(player))
end

entity.onTrigger = function(player, npc)
    mamookGlobal.onTriggerEbonyDoor(player, npc, lockedSideOfDoor(player))
end

return entity
