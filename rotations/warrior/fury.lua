local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Heroic Leap', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', 										align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', 										key = 'kPause', 		default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 										key = 'trinket1',		default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 										key = 'trinket2', 	default = true,	desc = '|cffABD473Trinkets will be used whenever possible!|r'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 		size = 16, text = 'Survival',							align = 'center'},
	{type = 'checkspin',	text = 'Healthstone',											key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',									key = 'AHP',					spin = 45, check = true},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarrior |cffADFF2FFury |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/2 - 5/2 - 6/3 - 7/2')
	print('|cffADFF2F --- |rLast Updated: 16.06.2017')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel', 'target.inMelee&target.inFront'},
	{'!Storm Bolt', 'target.inFront&target.range<30&talent(2,2)&!target.immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
	{'!Arcane Torrent', 'target.inMelee&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
	{'!Shockwave', 'target.inFront&target.inMelee&talent(2,1)&!target.immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
}

local Survival = {
	{'Victory Rush', 'player.health<80'},
	{'#127834', 'item(127834).usable&item(127834).count>0&player.health<=UI(AHP_spin)&UI(AHP_check)'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<=UI(HS_spin)&UI(HS_check)', 'player'}, 	--Health Stone
}

local Cooldowns = {
	{'Battle Cry', '{spell(Odyn\'s Fury).cooldown<gcd&{spell(Bloodthirst).cooldown<gcd||{player.buff(Enrage).remains>spell(Bloodthirst).cooldown}}}'},
	{'Avatar', 'talent(3,3)&player.buff(Battle Cry)'},
	{'Bloodbath', 'talent(6,1)&{player.buff(Dragon Roar)||{!talent(7,3)&{player.buff(Battle Cry)||spell(Battle Cry).cooldown>10}}}'},
	{'Blood Fury', 'player.buff(Battle Cry)'},
	{'Berserking', 'player.buff(Battle Cry)'},
	{'#Trinket1', 'UI(trinket1)'},
	{'#Trinket2', 'UI(trinket2)'},
}

local Bladestorm = {
	{'Bladestorm', 'talent(7,1)&player.buff(Enrage).remains>2'},
}

local Ranged = {
	{'Storm Bolt', 'talent(2,2)&target.range<30'},
}

local AoE = {
	{'Bloodthirst', '!player.buff(Enrage)||player.rage<50'},
	{Bladestorm},
	{'Whirlwind', 'player.buff(Enrage)'},
	{'Dragon Roar', 'talent(7,3)'},
	{'Rampage', 'player.buff(Meat Cleaver)'},
	{'Bloodthirst'},
	{'Whirlwind'},
	{'Shockwave', 'talent(2,1)&!target.immune(stun)&player.area(6).enemies>2&target.inMelee&target.inFront'},
}

local ST = {
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury)&player.buff(Fujieda\'s Fury).stack<2'},
	{'Execute', '{artifact(Juggernaut).enabled&{!player.buff(Juggernaut)||player.buff(Juggernaut).remains<2}}||player.buff(Stone Heart)'},
	{'Rampage', 'player.rage==100&{target.health>20||{target.health<20&!talent(5,1)}||{player.buff(Massacre)&player.buff(Enrage).remains<1}}'},
	{'Berserker Rage', 'talent(3,2)&spell(Odyn\'s Fury).cooldown<gcd&!player.buff(Enrage)'},
	{'Dragon Roar', '!spell(Odyn\'s Fury).cooldown<20||spell(Odyn\'s Fury).cooldown<3'},
	{'Odyn\'s Fury', 'artifact(Odyn\'s Fury).equipped&player.buff(Battle Cry)&player.buff(Enrage)'},
	{'Rampage', '!player.buff(Enrage)&!player.buff(Juggernaut)'},
	{'Furious Slash', 'talent(6,2)&{!player.buff(Frenzy)||player.buff(Frenzy).stack<4}'},
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
	{'Rampage', '!player.buff(Enrage)||{player.rage==100&!player.buff(Juggernaut)}||player.buff(Massacre)'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', 'talent(6,3)&player.area(8).enemies==2'},
	{'Whirlwind', 'player.area(8).enemies>2'},
	{'Dragon Roar'},
	{'Bloodthirst'},
	{'Whirlwind'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)&target.inMelee'},
	{TwoTargets, 'player.area(8).enemies==2||player.area(8).enemies==3'},
	{AoE, 'player.area(8).enemies>3'},
	{ST, 'target.inMelee&target.inFront'},
	{Ranged, '!target.inMelee&target.inFront'},
	{Fel_Explosives, 'range<=5'}
}

local outCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
}

NeP.CR:Add(72, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Fury',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
