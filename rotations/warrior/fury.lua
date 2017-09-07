local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

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
	{type = 'checkspin',	text = 'Victory Rush below HP%',					key = 'vrush',				spin = 80, 	check = true},
	{type = 'checkspin',	text = 'Healthstone',											key = 'HS',						spin = 45, 	check = true},
	{type = 'checkspin',	text = 'Healing Potion',									key = 'AHP',					spin = 45, 	check = true},
	-- PvP
	{type = 'header', 		size = 16, text = 'PvP',									align = 'center'},
	{type = 'checkspin',	text = 'Death Wish Stacks (max)',					key = 'DWS',					spin = 5, 	max = 10, 	step = 1, 	check = true},
	{type = 'checkspin',	text = 'Death Wish HP% limit',						key = 'DWH',					spin = 5, 	max = 100, 	step = 5, 	check = true, desc = '|cffABD473Select how many stacks you want of \'Death Wish\', and the HP% limit you want to have on \'Death Wish\'!|r'},
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

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel', 'range<=5&inFront', 'target'},
	{'!Storm Bolt', 'inFront&range<30&talent(2,2)&!immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)', 'target'},
	{'!Arcane Torrent', 'range<=5&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)', 'target'},
	{'!Shockwave', 'inFront&range<=5&talent(2,1)&!immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)', 'target'},
}

local Interrupts_Random = {
	{'!Pummel', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<=5', 'enemies'},
	{'!Storm Bolt', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&inFront&range<21', 'enemies'},
	{'!Arcane Torrent', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&inFront&range<=5', 'enemies'},
	{'!Shockwave', 'interruptAt(75)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&inFront&range<11', 'enemies'},
}

local Survival = {
	{'Victory Rush', 'player.health<=UI(vrush_spin)&UI(vrush_check)', 'target'},
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<=UI(HS_spin)&UI(HS_check)', 'player'}, 			--Health Stone
}

local Cooldowns = {
	{'Battle Cry', '{spell(Odyn\'s Fury).cooldown<gcd&{spell(Bloodthirst).cooldown<gcd||{player.buff(Enrage).remains>spell(Bloodthirst).cooldown}}}'},
	{'Avatar', 'buff(Battle Cry)', 'player'},
	{'Bloodbath', 'player.buff(Dragon Roar)||{!talent(7,3)&{player.buff(Battle Cry)||spell(Battle Cry).cooldown>10}}', 'target'},
	{'Blood Fury', 'buff(Battle Cry)', 'player'},
	{'Berserking', 'buff(Battle Cry)', 'player'},
	{'#Trinket1', 'UI(trinket1)'},
	{'#Trinket2', 'UI(trinket2)'}
}

local Bladestorm = {
	{'Bladestorm', 'player.buff(Enrage).remains>2', 'target'}
}

local Ranged = {
	{'Storm Bolt', 'range<30', 'target'},
}

local AoE = {
	{'Bloodthirst', '!player.buff(Enrage)||player.rage<50', 'target'},
	{'Odyn\'s Fury', 'player.buff(Battle Cry)&player.buff(Enrage)', 'target'},
	{Bladestorm},
	{'Whirlwind', 'player.buff(Enrage)', 'target'},
	{'Dragon Roar', 'talent(7,3)', 'target'},
	{'Rampage', 'buff(Meat Cleaver)', 'player'},
	{'Bloodthirst', nil, 'target'},
	{'Whirlwind', nil, 'target'},
	{'Shockwave', '!immune(stun)&player.area(10).enemies.inFront>2', 'target'},
}

local ST = {
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury).stack<2', 'target'},
	{'Execute', '{!player.buff(Juggernaut)||player.buff(Juggernaut).remains<2}}||player.buff(Stone Heart)', 'target'},
	{'Rampage', 'player.rage>=100&{target.health>20||{target.health<20&!talent(5,1)}||{player.buff(Massacre)&player.buff(Enrage).remains<gcd}}'},
	{'Berserker Rage', 'talent(3,2)&spell(Odyn\'s Fury).cooldown<gcd&!buff(Enrage)', 'player'},
	{'Dragon Roar', 'player.spell(Odyn\'s Fury).cooldown>20||player.spell(Odyn\'s Fury).cooldown<3', 'target'},
	{'Odyn\'s Fury', 'player.buff(Battle Cry)&player.buff(Enrage)', 'target'},
	{'Rampage', '!player.buff(Enrage)&!player.buff(Juggernaut)', 'target'},
	{'Furious Slash', 'talent(6,2)&{!player.buff(Frenzy)||player.buff(Frenzy).stack<4}', 'target'},
	{'Raging Blow', '!player.buff(Juggernaut)&player.buff(Enrage)&!player.buff(Battle Trance)', 'target'},
	{'Whirlwind', 'talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)', 'target'},
	{'Execute', 'talent(6,3)||{!talent(6,3)&player.rage>50}', 'target'},
	{'Bloodthirst', '!buff(Enrage)', 'player'},
	{'Raging Blow', '!player.buff(Enrage)', 'target'},
	{'Execute', nil, 'target'},
	{'Raging Blow', nil, 'target'},
	{'Bloodthirst', nil, 'target'},
	{'Furious Slash', nil, 'target'},
	{Bladestorm},
	{'Bloodbath', 'player.buff(Frothing Berserker)||{player.rage>80&!talent(5,2)}', 'target'}
}

local TwoTargets = {
	{Bladestorm},
	{'Rampage', '!buff(Enrage)||{rage==100&!buff(Juggernaut)}||.buff(Massacre)', 'player'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', 'talent(6,3)', 'target'},
	{'Dragon Roar', nil, 'target'},
	{'Bloodthirst', nil, 'target'},
	{'Whirlwind', nil, 'target'}
}

local xPvP = {
	{'Gladiator\'s Medallion', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Adaptation', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Disarm', 'range<=5&inFront', 'target'},
	{'Spell Reflection', 'range<41&combat&alive&{interruptAt(80)||channeling.percent(5)}', 'enemies'},
	{'Death Wish', 'player.buff(Death Wish).count<UI(DWS)&player.health>=UI(DWH)', 'player'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, '{channeling.percent(5)||interruptAt(70)}&toggle(Interrupts)'},
	{Interrupts_Random},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)&target.range<=5'},
	{TwoTargets, 'player.area(8).enemies==2||player.area(8).enemies==3'},
	{AoE, 'player.area(8).enemies>3'},
	{ST, 'player.area(8).enemies<=3&target.range<=5&target.inFront'},
	{Ranged, '!target.inMelee&target.inFront'},
	{xPvP},
	{Fel_Explosives, 'range<=5'}
}

local outCombat = {
	{Keybinds},
	{Interrupts, '{channeling.percent(5)||interruptAt(70)}&toggle(Interrupts)'},
	{Interrupts_Random}
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
