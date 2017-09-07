local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
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
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarrior |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/2 - 5/3 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
  key = 'super_taunt',
  name = 'Taunt Lowest Threat',
  text = 'Taunt a nearby enemy in combat, when threat gets low, without targeting it.',
  icon = 'Interface\\Icons\\spell_nature_reincarnation',
 })

end

local PreCombat = {}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Etc = {
	{'Impending Victory', 'inMelee&{{!player.buff(Victorious)&player.rage>10&player.health<95}||{player.buff(Victorious)&player.health<80}}', 'target'},
	{'Heroic Throw', 'range>10&range<40&inFront', 'target'},
	{'Shockwave', '!target.immune(stun)&player.area(6).enemies>2&target.inMelee&target.inFront'},
	{'Intercept', 'range>10&range<25&enemy&alive&combat&!player.lastgcd(Heroic Leap)&UI(kIntercept)', 'target'},
	{'Heroic Throw', 'range>10&range<41&inFront&alive&enemy&!UI(kIntercept', 'target'}
}

local Interrupts = {
	{'!Pummel', 'inFront&inMelee', 'target'},
	{'!Arcane Torrent', 'inMelee&player.spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)', 'target'},
	{'!Shockwave', 'talent(1,1)&!target.immune(stun)&spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)&target.inFront&target.inMelee'},
	{'!Spell Reflection', 'target.inMelee&player.spell(Shockwave).cooldown>gcd&player.spell(Pummel).cooldown>gcd'}
}

local Interrupts_Random = {
	{'!Pummel', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&inMelee', 'enemies'},
	{'!Shockwave', 'interruptAt(70)&&!target.immune(stun)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)&inFront&inMelee', 'enemies'},
	{'!Spell Reflection', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Shockwave).cooldown>gcd&player.spell(Pummel).cooldown>gcd&range<51', 'enemies.ground'},
}

local Cooldowns = {
	{'Demoralizing Shout', 'talent(6,3)&player.buff(Battle Cry)'},
	{'Shield Wall', 'player.incdmg(2.5)>player.health.max*0.50'},
	{'Last Stand', 'player.incdmg(2.5)>player.health.max*0.50&!player.spell(Shield Wall).cooldown'},
	{'Battle Cry', '{talent(6,1)&talent(3,2)&player.spell(Shield Slam).cooldown<5.5-gcd}||!talent(6,1)'},
	{'Ravager', 'talent(7,3)&player.buff(Battle Cry)', 'target.ground'},
	{'#144249', 'equipped(144249)&{player.area(8).enemies>4||player.incdmg(2.5)>player.health.max*0.20}'}, -- Archimonde's Hatred Reborn (Trinket)
}

local AoE = {
	{'Neltharion\'s Fury', '{player.buff(Battle Cry)&!player.moving&player.area(8).enemies>2}||player.incdmg(2.5)>player.health.max*0.20'},
	{'Shield Slam', 'player.spell(Shield Block).cooldown<gcd*2&!player.buff(Shield Block)&talent(7,2)', 'target'},
	{'Revenge', nil, 'target'},
	{'Thunder Clap', 'player.area(6).enemies>2'},
	{'Devastate', '!talent(5,1)', 'target'}
}

local ST = {
	{'Shield Block', '!player.buff(Neltharion\'s Fury)&{{spell(Shield Slam).cooldown<6&!player.buff(Shield Block)}||{spell(Shield Slam).cooldown<6+player.buff(Shield Block).duration&player.buff(Shield Block)}}'},
	{'!Ignore Pain','{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>30}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>10}||{player.rage>50&!talent(6,1)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ultimatum)}||{player.buff(Vengeance: Ignore Pain)&player.rage>20}||{talent(6,1)&!player.buff(Ultimatum)&!player.buff(Vengeance: Ignore Pain)&!player.buff(Vengeance: Focused Rage)&player.rage<30}', 'target'},
	{'Neltharion\'s Fury', 'player.incdmg(2.5)>player.health.max*0.20&!player.buff(Shield Block)&!player.moving'},
	{'Shield Slam', '{player.spell(Shield Block).cooldown<gcd&!player.buff(Shield Block)&talent(7,2)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<gcd*2&player.rage<13}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<gcd*2&player.rage<20}', 'target'},
	{'Shield Slam', '!talent(7,2)', 'target'},
	{'Revenge', 'player.spell(Shield Slam).cooldown<gcd*2||player.rage<6', 'target'},
	{'Devastate', '!talent(5,1)', 'target'}
}

local inCombat = {
	{Etc},
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(interrupts)'},
	{Cooldowns, 'toggle(cooldowns)'},
	{ST, 'target.inMelee&target.inFront&player.area(8).enemies<2'},
	{AoE, 'toggle(aoe)&target.inMelee&target.inFront&player.area(8).enemies>1'},
	{'Taunt', 'toggle(super_taunt)&combat&alive&threat<100', 'enemies'},
	{Fel_Explosives, 'range<=5'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
}

NeP.CR:Add(73, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Protection',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
