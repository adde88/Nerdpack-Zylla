local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
	--{type = 'checkbox', text = 'Enable Chatoverlay', 																						key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
		--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'normal',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',							 					align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',	key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																						key = 'list', 				list = Zylla.prepots, 	width = 175},
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
	{type = 'header', 	size = 16, text = 'Survival', 														align = 'center'},
	{type='spinner', 		text = 'Crimson Vial Below (HP%)', 												key='E_HP', 					default = 60},
	{type = 'checkspin',text = 'Healthstone',																			key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',text = 'Healing Potion',																	key = 'AHP',					spin = 45, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	 print('|cffADFF2F ----------------------------------------------------------------------|r')
	 print('|cffADFF2F --- |rRogue |cffADFF2FSubtlety |r')
	 print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/X - 5/X - 6/1 - 7/1')
   print('|cffADFF2F ----------------------------------------------------------------------|r')
   print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	 NeP.Interface:AddToggle({
		 key='opener',
		 name='Opener',
		 text = 'If Enabled we will Open with Cheap Shot when Stealthed. If not Shadowstrike will be used.',
		 icon='Interface\\Icons\\ability_cheapshot',
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
	{'Stealth', 'toggle(xStealth)&!buff&!buff(Vanish)&!nfly'},
	{'Shadowstrike', '!toggle(xPickPock)&!toggled(opener)&stealthed&range<25&inFront', 'target'},
	{'Cheap Shot', '!toggle(xPickPock)&toggled(opener)&stealthed&range<25&inFront', 'target'},
	{'Pick Pocket', 'toggle(xPickPock)&enemy&alive&!combat&range<=10&player.buff(Stealth)', 'enemies'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'ingroup&item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'}				--XXX: Lightforged Augment Rune
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Interrupts = {
	{'&Kick'},
	{'!Cheap Shot', 'cooldown(Kick).remains>gcd&player.buff(Stealth)&inFront&inMelee'},
	{'!Kidney Shot', 'cooldown(Kick).remains>gcd&combo_points>0&inFront&inMelee'},
	{'!Blind', 'cooldown(Kick).remains>gcd&inFront&range<25&cooldown(Kidney Shot).remains>gcd'},
}

local Survival ={
	{'Crimson Vial', 'health<=UI(k_CVHP)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'} 																		--XXX: Health Stone
}

local Builders = {
	{'Shuriken Storm', 'player.area(10).enemies>1'},
	--{'Gloomblade'},
	{'Backstab'},
}

local Cooldowns ={
	{'Blood Fury', 'stealthed'},
	{'Berserking', 'stealthed'},
	{'Shadow Blades', '!stealthed||!player.buff(Shadowmeld)'},
	{'Goremaw\'s Bite', '!player.buff(Shadow Dance)&{{combo_points.deficit>={4-parser_bypass2}*2&energy.deficit>{50+talent(3,3).enabled*25-parser_bypass3}*15}||target.time_to_die<8}'},
	{'Marked for Death', 'target.time_to_die<combo_points.deficit||combo_points.deficit>4'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Finishers = {
	{'Enveloping Shadows', 'player.buff(Enveloping Shadows).remains<target.time_to_die&player.buff(Enveloping Shadows).remains<=combo_points*1.8'},
	{'Death from Above', 'player.area(8).enemies>5'},
	{'Nightblade', 'target.time_to_die>8&{{dot.refreshable(Nightblade){player.buff(Finality: Nightblade)}}||target.dot(Nightblade).remains<target.dot(Nightblade).tick_time}'},
	{'Death from Above'},
	{'Eviscerate'},
}

local Stealth_Cooldowns = {
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>1.65'},
	{'Vanish', '!stealthed'},
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>1&combo_points<2'},
	{'Shadowmeld', 'player.energy>30-variable.ssw_er&energy.deficit>10'},
	{'Shadow Dance', '!stealthed&combo_points<2'},
}

local Stealthed = {
	{'Symbols of Death', '!player.buff(Shadowmeld)&{{player.buff(Symbols of Death).remains<target.time_to_die-4&player.buff(Symbols of Death).remains<=player.buff(Symbols of Death).duration*0.3}||{equipped(137032)&energy.time_to_max<0.25}}'},
	{Finishers, 'combo_points>4'},
	{'Shuriken Storm', '!player.buff(Shadowmeld)&{{combo_points.deficit>2&player.area(10).enemies>1+talent(6,1).enabled+equipped(137032)}||player.buff(The Dreadlord\'s Deceit).stack>19}'},
	{'Shadowstrike'},
}

local xCombat = {
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&inFront&inMelee'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)&inFront&inMelee', 'enemies'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Stealthed, 'stealthed||player.buff(Shadowmeld)'},
	{Finishers, 'combo_points>4||{combo_points>3&player.area(10).enemies>2&player.area(10).enemies<5}'},
	{Stealth_Cooldowns, 'combo_points.deficit>1+talent(6,1).enabled&{variable.ed_threshold||{cooldown(Shadowmeld).up&!cooldown(Vanish).up&cooldown(Shadow Dance).charges<2}||target.time_to_die<12||player.area(10).enemies>4}'},
	{Builders, 'variable.ed_threshold'},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.Condition.Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
}

NeP.CR.Add(261, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Subtlety',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
