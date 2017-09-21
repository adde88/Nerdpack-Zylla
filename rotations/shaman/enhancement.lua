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
	{type = 'header',  	size = 16, text = 'Keybinds',	 																			align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',									align = 'left', 				key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Tier 3 Totems|r',					align = 'left', 				key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',												align = 'left', 				key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',												align = 'left', 				key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																				key = 'chat', 					width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(PayPal_GUI),
	{type = 'spacer'},
	unpack(PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',							 										align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', 																						key = 'trinket1',				default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																						key = 'trinket2', 			default = true,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																key = 'LJ',							spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
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
	unpack(Mythic_GUI),
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

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	{'!Earthgrab Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	{'!Voodoo Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	{'!Wind Rush Totem', 'keybind(lcontrol)' , 'cursor.ground'}
}

local PreCombat = {
	{'Healing Surge', '!moving&player.health<80', 'player'},
	{'Ghost Wolf', 'movingfor>0.5&!buff', 'player'}
}

local Survival = {
	{'!Healing Surge', '!moving&UI(E_HS)&player.health<UI(HS_HP)&player.maelstrom>10', 'player'},
	{'!Rainfall', 'UI(E_RF_PL)&player.health<UI(P_RF_HP)&player.maelstrom>10&range<41', 'player.ground'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 													-- Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 																	-- Health Stone
}

local Party = {
	{'!Healing Surge', '!moving&UI(E_HEAL)&health<UI(L_HS_HP)&player.maelstrom>10&range<41', 'lowest'},
	{'!Rainfall', 'advanced&UI(E_HEAL_RF)&health<UI(L_RF_HP)&player.maelstrom>10&range<41', 'lowest.ground'}
}

local Cooldowns = {
	{'Astral Shift', 'player.health<=(AS_HP)', 'player'},
	{'Feral Spirit', 'player.buff(Ascendance)||player.spell(Ascendance).cooldown>gcd', 'player'},
	{'Berserking', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<110', 'player'},
	{'Blood Fury', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<110', 'player'},
	{'Doom Winds', '{player.spell(Flametongue).cooldown<gcd}||{talent(4,3)&player.spell(Frostbrand).cooldown<gcd}', 'player'},
	{'Ascendance', 'player.spell(Feral Spirit).cooldown<gcd', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Interrupts = {
	{'!Wind Shear', 'range<36&interruptAt(70)'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&range<36&player.spell(Wind Shear).cooldown>gcd&!player.lastcast(Wind Shear)', 'target.ground'},
}

local Interrupts_Random = {
	{'!Wind Shear', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&range<36', 'enemies'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Wind Shear).cooldown>gcd&!player.lastcast(Wind Shear)&inFront&range<36', 'enemies.ground'},
}

local xCombat = {
	{'Windstrike', 'player.buff(Ascendance)||player.lastcast(Ascendance)'},
	{'Crash Lightning', '{toggle(AoE)&{player.area(8).enemies>=2||player.buff(Lightning Crash).duration<gcd}}||{!toggle(AoE)&player.buff(Lightning Crash).duration<gcd}'},
	{'Stormstrike', '!talent(4,3)&player.area(8).enemies>2'},
	{'Stormstrike', 'player.buff(Stormbringer)'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<gcd'},
	{'Flametongue', 'player.buff(Flametongue).remains<gcd'},
	{'Windsong'},
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)'},
	{'Stormstrike'},
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>50'},
	{'Lava Lash', 'player.buff(Hot Hand)'},
	{'Lava Lash', 'player.maelstrom>40'},
	{'Earthen Spike'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<4.5'},
	{'Flametongue', 'player.buff(Flametongue).remains<4.5'},
	{'Sundering'},
	{'Rockbiter'},
	{'Flametongue'}
}

local Ranged = {
	{'Lightning Bolt', '!target.inMelee&range<41&InFront', 'target'},
	{'Feral Lunge', 'range>10&range<25&InFront', 'target'}
}

local inCombat = {
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.range<41'},
	{Survival},
	{Party},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'ui(mythic_fel)&inMelee'},
	{xCombat, 'target.inMelee&target.inFront'},
	{Ranged},
	{'Ghost Wolf', 'movingfor>0.75&target.range>=12!buff', 'player'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<41'}
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement (default)',
	ic = {
		{inCombat, '!player.lastcast(Feral Spirit)'},
		{'Crash Lightning', 'inMelee&inFront&player.lastcast(Feral Spirit)', 'target'},
	},
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
