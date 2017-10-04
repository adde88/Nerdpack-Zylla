local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																		align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',								align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Blizzard|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Frost Nova|r',						align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',											align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																			key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',																	key = 'kDBM', 		default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',					key = 'prepot', 	default = false},
	{type = 'combo',		default = '1',																										key = 'list', 		list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkbox',	text = 'Use Timewarp',																						key = 'kTW', 			default = false},
	{type = 'checkbox',	text = 'Stop Casting Ray of Frost (Target in Melee range)',				key = 'RoFstop', 	default = true},
	{type = 'checkbox',	text = 'Polymorph (Backup Interrupt)',														key = 'Pol_Int',	default = false},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Blizzard + Arctic Gale - Units',													key = 'blizze',		min = 1,	spin = 2,	step = 1,	max = 20,	check = false,	desc = Zylla.ClassColor..'How many units to hit with Blizzard + Arctic Gale.|r'},
	{type = 'checkspin',text = 'Blizzard (normal) - Units',																key = 'blizz',		min = 1,	spin = 3,	step = 1,	max = 20,	check = true,		desc = Zylla.ClassColor..'How many units to hit with normal Blizzard.|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Comet Storm - Units',																			key = 'cstorm',		min = 1,	spin = 4,	step = 1,	max = 20,	check = true,		desc = Zylla.ClassColor..'How many units to hit with Comet Storm.|r'},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Use Trinket #1', 																					key = 'trinket1',	default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																					key = 'trinket2', default = false,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 															key = 'LJ',				min = 1,	spin = 4,	step = 1,	max = 20,	check = true,		desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 									key = 'kj', 			align = 'left', width = 55, step = 1, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Survival
	{type = 'header',		size = 16, text = 'Survival',									 	 									align = 'center'},
	{type = 'checkbox',	text = 'Ice Barrier',																							key = 'ibarr',		default = true},
	{type = 'checkspin',text = 'Healthstone',																							key = 'HS',				spin = 45, check = true},
	{type = 'checkspin',text = 'Healing Potion',																					key = 'AHP',			spin = 45, check = true},
	{type = 'checkspin',text = 'Ice Block', 																							key = 'ib'	, 		spin = 20, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMage |cffADFF2FFrost |r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffC41F3BVersion: 1 - RoF+IN+CS|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/1 - 5/1 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffC41F3BVersion: 2 - BC+FT+TV |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/1 - 3/2 - 4/2 - 5/1 - 6/1 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
	{'Summon Water Elemental', '!talent(1,2)&{!pet.exists||!pet.alive}'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127847', 'item(127847).usable&item(127847).count>0&UI(prepot)&!buff(Flask of the Whispered Pact)'},	--XXX: Flask of the Whispered Pact
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'Blizzard', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
	{'Frost Nova', 'keybind(lalt)&UI(lalt)'}
}

local Interrupts = {
	{'!Counterspell'},
	{'!Ring of Frost', 'advanced&!player.moving&UI(RoF_Int)&interruptAt(5)&toggle(Interrupts)&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&range<31', 'target.ground'},
	{'!Ring of Frost', 'advanced&!player.moving&UI(RoF_Int)&interruptAt(5)&toggle(Interrupts)&toggle(xIntRandom)&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&range<31', 'enemies.ground'},
	{'!Arcane Torrent', 'inMelee&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)'},
	{'!Polymorph', '!player.moving&UI(Pol_Int)&interruptAt(5)&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&range<31'},
}

local Survival = {
	{'Ice Barrier', 'UI(ibarr)&!buff'},
	{'Ice Block', 'UI(ib_check)&health<=UI(ib_spin)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local RoF = {
	{'!/stopcasting', 'UI(RoFstop)&target.movingfor>0.75&target.inMelee'},	--XXX: Interrupt Ray of Frost Channeling
}

local xPvP = {
	{'Gladiator\'s Medallion', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Adaptation', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Temporal Shield'},
	{'Ice Form'}
}

local Cooldowns = {
	{'Rune of Power', '!buff&{{cooldown(Icy Veins).remains<cooldown.cast_time}||{cooldown.charges<1.9&cooldown(Icy Veins).remains>10}||buff(Icy Veins)||{target.ttd+5<cooldown.charges*10}}', 'player'},
	{'Icy Veins', '!buff', 'player'},
	{'Mirror Image'},
	{'Blood Fury'},
	{'Berserking'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)', 'target'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Fillers = {
	{'Glacial Spike'},
	{'Ice Nova'},
}

local xCombat = {
	{'Ice Lance', '!player.buff(Fingers of Frost)&player.lastcast(Flurry)'},
	{'Blizzard', 'advanced&{{UI(blizze_check)||UI(blizz_check)}&player.buff(Potion of Deadly Grace)&!debuff(Water Jet)}', 'target.ground'},
	{'!Ice Nova', 'debuff(Winter\'s Chill)'},
	{'Frostbolt', 'debuff(Water Jet).remains>action(Frostbolt).cast_time&player.buff(Fingers of Frost).stack<2'},
	{'&Water Jet', 'pet.exists&petrange<46&!talent(1,2)&player.lastcast(Frostbolt)&player.buff(Fingers of Frost).stack<{2+artifact(Icy Hand).zenabled}&!player.buff(Brain Freeze)'},
	{'Ray of Frost', 'player.buff(Icy Veins)||{cooldown(Icy Veins).remains>action(Ray of Frost).cooldown&!player.buff(Rune of Power)}'},
	{'Flurry', 'player.buff(Brain Freeze)&!player.buff(Fingers of Frost)&!player.lastcast(Flurry)'},
	{'Frozen Touch', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).zenabled}'},
	{'Frost Bomb', 'debuff(Frost Bomb).remains<action(Ice Lance).travel_time&player.buff(Fingers of Frost).stack>0'},
	{'Ice Lance', '{player.buff(Fingers of Frost).stack>0&cooldown(Icy Veins).remains>10}||player.buff(Fingers of Frost).stack>2'},
	{'Frozen Orb'},
	{'Frozen Orb',  'advanced&honortalent(6,1)', 'target.ground'},
	{'Comet Storm', 'range<41&combat&alive&infront&advanced&UI(cstorm_check)&area(6).enemies>=UI(cstorm_spin)', 'enemies.ground'},
	{'Blizzard', 'range<41&combat&alive&advanced&{{UI(blizze_check)&talent(6,3)&area(10).enemies>=UI(blizze_spin})||{UI(blizz_check)!talent(6,3)&area(8).enemies>=UI(blizz_spin)}}', 'enemies.ground'},
	{'Ebonbolt', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).zenabled}'},
	{'Ice Barrier', '!buff&!buff(Rune of Power)', 'player'},
	{'Ice Floes', 'gcd.remains<0.2&movingfor>0.75&!lastcast(Ice Floes)&!buff', 'player'},
	{'Summon Water Elemental', '!talent(1,2)&{!pet.exists||!pet.alive}', 'player'},
	{'Frostbolt', '!player.moving||player.buff(Ice Floes)'},
}

local inCombat = {
	{'Time Warp', 'UI(kTW)&!hashero', 'player'},
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&interruptAt(70)&inFront&range<41', 'target'},
	{Interrupts, 'toggle(Interrupts)&interruptAt(70)&inFront&range<41', 'enemies'},
	{Survival, nil, 'player'},
	{xCombat, 'range<41&inFront', 'target'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'range<41'},
	{Fillers, 'range<41&inFront', 'target'}
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
}

NeP.CR:Add(64, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Frost',
	pooling = true,
	ic = {
		{inCombat, '!player.casting(Summon Water Elemental)||!player.channeling(Ray of Frost)'},
		{RoF, 'player.channeling(Ray of Frost)'}
	},
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
