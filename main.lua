


-- MerchantFrame_Type means "MerchantFrame, MailFrame or ClassTrainerFrame".
-- TradeSkillFrame_Type means "TradeSkillFrame, ArchaeologyFrame or PlayerTalentFrame".

local function frameCheck(f, ...)

  -- print(f:GetName())

  -- Reset to defaults. I.e. align CharacterFrame, MailFrame, ClassTrainerFrame,
  -- DressUpFrame and SpellBookFrame according to MerchantFrame.
  local opt = MovAny:GetUserData(CharacterFrame:GetName(), nil, true)
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
  MovAny.Position:Apply(opt, CharacterFrame)

  opt = MovAny:GetUserData(MailFrame:GetName(), nil, true)
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
  MovAny.Position:Apply(opt, MailFrame)

  if ClassTrainerFrame then
    opt = MovAny:GetUserData(ClassTrainerFrame:GetName(), nil, true)
    opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
    MovAny.Position:Apply(opt, ClassTrainerFrame)
  end

  opt = MovAny:GetUserData(DressUpFrame:GetName(), nil, true)
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
  MovAny.Position:Apply(opt, DressUpFrame)

  -- SpellBookFrame is always displayed with a slight offset.
  opt = MovAny:GetUserData(SpellBookFrame:GetName(), nil, true)
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 58, 41}
  MovAny.Position:Apply(opt, SpellBookFrame)



  -- Remember for later.
  local openingTradeSkillFrameType = nil

  -- Make TradeSkillFrame_Type frames mutually exclusive.
  if f == TradeSkillFrame and TradeSkillFrame:IsVisible() then
    openingTradeSkillFrameType = TradeSkillFrame
    if ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
      ArchaeologyFrame:Hide()
    end
    if PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
      PlayerTalentFrame:Hide()
    end

  elseif f == ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
    openingTradeSkillFrameType = ArchaeologyFrame
    if TradeSkillFrame and TradeSkillFrame:IsVisible() then
      TradeSkillFrame:Hide()
    end
    if PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
      PlayerTalentFrame:Hide()
    end

  elseif f == PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
    openingTradeSkillFrameType = PlayerTalentFrame
    if TradeSkillFrame and TradeSkillFrame:IsVisible() then
      TradeSkillFrame:Hide()
    end
    if ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
      ArchaeologyFrame:Hide()
    end

  end


  -- Remember for later.
  local rightmostFrame = nil

  -- If MerchantFrame_Type or DressUpFrame are visible, also make
  -- SpellBookFrame mutually exclusive with TradeSkillFrame_Type.
  if MerchantFrame:IsVisible() or MailFrame:IsVisible() or (ClassTrainerFrame and ClassTrainerFrame:IsVisible()) or DressUpFrame:IsVisible() then

    -- If TradeSkillFrame_Type is being opened, it replaces SpellBookFrame.
    if openingTradeSkillFrameType then
      rightmostFrame = openingTradeSkillFrameType
      if SpellBookFrame:IsVisible() then
        SpellBookFrame:Hide()
      end

    -- If SpellBookFrame is being opened, it replaces TradeSkillFrame_Type.
    elseif (f == SpellBookSideTabsFrame or f == SpellBookFrame) and SpellBookFrame:IsVisible() then
      rightmostFrame = SpellBookFrame
      if TradeSkillFrame and TradeSkillFrame:IsVisible() then
        TradeSkillFrame:Hide()
      end
      if ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
        ArchaeologyFrame:Hide()
      end
      if PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
        PlayerTalentFrame:Hide()
      end

    -- If MerchantFrame_Type or DressUpFrame is being opened while SpellBookFrame
    -- and TradeSkillFrame_Type are visible, SpellBookFrame shall be hidden.
    elseif TradeSkillFrame and TradeSkillFrame:IsVisible() then
      rightmostFrame = TradeSkillFrame
      if SpellBookFrame:IsVisible() then
        SpellBookFrame:Hide()
      end
    elseif ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
      rightmostFrame = ArchaeologyFrame
      if SpellBookFrame:IsVisible() then
        SpellBookFrame:Hide()
      end
    elseif PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
      rightmostFrame = PlayerTalentFrame
      if SpellBookFrame:IsVisible() then
        SpellBookFrame:Hide()
      end
    end

  -- Otherwise the newly opened TradeSkillFrame_Type is our rightmostFrame.
  elseif openingTradeSkillFrameType then
    rightmostFrame = openingTradeSkillFrameType

  -- Check again if a TradeSkillFrame is still open.
  elseif TradeSkillFrame and TradeSkillFrame:IsVisible() then
    rightmostFrame = TradeSkillFrame
  elseif ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
    rightmostFrame = ArchaeologyFrame
  elseif PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
    rightmostFrame = PlayerTalentFrame

  end




  -- Place DressUpFrame to the right of the rightmost frame.
  -- Order of preference: TradeSkillFrame_Type, SpellBookFrame, CharacterFrame or leftmost.
  local xOffsetDressUpFrame = 0

  if CharacterFrame:IsVisible() then
    xOffsetDressUpFrame = CharacterFrame:GetWidth() + 18
  end

  -- If MerchantFrame_Type is visible, everything is moved to the right of MerchantFrame.
  if MerchantFrame:IsVisible() or MailFrame:IsVisible() or (ClassTrainerFrame and ClassTrainerFrame:IsVisible()) then

    -- print("MerchantFrame_Type")

    if CharacterFrame:IsVisible() then
      -- Move CharacterFrame to the right of MerchantFrame_Type.
      local opt = MovAny:GetUserData(CharacterFrame:GetName(), nil, true)
      opt.pos = {"TOPLEFT", "MerchantFrame", "TOPRIGHT", 18, 0}
      MovAny.Position:Apply(opt, CharacterFrame)
    end


    -- Move rightmostFrame next to MerchantFrame_Type.
    if rightmostFrame then

      -- Move DressUpFrame to the right of rightmostFrame.
      xOffsetDressUpFrame = MerchantFrame:GetWidth() + rightmostFrame:GetWidth() + 36
      -- Extra offset for Archaeology side tabs.
      if rightmostFrame == ArchaeologyFrame then
        xOffsetDressUpFrame = xOffsetDressUpFrame + 32
      -- Extra offset for spell book side tabs.
      elseif SpellBookSideTabsFrame:IsVisible() then
        xOffsetDressUpFrame = xOffsetDressUpFrame + 35
      end

      local opt = MovAny:GetUserData(rightmostFrame:GetName(), nil, true)
      -- If MerchantFrame_Type and CharacterFrame are open, the other frames move slightly right.
      if CharacterFrame:IsVisible() then
        opt.pos = {"TOPLEFT", "CharacterFrame", "TOPLEFT", 58, 41}
        xOffsetDressUpFrame = xOffsetDressUpFrame + 58
      else
        opt.pos = {"TOPLEFT", "MerchantFrame", "TOPRIGHT", 18, 41}
      end
      MovAny.Position:Apply(opt, rightmostFrame)

    else
      if CharacterFrame:IsVisible() then
        xOffsetDressUpFrame = MerchantFrame:GetWidth() + CharacterFrame:GetWidth() + 36
      else
        xOffsetDressUpFrame = MerchantFrame:GetWidth() + 18
      end
    end



  -- No MerchantFrame_Type is shown!
  else

    -- print("No MerchantFrame_Type")




    -- If SpellBookFrame and another rightmostFrame are visible,
    -- move rightmostFrame next to SpellBookFrame.
    -- (If this is the case DressUpFrame cannot be visible.)
    if SpellBookFrame:IsVisible() and rightmostFrame and rightmostFrame ~= SpellBookFrame then

      local opt = MovAny:GetUserData(rightmostFrame:GetName(), nil, true)
      -- Some extra space for spell book side tabs.
      if SpellBookSideTabsFrame:IsVisible() then
        opt.pos = {"TOPLEFT", "SpellBookFrame", "TOPRIGHT", 18 + 35, 0}
      else
        opt.pos = {"TOPLEFT", "SpellBookFrame", "TOPRIGHT", 18, 0}
      end
      MovAny.Position:Apply(opt, rightmostFrame)

    -- Only SpellBookFrame is visible.
    elseif SpellBookFrame:IsVisible() then

      xOffsetDressUpFrame = SpellBookFrame:GetWidth() + 58 + 18
      -- Extra offset for spell book side tabs.
      if SpellBookSideTabsFrame:IsVisible() then
        xOffsetDressUpFrame = xOffsetDressUpFrame + 35
      end

    -- Only TradeSkillFrame_Type is visible.
    elseif rightmostFrame then

      local opt = MovAny:GetUserData(rightmostFrame:GetName(), nil, true)
      opt.pos = {"TOPLEFT", "SpellBookFrame", "TOPLEFT", 0, 0}
      MovAny.Position:Apply(opt, rightmostFrame)

      xOffsetDressUpFrame = rightmostFrame:GetWidth() + 58 + 18
      -- Extra offset for Archaeology side tabs.
      if rightmostFrame == ArchaeologyFrame then
        xOffsetDressUpFrame = xOffsetDressUpFrame + 32
      end

    end


  end

  if DressUpFrame:IsVisible() then
    local opt = MovAny:GetUserData(DressUpFrame:GetName(), nil, true)
    opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", xOffsetDressUpFrame, 0}
    MovAny.Position:Apply(opt, DressUpFrame)
  end

end



hooksecurefunc(CharacterFrame, "Show", frameCheck)
hooksecurefunc(CharacterFrame, "Hide", frameCheck)

-- Needed to react to resizing of CharacterFrame.
hooksecurefunc(PaperDollFrame, "Show", frameCheck)
hooksecurefunc(TokenFrame, "Show", frameCheck)
hooksecurefunc(ReputationFrame, "Show", frameCheck)

hooksecurefunc(DressUpFrame, "Show", frameCheck)
hooksecurefunc(DressUpFrame, "Hide", frameCheck)

hooksecurefunc(SpellBookFrame, "Show", frameCheck)
hooksecurefunc(SpellBookFrame, "Hide", frameCheck)
-- Need these as well to differentiate between SpellBookFrame tabs.
hooksecurefunc(SpellBookSideTabsFrame, "Show", frameCheck)
hooksecurefunc(SpellBookSideTabsFrame, "Hide", frameCheck)

hooksecurefunc(MerchantFrame, "Show", frameCheck)
hooksecurefunc(MerchantFrame, "Hide", frameCheck)

hooksecurefunc(MailFrame, "Show", frameCheck)
hooksecurefunc(MailFrame, "Hide", frameCheck)

-- TradeSkillFrame is not existing until opened for the first time...
local tradeSkillShowFrame = CreateFrame("Frame")
local tradeSkillFrameHooked = false
tradeSkillShowFrame:RegisterEvent("TRADE_SKILL_SHOW")
tradeSkillShowFrame:SetScript("OnEvent", function(self, event, ...)
  if not tradeSkillFrameHooked then
    hooksecurefunc(TradeSkillFrame, "Show", frameCheck)
    hooksecurefunc(TradeSkillFrame, "Hide", frameCheck)
    TradeSkillFrame:Show()
    tradeSkillFrameHooked = true
  end
end)

-- ArchaeologyFrame and PlayerTalentFrame are not existing until opened for the first time...
local addonLoadedFrame = CreateFrame("Frame")
local archaeologyFrameHooked = false
local playerTalentFrameHooked = false
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:SetScript("OnEvent", function(self, event, arg1, ...)
  if arg1 == "Blizzard_ArchaeologyUI" and not archaeologyFrameHooked then
    hooksecurefunc(ArchaeologyFrame, "Show", frameCheck)
    hooksecurefunc(ArchaeologyFrame, "Hide", frameCheck)
    archaeologyFrameHooked = true
  elseif arg1 == "Blizzard_TalentUI" and not playerTalentFrameHooked then
    hooksecurefunc(PlayerTalentFrame, "Show", frameCheck)
    hooksecurefunc(PlayerTalentFrame, "Hide", frameCheck)
    playerTalentFrameHooked = true
  end
end)

-- ClassTrainerFrame is not existing until opened for the first time...
local trainerShowFrame = CreateFrame("Frame")
local classTrainerFrameHooked = false
trainerShowFrame:RegisterEvent("TRAINER_SHOW")
trainerShowFrame:SetScript("OnEvent", function(self, event, ...)
  if not classTrainerFrameHooked then
    hooksecurefunc(ClassTrainerFrame, "Show", frameCheck)
    hooksecurefunc(ClassTrainerFrame, "Hide", frameCheck)
    ClassTrainerFrame:Show()
    classTrainerFrameHooked = true
  end
end)