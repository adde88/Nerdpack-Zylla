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
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSHAMAN |cffADFF2FEnhancement |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/X - 3/X - 4/3 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'}
}

local PreCombat = {
	{'Healing Surge', '!moving&player.health<80', 'player'},
	{'Ghost Wolf', 'movingfor>1&!player.buff(Ghost Wolf)'},
}

local Survival = {
	{'!Healing Surge', 'player.health<80&player.maelstrom>10', 'player'},
}

local Cooldowns = {
	{'Astral Shift', 'player.health<40'},
}

local Interrupts = {
	{'!Wind Shear'},
}

local xCombat = {
	{'Windstrike', 'player.buff(Ascendance)||lastcast(Ascendance)'},
	{'Feral Spirit', 'toggle(Cooldowns)'},
	{'Berserking', 'toggle(Cooldowns)&player.buff(Ascendance)||!talent(7,1)||player.level<100'},
	{'Blood Fury', 'toggle(Cooldowns)'},
	{'Crash Lightning', '{toggle(AoE)&{player.area(8).enemies>=2||player.buff(Lightning Crash).duration<gcd}}||{!toggle(AoE)&player.buff(Lightning Crash).duration<gcd}'},
	{'Crash Lightning', 'lastgcd(Feral Spirit)'},
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd&player.maelstrom<60&player.area(8).enemies>2'},
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd||{spell(Boulderfist).charges>1.75&player.maelstrom<200&player.area(8).enemies<3}'},
	{'Stormstrike', '!talent(4,3)&player.area(8).enemies>2'},
	{'Stormstrike', 'player.buff(Stormbringer)'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<gcd'},
	{'Flametongue', 'player.buff(Flametongue).remains<gcd'},
	{'Windsong'},
	{'Ascendance'},
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)'},
	{'Doom Winds', 'toggle(Cooldowns)'},
	{'Stormstrike'},
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>50'},
	{'Lava Lash', 'player.buff(Hot Hand)'},
	{'Earthen Spike'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<4.5'},
	{'Flametongue', 'player.buff(Flametongue).remains<4.8'},
	{'Sundering'},
	{'Lava Lash', 'player.maelstrom>39'},
	{'Rockbiter'},
	{'Flametongue'},
	{'Boulderfist'}
}

local Ranged = {
	{'Lightning Bolt'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<40'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>2'},
	{xCombat, 'target.inMelee&target.inFront'},
	{Ranged, '!target.inMelee&target.range<50&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
