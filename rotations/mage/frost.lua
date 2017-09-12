local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Mythic_Plus = _G.Mythic_Plus
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	{type = 'header', 	size = 16, text = 'Keybinds', 																		align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: |cff69CCF0Pause|r', 													align = 'left', 	key = 'kPause',	default = true,},
	{type = 'checkbox', text = 'Left Ctrl: |cff69CCF0Blizzard|r', 												align = 'left', 	key = 'lctrl',	default = true, desc = '|cffFF7D0AThis spell will be placed at your cursors ground location.|r'},
	{type = 'checkbox', text = 'Left Alt: |cff69CCF0Frost Nova|r', 												align = 'left',		key = 'lalt',		default = true,},
	{type = 'ruler'},		{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																align = 'center'},
	{type = 'checkbox',	text = 'Use Timewarp',																						key = 'kTW', 			default = false},
	{type = 'checkbox',	text = 'Stop Casting Ray of Frost (Target in Melee range)',				key = 'RoFstop', 	default = true},
	{type = 'checkbox',	text = 'Polymorph (Backup Interrupt)',														key = 'Pol_Int',	default = false},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Blizzard + Arctic Gale - Units',													key = 'blizze',		spin = 2,	step = 1,	max = 20,	check = false,	desc = '|cff69CCF0How many units to hit with Blizzard + Arctic Gale.|r'},
	{type = 'checkspin',text = 'Blizzard (normal) - Units',																key = 'blizz',		spin = 3,	step = 1,	max = 20,	check = true,	desc = '|cff69CCF0How many units to hit with normal Blizzard.|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Comet Storm - Units',																			key = 'cstorm',		spin = 4,	step = 1,	max = 20,	check = true,	desc = '|cff69CCF0How many units to hit with Comet Storm.|r'},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Use Trinket #1', 																					key = 'trinket1',	default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																					key = 'trinket2', default = true,	desc = '|cff69CCF0Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 															key = 'LJ',				spin = 4,	step = 1,	max = 20,	check = true,	desc = '|cff69CCF0World Spell usable on Argus.|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 									key = 'kj', 			step = 1, spin = 4, max = 15, check = true, desc = '|cff69CCF0Legendary will be used only on selected amount of units!|r'},
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
	{'%pause', 'keybind(lshift)&UI(kPause)'},
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
	{'Rune of Power', '{!buff&{cooldown(Icy Veins).remains<cooldown(Rune of Power).cast_time}||{cooldown(Rune of Power).charges<1.9&cooldown(Icy Veins).remains>10}||player.buff(Icy Veins)||{target.time_to_die+5<cooldown(Rune of Power).charges*10}'},
	{'Icy Veins', '!player.buff(Icy Veins)'},
	{'Mirror Image'},
	{'Blood Fury'},
	{'Berserking'},
	{'#Trinket1', 'UI(trinket1)'},
	{'#Trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local xCombat = {
	{'Summon Water Elemental', '!talent(1,2)&{!pet.exists||!pet.alive}', 'player'},
	{'Blizzard', '!player.moving&{{UI(blizze_check)&talent(6,3)&area(10).enemies>=UI(blizze_spin})||{UI(blizz_check)!talent(6,3)&area(8).enemies>=UI(blizz)}}', 'target.ground'},
	{'Blizzard', '!player.moving&{{UI(blizze_check)||UI(blizz_check)}&player.buff(Potion of Deadly Grace)&!target.debuff(Water Jet)}', 'target.ground'}, --TODO: Remove??
	{'Ice Lance', '!player.buff(Fingers of Frost)&lastgcd(Flurry)'},
	{'Ice Lance', '{player.buff(Fingers of Frost).stack>0&player.spell(Icy Veins).cooldown>10}||player.buff(Fingers of Frost).stack>2', 'target'},
	{'!Ice Nova', 'debuff(Winter\'s Chill)', 'target'},
	{'Frostbolt', '{!player.moving||player.buff(Ice Floes)}&debuff(Water Jet).remains>action(Frostbolt).cast_time&player.buff(Fingers of Frost).stack<2', 'target'},
	{'Frostbolt', '!player.moving||player.buff(Ice Floes)', 'target'},
	{'&135029', 'pet.exists&player.lastgcd(Frostbolt)&player.buff(Fingers of Frost).stack<{2+artifact(Icy Hand).enabled}&!player.buff(Brain Freeze)', 'target'},
	{'Ray of Frost', '!player.moving&player.buff(Icy Veins)||{player.spell(Icy Veins).cooldown>action(Ray of Frost).cooldown&!player.buff(Rune of Power)}' ,'target'},
	{'Flurry', '{!player.moving||player.buff(Ice Floes)}&&player.buff(Brain Freeze)&!player.buff(Fingers of Frost)&!player.lastgcd(Flurry)', 'target'},
	{'Glacial Spike', '!player.moving||player.buff(Ice Floes)', 'target'},
	{'Frost Bomb', '!player.moving&target.debuff(Frost Bomb).remains<player.travel_time(Ice Lance)&player.buff(Fingers of Frost).stack>0', 'target'},
	{'Frozen Orb', nil, 'target'},
	{'Ice Nova', 'debuff(Winter\'s Chill).duration>gcd', 'target'},
	{'Comet Storm', 'UI(cstorm_check)&area(6).enemies>=UI(cstorm_spin)', 'target'},
	{'Ebonbolt', '{!player.moving||player.buff(Ice Floes)}&player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).enabled}', 'target'},
	{'Ice Barrier', '!buff&!buff(Rune of Power)', 'player'},
	{'Ice Floes', 'gcd.remains<0.2&player.movingfor>0.75&!lastgcd&!buff', 'player'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<41'},
	{Interrupts_Random},
	{Survival},
	{xCombat, 'target.range<41&target.inFront'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'range<41'},
	{Hero}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<41'},
	{Interrupts_Random}
}

NeP.CR:Add(64, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Frost',
--waitfor = true,
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
