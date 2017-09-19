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
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Flamestrike|r',	align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Rune of Power|r',	align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(PayPal_GUI),
	{type = 'spacer'},
	unpack(PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', 																	align = 'center'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',				spin = 4, step = 1, max = 20, check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Ring of Frost (Interrupt)',												key = 'RoF_Int',	default = true},
	{type = 'checkbox', text = 'Polymorph (Interrupt)',														key = 'Pol_Int',	default = false},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',	default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', default = true,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 					key = 'kj', 			align = 'left', width = 55, step = 1, spin = 4, max = 15, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 		text = 'Survival',									 	 									align = 'center'},
	{type = 'checkbox', 	text = 'Blazing Barrier', 															key = 'bb', 			default = true},
	{type = 'checkspin',	text = 'Healthstone',																		key = 'HS',				spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',																key = 'AHP',			spin = 45, check = true},
	{type = 'checkspin', 	text = 'Ice Block', 																		key = 'ib', 			spin = 20, check = true},
	{type = 'ruler'},		 {type = 'spacer'},
	unpack(Mythic_GUI),
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
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Rune of Power', 'keybind(lalt)'},
	{'!Flamestrike', 'keybind(lcontrol)', 'cursor.ground'}
}

local PreCombat = {
	{'Blazing Barrier' , '!buff&area(50).enemies>0&UI(bb)', 'player'}
}

local Interrupts = {
	{'!Counterspell', 'interruptAt(70)', 'target'},
	{'!Arcane Torrent', 'interruptAt(70)&inMelee&inFront&player.spell(Counterspell).cooldown>gcd&!player.lastcast(Counterspell)', 'target'},
	{'!Dragon\'s Breath', 'interruptAt(70)&player.spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)&player.area(12).enemies.inFront>0', 'target'},
	{'!Ring of Frost', 'interruptAt(5)&advanced&!player.moving&UI(RoF_Int)&player.spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)&range<31', 'target.ground'},
	{'!Polymorph', '!player.moving&UI(Pol_Int)&interruptAt(5)&player.spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)&range<31', 'target'},
}

local Interrupts_Random = {
	{'!Counterspell', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<41', 'enemies'},
  {'!Dragon\'s Breath', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)&player.area(12).enemies.inFront>0', 'enemies'},
	{'!Ring of Frost', 'advanced&!player.moving&UI(RoF_Int)&interruptAt(5)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)&range<31', 'enemies.ground'},
	{'!Polymorph', '!player.moving&UI(Pol_Int)&interruptAt(5)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)&range<31', 'enemies'},
}

local Cooldowns = {
	{'Blood Fury'},
	{'Berserking', 'toggle(xTimeWarp)'},
	{'Time Warp', 'toggle(xTimeWarp)'},
	{'#144259', 'UI(kj_check)&target.range<41&target.area(10).enemies>UI(kj_spin)&equipped(144259)'}, -- Kil'jaeden's Burning Wish / AoE Trinket
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Survival = {
	{'!Ice Block', 'UI(ib_check)&{health<UI(ib_spin)||debuff(Cauterize)}', 'player'},
	{'Blazing Barrier' , 'player.buff(Blazing Barrier).duration<gcd'},
	{'#127834', 'item(127834).usable&item(127834).count>0&player.health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<=UI(HS_spin)&UI(HS_check)', 'player'}, 						--Health Stone
}

local Talents = {
	{'Flame On', 'action(Fire Blast).charges<0.2&{player.spell(Combustion).cooldown>65||target.ttd<player.spell(Combustion).cooldown}'},
	{'Blast Wave', '!player.buff(Combustion)||{player.buff(Combustion)&action(Fire Blast).charges<1&action(Phoenix\'s Flames).charges<1}'},
	{'Meteor', 'player.spell(Combustion).cooldown>30||{{player.spell(Combustion).cooldown>target.ttd}||player.buff(Rune of Power)}', 'target.ground'},
	{'Cinderstorm', 'player.spell(Combustion).cooldown<action(Cinderstorm).cast_time&{{player.buff(Rune of Power)||!talent(3,2)}||player.spell(Combustion).cooldown>10*spell_haste&!player.buff(Combustion)}'},
	{'Dragon\'s Breath', 'equipped(132863)'},
	{'Living Bomb', '!debuff&area(10).enemies>1&!player.buff(Combustion)', 'target'}
}

local Combustion = {
	{'Rune of Power', '!player.buff(Combustion)'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&player.buff(Combustion)'},
	{'Phoenix\'s Flames', 'action(Phoenix\'s Flames).charges>2.7&player.buff(Combustion)&!player.buff(Hot Streak!)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&player.buff(Combustion)'},
	{'Phoenix\'s Flames'},
	{'Scorch', 'player.buff(Combustion).duration>action(Scorch).cast_time'},
	{'Scorch'}
}

local RoP = {
	{'Rune of Power'},
	{'&Pyroblast', 'player.buff(Hot Streak!)'},
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&!player.casting(Rune of Power)&!player.lastcast(Phoenix\'s Flames)'},
	{'Phoenix\'s Flames', '!player.lastgcd(Phoenix\'s Flames)'},
	{'Scorch', 'target.health<35&equipped(132454)'},
	{'Fireball'}
}

local MainRotation = {
	{'&Pyroblast', 'player.buff(Hot Streak!)&player.buff(Hot Streak!).duration<action(Fireball).execute_time'},
	{'Phoenix\'s Flames', 'action(Phoenix\'s Flames).charges>2.7&target.area(8).enemies>2'},
	{'&Flamestrike', 'advanced&target.range<41&talent(6,3)&target.area(10).enemies>2&player.buff(Hot Streak!)', 'target.ground'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&!player.lastgcd(Pyroblast)&{player.casting(Fireball).percent>90||player.lastcast(Fireball)}'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&target.health<35&equipped(132454)'},
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!prev_off_gcd(Fire Blast)&action(Fire Blast).charges>0&player.spell(Combustion).cooldown<action(Fire Blast).cooldown_to_max'},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&!player.casting(Rune of Power)&!talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.4||player.spell(Combustion).cooldown<40}&(3-action(Fire Blast).charges)*(12*spell_haste)<=player.spell(Combustion).cooldown+3'},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&!player.casting(Rune of Power)&talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.5||player.spell(Combustion).cooldown<40}&{3-action(Fire Blast).charges}*{18*spell_haste}<=player.spell(Combustion).cooldown+3'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)||player.buff(Incanter\'s Flow).stack>3||talent(3,1)}&{{4-action(Phoenix\'s Flames).charges}*13<player.spell(Combustion).cooldown+5||target.ttd<10}'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)}&{4-action(Phoenix\'s Flames).charges}*30<player.spell(Combustion).cooldown+5', 'target'},
	{'Scorch', 'health<35&equipped(132454)', 'target'},
	{'Ice Floes', 'gcd.remains<0.5&movingfor>0.75&!lastcast&!buff', 'player'},
	{'Fireball', '!player.moving||{player.moving&player.buff(Ice Floes)}', 'target'},
	{'Ice Barrier', '!buff&!buff(Combustion)&!buff(Rune of Power)', 'player'},
	{'Scorch', 'player.moving&!player.buff(Ice Floes)', 'target'},
	{'Dragon\'s Breath', 'player.area(12).enemies.inFront>2', 'target'},
}

local xCombat = {
	{'Rune of Power', '!player.moving&toggle(cooldowns)&{{player.spell(Combustion).cooldown>40}&{!player.buff(Combustion)&{player.spell(Flame On).cooldown<5||player.spell(Flame On).cooldown>30}&!talent(7,1)||target.ttd<11||talent(7,1)&{action(Rune of Power).charges>1.8||xtime<40}&{player.spell(Combustion).cooldown>40)}}}'},
	{Combustion, 'toggle(cooldowns)&!player.moving&{player.spell(Combustion).cooldown<=action(Rune of Power).cast_time+gcd||player.buff(Combustion)}'},
	{RoP, '!player.moving&player.buff(Rune of Power)&!player.buff(Combustion)'},
	{MainRotation},
}

local Cumbustion ={
	{'&Combustion', 'target.range<41&target.ttd>12&{buff(Rune of Power)||casting(Rune of Power).percent>80}', 'player'}
}

local inCombat = {
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'toggle(interrupts)&target.inFront&target.range<41'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Survival},
	{Talents},
	{xCombat, 'range<41&inFront'},
	{Mythic_Plus, 'range<41'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, 'toggle(interrupts)&target.inFront&target.range<41'},
}

NeP.CR:Add(63, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Fire',
	ic = {
		{inCombat, '!player.casting(Rune of Power)'},
		{Cumbustion}
	},
--waitfor = true,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='570', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
