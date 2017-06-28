local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--KEYBINDS
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Heroic Leap', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', align = 'center'},
	{type = 'checkbox', text = 'Pause enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Intercept enabled', key = 'kIntercept', default = false},
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

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWarrior |cffADFF2FProtection |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/2 - 5/3 - 6/1 - 7/2")
	print("|cffADFF2F ----------------------------------------------------------------------|r")

end

local Etc = {
	{'Impending Victory', '{!player.buff(Victorious)&player.rage>10&player.health<=85}||{player.buff(Victorious)&player.health<=70}'},
	{'Heroic Throw', '!target.inMelee&target.range<=30&target.inFront'},
	{'Shockwave', '!target.immune(stun)&player.area(6).enemies>=3&target.inMelee&target.inFront'},
	{'Intercept', '!target.inMelee&target.range<25&target.enemy&!prev_gcd(Heroic Leap)&UI(kIntercept)&target.alive'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel', 'target.inFront&target.inMelee'},
	{'!Arcane Torrent', 'target.inMelee&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
	{'!Shockwave', 'talent(1,1)&!target.immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&target.inFront&target.inMelee'},
	{'!Spell Reflection', '{target.inMelee&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)}||{target.range>=10&!spell(Pummel).cooldown}'}
}

local Cooldowns = {}

local PreCombat = {
	{'Intercept', '!target.inMelee&target.range<25&target.enemy&!prev_gcd(Heroic Leap)&UI(kIntercept)&target.alive'},
	{'Heroic Throw', '!target.inMelee&target.range<=30&target.inFront&target.alive&target.enemy&!UI(kIntercept'}
}

local Something = {
	{'Focused Rage', 'talent(3,2)&player.buff(Ultimatum)&!talent(6,1)'},
	{'Battle Cry', '{talent(6,1)&talent(3,2)&spell(Shield Slam).cooldown<=4.5-gcd}||!talent(6,1)'},
	{'Demoralizing Shout', 'talent(6,3)&player.buff(Battle Cry)'},
	{'Ravager', 'talent(7,3)&player.buff(Battle Cry)'}
}

local AoE = {
	{Something},
	{'Neltharion\'s Fury', 'player.buff(Battle Cry)&xmoving=0&player.area(8).enemies>=3'},
	{'Shield Slam', '!{spell(Shield Block).cooldown<=gcd*2&!player.buff(Shield Block)&talent(7,2)}'},
	{'Revenge'},
	{'Thunder Clap', 'player.area(6).enemies>=3'},
	{'Devastate'}
}

local ST = {
	{'Shield Block', '!player.buff(Neltharion\'s Fury)&{{spell(Shield Slam).cooldown<6&!player.buff(Shield Block)}||{spell(Shield Slam).cooldown<6+player.buff(Shield Block).duration&player.buff(Shield Block)}}'},
	{'!Ignore Pain','{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>=13}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>=20}||{player.rage>=60&!talent(6,1)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ultimatum)}||{player.buff(Vengeance: Ignore Pain)&player.rage>=30}||{talent(6,1)&!player.buff(Ultimatum)&!player.buff(Vengeance: Ignore Pain)&!player.buff(Vengeance: Focused Rage)&player.rage<30}'},
	{'Focused Rage', '{player.buff(Vengeance: Focused Rage)&!player.buff(Vengeance: Ignore Pain)}||{player.buff(Ultimatum)&player.buff(Vengeance: Focused Rage)&!player.buff(Vengeance: Ignore Pain)}||{talent(6,1)&player.buff(Ultimatum)&!player.buff(Vengeance: Ignore Pain)&!player.buff(Vengeance: Focused Rage)}||{talent(6,1)&!player.buff(Vengeance: Ignore Pain)&!player.buff(Vengeance: Focused Rage)&player.rage>=30}||{player.buff(Ultimatum)&player.buff(Vengeance: Ignore Pain)&spell(Shield Slam)&player.rage<10}||{player.rage>=100}'},
	{'Demoralizing Shout', 'player.incdmg(2.5)>player.health.max*0.20'},
	{'Shield Wall', 'player.incdmg(2.5)>player.health.max*0.50'},
	{'Last Stand', 'player.incdmg(2.5)>player.health.max*0.50&!spell(Shield Wall).cooldown'},
	{AoE, 'toggle(aoe)&player.area(8).enemies>=2'},
	{Something},
	{'Neltharion\'s Fury', 'player.incdmg(2.5)>player.health.max*0.20&!player.buff(Shield Block)'},
	{'Shield Slam', '!{spell(Shield Block).cooldown<=gcd&!player.buff(Shield Block)&talent(7,2)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage<13}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage<20}||'},
	{'Shield Slam', '!talent(7,2)'},
	{'Revenge', 'spell(Shield Slam).cooldown<=gcd*2||player.rage<=5'},
	{'Devastate'}
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Etc},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{ST, 'target.inMelee&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
}

NeP.CR:Add(73, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Protection',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
