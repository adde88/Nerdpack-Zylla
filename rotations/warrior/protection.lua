local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

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
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																align = 'center'},
	{type = 'combo',		default = 'normal',																							key = 'target', 			list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',															align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 									key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',				key = 'prepot', 			default = false},
	{type = 'combo',		default = '3',																									key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 														key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																				key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																				key = 'trinket2', 		default = false,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spinner', 	text = 'Ravager - Units', 																			key = 'ravager', 			default = 2, max =20, step = 1, desc = Zylla.ClassColor..'How many units to strike with Ravager!|r'},
	{type = 'checkspin',text = 'Emergency Health', 																			key = 'emg_hp',				spin = 20,	step = 5, shiftStep = 10,	max = 100, min = 1,	check = true,	desc = Zylla.ClassColor..'Will use Shield Wall and Last Stand to Survive.|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 								key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
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

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127850', 'ingroup&item(127850).usable&item(127850).count>0&UI(prepot)&!buff(Flask of Ten Thousand Scars)'},													--XXX: Flask of Ten Thousand Scars
	{'#127849', 'item(127850).count==0&ingroup&item(127849).usable&item(127849).count>0&UI(prepot)&!buff(Flask of the Countless Armies)'},	--XXX: Flask of the Countless Armies (IF WE DON'T HAVE THOUSAND SCARS FLASKS)
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},																	--XXX: Lightforged Augment Rune
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Heroic Leap', 'keybind(lcontrol)&UI(lcontrol)' , 'cursor.ground'}
}

local Etc = {
	{'Victory Rush', 'inMelee&inFront&player.buff(Victorious)&player.health<=70'},
	{'Impending Victory', 'inMelee&inFront&{{!player.buff(Victorious)&player.rage>10&player.health<95}||{player.buff(Victorious)&player.health<80}}'},
	{'Heroic Throw', 'range>10&range<40&inFront'},
	{'Shockwave', '!immune(stun)&player.area(6).enemies.inFront>2&inMelee&inFront'},
	{'Intercept', 'range>10&range<25&enemy&alive&combat&!player.lastgcd(Heroic Leap)&UI(kIntercept)'},
	{'Heroic Throw', 'range>10&range<41&inFront&alive&enemy&!UI(kIntercept'}
}

local Interrupts = {
	{'&Pummel', 'inFront&inMelee'},
	{'!Arcane Torrent', 'inMelee&spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)'},
	{'!Shockwave', 'spell(Pummel).cooldown>gcd&!player.lastgcd(Pummel)&inFront&inMelee'},
	{'!Spell Reflection', 'spell(Shockwave).cooldown>gcd&spell(Pummel).cooldown>gcd'}
}

local Cooldowns = {
	{'Demoralizing Shout', 'talent(6,3)&buff(Battle Cry)', 'player'},
	{'Shield Wall', '{incdmg(2.5)>health.max*0.50&health<50}||{UI(emg_hp_check)&health<=UI(emg_hp_spin)}', 'player'},
	{'Last Stand', '{incdmg(2.5)>health.max*0.50&health<50}||{UI(emg_hp_check)&health<=UI(emg_hp_spin)}', 'player'},
	{'Battle Cry', '{talent(6,1)&talent(3,2)&spell(Shield Slam).cooldown<5.5-gcd}||!talent(6,1)', 'player'},
	{'&#144249', 'equipped(144249)&{area(8).enemies>4||incdmg(2.5)>health.max*0.20}', 'player'}, --XXX: Archimonde's Hatred Reborn (Trinket)
	{'Avatar', 'inMelee'},
	{'Ravager', 'combat&alive&range<41&area(8).enemies>=UI(ravager)', 'enemies.ground'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local AoE = {
	{'Neltharion\'s Fury', '{player.buff(Battle Cry)&player.movingfor<0.75&player.area(8).enemies>2}||player.incdmg(2.5)>player.health.max*0.20'},
	{'Shield Slam', 'spell(Shield Block).cooldown<gcd*2&!player.buff(Shield Block)&talent(7,2)'},
	{'Revenge'},
	{'Thunder Clap'},
	{'Devastate', '!talent(5,1)'}
}

local ST = {
	{'Shield Block', '!player.buff(Neltharion\'s Fury)&{{spell(Shield Slam).cooldown<6&!player.buff(Shield Block)}||{spell(Shield Slam).cooldown<6+player.buff(Shield Block).duration&player.buff(Shield Block)}}'},
	{'!Ignore Pain','{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>30}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<=gcd*2&player.rage>10}||{player.rage>50&!talent(6,1)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ultimatum)}||{player.buff(Vengeance: Ignore Pain)&player.rage>20}||{talent(6,1)&!player.buff(Ultimatum)&!player.buff(Vengeance: Ignore Pain)&!player.buff(Vengeance: Focused Rage)&player.rage<30}'},
	{'Neltharion\'s Fury', 'player.incdmg(2.5)>player.health.max*0.20&!player.buff(Shield Block)&player.movingfor<0.75'},
	{'Shield Slam', '{spell(Shield Block).cooldown<gcd&!player.buff(Shield Block)&talent(7,2)}||{player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<gcd*2&player.rage<13}||{!player.buff(Vengeance: Ignore Pain)&player.buff(Ignore Pain).duration<gcd*2&player.rage<20}'},
	{'Shield Slam', '!talent(7,2)'},
	{'Revenge', 'spell(Shield Slam).cooldown<gcd*2||player.rage<6'},
	{'Devastate', '!talent(5,1)'}
}

local xCombat = {
	{Cooldowns, 'toggle(cooldowns)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)&toggle(xIntRandom)', 'enemies'},
	{ST, 'player.area(8).enemies<2'},
	{AoE, 'toggle(aoe)&player.area(8).enemies>=2'},
}

local inCombat = {
	{Etc},
	{Keybinds},
	{'Taunt', 'toggle(super_taunt)&combat&alive&threat<100', 'enemies'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
}

NeP.CR:Add(73, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Protection',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
