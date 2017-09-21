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
	{type = 'header',  	size = 16, text = 'Keybinds',	 																		align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',								align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Blizzard|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Frost Nova|r',						align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',											align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																			key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(PayPal_GUI),
	{type = 'spacer'},
	unpack(PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																align = 'center'},
	{type = 'checkbox',	text = 'Use Timewarp',																						key = 'kTW', 			default = false},
	{type = 'checkbox',	text = 'Stop Casting Ray of Frost (Target in Melee range)',				key = 'RoFstop', 	default = true},
	{type = 'checkbox',	text = 'Polymorph (Backup Interrupt)',														key = 'Pol_Int',	default = false},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Blizzard + Arctic Gale - Units',													key = 'blizze',		min = 1,	spin = 2,	step = 1,	max = 20,	check = false,	desc = Zylla.ClassColor..'How many units to hit with Blizzard + Arctic Gale.|r'},
	{type = 'checkspin',text = 'Blizzard (normal) - Units',																key = 'blizz',		min = 1,	spin = 3,	step = 1,	max = 20,	check = true,		desc = Zylla.ClassColor..'How many units to hit with normal Blizzard.|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Comet Storm - Units',																			key = 'cstorm',		min = 1,	spin = 4,	step = 1,	max = 20,	check = true,		desc = Zylla.ClassColor..'How many units to hit with Comet Storm.|r'},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Use Trinket #1', 																					key = 'trinket1',	default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																					key = 'trinket2', default = true,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 															key = 'LJ',				min = 1,	spin = 4,	step = 1,	max = 20,	check = true,		desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 									key = 'kj', 			min = 1,	step = 1, spin = 4, max = 15, check = true, 	desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Survival
	{type = 'header',		size = 16, text = 'Survival',									 	 									align = 'center'},
	{type = 'checkbox',	text = 'Ice Barrier',																							key = 'ibarr',		default = true},
	{type = 'checkspin',text = 'Healthstone',																							key = 'HS',				spin = 45, check = true},
	{type = 'checkspin',text = 'Healing Potion',																					key = 'AHP',			spin = 45, check = true},
	{type = 'checkspin',text = 'Ice Block', 																							key = 'ib'	, 		spin = 20, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Mythic_GUI),
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
	{'Summon Water Elemental', '!talent(1,2)&{!pet.exists||!pet.alive}', 'player'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'Blizzard', 'keybind(lcontrol)&UI(lctrl)', 'cursor.ground'},
	{'Frost Nova', 'keybind(lalt)&UI(lalt)'}
}

local Interrupts = {
	{'!Counterspell', 'interruptAt(70)', 'target'},
	{'!Ring of Frost', 'advanced&!player.moving&UI(RoF_Int)&interruptAt(5)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counterspell).cooldown>gcd&!lastgcd(Counterspell)&range<31', 'target.ground'},
	{'!Arcane Torrent', 'interruptAt(70)&inMelee&player.spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)', 'target'},
	{'!Polymorph', '!player.moving&UI(Pol_Int)&interruptAt(5)&player.spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&range<31', 'target'},
}

local Interrupts_Random = {
	{'!Counterspell', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<41', 'enemies'},
	{'!Ring of Frost', 'advanced&!player.moving&UI(RoF_Int)&interruptAt(5)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counterspell).cooldown>gcd&!lastgcd(Counterspell)&range<31', 'enemies.ground'},
	{'!Polymorph', '!player.moving&UI(Pol_Int)&interruptAt(5)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counterspell).cooldown>gcd&!lastgcd(Counterspell)&range<31', 'enemies'},
}

local Survival = {
	{'Ice Barrier', 'UI(ibarr)&!buff', 'player'},
	{'Ice Block', 'UI(ib_check)&health<=UI(ib_spin)', 'player'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 													-- Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 																	-- Health Stone
}

local Hero = {
	{'Time Warp', 'UI(kTW)&!hashero', 'player'},
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
	{'Icy Veins', '!player.buff(Icy Veins)'},
	{'Mirror Image'},
	{'Blood Fury'},
	{'Berserking'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'#144259', 'UI(kj_check)&target.range<41&target.area(10).enemies>UI(kj_spin)&equipped(144259)'}, -- Kil'jaeden's Burning Wish / AoE Trinket
}

local Fillers = {
	{'Glacial Spike', nil, 'target'},
	{'Ice Nova', nil, 'target'},
}

local xCombat = {
	{'Ice Lance', '!player.buff(Fingers of Frost)&lastcast(Flurry)', 'target'},
	{'Blizzard', 'advanced&{{UI(blizze_check)||UI(blizz_check)}&player.buff(Potion of Deadly Grace)&!debuff(Water Jet)}', 'target.ground'},
	{'!Ice Nova', 'debuff(Winter\'s Chill)', 'target'},
	{'Frostbolt', 'debuff(Water Jet).remains>action(Frostbolt).cast_time&player.buff(Fingers of Frost).stack<2', 'target'},
	{'&Water Jet', 'pet.exists&petrange<46&!talent(1,2)&lastcast(Frostbolt)&player.buff(Fingers of Frost).stack<{2+artifact(Icy Hand).zenabled}&!player.buff(Brain Freeze)', 'target'},
	{'Ray of Frost', 'player.buff(Icy Veins)||{cooldown(Icy Veins).remains>action(Ray of Frost).cooldown&!player.buff(Rune of Power)}', 'target'},
	{'Flurry', 'player.buff(Brain Freeze)&!player.buff(Fingers of Frost)&!lastcast', 'target'},
	{'Frozen Touch', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).zenabled}', 'target'},
	{'Frost Bomb', 'debuff(Frost Bomb).remains<action(Ice Lance).travel_time&player.buff(Fingers of Frost).stack>0', 'target'},
	{'Ice Lance', '{player.buff(Fingers of Frost).stack>0&cooldown(Icy Veins).remains>10}||player.buff(Fingers of Frost).stack>2', 'target'},
	{'Frozen Orb', nil, 'target'},
	{'Frozen Orb',  'advanced&honortalent(6,1)', 'target.ground'},
	{'Comet Storm', 'range<41&combat&alive&infront&advanced&UI(cstorm_check)&area(6).enemies>=UI(cstorm_spin)', 'enemies.ground'},
	{'Blizzard', 'range<41&combat&alive&advanced&{{UI(blizze_check)&talent(6,3)&area(10).enemies>=UI(blizze_spin})||{UI(blizz_check)!talent(6,3)&area(8).enemies>=UI(blizz_spin)}}', 'enemies.ground'},
	{'Ebonbolt', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).zenabled}', 'target'},
	{'Ice Barrier', '!buff&!buff(Rune of Power)', 'player'},
	{'Ice Floes', 'gcd.remains<0.2&xmoving==1&!lastcast&!buff', 'player'},
	{'Summon Water Elemental', '!talent(1,2)&{!pet.exists||!pet.alive}', 'player'},
	{'Frostbolt', 'xmoving==0||player.buff(Ice Floes)', 'target'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<41'},
	{Interrupts_Random},
	{Survival},
	{xCombat, 'range<41&inFront'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'range<41'},
	{Hero},
	{Fillers, 'range<41&inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<41'},
	{Interrupts_Random}
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
	gui_st = {title='Zylla\'s Combat Routines', width='276', height='780', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
