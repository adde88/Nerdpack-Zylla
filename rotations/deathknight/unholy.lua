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
	print("|cffADFF2F --- |rDEATH KNIGHT |cffADFF2FUnholy|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	
end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "{target.dead||!target.exists}&!player.area(40).enemies=0" },
}

local Survival = {

}

local Cooldowns = {

}

local AoE = {

}

local ST = {
	--Virulent Plague maintained at all times via Outbreak.
	{'Outbreak', '!target.debuff(Virulent Plague)'},
	--Death Coil with Sudden Doom procs.
	{'Death Coil', 'player.buff(Sudden Doom)'},
	--Scourge Strike to burst Festering Wound.
	{'Scourge Strike', 'target.debuff(Festering Wound)'},
	--Festering Strike to apply Festering Wound.
	{'Festering Strike', '!target.debuff(Festering Wound)'},
	--Death Coil to dump Runic Power.
	{'Death Coil'}
}

local inCombat = {
	{_Zylla, 'UI(kAutoTarget)'},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, {'toggle(AoE)&player.area(8).enemies>=3'}},
	{ST, {'target.range<8&target.infront'}}
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Death and Decay', 'keybind(shift)', 'cursor.ground'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(252, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death Knight - Unholy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
