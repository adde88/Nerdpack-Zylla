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
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
    {'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

local xCombat = {
	{'Corruption', '!target.dot(Corruption).ticking'},
	{'Drain Life'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Survival = {
	{'#Healthstone', 'player.health<80'},
}

local Cooldowns = {
	{'Berserking'},
	{'Blood Fury'},
	{'Soul Harvest', 'talent(4,3)'},
}

local inCombat = {
	--{_Zylla, 'toggle(AutoTarget)'},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, {'target.range<40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(265, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Affliction',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
