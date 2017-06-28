local _, Zylla = ...

-- Thanks to NoC for a working WW-Monk rotation.

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	-- General
	{type = 'header',	text = 'General:',															align = 'center'},
	{type = 'checkbox',	text = 'Automatic Res',														key = 'auto_res',		default = true},
	{type = 'checkbox',	text = '5 min DPS test', 													key = 'dpstest',		default = false},
	{type = 'checkbox',	text = 'Pause Enabled', 													key = 'kPause',			default = true},

	-- Survival
	{type = 'spacer'},	{type = 'rule'},
	{type = 'header',	text = 'Survival:', 														align = 'center'},
	{type = 'spinner',	text = 'Healthstone & Healing Tonic',										key = 'Healthstone',	default = 35},
	{type = 'spinner',	text = 'Effuse',															key = 'effuse',			default = 30},
	{type = 'spinner',	text = 'Healing Elixir',													key = 'Healing Elixir',	default = 50},

	-- Offensive
	{type = 'spacer'},{type = 'rule'},
	{type = 'header',	text = 'Offensive:',														align = 'center'},
	{type = 'checkbox',	text = 'Storm Earth Fire Usage',											key = 'sef_toggle', 	default = true},
	{type = 'checkbox',	text = 'Automatic Crackling Jade Lightning at Range',						key = 'auto_cjl',		default = true},
	{type = 'checkbox',	text = 'Automatic Chi Wave at Pull',										key = 'auto_cw',		default = true},
	{type = 'checkbox',	text = 'Automatic Mark of the Crane Dotting',								key = 'auto_dot',		default = true},
	{type = 'checkbox',	text = 'Automatic Crackling Jade Lightning in Melee to Maintain Hit Combo', key = 'auto_cjl_hc',	default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms:',												align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1',													key = 'kT1',			default = true},
	{type = 'checkbox', text = 'Use Trinket #2',													key = 'kT2',			default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures',										key = 'kRoCF',			default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP',								key = 'k_HEIR',			default = true},
	{type = 'ruler'},	{type = 'spacer'},
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rMonk |cffADFF2FWindwalker|r")
	print("|cffADFF2F --- |")
	print("|cffADFF2F --- |rRecommended Talents: IN DEVELOPMENT...")
	print("|cffADFF2F --- |rFirst time users: CHECK OUT SETTINGS!")
	print("|cffADFF2F --- |")
	print("|cffADFF2F --- |rKeybinds:")
	print("|cffADFF2F --- |rL-CTRL: Transcendence/Transfer")
	print("|cffADFF2F --- |rL-ALT: Touch of Karma")
	print("|cffADFF2F --- |rL-SHIFT: Pause")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")

end

local Keybinds = {
	-- Keybinds
	{'!Touch of Karma', 'keybind(lalt)'},
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	-- DPS TEST
	{'!/stopcasting\n/stopattack\n/cleartarget\n/stopattack\n/cleartarget\n/nep mt', 'player.combat.time>=300&UI(dpstest)'},
	-- Cancel CJL WHEN WE'RE IN MELEE RANGE
	{'!/stopcasting', 'target.inMelee&player.casting(Crackling Jade Lightning)'},
	-- TRANSCENDENCE
	{'!Transcendence', 'keybind(lcontrol)&!player.buff(Transcendence)'},
	{'!Transcendence: Transfer', 'keybind(lcontrol)&player.buff(Transcendence)'},
	{'!/cancelaura Transcendence', 'keybind(lcontrol)&player.buff(Transcendence)&lastcast(Transcendence: Transfer)'},
	-- FREEDOOM!
	{'!Tiger\'s Lust', 'player.state.disorient||player.state.stun||player.state.root||player.state.snare'},
}

local Cooldowns = {
	{'Tiger Palm', 'player.combat.time<4&player.energydiff=0&player.chi<=1&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},
	-- TODO: add logic to handle ToD interaction with legendary item 137057 (Hidden Masters Forbidden Touch)
	-- No Serenity
	{'Touch of Death', 'target.inMelee&target.DeathIn>=8&{!player.spell.usable(Gale Burst)||{player.spell.usable(Gale Burst)&!talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<=4&player.spell(Rising Sun Kick).cooldown<7&player.chi>=2}}'},
	-- Serenity
	{'Touch of Death', 'target.inMelee&target.DeathIn>=8&{!player.spell.usable(Gale Burst)||{player.spell.usable(Gale Burst)&talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<=4&player.spell(Rising Sun Kick).cooldown<7}}'},
	{'Lifeblood'},
	{'Berserking'},
	{'Blood Fury'},
	{'#trinket1', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)'},
	{'#trinket2', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)'},
	-- Use Xuen only while hero or potion (WOD: 156423, Legion: 188027) is active
	{'Invoke Xuen, the White Tiger', 'player.hashero'},
}

local Survival = {
	{'Healing Elixir', 'player.health<=UI(Healing Elixir)', 'player'},
	{'#Healthstone', 'player.health<=UI(Healthstone)', 'player'},			-- Healthstone
	{'#Ancient Healing Potion', 'player.health<=UI(Healthstone)', 'player'}, -- Ancient Healing Potion
	{'Effuse', 'player.energy>=60&!player.moving&player.health<=UI(effuse)', 'player'},
	{'Detox', 'player.dispellable(Detox)', 'player'},
}

local Interrupts = {
	{'Spear Hand Strike'},
	-- Ring of Peace when Spear Hand Strike is on CD
	{'Ring of Peace', '!target.debuff(Spear Hand Strike)&player.spell(Spear Hand Strike).cooldown>1&!lastcast(Spear Hand Strike)'},
	-- Leg Sweep when Spear Hand Strike is on CD
	{'Leg Sweep', 'player.spell(Spear Hand Strike).cooldown>1&target.inMelee&!lastcast(Spear Hand Strike)'},
	-- Quaking Palm when Spear Hand Strike is on CD
	{'Quaking Palm', '!target.debuff(Spear Hand Strike)&player.spell(Spear Hand Strike).cooldown>1&!lastcast(Spear Hand Strike)'},
}

local SEF = {
	{'Tiger Palm', 'player.energydiff=0&player.chi<=1&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&{player.spell(Touch of Death).cooldown<=8||player.spell(Touch of Death).cooldown>85}'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&target.DeathIn<=25'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&{player.spell(Fists of Fury).cooldown<=1&player.chi>=3}'},
	{'Fists of Fury', 'target.inMelee&player.buff(Storm, Earth, and Fire)'},
	{'Rising Sun Kick', 'target.inMelee&player.buff(Storm, Earth, and Fire)&player.chi=2&player.energydiff>0' }
}

local Ranged = {
	{'Tiger\'s Lust', 'player.movingfor>0.5&target.alive'},
	{'Crackling Jade Lightning', 'UI(auto_cjl)&!player.moving&player.combat.time>4&target.combat&!lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)'},
	{'Chi Wave', 'UI(auto_cw)&target.inRanged&target.combat'},
}

local Serenity = {
	{'Serenity', 'target.inMelee'},
	{'Strike of the Windlord', 'player.area(9).enemies>=1', 'target'},
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=8||{player.spell(Spinning Crane Kick).count>=3&player.area(8).enemies>=2&toggle(AoE)}||{player.area(8).enemies>=3&toggle(AoE)}}'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies<3&target.inMelee', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.area(5).enemies<3&target.inMelee'},
	{'Fists of Fury', 'target.inMelee'},
	{'Spinning Crane Kick', 'player.area(8).enemies>=3&toggle(AoE)&!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies>=3', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.area(5).enemies>=3'},
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=5||{player.area(8).enemies>=2&toggle(AoE)}}'},
	{'Blackout Kick', 'UI(auto_dot)&!lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)', 'Zylla_sck(Mark of the Crane)'},
	{'Blackout Kick', '!lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)&target.inMelee'},
	{'Rushing Jade Wind', '!lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
}

local Melee = {
	{'Energizing Elixir', 'player.energydiff>0&player.chi<=1&target.inMelee'},
	-- TODO: add support for convergence of fates legendry
	{'Strike of the Windlord', 'player.area(9).enemies>=1', 'target'},
	{'Fists of Fury', 'target.inMelee'},
	{{
		{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
		{'Tiger Palm'},
	}, 'player.energydiff=0&player.chi<=3&player.buff(Storm, Earth, and Fire)&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=8||{player.spell(Spinning Crane Kick).count>=3&player.area(8).enemies>=2&toggle(AoE)}||{player.area(8).enemies>=3&toggle(AoE)}}'},
	{'Rising Sun Kick', 'target.inMelee&UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'target.inMelee'},
	{'Spinning Crane Kick', '!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)&player.spell(Spinning Crane Kick).count>=16'},
	{'Whirling Dragon Punch'},
	-- TODO: add support for CJL with legenadry Emperors Capcitor
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=5||{player.area(8).enemies>=2&toggle(AoE)}}'},
	{'Rushing Jade Wind', 'player.chidiff>1&!lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
	{{
		{'Blackout Kick', 'UI(auto_dot)&{player.chi>1||player.buff(Blackout Kick!)}', 'Zylla_sck(Mark of the Crane)'},
		{'Blackout Kick', 'player.buff(Blackout Kick!)||player.chi>1'},
	}, '!lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)&target.inMelee'},
	{'Chi Wave', 'player.timetomax>=2.25&target.combat'}, -- 40 yard range 0 energy, 0 chi
	{'Chi Burst', '!player.moving&player.timetomax>=2.25'},
	{{
		{'Tiger Palm', 'UI(auto_dot)', 'Zylla_sck(Mark of the Crane)'},
		{'Tiger Palm'},
	}, 'player.energy>50&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},

	-- CJL when we're using Hit Combo as a last resort filler, at 100 energy, and it's toggled on
	{'Crackling Jade Lightning', 'UI(auto_cjl_hc)&target.inMelee&!lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff=0'},

	-- Last resort BoK when we only have 1 chi and no hit combo
	{'Blackout Kick', 'player.chi=1&!player.buff(Hit Combo)&target.inMelee'},
	-- Last resort TP when we don't have hit combo up
	{'Tiger Palm', '!player.buff(Hit Combo)&target.inMelee'},
	--[[ Last resort TP when at 100 energy - doing this because it's sometimes
	 getting parried/missed and we're stuck thinking it was lastcast and
	 don't do anything, so as a fallthrough we'll cast when at 100 energy
	 no matter what. May replace with CJL when @ 100 energy instead --]]
	{'Tiger Palm', 'player.energy>=100&target.inMelee'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(70)&target.inMelee'},
	{Cooldowns, 'toggle(cooldowns)&target.inMelee'},
	{Serenity, 'toggle(cooldowns)&target.inMelee&talent(7,3)&!player.casting(Fists of Fury)&{player.spell(Serenity).cooldown=0||player.buff(Serenity)}'},
	-- TODO: handle legendary Drinking Horn Cover
	{SEF, 'target.inMelee&UI(sef_toggle)&!talent(7,3)&!player.casting(Fists of Fury)&{player.spell(Strike of the Windlord).exists&player.spell(Strike of the Windlord).cooldown<=14&player.spell(Fists of Fury).cooldown<=6&player.spell(Rising Sun Kick).cooldown<=6}'},
	{Melee, '!player.casting(Fists of Fury)'},
	{Ranged, '!target.inMelee&target.inRanged&target.combat'},
}

local outCombat = {
	{Keybinds},
	{'Effuse', 'player.health<=50&player.lastmoved>=1', 'player'},
	{'%ressdead(Resuscitate)', 'UI(auto_res)'},
}

NeP.CR:Add(269, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Windwalker',
	ic=inCombat,
	ooc=outCombat,
	gui=GUI,
	load=exeOnLoad
})
