local _, Zylla = ...

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl:  Flamestrike (Target Ground)', align = 'center'},
	{type = 'text', 	text = 'Left Alt:  Rune of Power', align = 'center'},
	{type = 'text', 	text = 'Right Alt:  ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},
	{type = 'checkbox', text = 'Combustion Enabled', key = 'kCombustion', default = true},
   	{type = 'checkbox', text = 'Cinderstorm Enabled', key = 'kCinderstorm', default = true},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = false},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = false}
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMage |cffADFF2FFire |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/X - 3/2 - 4/2 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = { 
	{'@Zylla.Targeting()', {'!target.alive&UI(kAutoTarget)'}},
}

local Keybinds = {
	{'%pause', 'keybind(lshift))&UI(kPause)'},
	{'Rune of Power', 'keybind(lalt)'},
	{'Flamestrike', 'keybind(lcontrol)', 'target.ground'},
}

local Trinkets = {
	{'#trinket1', 'UI(kT1)'},
	{'#trinket2', 'UI(kT2)'},
}

local PreCombat = {
	
}

local Interrupts = {
	{'Counterspell'},
	{'Arcane Torrent', 'target.range<=8&spell(Counterspell).cooldown>gcd&!player.lastcast(Counterspell)'},
}


local Cooldowns = {
	--Empty
}

local Survival = {
	{'Ice Block', 'player.health<19'},
	{'Ice Block', 'player.debuff(Cauterize)'},
}

local Talents = {
	{'Flame On', 'talent(4,2)&{action(Fire Blast).charges<0.2&{cooldown(Combustion).remains>65||target.time_to_die<cooldown(Combustion).remains}}'},
	{'Blast Wave', 'talent(4,1)&{{!player.buff(Combustion)}||{player.buff(Combustion)&action(Fire Blast).charges<1&action(Phoenix\'s Flames).charges<1}}'},
	{'Meteor', 'talent(7,3)&{cooldown(Combustion).remains>30||{cooldown(Combustion).remains>target.time_to_die}||player.buff(Rune of Power)}'},
	{'Cinderstorm', 'UI(kCinderstorm)&talent(7,2)&{cooldown(Combustion).remains<action(Cinderstorm).cast_time&{player.buff(Rune of Power)||!talent(3,2)}||cooldown(Combustion).remains>10*spell_haste&!player.buff(Combustion)}'},
	{'Dragon\'s Breath', 'equipped(132863)'},
	{'Living Bomb', 'talent(6,1)&target.area(10).enemies>1&!player.buff(Combustion)'}
}

local Combustion = {
	{'Rune of Power', '!player.buff(Combustion)'},
	{Talents},
	{'&Combustion', 'player.buff(Rune of Power)||player.casting(Rune of Power).percent>80'},
	{'Blood Fury'},
	{'Berserking'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&player.buff(Combustion)'},
	-- We want to cast Flames if we have 3 charges, so we can get recharges going
	{'Phoenix\'s Flames', 'action(Phoenix\'s Flames).charges>2.7&player.buff(Combustion)&!player.buff(Hot Streak!)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&player.buff(Combustion)'},
	{'Phoenix\'s Flames', 'artifact(Phoenix\'s Flames).equipped'},
	{'Scorch', 'player.buff(Combustion).remains>action(Scorch).cast_time'},
	{'Scorch'}
}

local RoP = {
	{'Rune of Power'},
	{'Pyroblast', 'player.buff(Hot Streak!)'},
	{Talents},
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&!player.casting(Rune of Power)&!player.lastcast(Phoenix\'s Flames)'},
	{'Phoenix\'s Flames', '!player.lastgcd(Phoenix\'s Flames)'},
	{'Scorch', 'target.health<=25&equipped(132454)'},
	{'Fireball'}
}

local MainRotation = {
	{'Pyroblast', 'player.buff(Hot Streak!)&player.buff(Hot Streak!).remains<action(Fireball).execute_time'},
	{'Phoenix\'s Flames', 'artifact(Phoenix\'s Flames).equipped&{action(Phoenix\'s Flames).charges>2.7&target.area(8).enemies>2}'},
	{'Flamestrike', 'talent(6,3)&target.area(10).enemies>2&player.buff(Hot Streak!)', 'target.ground'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&!player.lastgcd(Pyroblast)&{player.casting(Fireball).percent>90||player.lastcast(Fireball)}'},
	{'Pyroblast', 'player.buff(Hot Streak!)&target.health<=25&equipped(132454)'},
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)'},
	{Talents},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&!player.casting(Rune of Power)&!talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.4||cooldown(Combustion).remains<40}&(3-action(Fire Blast).charges)*(12*spell_haste)<=cooldown(Combustion).remains+3'},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&!player.casting(Rune of Power)&talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.5||cooldown(Combustion).remains<40}&{3-action(Fire Blast).charges}*{18*spell_haste}<=cooldown(Combustion).remains+3'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)||player.buff(Incanter\'s Flow).stack>3||talent(3,1)}&{4-action(Phoenix\'s Flames).charges}*13<cooldown(Combustion).remains+5||target.time_to_die<10'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)}&{4-action(Phoenix\'s Flames).charges}*30<cooldown(Combustion).remains+5'},
	{'Scorch', 'target.health<=25&equipped(132454)'},
	{'Ice Floes', 'cooldown(61304).remains<0.5&xmoving=1&!player.lastcast(Ice Floes)&!player.buff(Ice Floes)'},
	{'Fireball', 'xmoving=0||player.buff(Ice Floes)'},
	{'Ice Barrier', '!player.buff(Ice Barrier)&!player.buff(Combustion)&!player.buff(Rune of Power)'},
	--Scorch as a filler when moving.
	{'Scorch', 'xmoving=1&!player.buff(Ice Floes)'}
}

local xCombat = {
	{'Rune of Power', 'toggle(Cooldowns)&xmoving=0&{cooldown(Combustion).remains>40||!UI(kCombustion)}&{!player.buff(Combustion)&{cooldown(Flame On).remains<5||cooldown(Flame On).remains>30}&!talent(7,1)||target.time_to_die<11||talent(7,1)&{action(Rune of Power).charges>1.8||xtime<40}&{cooldown(Combustion).remains>40||!UI(kCombustion)}}'},
	{Combustion, 'UI(kCombustion)&toggle(Cooldowns)&xmoving=0&{cooldown(Combustion).remains<=action(Rune of Power).cast_time+gcd||player.buff(Combustion)}'},
	{RoP, 'xmoving=0&player.buff(Rune of Power)&!player.buff(Combustion)'},
	{MainRotation, '!player.casting(Rune of Power)&!player.buff(Combustion)'},
	{'Blazing Barrier' , '!player.buff(Blazing Barrier)', 'player'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<=40'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<40&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(63, {
	name = '[|cff'..Zylla.addonColor..'Zylla|r] Mage - Fire',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
