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

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |ROGUE |cffADFF2FAssassination|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F --- |r")
	print("|cffADFF2F --- |rThis rotation does not work at the moment!|")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
end

local _Zylla = {
    {'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

local Survival = {

}

local Cooldowns = {
	{'Vendetta'}
}

local InCombat = {
	-- Poisons
	{'Deadly Poison', '!player.buff(Deadly Poison)'},
	{'Crippling Poison', '!player.buff(Crippling Poison)'},
	--Rupture maintained with 5 Combo Points.
	{'Rupture', {'player.combopoints>=5', 'target.debuff(Rupture).duration<5'}},
	--Garrote to maintain the DoT.
	{'Garrote', '!target.debuff(Garrote)'},
	--Envenom to dump excess Combo Points.
	{'Envenom', 'player.combopoints>=5'},
	--Mutilate or  to build Combo Points.
	{'Fan of Knives', {'toggle(AoE)', 'player.area(8).enemies>=3'}},
	{'Mutilate'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local inCombat = {
	{_Zylla, 'toggle(AutoTarget)'},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{InCombat, {'target.range<8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	-- Poisons
	{'Deadly Poison', '!player.buff(Deadly Poison)'},
	{'Crippling Poison', '!player.buff(Crippling Poison)'},
}

NeP.CR:Add(259, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Assassination',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
