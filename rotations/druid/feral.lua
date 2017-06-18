local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
} 

local exeOnLoad = function()
	Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FFeral |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|')
	print('| This routine does not work at the moment...')
end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'Skull Bash'},
	{'Typhoon', 'talent(4,3)&cooldown(Skull Bash).remains>gcd'},
	{'Mighty Bash', 'talent(4,1)&cooldown(Skull Bash).remains>gcd'},
}

-- Pool START

local Bear_Healing = {
	{'Bear Form', 'form~=1'},
	{'Frenzied Regeneration'},
}

local Regrowth_Pool = {
	{'!Regrowth'},
}

local Moonfire_Pool = {
	{'%pause', 'player.energy<30&!player.buff(Clearcasting)'},
	{'Moonfire'},
}

local Rake_Pool = {
	{'%pause', 'player.energy<35&!player.buff(Clearcasting)'},
	{'Rake'},
}

local Rip_Pool = {
	{'%pause', 'player.energy<30&!player.buff(Clearcasting)'},
	{'Rip'},
}

local Savage_Roar_Pool = {
	{'%pause', 'player.energy<40&!player.buff(Clearcasting)'},
	{'Savage Roar'},
}

local Ferocious_Bite_Pool = {
	{'%pause', 'player.energy<25&!player.buff(Clearcasting)'},
	{'Ferocious Bite'},
}

local Thrash_Pool = {
	{'%pause', 'player.energy<50&!player.buff(Clearcasting)'},
	{'Thrash'},
}

local Swipe_Pool = {
	{'%pause', 'player.energy<45&!player.buff(Clearcasting)'},
	{'Swipe'},
}

-- Pool END

local PreCombat = {
	{'Travel Form', '!indoors&!player.buff(Travel Form)&!player.buff(Prowl)&{!target.enemy||target.enemy&!target.alive}'},
	{Regrowth_Pool, 'talent(7,2)&target.enemy&target.alive&!player.buff(Prowl)&!prev(Regrowth)&player.buff(Bloodtalons).stack<2'},
	{'Cat Form', '!player.buff(Cat Form)&!player.buff(Travel Form)'},
 	{'Prowl', '!player.buff(Prowl)&target.enemy&target.alive'},
 	{'Rake', 'player.buff(Prowl)&target.range<5&target.inFront'},
}

local SBT_Opener = {
	--# Hard-cast a Regrowth for Bloodtalons buff. Use Dash to re-enter Cat Form.
	{Regrowth_Pool, 'talent(7,2)&combo_points=5&!player.buff(Bloodtalons)&!target.dot(Rip).ticking'},
	--# Force use of Tiger's Fury before applying Rip.
	{'Tiger\'s Fury', '!target.dot(Rip).ticking&combo_points=5'},
}

local Cooldowns = {
	{'Rake', 'player.buff(Prowl)||player.buff(Shadowmeld)'},
	{'Berserk', 'player.buff(Tiger\'s Fury)'},
	{'Incarnation: King of the Jungle', 'talent(5,2)&{cooldown(Tiger\'s Fury).remains<gcd}'},
	{'Tiger\'s Fury', '{!player.buff(Clearcasting)&energy.deficit>=60}||energy.deficit>=80'},
	{'Incarnation: King of the Jungle', 'talent(5,2)&{energy.time_to_max>1&player.energy>=35}'},
	{Ferocious_Bite_Pool, 'target.dot(Rip).ticking&target.dot(Rip)remains<3&target.time_to_die>3&{target.health<25||talent(6,1)}'},
	{Regrowth_Pool, 'talent(7,2)&player.buff(Predatory Swiftness)&{combo_points>=5||player.buff(Predatory Swiftness).remains<1.5||{talent(7,2)&combo_points=2&!player.buff(Bloodtalons)&cooldown(Ashamane\'s Frenzy).remains<gcd}}'},
	{SBT_Opener, 'talent(6,1)&xtime<20'},
	--# Special logic for Ailuro Pouncers legendary.
	{Regrowth_Pool, 'equipped(137024)&talent(7,2)&player.buff(Predatory Swiftness).stack>1&!player.buff(Bloodtalons)'},
}

local Finisher = {
	{Savage_Roar_Pool, 'talent(5,3)&{!player.buff(Savage Roar)&{combo_points=5||talent(7,3)&action(Brutal Slash).charges>0}}'},
	{Thrash_Pool, 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies>=5'},
	{Swipe_Pool, 'player.area(8).enemies>=8'},
	{Rip_Pool, '{!target.dot(Rip).ticking||{target.dot(Rip).remains<8&target.health>25&!talent(6,1)}||persistent_multiplier(Rip)>dot(Rip).pmultiplier}&{target.time_to_die-target.dot(Rip).remains>dot(Rip).tick_time*4&combo_points=5}&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting)}||talent(5,1)||!target.dot(Rip).ticking||{target.dot(Rake).remains<1.5&player.area(8).enemies<6}}'},
	{Savage_Roar_Pool, 'talent(5,3)&{{{player.buff(Savage Roar).duration<=10.5&talent(6,2)}||{player.buff(Savage Roar).duration<=7.2&!talent(6,2)}}&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||player.buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5&player.area(8).enemies<6}}}'},
	{'Swipe', 'combo_points=5&{player.area(8).enemies>=6||{player.area(8).enemies>=3&!talent(7,2)}}&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting)}}'},
	{'Ferocious Bite', 'energy.deficit=0&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting)}}'},
}

local Generator = {
	{'Brutal Slash', 'talent(7,1)&combo_points<5'},
	{'!Ashamane\'s Frenzy', 'combo_points<=2&toggle(Cooldowns)&{player.buff(Bloodtalons)||!talent(7,2)}&{player.buff(Savage Roar)||!talent(5,3)}'},
	{'Elune\'s Guidance', 'talent(6,3)&{combo_points=0&player.energy<action(Ferocious Bite).cost+25-energy.regen*cooldown(Elune\'s Guidance).remains}'},
	{'Elune\'s Guidance', 'talent(6,3)&{combo_points=0&player.energy>=action(Ferocious Bite).cost+25}'},
	{Thrash_Pool, 'talent(7,1)&player.area(8).enemies>=9'},
	{Swipe_Pool, 'player.area(8).enemies>=6'},
	--{'', ''},
	{Rake_Pool, 'combo_points<5&{!target.dot(Rake).ticking||{!talent(7,2)&target.dot(Rake).remains<target.dot(Rake).duration*0.3}||{talent(7,2)&player.buff(Bloodtalons)&{!talent(5,1)&target.dot(Rake).remains<=7||target.dot(Rake).remains<=5}&persistent_multiplier(Rake)>dot(Rake).pmultiplier*0.80}}&target.time_to_die-target.dot(Rake).remains>dot(Rake).tick_time'},
	{Moonfire_Pool, 'talent(1,3)&combo_points<5&target.dot(Moonfire).remains<=4.2&target.time_to_die-target.dot(Moonfire).remains>dot(Moonfire).tick_time*2'},
	{Thrash_Pool, 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies>=2'},
	--{'Brutal Slash', 'combo_points<5&{{}}'},
	{'Swipe', 'combo_points<5&player.area(8).enemies>=3'},
	{'Shred', 'combo_points<5&{player.area(8).enemies<3||talent(7,1)}'},
}

local xCombat = {
	{Finisher},
	{Generator},
}

local Survival = {
	{Bear_Healing, 'talent(3,2)&player.incdmg(5)>player.health.max*0.20&!player.buff(Frenzied Regeneration)'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'cooldown(Swiftmend)up.&form>0&talent(3,3)&player.health<=75'},
	{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival, 'player.health<100'},
	{'Cat Form', '!player.buff(Frenzied Regeneration)&{!player.buff(Cat Form)&{!player.buff(Travel Form)||player.area(8).enemies>=1}}'},
	{Cooldowns, '!player.buff(Frenzied Regeneration)&toggle(Cooldowns)'},
	{Moonfire_Pool, 'talent(1,3)&!target.inMelee&target.range<=40&target.inFront&!player.buff(Prowl)&!target.debuff(Moonfire)'},
	{xCombat, '!player.buff(Frenzied Regeneration)&target.inMelee&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(103, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Feral',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
