local _, Zylla = ...
local GUI = {
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
	{'@Zylla.Targeting()', {'!target.alive&UI(kAutoTarget)'}},
}

local xCombat = {
{'Corruption', '!target.dot(Corruption).ticking'},
{'Drain Life'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
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
	{_Zylla},
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
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] WARLOCK - Affliction',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
