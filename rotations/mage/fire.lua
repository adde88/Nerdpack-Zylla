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
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'normal',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 		default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',								key = 'prepot', 	default = false},
	{type = 'checkbox', text = 'Enable \'pre-cast Pyroblast\'',										key = 'precast', 	default = false},
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
	{type = 'checkspin',	text = 'Healthstone',																		key = 'HS',				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',	text = 'Healing Potion',																key = 'AHP',			align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin', 	text = 'Ice Block', 																		key = 'ib', 			align = 'left', width = 55, step = 5, shiftStep = 10, spin = 20, max = 100, min = 1, check = true},
	{type = 'ruler'},		 {type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMage |cffADFF2FFire|r')
	print('|cffADFF2F --- |rBased on SimCraft T20 Fire Mage')
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

local Cumbustion ={
	{'&Combustion', 'target.ttd>12&{player.buff(Rune of Power)||casting(Rune of Power).percent>80}||{player.buff(Incanter\'s Flow).count>3}'}
}

local Keybinds = {
	{'%pause', '{keybind(lshift)&UI(lshift)}||{player.buff(Ice Block)||player.buff(Shadowmeld)||player.buff(Ice Block)}'},
	{'!Rune of Power', 'keybind(lalt)&UI(lalt)', 'player'},
	{'!Flamestrike', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'}
}

local PreCombat = {
	{'Blazing Barrier' , '!player.buff&player.area(50).enemies>0&UI(bb)', 'target'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<5'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<5'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<5'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127847', 'item(127847).usable&item(127847).count>0&UI(prepot)&!buff(Flask of the Whispered Pact)'},	--XXX:  Flask of the Whispered Pact
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},					--XXX: Lightforged Augment Rune
	{'Pyroblast', 'UI(precast)&UI(kDBM)&dbm(pull in)<=spell(11366).casttime+gcd', 'target'}	--TODO: Fix SpellID issue (spell.casttime)
}

local Interrupts = {
	{'!Counterspell'},
	{'!Arcane Torrent', 'inMelee&inFront&spell(Counterspell).cooldown>=gcd&!player.lastgcd(Counterspell)'},
	{'!Dragon\'s Breath', 'spell(Counterspell).cooldown>=gcd&!player.lastgcd(Counterspell)&player.area(12).enemies.inFront>0'},
	{'!Ring of Frost', 'interruptAt(5)&advanced&!player.moving&UI(RoF_Int)&spell(Counterspell).cooldown>=gcd&!player.lastgcd(Counterspell)&range<=30', 'target.ground'},
	{'!Ring of Frost', 'interruptAt(5)&toggle(xIntRandom)&advanced&!player.moving&UI(RoF_Int)&spell(Counterspell).cooldown>=gcd&!player.lastgcd(Counterspell)&range<=30', 'enemies.ground'},
	{'!Polymorph', 'interruptAt(5)&!player.moving&UI(Pol_Int)&spell(Counterspell).cooldown>=gcd&!player.lastgcd(Counterspell)&range<=30'},
}

local Cooldowns = {
	{'Mirror Image', '!buff(Combustion)', 'player'},
	{'Blood Fury', nil, 'player'},
	{'Berserking', 'toggle(xTimeWarp)', 'player'},
	{'Time Warp', 'toggle(xTimeWarp)', 'player'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)', 'target'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'} 		--XXX: Argus World Spell
}

local Survival = {
	{'Blazing Barrier' , '!buff&UI(bb)'},
	{'!Ice Block', 'UI(ib_check)&{health<UI(ib_spin)||debuff(Cauterize)}'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Talents = {
	{'Blast Wave', '{!player.buff(Combustion)}||{player.buff(Combustion)&action(Fire Blast).charges<1&action(Phoenix\'s Flames).charges<1}'},
	{'Meteor', 'advanced&{cooldown(Combustion).remains>40||{cooldown(Combustion).remains>target.ttd}||player.buff(Rune of Power)||player.buff(Firestarter)}', 'target.ground'},
	{'Cinderstorm', 'cooldown(Combustion).remains<spell(198929).casttime&{player.buff(Rune of Power)||!talent(3,2)}||cooldown(Combustion).remains>10*spell_haste&!player.buff(Combustion)'},	--TODO: Fix SpellID issue (spell.casttime)
	{'Dragons Breath', 'equipped(132863)||{talent(4,1)&!player.buff(Hot Streak!)}'},
	{'Living Bomb', 'area(10).enemies>1&!player.buff(Combustion)'},
}

local Combustion_Phase = {
	{'Rune of Power', '!buff(Combustion)', 'player'},
	{Talents},
	{Cooldowns, 'toggle(cooldowns)'},
	{'&Flamestrike', 'advanced&!player.moving&{{talent(6,3)&area(10).enemies>2||area(10).enemies>4}&player.buff(Hot Streak!)}', 'target.ground'},
	{'Pyroblast', '!player.moving&player.buff(Kael\'thas\'s Ultimate Ability)&player.buff(Combustion).remains>execute_time'},
	{'&Pyroblast', 'player.buff(Hot Streak!)'},
	{'&Fire Blast', 'player.buff(Heating Up)'},
	{'Phoenix\'s Flames'},
	{'Scorch', 'player.buff(Combustion).remains>spell(2948).casttime'}, --TODO: Fix SpellID issue (spell.casttime)
	{'Dragon\'s Breath', '!player.buff(Hot Streak!)&action(Fire Blast).charges<1&action(Phoenix\'s Flames).charges<1'},
	{'Scorch', 'health<=30&equipped(132454)'},
}

local Rop_Phase = {
	{'Rune of Power', '!player.moving', 'player'},
	{'Flamestrike', 'advanced&!player.moving&{{(talent(6,3)&area(10).enemies>1}||area(10).enemies>3}&player.buff(Hot Streak!)}', 'target.ground'},
	{'&Pyroblast', 'player.buff(Hot Streak!)'},
	{Talents},
	{'Pyroblast', '!player.moving&player.buff(Kael\'thas\'s Ultimate Ability)&execute_time<buff(Kael\'thas\'s Ultimate Ability).remains'},
	{'&Fire Blast', '!player.lastcast(Fire Blast)&player.buff(Heating Up)&player.buff(Firestarter)&spell(Fire Blast).charges>1.7'},
	{'Phoenix\'s Flames', '!player.lastgcd(Phoenix\'s Flames)&spell(Phoenix\'s Flames).charges>2.7&player.buff(Firestarter)'},
	{'&Fire Blast', '!player.lastcast(Fire Blast)&!player.buff(Firestarter)'},
	{'Phoenix\'s Flames', '!player.lastgcd(Phoenix\'s Flames)'},
	{'Scorch', 'target.health<=30&equipped(132454)'},
	{'Dragon\'s Breath', 'area(12).enemies.inFront>2'},
	{'Flamestrike', 'advanced&!player.moving&{{talent(6,3)&area(10).enemies>2}||area(10).enemies>5}', 'target.ground'},
	{'Fireball', '!player.moving'},
}

local MainRotation = {
	{'&Flamestrike', 'advanced&!player.moving&{{{talent(6,3)&area(10).enemies>1}||area(10).enemies>3}&player.buff(Hot Streak!)}', 'target.ground'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&player.buff(Hot Streak!).remains<action(Fireball).execute_time'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&player.buff(Firestarter)&!talent(3,2)'},
	{'Phoenix\'s Flames', 'spell(Phoenix\'s Flames).charges>2.7&area(10).enemies>2'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&!player.lastgcd(Pyroblast)'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&target.health<=30&equipped(132454)'},
	{'Pyroblast', '!player.moving&player.buff(Kael\'thas\'s Ultimate Ability)&execute_time<buff(Kael\'thas\'s Ultimate Ability).remains'},
	{Talents},
	{'&Fire Blast', '!talent(7,1)&player.buff(Heating Up)&{!talent(3,2)||spell(Fire Blast).charges>1.4||cooldown(Combustion).remains<40}&{3-spell(Fire Blast).charges}*{12*spell_haste}<cooldown(Combustion).remains+3||target.ttd<4'},
	{'&Fire Blast', 'talent(7,1)&player.buff(Heating Up)&{!talent(3,2)||spell(Fire Blast).charges>1.5||cooldown(Combustion).remains<40}&{3-spell(Fire Blast).charges}*{18*spell_haste}<cooldown(Combustion).remains+3||target.ttd<4'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)||player.buff(Incanter\'s Flow).stack>3||talent(3,1)}&artifact(Phoenix Reborn).enabled&{4-spell(Phoenix\'s Flames).charges}*13<cooldown(Combustion).remains+5||target.ttd<10'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)}&{4-spell(Phoenix\'s Flames).charges}*30<cooldown(Combustion).remains+5'},
	{'Phoenix\'s Flames', 'spell(Phoenix\'s Flames).charges>2.5&cooldown(Combustion).remains>23'},
	{'Flamestrike', 'advanced&!player.moving&{{talent(6,3)&area(10).enemies>3}||area(10).enemies>5}', 'target.ground'},
	{'Scorch', '!player.moving&health<=30&equipped(132454)'},
	{'Fireball', '!player.moving'},
}

local xCombat = {
	{'Rune of Power', 'player.buff(Firestarter)&action(Rune of Power).charges==2||cooldown(Combustion).remains>40&!player.buff(Combustion)&!talent(7,1)||target.ttd<11||talent(7,1)&{spell(Rune of Power).charges>1.8||time<40}&cooldown(Combustion).remains>40'},
	{'Rune of Power', '{player.buff(Kael\'thas\'s Ultimate Ability)&{cooldown(Combustion).remains>40||action(Rune of Power).charges>1}}||{player.buff(Erupting Infernal Core)&{cooldown(Combustion).remains>40||action(Rune of Power).charges>1}}'},
	{Combustion_Phase, 'cooldown(Combustion).remains<=action(116011).cast_time+{!talent(7,1)*gcd}&{!talent(1,3)||!player.buff(Firestarter)||area(10).enemies>=4||area(10).enemies>=2&talent(6,3)}||player.buff(Combustion)'},	--TODO: Fix SpellID issue (spell.casttime)
	{Rop_Phase, 'player.buff(Rune of Power)&!player.buff(Combustion)'},
	{MainRotation},
	{'Scorch', 'player.moving'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(interrupts)&@Zylla.InterruptAt(intat)&inFront&range<=40', 'target'},
	{Interrupts, 'toggle(interrupts)&@Zylla.InterruptAt(intat)&toggle(xIntRandom)&inFront&range<=40', 'enemies'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Survival, nil, 'player'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.Condition:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
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
