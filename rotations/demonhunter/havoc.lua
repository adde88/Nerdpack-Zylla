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

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDemon Hunter |cffADFF2FHavoc|r')
	print('|cffADFF2F --- |rRecommended Talents: Not ready yet.')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')
end

local Survival = {
	{'Blur', 'player.health<70'}
}

local Interrupts = {
	{'!Consume Magic'}
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Cooldowns = {
	{'Metamorphosis', nil, 'target.ground'}
}

local xCombat = {
	{'Vengeful Retreat', 'target.range<7&player.spell(Fel Rush).charges>1&player.fury<95'},
	{'Fel Rush', 'player.spell(Fel Rush).charges>1', 'target.range>5'},
	{'Blade Dance', 'toggle(AoE)&player.area(8).enemies>3'},
	{'Chaos Strike', 'player.fury>60'},
	{'Demon\'s Bite'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(70)'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'target.inMelee&target.inFront'},
}

local outCombat = {
	{Keybinds}
}

NeP.CR:Add(577, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Havoc',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
