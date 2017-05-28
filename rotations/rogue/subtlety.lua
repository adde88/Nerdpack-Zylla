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
 	print('|cffADFF2F --- |rROGUE |cffADFF2FSubtlety |r')
 	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/X - 5/X - 6/1 - 7/1')
 	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
    {'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

local PreCombat = {
	{'Stealth', '!player.buff(Stealth)||!player.buff(Shadowmeld)'},
	{'Shadowstrike', 'stealthed&target.range<=15&target.infront'},
	--{'#Old War'},
}


local Builders = {
	{'Shuriken Storm', 'player.area(10).enemies>=2'},
	--{'Gloomblade'},
	{'Backstab'},
}

local Cooldowns ={
	{'Blood Fury', 'stealthed'},
	{'Berserking', 'stealthed'},
	{'Shadow Blades', '!stealthed||!player.buff(Shadowmeld)'},
	{'Goremaw\'s Bite', '!player.buff(Shadow Dance)&{{combo_points.deficit>={4-parser_bypass2}*2&energy.deficit>{50+talent(3,3).enabled*25-parser_bypass3}*15}||target.time_to_die<8}'},
	{'Marked for Death', 'target.time_to_die<combo_points.deficit||combo_points.deficit>=5'},
}

local Finishers = {
	{'Enveloping Shadows', 'player.buff(Enveloping Shadows).remains<target.time_to_die&player.buff(Enveloping Shadows).remains<=combo_points*1.8'},
	{'Death from Above', 'player.area(8).enemies>=6'},
	{'Nightblade', 'target.time_to_die>8&{{dot.refreshable(Nightblade){!artifact(Finality).enabled||player.buff(Finality: Nightblade)}}||target.dot(Nightblade).remains<target.dot(Nightblade).tick_time}'},
	{'Death from Above'},
	{'Eviscerate'},
}

local Stealth_Cooldowns = {
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>=2.65'},
	{'Vanish', '!stealthed'},
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>=2&combo_points<=1'},
	{'Shadowmeld', 'player.energy>=40-variable.ssw_er&energy.deficit>10'},
	{'Shadow Dance', '!stealthed&combo_points<=1'},
}

local Stealthed = {
	{'Symbols of Death', '!player.buff(Shadowmeld)&{{player.buff(Symbols of Death).remains<target.time_to_die-4&player.buff(Symbols of Death).remains<=player.buff(Symbols of Death).duration*0.3}||{xequipped(137032)&energy.time_to_max<0.25}}'},
	{Finishers, 'combo_points>=5'},
	{'Shuriken Storm', '!player.buff(Shadowmeld)&{{combo_points.deficit>=3&player.area(10).enemies>=2+talent(6,1).enabled+xequipped(137032)}||player.buff(The Dreadlord\'s Deceit).stack>=29}'},
	{'Shadowstrike'},
}

local xCombat = {
	{Cooldowns, 'toggle(Cooldowns)'},
	--# Fully switch to the Stealthed Rotation {by doing so, it forces pooling if nothing is available}
	{Stealthed, 'stealthed||player.buff(Shadowmeld)'},
	{Finishers, 'combo_points>=5||{combo_points>=4&player.area(10).enemies>=3&player.area(10).enemies<=4}'},
	{Stealth_Cooldowns, 'combo_points.deficit>=2+talent(6,1).enabled&{variable.ed_threshold||{cooldown(Shadowmeld).up&!cooldown(Vanish).up&cooldown(Shadow Dance).charges<=1}||target.time_to_die<12||player.area(10).enemies>=5}'},
	{Builders, 'variable.ed_threshold'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'Kick'},
	{'Cheap Shot', 'cooldown(Kick).remains>gcd'},
	{'Kidney Shot', 'cooldown(Kick).remains>gcd'},
	{'Blind', 'cooldown(Kick).remains>gcd'},
}

local Survival ={
	{'Crimson Vial', 'player.health<=70'},
}

local inCombat = {
	{_Zylla, 'toggle(AutoTarget)'},
	{Keybinds},
	{Interrupts, 'target.interruptAt(47)&toggle(Interrupts)&target.infront&target.range<8'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<8&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(261, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] ROGUE - Subtlety',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
