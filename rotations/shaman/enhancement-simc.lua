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
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 				key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Tier 3 Totems|r',align = 'left', 				key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 				key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 				key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 					width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(PayPal_GUI),
	{type = 'spacer'},
	unpack(PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',							 										align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',				default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 			default = true,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',							spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	-- Survival
	{type = 'header', 	text = 'Survival',									  	      						align = 'center'},
	{type = 'checkbox', text = 'Enable Healing Surge',														key = 'E_HS',           default = false},
	{type = 'spinner', 	text = 'Healing Surge below HP%',             						key = 'HS_HP',          default = 50},
	{type = 'spinner', 	text = 'Astral Shift below HP%',             							key = 'AS_HP',          default = 40},
	{type = 'checkspin',	text = 'Healthstone',																		key = 'HS',							spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',																key = 'AHP',						spin = 45, check = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Group/Party stuff...
	{type = 'header', 	text = 'Party/Group',									  	    						align = 'center'},
	{type = 'checkbox', text = 'Heal Lowest Party Member',												key = 'E_HEAL',        default = false},
	{type = 'spinner', 	text = 'below HP%',             													key = 'L_HS_HP',       default = 33},
	{type = 'checkbox', text = 'Use Rainfall to Heal Party',											key = 'E_HEAL_RF',     default = false},
	{type = 'spinner', 	text = 'below HP%',             													key = 'L_RF_HP',       default = 33},
	{type = 'ruler'},	  {type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rShaman |cffADFF2FEnhancement (SimCraft) |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/X - 3/X - 4/3 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
	 key = 'xIntRandom',
	 name = 'Interrupt Anyone',
	 text = 'Interrupt all nearby enemies, without targeting them.',
	 icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'}
}

local PreCombat = {
	{'Healing Surge', '!moving&player.health<80', 'player'},
	{'Ghost Wolf', 'movingfor>0.75&!player.buff(Ghost Wolf)'},
}

local Survival = {
	{'!Healing Surge', '!moving&UI(E_HS)&player.health<=UI(HS_HP)&player.maelstrom>10', 'player'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 													-- Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 																	-- Health Stone
}

local Party = {
	{'!Healing Surge', '!player.moving&UI(E_HEAL)&health<UI(L_HS_HP)&player.maelstrom>10&range<41', 'lowest'},
	{'!Rainfall', 'advanced&UI(E_HEAL_RF)&health<UI(L_RF_HP)&player.maelstrom>10&range<41', 'lowest.ground'}
}

local Cooldowns = {
	{'Astral Shift', 'player.health<=(AS_HP)'},
	{'Feral Spirit', 'player.maelstrom>=20&player.spell(Crash Lightning).cooldown<=gcd'},
	{'Berserking', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<100'},
	{'Blood Fury', 'player.buff(Ascendance)||player.buff(Feral Spirit).duration>5||player.level<100'},
	{'Doom Winds'},
	{'Ascendance', 'player.buff(Stormbringer).react'},
	{'#Trinket1', 'UI(trinket1)'},
	{'#Trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Interrupts = {
	{'!Wind Shear', 'range<36&interruptAt(70)'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&range<36&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)', 'target.ground'},
}

local Interrupts_Random = {
	{'!Wind Shear', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&range<36', 'enemies'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)&range<36', 'enemies.ground'},
}

local xCombat = {
	-- Crash Lightning
	{'Crash Lightning', 'lastgcd(Feral Spirit)', 'target'},
	{'Crash Lightning', 'talent(6,1)&player.area(10).enemies>=3&{!talent(4,3)||player.buff(Frostbrand).duration>gcd}', 'target'},
	{'Crash Lightning', 'player.buff(Crash Lightning).duration<gcd&player.area(10).enemies>=2', 'target'},
	{'Crash Lightning', 'player.area(10).enemies>=3', 'target'},
	{'Crash Lightning', '{{player.area(10).enemies>1||talent(6,1)||talent(7,2)}&!set_bonus(T19)==4}||player.buff(Feral Spirit).duration>5', 'target'},
	{'Crash Lightning', 'set_bonus(T20)>=2&player.buff(Lightning Crash).duration<gcd', 'target'},
	-- Windstrike
	{'Windstrike', 'player.buff(Stormbringer).react&{{talent(6,2)&player.maelstrom>=26}||{!talent(6,2)}}', 'target'},
	{'Windstrike', 'talent(5,2)&player.spell(Lightning Bolt)<gcd&player.maelstrom>80', 'target'},
	{'Windstrike', 'talent(6,2)&player.maelstrom>46&{player.spell(Lightning Bolt)<gcd||!talent(5,2)}', 'target'},
	{'Windstrike', '!talent(5,2)&!talent(6,2)', 'target'},
	-- Stormstrike
	{'Stormstrike', 'player.buff(Stormbringer).react&{{talent(6,2)&player.maelstrom>=26}||{!talent(6,2)}}', 'target'},
	{'Stormstrike', 'talent(5,2)&player.spell(Lightning Bolt)<gcd&player.maelstrom>80', 'target'},
	{'Stormstrike', 'talent(6,2)&player.maelstrom>46&{player.spell(Lightning Bolt)<gcd||!talent(5,2)}', 'target'},
	{'Stormstrike', '!talent(5,2)&!talent(6,2)', 'target'},
	-- Frostbrand
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).duration<gcd&{{!talent(6,2)}||{talent(6,2)&player.maelstrom>25}}', 'target'},
	{'Frostbrand', 'talent(4,3)player.buff(Frostbrand).duration<4.8&{{!talent(6,2)}||{talent(6,2)&player.maelstrom>25}}', 'target'},
	{'Frostbrand', 'equipped(137084)&talent(1,2)&player.buff(Hot Hand).react&!player.buff(Frostbrand)&{{!talent(6,2)}||talent(6,2)&player.maelstrom>25}}', 'target'},
	{'Frostbrand', 'equipped(137084)&!player.buff(Frostbrand)&{{!talent(6,2)}||talent(6,2)&player.maelstrom>25}}', 'target'},
	--Lava Lash
	{'Lava Lash', 'talent(6,2)&talent(5,2)&{set_bonus(T19)==4&player.maelstrom>=80}', 'target'},
	{'Lava Lash', 'talent(6,2)&!talent(5,2)&{set_bonus(T19)==4&player.maelstrom>=53}', 'target'},
	{'Lava Lash', '{!set_bonus(T19)==4&player.maelstrom>=120}||{!talent(6,2)&set_bonus(T19)==4&player.maelstrom>=40}', 'target'},
	{'Lava Lash', 'talent(1,2)&player.buff(Hot Hand).react', 'target'},
	-- Flametongue
	{'Flametongue', 'player.buff(Flametongue).duration<gcd', 'target'},
	{'Flametongue', 'player.buff(Flametongue).remains<gcd||{player.spell(Doom Winds).cooldown<6&player.buff(Flametongue).duration<4}', 'target'},
	{'Flametongue', 'player.buff(Flametongue).duration<4.8', 'target'},
	-- Here comes the rest
	{'Windsong', nil, 'target'},
	{'Fury of Air', 'toggle(AoE)&!player.buff(Fury of Air)&player.maelstrom>22'},
	{'Lightning Bolt', '{talent(5,2)&player.maelstrom>=40&!talent(6,2)}||{talent(5,2)&talent(6,2)player.maelstom>46}', 'target'},
	{'Earthen Spike', nil, 'target'},
	{'Sundering', 'toggle(AoE)&player.area(8).enemies.infront>=3', 'target'},
	{'Rockbiter', 'talent(1,3)&player.buff(Landslide).duration<gcd', 'target'},
}

local Ranged = {
	{'Lightning Bolt', '!target.inMelee&range<41&InFront', 'target'},
	{'Feral Lunge', 'range>10&range<25&InFront', 'target'}
}

local inCombat = {
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'toggle(Interrupts)'},
	{Survival},
	{Party},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'target.inMelee&target.inFront'},
	{Ranged},
	{'Ghost Wolf', 'player.movingfor>0.75&target.range>12'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<41'},
	{'!Healing Surge', '!moving&UI(E_HS)&player.health<90', 'player'},
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement (SimCraft)',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
