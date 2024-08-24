-- Author      : Lazar Dilov
-- Create Date : 1/10/2024 6:12:20 AM

C_CVar.SetCVar('showArenaEnemyFrames', 0)

local blizzFrame = CreateFrame("Frame", nil, UIParent)
        blizzFrame:SetSize(1, 1)
        blizzFrame:SetPoint("RIGHT", UIParent, "RIGHT", 500, 0)
        blizzFrame:Hide()

local farenaprep = CreateFrame('Frame')
farenaprep:SetScript('OnEvent', function(self, event,...)
    if event == 'ARENA_PREP_OPPONENT_SPECIALIZATIONS' or event == 'ARENA_OPPONENT_UPDATE' then
        print("|cffFFF569ArenaUIRemover:|r default arena frames are now hidden!")
        ArenaRemoverEventCallback()
    end
end)

farenaprep:RegisterEvent('ARENA_PREP_OPPONENT_SPECIALIZATIONS')

local farenaprep_2 = CreateFrame('Frame')
farenaprep_2:SetScript('OnEvent', function(self, event,...)
    if event == 'ADDON_LOADED' and ... == 'Blizzard_ArenaUI' then
      print("|cffFFF569ArenaUIRemover|r loaded!")
      ArenaRemoverEventCallback()
    end
end)

farenaprep_2:RegisterEvent('ADDON_LOADED')
farenaprep_2:RegisterEvent('ARENA_OPPONENT_UPDATE')
farenaprep_2:RegisterEvent('PLAYER_ENTERING_WORLD')

ArenaRemoverEventCallback = function()
  local _, instanceType = IsInInstance()

  loaded, value = C_AddOns.LoadAddOn(name)
  C_CVar.SetCVar('showArenaEnemyFrames', 0)

  if (instanceType == "arena") then
      for i = 1, 5 do
          local arenaFrame = _G["ArenaEnemyMatchFrame" .. i]
          local prepFrame = _G["ArenaEnemyPrepFrame" .. i]
          local arenaFramesContainøer = _G["ArenaEnemyMatchFramesContainer"]
          local prepFramesContainer = _G["ArenaEnemyPrepFramesContainer"]
          
          if prepFrame ~= nil then
              prepFrame:SetParent(blizzFrame)
              prepFrame:ClearAllPoints()
              prepFrame:Hide()             
              prepFrame.Show = function() end
          end

          if prepFramesContainer ~= nil then
              prepFramesContainer:ClearAllPoints()
              prepFramesContainer:Hide()
              prepFramesContainer.Show = function() end
          end

          if arenaFrame ~= nil then
              arenaFrame:SetParent(blizzFrame)
              arenaFrame:ClearAllPoints()
              arenaFrame:Hide()
              arenaFrame.Show = function() end
          end

          if arenaFramesContainer ~= nil then
              arenaFramesContainer:ClearAllPoints()
              arenaFramesContainer:Hide()
              arenaFramesContainer.Show = function() end
          end
      end
  end
end
