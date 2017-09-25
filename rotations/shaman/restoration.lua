local _, Zylla = ...

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																																				align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',																										align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Healing Rain|r',																							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Lightning Surge Totem|r',																			align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'Cloudburst Totem|r',																					align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																																					key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Survival', 																																										align = 'center'},
	{type = 'checkbox', text = 'Enable Astral Shift', 																																				key = 'S_ASE', default = true},
	{type = 'spinner', 	text = 'when below HP%', 																																							key = 'S_AS', default = 40},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', 																																		key = 'S_GOTNE', default = true},
	{type = 'spinner', 	text = 'when below HP%', 																																							key = 'S_GOTN', default = 40},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Healthstone', 																																					key = 'S_HSE', default = true},
	{type = 'spinner', 	text = 'when below HP%', 																																							key = 'S_HS', default = 20},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', 																															key = 'S_AHPE', default = true},
	{type = 'spinner', 	text = 'when below HP%', 																																							key = 'S_AHP', default = 20},
	{type = 'ruler'},		{type = 'spacer'},
	-- Healing Stream Totem
	{type = 'header', 	text = 'Healing Stream Totem', 																																				align = 'center'},
	{type = 'checkbox', text = 'Enable Healing Stream Totem',	 																																key = 'To_HSTE', default = true},
	{type = 'ruler'},		{type = 'spacer'},
	-- Earthen Shield Totem
	{type = 'header', 	text = 'Earthen Shield Totem', 																																				align = 'center'},
	{type = 'text', 		text = '|cffff0000Advanced LUA Unlocker Required!|r'},
	{type = 'checkbox', text = 'Enable Earthen Shield Totem', 																																key = 'To_ESTE', default = true},
	{type = 'text', 		text = 'When more than one players in 10yd. radius drops below 90%', 																	align = 'center'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Ancestral Protection Totem
	{type = 'header', 	text = 'Ancestral Protection Totem', 																																	align = 'center'},
	{type = 'text', 		text = '|cffff0000Advanced LUA Unlocker Required!|r'},
	{type = 'checkbox', text = 'Enable Ancestral Protection Totem', 																													key = 'To_APTE', default = true},
	{type = 'text', 		text = 'When more than two players in 20yd. radius drops below 90%', 																	align = 'center'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Emergency Healing
	{type = 'header', 	text = 'Emergency Healing', 																																					align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Healing', 																																		key = 'E_EH', default = true},
	{type = 'spinner',	text = 'Riptide', 																																										key = 'E_RT', default = 25},
	{type = 'spinner', 	text = 'Healing Surge', 																																							key = 'E_HSG', default = 35},
	{type = 'ruler'},		{type = 'spacer'},
	-- Tank Healing
	{type = 'header', 	text = 'Tank Healing', 																																								align = 'center'},
	{type = 'spinner', 	text = 'Riptide below HP%', 																																					key = 'T_FRT', default = 90},
	{type = 'spinner', 	text = 'Healing Surge below HP%', 																																		key = 'T_HS', default = 80},
	{type = 'spacer'},
	{type = 'header', 	text = 'AoE Tank Healing', 																																						align = 'center'},
	{type = 'text', 		text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', 		text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of tank.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', 																																				key = 'T_HRE', default = true},
	{type = 'spacer'},
	{type = 'text', 		text = 'Active: when 3 or more players within 40yd. are below 80% health.'},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chain Heal', 																																					key = 'T_CHE', default = true},
	{type = 'text', 		text = 'Active: when 3 or more players within 40yd. are below 80% health.'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Player Healing
	{type = 'header', 	text = 'Player Healing', 																																							align = 'center'},
	{type = 'spinner', 	text = 'Force Riptide below HP%', 																																		key = 'P_FRT', default = 85},
	{type = 'spinner', 	text = 'Healing Surge below HP%', 																																		key = 'P_HS', default = 75},
	{type = 'spacer'},
	{type = 'header', 	text = 'AoE Player Healing', 																																					align = 'center'},
	{type = 'text', 		text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', 		text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of player.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', 																																				key = 'P_HRE', default = true},
	{type = 'text', 		text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chain Heal', 																																					key = 'P_CHE', default = true},
	{type = 'text', 		text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Lowest Healing
	{type = 'header', 	text = 'Lowest Healing', 																																							align = 'center'},
	{type = 'spinner', 	text = 'Riptide when below HP%', 																																			key = 'L_FRT', default = 80},
	{type = 'spinner', 	text = 'Healing Surge when below HP%', 																																key = 'L_HS', default = 70},
	{type = 'spinner', 	text = 'Healing Wave when below HP%', 																																key = 'L_HW', default = 96},
	{type = 'spacer'},
	{type = 'header', 	text = 'AoE Lowest Healing', 																																					align = 'center'},
	{type = 'text', 		text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', 		text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of lowest health player.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', 																																				key = 'L_HRE', default = true},
	{type = 'text', 		text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chain Heal', 																																					key = 'L_CHE', default = true},
	{type = 'text', 		text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
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
	{'!Astral Shift', 'UI(S_ASE)&health<=UI(S_AS)', 'player'},
	{'!Gift of the Naaru', 'UI(S_GOTNE)&health<=UI(S_GOTN)', 'player'},
	{'#127834', 'item(127834).count>0&health<UI(S_AHP)', 'player'},       -- Ancient Healing Potion
  {'#5512', 'item(5512).count==3&health<UI(S_HS)', 'player'},  					--Health Stone
	{'Ancestral Guidance', 'player.area(40,60).heal>2'},
}

local Keybinds = {
	{'!Healing Rain', 'UI(K_HR)&keybind(lshift)', 'cursor.ground'},
	{'!Lightning Surge Totem', 'UI(K_LST)&keybind(lcontrol)', 'cursor.ground'},
	{'!Cloudburst Totem', 'UI(K_CT)&keybind(lalt)', 'cursor.ground'},
}

local Totems = {
	{'Healing Stream Totem', 'UI(To_HSTE)&player.area(40,80).heal>1'},
	{'Earthen Shield Totem', 'advanced&UI(To_ESTE)&range<41&area(10,90).heal>1', 'lowest.ground'},
	{'Ancestral Protection Totem', 'advanced&UI(To_APTE)&range<41&area(20,40).heal>2', 'lowest.ground'},
}

local Emergency = {
	{'!Riptide', 'UI(E_EH)&health<=UI(E_RT)', 'lowest'},
	{'!Healing Surge', '!player.moving&UI(E_EH)&health<=UI(E_HSG)', 'lowest'},
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
	{'Lava Burst', '!player.moving&debuff(Flame Shock).duration>player.spell(Lava Burst).casttime', 'target'},
	{'Chain Lightning', '!player.moving&area(10).enemies>1', 'target'},
	{'Lightning Bolt', '!player.moving', 'target'},
}

local Tank = {
	{'Riptide', 'buff(Riptide).duration<6||health<=UI(T_FRT)', 'tank'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'health<=UI(T_HS)', 'tank'},
		{'Healing Rain', 'advanced&UI(T_HRE)&toggle(AoE)&area(10,90).heal>0', 'tank.ground'},
		{'Chain Heal', 'UI(T_CHE)&toggle(AoE)&area(40,80).heal>1', 'tank'},
	}, {'!player.moving||{player.buff(Spiritwalker\'s Grace)&moving}'}},
}

local Player = {
	{'Riptide', 'buff(Riptide).duration<6||health<=UI(P_FRT)', 'player'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'health<=UI(P_HS)', 'player'},
		{'Healing Rain', 'advanced&UI(P_HRE)&toggle(AoE)&area(10,90).heal>1', 'player.ground'},
		{'Chain Heal', 'UI(P_CHE)&toggle(AoE)&area(40,80).heal>1', 'player'},
	}, {'!player.moving||{player.buff(Spiritwalker\'s Grace)&moving}'}},
}

local Lowest = {
	{'Riptide', 'buff(Riptide).duration<6||health<=UI(L_FRT)', 'lnbuff(Riptide)'},
	{{ -- Spiritwalker's Grace
		{'Healing Wave', 'health<=UI(L_HW)', 'lowest'},
		{'Healing Rain', 'advanced&UI(L_HRE)&toggle(AoE)&area(10,90).heal>1', 'lowest.ground'},
		{'Chain Heal', 'UI(L_CHE)&toggle(AoE)&area(40,80).heal>1', 'lowest'},
		{'Healing Surge', 'health<=UI(L_HS)', 'lowest'},
	}, {'!player.moving||{player.buff(Spiritwalker\'s Grace)&moving}'}},
}

local inCombat = {
	{Keybinds},
	{'%dispelall', 'toggle(disp)'},
	{Survival},
	{Emergency, 'range<41'},
	{Totems},
	{Mythic_Plus, 'range<41'},
	{Tank, 'range<41&tank.exists&tank.health<100'},
	{Lowest, 'range<41&&lowest.health<100'},
	{Player, 'range<41&player.health<100'},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.range<41'},
	{DPS, 'toggle(zyDPS)&range<41&inFront'},
	{'Ghost Wolf', 'player.movingfor>0.5&target.range>20&!player.buff(Ghost Wolf)'},
}

local outCombat = {
	{Dispel, 'toggle(zyDISP)&player.spell(Purify Spirit).cooldown<gcd'},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.range<41'},
	{'Riptide', 'health<100', 'lnbuff(Riptide)'},
	{Lowest, 'lowest.health<100'},
	{'Ghost Wolf', 'player.movingfor>0.25&!player.buff(Ghost Wolf)'},
}

NeP.CR:Add(264, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Restoration',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
