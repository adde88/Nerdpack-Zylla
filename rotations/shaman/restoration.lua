local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
	{type = 'ruler'},{type = 'spacer'},
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
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rShaman |cffADFF2FRestoration |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/2 - 3/1 - 4/2 - 5/3 - 6/2 - 7/X')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local Survival = {
	{'&Astral Shift', 'UI(S_ASE)&player.health<=UI(S_AS)'},
	{'&Gift of the Naaru', 'UI(S_GOTNE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_GOTN)'},
	{'#5512', 'UI(S_HSE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_HS)'},
	{'#127834', 'UI(S_AHPE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_AHP)'},
}

local Keybinds = {
	{'!Healing Rain', 'UI(K_HR)&keybind(lshift)', 'cursor.ground'},
	{'!Lightning Surge Totem', 'UI(K_LST)&keybind(lcontrol)', 'cursor.ground'},
	{'!Cloudburst Totem', 'UI(K_CT)&keybind(lalt)', 'cursor.ground'},
}

local Totems = {
	{'Healing Stream Totem', 'UI(To_HSTE)'},
	{'Earthen Shield Totem', 'advanced&UI(To_ESTE)', 'tank.ground'},
}

local Emergency = {
	{'!Riptide', '{!moving||moving}&{!lowest.debuff(Ignite Soul)}&UI(E_EH)&lowest.health<=UI(E_RT)', 'lowest'},
	{'!Healing Surge', '!moving&UI(E_EH)&{!lowest.debuff(Ignite Soul)}&lowest.health<=UI(E_HSG)', 'lowest'},
}

local Interrupts = {
	{'&Wind Shear'},
}

local Dispel = {
	{'%dispelall'},
}

local DPS = {
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)'},
	{'Lava Burst', 'target.debuff(Flame Shock).duration>spell(Lava Burst).casttime'},
	{'Chain Lightning', 'player.area(40).enemies>=2', 'target'},
	{'Lightning Bolt', nil, 'target'},
}

local Tank = {
	{'Riptide', '{!moving||moving}&tank.buff(Riptide).duration<=5||tank.health<=UI(T_FRT)', 'tank'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'tank.health<=UI(T_HS)', 'tank'},
		{'Healing Rain', 'advanced&UI(T_HRE)&toggle(AoE)&tank.area(10,90).heal>=1', 'tank.ground'},
		{'Chain Heal', 'UI(T_CHE)&toggle(AoE)&tank.area(40,80).heal>=2', 'tank'},
	}, {'!moving||player.buff(Spiritwalker\'s Grace)&moving'}},
}

local Player = {
	{'Riptide', '{!moving||moving}&player.buff(Riptide).duration<=5||player.health<=UI(P_FRT)', 'player'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'player.health<=UI(P_HS)', 'player'},
		{'Healing Rain', 'advanced&UI(P_HRE)&toggle(AoE)&player.area(10,90).heal>=2', 'player.ground'},
		{'Chain Heal', 'UI(P_CHE)&toggle(AoE)&player.area(40,80).heal>=2', 'player'},
	}, {'!moving||player.buff(Spiritwalker\'s Grace)&moving'}},
}

local Lowest = {
	{'Riptide', 'buff(Riptide).duration<=5||health<=UI(L_FRT)', 'lnbuff(Riptide)'},
	{{ -- Spiritwalker's Grace
		{'Healing Wave', 'lowest.health<=UI(L_HW)', 'lowest'},
		{'Healing Rain', 'advanced&UI(L_HRE)&toggle(AoE)&lowest.area(10,90).heal>=2', 'lowest.ground'},
		{'Chain Heal', 'UI(L_CHE)&toggle(AoE)&lowest.area(40,80).heal>=2', 'lowest'},
		{'Healing Surge', 'lowest.health<=UI(L_HS)', 'lowest'},
	}, {'!moving||player.buff(Spiritwalker\'s Grace)&moving'}},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Dispel, '&toggle(yuPS)&spell(Purify Spirit).cooldown<gcd'},
	{Survival},
	{Emergency},
	{Totems},
	{Tank, 'tank.exists&tank.health<100'},
	{Lowest, 'lowest.health<100'},
	{Player, 'player.health<100'},
	{Interrupts, 'toggle(interrupts)&target.interruptAt(70)&target.inFront&target.range<=30'},
	{DPS, 'toggle(yuDPS)&target.range<40&target.inFront'},
}

local outCombat = {
	{Dispel, 'toggle(yuPS)&spell(Purify Spirit).cooldown<gcd'},
	{Interrupts, 'toggle(interrupts)&target.interruptAt(70)&target.inFront&target.range<=30'},
	{'Riptide', 'health<100', 'lnbuff(Riptide)'},
	{Lowest, 'lowest.health<100'},
}

NeP.CR:Add(264, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Restoration',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
