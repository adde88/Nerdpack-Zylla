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

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSHAMAN |cffADFF2FEnhancement |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/X - 3/X - 4/3 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "target.dead||!target.exists" },
}

local PreCombat = {
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	{'Ghost Wolf', '!player.buff(Ghost Wolf)'},
}

local Survival = {

}

local Cooldowns = {

}

local Interrupts = {
	{'Wind Shear'},
}

local xCombat = {
	{'Healing Surge', 'player.health<=70&player.maelstrom>=20', 'player'},
	--# Executed every time the actor is available.
	--# Bloodlust casting behavior mirrors the simulator settings for proxy bloodlust. See options 'bloodlust_percent', and 'bloodlust_time'.
	{'Feral Spirit', 'toggle(Cooldowns)'},
	{'Crash Lightning', 'artifact(Alpha Wolf).enabled&prev_gcd(Feral Spirit)'},
	{'Berserking', 'player.buff(Ascendance)||!talent(7,1)||player.level<100'},
	{'Blood Fury'},
	{'Crash Lightning', 'talent(6,1)&player.buff(Crash Lightning).remains<gcd&player.area(8).enemies>=3'},
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd&player.maelstrom<=50&player.area(8).enemies>=3'},
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd||{spell(Boulderfist).charges>1.75&player.maelstrom<=100&player.area(8).enemies<=2}'},
	{'Crash Lightning', 'player.buff(Crash Lightning).remains<gcd&player.area(8).enemies>=2'},
	{'Stormstrike', '!talent(4,3)&player.area(8).enemies>=3'},
	{'Stormstrike', 'player.buff(Stormbringer)'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<gcd'},
	{'Flametongue', 'player.buff(Flametongue).remains<gcd'},
	{'Windsong'},
	{'Ascendance'},
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)'},
	{'Doom Winds'},
	{'Crash Lightning', 'player.area(8).enemies>=3'},
	{'Stormstrike'},
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>=60'},
	{'Lava Lash', 'player.buff(Hot Hand)'},
	{'Earthen Spike'},
	{'Crash Lightning', 'player.area(8).enemies>1||talent(6,1)||spell(Feral Spirit).cooldown>110'},
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<4.5'},
	{'Flametongue', 'player.buff(Flametongue).remains<4.8'},
	{'Sundering'},
	{'Lava Lash', 'player.maelstrom>=90'},
	--{'Rockbiter'},
	{'Flametongue'},
	{'Boulderfist'}
}

local Ranged = {
	{'Lightning Bolt'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'}
}

local inCombat = {
	{_Zylla, 'UI(kAutoTarget)'},
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<=30'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies>=3'}},
	{xCombat, 'target.range<8&target.infront'},
	{Ranged, 'target.range>8&target.range<40&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(263, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Enhancement',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
