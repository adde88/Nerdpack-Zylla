local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
  {type = "texture", texture = "Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp", width = 128, height = 128, offset = 90, y = 42, center = true},
  {type = 'ruler'},	  {type = 'spacer'},
	-- General
	{type = 'header',	text = 'General:',															align = 'center'},
	{type = 'checkbox',	text = 'Automatic Res',												key = 'auto_res',		default = true},
	{type = 'checkbox',	text = '5 min DPS test', 											key = 'dpstest',		default = false},
	{type = 'checkbox',	text = 'Pause Enabled', 											key = 'kPause',			default = true},

	-- Survival
	{type = 'spacer'},	{type = 'rule'},
	{type = 'header',	text = 'Survival:', 														align = 'center'},
	{type = 'spinner',	text = 'Healthstone & Healing Tonic',					key = 'Healthstone',		default = 35},
	{type = 'spinner',	text = 'Effuse',															key = 'effuse',					default = 30},
	{type = 'spinner',	text = 'Healing Elixir',											key = 'Healing Elixir',	default = 50},
	{type = 'checkbox', text = 'Dispel Party Members', 								key = 'E_disAll', 			default = true},

	-- Offensive
	{type = 'spacer'},{type = 'rule'},
	{type = 'header',	text = 'Offensive:',																				align = 'center'},
	{type = 'checkbox',	text = 'Storm Earth Fire Usage',													key = 'sef_toggle', 	default = true},
	{type = 'checkbox',	text = 'Crackling Jade Lightning at Range',								key = 'auto_cjl',			default = true},
	{type = 'checkbox',	text = 'Chi Wave at Pull',																key = 'auto_cw',			default = true},
	{type = 'checkbox',	text = 'Mark of the Crane Dotting',												key = 'auto_dot',			default = true},
	{type = 'checkbox',	text = 'Crackling Jade Lightning to Maintain Hit Combo',	key = 'auto_cjl_hc',	default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms:',									align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1',											key = 'kT1',			default = true},
	{type = 'checkbox', text = 'Use Trinket #2',											key = 'kT2',			default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures',					key = 'kRoCF',		default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below HP%',		key = 'k_HEIR',		default = true},
	{type = 'ruler'},	{type = 'spacer'},
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
	-- Etc...
	{'!Tiger\'s Lust', 'player.state(disorient)||player.state(stun)||player.state(root)||player.state(snare)'},		-- FREEDOOM!
	{'!/stopcasting\n/stopattack\n/cleartarget\n/stopattack\n/cleartarget\n/nep mt', 'player.combat.time>200&UI(dpstest)'},		-- DPS TEST
	{'!/stopcasting', 'target.inMelee&player.casting(Crackling Jade Lightning)'},		-- Cancel CJL WHEN WE'RE IN MELEE RANGE
}

local Cooldowns = {
	-- No Serenity
	{'Touch of Death', 'target.inMelee&target.DeathIn>7&{!player.spell.usable(Gale Burst)||{player.spell.usable(Gale Burst)&!talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<5&player.spell(Rising Sun Kick).cooldown<7&player.chi>1}}'},
	-- Serenity
	{'Touch of Death', 'target.inMelee&target.DeathIn>7&{!player.spell.usable(Gale Burst)||{player.spell.usable(Gale Burst)&talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<5&player.spell(Rising Sun Kick).cooldown<7}}'},
	{'Lifeblood'},
	{'Berserking'},
	{'Blood Fury'},
	{'#trinket1', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)'},
	{'#trinket2', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)'},
	-- Use Xuen only while hero or potion (WOD: 156423, Legion: 188027) is active
	{'Invoke Xuen, the White Tiger', 'player.hashero||{player.buff(Serenity)||player.buff(Storm, Earth, and Fire)}'},
}

local Dispel = {
	{'%dispelSelf'},
	{'%dispelAll', 'UI(E_disAll)'},
}

local Survival = {
	{'Healing Elixir', 'player.health<=UI(Healing Elixir)', 'player'},
	{'#127834', 'item(127834).count>0&player.health<UI(Healthstone)'},        -- Ancient Healing Potion
	{'#5512', 'item(5512).count>0&player.health<UI(Healthstone)', 'player'},  --Health Stone
	{'!Effuse', 'player.energy>50&!player.moving&player.health<=UI(effuse)', 'player'},
}

local Interrupts = {
	{'!Spear Hand Strike', 'target.inMelee&target.inFront'},
	{'!Ring of Peace', 'target.range<40&!target.debuff(Spear Hand Strike)&player.spell(Spear Hand Strike).cooldown>gcd&!lastcast(Spear Hand Strike)'},
	{'!Leg Sweep', 'target.inMelee&target.inFront&player.spell(Spear Hand Strike).cooldown>gcd&!lastcast(Spear Hand Strike)'},
}

local Interrupts_Random = {
	{'!Rebuke', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&inMelee', 'enemies'},
	{'!Ring of Peace', 'range<40&inFront&!debuff(Spear Hand Strike)&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'enemies'},
	{'!Leg Sweep', 'inMelee&inFront&!debuff(Spear Hand Strike)&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'enemies'},
}

local SEF = {
	{'Tiger Palm', 'player.energydiff==0&player.chi<2&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)', 'target'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&{player.spell(Touch of Death).cooldown<9||player.spell(Touch of Death).cooldown>85}'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&target.DeathIn<35'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&{player.spell(Fists of Fury).cooldown<2&player.chi>2}'},
	{'Fists of Fury', 'player.buff(Storm, Earth, and Fire)', 'target'},
	{'Rising Sun Kick', 'player.buff(Storm, Earth, and Fire)&player.chi==2&player.energydiff>0', 'target'}
}

local Ranged = {
	{'Tiger\'s Lust', 'player.movingfor>0.5&target.alive'},
	{'Chi Wave', 'toggle(aoe)&UI(auto_cw)&player.area(40).enemies>=2&target.combat', 'target'},
	{'Chi Wave', 'toggle(aoe)&player.area(40).enemies>=2&player.timetomax>1.25&target.combat', 'target'}, -- 40 yard range 0 energy, 0 chi
	{'Chi Burst', 'toggle(aoe)&player.area(40).enemies.infront>=2&target.range<=40&!player.moving&player.timetomax>1.25', 'target'},
	{'Crackling Jade Lightning', '!player.moving&UI(auto_cjl)&player.combat.time>4&!player.lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)', 'target'},
	{'Crackling Jade Lightning', '!player.moving&equipped(144239)&player.buff(The Emperor\'s Capacitor).count>10&!player.lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff==0', 'target'}, -- Legendary Chest support
	{'Crackling Jade Lightning', '!player.moving&UI(auto_cjl_hc)&!player.lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff==0', 'target'}, -- CJL when we're using Hit Combo as a last resort filler, at 100 energy, and it's toggled on
}

local Serenity = {
	{'Serenity', 'target.inMelee'},
	{'Strike of the Windlord', 'toggle(AoE)&player.area(9).enemies.infront>0', 'target'},
	{'Spinning Crane Kick', 'toggle(AoE){{!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>7||{player.spell(Spinning Crane Kick).count>2&player.area(8).enemies>1&toggle(AoE)}||{player.area(8).enemies>2}}}'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies<3&target.inMelee', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.area(5).enemies<3&target.inMelee', 'target'},
	{'Fists of Fury', 'target.inMelee&target.inFront', 'target'},
	{'Spinning Crane Kick', 'player.area(8).enemies>2&toggle(AoE)&!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies>2', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.area(5).enemies>2', 'target'},
	{'Spinning Crane Kick', '{!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>4||{player.area(8).enemies>1&toggle(AoE)}}'},
	{'Blackout Kick', 'UI(auto_dot)&!player.lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)', 'Zylla_sck(Mark of the Crane)'},
	{'Blackout Kick', '!player.lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)&target.inMelee'},
	{'Rushing Jade Wind', '!player.lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
}

local Melee = {
	{'Energizing Elixir', 'player.energydiff>0&player.chi<2'},
	{'Strike of the Windlord', 'toggle(aoe)&player.area(9).enemies>0', 'target'},
	{'Fists of Fury', 'toggle(aoe)&player.area(6).enemies.infront>=2', 'target'},
	{{
		{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
		{'Tiger Palm'},
	}, 'player.energydiff==0&player.chi<4&player.buff(Storm, Earth, and Fire)&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Spinning Crane Kick', 'toggle(AoE)&{{!player.lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>7||{player.spell(Spinning Crane Kick).count>2&player.area(8).enemies>1}||{player.area(8).enemies>2}}}'},
	{'Rising Sun Kick', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick'},
	{'Whirling Dragon Punch', 'toggle(aoe)&player.area(6).enemies>=2', 'target'},
	{'Rushing Jade Wind', 'toggle(AoE)&player.chidiff>1&!player.lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
	{{
		{'Blackout Kick', 'UI(auto_dot)&{player.chi>1||player.buff(Blackout Kick!)}', 'Zylla_sck(Mark of the Crane)'},
		{'Blackout Kick', 'player.buff(Blackout Kick!)||player.chi>1', 'target'},
	}, '!player.lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)'},
	{{
		{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
		{'Tiger Palm'},
	}, 'player.energy>50&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)'},
	{'Blackout Kick', 'player.chi==1&!player.buff(Hit Combo)'},	-- Last resort BoK when we only have 1 chi and no hit combo
	{'Tiger Palm', 'player.combat.time<4&player.energydiff==0&player.chi<2&!player.lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},
	{'Tiger Palm', '!player.buff(Hit Combo)', 'target'},	-- Last resort TP when we don't have hit combo up
	{'Tiger Palm', 'player.energy>100', 'target'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Dispel, 'toggle(dispels)&!player.spell(Detox).cooldown'},
	{Survival, 'player.health<100'},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)'},
	{Cooldowns, 'toggle(cooldowns)&target.inMelee'},
	{Serenity, 'toggle(cooldowns)&target.combat&target.inMelee&talent(7,3)&!player.casting(Fists of Fury)&{player.spell(Serenity).cooldown==0||player.buff(Serenity)}'},
	{SEF, 'target.combat&target.inMelee&UI(sef_toggle)&!talent(7,3)&!player.casting(Fists of Fury)&{player.spell(Strike of the Windlord).exists&player.spell(Strike of the Windlord).cooldown<24&player.spell(Fists of Fury).cooldown<7&player.spell(Rising Sun Kick).cooldown<7}'},
	{Melee, 'target.combat&target.inMelee&target.inFront&!player.casting(Fists of Fury)'},
	{Ranged, '!target.inMelee&target.range<=40&target.combat&!player.casting(Fists of Fury)'},
}

local outCombat = {
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)'},
	{'Effuse', 'player.health<85&player.lastmoved>0', 'player'},
	{'%ressdead(Resuscitate)', 'UI(auto_res)'},
}

NeP.CR:Add(269, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Windwalker',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
