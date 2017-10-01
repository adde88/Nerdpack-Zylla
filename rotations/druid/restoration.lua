local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																				align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',										align = 'left', 		key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Efflorescence|r',						align = 'left', 		key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',													align = 'left', 		key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',													align = 'left', 		key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																					key = 'chat', 			width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																		align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',																			key = 'kDBM', 					default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',														key = 'prepot', 				default = false},
	{type = 'combo',		default = '1',																												key = 'list', 					list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																	key = 'LJ',							spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'spinner', 	text = 'Emergency HP',																								key = 'k_CH',						default = 33},
	{type = 'spinner', 	text = 'DPS while ppl. are above HP%',																key = 'k_DPSHP',				default = 90},
	{type = 'spinner', 	text = 'Rejuvenation - Player cap.', 																	key = 'REJUV_UNITS', 		align = 'left', width = 55, step = 1, default = 8, max = 40},
	{type = 'spinner', 	text = 'Rejuvenation - only below HP%', 															key = 'MASS_REJUV_HP', 	align = 'left', width = 55, step = 5, default = 95, max = 100},
	{type = 'checkbox', text = 'Use Trinket #1', 																							key = 'trinket1',				default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																							key = 'trinket2', 			default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type='ruler'},		{type='spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',																										align = 'center'},
	{type = 'checkspin',text = 'Barkskin',              																			key = 'bark',          	spin = 40, step = 5, shiftStep = 10, max = 100, min = 1, check = true},

	{type = 'ruler'},	  {type = 'spacer'},
	-- TANK
	{type = 'header', 	size = 16, text = 'Tank Healing',																			align = 'center'},
	{type = 'spinner', 	text = 'Rejuvenation',																								key = 'trejuv',					default = 99},
	{type = 'spinner', 	text = 'Germination',																									key = 'tgerm',					default = 90},
	{type = 'spinner', 	text = 'Swiftmend',																										key = 'tsm',						default = 80},
	{type = 'spinner', 	text = 'Healing Touch',																								key = 'tht',						default = 90},
	{type = 'spinner', 	text = 'Regrowth',																										key = 'trg',						default = 60},
	{type = 'checkspin',text = 'Ironbark',              																			key = 'tbark',          spin = 20, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type='ruler'},		{type='spacer'},
	-- LOWEST
	{type = 'header', 	size = 16, text = 'Lowest Healing', 																	align = 'center'},
	{type = 'spinner', 	text = 'Rejuvenation', 																								key = 'lrejuv', 				default = 90},
	{type = 'spinner', 	text = 'Germination', 																								key = 'lgerm', 					default = 75},
	{type = 'spinner', 	text = 'Swiftmend', 																									key = 'lsm', 						default = 80},
	{type = 'spinner', 	text = 'Healing Touch', 																							key = 'lht',						default = 90},
	{type = 'spinner', 	text = 'Regrowth', 																										key = 'lrg', 						default = 60},
	{type = 'checkspin',text = 'Ironbark',              																			key = 'lbark',          spin = 15, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type='ruler'},		{type='spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDruid |cffADFF2FRestoration |r')
	print('|cffADFF2F --- |')
	print('|cffADFF2F --- |rCheck Setting to go over important healing stuff! |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON.')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xDPS',
		name = 'DPS',
		text = 'Do damage in combat when possible.',
		icon = 'Interface\\Icons\\ability_backstab',
	})

	NeP.Interface:AddToggle({
		key='xStealth',
		name='Auto Stealth',
		text = 'If Enabled we will automatically use Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
	})

	NeP.Interface:AddToggle({
		key = 'xFORM',
		name = 'Handle Forms',
		text = 'Automatically handle player forms',
		icon = 'Interface\\Icons\\inv-mount_raven_54',
	})

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
		key = 'xRejuv',
		name = 'Rejuvenation on many players.',
		text = 'Keep Rejuvenation up on several party/raid members. (Units and HP% changable within settings).',
		icon = 'Interface\\Icons\\spell_nature_rejuvenation',
	})

	NeP.Interface:AddToggle({
		key = 'disp',
		name='Dispel',
		text = 'ON/OFF Dispel All',
		icon='Interface\\ICONS\\spell_holy_purify',
	})

end

local PreCombat = {
	{'%pause', 'player.buff(Shadowmeld)'},
	{'Travel Form', 'toggle(xFORM)&movingfor>0.75&!indoors&!buff&!buff(Prowl)', 'player'},
	{'Cat Form', 'toggle(xFORM)&movingfor>0.75&indoors&!buff&!buff(Travel Form)&!buff(Prowl)', 'player'},
	{'Prowl', 'toggle(xFORM)&toggle(xStealth)&!buff&{!buff(Travel Form)||{buff(Travel Form)&target.enemy&target.range<=25}}', 'player'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3', 'player'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3', 'player'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3', 'player'},	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)', 'player'},	--XXX: Flask of the Seventh Demon
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Efflorescence', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'Skull Bash', 'player.form~=0'},
	{'!Mighty Bash', 'spell(Skull Bash).cooldown>gcd&!player.lastcast(Skull Bash)'},
}

local DPS = {
	{'Moonfire', 'debuff.duration<3&range<41&combat'},
	{'Sunfire', 'debuff.duration<3&range<41&combat'},
	{'Solar Wrath', 'debuff(Moonfire)&debuff(Sunfire)&range<41&combat&alive'},
}

local Innervate = {
	{'Rejuvenation', '!buff'},
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination))'},
	{'Regrowth'},
}

local TreeForm = {}

local Emergency = {
	{'!Swiftmend'},
	{'!Regrowth'},
}

local Cooldowns = {
	{'Tranquility', 'player.area(40,75).heal>2'},
	{'Innervate', 'player.mana<60'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
}

local Mitigations = {
	{'Barkskin', 'UI(bark_check)&health<UI(bark_spin)', 'player'},
	{'Ironbark', 'UI(tbark_check)&health<UI(tbark_spin)', 'tank'},
	{'Ironbark', 'UI(lbark_check)&health<UI(lbark_spin)', 'lowest'},
}

local Mass_Rejuv = {
	{'Rejuvenation', 'range<41&alive&count(Rejuvenation).friendly.buffs<=UI(REJUV_UNITS)&buff.duration<3&health<=UI(MASS_REJUV_HP)'}
}

local xHealing = {
	{Emergency, 'health<=UI(k_CH)', 'lowest'},
	{Innervate, 'player.buff(Innervate)', 'lowest'},
	--XXX: Lifebloom on main-tank
	{'Lifebloom', 'buff.duration<5.5&health>=UI(tsm)||!buff', 'tank'},
	--XXX: Cenarion Ward
	{'Cenarion Ward', '!buff', 'tank'},
	{'Cenarion Ward', '!buff', 'tank2'},
	{'Cenarion Ward', '!buff', 'lowest'},
	--XXX: AoE
	{'Wild Growth', '!player.moving&area(30,75).heal>2', 'lowest'},
	{'Essence of G\'Hanir', '!player.moving&player.area(30,75).heal>2'},
	{'Flourish', 'player.lastcast(Wild Growth)&lowest.health<60'},
	--XXX: Rejuv
	{'Rejuvenation', 'health<=UI(trejuv)&!buff', 'tank'},
	{'Rejuvenation', 'health<=UI(trejuv)&!buff', 'tank2)'},
	{'Rejuvenation', 'health<=UI(lrejuv)&!buff', 'lowest'},
	--XXX: Germ
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(lgerm)', 'tank'},
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(lgerm)', 'tank2'},
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(lgerm)', 'lowest'},
	--XXX: Swiftmend
	{'Swiftmend', 'health<=UI(tsm)', 'tank'},
	{'Swiftmend', 'health<=UI(tsm)', 'tank2'},
	{'Swiftmend', 'health<=UI(lsm)', 'lowest'},
	--XXX: Regrowth
	{'Regrowth', 'player.buff(Clearcasting)', 'lowest'},
	{'Regrowth', '!player.moving&health<=UI(trg)', 'tank'},
	{'Regrowth', '!player.moving&health<=UI(trg)', 'tank2'},
	{'Regrowth', '!player.moving&health<=UI(lrg)', 'lowest'},
	--XXX: Healing Touch
	{'Healing Touch', '!player.moving&health<=UI(tht)', 'tank'},
	{'Healing Touch', '!player.moving&health<=UI(tht)', 'tank2'},
	{'Healing Touch', '!player.moving&health<=UI(lht)', 'lowest'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)&inFront&inMelee', 'target'},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)&toggle(xIntRandom)&inFront&inMelee', 'enemies'},
	{Mitigations},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'%dispelall', 'toggle(disp)'},
	{xHealing},
	{DPS, 'toggle(xDPS)&lowest.health>=UI(k_DPSHP)', 'enemies'},
	{Mass_Rejuv, 'toggle(xRejuv)', 'enemies'},
	{Mythic_Plus, 'range<=40'},
	{'Cat Form', 'movingfor>0.75&toggle(xFORM)&!buff(Cat Form)&{!buff(Travel Form)||area(8).enemies.inFront>0}', 'player'},
	{'%pause', 'player.buff(Shadowmeld)'},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
}

NeP.CR:Add(105, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Restoration',
	ic =  {{inCombat, '!player.channeling(Tranquility)'}},
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
