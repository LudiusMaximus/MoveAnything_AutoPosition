


-- MerchantFrame_Type means "MerchantFrame, MailFrame, TradeFrame, InspectFrame or ClassTrainerFrame".
-- TradeSkillFrame_Type means "TradeSkillFrame, ArchaeologyFrame or PlayerTalentFrame".

local function frameCheck(f, ...)

  -- if f:IsVisible() then
    -- print("Opening", f:GetName())
  -- else
    -- print("Closing", f:GetName())
  -- end

  -- Reset to defaults. I.e. align CharacterFrame, MailFrame, ClassTrainerFrame,
  -- DressUpFrame and SpellBookFrame according to MerchantFrame.
  local opt = MovAny:GetUserData(CharacterFrame:GetName(), nil, true)
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
  MovAny.Position:Apply(opt, CharacterFrame)

  opt = MovAny:GetUserData(MailFrame:GetName(), nil, true)
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
  MovAny.Position:Apply(opt, MailFrame)

  opt = MovAny:GetUserData(TradeFrame:GetName(), nil, true)
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
  MovAny.Position:Apply(opt, TradeFrame)

  if InspectFrame then
    opt = MovAny:GetUserData(InspectFrame:GetName(), nil, true)
    opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 0, 0}
    MovAny.Position:Apply(opt, InspectFrame)
  end

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
  opt.pos = {"TOPLEFT", "MerchantFrame", "TOPLEFT", 58, 36}
  MovAny.Position:Apply(opt, SpellBookFrame)



  -- Remember for later.
  local openingTradeSkillFrameType = nil
  local visibleMerchantFrameType = nil

  -- Remember for later.
  local rightmostFrame = nil


  -- If any but these frames is opened, hide the AuctionHouseFrame.
  if f:IsVisible()
     and not (AuctionHouseFrame and f == AuctionHouseFrame)
     and not (DressUpFrame and f == DressUpFrame)
     and not (CharacterFrame and f == CharacterFrame)
     and not (PaperDollFrame and f == PaperDollFrame)
     and AuctionHouseFrame and AuctionHouseFrame:IsVisible() then

    AuctionHouseFrame:Hide()
  end



  -- Make TradeSkillFrame_Type frames mutually exclusive.
  if f == TradeSkillFrame and TradeSkillFrame:IsVisible() then
    openingTradeSkillFrameType = TradeSkillFrame
    if ArchaeologyFrame and ArchaeologyFrame:IsVisible() then ArchaeologyFrame:Hide() end
    if PlayerTalentFrame and PlayerTalentFrame:IsVisible() then PlayerTalentFrame:Hide() end

  elseif f == ArchaeologyFrame and ArchaeologyFrame:IsVisible() then
    openingTradeSkillFrameType = ArchaeologyFrame
    if TradeSkillFrame and TradeSkillFrame:IsVisible() then TradeSkillFrame:Hide() end
    if PlayerTalentFrame and PlayerTalentFrame:IsVisible() then PlayerTalentFrame:Hide() end

  elseif f == PlayerTalentFrame and PlayerTalentFrame:IsVisible() then
    openingTradeSkillFrameType = PlayerTalentFrame
    if TradeSkillFrame and TradeSkillFrame:IsVisible() then TradeSkillFrame:Hide() end
    if ArchaeologyFrame and ArchaeologyFrame:IsVisible() then ArchaeologyFrame:Hide() end


  -- Make MerchantFrame_Type frames mutually exclusive.
  elseif f == MerchantFrame and MerchantFrame:IsVisible() then
    visibleMerchantFrameType = MerchantFrame

    if MailFrame and MailFrame:IsVisible() then MailFrame:Hide() end
    if TradeFrame and TradeFrame:IsVisible() then TradeFrame:Hide() end

    if ClassTrainerFrame and ClassTrainerFrame:IsVisible() then ClassTrainerFrame:Hide() end
    if InspectFrame and InspectFrame:IsVisible() then InspectFrame:Hide() end

  elseif f == MailFrame and MailFrame:IsVisible() then
    visibleMerchantFrameType = MailFrame

    if MerchantFrame and MerchantFrame:IsVisible() then MerchantFrame:Hide() end
    if TradeFrame and TradeFrame:IsVisible() then TradeFrame:Hide() end

    if ClassTrainerFrame and ClassTrainerFrame:IsVisible() then ClassTrainerFrame:Hide() end
    if InspectFrame and InspectFrame:IsVisible() then InspectFrame:Hide() end

  elseif f == TradeFrame and TradeFrame:IsVisible() then
    visibleMerchantFrameType = TradeFrame

    if MailFrame and MailFrame:IsVisible() then MailFrame:Hide() end
    if MerchantFrame and MerchantFrame:IsVisible() then MerchantFrame:Hide() end

    if ClassTrainerFrame and ClassTrainerFrame:IsVisible() then ClassTrainerFrame:Hide() end
    if InspectFrame and InspectFrame:IsVisible() then InspectFrame:Hide() end

  elseif f == InspectFrame and InspectFrame:IsVisible() then
    visibleMerchantFrameType = InspectFrame

    if MailFrame and MailFrame:IsVisible() then MailFrame:Hide() end
    if MerchantFrame and MerchantFrame:IsVisible() then MerchantFrame:Hide() end
    if TradeFrame and TradeFrame:IsVisible() then TradeFrame:Hide() end

    if ClassTrainerFrame and ClassTrainerFrame:IsVisible() then ClassTrainerFrame:Hide() end

  elseif f == ClassTrainerFrame and ClassTrainerFrame:IsVisible() then
    visibleMerchantFrameType = ClassTrainerFrame

    if MailFrame and MailFrame:IsVisible() then MailFrame:Hide() end
    if MerchantFrame and MerchantFrame:IsVisible() then MerchantFrame:Hide() end
    if TradeFrame and TradeFrame:IsVisible() then TradeFrame:Hide() end

    if InspectFrame and InspectFrame:IsVisible() then InspectFrame:Hide() end


  elseif f == AuctionHouseFrame and AuctionHouseFrame:IsVisible() then

     -- Hide everything else!
    if ArchaeologyFrame and ArchaeologyFrame:IsVisible() then ArchaeologyFrame:Hide() end
    if PlayerTalentFrame and PlayerTalentFrame:IsVisible() then PlayerTalentFrame:Hide() end
    if TradeSkillFrame and TradeSkillFrame:IsVisible() then TradeSkillFrame:Hide() end

    if MailFrame and MailFrame:IsVisible() then MailFrame:Hide() end
    if MerchantFrame and MerchantFrame:IsVisible() then MerchantFrame:Hide() end
    if TradeFrame and TradeFrame:IsVisible() then TradeFrame:Hide() end

    if ClassTrainerFrame and ClassTrainerFrame:IsVisible() then ClassTrainerFrame:Hide() end
    if InspectFrame and InspectFrame:IsVisible() then InspectFrame:Hide() end

    if SpellBookFrame and SpellBookFrame:IsVisible() then SpellBookFrame:Hide() end

    opt = MovAny:GetUserData(AuctionHouseFrame:GetName(), nil, true)
    opt.pos = {"TOPLEFT", "SpellBookFrame", "TOPLEFT", 0, 0}
    MovAny.Position:Apply(opt, AuctionHouseFrame)

    rightmostFrame = AuctionHouseFrame


  end


  -- Check if a MerchantFrame_Type is visible.
  if not visibleMerchantFrameType then
    if MerchantFrame:IsVisible() then visibleMerchantFrameType = MerchantFrame
    elseif MailFrame:IsVisible() then visibleMerchantFrameType = MailFrame
    elseif TradeFrame:IsVisible() then visibleMerchantFrameType = TradeFrame
    elseif InspectFrame and InspectFrame:IsVisible() then visibleMerchantFrameType = InspectFrame
    elseif ClassTrainerFrame and ClassTrainerFrame:IsVisible() then visibleMerchantFrameType = ClassTrainerFrame
    end
  end









  -- If MerchantFrame_Type or DressUpFrame are visible, also make
  -- SpellBookFrame mutually exclusive with TradeSkillFrame_Type.
  if visibleMerchantFrameType or DressUpFrame:IsVisible() then

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

    -- Otherwise it may be that SpellBookFrame is visible and we have to store it as rightmostFrame.
    elseif SpellBookFrame:IsVisible() then
      rightmostFrame = SpellBookFrame

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


  if AuctionHouseFrame and AuctionHouseFrame:IsVisible() then
    xOffsetDressUpFrame = AuctionHouseFrame:GetWidth() + 58 + 18
  end



  -- If MerchantFrame_Type is visible, everything is moved to the right of that MerchantFrame_Type.
  if visibleMerchantFrameType then

    -- print("MerchantFrame_Type")

    if CharacterFrame:IsVisible() then
      -- Move CharacterFrame to the right of MerchantFrame_Type.
      local opt = MovAny:GetUserData(CharacterFrame:GetName(), nil, true)
      opt.pos = {"TOPLEFT", visibleMerchantFrameType:GetName(), "TOPRIGHT", 18, 0}
      MovAny.Position:Apply(opt, CharacterFrame)
    end


    -- Move rightmostFrame next to MerchantFrame_Type.
    if rightmostFrame then

      -- Move DressUpFrame to the right of rightmostFrame.
      xOffsetDressUpFrame = visibleMerchantFrameType:GetWidth() + rightmostFrame:GetWidth() + 36
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
        opt.pos = {"TOPLEFT", "CharacterFrame", "TOPLEFT", 58, 36}
        xOffsetDressUpFrame = xOffsetDressUpFrame + 58
      else
        opt.pos = {"TOPLEFT", visibleMerchantFrameType:GetName(), "TOPRIGHT", 18, 36}
      end
      MovAny.Position:Apply(opt, rightmostFrame)

    else
      if CharacterFrame:IsVisible() then
        xOffsetDressUpFrame = visibleMerchantFrameType:GetWidth() + CharacterFrame:GetWidth() + 36
      else
        xOffsetDressUpFrame = visibleMerchantFrameType:GetWidth() + 18
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

-- Needed to react to resizing of CharacterFrame when switching tabs..
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

hooksecurefunc(TradeFrame, "Show", frameCheck)
hooksecurefunc(TradeFrame, "Hide", frameCheck)



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

-- ArchaeologyFrame, PlayerTalentFrame and InspectFrame are not existing until opened for the first time...
local addonLoadedFrame = CreateFrame("Frame")
local archaeologyFrameHooked = false
local playerTalentFrameHooked = false
local inspectFrameHooked = false
local auctionHouseFrameHooked = false
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:SetScript("OnEvent", function(self, event, arg1, ...)
  if not archaeologyFrameHooked and arg1 == "Blizzard_ArchaeologyUI" then
    hooksecurefunc(ArchaeologyFrame, "Show", frameCheck)
    hooksecurefunc(ArchaeologyFrame, "Hide", frameCheck)
    archaeologyFrameHooked = true
  elseif not playerTalentFrameHooked and arg1 == "Blizzard_TalentUI" then
    hooksecurefunc(PlayerTalentFrame, "Show", frameCheck)
    hooksecurefunc(PlayerTalentFrame, "Hide", frameCheck)
    playerTalentFrameHooked = true
  elseif not inspectFrameHooked and arg1 == "Blizzard_InspectUI" then
    hooksecurefunc(InspectFrame, "Show", frameCheck)
    hooksecurefunc(InspectFrame, "Hide", frameCheck)
    inspectFrameHooked = true
  elseif not inspectFrameHooked and arg1 == "Blizzard_AuctionHouseUI" then
    hooksecurefunc(AuctionHouseFrame, "Show", frameCheck)
    hooksecurefunc(AuctionHouseFrame, "Hide", frameCheck)
    auctionHouseFrameHooked = true
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