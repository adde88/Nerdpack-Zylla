local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 		key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 			width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'target',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 			default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',								key = 'prepot', 		default = false},
	{type = 'combo',		default = '3',																						key = 'list', 			list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	text = 'Interrupt at percentage:', 												key = 'intat',			default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkspin',text = 'Brutal Slash - Units', 														key = 'brs_unit',		spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'How many units infront of player?.|r'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',					spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',		default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 	default = false,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 					key = 'kj', 				align = 'left', width = 55, step = 1, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Dots
	{type = 'header', 	size = 16, text = 'DoT Handling:',												align = 'center'},
	{type = 'checkbox', text = 'Enable AoE dots',																	key = 'aoedot',					default = true},
	{type = 'spinner',	text = 'Dot Duration', 																		key = 'ptftimer_spin', 	default = 6, step = 1, shiftStep = 2, max = 20, check = true, desc = Zylla.ClassColor..'Refresh dots when duration is lower than...|r'},
	{type = 'spinner',	text = 'Dot Units', 																			key = 'dot_units', 			default = 4, step = 1, shiftStep = 2, max = 20, check = true, desc = Zylla.ClassColor..'Limit amount of units to refresh dots on.|r'},
	{type = 'checkspin',text = 'Time to Die Limit\n(Predatory TF Support)', 			key = 'ttd_lim',				spin = 8, step = 1, shiftStep = 2, max = 12, check = true, desc = Zylla.ClassColor..'If a unit is about to die in x amount of seconds, dot it..|r'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',															align = 'center'},
	{type = 'checkspin',text = 'Swiftmend', 																			key = 'swiftm', 		spin = 85, step = 5, shiftStep = 10, max = 100, check = true},
	{type = 'checkspin',text = 'Regrowth', 																				key = 'rghp', 			spin = 45, step = 5, shiftStep = 10, max = 100, check = true},
	{type = 'checkspin',text = 'Survival Instincts', 															key = 'sint', 			spin = 50, step = 5, shiftStep = 10, max = 100, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDruid |cffADFF2FFeral |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/2')
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
	{'Travel Form', 'toggle(xFORM)&movingfor>0.75&!indoors&!buff&!buff(Prowl)'},
	{'!Regrowth', 'talent(7,2)&target.enemy&target.alive&!buff(Prowl)&!lastcast(Regrowth)&buff(Bloodtalons).stack<2'},
	{'Cat Form', 'toggle(xFORM)&movingfor>0.75&indoors&!buff&!buff(Travel Form)&!buff(Prowl)'},
	{'Prowl', 'toggle(xFORM)&toggle(xStealth)&!buff&{!buff(Travel Form)||{buff(Travel Form)&target.enemy&target.range<=25}}'},
	{'Rake', 'player.buff(Prowl)&inMelee&inFront&enemy&alive', 'target'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<1.5'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<1.5'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<1.5'},	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local AoE_PTF = {
	{'Tiger\'s Fury', 'UI(ttd_lim_check)&ttd<=UI(ttd_lim_spin)'},	--XXX: Will be used when
	{'Rake', '{UI(aoedot)&debuff(Rake).duration<UI(ptftimer_spin)&count(Rake).enemies.debuffs<UI(dot_units)}||{debuff(Rake).duration<UI(ptftimer_spin)&debuff(Rip).duration<UI(ptftimer_spin)&debuff(Thrash).duration<UI(ptftimer_spin)&ttd<=UI(ttd_lim_spin)&UI(ttd_lim_check)&talent(1,1)}'},
	{'Rip', '{UI(aoedot)&debuff(Rip).duration<UI(ptftimer_spin)&count(Rip).enemies.debuffs<UI(dot_units)}||{debuff(Rake).duration<UI(ptftimer_spin)&debuff(Rip).duration<UI(ptftimer_spin)&debuff(Thrash).duration<UI(ptftimer_spin)&ttd<=UI(ttd_lim_spin)&UI(ttd_lim_check)&talent(1,1)}'},
	{'Thrash', '{UI(aoedot)&debuff(Thrash).duration<UI(ptftimer_spin)&count(Thrash).enemies.debuffs<UI(dot_units)}||{debuff(Rake).duration<UI(ptftimer_spin)&debuff(Rip).duration<UI(ptftimer_spin)&debuff(Thrash).duration<UI(ptftimer_spin)&ttd<=UI(ttd_lim_spin)&UI(ttd_lim_check)&talent(1,1)}'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'}
}

local Interrupts = {
	{'!Skull Bash', 'player.form~=0&range<14'},
	{'!Typhoon', 'interruptAt(60)&spell(Skull Bash).cooldown>gcd&range<16'},
	{'!Mighty Bash', 'inMelee&spell(Skull Bash).cooldown>gcd'}
}

local Bear_Healing = {
	{'Bear Form', 'form~=1'},
	{'Frenzied Regeneration'}
}

local Survival = {
	{'Tiger\'s Fury', '{{!buff(Clearcasting)&energy.deficit>50}||energy.deficit>70}'},
	{'!Regrowth', 'talent(7,2)&buff(Predatory Swiftness)&{player.combopoints>4||buff(Predatory Swiftness).remains<1.5||{talent(7,2)&combopoints==2&!buff(Bloodtalons)&spell(Ashamane\'s Frenzy).cooldown<gcd}}'},
	{'!Regrowth', 'equipped(137024)&talent(7,2)&buff(Predatory Swiftness).stack>1&!buff(Bloodtalons)'},		--XXX: Special logic for Ailuro Pouncers legendary.
	{Bear_Healing, 'talent(3,2)&incdmg(5)>health.max*0.20&!buff(Frenzied Regeneration)', 'player'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'cooldown(Swiftmend).up.&form>0&talent(3,3)&player.health<=UI(swiftm_spin)&UI(swiftm_check)'},
	{'Swiftmend', 'talent(3,3)&health<=UI(swiftm_spin)&UI(swiftm_check)', 'player'},
	{'!Regrowth', 'UI(rghp_check)&health<=UI(rghp_spin)', 'player'},
	{'Survival Instincts', 'player.health<=UI(sint_spin)&UI(sint_check)', 'player'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local SBT_Opener = {
	{'!Regrowth', 'talent(7,2)&combopoints==5&!buff(Bloodtalons)&!target.debuff(Rip)', 'player'},
	{'Tiger\'s Fury', '!target.debuff(Rip)&combopoints==5', 'player'}
}

local Cooldowns = {
	{'Berserk', 'buff(Tiger\'s Fury)', 'player'},
	{'Incarnation: King of the Jungle', '{spell(Tiger\'s Fury).cooldown<gcd||{energy.time_to_max>1&energy>25}}', 'player'},
	{SBT_Opener, 'talent(6,1)&xtime<20'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Finisher = {
	{'Savage Roar', '{!buff(Savage Roar)&{combopoints==5||talent(6,2)&action(Brutal Slash).charges>0}}', 'player'},
	{'Savage Roar', '{{{buff(Savage Roar).duration<20.5&talent(5,3)}||{buff(Savage Roar).duration<8.2&!talent(5,3)}}&combopoints==5&{energy.time_to_max<1||buff(Berserk)||buff(Incarnation: King of the Jungle)||spell(Tiger\'s Fury).cooldown<3||buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5&area(8).enemies<6}}}', 'player'},
	{'Thrash', 'debuff(Thrash).duration<=dot(Thrash).duration*0.3&player.area(8).enemies>4'},
	{'Swipe', 'player.combopoints==5&{player.area(8).enemies>5||{player.area(8).enemies>2&!talent(7,2)}}&player.combopoints==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||spell(Tiger\'s Fury).cooldown<3||{talent(7,3)&player.buff(Clearcasting)}}'},
	{'Swipe', 'player.area(8).enemies>7'},
	{'Rip', '{!debuff(Rip)||{debuff(Rip).duration<8&health>25&!talent(6,1)}||persistent_multiplier>dot(Rip).pmultiplier}&{debuff(Rip).duration>dot(Rip).tick_time*4&player.combopoints==5}&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||spell(Tiger\'s Fury).cooldown<3||{talent(6,2)&player.buff(Clearcasting)}||talent(5,1)||!debuff(Rip)||{debuff(Rake).duration<1.5&player.area(8).enemies<6}}'},
	{'Ferocious Bite', '	player.combopoints==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||spell(Tiger\'s Fury).cooldown<3||{talent(7,3)&player.buff(Clearcasting)}}'},
	{'Ferocious Bite', 'player.combopoints>0&debuff(Rip)&debuff(Rip).duration<3&ttd>3&{health<25||talent(6,1)}'},
}

local Generator = {
	{'Moonfire', 'talent(1,3)&inFront&!player.buff(Prowl)&!debuff'},
	{'Brutal Slash', 'player.combopoints<5&player.area(8).enemies>UI(brs_unit)'},
	{'!Ashamane\'s Frenzy', 'player.combopoints<3&toggle(Cooldowns)&{player.buff(Bloodtalons)||!talent(7,2)}&{player.buff(Savage Roar)||!talent(5,3)}'},
	{'Elune\'s Guidance', 'talent(5,3)&{combopoints==0&energy<action(Ferocious Bite).cost+25-energy.regen*spell(Elune\'s Guidance).cooldown}', 'player'},
	{'Elune\'s Guidance', 'talent(5,3)&{combopoints==0&energy>=action(Ferocious Bite).cost+25}', 'player'},
	{'Thrash', 'talent(6,2)&player.area(8).enemies>8'},
	{'Thrash', 'debuff(Thrash).duration<=dot(Thrash).duration*0.3&player.area(8).enemies>1'},
	{'Swipe', 'player.combopoints<5&player.area(8).enemies.infront>=3'},
	{'Rake', 'player.combopoints<5&{!debuff(Rake)||{!talent(7,2)&debuff(Rake).duration<dot(Rake).duration*0.3}||{talent(7,2)&player.buff(Bloodtalons)&{!talent(5,1)&debuff(Rake).duration<8||debuff(Rake).duration<6}&persistent_multiplier>dot(Rake).pmultiplier*0.80}}&debuff(Rake).duration>dot(Rake).tick_time'},
	{'Moonfire', 'talent(1,3)&player.combopoints<5&debuff(Moonfire).duration<5.2&debuff(Moonfire).duration>dot(Moonfire).tick_time*2'},
	{'Shred', 'player.combopoints<5'}
}

local xCombat = {
	{Cooldowns, '!player.buff(Frenzied Regeneration)&toggle(Cooldowns)&ttd>12'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&inFront'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(xIntRandom)&toggle(Interrupts)&inFront', 'enemies'},
	{Finisher},
	{Generator}
}

local inCombat = {
	{'Cat Form', '!buff(Frenzied Regeneration)&{!buff(Cat Form)&{!buff(Travel Form)||area(8).enemies>0}}', 'player'},
	{'Rake', 'inMelee&inFront&{player.buff(Prowl)||player.buff(Shadowmeld)}', 'target'},
	{Keybinds},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'inMelee&inFront'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{AoE_PTF, 'inmelee&infront', 'enemies'}
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
}

NeP.CR:Add(103, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Feral',
	pooling = true,
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
