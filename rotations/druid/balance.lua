local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
--Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'normal',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',								key = 'prepot', 			default = false},
	{type = 'combo',		default = "3",																						key = "list", 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 					key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',															align = 'center'},
	{type = 'checkspin',text = 'Swiftmend', 																			key = 'sm',						spin = 70,	step = 5, shiftStep = 10, max = 100, min = 1,	check = false},
	{type = 'checkspin',text = 'Regrowth', 																				key = 'rg',						spin = 45,	step = 5, shiftStep = 10,	max = 100, min = 1,	check = false},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FBalance |r')
	print('|cffADFF2F --- |rRecommended Talents: in development....')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

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
	{'Blessing of the Ancients', '!buff(Blessing of Elune)'},
	{'%pause', 'buff(Shadowmeld)'},
	-- Pots
	{'#127844', '{buff(Celestial Alignment)||buff(Incarnation: Chosen of Elune)}&UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 	--XXX: Potion of the Old War
	{'#127843', '{buff(Celestial Alignment)||buff(Incarnation: Chosen of Elune)}&UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 	--XXX: Potion of Deadly Grace
	{'#142117', '{buff(Celestial Alignment)||buff(Incarnation: Chosen of Elune)}&UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local MoonkinForm = {
	{'Moonkin Form', 'toggle(xFORM)&!buff&!buff(Travel Form)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Interrupts = {
	{'&Skull Bash', 'player.form~=0&range<14'},
	{'!Typhoon', 'spell(Skull Bash).cooldown>gcd&range<16!player.lastgcd(Skull Bash)'},
	{'!Mighty Bash', 'inMelee&spell(Skull Bash).cooldown>gcd&!player.lastgcd(Skull Bash)'}
}

local Survival = {
	{'/run CancelShapeshiftForm()', 'toggle(xFORM)&form~=0&talent(3,3)&!buff(Rejuvenation)'},
	{'Rejuvenation', 'talent(3,3)&!buff(Rejuvenation)'},
	{'/run CancelShapeshiftForm()', 'toggle(xFORM)&UI(sm_check)&form~=0&talent(3,3)&health<=UI(sm_spin)'},
	{'Swiftmend', 'UI(sm_check)&talent(3,3)&health<UI(sm_spin)'},
	{'Regrowth', 'UI(rg_check)&health<UI(rg_spin)'},
}

local Cooldowns = {
	{'Incarnation: Chosen of Elune', 'astralpower>75&!buff(The Emerald Dreamcatcher)', 'player'},
	{'Astral Communion', 'astralpower.deficit>75&buff(The Emerald Dreamcatcher)', 'player'},
	{'Blood Fury', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)', 'player'},
	{'Berserking', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Celestial_Alignment = {
	{'Starfall', 'advanced&{area(15).enemies>1&talent(5,3)||area(15).enemies>2}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Lunar Strike', 'player.buff(Owlkin Frenzy)'},
	{'Starsurge', 'area(15).enemies<=2'},
	{'Warrior of Elune', '!lastcast', 'player'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astralpower.deficit>12||player.buff(Incarnation: Chosen of Elune)}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath', 'talent(7,3)&dot(Sunfire).remains<5&action.cast_time<dot(Sunfire).remains'},
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action.cast_time<dot(Moonfire).remains}||area(5).enemies>=2'},
	{'Solar Wrath'},
}

local Emerald_Dreamcatcher = {
	{'Celestial Alignment', 'astralpower>75&!player.buff(The Emerald Dreamcatcher)', 'player'},
	{'Starsurge', '{player.buff(The Emerald Dreamcatcher).remains<gcd.max}||astralpower>80||{{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astralpower>75}'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&debuff.remains<7.2&astralpower>05}'},
	{'Lunar Strike', 'player.buff(Owlkin Frenzy)'},
	{'Moonfire', '{talent(7,3)&debuff.remains<3}||{debuff.remains<6.6&!talent(7,3)}'},
	{'Sunfire', '{talent(7,3)&debuff.remains<3}||{debuff.remains<5.4&!talent(7,3)}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Solar Wrath).execute_time&astralpower>02&dot(Sunfire).remains<5.4&dot(Moonfire).remains>6.6'},
	{'Lunar Strike', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Lunar Strike).execute_time&astralpower>7&{!{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}||{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astralpower<87}'},
	{'New Moon', 'astralpower<100'},
	{'Half Moon', 'astralpower<90'},
	{'Full Moon', 'astralpower<70'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath', 'astralpower<100'},
}

local Fury_of_Elune = {
	{'Incarnation: Chosen of Elune', 'astralpower>85&cooldown(Fury of Elune).remains<=gcd', 'player'},
	{'Fury of Elune', 'advanced&astralpower>85', 'target.ground'},
	{'New Moon', '{{cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges==3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astralpower<100}}'},
	{'Half Moon', '{{cooldown(New Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges==3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astralpower<90}}'},
	{'Full Moon', '{{cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges==3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astralpower<70}}'},
	{'Astral Communion', 'player.buff(Fury of Elune)&astralpower.deficit>75'},
	{'Warrior of Elune', 'player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>25&player.buff(Lunar Empowerment)}'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Lunar Strike', 'player.buff(Owlkin Frenzy)'},{
	'New Moon', 'astralpower.deficit>0&player.buff(Fury of Elune)'},
	{'Half Moon', 'astralpower.deficit>10&player.buff(Fury of Elune)&astralpower>action(Half Moon).cast_time*12'},
	{'Full Moon', 'astralpower.deficit>30&player.buff(Fury of Elune)&astralpower>action(Full Moon).cast_time*12'},
	{'Moonfire', '!player.buff(Fury of Elune)&dot(Moonfire).remains<7.6'},
	{'Sunfire', '!player.buff(Fury of Elune)&dot(Sunfire).remains<6.4'},
	{'Stellar Flare', 'dot(Stellar Flare).remains<8.2&player.area(40).enemies==1'},
	{'Starfall', 'advanced&{area(15).enemies>1&talent(5,3)||area(15).enemies>2}&player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>10', 'target.ground'},
	{'Starsurge', 'area(15).enemies<3&!player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>7'},
	{'Starsurge', '!player.buff(Fury of Elune)&{{astralpower>82&cooldown(Fury of Elune).remains>gcd*3}||{cooldown(Warrior of Elune).remains<6&cooldown(Fury of Elune).remains>25&player.buff(Lunar Empowerment).stack<2}}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack==3||{player.buff(Lunar Empowerment).remains<5&buff(Lunar Empowerment)}||area(5).enemies>1'},
	{'Solar Wrath'},
}

local ST = {
	{'New Moon', 'astralpower.deficit>0'},
	{'Half Moon', 'astralpower.deficit>10'},
	{'Full Moon', 'astralpower.deficit>30'},
	{'Starfall', 'advanced&{area(15).enemies>1&talent(5,3)||area(15).enemies>2}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Starsurge', 'player.area(40).enemies<3&{player.buff(Solar Empowerment).stack<3||player.buff(Lunar Empowerment).stack<3}'},
	{'Lunar Strike', 'player.buff(Owlkin Frenzy)'},
	{'Warrior of Elune'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)&{astralpower.deficit>8||{astralpower.deficit>12&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)&{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Solar Wrath', 'talent(7,3)&dot(Sunfire).remains<5&action(Solar Wrath).cast_time<dot(Sunfire).remains&{astralpower.deficit>8||{astralpower.deficit>12&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Lunar Strike', '{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}&{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<dot(Moonfire).remains}||area(5).enemies>1'},
	{'Solar Wrath'},
}

local AoE = {
	{'Starfall', 'talent(5,1)&!player.buff&astralpower>39', 'target.ground'},
	{'Starfall', 'talent(5,2)&!player.buff&astralpower>59', 'target.ground'},
	{'Sunfire', '!debuff'},
	{'Starsurge', 'astralpower>90'},
	{'Starsurge', '!player.buff(Fury of Elune)&astralpower>90'},
	{'Lunar Strike', 'player.buff(Owlkin Frenzy)'},
	{'Full Moon', 'astralpower<=60'},
	{'New Moon', 'astralpower<=90'},
	{'Half Moon', 'astralpower<=80'},
	{'Sunfire', 'debuff.duration<3'},
	{'Lunar Strike'},
	{'Moonfire', 'debuff.duration<3'},
}

local Normal = {
	{'Blessing of the Ancients', 'area(40).enemies<3&talent(6,3)&!buff(Blessing of Elune)', 'player'},
	{'Blessing of the Ancients', 'area(40).enemies>2&talent(6,3)&!buff(Blessing of An\'she)', 'player'},
	{Fury_of_Elune, 'talent(7,1)&cooldown(Fury of Elune).remains<ttd'},
	{Emerald_Dreamcatcher, 'equipped(137062)'},
	{'New Moon', 'cooldown.charges<3&cooldown.recharge_time<5}||cooldown.charges==3'},
	{'Half Moon', 'cooldown.charges<=2&cooldown.recharge_time<5}||cooldown.charges==3||{ttd<15&cooldown.charges<3}'},
	{'Full Moon', 'cooldown.charges<=2&cooldown.recharge_time<5}||cooldown.charges==3||ttd<15'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<=3&debuff.remains<7.2&astralpower>50}'},
	{'Lunar Strike', 'player.buff(Owlkin Frenzy)'},
	{'Moonfire', '{talent(7,3)&debuff.remains<3}||{debuff.remains<6.6&!talent(7,3)}'},
	{'Sunfire', '{talent(7,3)&debuff.remains<3}||{debuff.remains<5.4&!talent(7,3)}'},
	{'Astral Communion', 'astralpower.deficit>75', 'player'},
	{'Incarnation: Chosen of Elune', 'astralpower>30', 'player'},
	{'Celestial Alignment', 'astralpower>30', 'player'},
	{'Starfall', 'advanced&player.buff(Oneth\'s Overconfidence)', 'target.ground'},
	{'Solar Wrath', 'player.buff(Solar Empowerment).stack==3&area(5).enemies'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack==3'},
	{Celestial_Alignment, 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{ST},
}

local xCombat = {
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&inFront&range<40'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)&inFront&range<40', 'enemies'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, 'area(15).enemies>=3&range<40&inFront'},
	{Normal, 'area(15).enemies<=2&range<40&inFront'},
}

local inCombat = {
	{MoonkinForm, nil, 'player'},
	{Keybinds},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'range<=40'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.Condition:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
	{MoonkinForm, nil, 'player'},
}

NeP.CR:Add(102, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Balance',
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
