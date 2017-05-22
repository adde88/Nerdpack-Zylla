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
	print("|cffADFF2F --- |PRIEST |cffADFF2FHoly|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F --- |r")
	print("|cffADFF2F --- |rThis rotation does not work at the moment!|")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "target.dead||!target.exists" },
}

local Keybinds = {

}


local Cooldowns = {

}


local inCombat = {

}

local outCombat = {

}

NeP.CR:Add(256, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] PRIEST - Holy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
