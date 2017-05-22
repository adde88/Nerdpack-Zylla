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
	print("|cffADFF2F --- |rDEMON HUNTER |cffADFF2FHavoc|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "target.dead||!target.exists" },
}

local Survival = {
	{'Blur', 'player.health<=60'}
}

local Interrupts = {
	{'Consume Magic'}
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Cooldowns = {
	{'Metamorphosis', nil, 'target.ground'}
}

local inCombat = {
	{_Zylla, 'UI(kAutoTarget)'},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(50)'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Vengeful Retreat', {'target.range<=6', 'player.spell(Fel Rush).charges>=2', 'player.fury<=85'}},
	{'Fel Rush', {'player.spell(Fel Rush).charges>=2', 'target.range>5'}},
	{'Blade Dance', {'toggle(AoE)', 'player.area(8).enemies>=4'}},
	{'Chaos Strike', 'player.fury>=70'},
	{'Demon\'s Bite'},
}

local outCombat = {
	{Keybinds}
}

NeP.CR:Add(577, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Havoc',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
