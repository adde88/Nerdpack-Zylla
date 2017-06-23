local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']
local GUI = {
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Heroic Leap', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', align = 'center'},
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

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWarrior |cffADFF2FFury |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/2 - 5/2 - 6/3 - 7/2")
	print("|cffADFF2F --- |rLast Updated: 16.06.2017")
	print("|cffADFF2F ----------------------------------------------------------------------|r")

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel', 'target.inMelee&target.inFront'},
	{'!Storm Bolt', 'target.inFront&target.range<=20&talent(2,2)&!target.immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
	{'!Arcane Torrent', 'target.inMelee&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
	{'!Shockwave', 'target.inFront&target.inMelee&talent(2,1)&!target.immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
}

local Survival = {
	{'Victory Rush', 'player.health<=70'},
}

local Cooldowns = {
	{'Battle Cry', '{spell(Odyn\'s Fury).cooldown<gcd&{spell(Bloodthirst).cooldown<gcd||{player.buff(Enrage).remains>spell(Bloodthirst).cooldown}}}'},
	{'Avatar', 'talent(3,3)&player.buff(Battle Cry)'},
	{'Bloodbath', 'talent(6,1)&{player.buff(Dragon Roar)||{!talent(7,3)&{player.buff(Battle Cry)||spell(Battle Cry).cooldown>10}}}'},
	{'Blood Fury', 'player.buff(Battle Cry)'},
	{'Berserking', 'player.buff(Battle Cry)'},
}

local Bladestorm = {
	{'Bladestorm', 'talent(7,1)&player.buff(Enrage).remains>2'},
}

local Ranged = {
	{'Storm Bolt', 'talent(2,2)&target.range<=20'},
}

local AoE = {
	{'Bloodthirst', '!player.buff(Enrage)||player.rage<50'},
	{Bladestorm},
	{'Whirlwind', 'player.buff(Enrage)'},
	{'Dragon Roar', 'talent(7,3)'},
	{'Rampage', 'player.buff(Meat Cleaver)'},
	{'Bloodthirst'},
	{'Whirlwind'},
	{'Shockwave', 'talent(2,1)&!target.immune(stun)&player.area(6).enemies>=3&target.inMelee&target.inFront'},
}

local ST = {
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury)&player.buff(Fujieda\'s Fury).stack<2'},
	{'Execute', '{artifact(Juggernaut).enabled&{!player.buff(Juggernaut)||player.buff(Juggernaut).remains<2}}||player.buff(Stone Heart)'},
	{'Rampage', 'player.rage=100&{target.health>20||{target.health<20&!talent(5,1)}||{player.buff(Massacre)&player.buff(Enrage).remains<1}}'},
	{'Berserker Rage', 'talent(3,2)&spell(Odyn\'s Fury).cooldown<gcd&!player.buff(Enrage)'},
	{'Dragon Roar', '!spell(Odyn\'s Fury).cooldown<=10||spell(Odyn\'s Fury).cooldown<3'},
	{'Odyn\'s Fury', 'artifact(Odyn\'s Fury).equipped&player.buff(Battle Cry)&player.buff(Enrage)'},
	{'Rampage', '!player.buff(Enrage)&!player.buff(Juggernaut)'},
	{'Furious Slash', 'talent(6,2)&{!player.buff(Frenzy)||player.buff(Frenzy).stack<=3}'},
	{'Raging Blow', '!player.buff(Juggernaut)&player.buff(Enrage)'},
	{'Whirlwind', 'talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)'},
	{'Execute', 'talent(6,3)||{!talent(6,3)&player.rage>50}'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', '!player.buff(Enrage)'},
	{'Execute', 'artifact(Juggernaut).enabled'},
	{'Raging Blow'},
	{'Bloodthirst'},
	{'Furious Slash'},
	{Bladestorm},
	{'Bloodbath', 'talent(6,1)&{player.buff(Frothing Berserker)||{player.rage>80&!talent(5,2)}}'}
}

local TwoTargets = {
	{'Whirlwind', '!player.buff(Meat Cleaver)'},
	{Bladestorm},
	{'Rampage', '!player.buff(Enrage)||{player.rage=100&!player.buff(Juggernaut)}||player.buff(Massacre)'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', 'talent(6,3)&player.area(8).enemies=2'},
	{'Whirlwind', 'player.area(8).enemies>2'},
	{'Dragon Roar'},
	{'Bloodthirst'},
	{'Whirlwind'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(80)&toggle(Interrupts)'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)&target.inMelee'},
	{TwoTargets, 'player.area(8).enemies=2||player.area(8).enemies=3'},
	{AoE, 'player.area(8).enemies>3'},
	{ST, 'target.inMelee&target.inFront'},
	{Ranged, '!target.inMelee&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(80)&toggle(Interrupts)'},
}

NeP.CR:Add(72, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Fury',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
