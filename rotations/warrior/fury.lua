local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Mythic_Plus = _G.Mythic_Plus
local Logo_GUI = _G.Logo_GUI
local PayPal_GUI = _G.PayPal_GUI
local PayPal_IMG = _G.PayPal_IMG
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																	align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',							align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Heroic Leap|r',				align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																		key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(PayPal_GUI),
	{type = 'spacer'},
	unpack(PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings', 														align = 'center'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 														key = 'LJ',						spin = 4,	step = 1,	max = 20,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																				key = 'trinket1',			default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																				key = 'trinket2', 		default = true,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 		size = 16, text = 'Survival',																	align = 'center'},
	{type = 'checkspin',	text = 'Victory Rush below HP%',															key = 'vrush',				spin = 80, 	max = 100, step = 5, check = true, },
	{type = 'checkspin',	text = 'Enraged Regeneration',																key = 'en_rege',			spin = 45, 	max = 100, step = 5, check = true, },
	{type = 'checkspin',	text = 'Healthstone',																					key = 'HS',						spin = 45, 	max = 100, step = 5, check = true, },
	{type = 'checkspin',	text = 'Healing Potion',																			key = 'AHP',					spin = 45, 	max = 100, step = 5, check = true, },
	-- PvP
	{type = 'header', 		size = 16, text = 'PvP',																			align = 'center'},
	{type = 'checkspin',	text = 'Death Wish - Max Stacks',															key = 'DWS',					spin = 5, 	max = 10, 	step = 1, 	check = true},
	{type = 'checkspin',	text = 'Death Wish HP% limit',																key = 'DWH',					spin = 5, 	max = 100, 	step = 5, 	check = true, desc = Zylla.ClassColor..'Select how many stacks you want of \'Death Wish\', and the HP% limit you want to have on \'Death Wish\'!|r'},
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
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel', 'interruptAt(70)&inMelee&inFront', 'target'},
	{'!Storm Bolt', 'interruptAt(70)&inFront&range<30&talent(2,2)&!immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)', 'target'},
	{'!Arcane Torrent', 'interruptAt(70)&inMelee&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)', 'target'},
	{'!Shockwave', 'interruptAt(70)&inFront&inMelee&talent(2,1)&!immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)', 'target'},
}

local Interrupts_Random = {
	{'!Pummel', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&inMelee', 'enemies'},
	{'!Storm Bolt', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&inFront&range<21', 'enemies'},
	{'!Arcane Torrent', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&inFront&inMelee', 'enemies'},
	{'!Shockwave', 'interruptAt(75)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&inFront&range<11', 'enemies'},
}

local Survival = {
	{'Victory Rush', 'player.health<=UI(vrush_spin)&UI(vrush_check)', 'target'},
	{'Enraged Regeneration', 'player.health<=UI(en_rege)', 'player'},
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<=UI(HS_spin)&UI(HS_check)', 'player'}, 			--Health Stone
	{'Piercing Howl', 'player.area(15).enemies>4&count(Piercing Howl).enemies.debuffs==0'},
}

local Cooldowns = {
	{'Battle Cry', '{spell(Odyn\'s Fury).cooldown<gcd&{spell(Bloodthirst).cooldown<gcd||{player.buff(Enrage).remains>spell(Bloodthirst).cooldown}}}'},
	{'Avatar', 'buff(Battle Cry)', 'player'},
	{'Bloodbath', 'player.buff(Dragon Roar)||{!talent(7,3)&{player.buff(Battle Cry)||spell(Battle Cry).cooldown>10}}', 'target'},
	{'Blood Fury', 'buff(Battle Cry)', 'player'},
	{'Berserking', 'buff(Battle Cry)', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'}
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
	{'Blood Bath', nil, 'target'},
	{'Dragon Roar', 'talent(7,3)', 'target'},
	{'Rampage', 'buff(Meat Cleaver)', 'target'},
	{'Bloodthirst', nil, 'target'},
	{'Whirlwind', nil, 'target'},
	{'Shockwave', '!immune(stun)&player.area(10).enemies.inFront>2', 'target'},
}

local ST = {
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury).stack<2', 'target'},
	{'Execute', '{!player.buff(Juggernaut)||player.buff(Juggernaut).remains<2}}||player.buff(Stone Heart)', 'target'},
	{'Rampage', 'player.rage>=100&{health>20||{health<20&!talent(5,1)}||{player.buff(Massacre)&player.buff(Enrage).remains<gcd}}', 'target'},
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
	{'Blood Bath', nil, 'target'},
	{'Bloodthirst', nil, 'target'},
	{'Furious Slash', nil, 'target'},
	{Bladestorm},
	{'Bloodbath', 'player.buff(Frothing Berserker)||{player.rage>80&!talent(5,2)}', 'target'}
}

local TwoTargets = {
	{Bladestorm},
	{'Rampage', '!buff(Enrage)||{rage==100&!buff(Juggernaut)}||buff(Massacre)', 'target'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', 'talent(6,3)', 'target'},
	{'Blood Bath', nil, 'target'},
	{'Dragon Roar', nil, 'target'},
	{'Bloodthirst', nil, 'target'},
	{'Whirlwind', nil, 'target'}
}

local xPvP = {
	{'Gladiator\'s Medallion', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Adaptation', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Disarm', 'inMelee&inFront', 'target'},
	{'Spell Reflection', 'range<41&combat&alive&interruptAt(80)', 'enemies'},
	{'Death Wish', 'player.buff(Death Wish).count<UI(DWS)&player.health>=UI(DWH)', 'player'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)'},
	{Interrupts_Random},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)&inMelee'},
	{TwoTargets, 'player.area(8).enemies==2||player.area(8).enemies==3'},
	{AoE, 'player.area(8).enemies>3'},
	{ST, 'player.area(8).enemies<=3&inMelee&inFront'},
	{Ranged, '!inMelee&inFront'},
	{xPvP},
	{Mythic_Plus, 'inMelee'}
}

local outCombat = {
	{Keybinds},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)'},
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
