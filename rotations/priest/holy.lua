local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},	
} 

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |PRIEST |cffADFF2FHoly|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F --- |r")
	print("|cffADFF2F --- |rThis rotation does not work at the moment!|")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
end

local Keybinds = {

}

local Cooldowns = {

}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
}

local outCombat = {
	
}

NeP.CR:Add(256, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Priest - Holy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	 ids = Zylla.SpellIDs[Zylla.Class],
	load = exeOnLoad
})
