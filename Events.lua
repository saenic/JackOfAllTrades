local EM = EVENT_MANAGER
local name = JackOfAllTrades.name

local professionalUpkeep = {
	id = 1,
	index = 4
}

local meticulousDissasembly = {
	id = 83,
	index = 4
}


local masterGatherer = {
	id = 78,
	index = 4
}

local plentifulHarvest = {
	id = 81,
	index = 3
}

local treasureHunter = {
	id = 79,
	index = 4
}

local homemaker = {
	id = 91,
	index = 4
}

local reelTechinque = {
	id = 88,
	index = 4
}

local anglersInstinct = {
	id = 89,
	index = 3
}

local cutpursesArt = {
	id = 90,
	index = 4
}

local infamous = {
	id = 77,
	index = 4
}

local function OpenStore(e)
	if JackOfAllTrades.AddCPNodeToQueue(professionalUpkeep.id, professionalUpkeep.index) then
		JackOfAllTrades.SlotAllStarsInQueue()
	end
end

local function StartGathering()
	if JackOfAllTrades.AddCPNodeToQueue(masterGatherer.id, masterGatherer.index) or JackOfAllTrades.AddCPNodeToQueue(plentifulHarvest.id, plentifulHarvest.index) then
		JackOfAllTrades.SlotAllStarsInQueue()
	end
end

local function StartLooting()
	if JackOfAllTrades.AddCPNodeToQueue(homemaker.id, homemaker.index) then
		JackOfAllTrades.SlotAllStarsInQueue()
	end
end

local function StartOpeningChest()
	if JackOfAllTrades.AddCPNodeToQueue(treasureHunter.id, treasureHunter.index) then
		JackOfAllTrades.SlotAllStarsInQueue()
	end
end

local function StartPickpocketing()
	if JackOfAllTrades.AddCPNodeToQueue(cutpursesArt.id, cutpursesArt.index) then
		JackOfAllTrades.SlotAllStarsInQueue()
	end
end

local function OpenFence()
	if JackOfAllTrades.AddCPNodeToQueue(infamous.id, infamous.index) then
		JackOfAllTrades.SlotAllStarsInQueue()
	end
end

local function OpenCraftingStation()
	if JackOfAllTrades.AddCPNodeToQueue(meticulousDissasembly.id, meticulousDissasembly.index) then
		JackOfAllTrades.SlotAllStarsInQueue()
	end
end

-------------------------------------------------------------------------------------------------
-- When the player looks at something they can interact with, i.e. A crafting/ fishing node --
-------------------------------------------------------------------------------------------------
-- Pre Hook for whenever the player presses the interact key
local function OnInteractKeyPressed() 
	local interactText, mainText, looted, _, additionalInfo, _, _, _ = GetGameCameraInteractableActionInfo()
	-- FISHING
	if additionalInfo == ADDITIONAL_INTERACT_INFO_FISHING_NODE then StartFishing() return end
	-- LOOTING
	if (interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_SEARCH) or interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_STEALFROM)) and mainText ~= "Bookshelf" and not looted then
		StartLooting()
	end
	-- GATHERING
	if interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_COLLECT) or interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_CUT) or interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_MINE) or interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_HARVEST) or interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_LOOT) then 
		StartGathering() 
	-- TREASURE HUNTER
	elseif interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_UNLOCK) or (mainText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_CHEST) and interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_USE)) then 
		StartOpeningChest()
	-- PICKPOCKETTING
	elseif interactText == GetString(SI_JACK_OF_ALL_TRADES_INTERACT_PICKPOCKET) then 
		StartPickpocketing()
	end
end

-------------------------------------------------------------------------------------------------
-- Register for events, we only want to do so if the API version is high enough  --
-------------------------------------------------------------------------------------------------
EM:RegisterForEvent(name, EVENT_OPEN_STORE, OpenStore)
EM:RegisterForEvent(name, EVENT_CRAFTING_STATION_INTERACT, OpenCraftingStation)
EM:RegisterForEvent(name, EVENT_OPEN_FENCE, OpenFence)
