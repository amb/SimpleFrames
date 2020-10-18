-- print('Simple Frames load.')

MainMenuBarArtFrame.LeftEndCap:Hide();
MainMenuBarArtFrame.RightEndCap:Hide()

local function SFBigBars()
    function BiggerPlayerFrame(self)
        -- local barTexture = "Interface\\AddOns\\FrameXML\\UI-StatusBar";
        local barTexture = "Interface\\Addons\\SimpleFrames\\Assets\\UI-StatusBar";
        self.healthbar:SetStatusBarTexture(barTexture);
        self.healthbar.AnimatedLossBar:SetStatusBarTexture(barTexture);
        PlayerFrameMyHealPredictionBar:SetTexture(barTexture);
        PlayerFrameAlternateManaBar:SetStatusBarTexture(barTexture);
        PlayerFrameManaBar.FeedbackFrame.BarTexture:SetTexture(barTexture);
        PlayerFrameManaBar.FeedbackFrame.LossGlowTexture:SetTexture(barTexture);
        PlayerFrameManaBar.FeedbackFrame.GainGlowTexture:SetTexture(barTexture);
        PlayerFrameTexture:SetTexture("Interface\\Addons\\SimpleFrames\\Assets\\UI-TargetingFrame");

        self.name:Hide();
        self.name:ClearAllPoints();
        self.name:SetPoint("CENTER", PlayerFrame, "CENTER", 50.5, 36);
        self.healthbar:SetPoint("TOPLEFT", 106, -24);
        self.healthbar:SetHeight(26);
        self.healthbar.LeftText:ClearAllPoints();
        self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
        self.healthbar.RightText:ClearAllPoints();
        self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -5, 0);
        self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
        self.manabar:SetPoint("TOPLEFT", 106, -52);
        self.manabar:SetHeight(13);
        self.manabar.LeftText:ClearAllPoints();
        self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 8, 0);
        self.manabar.RightText:ClearAllPoints();
        self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", -5, 0);
        self.manabar.TextString:SetPoint("CENTER", self.manabar, "CENTER", 0, 0);
        self.manabar.FullPowerFrame.SpikeFrame.AlertSpikeStay:ClearAllPoints();
        self.manabar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetPoint("CENTER", self.manabar.FullPowerFrame, "RIGHT",
            -6, -3);
        self.manabar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetSize(30, 29);
        self.manabar.FullPowerFrame.PulseFrame:ClearAllPoints();
        self.manabar.FullPowerFrame.PulseFrame:SetPoint("CENTER", self.manabar.FullPowerFrame, "CENTER", -6, -2);
        self.manabar.FullPowerFrame.SpikeFrame.BigSpikeGlow:ClearAllPoints();
        self.manabar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetPoint("CENTER", self.manabar.FullPowerFrame, "RIGHT", 5,
            -4);
        self.manabar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetSize(30, 50);
    end
    hooksecurefunc("PlayerFrame_ToPlayerArt", BiggerPlayerFrame)

    hooksecurefunc("PlayerFrame_UpdateStatus", function()
        if IsResting("player") then
            PlayerStatusTexture:Hide()
            PlayerRestGlow:Hide()
            PlayerStatusGlow:Hide()
        elseif PlayerFrame.inCombat then
            PlayerStatusTexture:Hide()
            PlayerAttackGlow:Hide()
            PlayerStatusGlow:Hide()
        end
    end)

end

SFBigBars()

local tiledGrid

local function toggleGrid()
    if tiledGrid then
        tiledGrid:Hide()
        tiledGrid = nil
    else
        tiledGrid = CreateFrame('Frame', nil, UIParent)
        tiledGrid:SetAllPoints(UIParent)
        local w = GetScreenWidth() / 64
        local h = GetScreenHeight() / 36
        for i = 0, 64 do
            local t = tiledGrid:CreateTexture(nil, 'BACKGROUND')
            if i == 32 then
                t:SetColorTexture(1, 1, 0, 0.5)
            else
                t:SetColorTexture(1, 1, 1, 0.15)
            end
            t:SetPoint('TOPLEFT', tiledGrid, 'TOPLEFT', i * w - 1, 0)
            t:SetPoint('BOTTOMRIGHT', tiledGrid, 'BOTTOMLEFT', i * w + 1, 0)
        end
        for i = 0, 36 do
            local t = tiledGrid:CreateTexture(nil, 'BACKGROUND')
            if i == 18 then
                t:SetColorTexture(1, 1, 0, 0.5)
            else
                t:SetColorTexture(1, 1, 1, 0.15)
            end
            t:SetPoint('TOPLEFT', tiledGrid, 'TOPLEFT', 0, -i * h + 1)
            t:SetPoint('BOTTOMRIGHT', tiledGrid, 'TOPRIGHT', 0, -i * h - 1)
        end
    end
end

local function MFInner()
    if SimpleFramesXpos == nil then
        SimpleFramesXpos = 835;
    end

    if SimpleFramesYpos == nil then
        SimpleFramesYpos = 322;
    end

    if SimpleFramesScale == nil then
        SimpleFramesScale = 1.0
    end
    
    PlayerFrame:SetScale(SimpleFramesScale)
    TargetFrame:SetScale(SimpleFramesScale)
    FocusFrame:SetScale(SimpleFramesScale)    

    PlayerFrame:ClearAllPoints();
    PlayerFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", SimpleFramesXpos, SimpleFramesYpos);
    PlayerFrame:SetUserPlaced(true);
    -- PlayerFrame:SetSize(400, 70);

    TargetFrame:ClearAllPoints();
    TargetFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -SimpleFramesXpos, SimpleFramesYpos);
    TargetFrame:SetUserPlaced(true);
end

local function MFPosition(self, event)
    -- SFBigFrames();
    MFInner();
end

SLASH_SFRAMES1 = "/sframes";
SlashCmdList["SFRAMES"] = function(msg)
    print("Setup Simple Frames location.");
    local options = {}

    chunks = {}
    for substring in msg:gmatch("%S+") do
        table.insert(chunks, substring)
    end

    if #chunks == 0 then
        print("Current location:", SimpleFramesXpos, SimpleFramesYpos)
        print("/sframes 100 100 to set unitframe locations")
    end

    if #chunks == 2 then
        x = tonumber(chunks[1]);
        y = tonumber(chunks[2]);
        if x ~= nil and y ~= nil then
            SimpleFramesXpos = x;
            SimpleFramesYpos = y;
            print("Set locations to ", x, y)
        end
    end

    if #chunks == 1 then
        s = tonumber(chunks[1]);
        if s < 2 and s > 0.5 then
            SimpleFramesScale = s
            print("Scale set to", s)

            PlayerFrame:SetScale(SimpleFramesScale)
            TargetFrame:SetScale(SimpleFramesScale)
            FocusFrame:SetScale(SimpleFramesScale)
        end
    end

    MFInner();
end

local events = CreateFrame('Frame');
events:RegisterEvent('PLAYER_LOGIN');
events:SetScript('OnEvent', MFPosition);

-- Capture values from drag

local function GetScaledMouse(frame)
    local x, y = GetCursorPosition();
    local s = frame:GetEffectiveScale();
    x, y = x / s, y / s;
    return x, y
end

local initialX = 0;
local initialY = 0;

PlayerFrame:SetScript('OnDragStart', function()
    PlayerFrame:StartMoving()
    -- initialX, initialY = PlayerFrame:GetCenter()
    -- a, _, b, initialX, initialY = PlayerFrame:GetPoint();
    -- print(a, b)
    toggleGrid()
end)

-- PlayerFrame:SetScript('OnReceiveDrag', function()
--     _, _, _, x, y = PlayerFrame:GetPoint();
--     local p = PlayerFrame:GetParent()
--     local frameH = p:GetTop() - p:GetBottom()
--     local pframeH = PlayerFrame:GetTop() - PlayerFrame:GetBottom()
--     lx = x
--     ly = frameH + y - pframeH
--     TargetFrame:ClearAllPoints();
--     TargetFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -lx, ly);
--     TargetFrame:SetUserPlaced(true);
-- end)

PlayerFrame:SetScript('OnDragStop', function()
    a, _, b, x, y = PlayerFrame:GetPoint();
    -- print("Moved frame locations:", x - initialX, y - initialY, a, b)
    -- cx, cy = PlayerFrame:GetCenter()
    local p = PlayerFrame:GetParent()
    local s = PlayerFrame:GetEffectiveScale();
    local st = p:GetEffectiveScale();
    -- print(s, st)
    -- x, y = x * s, y * s;
    -- local frameW = (p:GetRight() - p:GetLeft())
    local frameH = p:GetTop() - p:GetBottom()
    local pframeH = PlayerFrame:GetTop() - PlayerFrame:GetBottom()
    -- print("Set new location:", x, frameH + y - pframeH)
    -- print("Set new location:", x - frameW / 2, frameH + y - pframeH - frameH / 2)
    SimpleFramesXpos = x
    SimpleFramesYpos = frameH * st / s - pframeH + y
    MFInner();
    -- SimpleFramesXpos = SimpleFramesXpos - x + initialX
    -- SimpleFramesYpos = SimpleFramesYpos - y + initialY
    PlayerFrame:StopMovingOrSizing();
    toggleGrid()
end)

-- Hide bags and micro buttons, show on mouse over

local function hideMicroButtons()
    MicroButtonAndBagsBar:Hide()
    CharacterMicroButton:Hide();
    SpellbookMicroButton:Hide();
    TalentMicroButton:Hide();
    AchievementMicroButton:Hide();
    QuestLogMicroButton:Hide();
    GuildMicroButton:Hide();
    LFDMicroButton:Hide();
    CollectionsMicroButton:Hide();
    EJMicroButton:Hide();
    StoreMicroButton:SetScript("OnShow", StoreMicroButton.Hide)
    StoreMicroButton:Hide()
    MainMenuMicroButton:Hide();
end

local function showMicroButtons()
    MicroButtonAndBagsBar:Show()
    CharacterMicroButton:Show();
    SpellbookMicroButton:Show();
    TalentMicroButton:Show();
    AchievementMicroButton:Show();
    QuestLogMicroButton:Show();
    GuildMicroButton:Show();
    LFDMicroButton:Show();
    CollectionsMicroButton:Show();
    EJMicroButton:Show();
    StoreMicroButton:SetScript("OnShow", StoreMicroButton.Show)
    StoreMicroButton:Show()
    MainMenuMicroButton:Show();
end

function MouseIsOver(frame)
    local x, y = GetCursorPosition();
    local s = frame:GetEffectiveScale();
    x, y = x / s, y / s;
    return ((x >= frame:GetLeft()) and (x <= frame:GetRight()) and (y >= frame:GetBottom()) and (y <= frame:GetTop()));
end

hideMicroButtons()

local microButtonsMouseOver = CreateFrame("Frame", nil, UIParent)
microButtonsMouseOver:SetFrameStrata("BACKGROUND")
microButtonsMouseOver:SetWidth(310)
microButtonsMouseOver:SetHeight(105)

-- local t = microButtonsMouseOver:CreateTexture(nil, "BACKGROUND")
-- t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions.blp")
-- t:SetAllPoints(microButtonsMouseOver)
-- microButtonsMouseOver.texture = t

microButtonsMouseOver:SetPoint("BOTTOMRIGHT", 0, 0)
microButtonsMouseOver:Show()

microButtonsMouseOver:EnableMouse()
microButtonsMouseOver:SetScript('OnEnter', function()
    showMicroButtons()
end)
microButtonsMouseOver:SetScript('OnLeave', function()
    if not MouseIsOver(microButtonsMouseOver) then
        hideMicroButtons()
    end
end)
