local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl:  Flamestrike (Target Ground)', align = 'center'},
	{type = 'text', 	text = 'Left Alt:  Rune of Power', align = 'center'},
	{type = 'text', 	text = 'Right Alt:  ', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
	{type = 'ruler'},	{type = 'spacer'},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMage |cffADFF2FFire |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/X - 3/2 - 4/2 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xTimeWarp',
		name = 'Time Warp',
		text = 'Automatically use Time Warp.',
		icon = 'Interface\\Icons\\ability_mage_timewarp',
	})

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Rune of Power', 'keybind(lalt)'},
	{'!Flamestrike', 'keybind(lcontrol)', 'cursor.ground'}
}

local PreCombat = {
	{'Blazing Barrier' , '!player.buff(Blazing Barrier)&player.area(40).enemies>0'},
}

local Interrupts = {
	{'!Counterspell'},
	{'!Arcane Torrent', 'target.inMelee&spell(Counterspell).cooldown>gcd&!player.lastcast(Counterspell)'}
}

local Cooldowns = {
	--# Executed every time the actor is available.
	{'Time Warp', 'toggle(xTimeWarp)&{{xtime==0&!player.buff(Bloodlust)}||{!player.buff(Bloodlust)&equipped(132410)}}'},
	{'#trinket2', 'target.range<41&target.area(10).enemies>3'},
}

local Survival = {
	{'!Ice Block', 'player.health<30||player.debuff(Cauterize)'},
	{'Blazing Barrier' , '!player.buff(Blazing Barrier)'},
}

local Talents = {
	{'Flame On', 'action(Fire Blast).charges<0.2&{player.spell(Combustion).cooldown>65||target.time_to_die<player.spell(Combustion).cooldown}'},
	{'Blast Wave', '!player.buff(Combustion)||{player.buff(Combustion)&action(Fire Blast).charges<1&action(Phoenix\'s Flames).charges<1}'},
	{'Meteor', 'player.spell(Combustion).cooldown>30||{{player.spell(Combustion).cooldown>target.time_to_die}||player.buff(Rune of Power)}'},
	{'Cinderstorm', 'player.spell(Combustion).cooldown<action(Cinderstorm).cast_time&{{player.buff(Rune of Power)||!talent(3,2)}||player.spell(Combustion).cooldown>10*spell_haste&!player.buff(Combustion)}'},
	{'Dragon\'s Breath', 'equipped(132863)'},
	{'Living Bomb', 'target.area(10).enemies>1&!player.buff(Combustion)'}
}

local Combustion = {
	{'Rune of Power', '!player.buff(Combustion)'},
	{Talents},
	{'&Combustion', 'player.buff(Rune of Power)||player.casting(Rune of Power).percent>80'},
	{'Blood Fury'},
	{'Berserking'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&player.buff(Combustion)'},
	--Want to cast Flames if we have 3 charges so we can recharges going
	{'Phoenix\'s Flames', 'action(Phoenix\'s Flames).charges>2.7&player.buff(Combustion)&!player.buff(Hot Streak!)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&player.buff(Combustion)'},
	{'Phoenix\'s Flames'},
	{'Scorch', 'player.buff(Combustion).duration>action(Scorch).cast_time'},
	{'Scorch'}
}

local RoP = {
	{'Rune of Power'},
	{'&Pyroblast', 'player.buff(Hot Streak!)'},
	{Talents},
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)'},
	{'&Fire Blast', 'player.buff(Heating Up)&!player.lastcast(Fire Blast)&!player.casting(Rune of Power)&!player.lastcast(Phoenix\'s Flames)'},
	{'Phoenix\'s Flames', '!player.lastgcd(Phoenix\'s Flames)'},
	{'Scorch', 'target.health<35&equipped(132454)'},
	{'Fireball'}
}

local MainRotation = {
	{'Pyroblast', 'player.buff(Hot Streak!)&player.buff(Hot Streak!).duration<action(Fireball).execute_time'},
	{'Phoenix\'s Flames', 'action(Phoenix\'s Flames).charges>2.7&target.area(8).enemies>2'},
	{'Flamestrike', 'talent(6,3)&target.area(10).enemies>2&player.buff(Hot Streak!)', 'target.ground'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&!player.lastgcd(Pyroblast)&{player.casting(Fireball).percent>90||player.lastcast(Fireball)}'},
	{'&Pyroblast', 'player.buff(Hot Streak!)&target.health<35&equipped(132454)'},
	{'Pyroblast', 'player.buff(Kael\'thas\'s Ultimate Ability)'},
	{Talents},
	--{'&Fire Blast', 'player.buff(Heating Up)&!prev_off_gcd(Fire Blast)&action(Fire Blast).charges>0&player.spell(Combustion).cooldown<action(Fire Blast).cooldown_to_max'},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&!player.casting(Rune of Power)&!talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.4||player.spell(Combustion).cooldown<40}&(3-action(Fire Blast).charges)*(12*spell_haste)<=player.spell(Combustion).cooldown+3'},
	{'&Fire Blast', 'player.casting(Fireball).percent>40&xtime>3&!player.casting(Rune of Power)&talent(7,1)&player.buff(Heating Up)&!player.lastcast(Fire Blast)&{!talent(3,2)||action(Fire Blast).charges>1.5||player.spell(Combustion).cooldown<40}&{3-action(Fire Blast).charges}*{18*spell_haste}<=player.spell(Combustion).cooldown+3'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)||player.buff(Incanter\'s Flow).stack>3||talent(3,1)}&{{4-action(Phoenix\'s Flames).charges}*13<player.spell(Combustion).cooldown+5||target.time_to_die<10}'},
	{'Phoenix\'s Flames', '{player.buff(Combustion)||player.buff(Rune of Power)}&{4-action(Phoenix\'s Flames).charges}*30<player.spell(Combustion).cooldown+5'},
	{'Scorch', 'target.health<35&equipped(132454)'},
	{'Ice Floes', 'player.spell(61304).cooldown<0.5&player.moving&!player.lastcast(Ice Floes)&!player.buff(Ice Floes)'},
	{'Fireball', '!player.moving||player.buff(Ice Floes)'},
	{'Ice Barrier', '!player.buff(Ice Barrier)&!player.buff(Combustion)&!player.buff(Rune of Power)'},
	{'Scorch', 'player.moving&!player.buff(Ice Floes)'},
	{'Dragon\'s Breath', 'target.range<22&player.area(10).enemies>1'},
}

local xCombat = {
	{'Rune of Power', '!player.moving&toggle(cooldowns)&{{player.spell(Combustion).cooldown>40}&{!player.buff(Combustion)&{player.spell(Flame On).cooldown<5||player.spell(Flame On).cooldown>30}&!talent(7,1)||target.time_to_die<11||talent(7,1)&{action(Rune of Power).charges>1.8||xtime<40}&{player.spell(Combustion).cooldown>40)}}}'},
	{Combustion, '!player.moving&{player.spell(Combustion).cooldown<=action(Rune of Power).cast_time+gcd||player.buff(Combustion)}'},
	{RoP, '!player.moving&player.buff(Rune of Power)&!player.buff(Combustion)'},
	{MainRotation, '!player.casting(Rune of Power)'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(interrupts)&target.inFront&target.range<41'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<41&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(63, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Fire',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
