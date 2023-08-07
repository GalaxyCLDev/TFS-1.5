local config = {
    [1] = {
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
 
local advanceSave = CreatureEvent("SagaOutfit")
function advanceSave.onAdvance(player, skill, oldLevel, newLevel)
    if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
        return true
    end
 
    local saga = config[player:getVocation():getId()]
    if saga then
        local highestUnlockedLevel = 0
        for level, outfitId in pairs(saga) do
            if newLevel >= level and level > highestUnlockedLevel then
                highestUnlockedLevel = level
            end
        end

        if highestUnlockedLevel > 0 then
            local outfitId = saga[highestUnlockedLevel]
            player:addOutfit(outfitId)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have unlocked a new saga by reaching the level " .. highestUnlockedLevel .. ".")
        end
    end
 
    return true
end
advanceSave:register()
