-----------------------------------
-- Area: Mamook
--  NPC: _1t0 (Mahogany Door)
-- Notes:
--      Door at teleport landing spot from Red Bell Key Item Door
--      Presumably this door teleports players back to the Red Bell Door
--      Not reachable by players until the Mamook Incursion event is coded
-- !pos 420.000, 19.939, 520.000
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

return entity
