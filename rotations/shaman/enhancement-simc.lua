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
	print('|cffADFF2F --- |rSHAMAN |cffADFF2FEnhancement (SimCraft) |r')
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
	{'Astral Shift', 'player.health<=40'},
	{'Feral Spirit', 'player.maelstrom>=20&player.spell(Crash Lightning).cooldown<=gcd'},
	{'Berserking', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<100'},
	{'Blood Fury', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<100'},
	{'Doom Winds'},
	{'Ascendance', 'player.buff(Stormbringer).react'},
}

local Interrupts = {
	{'!Wind Shear'},
}

local xCombat = {
	-- Crash Lightning
	{'Crash Lightning', 'lastgcd(Feral Spirit)', 'target'},
	{'Crash Lightning', 'talent(6,1)&player.area(10).enemies>=3&{!talent(4,3)||player.buff(Frostbrand).duration>gcd}', 'target'},
	{'Crash Lightning', 'player.buff(Crash Lightning).duration>gcd&player.area(10).enemies>=2', 'target'},
	{'Crash Lightning', 'player.area(10).enemies>=3', 'target'},
	{'Crash Lightning', '{{player.area(10).enemies>1||talent(6,1)||talent(7,2)}&!set_bonus(T19)==4}||player.buff(Feral Spirit).duration>5', 'target'},
  {'Crash Lightning', 'set_bonus(T20)==2&player.buff(Lightning Crash).duration<gcd', 'target'},
	-- Windstrike
	{'Windstrike', 'player.buff(Stormbringer).react&{{talent(6,2)&player.maelstrom>=26}||{!talent(6,2)}}', 'target'},
	{'Windstrike', 'talent(5,2)&player.spell(Lightning Bolt)<gcd&player.maelstrom>80', 'target'},
	{'Windstrike', 'talent(6,2)&player.maelstrom>46&{player.spell(Lightning Bolt)<gcd||!talent(5,2)}', 'target'},
	{'Windstrike', '!talent(5,2)&!talent(6,2)', 'target'},
	-- Stormstrike
	{'Stormstrike', 'player.buff(Stormbringer).react&{{talent(6,2)&player.maelstrom>=26}||{!talent(6,2)}}', 'target'},
	{'Stormstrike', 'talent(5,2)&player.spell(Lightning Bolt)<gcd&player.maelstrom>80', 'target'},
	{'Stormstrike', 'talent(6,2)&player.maelstrom>46&{player.spell(Lightning Bolt)<gcd||!talent(5,2)}', 'target'},
	{'Stormstrike', '!talent(5,2)&!talent(6,2)', 'target'},
	-- Frostbrand
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).duration<gcd&{{!talent(6,2)}||{talent(6,2)&player.maelstrom>25}}', 'target'},
	{'Frostbrand', 'talent(4,3)player.buff(Frostbrand).duration<4.8&{{!talent(6,2)}||{talent(6,2)&player.maelstrom>25}}', 'target'},
	{'Frostbrand', 'equipped(137084)&talent(1,2)&player.buff(Hot Hand).react&!player.buff(Frostbrand)&{{!talent(6,2)}||talent(6,2)&player.maelstrom>25}}', 'target'},
	{'Frostbrand', 'equipped(137084)&!player.buff(Frostbrand)&{{!talent(6,2)}||talent(6,2)&player.maelstrom>25}}', 'target'},
	--Lava Lash
	{'Lava Lash', 'talent(6,2)&talent(5,2)&{set_bonus(T19)==4&player.maelstrom>=80}', 'target'},
	{'Lava Lash', 'talent(6,2)&!talent(5,2)&{set_bonus(T19)==4&player.maelstrom>=53}', 'target'},
	{'Lava Lash', '{!set_bonus(T19)==4&player.maelstrom>=120}||{!talent(6,2)&set_bonus(T19)==4&player.maelstrom>=40}', 'target'},
	{'Lava Lash', 'talent(1,2)&player.buff(Hot Hand).react', 'target'},
	-- Flametongue
	{'Flametongue', 'player.buff(Flametongue).duration<gcd', 'target'},
	{'Flametongue', 'player.buff(Flametongue).remains<gcd||{player.spell(Doom Winds).cooldown<6&player.buff(Flametongue).duration<4}', 'target'},
	{'Flametongue', 'player.buff(Flametongue).duration<4.8', 'target'},
	-- Here comes the rest
	{'Windsong'},
	{'Fury of Air', 'toggle(AoE)&!player.buff(Fury of Air)&player.maelstrom>22'},
	{'Lightning Bolt', '{talent(5,2)&player.maelstrom>=40&!talent(6,2)}||{talent(5,2)&talent(6,2)player.maelstom>46}', 'target'},
	{'Earthen Spike', nil, 'target'},
	{'Sundering', 'toggle(AoE)&player.area(8).enemies.infront>=3', 'target'},
	{'Rockbiter', 'talent(1,3)&player.buff(Landslide).duration<gcd', 'target'},
}

local Ranged = {
	{'Lightning Bolt', nil, 'target'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<40'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'target.inMelee&target.inFront'},
	{Ranged, '!target.inMelee&target.range<41&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement (SimCraft)',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
