local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
	{type = "texture", texture = "Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp", width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Keyinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',	align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',	key = 'kPause',	default = true},
	{type = 'checkbox', text = 'Use Voodoo/Earthgrab Totems (AoE)',	key = 'E_Tots',	default = true},
	{type = 'ruler'},	{type = 'spacer'},
  -- Survival
	{type = 'header', 	text = 'Survival',	align = 'center'},
	{type = 'checkbox', text = 'Use Rainfall on lowest party member',	key = 'E_RF',	default = true},
	{type = 'spinner', 	text = '',	key = 'RF_HP',	default = 75},
	{type = 'checkbox', text = 'Use Healing Surge (SOLO)',	key = 'e_HS',	default = true},
	{type = 'spinner', 	text = '',	key = 'HS_HP',	default = 75},
	{type = 'spinner',	text = 'Healthstone when below HP%',	key = 'HST_HP',	default = 45},
	{type = 'spinner',	text = 'Healing Potion when below HP%',	key = 'AHP_HP',	default = 45},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rShaman |cffADFF2FEnhancement |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/X - 3/X - 4/3 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
		key = 'Heroism',
		name = 'Use Heroism',
		text = 'Automatically use Heroism.',
		icon = 'Interface\\Icons\\ability_shaman_heroism',
	})
end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	{'!Wind Rush Totem', 'keybind(lalt)', 'cursor.ground'},
}

local PreCombat = {
	{'Healing Surge', 'UI(E_HS)&!moving&player.health<UI(HS_HP)', 'player'},
	{'Ghost Wolf', 'movingfor>1&!player.buff(Ghost Wolf)'},
}

local Survival = {
	{'!Healing Surge', 'UI(E_HS)&player.health<UI(HS_HP)&player.maelstrom>10', 'player'},
	{'#127834', 'item(127834).count>0&player.health<UI(HST_HP)'},        -- Ancient Healing Potion
	{'#5512', 'item(5512).count>0&player.health<UI(AHP_HP)', 'player'},  --Health Stone
}

local Cooldowns = {
	{'Heroism', 'toggle(Heroism)'},
	{'Ascendance', 'player.maelstrom>129'},
	{'Feral Spirit'},
	{'Berserking', 'toggle(Heroism)'},
	{'Blood Fury'},
	{'Doom Winds'},
}

local Interrupts_Normal = {
	{'!Wind Shear', 'target.interruptAt(70)&target.range<31&target.inFront', 'target'},
	{'!Lightning Surge Totem', 'advanced&target.range<36&target.interruptAt(1)&player.spell(Wind Shear).cooldown>gcd&!lastgcd(Wind Shear)', 'target.ground'}
}

local Interrupts_Random = {
	{'!Wind Shear', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<31', 'enemies'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Wind Shear).cooldown>gcd&!prev_gcd(Wind Shear)&inFront&range<36', 'enemies.ground'},
}

local Talents = {
	{'Windsong', 'target.range<11&target.inFront'},
	{'Rainfall', 'advanced&UI(E_RF)&health<UI(RF_HP)&range<41', 'lowest.ground'},
	{'Lightning Shield', '!player.buff(Lightning Shield)'},
	{'Feral Lunge', 'target.range>7&target.range<26'},
	{'Earthgrab Totem', 'advanced&target.range<36&UI(E_Tots)&target.area(10).enemies>2', 'target.ground'},
	{'Voodoo Totem', 'advanced&target.range<36&UI(E_Tots)&target.area(10).enemies>2', 'target.ground'},
	{'Fury of Air', 'toggle(AoE)&!player.buff(Fury of Air)'},
	{'Sundering', 'target.inMelee&toggle(AoE)&player.area(8).enemies.inFront>2'},
	{'Earthen Spike', 'target.range<11&target.inFront'},
}

local xCombat = {
	{'Crash Lightning', '{toggle(AoE)}||{!toggle(AoE)&player.buff(Crashing Lightning).duration<gcd}'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).duration<gcd*2'},
	{'Flametongue', 'target.inMelee&!player.buff(Flametongue)'},
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>39'},
	{'Lava Lash', 'player.buff(Hot Hand)||player.maelstrom>39'},
	{'Rockbiter', '{talent(1,3)&talent(7,2)}||{talent(1,3)&!talent(7,2)&!player.buff(Landslide)}||{!talent(1,3)&player.maelstrom<131}'},
}

local Ranged = {
	{'Lightning Bolt'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Survival},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Interrupts_Normal, 'toggle(Interrupts)'},
	{Interrupts_Random},
	{Talents},
	{xCombat, 'target.inMelee&target.inFront'},
	{Ranged, '!target.inMelee&target.range<41target.inFront'},
	{'Stormstrike', '{player.buff(Ascendance)&player.maelstrom>7&target.range<31&target.inFront}||{!player.buff(Stormbringer)&player.maelstrom>39&target.inMelee&target.inFront}||{player.buff(Stormbringer)&player.maelstrom>19&target.inMelee&target.inFront}'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Normal, 'toggle(Interrupts)'},
	{Interrupts_Random},
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
--blacklist = Zylla.Blacklist
})
