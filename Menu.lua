-------------------------------------------------------------------------------------------------
-- Utility Functions --
-------------------------------------------------------------------------------------------------
local function ConvertRGBToHex(r, g, b)
    return string.format("|c%.2x%.2x%.2x", zo_floor(r * 255), zo_floor(g * 255), zo_floor(b * 255))
end

local function ConvertHexToRGB(colourString)
    local r=tonumber(string.sub(colourString, 3, 4), 16) or 255
    local g=tonumber(string.sub(colourString, 5, 6), 16) or 255
    local b=tonumber(string.sub(colourString, 7, 8), 16) or 255
    return r/255, g/255, b/255
end

-------------------------------------------------------------------------------------------------
-- Lib Addon Menu Variables --
-------------------------------------------------------------------------------------------------
function JackOfAllTrades:InitMenu()
    local LAM = LibAddonMenu2
    -- If for whatever reason we can't find LAM then just don't initialize the menu 
    if LAM == nil then return end
    local panelName = "JackOfAllTradesSettings"
    local panelData = {
        type = "panel",
        name = "Jack of all Trades",
        displayName = string.format("%s%s|u5:0::Jack of all Trades|u", "|t32:32:esoui/art/champion/champion_points_stamina_icon-hud-32.dds|t", ""),
        author = string.format("%s@CyberOnEso|r", self.colours.author),
        --website = "https://www.esoui.com/forums/showthread.php?p=43242",
        version = self.version,
        slashCommand = "/jackofalltrades",
        registerForRefresh = true
    }

    local panel = LAM:RegisterAddonPanel(panelName, panelData)
    local optionsData = {
        {
            type = "header",
            name = SI_JACK_OF_ALL_TRADES_MENU_NOTIFICATIONS,
            width = "full"
        },
        {
            type = "description",
            text = SI_JACK_OF_ALL_TRADES_MENU_NOTIFICATIONS_DESCRIPTION_GLOBAL,
            width = "full"
        },
        {   
            type = "checkbox",
            name = SI_JACK_OF_ALL_TRADES_MENU_NOTIFICATIONS_GLOBAL,
            -- If all nodes are true, set to True, else false
            getFunc = function() 
                        for node, state in pairs(self.savedVariables.notification) do 
                            if self.savedVariables.notification[node] == false then 
                                return false 
                            end 
                        end 
                        return true
                    end,
            -- Set all nodes to this value
            setFunc = function(value)
                        for node, state in pairs(self.savedVariables.notification) do 
                            self.savedVariables.notification[node] = value
                        end 
                    end,
            width = "full"
        },
        {   
            type = "submenu",
            name = SI_JACK_OF_ALL_TRADES_MENU_NOTIFICATIONS_INDIVIDUAL,
            controls = {
                {
                    type = "custom",
                    name = "Riding",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Riding"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("giftedRider")),
                    getFunc = function() return self.savedVariables.notification.giftedRider end,
                    setFunc = function(value) self.savedVariables.notification.giftedRider = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("giftedRider"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("warMount")),
                    getFunc = function() return self.savedVariables.notification.warMount end,
                    setFunc = function(value) self.savedVariables.notification.warMount = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("warMount"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Crafting",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Crafting"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("masterGatherer")),
                    getFunc = function() return self.savedVariables.notification.masterGatherer end,
                    setFunc = function(value) self.savedVariables.notification.masterGatherer = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("masterGatherer"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("plentifulHarvest")),
                    getFunc = function() return self.savedVariables.notification.plentifulHarvest end,
                    setFunc = function(value) self.savedVariables.notification.plentifulHarvest = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("plentifulHarvest"), 1000),
                    width = "half"
                },
                {   
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("meticulousDisassembly")),
                    getFunc = function() return self.savedVariables.notification.meticulousDisassembly end,
                    setFunc = function(value) self.savedVariables.notification.meticulousDisassembly = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("meticulousDisassembly"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Looting",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Looting"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("treasureHunter")),
                    getFunc = function() return self.savedVariables.notification.treasureHunter end,
                    setFunc = function(value) self.savedVariables.notification.treasureHunter = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("treasureHunter"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("homemaker")),
                    getFunc = function() return self.savedVariables.notification.homemaker end,
                    setFunc = function(value) self.savedVariables.notification.homemaker = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("homemaker"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Fishing",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Fishing"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("reelTechnique")),
                    getFunc = function() return self.savedVariables.notification.reelTechnique end,
                    setFunc = function(value) self.savedVariables.notification.reelTechnique = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("reelTechnique"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("anglersInstincts")),
                    getFunc = function() return self.savedVariables.notification.anglersInstincts end,
                    setFunc = function(value) self.savedVariables.notification.anglersInstincts = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("anglersInstincts"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Thieving",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Thieving"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("infamous")),
                    getFunc = function() return self.savedVariables.notification.infamous end,
                    setFunc = function(value) self.savedVariables.notification.infamous = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("infamous"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("cutpursesArt")),
                    getFunc = function() return self.savedVariables.notification.cutpursesArt end,
                    setFunc = function(value) self.savedVariables.notification.cutpursesArt = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("cutpursesArt"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("shadowstrike")),
                    getFunc = function() return self.savedVariables.notification.shadowstrike end,
                    setFunc = function(value) self.savedVariables.notification.shadowstrike = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("shadowstrike"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("sustainingShadows")),
                    getFunc = function() return self.savedVariables.notification.sustainingShadows end,
                    setFunc = function(value) self.savedVariables.notification.sustainingShadows = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("sustainingShadows"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Miscellaneous",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Miscellaneous"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("professionalUpkeep")),
                    getFunc = function() return self.savedVariables.notification.professionalUpkeep end,
                    setFunc = function(value) self.savedVariables.notification.professionalUpkeep = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("professionalUpkeep"), 1000),
                    width = "half"
                },
            },
        },
        {
            type = "colorpicker",
            name = zo_strformat(SI_JACK_OF_ALL_TRADES_TEXT_COLOUR, GetString(SI_JACK_OF_ALL_TRADES_NOTIFICATION)), -- or string id or function returning a string
            getFunc = function()
                        return ConvertHexToRGB(self.savedVariables.colour.notifications)
                    end, -- (alpha is optional)
            setFunc = function(r,g,b) 
                        self.savedVariables.colour.notifications = ConvertRGBToHex(r, g, b)
                    end, -- (alpha is optional)
            disabled = function() 
                        for node, state in pairs(self.savedVariables.notification) do 
                            if self.savedVariables.notification[node] == true then 
                                return false 
                            end 
                        end 
                        return true
                    end
        },
        {
            type = "header",
            name = SI_JACK_OF_ALL_TRADES_WARNING,
            width = "full"
        },
    	{
    	    type = "description",
    	    text = SI_JACK_OF_ALL_TRADES_MENU_WARNING_DESCRIPTION,
            width = "full"
    	},
        {   
            type = "checkbox",
            name = "For all stars",
            -- If all nodes are true, set to True, else false
            getFunc = function() 
                        for node, state in pairs(self.savedVariables.warnings) do 
                            if self.savedVariables.warnings[node] == false then 
                                return false 
                            end 
                        end 
                        return true
                    end,
            -- Set all nodes to this value
            setFunc = function(value)
                        for node, state in pairs(self.savedVariables.warnings) do 
                            self.savedVariables.warnings[node] = value
                        end 
                    end,
            width = "full"
        },
        {   
            type = "submenu",
            name = "For certain stars",
            controls = {
                {
                    type = "custom",
                    name = "Riding",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Riding"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("giftedRider")),
                    getFunc = function() return self.savedVariables.warnings.giftedRider end,
                    setFunc = function(value) self.savedVariables.warnings.giftedRider = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("giftedRider"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("warMount")),
                    getFunc = function() return self.savedVariables.warnings.warMount end,
                    setFunc = function(value) self.savedVariables.warnings.warMount = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("warMount"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Crafting",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Crafting"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("masterGatherer")),
                    getFunc = function() return self.savedVariables.warnings.masterGatherer end,
                    setFunc = function(value) self.savedVariables.warnings.masterGatherer = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("masterGatherer"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("plentifulHarvest")),
                    getFunc = function() return self.savedVariables.warnings.plentifulHarvest end,
                    setFunc = function(value) self.savedVariables.warnings.plentifulHarvest = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("plentifulHarvest"), 1000),
                    width = "half"
                },
                {   
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("meticulousDisassembly")),
                    getFunc = function() return self.savedVariables.warnings.meticulousDisassembly end,
                    setFunc = function(value) self.savedVariables.warnings.meticulousDisassembly = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("meticulousDisassembly"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Looting",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Looting"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("treasureHunter")),
                    getFunc = function() return self.savedVariables.warnings.treasureHunter end,
                    setFunc = function(value) self.savedVariables.warnings.treasureHunter = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("treasureHunter"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("homemaker")),
                    getFunc = function() return self.savedVariables.warnings.homemaker end,
                    setFunc = function(value) self.savedVariables.warnings.homemaker = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("homemaker"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Fishing",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Fishing"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("reelTechnique")),
                    getFunc = function() return self.savedVariables.warnings.reelTechnique end,
                    setFunc = function(value) self.savedVariables.warnings.reelTechnique = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("reelTechnique"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("anglersInstincts")),
                    getFunc = function() return self.savedVariables.warnings.anglersInstincts end,
                    setFunc = function(value) self.savedVariables.warnings.anglersInstincts = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("anglersInstincts"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Thieving",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Thieving"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("infamous")),
                    getFunc = function() return self.savedVariables.warnings.infamous end,
                    setFunc = function(value) self.savedVariables.warnings.infamous = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("infamous"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("cutpursesArt")),
                    getFunc = function() return self.savedVariables.warnings.cutpursesArt end,
                    setFunc = function(value) self.savedVariables.warnings.cutpursesArt = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("cutpursesArt"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("shadowstrike")),
                    getFunc = function() return self.savedVariables.warnings.shadowstrike end,
                    setFunc = function(value) self.savedVariables.warnings.shadowstrike = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("shadowstrike"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("sustainingShadows")),
                    getFunc = function() return self.savedVariables.warnings.sustainingShadows end,
                    setFunc = function(value) self.savedVariables.warnings.sustainingShadows = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("sustainingShadows"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Miscellaneous",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Miscellaneous"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("professionalUpkeep")),
                    getFunc = function() return self.savedVariables.warnings.professionalUpkeep end,
                    setFunc = function(value) self.savedVariables.warnings.professionalUpkeep = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("professionalUpkeep"), 1000),
                    width = "half"
                },
            },
        },
        {
            type = "colorpicker",
            name = zo_strformat(SI_JACK_OF_ALL_TRADES_TEXT_COLOUR, GetString(SI_JACK_OF_ALL_TRADES_WARNING)), -- or string id or function returning a string
            getFunc = function()
                        return ConvertHexToRGB(self.savedVariables.colour.warnings)
                    end, -- (alpha is optional)
            setFunc = function(r,g,b) 
                        self.savedVariables.colour.warnings = ConvertRGBToHex(r, g, b)
                    end, -- (alpha is optional)
            disabled = function() 
                        for node, state in pairs(self.savedVariables.warnings) do 
                            if self.savedVariables.warnings[node] == true then 
                                return false 
                            end 
                        end 
                        return true
                    end
        },
        {
            type = "header",
            name = SI_JACK_OF_ALL_TRADES_MENU_TOGGLE,
            width = "full"
        },
        {
            type = "description",
            text = SI_JACK_OF_ALL_TRADES_MENU_TOGGLE_DESCRIPTION,
            width = "full"
        },
        {   
            type = "checkbox",
            name = SI_JACK_OF_ALL_TRADES_MENU_TOGGLE_GLOBAL,
            -- If all nodes are true, set to True, else false
            getFunc = function() 
                        for node, state in pairs(self.savedVariables.enable) do 
                            if self.savedVariables.enable[node] == false then 
                                return false 
                            end 
                        end 
                        return true
                    end,
            -- Set all nodes to this value
            setFunc = function(value)
                        for node, state in pairs(self.savedVariables.enable) do 
                            self.savedVariables.enable[node] = value
                        end 
                    end,
            width = "full"
        },
        {   
            type = "submenu",
            name = SI_JACK_OF_ALL_TRADES_MENU_TOGGLE_INDIVIDUAL,
            controls = {
                {
                    type = "custom",
                    name = "Riding",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Riding"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("giftedRider")),
                    getFunc = function() return self.savedVariables.enable.giftedRider end,
                    setFunc = function(value) self.savedVariables.enable.giftedRider = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("giftedRider"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("warMount")),
                    getFunc = function() return self.savedVariables.enable.warMount end,
                    setFunc = function(value) self.savedVariables.enable.warMount = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("warMount"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Crafting",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Crafting"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("masterGatherer")),
                    getFunc = function() return self.savedVariables.enable.masterGatherer end,
                    setFunc = function(value) self.savedVariables.enable.masterGatherer = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("masterGatherer"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("plentifulHarvest")),
                    getFunc = function() return self.savedVariables.enable.plentifulHarvest end,
                    setFunc = function(value) self.savedVariables.enable.plentifulHarvest = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("plentifulHarvest"), 1000),
                    width = "half"
                },
                {   
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("meticulousDisassembly")),
                    getFunc = function() return self.savedVariables.enable.meticulousDisassembly end,
                    setFunc = function(value) self.savedVariables.enable.meticulousDisassembly = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("meticulousDisassembly"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Looting",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Looting"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("treasureHunter")),
                    getFunc = function() return self.savedVariables.enable.treasureHunter end,
                    setFunc = function(value) self.savedVariables.enable.treasureHunter = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("treasureHunter"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("homemaker")),
                    getFunc = function() return self.savedVariables.enable.homemaker end,
                    setFunc = function(value) self.savedVariables.enable.homemaker = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("homemaker"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Fishing",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Fishing"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("reelTechnique")),
                    getFunc = function() return self.savedVariables.enable.reelTechnique end,
                    setFunc = function(value) self.savedVariables.enable.reelTechnique = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("reelTechnique"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("anglersInstincts")),
                    getFunc = function() return self.savedVariables.enable.anglersInstincts end,
                    setFunc = function(value) self.savedVariables.enable.anglersInstincts = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("anglersInstincts"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Thieving",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Thieving"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("infamous")),
                    getFunc = function() return self.savedVariables.enable.infamous end,
                    setFunc = function(value) self.savedVariables.enable.infamous = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("infamous"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("cutpursesArt")),
                    getFunc = function() return self.savedVariables.enable.cutpursesArt end,
                    setFunc = function(value) self.savedVariables.enable.cutpursesArt = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("cutpursesArt"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("shadowstrike")),
                    getFunc = function() return self.savedVariables.enable.shadowstrike end,
                    setFunc = function(value) self.savedVariables.enable.shadowstrike = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("shadowstrike"), 1000),
                    width = "half"
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("sustainingShadows")),
                    getFunc = function() return self.savedVariables.enable.sustainingShadows end,
                    setFunc = function(value) self.savedVariables.enable.sustainingShadows = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("sustainingShadows"), 1000),
                    width = "half"
                },
                {
                    type = "custom",
                    name = "Miscellaneous",
                    --reference = "MyAddonCustomControl", -- unique name for your control to use as reference (optional)
                    createFunc = function(customControl) 
                        local wm = WINDOW_MANAGER
                        customControl.header = wm:CreateControlFromVirtual(nil, customControl, "ZO_Options_SectionTitleLabel")
                        local header = customControl.header
                        --header:SetAnchor(TOPLEFT, divider, BOTTOMLEFT)
                        header:SetAnchor(TOPLEFT)
                        header:SetFont("ZoFontHeader2")
                        header:SetText(LAM.util.GetStringFromValue("Miscellaneous"))
                    end, -- function to call when this custom control was created (optional)
                    refreshFunc = function(customControl) end, -- function to call when panel/controls refresh (optional)
                    width = "full", -- or "half" (optional)
                    minHeight = function() return 18 end, --or number for the minimum height of this control. Default: 26 (optional)
                    maxHeight = function() return 18 end, --or number for the maximum height of this control. Default: 4 * minHeight (optional)
                },
                {
                    type = "checkbox",
                    name = GetChampionSkillName(self.GetSkillId("professionalUpkeep")),
                    getFunc = function() return self.savedVariables.enable.professionalUpkeep end,
                    setFunc = function(value) self.savedVariables.enable.professionalUpkeep = value end,
                    tooltip = GetChampionSkillDescription(self.GetSkillId("professionalUpkeep"), 1000),
                    width = "half"
                },
            },
        },
        {
            type = "header",
            name = SI_JACK_OF_ALL_TRADES_MENU_SKILL_INDEX,
            width = "full"
        },
        {
            type = "description",
            text = SI_JACK_OF_ALL_TRADES_MENU_SKILL_INDEX_DESCRIPTION,
            width = "full"
        },
        {
            type = "slider",
            name = zo_strformat(SI_JACK_OF_ALL_TRADES_MENU_SKILL_INDEX_SLIDER, GetString(SI_JACK_OF_ALL_TRADES_MENU_PRIMARY)),
            getFunc = function() return self.savedVariables.skillIndexToReplace[1] end,
            setFunc = function(value) 
                        self.savedVariables.skillIndexToReplace[1] = value 
                    end,
            min = 1,
            max = 4,
            step = 1, -- (optional)
            clampInput = true, -- boolean, if set to false the input won't clamp to min and max and allow any number instead (optional)
            clampFunction = function(value, min, max) 
                                if value ~= self.savedVariables.skillIndexToReplace[2] and value ~= self.savedVariables.skillIndexToReplace[3] then
                                    return math.max(math.min(value, max), min) 
                                else
                                    for i=1, 4 do
                                        if i ~= self.savedVariables.skillIndexToReplace[2] and i ~= self.savedVariables.skillIndexToReplace[3] then
                                            return i
                                        end
                                    end
                                end
                            end,  -- function that is called to clamp the value (optional)
            decimals = 0, -- when specified the input value is rounded to the specified number of decimals (optional)
            autoSelect = false, -- boolean, automatically select everything in the text input field when it gains focus (optional)
            readOnly = true, -- boolean, you can use the slider, but you can't insert a value manually (optional)
            tooltip = "Primary skills are: " .. JackOfAllTrades.GetStringOfSkillNames(1), -- or string id or function returning a string (optional)
            width = "full", -- or "half" (optional)
            default = 1, -- default value or function that returns the default value (optional)
        },
        {
            type = "slider",
            name = zo_strformat(SI_JACK_OF_ALL_TRADES_MENU_SKILL_INDEX_SLIDER, GetString(SI_JACK_OF_ALL_TRADES_MENU_SECONDARY)),
            getFunc = function() return self.savedVariables.skillIndexToReplace[2] end,
            setFunc = function(value) 
                        self.savedVariables.skillIndexToReplace[2] = value
                    end,
            min = 1,
            max = 4,
            step = 1, -- (optional)
            clampInput = true, -- boolean, if set to false the input won't clamp to min and max and allow any number instead (optional)
            clampFunction = function(value, min, max) 
                                if value ~= self.savedVariables.skillIndexToReplace[1] and value ~= self.savedVariables.skillIndexToReplace[3] then
                                    return math.max(math.min(value, max), min) 
                                else
                                    for i=1, 4 do
                                        if i ~= self.savedVariables.skillIndexToReplace[1] and i ~= self.savedVariables.skillIndexToReplace[3] then
                                            return i
                                        end
                                    end
                                end
                            end, -- function that is called to clamp the value (optional)
            decimals = 0, -- when specified the input value is rounded to the specified number of decimals (optional)
            autoSelect = false, -- boolean, automatically select everything in the text input field when it gains focus (optional)
            readOnly = true, -- boolean, you can use the slider, but you can't insert a value manually (optional)
            tooltip = "Secondary skills are: " .. JackOfAllTrades.GetStringOfSkillNames(2), -- or string id or function returning a string (optional)
            width = "full", -- or "half" (optional)
            default = 2, -- default value or function that returns the default value (optional)
        },
        {
            type = "slider",
            name = zo_strformat(SI_JACK_OF_ALL_TRADES_MENU_SKILL_INDEX_SLIDER, GetString(SI_JACK_OF_ALL_TRADES_MENU_TERTIARY)),
            getFunc = function() return self.savedVariables.skillIndexToReplace[3] end,
            setFunc = function(value) 
                        self.savedVariables.skillIndexToReplace[3] = value
                    end,
            min = 1,
            max = 4,
            step = 1, -- (optional)
            clampInput = true, -- boolean, if set to false the input won't clamp to min and max and allow any number instead (optional)
            clampFunction = function(value, min, max) 
                                if value ~= self.savedVariables.skillIndexToReplace[1] and value ~= self.savedVariables.skillIndexToReplace[2] then
                                    return math.max(math.min(value, max), min) 
                                else
                                    for i=1, 4 do
                                        if i ~= self.savedVariables.skillIndexToReplace[1] and i ~= self.savedVariables.skillIndexToReplace[2] then
                                            return i
                                        end
                                    end
                                end
                            end, -- function that is called to clamp the value (optional)
            decimals = 0, -- when specified the input value is rounded to the specified number of decimals (optional)
            autoSelect = false, -- boolean, automatically select everything in the text input field when it gains focus (optional)
            readOnly = true, -- boolean, you can use the slider, but you can't insert a value manually (optional)
            tooltip = "Tertiary skills are: " .. JackOfAllTrades.GetStringOfSkillNames(3), -- or string id or function returning a string (optional)
            width = "full", -- or "half" (optional)
            default = 2, -- default value or function that returns the default value (optional)
        },
        {
            type = "header",
            name = SI_JACK_OF_ALL_TRADES_DEBUG,
            width = "full"
        },
        {
            type = "checkbox",
            name = zo_strformat(SI_JACK_OF_ALL_TRADES_ENABLE_MODE, GetString(SI_JACK_OF_ALL_TRADES_DEBUG)),
            getFunc = function() return self.savedVariables.debug end,
            setFunc = function(value) self.savedVariables.debug = value end,
            width = "full"
        },
        {
        type = "button",
        name = SI_JACK_OF_ALL_TRADES_DEBUG_RESET, -- string id or function returning a string
        func = function() JackOfAllTrades.ResetSavedVariables() end,
        width = "half", -- or "half" (optional)
        },
        {
        type = "button",
        name = SI_JACK_OF_ALL_TRADES_DEBUG_RESET_SKILLS, -- string id or function returning a string
        func = function() 
                if self.savedVariables.oldSkill then 
                    for index, skill in pairs(self.savedVariables.oldSkill) do
                        self.savedVariables.oldSkill[index] = nil
                    end
                end
            end,
        width = "half", -- or "half" (optional
        }
    }
    
	LAM:RegisterOptionControls(panelName, optionsData)
end