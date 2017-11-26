local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																					align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',											align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Cannonball Barrage|r',					align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Grappling Hook|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',														align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																						key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																				align = 'center'},
	{type = 'combo',		default = 'normal',																											key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',							 												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 													key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																				key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',								key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																													key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																		key = 'LJ',						spin = 4,	step = 1,	max = 20,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Tricks of the Trade on Focus/Tank',		 											key = 'tot', 					default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																								key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																								key = 'trinket2', 		default = false,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', text = 'Kil\'Jaeden\'s Burning Wish - Units', 													key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
  -- Survival
	{type = 'header', 	size = 16, text = 'Survival',																						align = 'center'},
	{type = 'checkspin',text = 'Crisom Vial',																										key = 'h_CV',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 75, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Riposte',																												key = 'h_RIP',				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 50, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Vanish',																												key = 'h_VAN',				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',text = 'Healthstone',																										key = 'HS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																								key = 'AHP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'ruler'},	  {type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffFFFF00 ----------------------------------------------------------------------|r')
	print('|cffFFFF00 --- |rRogue |cffFFF569Outlaw |r')
	print('|cffFFFF00 --- |rRecommended Talents: 1/1 - 2/3 - 3/1 - 4/X - 5/1 - 6/2 - 7/2')
  print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key='ambush',
		name='Ambush',
		text = 'If Enabled we will Open with Ambush when Stealthed. If disabled, Cheap Shot will be used.',
		icon='Interface\\Icons\\ability_rogue_ambush',
	})

	NeP.Interface:AddToggle({
		key='xStealth',
		name='Auto Stealth',
		text = 'If Enabled we will automatically use Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
	})

	NeP.Interface:AddToggle({
		key='xPickPock',
		name='Pick Pocket',
		text = 'If Enabled we will automatically Pick Pocket enemies out of combat.',
		icon='Interface\\Icons\\inv_misc_bag_11',
	})

  NeP.Interface:AddToggle({
   key = 'xIntRandom',
   name = 'Interrupt Anyone',
   text = 'Interrupt all nearby enemies, without targeting them.',
   icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

end

local PreCombat = {
	{'Pick Pocket', 'toggle(xPickPock)&enemy&alive&!combat&range<=10&player.buff(Stealth)', 'enemies'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'ingroup&item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'}				--XXX: Lightforged Augment Rune
}

local Survival ={
	{'Crimson Vial', 'health<UI(h_CV_spin)&UI(h_CV_check)'},
	{'Riposte', 'UI(h_RIP_check)&{health<UI(h_RIP_spin)||incdmg(5)>health.max*0.20}'},
	{'Cloak of Shadows', 'incdmg(5).magic>health.max*0.20'},
	{'Vanish', 'health<=UI(h_VAN)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'} 																		--XXX: Health Stone
}

local Keybinds = {
	{'%pause', 'buff(Shadowmeld)||buff(Vanish)', 'player'},
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Cannonball Barrage', 'keybind(lcontrol)', 'cursor.ground'},
	{'!Grappling Hook', 'talent(2,1)&keybind(lalt)', 'cursor.ground'}
}

local Interrupts = {
	{'&Kick', 'inMelee&inFront'},
	{'!Between the Eyes', 'range<21&inFront&spell(Kick).cooldown>=gcd&player.combopoints>0&!player.lastgcd(Kick)'},
	{'!Cloak of Shadows', 'spell(Kick).cooldown>=gcd&spell(Between the Eyes).cooldown>=gcd'},
}

local Build = {
	{'Ghostly Strike', 'inMelee&combo_points.deficit>0&debuff(Ghostly Strike).duration<2'},
	{'Pistol Shot', 'range<=30&{player.buff(Opportunity)&player.combopoints<5||{range>=10&player.combopoints<5}}'},
	{'Saber Slash', 'inMelee&{player.combopoints<5||{player.combopoints<6&player.buff(Broadsides)}}'},
}

local Finishers = {
	{'Between the Eyes', 'range<=30&player.combopoints>4&player.buff(Shark Infested Waters)'},
	{'Run Through', 'inMelee&player.combopoints>4'},
	{'Death from Above', 'range<=15&area(8).enemies>4&player.combopoints>4'},
	{'Slice and Dice', 'inMelee&combopoints>4&buff.remains<3', 'player'},
}

local Blade_Flurry = {
	{'Blade Flurry', 'area(8).enemies>=3&!buff(Blade Flurry)'},
	{'Blade Flurry', 'area(8).enemies<=2&buff(Blade Flurry)'}
}

local Cooldowns = {
	{'Cannonball Barrage', 'range<=35&area(10).enemies<4', 'target.ground'},
	{'Adrenaline Rush', 'inMelee&area(10).enemies>0&energy.deficit>0', 'player'},
	{'Marked for Death', 'range<=30&{{player.combopoints<6&player.energy>16}||xtime<20}'},
	{'Curse of the Dreadblades', 'inMelee&combo_points.deficit>3&{target.debuff(Ghostly Strike)||!talent(1,1)}', 'player'},
	{'Killing Spree', 'inMelee&{energy.time_to_max>5||player.energy<15}'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local RollingBones ={
	{'Roll the Bones', 'combopoints>=5&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)'},
	{'Roll the Bones', 'combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!talent(7,1)&buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&buff(Buried Treasure)'},
	{'Roll the Bones', 'combopoints>4&!talent(7,1)&!RtB'},
}

local TricksofTrade = {
	{'Tricks of the Trade', 'UI(tott)&ingroup&!is(player)&!buff&range<99', {'focus', 'tank'}},
}

local Stealth_Opener = {
	{'Ambush', 'alive&enemy&inMelee&inFront&player.buff(Stealth)&toggle(ambush)'},
	{'Cheap Shot', 'alive&enemy&inMelee&inFront&player.buff(Stealth)&!toggle(ambush)'}
}

local xCombat = {
	{Cooldowns, 'toggle(Cooldowns)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)', 'enemies'},
	{Build},
	{Finishers},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{RollingBones, nil, 'player'},
	{Blade_Flurry, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.Condition.Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{TricksofTrade},
}

local outCombat = {
	{'Stealth', 'toggle(xStealth)&!buff&!buff(Vanish)&!nfly', 'player'},
	{PreCombat, nil, 'player'},
	{Stealth_Opener, '!toggle(xPickPock)&!debuff(Sap)', 'target'},
  {Blade_Flurry, nil, 'player'},
	{Keybinds},
	{TricksofTrade},
}

NeP.CR.Add(260, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Outlaw',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
