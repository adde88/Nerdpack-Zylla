local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	-- Logo
	{type = "texture", texture = "Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp", width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Tier 3 Talent Totems @ cursor', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',									  	      align = 'center'},
	{type = 'checkbox', text = 'Enable Healing Surge',								key = 'E_HS',           default = false},
	{type = 'spinner', 	text = 'Healing Surge below HP%',             key = 'HS_HP',          default = 20},
	{type = 'spinner', 	text = 'Astral Shift below HP%',             	key = 'AS_HP',          default = 40},
	{type = 'checkbox', text = 'Use Rainfall to Heal Player',					key = 'E_RF_PL',        default = true},
	{type = 'spinner', 	text = 'below HP%',             							key = 'P_RF_HP',       	default = 33},
	{type = 'spinner',	text = 'Healthstone',										      key = 'HS',						  default = 30},
	{type = 'spinner',	text = 'Ancient Healing Potion',		 			    key = 'AHP',	  				default = 25},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Group/Party stuff...
	{type = 'header', 	text = 'Party/Group',									  	    align = 'center'},
	{type = 'checkbox', text = 'Heal Lowest Party Member',						key = 'E_HEAL',        default = false},
	{type = 'spinner', 	text = 'below HP%',             							key = 'L_HS_HP',       default = 33},
	{type = 'checkbox', text = 'Use Rainfall to Heal Party',					key = 'E_HEAL_RF',     default = false},
	{type = 'spinner', 	text = 'below HP%',             							key = 'L_RF_HP',       default = 25},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', 									align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', 											key = 'kT1', 						default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 											key = 'kT2',						default = false},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', 					key = 'kRoCF', 					default = false},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', 				default = false},
	{type = 'spinner',	text = '', 																		key = 'k_HeirHP', 			default = 40},
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
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	{'!Earthgrab Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	{'!Voodoo Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	{'!Wind Rush Totem', 'keybind(lcontrol)' , 'cursor.ground'}
}

local PreCombat = {
	{'Healing Surge', '!moving&player.health<80', 'player'},
	{'Ghost Wolf', 'movingfor>0.75&!player.buff(Ghost Wolf)'}
}

local Survival = {
	{'!Healing Surge', '!moving&UI(E_HS)&player.health<UI(HS_HP)&player.maelstrom>10', 'player'},
	{'!Rainfall', 'UI(E_RF_PL)&player.health<UI(P_RF_HP)&player.maelstrom>10&range<41', 'player.ground'},
	{'#127834', 'item(127834).count>0&player.health<UI(AHP)'},        -- Ancient Healing Potion
  {'#5512', 'item(5512).count>0&player.health<UI(HS)', 'player'}	  --Health Stone
}

local Party = {
	{'!Healing Surge', '!moving&UI(E_HEAL)&health<UI(L_HS_HP)&player.maelstrom>10&range<41', 'lowest'},
	{'!Rainfall', 'advanced&UI(E_HEAL_RF)&health<UI(L_RF_HP)&player.maelstrom>10&range<41', 'lowest.ground'}
}

local Cooldowns = {
	{'Astral Shift', 'player.health<=(AS_HP)', 'player'},
	{'Feral Spirit', 'player.buff(Ascendance)||player.hashero', 'player'},
	{'Berserking', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<110', 'player'},
	{'Blood Fury', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<110', 'player'},
	{'Doom Winds', '{player.spell(Flametongue).cooldown<gcd}||{talent(4,3)&player.spell(Frostbrand).cooldown<gcd}', 'player'},
	{'Ascendance', 'player.spell(Feral Spirit).cooldown<gcd', 'player'}
}

local Interrupts = {
	{'!Wind Shear', 'target.inFront'},
	{'!Lightning Surge Totem', 'advanced&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)', 'target.ground'}
}

local Interrupts_Random = {
	{'!Wind Shear', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&range<41', 'enemies'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)&range<41', 'enemies.ground'}
}

local xCombat = {
	{'Windstrike', 'player.buff(Ascendance)||lastcast(Ascendance)'},
	{'Crash Lightning', '{toggle(AoE)&{player.area(8).enemies>=2||player.buff(Lightning Crash).duration<gcd}}||{!toggle(AoE)&player.buff(Lightning Crash).duration<gcd}'},
	{'Crash Lightning', 'lastgcd(Feral Spirit)'},
	{'Stormstrike', '!talent(4,3)&player.area(8).enemies>2'},
	{'Stormstrike', 'player.buff(Stormbringer)'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<gcd'},
	{'Flametongue', 'player.buff(Flametongue).remains<gcd'},
	{'Windsong'},
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)'},
	{'Stormstrike'},
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>50'},
	{'Lava Lash', 'player.buff(Hot Hand)'},
	{'Earthen Spike'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<4.5'},
	{'Flametongue', 'player.buff(Flametongue).remains<4.5'},
	{'Sundering'},
	{'Rockbiter'},
	{'Flametongue'}
}

local Ranged = {
	{'Lightning Bolt', 'range>8&range<41&InFront', 'target'},
	{'Feral Lunge', 'range>10&range<25&InFront', 'target'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.range<41'},
	{Survival},
	{Party},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'target.inMelee&target.inFront'},
	{Ranged}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<41'}
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement (default)',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
