local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	--XXX: Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																		align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',								align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Healing Rain|r',					align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Lightning Surge Totem|r',	align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'Cloudburst Totem|r',			align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																			key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	--XXX: Settings
	{type = 'header', 	size = 16, text = 'Survival', 																		align = 'center'},
	{type = 'spinner', 	text = 'Interrupt at % cast',             												key = 'k_inter', default = 70, step = 5, max = 100, min = 1},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 															key = 'LJ', spin = 4,	step = 1,	max = 20, min = 1, check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkspin',text = 'Astral Shift', 																						key = 'S_AS', spin = 40, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Gift of the Naaru', 																			key = 'S_GOTN', spin = 40, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healthstone',																							key = 'HS', spin = 45, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																					key = 'AHP', spin = 45, step = 5, max = 100, min = 1, check = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																					key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																					key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'ruler'},		{type = 'spacer'},
	--XXX: Totems
	{type = 'header', 	size = 16, text = 'Totems', 																			align = 'center'},
	{type = 'checkspin', text = 'Healing Stream Totem',	 																	key = 'To_HSTE', check = true},
	{type = 'checkbox', text = 'Earthen Shield Totem', 																		key = 'To_ESTE', default = true, desc = '|cffFF0000Advanced LUA Unlocker Required!|r\n'..Zylla.ClassColor..'When more than one players in 10yd. radius drops below 90%|r'},
	{type = 'checkbox', text = 'Ancestral Protection Totem', 															key = 'To_APTE', default = true, desc = '|cffFF0000Advanced LUA Unlocker Required!|r\n'..Zylla.ClassColor..'When more than two players in 20yd. radius drops below 40%|r'},
	{type = 'ruler'},
	--XXX: Emergency Healing
	{type = 'header', 	size = 16, text = 'Emergency Healing', 														align = 'center'},
	{type = 'checkspin',text = 'Riptide', 																								key = 'E_RT', spin = 25, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Surge', 																					key = 'E_HSG', spin = 35, step = 5, max = 100, min = 1, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	--XXX: Tank Healing
	{type = 'header', 	size = 16, text = 'Tank Healing', 																align = 'center'},
	{type = 'checkspin',text = 'Riptide', 																								key = 'T_FRT', spin = 90, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Surge', 																					key = 'T_HS', spin = 80, step = 5, max = 100, min = 1, check = true},
	{type = 'spacer'},
	{type = 'header', 	size = 12, text = 'AoE Tank Healing', 														align = 'left'},
	{type = 'text', 		size = 10, text = '|cffFFFF00Toggle Multitarget on NeP Bar.|r', 	align = 'left'},
	{type = 'checkbox', text = 'Healing Rain', 																						key = 'T_HRE', default = true, desc = '|cffFF0000Advanced LUA unlocker required for Healing Rain on-top of tank.|r\n'..Zylla.ClassColor..'Active: when 3 or more players within 40yd. are below 80% health.|r'},
	{type = 'checkbox', text = 'Chain Heal', 																							key = 'T_CHE', default = true, desc = Zylla.ClassColor..'Active: when 3 or more players within 40yd. are below 80% health.|r'},
	{type = 'ruler'},		{type = 'spacer'},
	--XXX: Player Healing
	{type = 'header', 	size = 16, text = 'Player Healing', 															align = 'center'},
	{type = 'checkspin',text = 'Force Riptide', 																					key = 'P_FRT', spin = 85, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Surge', 																					key = 'P_HS', spin = 75, step = 5, max = 100, min = 1, check = true},
	{type = 'spacer'},
	{type = 'header', 	size = 12, text = 'AoE Player Healing', 													align = 'left'},
	{type = 'text', 		size = 10, text = '|cffFFFF00Toggle Multitarget on NeP Bar.|r',		align = 'left'},
	{type = 'checkbox', text = 'Healing Rain', 																						key = 'P_HRE', default = true, desc = '|cffFF0000Advanced LUA unlocker required for Healing Rain ontop of player.|r\n'..Zylla.ClassColor..'Active: when 3 or more players within 40yds. drop below 80% health.|r'},
	{type = 'checkbox', text = 'Chain Heal', 																							key = 'P_CHE', default = true, desc = Zylla.ClassColor..'Active: when 3 or more players within 40yds. drop below 80% health.|r'},
	{type = 'ruler'},		{type = 'spacer'},
	--XXX: Lowest Healing
	{type = 'header', 	size = 16, text = 'Lowest Healing', 															align = 'center'},
	{type = 'checkspin',text = 'Riptide', 																								key = 'L_FRT', spin = 80, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Surge', 																					key = 'L_HS', spin = 70, step = 5, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Wave', 																						key = 'L_HW', spin = 95, step = 5, max = 100, min = 1, check = true},
	{type = 'spacer'},
	{type = 'header', 	size = 12, text = 'AoE Lowest Healing', 													align = 'left'},
	{type = 'text', 		size = 10, text = '|cffFFFF00Toggle Multitarget on NeP Bar.', 		align = 'left'},
	{type = 'checkbox', text = 'Healing Rain', 																						key = 'L_HRE', default = true, desc = '|cffFF0000Advanced LUA unlocker required for Healing Rain ontop of lowest health player.|r\n'..Zylla.ClassColor..'Active: when 3 or more players within 40yds. drop below 80% health.|r'},
	{type = 'checkbox', text = 'Chain Heal', 																							key = 'L_CHE', default = true, desc = Zylla.ClassColor..'Active: when 3 or more players within 40yds. drop below 80% health.|r'},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
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
	{'!Astral Shift', 'UI(S_AS_check)&health<=UI(S_AS_spin)', 'player'},
	{'!Gift of the Naaru', 'UI(S_GOTN_check)&health<=UI(S_GOTN_spin)', 'player'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 																	--XXX: Health Stone
	{'!Ancestral Guidance', 'area(40,60).heal>=3', 'player'},
}

local Keybinds = {
	{'!Healing Rain', 'UI(lshift)&keybind(lshift)', 'cursor.ground'},
	{'!Lightning Surge Totem', 'UI(lcontrol)&keybind(lcontrol)', 'cursor.ground'},
	{'!Cloudburst Totem', 'UI(lalt)&keybind(lalt)', 'cursor.ground'},
}

local Totems = {
	{'Healing Stream Totem', 'UI(To_HSTE)&@Zylla.areaHeal(40,80,1)', 'player'},
	{'Earthen Shield Totem', 'advanced&UI(To_ESTE)&range<41&@Zylla.areaHeal(10,90,1)', 'lowest.ground'},
	{'Ancestral Protection Totem', 'advanced&UI(To_APTE)&range<41&@Zylla.areaHeal(20,40,2)', 'lowest.ground'},
}

local Emergency = {
	{'!Riptide', 'UI(E_RT_check)&health<=UI(E_RT_spin)', 'lowest'},
	{'!Healing Surge', '!player.moving&UI(E_HSG_check)&health<=UI(E_HSG_spin)', 'lowest'},
}

local Interrupts = {
	{'!Wind Shear', 'range<31&casting.percent>=UI(k_inter)', 'target'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(1)&range<31&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)', 'target.ground'},
}

local Interrupts_Random = {
	{'!Wind Shear', 'casting.percent>=UI(k_inter)&toggle(xIntRandom)&toggle(Interrupts)&range<31', 'enemies'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(5)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Wind Shear).cooldown>gcd&!player.lastgcd(Wind Shear)&inFront&range<31', 'enemies.ground'},
}

local Dispel = {
	{'%dispelall'},
}

local DPS = {
	{'Flame Shock', '!debuff(Flame Shock)', 'target'},
	{'Lava Burst', '!player.moving&debuff(Flame Shock).duration>player.spell(Lava Burst).casttime', 'target'},
	{'Chain Lightning', '!player.moving&area(10).enemies>=2', 'target'},
	{'Lightning Bolt', '!player.moving', 'target'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Tank = {
	{'Riptide', 'UI(T_FRT_check)&{buff(Riptide).duration<6||health<=UI(T_FRT_spin)}', 'tank'},
	{{ --XXX: Spiritwalker's Grace
		{'Healing Surge', 'health<=UI(T_HS_spin)', 'tank'},
		{'Healing Rain', 'advanced&UI(T_HRE)&toggle(AoE)&@Zylla.areaHeal(10,90,1)', 'tank.ground'},
		{'Chain Heal', 'UI(T_CHE)&toggle(AoE)&@Zylla.areaHeal(40,80,2)', 'tank'},
	}, {'!player.moving||{player.buff(Spiritwalker\'s Grace)&player.moving}'}},
}

local Player = {
	{'Riptide', 'UI(P_FRT_check)&{buff(Riptide).duration<6||health<=UI(P_FRT_spin)}', 'player'},
	{{ --XXX: Spiritwalker's Grace
		{'Healing Surge', 'health<=UI(P_HS)', 'player'},
		{'Healing Rain', 'advanced&UI(P_HRE)&toggle(AoE)&@Zylla.areaHeal(10,90,1)', 'player.ground'},
		{'Chain Heal', 'UI(P_CHE)&toggle(AoE)&@Zylla.areaHeal(40,80,2)', 'player'},
	}, {'!player.moving||{player.buff(Spiritwalker\'s Grace)&player.moving}'}},
}

local Lowest = {
	{'Riptide', 'UI(L_FRT_check)&{buff(Riptide).duration<6||health<=UI(L_FRT_spin)}', 'lnbuff(Riptide)'},
	{{ --XXX: Spiritwalker's Grace
		{'Healing Wave', 'UI(L_HW_check)&health<=UI(L_HW_spin)', 'lowest'},
		{'Healing Rain', 'advanced&UI(L_HRE)&toggle(AoE)&@Zylla.areaHeal(10,90,1)', 'lowest.ground'},
		{'Chain Heal', 'UI(L_CHE)&toggle(AoE)&@Zylla.areaHeal(40,80,1)', 'lowest'},
		{'Healing Surge', 'UI(L_HS_check)&health<=UI(L_HS_spin)', 'lowest'},
	}, {'!player.moving||{player.buff(Spiritwalker\'s Grace)&player.moving}'}},
}

local inCombat = {
	{Keybinds},
	{'%dispelall', 'toggle(disp)'},
	{Survival},
	{Emergency, 'range<41'},
	{Totems},
	{Mythic_Plus, 'ui(mythic_fel)&range<41'},
	{Tank, 'range<41&tank.exists&tank.health<100'},
	{Lowest, 'range<41&&lowest.health<100'},
	{Player, 'range<41&player.health<100'},
	{Interrupts_Random},
	{Interrupts, 'toggle(Interrupts)&target.range<41'},
	{DPS, 'toggle(zyDPS)&range<41&inFront'},
	{'Ghost Wolf', 'player.movingfor>0.5&target.range>=30&!player.buff(Ghost Wolf)'},
}

local outCombat = {
	{Dispel, 'toggle(zyDISP)&player.spell(Purify Spirit).cooldown<gcd'},
	{Interrupts_Random},
	{Interrupts, 'toggle(Interrupts)&target.range<41'},
	{'Riptide', 'health<100', 'lnbuff(Riptide)'},
	{Lowest, 'lowest.health<100'},
	{'Ghost Wolf', 'player.movingfor>0.25&!player.buff(Ghost Wolf)'},
}

NeP.CR:Add(264, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Restoration',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='800', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
