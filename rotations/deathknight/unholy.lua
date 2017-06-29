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
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rDEATH KNIGHT |cffADFF2FUnholy|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Death and Decay', 'keybind(shift)', 'cursor.ground'},
}

local Survival = {

}

local Cooldowns = {

}

local AoE = {

}

local ST = {
	--Virulent Plague maintained at all times via Outbreak.
	{'Outbreak', '!target.debuff(Virulent Plague)'},
	--Death Coil with Sudden Doom procs.
	{'Death Coil', 'player.buff(Sudden Doom)'},
	--Scourge Strike to burst Festering Wound.
	{'Scourge Strike', 'target.debuff(Festering Wound)'},
	--Festering Strike to apply Festering Wound.
	{'Festering Strike', '!target.debuff(Festering Wound)'},
	--Death Coil to dump Runic Power.
	{'Death Coil'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>=3'},
	{ST, 'target.inMelee&target.inFront'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(252, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death Knight - Unholy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
