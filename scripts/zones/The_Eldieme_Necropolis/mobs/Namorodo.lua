-----------------------------------
-- Area: The Eldieme Necropolis
--  MOB: Namorodo
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:SetMagicCastingEnabled(false)
    mob:timer(30000, function(mob) mob:SetMagicCastingEnabled(true) end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
    local personality = player:getFellowValue("personality")
    local fellow = player:getFellow()
    if fellow ~= nil then
        function checkPersonality(personality)
            local personaTable = {4,8,12,16,40,44,20,24,28,32,36,48}
            for i,v in ipairs(personaTable) do
                if v == personality then
                    return i - 1
                end
            end
        end
        player:showText(fellow, ID.text.SEEMS_TO_BE_THE_END + checkPersonality(personality))
        player:setCharVar("[Quest]Looking_Glass", 3)
        player:timer(30000, function(player) player:despawnFellow() end) -- 30 sec to talk to fellow
    end
end

return entity