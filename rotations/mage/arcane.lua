local _, Zylla = ...
local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rMage |cffADFF2FArcane|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F --- |r")
	print("|cffADFF2F --- |rThis rotation does nothing at the moment!|")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	
end

local _Zylla = {
	{"/targetenemy [noexists]", "!target.exists" },
    {"/targetenemy [dead][noharm]", "target.dead" },
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
	-- {'%pause', 'keybind(alt)'},
}

local inCombat = {
	{_Zylla, 'UI(kAutoTarget)'},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
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
