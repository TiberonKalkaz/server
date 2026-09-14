-----------------------------------
-- Area: Mamook
--  NPC: _1t6 (Ebony Door)
-- Notes: Locked Door.  Opened via Tanscale Key or Thief picking the lock.  Openable from inside the door.
-- !pos 100.000, 12.943, -440.000
-----------------------------------
local mamookGlobal = require('scripts/zones/Mamook/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

local lockedSideOfDoor = function(player)
    return player:getZPos() < -440.000
end

entity.onTrade = function(player, npc, trade)
    mamookGlobal.onTradeEbonyDoor(player, npc, trade, lockedSideOfDoor(player))
end

entity.onTrigger = function(player, npc)
    mamookGlobal.onTriggerEbonyDoor(player, npc, lockedSideOfDoor(player))
end

return entity
