-- Zone: Mamook (65)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------

local mamookGlobal = {}

local doorOpenTime     = 15 -- Doors stay open for 15s
local noValidationFlag = 0x8000

local thiefKeyInfo =
{
    -- [key type] = { { level, success rate}, { level, success rate} } -- extendable once different tiers are discovered
    [xi.item.SET_OF_THIEFS_TOOLS] = { {  75, 20 }, {  65, 10 } }, -- Based on 120 trades at 65, 70, and 75
    [xi.item.LIVING_KEY         ] = { {  75, 20 }, {  65, 10 } }, -- ToDo: Get Captures for large sets. Current Data at lvl 75 - 3/9
    [xi.item.SKELETON_KEY       ] = { {  75, 20 }, {  65, 10 } }, -- ToDo: Get Captures for large sets. Current Data at lvl 75 - 5/8
}

-----------------------------------
-- Helper fcn to extract thf tool
-----------------------------------
local function getTradedThiefTool(trade)
    if npcUtil.tradeHasExactly(trade, xi.item.SKELETON_KEY) then
        return xi.item.SKELETON_KEY
    elseif npcUtil.tradeHasExactly(trade, xi.item.LIVING_KEY) then
        return xi.item.LIVING_KEY
    elseif npcUtil.tradeHasExactly(trade, xi.item.SET_OF_THIEFS_TOOLS) then
        return xi.item.SET_OF_THIEFS_TOOLS
    end

    -- something else was traded
    return 0
end

-----------------------------------
-- Helper fcn to find success rate based on level and thf tool
-----------------------------------
local function getDoorSuccessRate(thfKeyType, playerLevel)
    local brackets = thiefKeyInfo[thfKeyType]

    if not brackets then
        return 0
    end

    for i = 1, #brackets do
        local minLevel, successRate = brackets[i][1], brackets[i][2]

        if playerLevel >= minLevel then
            return successRate
        end
    end

    return 0
end

-----------------------------------
-- Handles lockpick attempts including messaging
-----------------------------------
local function tryLockpick(player, npc, trade)
    local thfKeyType = getTradedThiefTool(trade)

    -- not a valid thief lockpick tool
    if thfKeyType == 0 then
        return
    end

    local rate = getDoorSuccessRate(thfKeyType, player:getMainLvl())

    if math.randomInt(1, 100) <= rate then
        npc:openDoor(doorOpenTime)
        player:showText(npc, bit.bor(ID.text.LOCK_SUCCESS, noValidationFlag), thfKeyType, 0, 15, 0, false, false)
    else
        player:showText(npc, bit.bor(ID.text.LOCK_FAIL, noValidationFlag), thfKeyType, 0, 15, 0, false, false)
    end

    player:tradeComplete()
end

-----------------------------------
-- Trading to attempt to open a locked Ebony Door
-- lockedSideOfDoor (boolean) true if player is trading from the locked side
-----------------------------------
mamookGlobal.onTradeEbonyDoor = function(player, npc, trade, lockedSideOfDoor)
    -- early exit criteria
    if
        trade:getItemCount() ~= 1 or
        npc:getAnimation() ~= xi.animation.CLOSE_DOOR or
        not lockedSideOfDoor
    then
        return
    end

    -- handle the Tanscale Key
    if npcUtil.tradeHasExactly(trade, xi.item.MAMOOK_TANSCALE_KEY) then
        npc:openDoor(doorOpenTime)
        player:showText(npc, bit.bor(ID.text.KEY_BREAKS, noValidationFlag), xi.item.MAMOOK_TANSCALE_KEY, 0, 14, 65344, false, false)
        player:tradeComplete()
        return
    end

    -- handle lockpicking
    if player:getMainJob() == xi.job.THF then
        tryLockpick(player, npc, trade)
    end
end

-----------------------------------
-- Player interacting with Ebony Door
-- lockedSideOfDoor (boolean) true if player is interacting from the locked side
-----------------------------------
mamookGlobal.onTriggerEbonyDoor = function(player, npc, lockedSideOfDoor)
    if npc:getAnimation() == xi.animation.CLOSE_DOOR then
        if lockedSideOfDoor then
            if player:getMainJob() == xi.job.THF then
                player:showText(npc, bit.bor(ID.text.DOOR_IS_LOCKED2, noValidationFlag), xi.item.MAMOOK_TANSCALE_KEY, xi.item.SET_OF_THIEFS_TOOLS, 15, 0, false, false)
            else
                player:showText(npc, bit.bor(ID.text.DOOR_IS_LOCKED, noValidationFlag), xi.item.MAMOOK_TANSCALE_KEY, 0, 14, 65344, false, false)
            end
        else
            player:messageText(npc, ID.text.YOU_UNLOCK_DOOR, false, 6)
            npc:openDoor(doorOpenTime)
        end
    end
end

return mamookGlobal
