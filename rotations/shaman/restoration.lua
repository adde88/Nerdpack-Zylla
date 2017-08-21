local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
	{type = 'texture', texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	 {type = 'spacer'},
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Astral Shift', key = 'S_ASE', default = true},
	{type = 'spinner', text = '', key = 'S_AS', default = 40},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = '', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = '', key = 'S_AHP', default = 20},
	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'L-Shift: Healing Rain @ Cursor', key = 'K_HR', default = true},
	{type = 'checkbox', text = 'L-Control: Lightning Surge Totem @ Cursor', key = 'K_LST', default = true},
	{type = 'checkbox', text = 'L-Alt: Cloudburst Totem @ Cursor', key = 'K_CT', default = true},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Healing Stream Totem
	{type = 'header', text = 'Healing Stream Totem', align = 'center'},
	{type = 'checkbox', text = 'Enable Healing Stream Totem', key = 'To_HSTE', default = true},
	{type = 'text', text = 'Deploy totem on cooldown.'},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Earthen Shield Totem
	{type = 'header', text = 'Earthen Shield Totem', align = 'center'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required to deploy Earthen Shield Totem on top of tank.|r'},
	{type = 'checkbox', text = 'Enable Earthen Shield Totem', key = 'To_ESTE', default = true},
	{type = 'text', text = 'Deploy totem on cooldown.'},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Emergency Healing
	{type = 'header', text = 'Emergency Healing', align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Healing', key = 'E_EH', default = true},
	{type = 'text', text = 'Riptide'},
	{type = 'spinner', text = 'Riptide', key = 'E_RT', default = 25},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'E_HSG', default = 35},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Tank Healing
	{type = 'header', text = 'Tank Healing', align = 'center'},
	{type = 'text', text = 'Force Riptide'},
	{type = 'spinner', text = '', key = 'T_FRT', default = 90},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'T_HS', default = 80},
	{type = 'spacer'},
	{type = 'header', text = 'AoE Tank Healing', align = 'center'},
	{type = 'text', text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of tank.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', key = 'T_HRE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'checkbox', text = 'Enable Chain Heal', key = 'T_CHE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Player Healing
	{type = 'header', text = 'Player Healing', align = 'center'},
	{type = 'text', text = 'Force Riptide'},
	{type = 'spinner', text = '', key = 'P_FRT', default = 85},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'P_HS', default = 75},
	{type = 'spacer'},
	{type = 'header', text = 'AoE Player Healing', align = 'center'},
	{type = 'text', text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of player.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', key = 'P_HRE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'checkbox', text = 'Enable Chain Heal', key = 'P_CHE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Lowest Healing
	{type = 'header', text = 'Lowest Healing', align = 'center'},
	{type = 'text', text = 'Force Riptide'},
	{type = 'spinner', text = '', key = 'L_FRT', default = 80},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'L_HS', default = 70},
	{type = 'text', text = 'Healing Wave'},
	{type = 'spinner', text = '', key = 'L_HW', default = 100},
	{type = 'spacer'},
	{type = 'header', text = 'AoE Lowest Healing', align = 'center'},
	{type = 'text', text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of lowest health player.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', key = 'L_HRE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'checkbox', text = 'Enable Chain Heal', key = 'L_CHE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'ruler'},{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rShaman |cffADFF2FRestoration |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/2 - 3/1 - 4/2 - 5/3 - 6/2 - 7/X')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

NeP.Interface:AddToggle({
	key = 'zyDPS',
	name = 'Enable DPS',
	text = 'Use damaging abilites when possible, between healing!',
	icon = 'Interface\\Icons\\spell_fire_lavaspawn',
})

NeP.Interface:AddToggle({
	key = 'xIntRandom',
	name = 'Interrupt Anyone',
	text = 'Interrupt all nearby enemies, without targeting them. Might require advanced unlocker on some routines!',
	icon = 'Interface\\Icons\\inv_ammo_arrow_04',
})

NeP.Interface:AddToggle({
	key = 'disp',
	name = 'Dispel',
	text = 'Enable/Disable Dispel!',
	icon = 'Interface\\Icons\\ability_shaman_cleansespirit',
})

end

local Survival = {
	{'&Astral Shift', 'UI(S_ASE)&health<=UI(S_AS)', 'player'},
	{'&Gift of the Naaru', 'UI(S_GOTNE)&health<=UI(S_GOTN)', 'player'},
	{'#127834', 'item(127834).count>0&health<UI(S_AHP)', 'player'},       -- Ancient Healing Potion
  {'#5512', 'item(5512).count>0&health<UI(S_HS)', 'player'},  					--Health Stone
}

local Keybinds = {
	{'!Healing Rain', 'UI(K_HR)&keybind(lshift)', 'cursor.ground'},
	{'!Lightning Surge Totem', 'UI(K_LST)&keybind(lcontrol)', 'cursor.ground'},
	{'!Cloudburst Totem', 'UI(K_CT)&keybind(lalt)', 'cursor.ground'},
}

local Totems = {
	{'Healing Stream Totem', 'UI(To_HSTE)&player.area(40,80).heal>1'},
	{'Earthen Shield Totem', 'advanced&UI(To_ESTE)&range<41', 'tank.ground'},
}

local Emergency = {
	{'!Riptide', 'UI(E_EH)&health<=UI(E_RT)', 'lowest'},
	{'!Healing Surge', '!moving&UI(E_EH)&health<=UI(E_HSG)', 'lowest'},
}

local Interrupts = {
	{'!Wind Shear', 'range<31&interruptAt(70)'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&range<31&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)', 'target.ground'},
}

local Interrupts_Random = {
	{'!Wind Shear', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&range<31', 'enemies'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)&inFront&range<31', 'enemies.ground'},
}

local Dispel = {
	{'%dispelall'},
}

local DPS = {
	{'Flame Shock', '!debuff(Flame Shock)', 'target'},
	{'Lava Burst', 'debuff(Flame Shock).duration>player.spell(Lava Burst).casttime', 'target'},
	{'Chain Lightning', 'area(10).enemies>1', 'target'},
	{'Lightning Bolt', nil, 'target'},
}

local Tank = {
	{'Riptide', 'buff(Riptide).duration<6||health<=UI(T_FRT)', 'tank'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'health<=UI(T_HS)', 'tank'},
		{'Healing Rain', 'advanced&UI(T_HRE)&toggle(AoE)&area(10,90).heal>0', 'tank.ground'},
		{'Chain Heal', 'UI(T_CHE)&toggle(AoE)&area(40,80).heal>1', 'tank'},
	}, {'!moving||{player.buff(Spiritwalker\'s Grace)&moving}'}},
}

local Player = {
	{'Riptide', 'buff(Riptide).duration<6||health<=UI(P_FRT)', 'player'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'health<=UI(P_HS)', 'player'},
		{'Healing Rain', 'advanced&UI(P_HRE)&toggle(AoE)&area(10,90).heal>1', 'player.ground'},
		{'Chain Heal', 'UI(P_CHE)&toggle(AoE)&area(40,80).heal>1', 'player'},
	}, {'!moving||{player.buff(Spiritwalker\'s Grace)&moving}'}},
}

local Lowest = {
	{'Riptide', 'buff(Riptide).duration<6||health<=UI(L_FRT)', 'lnbuff(Riptide)'},
	{{ -- Spiritwalker's Grace
		{'Healing Wave', 'health<=UI(L_HW)', 'lowest'},
		{'Healing Rain', 'advanced&UI(L_HRE)&toggle(AoE)&area(10,90).heal>1', 'lowest.ground'},
		{'Chain Heal', 'UI(L_CHE)&toggle(AoE)&area(40,80).heal>1', 'lowest'},
		{'Healing Surge', 'health<=UI(L_HS)', 'lowest'},
	}, {'!moving||{player.buff(Spiritwalker\'s Grace)&moving}'}},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{'%dispelall', 'toggle(disp)'},
	{Survival},
	{Emergency, 'range<41'},
	{Totems},
	{Tank, 'range<41&tank.exists&tank.health<100'},
	{Lowest, 'range<41&&lowest.health<100'},
	{Player, 'range<41&player.health<100'},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.range<41'},
	{DPS, 'toggle(zyDPS)&range<41&inFront'},
}

local outCombat = {
	{Dispel, 'toggle(zyDISP)&player.spell(Purify Spirit).cooldown<gcd'},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.range<41'},
	{'Riptide', 'health<100', 'lnbuff(Riptide)'},
	{Lowest, 'lowest.health<100'},
	{'Ghost Wolf', 'movingfor>0.75&!player.buff(Ghost Wolf)'},
}

NeP.CR:Add(264, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Restoration',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
