local config = {
    ["knight"] = {
        [25] = 3,
        [50] = 4,
        [100] = 5,
        [150] = 7,
        [200] = 9,
        [250] = 10,
        [300] = 11,
        [350] = 13,
        [400] = 14,
    },
    ["sorcerer"] = {
        [25] = 3,
        [50] = 4,
        [100] = 5,
        [150] = 7,
        [200] = 9,
        [250] = 10,
        [300] = 11,
        [350] = 13,
        [400] = 14,
    },
    ["druid"] = {
        [25] = 3,
        [50] = 4,
        [100] = 5,
        [150] = 7,
        [200] = 9,
        [250] = 10,
        [300] = 11,
        [350] = 13,
        [400] = 14,
    },
    ["paladin"] = {
        [25] = 3,
        [50] = 4,
        [100] = 5,
        [150] = 7,
        [200] = 9,
        [250] = 10,
        [300] = 11,
        [350] = 13,
        [400] = 14,
    },
}

local function unlockSagaRewards(player, outfitId)
    player:addOutfit(outfitId)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have unlocked a new saga by reaching the level %d.")
end

local advanceSave = CreatureEvent("SagaOutfit")
function advanceSave.onAdvance(player, skill, oldLevel, newLevel)
    if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
        return true
    end

    local vocation = player:getVocation():getName():lower()
    local saga = config[vocation]
    if saga then
        local highestUnlockedLevel = player:getStorageValue(1000) or 0
        local newUnlockedLevel = highestUnlockedLevel

        for level, outfitId in pairs(saga) do
            if newLevel >= level and level > highestUnlockedLevel then
                newUnlockedLevel = level
            end
        end

        if newUnlockedLevel > highestUnlockedLevel then
            player:setStorageValue(1000, newUnlockedLevel)
            local outfitId = saga[newUnlockedLevel]
            unlockSagaRewards(player, outfitId)
        end
    end

    return true
end
advanceSave:register()
