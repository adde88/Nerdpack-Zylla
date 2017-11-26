local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																					align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',											align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Transcendence/Tranfer|r',			align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Touch of Karma|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'Freezing Trap|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																						key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																				align = 'center'},
	{type = 'combo',		default = 'normal',																											key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																			align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 													key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																				key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',								key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																													key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
--{type = 'checkbox', text = 'Auto-target when casting Fists of Fury', 												key = 'xfistface', 		default = true},	--TODO: temp disabled.
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																		key = 'LJ',						spin = 4, step = 1, max = 20, check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox',	text = 'Automatic Ressurect',																						key = 'auto_res',			default = true},
	{type = 'checkbox', text = 'Use Paralysis to Interrupt', 																		key = 'para', 				default = true},
	{type = 'checkbox',	text = 'Dispel Player', 																								key = 'E_disSelf',		default = true},
	{type = 'checkbox',	text = 'Dispel Party Members', 																					key = 'E_disAll',			default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																								key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																								key = 'trinket2', 		default = false, 	desc = Zylla.ClassColor..'Trinkets will be used in sync with \'Serenity\' or \'Storm, Earth, and Fire\'!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Kil\'Jaeden\'s Burning Wish - Units', 													key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header',		size = 16, text = 'Survival:', 																					align = 'center'},
	{type = 'checkspin',text = 'Touch of Karma',																								key = 'tok',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 70, max = 100, min = 1, check = true, desc = Zylla.ClassColor..'Will also be used when taking alot of damage.|r'},
	{type = 'checkspin',text = 'Healthstone',																										key = 'HS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																								key = 'AHP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Effuse',																												key = 'eff',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 60, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Elixir',																								key = 'he',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 50, max = 100, min = 1, check = true},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Emergency Group Heals',																					key = 'effp',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 60, max = 100, min = 1, check = false, desc = Zylla.ClassColor..'Will heal party members below HP% set.|r'},
	-- Offensive
	{type = 'spacer'},	{type = 'rule'},
	{type = 'header',		size = 16, text = 'Offensive:',																					align = 'center'},
	{type = 'checkbox',	text = 'Storm Earth, and Fire',																					key = 'sef_toggle', 	default = true},
	{type = 'checkbox',	text = 'Crackling Jade Lightning',								 											key = 'auto_cjl',			default = true},
	{type = 'checkbox',	text = 'Chi Wave at Pull',																							key = 'auto_cw',			default = true},
	{type = 'checkbox',	text = 'Mark of the Crane Dotting',																			key = 'auto_dot',			default = true},
	{type = 'checkbox',	text = 'Crackling Jade Lightning to Maintain Hit Combo',								key = 'auto_cjl_hc',	default = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMonk |cffADFF2FWindwalker|r')
	print('|cffADFF2F --- |rRecommended Talents: Still in development.')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local Keybinds = {
	-- Keybinds
	{'!Touch of Karma', 'keybind(lalt)&UI(lalt)'},
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Transcendence', 'keybind(lcontrol)&UI(lcontrol)&!player.buff(Transcendence)'},
	{'!Transcendence: Transfer', 'keybind(lcontrol)&UI(lcontrol)&player.buff(Transcendence)'},
	{'!/cancelaura Transcendence', 'keybind(lcontrol)&UI(lcontrol)&player.buff(Transcendence)&player.lastcast(Transcendence: Transfer)'},
	{'!Tiger\'s Lust', 'state(disorient)||state(stun)||state(root)||state(snare)', 'player'},
	{'&/stopcasting', 'target.inMelee&player.casting(Crackling Jade Lightning)'}
}

local Cooldowns = {
	{'Touch of Death', 'inMelee&!talent(7,3)&spell(Strike of the Windlord).cooldown<8&spell(Fists of Fury).cooldown<5&spell(Rising Sun Kick).cooldown<7&player.chi>1'},
	{'Touch of Death', 'inMelee&talent(7,3)&spell(Strike of the Windlord).cooldown<8&spell(Fists of Fury).cooldown<5&spell(Rising Sun Kick).cooldown<7'},
	{'Lifeblood', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)', 'player'},
	{'Berserking', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)', 'player'},
	{'Blood Fury', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)', 'player'},
	{'#trinket1', 'UI(trinket1)&{player.buff(Serenity)||player.buff(Storm, Earth, and Fire)}'},
	{'#trinket2', 'UI(trinket2)&{player.buff(Serenity)||player.buff(Storm, Earth, and Fire)}'},
	{'Invoke Xuen, the White Tiger', 'player.hashero||{player.buff(Serenity)||player.buff(Storm, Earth, and Fire)}'},
	{'Touch of Karma', 'UI(tok_check)&{player.health<=UI(tok_spin)||player.incdmg(3)>player.health.max*0.20}'},
	{'Serenity', nil, 'player'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Dispel = {
	{'%dispelSelf', 'UI(E_disSelf)'},
	{'%dispelAll', 'UI(E_disAll)'}
}

local Survival = {
	{'Healing Elixir', 'UI(he_check)&health<=UI(he_spin)'},
	{'!Effuse', 'energy>50&!moving&UI(eff_check)&health<=UI(eff_spin)'}, 																									--XXX: Self  healing. Toggle and HP% in Settings
	{'!Effuse', 'energy>50&!moving&UI(effp_check)&health<=UI(effp_spin)', 'lowest'},																			--XXX: Party healing. Toggle and HP% in Settings
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Interrupts = {
	{'&Spear Hand Strike', 'inMelee&inFront'},
	{'!Paralysis', 'UI(para)&range<21&inFront&spell(Spear Hand Strike).cooldown>=gcd&!player.lastcast(Spear Hand Strike)'},
	{'!Ring of Peace', 'interruptAt(5)&advanced&range<=40&spell(Spear Hand Strike).cooldown>=gcd&!player.lastgcd(Spear Hand Strike)', 'target.ground'},
	{'!Ring of Peace', 'toggle(xIntRandom)&interruptAt(5)&advanced&range<=40&spell(Spear Hand Strike).cooldown>=gcd&!player.lastgcd(Spear Hand Strike)', 'enemies.ground'},
	{'!Leg Sweep', '!immune(stun)&inMelee&spell(Spear Hand Strike).cooldown>=gcd&!player.lastgcd(Spear Hand Strike)'},
	{'!Quaking Palm', '!immune(incapacitate)&inMelee&inFront&spell(Spear Hand Strike).cooldown>=gcd&!player.lastgcd(Spear Hand Strike)'}
}

local SEF = {
	{'Tiger Palm', 'player.energydiff==0&player.chi<2&!player.lastcast(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Storm, Earth, and Fire', '!buff&{spell(Touch of Death).cooldown<9||spell(Touch of Death).cooldown>85}', 'player'},
	{'Storm, Earth, and Fire', '!buff&spell(Fists of Fury).cooldown<2&player.chi>2', 'player'},
	{'Fists of Fury', 'player.chi>=3&player.buff(Storm, Earth, and Fire)'},
	{'Rising Sun Kick', 'player.chi>=2&player.buff(Storm, Earth, and Fire)&player.chi==2&player.energydiff>0'}
}

local Ranged = {
	{'Tiger\'s Lust', 'movingfor>0.5&target.combat&target.alive', 'player'},
	{'Chi Wave', 'toggle(aoe)&UI(auto_cw)&player.area(40).enemies>=2'},
	{'Chi Wave', 'toggle(aoe)&player.area(40).enemies>=2&player.timetomax>1.25'},
	{'Chi Burst', 'toggle(aoe)&player.area(40).enemies.infront>=2&!player.moving&player.timetomax>1.25'},
	{'Crackling Jade Lightning', '!player.moving&UI(auto_cjl)&player.combat.time>4&!player.lastcast(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)'},
	{'Crackling Jade Lightning', '!player.moving&equipped(144239)&player.buff(The Emperor\'s Capacitor).count>10&!player.lastcast(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff==0'},
	{'Crackling Jade Lightning', '!player.moving&UI(auto_cjl_hc)&!player.lastcast(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff==0'}
}

local Serenity = {
	{'Strike of the Windlord', 'toggle(AoE)&player.area(8).enemies.infront>0'},
	{'Spinning Crane Kick', 'toggle(AoE)&{{!player.lastcast(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{spell(Spinning Crane Kick).count>7||{spell(Spinning Crane Kick).count>2&player.area(8).enemies>1}||{player.area(8).enemies>2}}}'},
	{'Spinning Crane Kick', 'player.area(8).enemies>2&toggle(AoE)&!player.lastcast(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)'},
	{'Spinning Crane Kick', '{!player.lastcast(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{spell(Spinning Crane Kick).count>4||{player.area(8).enemies>1&toggle(AoE)}}'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies<3&inFront', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies>2&inFront', 'Zylla_sck(Mark of the Crane)'},
	{'Fists of Fury', 'inFront'},
	{'Blackout Kick', 'UI(auto_dot)&!player.lastcast(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)', 'Zylla_sck(Mark of the Crane)'},
	{'Blackout Kick', '!player.lastcast(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)&target.inMelee'},
	{'Rushing Jade Wind', '!player.lastcast(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'}
}

local Melee = {
	{Serenity, 'player.buff(Serenity)'},
	{SEF, 'UI(sef_toggle)&!talent(7,3)&spell(Strike of the Windlord).cooldown<24&spell(Fists of Fury).cooldown<7&spell(Rising Sun Kick).cooldown<7'},
	{'Energizing Elixir', 'energydiff>0&chi<2', 'player'},
	{'Strike of the Windlord', 'player.chi>=2&toggle(aoe)&player.area(9).enemies>0'},
	{'Fists of Fury', 'player.chi>=3&toggle(aoe)&player.area(6).enemies.infront>=2'},
		{{
			{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
			{'Tiger Palm'},
	}, 'player.energydiff==0&player.chi<4&player.buff(Storm, Earth, and Fire)&!player.lastcast(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Spinning Crane Kick', 'player.chi>=3&toggle(AoE)&{{!player.lastcast(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{spell(Spinning Crane Kick).count>7||{spell(Spinning Crane Kick).count>2&player.area(8).enemies>1}||{player.area(8).enemies>2}}}'},
	{'Rising Sun Kick', 'player.chi>=2&UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.chi>=2'},
	{'Whirling Dragon Punch', 'toggle(aoe)&player.area(6).enemies>=2'},
	{'Rushing Jade Wind', 'toggle(AoE)&player.chidiff>1&!player.lastcast(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
		{{
			{'Blackout Kick', 'UI(auto_dot)&{player.chi>1||player.buff(Blackout Kick!)}', 'Zylla_sck(Mark of the Crane)'},
			{'Blackout Kick', 'player.buff(Blackout Kick!)||player.chi>1'},
	}, 'player.chi>=1&!player.lastcast(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)'},
		{{
			{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
			{'Tiger Palm'},
	}, 'player.energy>50&!player.lastcast(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Blackout Kick', 'player.chi==1&!player.buff(Hit Combo)'},	--XXX: Last resort BoK when we only have 1 chi and no hit combo
	{'Tiger Palm', 'player.combat.time<4&player.energydiff==0&player.chi<2&!player.lastcast(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Tiger Palm', '!player.buff(Hit Combo)'},									--XXX: Last resort TP when we don't have hit combo up
	{'Tiger Palm', 'player.energy>100'}
}

local xCombat = {
	{Melee, 'inMelee&inFront'},
	{Ranged, '!inMelee&inFront'}
}

local inCombat = {
	{Dispel, 'spell(Detox).cooldown<=gcd'},
	{Survival, nil, 'player'},
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)', 'target'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)', 'enemies'},
	{Cooldowns, 'toggle(cooldowns)&target.ttd>10'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.Condition:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{PreCombat},
	{Keybinds},
	{Dispel, 'spell(Detox).cooldown<=gcd'},
	{'Effuse', 'UI(eff_check)&player.health<90&player.lastmoved>0', 'player'}, --XXX: Self healing. Toggle in Settings
	{'%ressdead(Resuscitate)', 'UI(auto_res)'},
}

NeP.CR:Add(269, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Windwalker',
	ic = {
		{inCombat, '!player.channeling(Fists of Fury)'},
	--{'&@Zylla.face', 'UI(xfistface)&player.channeling(Fists of Fury)', 'target'}	-- XXX:temp disabled
	},
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
