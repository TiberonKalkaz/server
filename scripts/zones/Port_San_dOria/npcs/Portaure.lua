-----------------------------------
-- Area: Port San d'Oria
--  NPC: Portaure
-----------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 3) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local MirrorMirror = player:getQuestStatus(xi.quest.log_id.JEUNO,xi.quest.id.jeuno.MIRROR_MIRROR)
    local MirrorMirrorProgress = player:getCharVar("[Quest]Mirror_Mirror")
    local fellowParam = getFellowParam(player)

    if MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress == 1 then
        player:startEvent(745,0,0,0,0,0,0,0,fellowParam)
    else
        -- This does not seem to be implemented in ASB yet
        player:startEvent(650) -- 651 starts quest "A Job For The Consortium"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 745 then
        player:setCharVar("[Quest]Mirror_Mirror", 2)
    end
end

return entity
