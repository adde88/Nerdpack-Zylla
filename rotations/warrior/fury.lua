local _, Zylla = ...
local GUI = {
}
local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWARRIOR |cffADFF2FFury |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/3 - 4/2 - 5/1 - 6/3 - 7/3")
	print("|cffADFF2F ----------------------------------------------------------------------|r")

end

local _Zylla = {
	{'@Zylla.Targeting()', {'!target.alive&UI(kAutoTarget)'}},
	--{'Charge', 'target.range>8&target.range<=25&target.infront'},
}

local PreCombat = {
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
}


local Survival = {
	{'Victory Rush', 'player.health<=70'},
}

local Cooldowns = {
	{'Battle Cry', '{spell(Odyn\'s Fury).cooldown=0&{spell(Bloodthirst).cooldown=0||{player.buff(Enrage).remains>spell(Bloodthirst).cooldown}}}'},
	{'Avatar', 'player.buff(Battle Cry)'}, --todo: TTD<{spell(Battle Cry).cooldown+10}
	{'Bloodbath', 'player.buff(Dragon Roar)||{!talent(7,3)&{player.buff(Battle Cry)||spell(Battle Cry).cooldown>10}}'},
	{'Blood Fury', 'player.buff(Battle Cry)'},
	{'Berserking', 'player.buff(Battle Cry)'},
}

local Bladestorm = {
	{'Bladestorm', 'talent(7,1)&player.buff(Enrage).remains>2'}, --raid_event not supported
}

local AoE = {
	{'Bloodthirst', '!player.buff(Enrage)||player.rage<50'},
	{Bladestorm},
	{'Whirlwind', 'player.buff(Enrage)'},
	{'Dragon Roar', 'talent(7,3)'},
	{'Rampage', 'player.buff(Meat Cleaver)'},
	{'Bloodthirst'},
	{'Whirlwind'},
}


local ST = {
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury)&player.buff(Fujieda\'s Fury).stack<2'},
	{'Execute', '{artifact(Juggernaut).enabled&{!player.buff(Juggernaut)||player.buff(Juggernaut).remains<2}}||player.buff(Stone Heart)'},
	{'Rampage', 'player.rage=100&{target.health>20||{target.health<20&!talent(5,1)}||{player.buff(Massacre)&player.buff(Enrage).remains<1}}'},
	{'Berserker Rage', 'talent(3,2)&spell(Odyn\'s Fury).cooldown=0&!player.buff(Enrage)'},
	{'Dragon Roar', '!spell(Odyn\'s Fury).cooldown<=10||spell(Odyn\'s Fury).cooldown<3'},
	{'Odyn\'s Fury', 'artifact(Odyn\'s Fury).equipped&player.buff(Battle Cry)&player.buff(Enrage)'},
	{'Rampage', '!player.buff(Enrage)&!player.buff(Juggernaut)'},
	{'Furious Slash', 'talent(6,2)&{!player.buff(Frenzy)||player.buff(Frenzy).stack<=3}'},
	{'Raging Blow', '!player.buff(Juggernaut)&player.buff(Enrage)'},
	{'Whirlwind', 'talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)'},
	{'Execute', 'talent(6,3)||{!talent(6,3)&player.rage>50}'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', '!player.buff(Enrage)'},
	{'Execute', 'artifact(Juggernaut).enabled'},
	{'Raging Blow'},
	{'Bloodthirst'},
	{'Furious Slash'},
	{Bladestorm},
	{'Bloodbath', 'player.buff(Frothing Berserker)||{player.rage>80&!talent(5,2)}'}
}

local TwoTargets = {
	{'Whirlwind', '!player.buff(Meat Cleaver)'},
	{Bladestorm},
	{'Rampage', '!player.buff(Enrage)||{player.rage=100&!player.buff(Juggernaut)}||player.buff(Massacre)'},
	{'Bloodthirst', '!player.buff(Enrage)'},
	{'Raging Blow', 'talent(6,3)&player.area(8).enemies=2'},
	{'Whirlwind', 'player.area(8).enemies>2'},
	{'Dragon Roar'},
	{'Bloodthirst'},
	{'Whirlwind'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'Pummel'},
	{'Arcane Torrent', 'target.range<=8&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<=8'},
	{_Zylla},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)&target.range<8'},
	{TwoTargets, 'toggle(aoe)&{player.area(8).enemies=2||player.area(8).enemies=3}'},
	{AoE, 'toggle(aoe)&player.area(8).enemies>3'},
	{ST, 'target.range<8&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(72, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] WARRIOR - Fury',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
