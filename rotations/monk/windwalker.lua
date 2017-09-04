local _, Zylla = ...

local GUI = {
	--Logo
	{type = 'texture',  texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = -60, align = 'center'},
	{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},
	-- Keybinds
	{type = 'header', text = 'Keybinds',	 					 															align = 'center'},
	{type = 'text', 	 text = 'Left Shift: Pause',																align = 'center'},
	{type = 'text', 	 text = 'Left Ctrl: Transendence/Transfer',									align = 'center'},
	{type = 'text', 	 text = 'Left Alt: Touch of Karma',													align = 'center'},
	{type = 'ruler'},	 {type = 'spacer'},
	-- General
	{type = 'header',		text = 'General:',																				align = 'center'},
	{type = 'checkbox', text = 'Auto-target when casting Fists of Fury', 					key = 'xfistface', 	default = true},
	{type = 'checkbox',	text = 'Automatic Res',																		key = 'auto_res',		default = true},
	{type = 'checkbox',	text = '5 min DPS test', 																	key = 'dpstest',		default = false},
	{type = 'checkbox',	text = 'Pause Enabled', 																	key = 'kPause',			default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',		default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 	default = true},
	-- Survival
	{type = 'spacer'},		{type = 'rule'},
	{type = 'header',			text = 'Survival:', 																		align = 'center'},
	{type = 'checkspin',	text = 'Touch of Karma',																key = 'tok',					spin = 70, check = true},
	{type = 'text', 			text = 'Will also be used when taking big damage', 			align = 'left'},
	{type = 'spacer'},
	{type = 'checkspin',	text = 'Healthstone',																		key = 'hs',						spin = 45, check = true},
	{type = 'checkspin',	text = 'Ancient Healing Potion',												key = 'ahp',					spin = 40, check = true},
	{type = 'checkspin',	text = 'Effuse below HP%',															key = 'eff',					spin = 60, check = true},
	{type = 'checkspin',	text = 'Healing Elixir',																key = 'he',						spin = 50, check = true},
	{type = 'spacer'},
	{type = 'checkspin',	text = 'Effuse Party-Member HP%',												key = 'effp',					spin = 60, check = false},
	{type = 'checkbox',		text = 'Dispel Party Members', 													key = 'E_disAll',			default = true},
	{type = 'checkbox', 	text = 'Use Paralysis to Interrupt', 										key = 'para', 				default = true},
	-- Offensive
	{type = 'spacer'},	{type = 'rule'},
	{type = 'header',		text = 'Offensive:',																			align = 'center'},
	{type = 'checkbox',	text = 'Use: Storm Earth, and Fire',											key = 'sef_toggle', 	default = true},
	{type = 'checkbox',	text = 'Use: Crackling Jade Lightning',								 		key = 'auto_cjl',			default = true},
	{type = 'checkbox',	text = 'Use: Chi Wave at Pull',														key = 'auto_cw',			default = true},
	{type = 'checkbox',	text = 'Mark of the Crane Dotting',												key = 'auto_dot',			default = true},
	{type = 'checkbox',	text = 'Crackling Jade Lightning to Maintain Hit Combo',	key = 'auto_cjl_hc',	default = true},
	{type = 'ruler'},		{type = 'spacer'},
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
		-- Dispels
		key = 'dispels',
		name = 'Detox',
		text = 'Enable/Disable: Automatic Removal of Poison and Diseases',
		icon = 'Interface\\ICONS\\spell_holy_renew',
	})

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local Keybinds = {
	-- Keybinds
	{'!Touch of Karma', 'keybind(lalt)'},
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Transcendence', 'keybind(lcontrol)&!player.buff(Transcendence)'},
	{'!Transcendence: Transfer', 'keybind(lcontrol)&player.buff(Transcendence)'},
	{'!/cancelaura Transcendence', 'keybind(lcontrol)&player.buff(Transcendence)&lastcast(Transcendence: Transfer)'},
	{'!Tiger\'s Lust', 'player.state(disorient)||player.state(stun)||player.state(root)||player.state(snare)'},
	{'&/stopcasting\n/stopattack\n/cleartarget\n/stopattack\n/cleartarget\n/nep mt', 'player.combat.time>200&UI(dpstest)'},
	{'&/stopcasting', 'target.range<=5&player.casting(Crackling Jade Lightning)'}
}

local Cooldowns = {
	-- No Serenity
	{'Touch of Death', 'target.range<=5&target.ttd>11&!talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<5&player.spell(Rising Sun Kick).cooldown<7&player.chi>1', 'target'},
	-- Serenity
	{'Touch of Death', 'target.range<=5&target.ttd>11&talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<5&player.spell(Rising Sun Kick).cooldown<7', 'target'},
	{'Lifeblood'},
	{'Berserking'},
	{'Blood Fury'},
	{'#trinket1', 'UI(trinket1)&{player.buff(Serenity)||player.buff(Storm, Earth, and Fire)}'},
	{'#trinket2', 'UI(trinket2)&{player.buff(Serenity)||player.buff(Storm, Earth, and Fire)}'},
	-- Use Xuen only while hero or potion (WOD: 156423, Legion: 188027) is active
	{'Invoke Xuen, the White Tiger', 'player.hashero||{player.buff(Serenity)||player.buff(Storm, Earth, and Fire)}'},
	{'Touch of Karma', 'UI(tok_check)&{player.health<=UI(tok_spin)||player.incdmg(5)>player.health.max*0.20}', 'target'},
	{'Serenity', nil, 'player'}
}

local Dispel = {
	{'%dispelSelf'},
	{'%dispelAll', 'UI(E_disAll)'}
}

local Survival = {
	{'Healing Elixir', 'player.health<=UI(Healing Elixir)', 'player'},
	{'#127834', 'item(127834).usable&item(127834).count>0&player.health<=UI(ahp_spin)&UI(ahp_check)'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<=UI(hs_spin)&UI(hs_check)', 'player'}, 	-- Health Stone
	{'!Effuse', 'energy>50&!moving&UI(eff_check)&health<=UI(eff_spin)', 'player'}, 												-- Self  healing. Toggle and HP% in Settings
	{'!Effuse', 'energy>50&!player.moving&UI(effp_check)&health<=UI(effp_spin)', 'lowest'} 								-- Party healing. Toggle and HP% in Settings
}

local Interrupts = {
	{'!Spear Hand Strike', 'interruptAt(70)&range<=5&inFront', 'target'},
	{'!Paralysis', 'UI(para)&interruptAt(60)&!immune(incapacitate)&range<21&inFront&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'target'},
	{'!Ring of Peace', 'interruptAt(5)&advanced&range<40&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'target.ground'},
	{'!Leg Sweep', 'interruptAt(70)&!immune(stun)&range<=5&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'target'},
	{'!Quaking Palm', 'interruptAt(70)&!immune(incapacitate)&range<=5&inFront&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'target'}
}

local Interrupts_Random = {
	{'!Spear Hand Strike', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<=5', 'enemies'},
	{'!Paralysis', 'UI(para)&interruptAt(60)&!immune(incapacitate)&range<21&inFront&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'enemies'},
	{'!Ring of Peace', 'interruptAt(5)&advanced&range<40&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'enemies.ground'},
	{'!Leg Sweep', 'interruptAt(70)&!immune(stun)&range<=5&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'enemies'},
	{'!Quaking Palm', 'interruptAt(70)&!immune(incapacitate)&range<=5&inFront&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'enemies'}
}

local SEF = {
	{'Tiger Palm', 'player.energydiff==0&player.chi<2&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)', 'target'},
	{'Storm, Earth, and Fire', '{!player.buff(Storm, Earth, and Fire)}&{player.spell(Touch of Death).cooldown<9||player.spell(Touch of Death).cooldown>85}'},
	{'Storm, Earth, and Fire', '!player.buff(Storm, Earth, and Fire)&target.DeathIn<35'},
	{'Storm, Earth, and Fire', '!player.buff(Storm, Earth, and Fire)&player.spell(Fists of Fury).cooldown<2&player.chi>2'},
	{'Fists of Fury', 'player.chi>=3&player.buff(Storm, Earth, and Fire)', 'target'},
	{'Rising Sun Kick', 'player.chi>=2&player.buff(Storm, Earth, and Fire)&player.chi==2&player.energydiff>0', 'target'}
}

local Ranged = {
	{'Tiger\'s Lust', 'player.movingfor>0.5&target.combat&target.alive'},
	{'Chi Wave', 'toggle(aoe)&UI(auto_cw)&player.area(40).enemies>=2', 'target'},
	{'Chi Wave', 'toggle(aoe)&player.area(40).enemies>=2&player.timetomax>1.25', 'target'},
	{'Chi Burst', 'toggle(aoe)&player.area(40).enemies.infront>=2&target.range<=40&!player.moving&player.timetomax>1.25', 'target'},
	{'Crackling Jade Lightning', '!player.moving&UI(auto_cjl)&player.combat.time>4&!player.lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)', 'target'},
	{'Crackling Jade Lightning', '!player.moving&equipped(144239)&player.buff(The Emperor\'s Capacitor).count>10&!player.lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff==0', 'target'},
	{'Crackling Jade Lightning', '!player.moving&UI(auto_cjl_hc)&!player.lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff==0', 'target'}
}

local Serenity = {
	{'Strike of the Windlord', 'toggle(AoE)&player.area(8).enemies.infront>0', 'target'},
	{'Spinning Crane Kick', 'toggle(AoE)&{{!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>7||{player.spell(Spinning Crane Kick).count>2&player.area(8).enemies>1}||{player.area(8).enemies>2}}}'},
	{'Spinning Crane Kick', 'player.area(8).enemies>2&toggle(AoE)&!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)'},
	{'Spinning Crane Kick', '{!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>4||{player.area(8).enemies>1&toggle(AoE)}}'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies<3&inFront', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies>2&inFront', 'Zylla_sck(Mark of the Crane)'},
	{'Fists of Fury', 'inFront', 'target'},
	{'Blackout Kick', 'UI(auto_dot)&!player.lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)', 'Zylla_sck(Mark of the Crane)'},
	{'Blackout Kick', '!player.lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)&target.range<=5', 'target'},
	{'Rushing Jade Wind', '!player.lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'}
}

local Melee = {
	{'Energizing Elixir', 'player.energydiff>0&player.chi<2'},
	{'Strike of the Windlord', 'player.chi>=2&toggle(aoe)&player.area(9).enemies>0', 'target'},
	{'Fists of Fury', 'player.chi>=3&toggle(aoe)&player.area(6).enemies.infront>=2', 'target'},
		{{
			{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
			{'Tiger Palm'},
	}, 'player.energydiff==0&player.chi<4&player.buff(Storm, Earth, and Fire)&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Spinning Crane Kick', 'player.chi>=3&toggle(AoE)&{{!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>7||{player.spell(Spinning Crane Kick).count>2&player.area(8).enemies>1}||{player.area(8).enemies>2}}}'},
	{'Rising Sun Kick', 'player.chi>=2&UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.chi>=2', 'target'},
	{'Whirling Dragon Punch', 'toggle(aoe)&player.area(6).enemies>=2', 'target'},
	{'Rushing Jade Wind', 'toggle(AoE)&player.chidiff>1&!player.lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
		{{
			{'Blackout Kick', 'UI(auto_dot)&{player.chi>1||player.buff(Blackout Kick!)}', 'Zylla_sck(Mark of the Crane)'},
			{'Blackout Kick', 'player.buff(Blackout Kick!)||player.chi>1', 'target'},
	}, 'player.chi>=1&!player.lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)'},
		{{
			{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
			{'Tiger Palm'},
	}, 'player.energy>50&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Blackout Kick', 'player.chi==1&!player.buff(Hit Combo)'},	-- Last resort BoK when we only have 1 chi and no hit combo
	{'Tiger Palm', 'player.combat.time<4&player.energydiff==0&player.chi<2&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.range<=5'},
	{'Tiger Palm', '!player.buff(Hit Combo)', 'target'},	-- Last resort TP when we don't have hit combo up
	{'Tiger Palm', 'player.energy>100', 'target'}
}

local inCombat = {
	{Dispel, 'toggle(dispels)&player.spell(Detox).cooldown<gcd'},
	{Survival, 'player.health<100'},
	{Interrupts, 'toggle(Interrupts)'},
	{Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)'},
	{Cooldowns, 'toggle(cooldowns)&target.range<=5'},
	{Serenity, 'player.buff(Serenity)&target.range<=5'},
	{SEF, 'target.range<=5&UI(sef_toggle)&!talent(7,3)&player.spell(Strike of the Windlord).cooldown<24&player.spell(Fists of Fury).cooldown<7&player.spell(Rising Sun Kick).cooldown<7'},
	{Melee, 'target.range<=5&target.inFront'},
	{Ranged, 'target.range>5&target.range<41'}
}

local outCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)'},
	{Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)'},
	{Dispel, 'toggle(dispels)&!player.spell(Detox).cooldown'},
	{'Effuse', 'UI(eff_check)&player.health<90&player.lastmoved>0', 'player'}, -- Self healing. Toggle in Settings
	{'%ressdead(Resuscitate)', 'UI(auto_res)'},
}

NeP.CR:Add(269, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Windwalker',
	ic = {
		{inCombat, '!player.channeling(Fists of Fury)'},
		{'&@Zylla.face', 'UI(xfistface)&player.channeling(Fists of Fury)', 'target'}
	},
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='570', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
