local _, Zylla = ...

-- Syncronized with simc APL as of simc commit 416d9945271c23d7fbe7769b94724f2c604b2f66 (from 2b2fc107fccdbe83b5736a30a0f8524592f594f7)

local GUI={
	-- General
	{type='header',text='General', align='center'},
	{type='checkbox', text='Automatic Res', key='auto_res', default=false},
	--{type='checkbox', text='Automatic Pre-Pot', key='auto_pot', default=false},
	{type='checkbox', text='5 min DPS test', key='dpstest', default=false},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},

	-- Survival
	{type='spacer'},{type='rule'},
	{type='header', text='Survival', align='center'},
	{type='spinner', text='Healthstone&Healing Tonic', key='Healthstone', default=35},
	{type='spinner', text='Effuse', key='effuse', default=30},
	{type='spinner', text='Healing Elixir', key='Healing Elixir', default=50},

	-- Offensive
	{type='spacer'},{type='rule'},
	{type='header', text='Offensive', align='center'},
	{type='checkbox', text='SEF usage', key='sef_toggle', default=true},
	{type='checkbox', text='Automatic CJL at range', key='auto_cjl', default=false},
	{type='checkbox', text='Automatic Chi Wave at pull', key='auto_cw', default=true},
	{type='checkbox', text='Automatic Mark of the Crane Dotting', key='auto_dot', default=true},
	{type='checkbox', text='Automatic CJL in melee to maintain Hit Combo', key='auto_cjl_hc', default=false},
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rMonk |cffADFF2FWindwalker  |r")
	print("|cffADFF2F --- |rRecommended Talents:  COMING SOON...")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	
end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "target.dead||!target.exists" },
}

local _All={
	-- Keybinds
	{'Leg Sweep', 'keybind(lcontrol)'},
	{'Touch of Karma', 'keybind(lalt)'},
	{'/stopcasting\n/stopattack\n/cleartarget\n/stopattack\n/cleartarget\n/nep mt', 'player.combat.time>=300&UI(dpstest)'},
	-- Cancel CJL when we're in melee range
	{'!/stopcasting', 'target.inMelee&player.casting(Crackling Jade Lightning)'},
	-- FREEDOOM!
	{'Tiger\'s Lust', 'player.state.disorient||player.state.stun||player.state.root||player.state.snare'},
}

local _Cooldowns={
	{'Tiger Palm', 'player.combat.time<4&player.energydiff=0&player.chi<=1&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},
	-- TODO: add logic to handle ToD interaction with legendary item 137057 (Hidden Masters Forbidden Touch)
	-- No Serenity
	{'Touch of Death', 'target.inMelee&target.deathin>=8&{!player.spell.usable(Gale Burst)||{player.spell.usable(Gale Burst)&!talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<=4&player.spell(Rising Sun Kick).cooldown<7&player.chi>=2}}'},
	-- Serenity
	{'Touch of Death', 'target.inMelee&target.deathin>=8&{!player.spell.usable(Gale Burst)||{player.spell.usable(Gale Burst)&talent(7,3)&player.spell(Strike of the Windlord).cooldown<8&player.spell(Fists of Fury).cooldown<=4&player.spell(Rising Sun Kick).cooldown<7}}'},
	{'Lifeblood'},
	{'Berserking'},
	{'Blood Fury'},
	{'#trinket1', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)'},
	{'#trinket2', 'player.buff(Serenity)||player.buff(Storm, Earth, and Fire)'},
	-- Use Xuen only while hero or potion (WOD: 156423, Legion: 188027) is active
	{'Invoke Xuen, the White Tiger', 'player.hashero'},
}

local _Survival={
	{'Healing Elixir', 'player.health<=UI(Healing Elixir)', 'player'},
	{'#Healthstone', 'player.health<=UI(Healthstone)', 'player'}, -- Healthstone
	{'#Ancient Healing Potion', 'player.health<=UI(Healthstone)', 'player'}, -- Ancient Healing Potion
	{'Effuse', 'player.energy>=60&player.lastmoved>=0.5&player.health<=UI(effuse)', 'player'},
	{'Detox', 'player.dispellable(Detox)', 'player'},
}

local _Interrupts={
	-- Ring of Peace when SHS is on CD
	{'Ring of Peace', '!target.debuff(Spear Hand Strike)&player.spell(Spear Hand Strike).cooldown>1&!lastcast(Spear Hand Strike)'},
	-- Leg Sweep when SHS is on CD
	{'Leg Sweep', 'player.spell(Spear Hand Strike).cooldown>1&target.inMelee&!lastcast(Spear Hand Strike)'},
	-- Quaking Palm when SHS is on CD
	{'Quaking Palm', '!target.debuff(Spear Hand Strike)&player.spell(Spear Hand Strike).cooldown>1&!lastcast(Spear Hand Strike)'},
	{'Spear Hand Strike'}, -- Spear Hand Strike
}

local _SEF={
	{'Tiger Palm', 'player.energydiff=0&player.chi<=1&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&{player.spell(Touch of Death).cooldown<=8||player.spell(Touch of Death).cooldown>85}'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&target.deathin<=25'},
	{'Storm, Earth, and Fire', '{{!toggle(AoE)&@Zylla.sef(nil)}||!player.buff(Storm, Earth, and Fire)}&{player.spell(Fists of Fury).cooldown<=1&player.chi>=3}'},
	{'Fists of Fury', 'target.inMelee&player.buff(Storm, Earth, and Fire)'},
	{'Rising Sun Kick', 'target.inMelee&player.buff(Storm, Earth, and Fire)&player.chi=2&player.energydiff>0' }
}

local _Ranged={
	{'Tiger\'s Lust', 'player.movingfor>0.5&target.alive'}, -- Tiger's Lust
	{'Crackling Jade Lightning', 'UI(auto_cjl)&!player.moving&player.combat.time>4&target.combat&!lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)'},
	{'Chi Wave', 'UI(auto_cw)&target.inRanged&target.combat'},
}

local _Serenity={
	{'Serenity', 'target.inMelee'},
	{'Strike of the Windlord', 'player.area(9).enemies>=1', 'target'},
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=8||{player.spell(Spinning Crane Kick).count>=3&player.area(8).enemies>=2&toggle(AoE)}||{player.area(8).enemies>=3&toggle(AoE)}}'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies<3&target.inMelee', 'NOC_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.area(5).enemies<3&target.inMelee'},
	{'Fists of Fury', 'target.inMelee'},
	{'Spinning Crane Kick', 'player.area(8).enemies>=3&toggle(AoE)&!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)'},
	{'Rising Sun Kick', 'UI(auto_dot)&player.area(5).enemies>=3', 'NOC_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'player.area(5).enemies>=3'},
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=5||{player.area(8).enemies>=2&toggle(AoE)}}'},
	{'Blackout Kick', 'UI(auto_dot)&!lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)', 'NOC_sck(Mark of the Crane)'},
	{'Blackout Kick', '!lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)&target.inMelee'},
	{'Rushing Jade Wind', '!lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
}

local _Melee={
	{'Energizing Elixir', 'player.energydiff>0&player.chi<=1&target.inMelee'},
	-- TODO: add support for convergence of fates legendry
	{'Strike of the Windlord', 'player.area(9).enemies>=1', 'target'},
	{'Fists of Fury', 'target.inMelee'},
	{{
		{'Tiger Palm', 'UI(auto_dot)', 'NOC_sck(Mark of the Crane)'},
		{'Tiger Palm'},
	}, 'player.energydiff=0&player.chi<=3&player.buff(Storm, Earth, and Fire)&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=8||{player.spell(Spinning Crane Kick).count>=3&player.area(8).enemies>=2&toggle(AoE)}||{player.area(8).enemies>=3&toggle(AoE)}}'},
	{'Rising Sun Kick', 'target.inMelee&UI(auto_dot)', 'NOC_sck(Mark of the Crane)'},
	{'Rising Sun Kick', 'target.inMelee'},
	{'Spinning Crane Kick', '!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)&player.spell(Spinning Crane Kick).count>=16'},
	{'Whirling Dragon Punch'},
	-- TODO: add support for CJL with legenadry Emperors Capcitor
	{'Spinning Crane Kick', '{!lastgcd(Spinning Crane Kick)&@Zylla.hitcombo(Spinning Crane Kick)}&{player.spell(Spinning Crane Kick).count>=5||{player.area(8).enemies>=2&toggle(AoE)}}'},
	{'Rushing Jade Wind', 'player.chidiff>1&!lastgcd(Rushing Jade Wind)&@Zylla.hitcombo(Rushing Jade Wind)'},
	{{
		{'Blackout Kick', 'UI(auto_dot)&{player.chi>1||player.buff(Blackout Kick!)}', 'NOC_sck(Mark of the Crane)'},
		{'Blackout Kick', 'player.buff(Blackout Kick!)||player.chi>1'},
	}, '!lastgcd(Blackout Kick)&@Zylla.hitcombo(Blackout Kick)&target.inMelee'},
	{'Chi Wave', 'player.timetomax>=2.25&target.combat'}, -- 40 yard range 0 energy, 0 chi
	{'Chi Burst', '!player.moving&player.timetomax>=2.25'},
	{{
		{'Tiger Palm', 'UI(auto_dot)', 'NOC_sck(Mark of the Crane)'},
		{'Tiger Palm'},
	}, 'player.energy>50&!lastgcd(Tiger Palm)&@Zylla.hitcombo(Tiger Palm)&target.inMelee'},

	-- CJL when we're using Hit Combo as a last resort filler, at 100 energy, and it's toggled on
	{'Crackling Jade Lightning', 'UI(auto_cjl_hc)&target.inMelee&!lastgcd(Crackling Jade Lightning)&@Zylla.hitcombo(Crackling Jade Lightning)&player.energydiff=0'},

	-- Last resort BoK when we only have 1 chi and no hit combo
	{'Blackout Kick', 'player.chi=1&!player.buff(Hit Combo)&target.inMelee'},
	-- Last resort TP when we don't have hit combo up
	{'Tiger Palm', '!player.buff(Hit Combo)&target.inMelee'},
	-- Last resrt TP when at 100 energy - doing this because it's sometimes
	-- getting parried/missed and we're stuck thinking it was latcast and
	-- don't do anything, so as a fallthrough we'll cast when at 100 energy
	-- no matter what. May replace with CJL when @ 100 energy instead
	{'Tiger Palm', 'player.energy>=100&target.inMelee'},
}

local inCombat={
	{_Zylla, 'UI(kAutoTarget)'},
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{_All},
	{_Survival, 'player.health<100'},
	{_Interrupts, 'target.interruptAt(55)&target.inMelee'},
	{_Cooldowns, 'toggle(cooldowns)&target.inMelee'},
	{_Serenity, 'toggle(cooldowns)&target.inMelee&talent(7,3)&!player.casting(Fists of Fury)&{player.spell(Serenity).cooldown=0||player.buff(Serenity)}'},
	-- TODO: handle legendary Drinking Horn Cover
	{_SEF, 'target.inMelee&UI(sef_toggle)&!talent(7,3)&!player.casting(Fists of Fury)&{player.spell(Strike of the Windlord).exists&player.spell(Strike of the Windlord).cooldown<=14&player.spell(Fists of Fury).cooldown<=6&player.spell(Rising Sun Kick).cooldown<=6}'},
	{_Melee, '!player.casting(Fists of Fury)'},
	{_Ranged, '!target.inMelee&target.inRanged&target.combat'},
}

local outCombat={
	{'Effuse', 'player.health<=50&player.lastmoved>=1', 'player'},
	-- Automatic res of dead party members
	{'%ressdead(Resuscitate)', 'UI(auto_res)'},
	-- TODO: Add support for (optional) automatic potion use w/pull timer
}

NeP.CR:Add(269, {
	name='[|cff'..Zylla.addonColor..'Zylla|r] Monk - Windwalker',
	ic=inCombat,
	ooc=outCombat,
	gui=GUI,
	load=exeOnLoad
})
