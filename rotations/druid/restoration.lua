local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	--XXX: Header
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
	--XXX: Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																		align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',																			key = 'kDBM', 					default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',														key = 'prepot', 				default = false},
	{type = 'combo',		default = '1',																												key = 'list', 					list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkbox', text = 'Dispel Everyone',																							key = 'dispelall', 			default = true},
	{type = 'checkspin',text = 'DPS while party is above HP%',																key = 'dps',						check = true,	align = 'left', width = 55, step = 5, shiftStep = 10, spin = 90, max = 100},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																	key = 'LJ',							check = true,	align = 'left', width = 55, step = 1, shiftStep = 5, spin = 4,	max = 20, min = 1,desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkspin',text = 'Emergency HP',																								key = 'emergency',			check = true, align = 'left', width = 55, step = 5, shiftStep = 10, spin = 33, max = 100},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Rejuvenation - units count:', 																key = 'massrejuv', 			check = false, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 8, max = 40},
	{type = 'spinner', 	text = 'Rejuvenation - health cap:', 																	key = 'massrejuv_hp', 	check = true, align = 'left', width = 55, step = 5, shiftStep = 10, default = 95, max = 100, desc = Zylla.ClassColor..'Select how many units to give Rejuvenation, and set a health-cap!|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																							key = 'trinket1',				default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																							key = 'trinket2', 			default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'header', 	size = 12, text = 'Tranquility Settings:', 														align = 'left'},
	{type = 'checkbox', text = 'Enable',																											key = 'tcheck', 				default = true},
	{type = 'spinner', 	text = 'Health:', 																										key = 'thp', 	 					align = 'left', width = 55, step = 5, shiftStep = 10, default = 75, max = 100},
	{type = 'spinner', 	text = 'Units:', 																											key = 'tunits', 				align = 'left', width = 55, step = 1, shiftStep = 2, default = 2, max = 10, desc = Zylla.ClassColor..'\'Unit-count\' and \'healt-count\' to trigger Tranquility. (40yd radius!)|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	--XXX: PLAYER
	{type = 'header', 	size = 16, text = 'Self Healing:',																		align = 'center'},
	{type = 'checkbox', text = 'Dispel Player',																								key = 'dispelself', 		default = true},
	{type = 'checkspin',text = 'Essence of G\'Hanir',																					key = 'peog',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 50, max = 100},
	{type = 'checkspin',text = 'Lifebloom',																										key = 'plb',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 99, max = 100, desc = Zylla.ClassColor..'Lifebloom and Essence of Gh\'hanir will only be used on yourself when NOT in party!|r'},
	{type = 'checkspin',text = 'Rejuvenation',																								key = 'prejuv',					check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 99, max = 100},
	{type = 'checkspin',text = 'Germination',																									key = 'pgerm',					check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 90, max = 100},
	{type = 'checkspin',text = 'Swiftmend',																										key = 'psm',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 80, max = 100},
	{type = 'checkspin',text = 'Healing Touch',																								key = 'pht',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 90, max = 100},
	{type = 'checkspin',text = 'Regrowth',																										key = 'prg',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 60, max = 100},
	{type = 'checkspin',text = 'Ironbark',              																			key = 'tbark',          check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 20, max = 40},
	{type = 'checkspin',text = 'Cenarion Ward',              																	key = 'pcw',          	check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 66, max = 100},
	{type = 'checkspin',text = 'Barkskin',              																			key = 'bark',          	check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 40, max = 100},
	{type='ruler'},		{type='spacer'},
	--XXX: TANK
	{type = 'header', 	size = 16, text = 'Tank Healing:',																		align = 'center'},
	{type = 'checkspin',text = 'Rejuvenation',																								key = 'trejuv',					check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 99, max = 100},
	{type = 'checkspin',text = 'Germination',																									key = 'tgerm',					check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 90, max = 100},
	{type = 'checkspin',text = 'Swiftmend',																										key = 'tsm',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 80, max = 100},
	{type = 'checkspin',text = 'Healing Touch',																								key = 'tht',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 90, max = 100},
	{type = 'checkspin',text = 'Regrowth',																										key = 'trg',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 60, max = 100},
	{type = 'checkspin',text = 'Ironbark',              																			key = 'tbark',          check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 20, max = 40},
	{type='ruler'},		{type='spacer'},
	--XXX: LOWEST
	{type = 'header', 	size = 16, text = 'Lowest Healing', 																	align = 'center'},
	{type = 'header', 	size = 12, text = 'Essence of G\'Hanir Settings:', 										align = 'left'},
	{type = 'checkbox', text = 'Enable',																											key = 'leog_check', 		default = true},
	{type = 'spinner', 	text = 'Health:', 																										key = 'leog_hp', 	 			align = 'left', width = 55, step = 5, shiftStep = 10, default = 75, max = 100},
	{type = 'spinner', 	text = 'Units:', 																											key = 'leog_units', 		align = 'left', width = 55, step = 1, shiftStep = 2, default = 2, max = 10, desc = Zylla.ClassColor..'\'Unit-count\' and \'healt-count\' to trigger Essence of Gh\'hanir. (40yd radius!)|r'},
	{type = 'header', 	size = 12, text = 'Wild Growth Settings:', 														align = 'left'},
	{type = 'checkbox', text = 'Enable',																											key = 'wg_check', 			default = true},
	{type = 'spinner', 	text = 'Health:', 																										key = 'wg_hp', 	 				align = 'left', width = 55, step = 5, shiftStep = 10, default = 75, max = 100},
	{type = 'spinner', 	text = 'Units:', 																											key = 'wg_units', 			align = 'left', width = 55, step = 1, shiftStep = 2, default = 3, max = 10, desc = Zylla.ClassColor..'\'Unit-count\' and \'healt-count\' to trigger Wild Growth. (30yd radius!)|r'},
	{type = 'header', 	size = 12, text = 'Efflorescence Settings:', 													align = 'left'},
	{type = 'checkbox', text = 'Enable',																											key = 'eff_check', 			default = true},
	{type = 'spinner', 	text = 'Health:', 																										key = 'eff_hp', 	 			align = 'left', width = 55, step = 5, shiftStep = 10, default = 80, max = 100},
	{type = 'spinner', 	text = 'Units:', 																											key = 'eff_units', 			align = 'left', width = 55, step = 1, shiftStep = 2, default = 3, max = 10, desc = Zylla.ClassColor..'\'Unit-count\' and \'healt-count\' to trigger Efflorescence. (30yd radius!)|r'},
	{type = 'checkspin',text = 'Flourish', 																										key = 'flourish', 			check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 60, max = 100},
	{type = 'checkspin',text = 'Rejuvenation', 																								key = 'lrejuv', 				check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 90, max = 100},
	{type = 'checkspin',text = 'Germination', 																								key = 'lgerm', 					check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 75, max = 100},
	{type = 'checkspin',text = 'Swiftmend', 																									key = 'lsm', 						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 90, max = 100},
	{type = 'checkspin',text = 'Healing Touch', 																							key = 'lht',						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 90, max = 100},
	{type = 'checkspin',text = 'Regrowth', 																										key = 'lrg', 						check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 60, max = 100},
	{type = 'checkspin',text = 'Ironbark',              																			key = 'lbark',          check = true, align = 'left', width = 55, step = 1, shiftStep = 5, spin = 15, max = 40},
	{type='ruler'},		{type='spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDruid |cffADFF2FRestoration |r')
	print('|cffADFF2F --- |r')
	print('|cffADFF2F --- |rCheck Settings to go over important healing stuff! |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON.')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

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
	{'Skull Bash', 'player.form~=0&inMelee&inFront'},
	{'!Mighty Bash', 'spell(Skull Bash).cooldown>gcd&!player.lastcast(Skull Bash)&inMelee&inFront'},
	{'!Typhoon', 'spell(Skull Bash).cooldown>gcd&!player.lastcast(Skull Bash)&range&range<=15&inFront'},
}

local DPS = {
	{'Moonfire', 'debuff.duration<3&range<41&combat'},
	{'Sunfire', 'debuff.duration<3&range<41&combat'},
	{'Solar Wrath', 'debuff(Moonfire)&debuff(Sunfire)&range<41&combat&alive'},
}

local Innervate = {
	{'Rejuvenation', '!buff'},
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination))'},
	{'Regrowth', '!player.moving'},
}

local TreeForm = {
	{'Rejuvenation', '!buff||buff.duration<5.5'},
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination)).duration<5.5'},
	{'Wild Growth', '!player.moving'},
	{'Regrowth'},
}

local Emergency = {
	{'!Swiftmend'},
	{'!Regrowth' ,'!player.moving'},
}

local Cooldowns = {
	{'Incarnation: Tree of Life', '!player.buff&area(30,50)>=2', 'lowest'},
	{'Tranquility', '@Zylla.areaHeal(40, thp, tunits)'},	--XXX: Custom Lib to make AoE Heals more customizable. ;)  --Zylla
	{'Innervate', 'player.mana<60'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
}

local Mitigations = {
	{'Barkskin', 'UI(bark_check)&health<UI(bark_spin)', 'player'},
	{'Ironbark', 'UI(tbark_check)&health<UI(tbark_spin)&!is(player)', 'tank'},
	{'Ironbark', 'UI(lbark_check)&health<UI(lbark_spin)&!is(player)', 'lowest'},
}

local Mass_Rejuv = {
	{'Rejuvenation', 'range<41&alive&count(Rejuvenation).friendly.buffs<=UI(massrejuv_spin)&health<=UI(massrejuv_hp)&{buff.duration<2||!buff}'}
}

local SelfHealing = {
	{'Lifebloom', 'UI(plb_check)&group.members==0&buff.duration<5.5'},
	{'Essence of G\'Hanir', 'UI(peog_check)&group.members==0&health<=UI(peog_spin)'},
	{'Rejuvenation', 'UI(prejuv_check)&buff.duration<5.5'},
	{'Rejuvenation', 'UI(pgerm_check)&talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(pgerm_spin)'},
	{'Cenarion Ward', 'UI(pcw_check)&!buff&health<=UI(pcw_spin)'},
	{'Healing Touch', 'UI(pht_check)&!player.moving&health<=UI(pht_spin)'},
	{'Regrowth', 'UI(prg_check)&!player.moving&health<=UI(prg_spin)'},
	{'Swiftmend', 'UI(psm_check)&health<=UI(psm_spin)'},
}

local xHealing = {
	{Emergency, 'UI(emergency_check)&health<=UI(emergency_spin)&!is(player)', 'lowest'},
	{Innervate, 'player.buff(Innervate)&!is(player)', 'lowest'},
	--XXX: Lifebloom on main-tank
	{'Lifebloom', 'buff.duration<5.5&!is(player)', 'tank'},
	--XXX: Cenarion Ward
	{'Cenarion Ward', '!buff&!is(player)', {'tank', 'tank2', 'lowest'}},
	--XXX: AoE Stuff....
	{'Wild Growth', '!player.moving&UI(wg_check)&@Zylla.areaHeal(30, wg_hp, wg_units)', 'lowest'},	--XXX: Custom Lib to make AoE Heals more customizable. ;)  --Zylla
	{'Essence of G\'Hanir', 'UI(leog_check)&@Zylla.PareaHeal(30, leog_hp, leog_units)', 'player'},	--XXX: Custom Lib to make AoE Heals more customizable. ;)  --Zylla
	{'Flourish', 'UI(flourish_check)&player.lastcast(Wild Growth)&health<=UI(flourish_spin)', 'lowest'},
	{'Efflorescence', 'UI(eff_check)&@Zylla.areaHeal(10, eff_hp, eff_units)&mushrooms==0', 'lowest.ground'},
	--XXX: Rejuvenation
	{'Rejuvenation', 'UI(trejuv_check)&health<=UI(trejuv_spin)&!buff&!is(player)', {'tank', 'tank2'}},
	{'Rejuvenation', 'UI(lrejuv_check)&health<=UI(lrejuv_spin)&!buff&!is(player)', 'lowest'},
	--XXX: Germination
	{'Rejuvenation', 'UI(tgerm_check)&talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(tgerm_spin)&!is(player)', {'tank', 'tank2'}},
	{'Rejuvenation', 'UI(lgerm_check)&talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(lgerm_spin)&!is(player)', 'lowest'},
	--XXX: Swiftmend
	{'Swiftmend', 'UI(tsm_check)&health<=UI(tsm_spin)&!is(player)', {'tank', 'tank2'}},
	{'Swiftmend', 'UI(lsm_check)&health<=UI(lsm_spin)&!is(player)', 'lowest'},
	--XXX: Regrowth
	{'Regrowth', 'player.buff(Clearcasting)', 'lowest'},
	{'Regrowth', 'UI(trg_check)&!player.moving&health<=UI(trg_spin)&!is(player)', {'tank', 'tank2'}},
	{'Regrowth', 'UI(lrg_check)&!player.moving&health<=UI(lrg_spin)&!is(player)', 'lowest'},
	--XXX: Healing Touch
	{'Healing Touch', 'UI(tht_check)&!player.moving&health<=UI(tht_spin)&!is(player)', {'tank', 'tank2'}},
	{'Healing Touch', 'UI(lht_check)&!player.moving&health<=UI(lht_spin)&!is(player)', 'lowest'},
}

local inCombat = {
	{'%dispelall(Nature\'s Cure)', 'UI(dispelall)'},
	{'%dispelself(Nature\'s Cure)', 'UI(dispelself)'},
	{Keybinds},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)', 'target'},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)&toggle(xIntRandom)', 'enemies'},
	{Mitigations},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xHealing},
	{SelfHealing, nil, 'player'},
	{TreeForm, 'player.form==4&player.buff(Incarnation: Tree of Life)', 'lowest'},
	{DPS, 'UI(dps_check)&lowest.health>=UI(dps_spin)', 'enemies'},
	{Mass_Rejuv, 'UI(massrejuv_check)', 'enemies'},
	{Mythic_Plus, 'range<=40'},
	{'Cat Form', 'movingfor>0.8&toggle(xFORM)&!buff(Cat Form)&{!buff(Travel Form)||area(8).enemies.inFront>0}', 'player'},
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
