local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWarrior |cffADFF2FArms |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/2 - 5/3 - 6/1 - 7/1")
	print("|cffADFF2F ----------------------------------------------------------------------|r")

end

local PreCombat = {}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel'},
	{'!Arcane Torrent', 'target.inMelee&cooldown(Pummel).remains>gcd&!prev_gcd(Pummel)'},
}

local Survival = {
	{'Victory Rush', 'player.health<80'},
}

local Cooldowns = {
	{'Blood Fury', 'player.buff(Battle Cry)'},
	{'Berserking', 'player.buff(Battle Cry)'},
	{'Arcane Torrent', 'player.buff(Battle Cry)&talent(6,1)&rage.deficit>40'},
	{'Battle Cry', '{player.buff(Bloodlust)||xtime>0}&gcd.remains<0.5&{player.buff(Shattered Defenses)||{cooldown(Colossus Smash).remains>gcd&cooldown(Warbreaker).remains>gcd}}'},
	{'Avatar', 'talent(3,3)&{player.buff(Bloodlust)||xtime>0}'},
}

local Opener = {
	{'Charge'},
	{'Focused Rage'},
	{'Colossus Smash'},
	{'Focused Rage'},
	{'Battle Cry'},
	{'Avatar'},
	{'Mortal Strike'},
	{'Focused Rage'},
	{'Colossus Smash'},
	{'Slam'},
	{'Focused Rage'},
	{'Colossus Smash'},
	{'Slam'},
	{'Focused Rage'},
	{'Mortal Strike'},
	{'Slam'},
}

local Etc = {
	{Cooldowns, 'toggle(Cooldowns)'},
	--{'Hamstring', 'player.buff(Battle Cry)&talent(6,1)&!target.debuff(Hamstring)'},	--waste of player.rage i would say unless ... it's PvP, maybe?
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<gcd'},
	--# The tl;dr of this line is to spam focused player.rage inside battle cry, the added nonsense is to help modeling the difficulty of timing focused player.rage immediately after mortal strike.
	--# In game, if focused player.rage is used the same instant as mortal strike, player.rage will be deducted for focused player.rage, the buff is immediately consumed, but it does not buff the damage of mortal strike.
	{'Focused Rage', 'player.buff(Battle Cry)&talent(6,1)&player.buff(Focused Rage).stack<3'},
	{'Colossus Smash', '!target.debuff(Colossus Smash)'},
	{'Warbreaker', 'artifact(Warbreaker).equipped&!target.debuff(Colossus Smash)'},
	{'Ravager', 'talent(7,3)'},
	{'Overpower', 'player.buff(Overpower!)'}
}

local AoE = {
	{'Mortal Strike', 'player.buff(Focused Rage).stack>1'},
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)'},
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<5.5'},
	{'Bladestorm'},
	{'Cleave'},
	{'Execute', 'player.rage>80'},
	{'Whirlwind', 'player.rage>30'},
	{'Shockwave', 'talent(2,1)'},
	{'Storm Bolt', 'talent(2,2)'}
}

local Cleave = {
	{'Mortal Strike', 'player.buff(Focused Rage).stack>1'},
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)'},
	{'Focused Rage', '!player.buff(Shattered Defenses)'},
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<5.5'},
	{'Bladestorm'},
	{'Cleave'},
	{'Whirlwind', 'player.rage>000||player.buff(Focused Rage).stack=3'},
	{'Shockwave', 'talent(2,1)'},
	{'Storm Bolt', 'talent(2,2)'}
}

local Execute = {
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).stack=3'},
	{'Execute', 'player.buff(Battle Cry)&talent(6,1)'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)&player.rage<40'},
	{'Execute', 'player.buff(Shattered Defenses)&player.rage>22'},
	{'Execute', '!player.buff(Shattered Defenses)&{{xequipped(137060)&rage>40}||!xequipped(137060)}'},
	{'Mortal Strike', 'xequipped(137060)'},
	{'Execute', '!player.buff(Shattered Defenses)'},
	{'Bladestorm'},
}

local ST = {
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).stack>0&cooldown(Battle Cry).remains<gcd'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)&cooldown(Mortal Strike).remains<gcd'},
	{'Focused Rage', '{{{!player.buff(Focused Rage)&prev_gcd(Mortal Strike)}||!prev_gcd(Mortal Strike)}&player.buff(Focused Rage).stack<3&{player.buff(Shattered Defenses)||cooldown(Colossus Smash).remains>gcd}}&player.rage>60'},
	{'Mortal Strike', 'player.buff(Focused Rage).stack>0'},
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	--Whirlwind instead of Slam if "Fevor of Battle" is picked
	{'Whirlwind', 'talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).stack=3||rage.deficit<40}'},
	{'Slam', '!talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).stack=3||rage.deficit<40}'},
	{'Mortal Strike', '!talent(5,3)'},
	{'Whirlwind', 'player.area(8).enemies>1||talent(3,1)&player.rage>35'},
	{'Slam', '!talent(3,1)&player.area(8).enemies==1&player.rage>22'},
	{'Execute', 'xequipped(137060)'},
	{'Focused Rage', 'xequipped(137060)'},
	{'Bladestorm'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)&target.inMelee'},
	{Etc, 'target.inMelee&target.inFront'},
	{Cleave, 'toggle(aoe)&player.area(8).enemies>1&talent(1,3)'},
	{AoE, 'toggle(aoe)&player.area(8).enemies>4&!talent(1,3)'},
	{Execute, 'target.inMelee&target.inFront&target.health<30&player.area(8).enemies<5'},
	{ST, 'target.inMelee&target.inFront&target.health>20'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
}

NeP.CR:Add(71, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Arms',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})

--[[
TODO:

Opener:
Charge
Focused Rage -> Colossus Smash
Focused Rage -> Battle Cry
Avatar
Mortal Strike
Focused Rage -> Colossus Smash (Slam if Tactician didn’t proc)
Focused Rage -> Colossus Smash (Slam if Tactician didn’t proc, or if you have Shattered Defenses)
Focused Rage -> Mortal Strike (Slam if Tactician didn’t proc)

Standard Rotation/Priority list:
Above 20%:
Use Colossus Smash and Mortal Strike on cooldown (Don't overwrite Shattered Defenses).
If you get a Colossus Smash proc, do Colossus Smash Focused Rage -> Mortal Strike.
Use slam when above 32 rage and both Colossus Smash and Mortal Strike are on cd.
Use Focused Rage to not avoid ragecapping (about 25 rage from cap).

Below 20%:
Use Colossus Smash on CD (Don't overwrite Shattered Defenses) -> 22 (18 with Dauntless and 3/3 PS) rage
Execute with the Shattered Defenses -> spam Execute when you don’t have Shattered Defenses.
Use Focused Rage if you're about to rage cap (about 25 rage from cap), save Focused Rage stacks for Battle Cry.

Battle Cry Rotation:
Above 20%:
Colossus Smash -> Battle Cry
Focused Rage
Mortal Strike -> Focused Rage
Colossus Smash (Slam if no Colossus Smash) -> Focused Rage
Colossus Smash (Slam if no Colossus Smash, or Shattered Defenses proc) -> Mortal Strike (Colossus Smash if Mortal Strike isn't up and no Shattered Defenses buff, Slam if neither Colossus Smash/Mortal Strike is up)
Below 20%:
Colossus Smash -> Battle Cry
Execute
Focused Rage -> Execute
Focused Rage -> Execute
Focused Rage -> x3 Focused Rage
Mortal Strike (Only use Colossus Smash if the debuff isn’t on the target. 2 Executes are more damage than 1 Colossus Smash + 1 Shattered Defenses Execute)
--]]
