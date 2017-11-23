local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																	align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',							align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Heroic Leap|r',				align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 																		key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																align = 'center'},
	{type = 'combo',		default = 'target',																							key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',															align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 									key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',				key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																									key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 														key = 'LJ',						spin = 4,	step = 1,	max = 20,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																				key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																				key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 								key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
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
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarrior |cffADFF2FFury |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/2 - 5/2 - 6/3 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127850', 'ingroup&item(127850).usable&item(127850).count>0&UI(prepot)&!buff(Flask of Ten Thousand Scars)'},														--XXX: Flask of Ten Thousand Scars
	{'#127849', 'item(127850).count==0&ingroup&item(127849).usable&item(127849).count>0&UI(prepot)&!buff(Flask of the Countless Armies)'},		--XXX: Flask of the Countless Armies (IF WE DON'T HAVE THOUSAND SCARS FLASKS)
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},																		--XXX: Lightforged Augment Rune
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel', 'inMelee&inFront'},
	{'!Storm Bolt', 'inFront&range<30&talent(2,2)&spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)'},
	{'!Arcane Torrent', 'inMelee&spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)'},
	{'!Shockwave', 'inFront&inMelee&talent(2,1)&spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)'},
}

local Survival = {
	{'Victory Rush', 'player.health<=UI(vrush_spin)&UI(vrush_check)'},
	{'Enraged Regeneration', 'player.health<=UI(en_rege)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
	{'Piercing Howl', 'player.area(15).enemies>4&count(Piercing Howl).enemies.debuffs==0'},
}

local Cooldowns = {
	{'Battle Cry', '{spell(Odyn\'s Fury).cooldown<gcd&{spell(Bloodthirst).cooldown<gcd||{player.buff(Enrage).remains>spell(Bloodthirst).cooldown}}}'},
	{'Avatar', 'buff(Battle Cry)', 'player'},
	{'Bloodbath', 'player.buff(Dragon Roar)||{!talent(7,3)&{player.buff(Battle Cry)||spell(Battle Cry).cooldown>10}}'},
	{'Blood Fury', 'buff(Battle Cry)', 'player'},
	{'Berserking', 'buff(Battle Cry)', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Bladestorm = {
	{'Bladestorm', 'player.buff(Enrage).remains>=3'}
}

local Ranged = {
	{'Storm Bolt', 'range<30'},
}

local AoE = {
	{'Bloodthirst', '!player.buff(Enrage)||player.rage<50'},
	{'Odyn\'s Fury', 'player.buff(Battle Cry)&player.buff(Enrage)'},
	{Bladestorm},
	{'Whirlwind', 'player.buff(Enrage)'},
	{'Blood Bath'},
	{'Dragon Roar', 'talent(7,3)'},
	{'Rampage', 'buff(Meat Cleaver)'},
	{'Bloodthirst'},
	{'Whirlwind'},
	{'Shockwave', '!immune(stun)&player.area(10).enemies.inFront>=3'},
}

local ST = {
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury).stack<2'},
	{'Execute', '{!player.buff(Juggernaut)||player.buff(Juggernaut).remains<2}}||player.buff(Stone Heart)'},
	{'Rampage', 'player.rage>=100&{health>20||{health<20&!talent(5,1)}||{player.buff(Massacre)&player.buff(Enrage).remains<gcd}}'},
	{'Berserker Rage', 'talent(3,2)&spell(Odyn\'s Fury).cooldown<gcd&!buff(Enrage)', 'player'},
	{'Dragon Roar', 'spell(Odyn\'s Fury).cooldown>20||spell(Odyn\'s Fury).cooldown<3'},
	{'Odyn\'s Fury', 'player.buff(Battle Cry)&player.buff(Enrage)'},
	{'Rampage', '!player.buff(Enrage)&!player.buff(Juggernaut)'},
	{'Furious Slash', 'talent(6,2)&{!player.buff(Frenzy)||player.buff(Frenzy).stack<4}'},
	{'Raging Blow', '!player.buff(Juggernaut)&player.buff(Enrage)&!player.buff(Battle Trance)'},
	{'Whirlwind', 'talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)'},
	{'Execute', 'talent(6,3)||{!talent(6,3)&player.rage>50}'},
	{'Bloodthirst', '!buff(Enrage)', 'player'},
	{'Raging Blow', '!player.buff(Enrage)'},
	{'Execute'},
	{'Raging Blow'},
	{'Blood Bath'},
	{'Bloodthirst'},
	{'Furious Slash'},
	{Bladestorm},
	{'Bloodbath', 'player.buff(Frothing Berserker)||{player.rage>80&!talent(5,2)}'}
}

local CoupleofTargets = {
	{Bladestorm},
	{'Rampage', '!buff(Enrage)||{rage==100&!buff(Juggernaut)}||buff(Massacre)'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', 'talent(6,3)'},
	{'Blood Bath'},
	{'Dragon Roar'},
	{'Bloodthirst'},
	{'Whirlwind'}
}

local xPvP = {
	{'Gladiator\'s Medallion', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Adaptation', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Disarm', 'inMelee&inFront'},
	{'Spell Reflection', 'range<41&combat&alive&interruptAt(80)', 'enemies'},
	{'Death Wish', 'player.buff(Death Wish).count<UI(DWS)&player.health>=UI(DWH)', 'player'}
}

local xCombat = {
	{Cooldowns, 'toggle(Cooldowns)&inMelee'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)&toggle(xIntRandom)', 'enemies'},
	{CoupleofTargets, 'player.area(8).enemies==2||player.area(8).enemies==3'},
	{AoE, 'player.area(8).enemies>3&inMelee&inFront'},
	{ST, 'player.area(8).enemies<=3&inMelee&inFront'},
	{Ranged, '!inMelee&inFront'},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{xPvP},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{Mythic_Plus, 'inMelee'}
}

local outCombat = {
	{PreCombat, nil, 'player'},
	{Keybinds},
}

NeP.CR:Add(72, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Fury',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
