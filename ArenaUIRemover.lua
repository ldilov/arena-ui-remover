local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")

local hiddenFrame = CreateFrame("Frame")

local function handleFrame(self, spec)
    if InCombatLockdown() then return end
    self:SetParent(hiddenFrame)
    print("|cffFFF569ArenaUIRemover|r loaded!")
end

eventFrame:SetScript("OnEvent", function(self, event, name)
    if not CompactArenaFrame then return end
    hiddenFrame:Hide()
    C_CVar.SetCVar('showArenaEnemyFrames', 0)
    hooksecurefunc(CompactArenaFrame, "UpdateVisibility", handleFrame)
end)
