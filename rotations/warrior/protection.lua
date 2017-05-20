local _, Zylla = ...

local GUI = {
	--KEYBINDS
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Heroic Leap', align = 'center'},
	{type = 'checkbox', text = 'Pause enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},
	{type = 'checkbox', text = 'Intercept enabled', key = 'kIntercept', default = false},
	{type = 'checkbox', text = 'Use trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use trinket #2', key = 'kT2', default = true}
} 

local exeOnLoad = function()
	Zylla.ExeOnLoad()

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWARRIOR |cffADFF2FProtection |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/2 - 5/3 - 6/1 - 7/2")
	print("|cffADFF2F ----------------------------------------------------------------------|r")
	--[[
	NeP.Interface:AddToggle({
		key = 'AutoTaunt',
		name = 'Auto Taunt',
		text = 'Automatically taunt nearby enemies.',
		icon = 'Interface\\Icons\\spell_nature_shamanrage',
	})
	]]--
end

local _Zylla = {
	{"/targetenemy [noexists]", "!target.exists" },
    {"/targetenemy [dead][noharm]", "target.dead" },
	--{'@Zylla.Taunt(Taunt)', 'toggle(AutoTaunt)'},
	--{'%taunt(Taunt)', 'toggle(AutoTaunt)'},
	{'Impending Victory', '{!player.buff(Victorious)&player.rage>10&player.health<=85}||{player.buff(Victorious)&player.health<=70}'},
	{'Heroic Throw', 'target.range>8&target.range<=30&target.infront'},
	{'Shockwave', 'player.area(6).enemies>=3'},
	{'Intercept', 'target.range>8&target.range<25&target.enemy&!prev_gcd(Heroic Leap)&UI(kIntercept)&target.alive'},
}

local Util = {
	-- ETC.
	-- {'%pause' , 'player.debuff(200904)||player.debuff(Sapped Soul)'}, -- Vault of the Wardens, Sapped Soul
}

local Keybinds = {
	-- Pause
	-- {'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'Pummel', 'target.infront&target.range<=8'},
	{'Arcane Torrent', 'target.range<=8&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
	{'Shockwave', 'talent(1,1)&target.infront&!target.immune(stun)&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)&target.infront&target.range<=8'},
	{'Spell Reflection', '{target.range<=8&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)}||{target.range>=10&!spell(Pummel).cooldown}'}
}

local Trinkets = {
	{'#trinket1', 'UI(kT1)'},
	{'#trinket2', 'UI(kT2)'}
}

local Cooldowns = {
	--# Cooldowns goes here
}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	{'Intercept', 'target.range>8&target.range<25&target.enemy&!prev_gcd(Heroic Leap)&UI(kIntercept)&target.alive'},
	{'Heroic Throw', 'target.range>8&target.range<=30&target.infront&target.alive&target.enemy&!UI(kIntercept'}
}

local Something = {
	--# Same skills in same order in both parts of the rotation... placed them here :)
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
	{_Zylla, 'UI(kAutoTarget)'},
	{Util},
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Trinkets},
	{ST, 'target.range<8&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(73, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] WARRIOR - Protection',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
