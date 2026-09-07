-- Call Leader - Epic Battlegrounds Addon (Single File Version)
-- Version: 1.0.0 (WoW 12.1)
-- Compiled for testing

-- ============================================================================
-- CONSTANTS
-- ============================================================================

local CALL_LEADER = {
    VERSION = "1.0.0",
    NAME = "Call Leader",
    ADDON_PREFIX = "CL",
}

-- Battleground IDs
local EPIC_BATTLEGROUNDS = {
    AV = 30,
    IOC = 562,
    ASH = 998,
    WG = 1,
    SR = 1105,
}

local ZONE_NAMES = {
    [30] = "Alterac Valley",
    [562] = "Isle of Conquest",
    [998] = "Ashran",
    [1] = "Wintergrasp",
    [1105] = "Seething Shore",
}

-- ============================================================================
-- DEFAULTS & SETTINGS
-- ============================================================================

local DefaultSettings = {
    ui = {
        scale = 1.0,
        opacity = 1.0,
        posX = 0,
        posY = 0,
        width = 350,
        height = 500,
        frameStrata = "MEDIUM",
        fontName = "Fonts\\FRIZQT__.TTF",
        fontSize = 12,
        isMovable = true,
        isVisible = true,
    },
    battlegrounds = {
        [30] = { name = "Alterac Valley", enabled = true, callouts = {} },
        [562] = { name = "Isle of Conquest", enabled = true, callouts = {} },
        [998] = { name = "Ashran", enabled = true, callouts = {} },
        [1] = { name = "Wintergrasp", enabled = true, callouts = {} },
        [1105] = { name = "Seething Shore", enabled = true, callouts = {} },
    },
    features = {
        enableColorCustomization = true,
        enableCalloutReordering = true,
        enableCustomCallouts = true,
        enablePresets = true,
        enableNotifications = true,
        enableSpeech = false,
    },
    notifications = {
        enableChat = true,
        enableRaid = true,
        enableParty = true,
        enablePersonal = true,
        chatChannel = "RAID",
    },
}

local DefaultCallouts = {
    [30] = {  -- Alterac Valley
        {
            id = "av_1",
            name = "Defend Balinda",
            description = "Defend against Balinda push",
            type = "defense",
            color = { r = 1.00, g = 0.00, b = 0.00 },
            icon = 237540,
            enabled = true,
        },
        {
            id = "av_2",
            name = "Push Drek",
            description = "Attack Drek the Betrayer",
            type = "attack",
            color = { r = 0.00, g = 1.00, b = 0.00 },
            icon = 237539,
            enabled = true,
        },
        {
            id = "av_3",
            name = "Cap IB",
            description = "Capture Iceblood Garrison",
            type = "location",
            color = { r = 0.00, g = 0.80, b = 1.00 },
            icon = 237541,
            enabled = true,
        },
        {
            id = "av_4",
            name = "Defend Galv",
            description = "Defend Galv boss",
            type = "defense",
            color = { r = 1.00, g = 0.00, b = 0.00 },
            icon = 237540,
            enabled = true,
        },
        {
            id = "av_5",
            name = "Regroup South",
            description = "Regroup at southern base",
            type = "strategy",
            color = { r = 1.00, g = 0.80, b = 0.00 },
            icon = 237535,
            enabled = true,
        },
    },
    [562] = { -- Isle of Conquest
        {
            id = "ioc_1",
            name = "Cap Flag",
            description = "Capture the central flag",
            type = "attack",
            color = { r = 0.00, g = 1.00, b = 0.00 },
            icon = 237570,
            enabled = true,
        },
        {
            id = "ioc_2",
            name = "Defend Gate",
            description = "Defend the main gate",
            type = "defense",
            color = { r = 1.00, g = 0.00, b = 0.00 },
            icon = 237571,
            enabled = true,
        },
        {
            id = "ioc_3",
            name = "Use Siege",
            description = "Use siege weapons",
            type = "strategy",
            color = { r = 0.00, g = 0.80, b = 1.00 },
            icon = 237572,
            enabled = true,
        },
        {
            id = "ioc_4",
            name = "Hold Workshop",
            description = "Hold the workshop",
            type = "location",
            color = { r = 0.00, g = 0.80, b = 1.00 },
            icon = 237573,
            enabled = true,
        },
    },
    [998] = { -- Ashran
        {
            id = "ash_1",
            name = "Defend Portal",
            description = "Defend the faction portal",
            type = "defense",
            color = { r = 1.00, g = 0.00, b = 0.00 },
            icon = 237600,
            enabled = true,
        },
        {
            id = "ash_2",
            name = "Push Center",
            description = "Push to center arena",
            type = "attack",
            color = { r = 0.00, g = 1.00, b = 0.00 },
            icon = 237601,
            enabled = true,
        },
        {
            id = "ash_3",
            name = "Cap Tower",
            description = "Capture tower objective",
            type = "location",
            color = { r = 0.00, g = 0.80, b = 1.00 },
            icon = 237602,
            enabled = true,
        },
    },
    [1] = { -- Wintergrasp
        {
            id = "wg_1",
            name = "Defend Fortress",
            description = "Defend the fortress",
            type = "defense",
            color = { r = 1.00, g = 0.00, b = 0.00 },
            icon = 237630,
            enabled = true,
        },
        {
            id = "wg_2",
            name = "Attack Fortress",
            description = "Attack the fortress",
            type = "attack",
            color = { r = 0.00, g = 1.00, b = 0.00 },
            icon = 237631,
            enabled = true,
        },
        {
            id = "wg_3",
            name = "Hold Towers",
            description = "Hold outer towers",
            type = "location",
            color = { r = 0.00, g = 0.80, b = 1.00 },
            icon = 237632,
            enabled = true,
        },
    },
    [1105] = { -- Seething Shore
        {
            id = "sr_1",
            name = "Cap Ore",
            description = "Capture ore deposits",
            type = "attack",
            color = { r = 0.00, g = 1.00, b = 0.00 },
            icon = 237700,
            enabled = true,
        },
        {
            id = "sr_2",
            name = "Defend Ore",
            description = "Defend ore positions",
            type = "defense",
            color = { r = 1.00, g = 0.00, b = 0.00 },
            icon = 237701,
            enabled = true,
        },
        {
            id = "sr_3",
            name = "Group Mid",
            description = "Group at midfield",
            type = "strategy",
            color = { r = 1.00, g = 0.80, b = 0.00 },
            icon = 237702,
            enabled = true,
        },
    },
}

-- ============================================================================
-- MAIN ADDON OBJECT
-- ============================================================================

local CallLeader = {}
CallLeader.VERSION = CALL_LEADER.VERSION
CallLeader.NAME = CALL_LEADER.NAME
CallLeader.initialized = false
CallLeader.currentBG = nil

-- Initialize the addon
function CallLeader:Initialize()
    if self.initialized then return end
    
    -- Load or create saved variables
    if not CallLeaderDB then
        CallLeaderDB = {}
    end
    
    -- Merge defaults
    self:MergeDefaults()
    
    -- Register events
    self:RegisterEvents()
    
    self.initialized = true
    self:Print("Call Leader v" .. self.VERSION .. " initialized successfully!")
end

-- Merge default settings with saved database
function CallLeader:MergeDefaults()
    -- UI Settings
    if not CallLeaderDB.ui then
        CallLeaderDB.ui = {}
    end
    for key, value in pairs(DefaultSettings.ui) do
        if CallLeaderDB.ui[key] == nil then
            CallLeaderDB.ui[key] = value
        end
    end
    
    -- Battleground Settings
    if not CallLeaderDB.battlegrounds then
        CallLeaderDB.battlegrounds = {}
    end
    for bgID, bgData in pairs(DefaultSettings.battlegrounds) do
        if not CallLeaderDB.battlegrounds[bgID] then
            CallLeaderDB.battlegrounds[bgID] = {}
        end
        for key, value in pairs(bgData) do
            if CallLeaderDB.battlegrounds[bgID][key] == nil then
                CallLeaderDB.battlegrounds[bgID][key] = value
            end
        end
    end
    
    -- Initialize callouts if empty
    for bgID, callouts in pairs(DefaultCallouts) do
        if not CallLeaderDB.battlegrounds[bgID].callouts or #CallLeaderDB.battlegrounds[bgID].callouts == 0 then
            CallLeaderDB.battlegrounds[bgID].callouts = {}
            for _, callout in ipairs(callouts) do
                table.insert(CallLeaderDB.battlegrounds[bgID].callouts, callout)
            end
        end
    end
    
    -- Features
    if not CallLeaderDB.features then
        CallLeaderDB.features = DefaultSettings.features
    end
    
    -- Notifications
    if not CallLeaderDB.notifications then
        CallLeaderDB.notifications = DefaultSettings.notifications
    end
end

-- Register addon events
function CallLeader:RegisterEvents()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    
    frame:SetScript("OnEvent", function(self, event, ...)
        CallLeader:OnEvent(event, ...)
    end)
    
    self.eventFrame = frame
end

-- Event handler
function CallLeader:OnEvent(event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "CallLeader" then
            self:Initialize()
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        self:OnEnteringWorld()
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        self:OnZoneChanged()
    end
end

function CallLeader:OnEnteringWorld()
    self:UpdateCurrentBattleground()
end

function CallLeader:OnZoneChanged()
    self:UpdateCurrentBattleground()
end

function CallLeader:UpdateCurrentBattleground()
    local bgID = GetCurrentMapAreaID()
    self.currentBG = bgID
    if EPIC_BATTLEGROUNDS[bgID] then
        self:Print("Entered " .. ZONE_NAMES[bgID] .. "!")
    end
end

function CallLeader:Print(message)
    print("|cff00ccff[Call Leader]|r " .. tostring(message))
end

function CallLeader:Debug(message)
    if CallLeaderDB.debug then
        self:Print("[DEBUG] " .. tostring(message))
    end
end

function CallLeader:GetCurrentBG()
    return self.currentBG
end

function CallLeader:GetBGName(bgID)
    return ZONE_NAMES[bgID] or "Unknown"
end

function CallLeader:IsInEpicBG()
    local bgID = self:GetCurrentBG()
    return EPIC_BATTLEGROUNDS[bgID] ~= nil
end

-- ============================================================================
-- MANAGERS
-- ============================================================================

local SettingsManager = {}

function SettingsManager:GetScale()
    return CallLeaderDB.ui.scale or 1.0
end

function SettingsManager:SetScale(scale)
    scale = math.max(0.5, math.min(2.0, scale))
    CallLeaderDB.ui.scale = scale
end

function SettingsManager:GetOpacity()
    return CallLeaderDB.ui.opacity or 1.0
end

function SettingsManager:SetOpacity(opacity)
    opacity = math.max(0.0, math.min(1.0, opacity))
    CallLeaderDB.ui.opacity = opacity
end

local CalloutManager = {}

function CalloutManager:GetCallouts(bgID)
    if not CallLeaderDB.battlegrounds[bgID] then
        return {}
    end
    return CallLeaderDB.battlegrounds[bgID].callouts or {}
end

function CalloutManager:AddCallout(bgID, callout)
    if not CallLeaderDB.battlegrounds[bgID] then
        CallLeaderDB.battlegrounds[bgID] = {}
    end
    if not CallLeaderDB.battlegrounds[bgID].callouts then
        CallLeaderDB.battlegrounds[bgID].callouts = {}
    end
    
    if not callout.id then
        callout.id = "custom_" .. GetTime()
    end
    
    table.insert(CallLeaderDB.battlegrounds[bgID].callouts, callout)
    return callout.id
end

function CalloutManager:RemoveCallout(bgID, calloutID)
    local callouts = self:GetCallouts(bgID)
    for i, callout in ipairs(callouts) do
        if callout.id == calloutID then
            table.remove(callouts, i)
            return true
        end
    end
    return false
end

function CalloutManager:MoveCalloutUp(bgID, calloutID)
    local callouts = self:GetCallouts(bgID)
    for i, callout in ipairs(callouts) do
        if callout.id == calloutID and i > 1 then
            callouts[i], callouts[i - 1] = callouts[i - 1], callouts[i]
            return true
        end
    end
    return false
end

function CalloutManager:MoveCalloutDown(bgID, calloutID)
    local callouts = self:GetCallouts(bgID)
    for i, callout in ipairs(callouts) do
        if callout.id == calloutID and i < #callouts then
            callouts[i], callouts[i + 1] = callouts[i + 1], callouts[i]
            return true
        end
    end
    return false
end

function CalloutManager:SetCalloutColor(bgID, calloutID, r, g, b)
    local callouts = self:GetCallouts(bgID)
    for _, callout in ipairs(callouts) do
        if callout.id == calloutID then
            callout.color = { r = r, g = g, b = b }
            return true
        end
    end
    return false
end

function CalloutManager:ToggleCallout(bgID, calloutID)
    local callouts = self:GetCallouts(bgID)
    for _, callout in ipairs(callouts) do
        if callout.id == calloutID then
            callout.enabled = not callout.enabled
            return true
        end
    end
    return false
end

function CalloutManager:GetEnabledCallouts(bgID)
    local callouts = self:GetCallouts(bgID)
    local enabled = {}
    for _, callout in ipairs(callouts) do
        if callout.enabled then
            table.insert(enabled, callout)
        end
    end
    return enabled
end

function CalloutManager:BroadcastCallout(callout)
    if not callout then return end
    
    local message = "|cff00ccff[" .. (callout.name or "Callout") .. "]|r " .. (callout.description or "")
    
    if IsInRaid() then
        SendChatMessage(message, "RAID")
    elseif IsInGroup() then
        SendChatMessage(message, "PARTY")
    else
        print(message)
    end
end

function CalloutManager:BroadcastAllCallouts(bgID)
    local callouts = self:GetEnabledCallouts(bgID)
    for _, callout in ipairs(callouts) do
        self:BroadcastCallout(callout)
    end
end

function CalloutManager:GetCallout(bgID, calloutID)
    local callouts = self:GetCallouts(bgID)
    for _, callout in ipairs(callouts) do
        if callout.id == calloutID then
            return callout
        end
    end
    return nil
end

local PresetManager = {}

function PresetManager:GetPreset(bgID)
    if not CallLeaderDB.presets then
        CallLeaderDB.presets = {}
    end
    return CallLeaderDB.presets[bgID]
end

function PresetManager:SavePreset(bgID, name, callouts)
    if not CallLeaderDB.presets then
        CallLeaderDB.presets = {}
    end
    
    CallLeaderDB.presets[bgID] = {
        name = name,
        bgID = bgID,
        callouts = callouts or {},
        savedAt = GetTime(),
    }
end

function PresetManager:ApplyPreset(bgID)
    local preset = self:GetPreset(bgID)
    if not preset then
        return false
    end
    
    if not CallLeaderDB.battlegrounds[bgID] then
        CallLeaderDB.battlegrounds[bgID] = {}
    end
    
    CallLeaderDB.battlegrounds[bgID].callouts = preset.callouts
    return true
end

function PresetManager:LoadDefaultPreset(bgID)
    if not DefaultCallouts[bgID] then
        return false
    end
    
    if not CallLeaderDB.battlegrounds[bgID] then
        CallLeaderDB.battlegrounds[bgID] = {}
    end
    
    CallLeaderDB.battlegrounds[bgID].callouts = {}
    for _, callout in ipairs(DefaultCallouts[bgID]) do
        table.insert(CallLeaderDB.battlegrounds[bgID].callouts, callout)
    end
    
    return true
end

function PresetManager:GetBGName(bgID)
    return ZONE_NAMES[bgID] or "Unknown"
end

-- ============================================================================
-- UI FRAME
-- ============================================================================

local MainFrame = {}

function MainFrame:Create()
    if MainFrame.frame then
        return MainFrame.frame
    end
    
    local frame = CreateFrame("Frame", "CallLeaderMainFrame", UIParent, "BackdropTemplate")
    frame:SetWidth(350)
    frame:SetHeight(500)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
    frame:SetBackdropBorderColor(0.0, 0.8, 1.0, 1.0)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    
    -- Title bar
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
    title:SetText("|cff00ccffCall Leader|r")
    frame.title = title
    
    -- Close button
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
    end)
    frame.closeBtn = closeBtn
    
    -- Tab buttons
    local tabs = {}
    local tabNames = {"Callouts", "Settings", "Presets"}
    
    for i, tabName in ipairs(tabNames) do
        local btn = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
        btn:SetSize(80, 25)
        btn:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + (i-1) * 85, -35)
        btn:SetText(tabName)
        btn:SetScript("OnClick", function()
            MainFrame:SwitchTab(i)
        end)
        tabs[i] = btn
    end
    frame.tabs = tabs
    frame.currentTab = 1
    
    -- Content area
    local content = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    content:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -65)
    content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)
    content:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 8,
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    content:SetBackdropColor(0.05, 0.05, 0.05, 0.8)
    content:SetBackdropBorderColor(0.0, 0.6, 0.8, 0.5)
    frame.content = content
    
    MainFrame.frame = frame
    MainFrame:PopulateCalloutTab()
    return frame
end

function MainFrame:PopulateCalloutTab()
    if not self.frame or not self.frame.content then return end
    
    local content = self.frame.content
    
    -- Clear existing children
    for _, child in ipairs({content:GetChildren()}) do
        child:Hide()
    end
    
    local bgID = CallLeader:GetCurrentBG()
    if not bgID then
        local text = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("CENTER", content, "CENTER", 0, 0)
        text:SetText("Enter a battleground to see callouts")
        return
    end
    
    local callouts = CalloutManager:GetCallouts(bgID)
    local yOffset = -10
    
    if #callouts == 0 then
        local text = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("TOPLEFT", content, "TOPLEFT", 10, yOffset)
        text:SetText("No callouts loaded")
        return
    end
    
    for i, callout in ipairs(callouts) do
        local btn = CreateFrame("Button", nil, content, "BackdropTemplate")
        btn:SetWidth(300)
        btn:SetHeight(35)
        btn:SetPoint("TOPLEFT", content, "TOPLEFT", 5, yOffset)
        
        local r, g, b = callout.color.r, callout.color.g, callout.color.b
        btn:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileSize = 8,
            edgeSize = 8,
        })
        btn:SetBackdropColor(r * 0.3, g * 0.3, b * 0.3, 0.6)
        btn:SetBackdropBorderColor(r, g, b, 1.0)
        
        local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("LEFT", btn, "LEFT", 5, 5)
        text:SetText(callout.name or "Callout " .. i)
        
        local descText = btn:CreateFontString(nil, "OVERLAY", "GameFontSmall")
        descText:SetPoint("LEFT", btn, "LEFT", 5, -8)
        descText:SetText(callout.description or "")
        descText:SetTextColor(0.7, 0.7, 0.7)
        
        btn:SetScript("OnClick", function()
            CalloutManager:BroadcastCallout(callout)
            CallLeader:Print("Broadcasted: " .. callout.name)
        end)
        
        yOffset = yOffset - 40
    end
end

function MainFrame:PopulateSettingsTab()
    if not self.frame or not self.frame.content then return end
    
    local content = self.frame.content
    
    -- Clear existing children
    for _, child in ipairs({content:GetChildren()}) do
        child:Hide()
    end
    
    local y = -10
    
    -- Scale slider
    local scaleLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scaleLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    scaleLabel:SetText("UI Scale: " .. string.format("%.1f", SettingsManager:GetScale()))
    y = y - 20
    
    local scaleSlider = CreateFrame("Slider", nil, content, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    scaleSlider:SetMinMaxValues(0.5, 2.0)
    scaleSlider:SetValue(SettingsManager:GetScale())
    scaleSlider:SetValueStep(0.1)
    scaleSlider:SetObeyStepOnDrag(true)
    scaleSlider:SetWidth(200)
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        SettingsManager:SetScale(value)
        MainFrame.frame:SetScale(value)
        scaleLabel:SetText("UI Scale: " .. string.format("%.1f", value))
    end)
    y = y - 30
    
    -- Opacity slider
    local opacityLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    opacityLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    opacityLabel:SetText("Opacity: " .. string.format("%.0f%%", SettingsManager:GetOpacity() * 100))
    y = y - 20
    
    local opacitySlider = CreateFrame("Slider", nil, content, "OptionsSliderTemplate")
    opacitySlider:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    opacitySlider:SetMinMaxValues(0.0, 1.0)
    opacitySlider:SetValue(SettingsManager:GetOpacity())
    opacitySlider:SetValueStep(0.1)
    opacitySlider:SetObeyStepOnDrag(true)
    opacitySlider:SetWidth(200)
    opacitySlider:SetScript("OnValueChanged", function(self, value)
        SettingsManager:SetOpacity(value)
        MainFrame.frame:SetAlpha(value)
        opacityLabel:SetText("Opacity: " .. string.format("%.0f%%", value * 100))
    end)
    y = y - 30
    
    -- Feature toggles
    local featureLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    featureLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    featureLabel:SetText("Features:")
    y = y - 20
    
    local features = {
        "enableColorCustomization",
        "enableCalloutReordering",
        "enableCustomCallouts",
        "enablePresets",
    }
    
    for _, featureName in ipairs(features) do
        local checkbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
        checkbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
        local checkboxLabel = checkbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        checkboxLabel:SetPoint("LEFT", checkbox, "RIGHT", 5, 0)
        checkboxLabel:SetText(featureName:gsub("enable", ""):gsub("Customization", " Custom."):gsub("Reordering", " Order."):gsub("Callouts", " Custom."):gsub("Presets", " Presets"))
        
        checkbox:SetChecked(CallLeaderDB.features[featureName] or false)
        checkbox:SetScript("OnClick", function(self)
            CallLeaderDB.features[featureName] = self:GetChecked()
        end)
        y = y - 20
    end
end

function MainFrame:PopulatePresetsTab()
    if not self.frame or not self.frame.content then return end
    
    local content = self.frame.content
    
    -- Clear existing children
    for _, child in ipairs({content:GetChildren()}) do
        child:Hide()
    end
    
    local y = -10
    
    -- Load Default button
    local loadDefaultBtn = CreateFrame("Button", nil, content, "GameMenuButtonTemplate")
    loadDefaultBtn:SetSize(150, 25)
    loadDefaultBtn:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    loadDefaultBtn:SetText("Load Default")
    loadDefaultBtn:SetScript("OnClick", function()
        local bgID = CallLeader:GetCurrentBG()
        if bgID then
            PresetManager:LoadDefaultPreset(bgID)
            CallLeader:Print("Loaded default preset for " .. PresetManager:GetBGName(bgID))
            MainFrame:PopulateCalloutTab()
        else
            CallLeader:Print("Not in a battleground")
        end
    end)
    y = y - 35
    
    -- Save Preset button
    local savePresetBtn = CreateFrame("Button", nil, content, "GameMenuButtonTemplate")
    savePresetBtn:SetSize(150, 25)
    savePresetBtn:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    savePresetBtn:SetText("Save Preset")
    savePresetBtn:SetScript("OnClick", function()
        local bgID = CallLeader:GetCurrentBG()
        if bgID then
            local bgName = PresetManager:GetBGName(bgID)
            PresetManager:SavePreset(bgID, bgName, CallLeaderDB.battlegrounds[bgID].callouts)
            CallLeader:Print("Saved preset for " .. bgName)
        else
            CallLeader:Print("Not in a battleground")
        end
    end)
    y = y - 35
    
    -- Broadcast All button
    local broadcastBtn = CreateFrame("Button", nil, content, "GameMenuButtonTemplate")
    broadcastBtn:SetSize(150, 25)
    broadcastBtn:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    broadcastBtn:SetText("Broadcast All")
    broadcastBtn:SetScript("OnClick", function()
        local bgID = CallLeader:GetCurrentBG()
        if bgID then
            CalloutManager:BroadcastAllCallouts(bgID)
            CallLeader:Print("Broadcasted all callouts")
        else
            CallLeader:Print("Not in a battleground")
        end
    end)
    y = y - 35
    
    -- Info text
    local infoLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    infoLabel:SetText("Version: " .. CallLeader.VERSION)
    y = y - 20
    
    local bgInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bgInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 10, y)
    if CallLeader:GetCurrentBG() then
        bgInfo:SetText("BG: " .. PresetManager:GetBGName(CallLeader:GetCurrentBG()))
    else
        bgInfo:SetText("BG: None")
    end
end

function MainFrame:SwitchTab(tabIndex)
    if not self.frame then return end
    self.frame.currentTab = tabIndex
    
    if tabIndex == 1 then
        self:PopulateCalloutTab()
    elseif tabIndex == 2 then
        self:PopulateSettingsTab()
    elseif tabIndex == 3 then
        self:PopulatePresetsTab()
    end
end

function MainFrame:Toggle()
    if not MainFrame.frame then
        MainFrame:Create()
    end
    
    if MainFrame.frame:IsShown() then
        MainFrame.frame:Hide()
    else
        MainFrame.frame:Show()
        MainFrame:SwitchTab(1)
    end
end

-- ============================================================================
-- SLASH COMMANDS
-- ============================================================================

SLASH_CALLLEADER1 = "/callleader"
SLASH_CALLLEADER2 = "/cl"

SlashCmdList["CALLLEADER"] = function(msg)
    local cmd = strtrim(string.lower(msg))
    
    if cmd == "" or cmd == "toggle" then
        MainFrame:Toggle()
    elseif cmd == "show" then
        MainFrame.frame = MainFrame.frame or MainFrame:Create()
        MainFrame.frame:Show()
    elseif cmd == "hide" then
        if MainFrame.frame then
            MainFrame.frame:Hide()
        end
    elseif cmd == "reset" then
        CallLeaderDB = {}
        CallLeader:MergeDefaults()
        CallLeader:Print("Settings reset to defaults")
    elseif cmd == "broadcast" then
        local bgID = CallLeader:GetCurrentBG()
        if bgID then
            CalloutManager:BroadcastAllCallouts(bgID)
            CallLeader:Print("Broadcasted all callouts")
        else
            CallLeader:Print("Not in a battleground")
        end
    else
        CallLeader:Print("Usage: /cl [show|hide|toggle|reset|broadcast]")
    end
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" and addon == "CallLeader" then
        CallLeader:Initialize()
    end
end)

-- Make globals available
_G.CallLeader = CallLeader
_G.CallLeaderDB = CallLeaderDB
