-----------------------------------
-- Area: Mamook
--  NPC: _1ta (Ebony Door)
-- Notes: Locked Door.  Opened via Tanscale Key or Thief picking the lock.  Openable from inside the door.
-- !pos 300.000, 43.947, 200.000
-----------------------------------
local mamookGlobal = require('scripts/zones/Mamook/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

local lockedSideOfDoor = function(player)
    return player:getZPos() > 200.000
end

entity.onTrade = function(player, npc, trade)
    mamookGlobal.onTradeEbonyDoor(player, npc, trade, lockedSideOfDoor(player))
end

entity.onTrigger = function(player, npc)
    mamookGlobal.onTriggerEbonyDoor(player, npc, lockedSideOfDoor(player))
end

return entity
