local _, Zylla = ...
local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	
} 

local exeOnLoad = function()
	Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FBalance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/2 - 3/X - 4/X - 5/2 - 6/3 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	{'Moonkin Form', '!player.buff(Moonkin Form)&!player.buff(Travel Form)'},
	{'Blessing of the Ancients', '!player.buff(Blessing of Elune)'},
	--{'New Moon', 'artifact(New Moon).enabled'},
}


local CA = {
	{'Starfall', '{target.area(15).enemies>=2&talent(5,3)||target.area(15).enemies>=3}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Starsurge', 'target.area(15).enemies<=2'},
	{'Warrior of Elune', ''},
	{'Lunar Strike', 'player.buff(Warrior of Elune)'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains'},
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>=2'},
	{'Solar Wrath'},
}

local ED = {
	{'Astral Communion', 'astral_power.deficit>=75&player.buff(The Emerald Dreamcatcher)'},
	{'Incarnation: Chosen of Elune', 'astral_power>=85&!player.buff(The Emerald Dreamcatcher)'},
	{'Celestial Alignment', 'astral_power>=85&!player.buff(The Emerald Dreamcatcher)'},
	{'Starsurge', '{player.buff(The Emerald Dreamcatcher).remains<gcd.max}||astral_power>=90||{{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astral_power>=85}'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&target.debuff(Stellar Flare).remains<7.2&astral_power>=15}'},
	{'Moonfire', '{talent(7,3)&target.debuff(Moonfire).remains<3}||{target.debuff(Moonfire).remains<6.6&!talent(7,3)}'},
	{'Sunfire', '{talent(7,3)&target.debuff(Sunfire).remains<3}||{target.debuff(Sunfire).remains<5.4&!talent(7,3)}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Solar Wrath).execute_time&astral_power>=12&dot(Sunfire).remains<5.4&dot(Moonfire).remains>6.6'},
	{'Lunar Strike', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Lunar Strike).execute_time&astral_power>=8&{!{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}||{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astral_power<=77}'},
	{'New Moon', 'astral_power<=90'},
	{'Half Moon', 'astral_power<=80'},
	{'Full Moon', 'astral_power<=60'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath'},
}

local FoE = {
	{'Incarnation: Chosen of Elune', 'astral_power>=95&cooldown(Fury of Elune).remains<=gcd'},
	{'Fury of Elune', 'astral_power>=95'},
	{'New Moon', '{{cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<=90}}'},
	{'Half Moon', '{{cooldown(New Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<=80}}'},
	{'Full Moon', '{{cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<=60}}'},
	{'Astral Communion', 'player.buff(Fury of Elune)&astral_power<=25'},
	{'Warrior of Elune', 'player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>=35&player.buff(Lunar Empowerment)}'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astral_power<=90||{astral_power<=85&player.buff(Incarnation: Chosen of Elune)}}'},
	{'New Moon', 'astral_power<=90&player.buff(Fury of Elune)'},
	{'Half Moon', 'astral_power<=80&player.buff(Fury of Elune)&astral_power>action(Half Moon).cast_time*12'},
	{'Full Moon', 'astral_power<=60&player.buff(Fury of Elune)&astral_power>action(Full Moon).cast_time*12'},
	{'Moonfire', '!player.buff(Fury of Elune)&target.dot(Moonfire).remains<=6.6'},
	{'Sunfire', '!player.buff(Fury of Elune)&target.dot(Sunfire).remains<=5.4'},
	{'Stellar Flare', 'target.dot(Stellar Flare).remains<=7.2&player.area(40).enemies=1'},
	{'Starfall', '{target.area(15).enemies>=2&talent(5,3)||target.area(15).enemies>=3}&player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>10', 'target.ground'},
	{'Starsurge', 'target.area(15).enemies<=2&!player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>7'},
	{'Starsurge', '!player.buff(Fury of Elune)&{{astral_power>=92&cooldown(Fury of Elune).remains>gcd*3}||{cooldown(Warrior of Elune).remains<=5&cooldown(Fury of Elune).remains>=35&player.buff(Lunar Empowerment).stack<2}}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack=3||{player.buff(Lunar Empowerment).remains<5&buff(Lunar Empowerment)}||target.area(5).enemies>=2'},
	{'Solar Wrath'},
}

local ST = {
	{'New Moon', 'astral_power<=90'},
	{'Half Moon', 'astral_power<=80'},
	{'Full Moon', 'astral_power<=60'},
	{'Starfall', '{target.area(15).enemies>=2&talent(5,3)||target.area(15).enemies>=3}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Starsurge', 'player.area(40).enemies<=2&{player.buff(Solar Empowerment).stack<3||player.buff(Lunar Empowerment).stack<3}'},
	{'Warrior of Elune'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains'},
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>=2'},
	{'Solar Wrath'},
}

local xCombat = {
	--# Executed every time the actor is available.
	{'#Deadly Grace', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{'Blessing of the Ancients', 'player.area(40).enemies<=2&talent(6,3)&!player.buff(Blessing of Elune)'},
	{'Blessing of the Ancients', 'player.area(40).enemies>=3&talent(6,3)&!player.buff(Blessing of An\'she)'},
	{'Blood Fury', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{'Berserking', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{FoE, 'talent(7,1)&{cooldown(Fury of Elune).remains<target.time_to_die}'},
	{ED, 'xequipped(137062)'},
	{'New Moon', 'cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges=3'},
	{'Half Moon', 'cooldown(Half Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges=3||{target.time_to_die<15&cooldown(Half Moon).charges<3}'},
	{'Full Moon', 'cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges=3||target.time_to_die<15'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&target.debuff(Stellar Flare).remains<7.2&astral_power>=15}'},
	{'Moonfire', '{talent(7,3)&target.debuff(Moonfire).remains<3}||{target.debuff(Moonfire).remains<6.6&!talent(7,3)}'},
	{'Sunfire', '{talent(7,3)&target.debuff(Sunfire).remains<3}||{target.debuff(Sunfire).remains<5.4&!talent(7,3)}'},
	{'Astral Communion', 'astral_power.deficit>=75'},
	{'Incarnation: Chosen of Elune', 'astral_power>=40'},
	{'Celestial Alignment', 'astral_power>=40'},
	{'Starfall', 'player.buff(Oneth\'s Overconfidence)', 'target.ground'},
	{'Solar Wrath', 'player.buff(Solar Empowerment).stack=3'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack=3'},
	{CA, 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{ST},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'Skull Bash'},
	{'Typhoon', 'talent(4,3)'},
	{'Mighty Bash', 'talent(4,1)'},
}

local Survival = {
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<=75'},
	{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
}

local Cooldowns = {

}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<=40'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'target.range<=40&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(102, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Balance',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
