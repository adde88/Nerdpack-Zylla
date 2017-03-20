local _, Zylla = ...
local GUI = {
} 
local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rMAGE |cffADFF2FArcane|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F --- |r")
	print("|cffADFF2F --- |rThis rotation does nothing at the moment!|")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	
end

local _Zylla = {
	{'@Zylla.Targeting()', {'!target.alive&toggle(AutoTarget)'}},
}

local Survival = {

}

local Cooldowns = {

}

local AoE = {

}

local ST = {

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{_Zylla}'
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies>=3'}},
	{ST, {'target.range<=40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(62, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Arcane',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
