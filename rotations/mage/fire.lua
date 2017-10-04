local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Flamestrike|r',	align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Rune of Power|r',	align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 		default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',								key = 'prepot', 	default = false},
	{type = 'combo',		default = '3',																						key = 'list', 		list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',				spin = 4, step = 1, max = 20, check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Ring of Frost as Interrupt',											key = 'RoF_Int',	default = true},
	{type = 'checkbox', text = 'Polymorph as Interrupt',													key = 'Pol_Int',	default = false},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',	default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', default = false,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 					key = 'kj', 			align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 0, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 		size = 16, text = 'Survival',									 	 				align = 'center'},
	{type = 'checkbox', 	text = 'Blazing Barrier', 															key = 'bb', 			default = true},
	{type = 'checkspin',	text = 'Healthstone',																		key = 'HS',				spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',																key = 'AHP',			spin = 45, check = true},
	{type = 'checkspin', 	text = 'Ice Block', 																		key = 'ib', 			spin = 20, check = true},
	{type = 'ruler'},		 {type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMage |cffADFF2FFire |r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xTimeWarp',
		name = 'Time Warp',
		text = 'Automatically use Time Warp.',
		icon = 'Interface\\Icons\\ability_mage_timewarp',
	})

	NeP.Interface:AddToggle({
	 key = 'xIntRandom',
	 name = 'Interrupt Anyone',
	 text = 'Interrupt all nearby enemies, without targeting them.',
	 icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

end

local Keybinds = {
	{'%pause', '{keybind(lshift)&UI(lshift)}||{player.buff(Ice Block)||player.buff(Shadowmeld)}'},
	{'!Rune of Power', 'keybind(lalt)&UI(lalt)'},
	{'!Flamestrike', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'}
}

local PreCombat = {
	{'Blazing Barrier' , '!buff&area(50).enemies>0&UI(bb)'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127847', 'item(127847).usable&item(127847).count>0&UI(prepot)&!buff(Flask of the Whispered Pact)'},	--XXX:  Flask of the Whispered Pact
}

local Interrupts = {
	{'!Counterspell'},
	{'!Arcane Torrent', 'inMelee&inFront&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)'},
	{'!Dragon\'s Breath', 'spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&player.area(12).enemies.inFront>0'},
	{'!Ring of Frost', 'interruptAt(5)&advanced&!player.moving&UI(RoF_Int)&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&range<=30', 'target.ground'},
	{'!Ring of Frost', 'interruptAt(5)&toggle(xIntRandom)&advanced&!player.moving&UI(RoF_Int)&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&range<=30', 'enemies.ground'},
	{'!Polymorph', 'interruptAt(5)&!player.moving&UI(Pol_Int)&spell(Counterspell).cooldown>gcd&!player.lastgcd(Counterspell)&range<=30'},
}

local Cooldowns = {
	{'Blood Fury'},
	{'Berserking', 'toggle(xTimeWarp)'},
	{'Time Warp', 'toggle(xTimeWarp)'},
	{'#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)', 'target'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'} --XXX: Argus World Spell
}

local Survival = {
	{'!Ice Block', 'UI(ib_check)&{health<UI(ib_spin)||debuff(Cauterize)}'},
	{'Blazing Barrier' , 'player.buff(Blazing Barrier).duration<gcd'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Talents = {
	{'Blast Wave', '!player.buff(Combustion)||{player.buff(Combustion)&action(Fire Blast).charges<1&action(Phoenix\'s Flames).charges<1}'},
	{'Meteor', 'spell(Combustion).cooldown>30||{{spell(Combustion).cooldown>ttd}||player.buff(Rune of Power)||player.buff(Incanter\'s Flow).stack>3}', 'target.ground'},
	{'Cinderstorm', 'spell(Combustion).cooldown<action(Cinderstorm).cast_time&{{player.buff(Rune of Power)||!talent(3,2)}||spell(Combustion).cooldown>10*spell_haste&!player.buff(Combustion)}'},
	{'Dragon\'s Breath', 'equipped(132863)'},	--XXX: Legendary Dragon's Breath Usage
	{'Living Bomb', '!debuff&area(10).enemies>=2&!player.buff(Combustion)'}
}

local Combustion = {
	{'Rune of Power', '!buff(Combustion)', 'player'},
	{'&Pyroblast', '!player.buff(Kael\'thas\'s Ultimate Ability)&player.buff(Hot Streak!)&{player.buff(Combustion)||player.buff(Incanter\'s Flow).stack>3}'},
	{'Phoenix\'s Flames', 'action(Phoenix\'s Flames).charges>2.7&player.buff(Combustion)&!player.buff(Hot Streak!)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&player.buff(Combustion)'},
	{'Scorch', 'player.buff(Combustion).duration>action(Scorch).cast_time||player.buff(Incanter\'s Flow).stack>3'},
}

local RoP_with_IDA = {
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)&!player.buff(Hot Streak!)'},
	{'&Fire Blast', '!player.buff(Kael\'thas\'s Ultimate Ability)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&!player.lastcast(Phoenix\'s Flames)'},
	{'Phoenix\'s Flames', '!player.lastgcd(Phoenix\'s Flames)'},
	{'Scorch', 'target.health<35&equipped(132454)'},
	{'Fireball'}
}

local MainRotation = {
	{'Pyroblast', '!player.buff(Kael\'thas\'s Ultimate Ability)&player.buff(Hot Streak!)&player.buff(Hot Streak!).duration<action(Fireball).execute_time'},
	{'Phoenix\'s Flames', 'action(Phoenix\'s Flames).charges>2.7&area(8).enemies>=3'},
	{'Flamestrike', 'advanced&range<=40&combat&alive&talent(6,3)&area(10).enemies>=3&player.buff(Hot Streak!)', 'target.ground'},
	{'&Pyroblast', '!player.buff(Kael\'thas\'s Ultimate Ability)&player.buff(Hot Streak!)&!player.lastgcd(Pyroblast)&{player.casting(Fireball).percent>90||player.lastcast(Fireball)}'},
	{'Pyroblast', 'player.buff(Hot Streak!)&target.health<=25&equipped(132454)'},
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)&!player.buff(Hot Streak!)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&action.charges>0&spell(Combustion).cooldown<action.cooldown_to_max'},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&!talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.4||spell(Combustion).cooldown<40}&(3-action(Fire Blast).charges)*(12*spell_haste)<=spell(Combustion).cooldown+3'},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.5||spell(Combustion).cooldown<40}&{3-action(Fire Blast).charges}*{18*spell_haste}<=spell(Combustion).cooldown+3'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)||player.buff(Incanter\'s Flow).stack>3||talent(3,1)}&{{4-action.charges}*13<spell(Combustion).cooldown+5||ttd<10}'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)||player.buff(Incanter\'s Flow).stack>3}&{4-action.charges}*30<spell(Combustion).cooldown+5'},
	{'Scorch', 'health<35&equipped(132454)'},
	{'Ice Floes', 'gcd.remains<0.5&movingfor>0.75&!lastcast&!buff', 'player'},
	{'Fireball', '!player.moving||{player.moving&player.buff(Ice Floes)}'},
	{'Ice Barrier', '!buff&!buff(Combustion)&!buff(Rune of Power)', 'player'},
	{'Scorch', 'player.moving&!player.buff(Ice Floes)'},
	{'Dragon\'s Breath', 'player.area(12).enemies.inFront>=3'},
}

local xCombat = {
	{'Rune of Power', '!moving&toggle(cooldowns)&{{spell(Combustion).cooldown>40}&{!buff(Combustion)&&!talent(7,1)||target.ttd<11||talent(7,1)&{action(Rune of Power).charges>1.8||xtime<40}&{spell(Combustion).cooldown>40)}}}', 'player'},
	{Combustions, 'toggle(cooldowns)&!player.moving&{spell(Combustion).cooldown<=action(Rune of Power).cast_time+gcd||player.buff(Combustion)}', 'target'},
	{RoP_with_IDA, '!player.moving&player.buff(Rune of Power)&!player.buff(Combustion)', 'target'},
	{MainRotation, nil, 'target'},
}

local Cumbustion ={
	{'&Combustion', 'target.ttd>12&{buff(Rune of Power)||casting(Rune of Power).percent>80}||{player.buff(Incanter\'s Flow).stack>3}'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(interrupts)&inFront&range<=40', 'target'},
	{Interrupts, 'toggle(interrupts)&toggle(xIntRandom)&inFront&range<=40', 'enemies'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Survival, nil, 'player'},
	{Talents, nil, 'target'},
	{xCombat, 'range<=40&inFront'},
	{Mythic_Plus, 'range<=40'},
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
	{Survival, nil, 'player'},
}

NeP.CR:Add(63, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Fire',
	ic = {
		{inCombat, '!player.casting(Rune of Power)'},
		{Cumbustion}
	},
	pooling = true,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
