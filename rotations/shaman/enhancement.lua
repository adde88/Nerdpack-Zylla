local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																			align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',									align = 'left', 				key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Tier 3 Totems|r',					align = 'left', 				key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',												align = 'left', 				key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',												align = 'left', 				key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																				key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																		align = 'center'},
	{type = 'combo',		default = 'normal',																									key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',							 										align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 											key = 'intat',					default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																		key = 'kDBM', 					default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',						key = 'prepot', 				default = false},
	{type = 'combo',		default = '1',																											key = 'list', 					list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkbox', text = 'Use Trinket #1', 																						key = 'trinket1',				default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																						key = 'trinket2', 			default = true,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																key = 'LJ',							spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 										key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',									  	      						align = 'center'},
	{type = 'checkbox', text = 'Enable Healing Surge',																			key = 'E_HS',           default = false},
	{type = 'spinner', 	text = 'Healing Surge below HP%',             											key = 'HS_HP',          default = 20},
	{type = 'spinner', 	text = 'Astral Shift below HP%',             												key = 'AS_HP',          default = 40},
	{type = 'checkbox', text = 'Use Rainfall to Heal Player',																key = 'E_RF_PL',        default = true},
	{type = 'spinner', 	text = 'below HP%',             																		key = 'P_RF_HP',       	default = 33},
	{type = 'checkspin',text = 'Healthstone',																								key = 'HS',							spin = 45, check = true},
	{type = 'checkspin',text = 'Healing Potion',																						key = 'AHP',						spin = 45, check = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Group/Party stuff...
	{type = 'header', 	size = 16, text = 'Party/Group',									  	    					align = 'center'},
	{type = 'checkbox', text = 'Heal Lowest Party Member',																	key = 'E_HEAL',        default = false},
	{type = 'spinner', 	text = 'below HP%',             																		key = 'L_HS_HP',       default = 33},
	{type = 'checkbox', text = 'Use Rainfall to Heal Party',																key = 'E_HEAL_RF',     default = false},
	{type = 'spinner', 	text = 'below HP%',             																		key = 'L_RF_HP',       default = 25},
	{type = 'ruler'},	  {type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rShaman |cffADFF2FEnhancement (Default)|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/X - 3/X - 4/3 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them. Might require advanced unlocker on some routines!',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
		key = 'xHeroism',
		name = 'Heroism',
		text = 'Automatically use Heroism.',
		icon = 'Interface\\Icons\\ability_shaman_heroism',
	})

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Lightning Surge Totem', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
	{'!Earthgrab Totem', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
	{'!Voodoo Totem', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
	{'!Wind Rush Totem', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'}
}

local PreCombat = {
	{'Healing Surge', '!moving&player.health<80'},
	{'Ghost Wolf', 'movingfor>0.5&!buff'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'ingroup&item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local Survival = {
	{'!Healing Surge', '!moving&UI(E_HS)&player.health<UI(HS_HP)&player.maelstrom>10'},
	{'!Rainfall', 'UI(E_RF_PL)&player.health<UI(P_RF_HP)&player.maelstrom>10&range<=40', 'player.ground'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Party = {
	{'!Healing Surge', '!moving&UI(E_HEAL)&health<UI(L_HS_HP)&player.maelstrom>10&range<=40'},
	{'!Rainfall', 'advanced&UI(E_HEAL_RF)&health<UI(L_RF_HP)&player.maelstrom>10&range<=40', 'lowest.ground'}
}

local Cooldowns = {
	{'Astral Shift', 'player.health<=(AS_HP)', 'player'},
	{'Feral Spirit', 'area(8).enemies.inFront>0&{player.buff(Ascendance)||spell(Ascendance).cooldown>=gcd}', 'player'},
	{'Berserking', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<110', 'player'},
	{'Blood Fury', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<110', 'player'},
	{'Doom Winds', 'area(8).enemies.inFront>0&{{spell(Flametongue).cooldown<=gcd}||{talent(4,3)&spell(Frostbrand).cooldown<=gcd}}', 'player'},
	{'Ascendance', 'area(8).enemies.inFront>0&spell(Feral Spirit).cooldown<=gcd', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Interrupts = {
	{'&Wind Shear'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(5)&spell(Wind Shear).cooldown>=gcd&!player.lastgcd(Wind Shear)', 'target.ground'},
	{'!Lightning Surge Totem', 'toggle(xIntRandom)&advanced&interruptAt(5)&spell(Wind Shear).cooldown>=gcd&!player.lastgcd(Wind Shear)', 'enemies.ground'},
}

local xCombat = {
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)&range<=35'},
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)&range<=35', 'enemies'},
	{Cooldowns, 'toggle(Cooldowns)&ttd>12'},
	{'Windstrike', 'inMelee&inFront&{player.buff(Ascendance)||player.lastcast(Ascendance)}'},
	{'Crash Lightning', 'inMelee&inFront&{{toggle(AoE)&{player.area(8).enemies>=2||player.buff(Lightning Crash).duration<=gcd}}||{!toggle(AoE)&player.buff(Lightning Crash).duration<=gcd}}'},
	{'Stormstrike', 'inMelee&inFront&!talent(4,3)&player.area(8).enemies>2'},
	{'Stormstrike', 'inMelee&inFront&player.buff(Stormbringer)'},
	{'Frostbrand', 'inMelee&inFront&talent(4,3)&player.buff(Frostbrand).remains<=gcd'},
	{'Flametongue', 'inMelee&inFront&player.buff(Flametongue).remains<=gcd'},
	{'Windsong', 'inMelee&inFront'},
	{'Fury of Air', 'inMelee&inFront&talent(6,2)&!player.buff(Fury of Air)'},
	{'Stormstrike', 'inMelee&inFront'},
	{'Lightning Bolt', 'inMelee&inFront&talent(5,2)&player.maelstrom>50'},
	{'Lava Lash', 'inMelee&inFront&player.buff(Hot Hand)'},
	{'Lava Lash', 'inMelee&inFront&player.maelstrom>40'},
	{'Earthen Spike'},
	{'Frostbrand', 'inMelee&inFront&talent(4,3)&player.buff(Frostbrand).remains<4.5'},
	{'Flametongue', 'inMelee&inFront&player.buff(Flametongue).remains<4.5'},
	{'Sundering', 'inMelee&inFront'},
	{'Rockbiter', 'inMelee&inFront'},
	{'Flametongue', 'inMelee&inFront'},
	{'Lightning Bolt', '!inMelee&inFront&range<=40'},
	{'Feral Lunge', '!inMelee&inFront&range<25'}
}

local inCombat = {
	{'Heroism', 'toggle(xHeroism)&!hashero', 'player'},
	{Keybinds},
	{Survival, nil, 'player'},
	{Party, 'ingroup', 'lowest'},
	{Mythic_Plus, 'ui(mythic_fel)&inMelee'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{'Ghost Wolf', 'movingfor>0.75&target.range>=12!buff', 'player'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Survival, nil, 'player'},
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement (default)',
	ic = {
		{inCombat, '!player.lastcast(Feral Spirit)'},
		{'Crash Lightning', 'inMelee&inFront&player.lastcast(Feral Spirit)', 'target'},
	},
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
