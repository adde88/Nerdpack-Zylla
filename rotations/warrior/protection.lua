local _, Zylla = ...

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																	align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',							align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Heroic Leap|r',				align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																		key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',															align = 'center'},
	{type = 'checkbox', text = 'Intercept enabled', 																		key = 'kIntercept', 	default = false},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 														key = 'LJ',						spin = 4,	step = 1,	max = 20,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																				key = 'trinket1',			default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																				key = 'trinket2', 		default = true,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spinner', 	text = 'Ravager - Units', 																			key = 'ravager', 			default = 2, max =20, step = 1, desc = Zylla.ClassColor..'How many units to strike with Ravager!|r'},
	unpack(Zylla.Mythic_GUI)
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
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Etc = {
	{'Victory Rush', 'inMelee&inFront&player.buff(Victorious)&player.health<=70', 'target'},
	{'Impending Victory', 'inMelee&inFront&{{!player.buff(Victorious)&player.rage>10&player.health<95}||{player.buff(Victorious)&player.health<80}}', 'target'},
	{'Heroic Throw', 'range>10&range<40&inFront', 'target'},
	{'Shockwave', '!immune(stun)&player.area(6).enemies.inFront>2&inMelee&inFront', 'target'},
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
	{'!Spell Reflection', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Shockwave).cooldown>gcd&player.spell(Pummel).cooldown>gcd&range<41', 'enemies.ground'},
}

local Cooldowns = {
	{'Demoralizing Shout', 'talent(6,3)&player.buff(Battle Cry)'},
	{'Shield Wall', 'player.incdmg(2.5)>player.health.max*0.50', 'player'},
	{'Last Stand', 'player.incdmg(2.5)>player.health.max*0.50', 'player'},
	{'Battle Cry', '{talent(6,1)&talent(3,2)&spell(Shield Slam).cooldown<5.5-gcd}||!talent(6,1)', 'player'},
	{'Ravager', 'talent(7,3)&player.buff(Battle Cry)', 'target.ground'},
	{'#144249', 'equipped(144249)&{player.area(8).enemies>4||player.incdmg(2.5)>player.health.max*0.20}'}, -- Archimonde's Hatred Reborn (Trinket)
	{'Avatar', 'target.inMelee'},
	{'Ravager', 'combat&alive&range<41&area(8).enemies>=UI(ravager)', 'enemies'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local AoE = {
	{'Neltharion\'s Fury', '{player.buff(Battle Cry)&player.movingfor<0.75&player.area(8).enemies>2}||player.incdmg(2.5)>player.health.max*0.20', 'target'},
	{'Shield Slam', 'player.spell(Shield Block).cooldown<gcd*2&!player.buff(Shield Block)&talent(7,2)', 'target'},
	{'Revenge', nil, 'target'},
	{'Thunder Clap'},
	{'Devastate', '!talent(5,1)', 'target'}
}

local ST = {
	{'Shield Block', '!player.buff(Neltharion\'s Fury)&{{spell(Shield Slam).cooldown<6&!player.buff(Shield Block)}||{spell(Shield Slam).cooldown<6+player.buff(Shield Block).duration&player.buff(Shield Block)}}'},
	{'!Ignore Pain','{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>30}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>10}||{player.rage>50&!talent(6,1)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ultimatum)}||{player.buff(Vengeance: Ignore Pain)&player.rage>20}||{talent(6,1)&!player.buff(Ultimatum)&!player.buff(Vengeance: Ignore Pain)&!player.buff(Vengeance: Focused Rage)&player.rage<30}', 'target'},
	{'Neltharion\'s Fury', 'player.incdmg(2.5)>player.health.max*0.20&!player.buff(Shield Block)&player.movingfor<0.75', 'target'},
	{'Shield Slam', '{player.spell(Shield Block).cooldown<gcd&!player.buff(Shield Block)&talent(7,2)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<gcd*2&player.rage<13}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<gcd*2&player.rage<20}', 'target'},
	{'Shield Slam', '!talent(7,2)', 'target'},
	{'Revenge', 'player.spell(Shield Slam).cooldown<gcd*2||player.rage<6', 'target'},
	{'Devastate', '!talent(5,1)', 'target'}
}

local inCombat = {
	{Etc},
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'interruptAt(70)&toggle(interrupts)'},
	{Cooldowns, 'toggle(cooldowns)'},
	{ST, 'inMelee&inFront&player.area(8).enemies<2'},
	{AoE, 'toggle(aoe)&inMelee&inFront&player.area(8).enemies>=2'},
	{'Taunt', 'toggle(super_taunt)&combat&alive&threat<100', 'enemies'},
	{Mythic_Plus, 'inMelee'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)'},
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
