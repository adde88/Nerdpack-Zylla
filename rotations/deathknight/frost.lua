local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'normal',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',	key = 'prepot', 			default = false},
	{type = 'combo',		default = '3',																						key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Kil\'Jaeden\'s Burning Wish - Units', 						key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',															align = 'center',			size = 16},
	{type = 'checkspin',text = 'Death Strike',																		key = 'ds', 					align = 'left', width = 55,  spin = 80, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healthstone',																			key = 'HS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																	key = 'AHP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},

	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDEATH KNIGHT |cffADFF2FFrost  |r')
	print('|cffADFF2F --- |r')
	print('|cffADFF2F --- |rRecommended Talents:  1/2 - 2/2 - 3/3 - 4/X - 5/X - 6/1 - 7/3')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xMACHINEGUN',
		name = 'MACHINEGUN',
		text = 'ON/OFF using MACHINEGUN rotation',
		icon = 'Interface\\Icons\\Inv_misc_2h_farmscythe_a_01',
	})

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
	{'%pause', 'buff(Shadowmeld)'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127849', 'item(127849).usable&item(127849).count>0&UI(prepot)&!buff(Flask of the Countless Armies)'},	--XXX: Flask of the Countless Armies
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},						--XXX: Lightforged Augment Rune
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Interrupts = {
	{'&Mind Freeze'},
	{'!Arcane Torrent', 'inMelee&spell(Mind Freeze).cooldown>gcd&!player.lastgcd(Mind Freeze)'},
}

local Survival = {
	{'Death Strike', 'UI(ds_check)&health<UI(ds_spin)&buff(Dark Succor)', 'target'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local BoS_check = {
	{'Horn of Winter', 'talent(2,2)&talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
	{'Horn of Winter', 'talent(2,2)&!talent(7,2)'},
	{'Frost Strike', 'talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
	{'Frost Strike', '!talent(7,2)'},
	{'Empower Rune Weapon', 'talent(7,2)&cooldown(Breath of Sindragosa).remains>15&runes<1'},
	{'Empower Rune Weapon', '!talent(7,2)&runes<1'},
	{'Hungering Rune Weapon', 'talent(3,2)&talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
	{'Hungering Rune Weapon', 'talent(3,2)&!talent(7,2)'},
}

local Cooldowns = {
	{'Blood Fury', '!talent(7,2)||dot(Breath of Sindragosa).ticking'},
	{'Berserking', 'player.buff(Pillar of Frost)'},
	{'Pillar of Frost'},
	{'Sindragosa\'s Fury', 'player.buff(Pillar of Frost)&debuff(Razorice).count>4'},
	{'Obliteration'},
	{'Breath of Sindragosa', 'talent(7,2)&runic_power>40'},
	{BoS_check},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)}
}

local Core = {
	{'Frostscythe', 'talent(6,1)&!talent(7,2)&{player.buff(Killing Machine)||player.area(8).enemies>3}'},
	{'Glacial Advance', 'talent(7,3)'},
	{'Frost Strike', 'player.buff(Obliteration)&!player.buff(Killing Machine)'},
	{'Obliterate', 'player.buff(Killing Machine)'},
	{'Obliterate'},
	{'Remorseless Winter'},
	{'Frostscythe', 'talent(6,1)&talent(2,2)'},
	{'Howling Blast', 'talent(2,2)'},
}

local IcyTalons = {
	{'Frost Strike', 'player.buff(Icy Talons).remains<1.5'},
	{'Howling Blast', '!dot(Frost Fever).ticking'},
	{'Howling Blast', 'player.buff(Rime)'},
	{'Frost Strike', 'runic_power>70||player.buff(Icy Talons).stack<3'},
	{Core},
	{BoS_check},
}

local BoS = {
	{'Howling Blast', '!dot(Frost Fever).ticking'},
	{Core},
	{'Horn of Winter', 'talent(2,3)'},
	{'Empower Rune Weapon', 'runic_power<80'},
	{'Hungering Rune Weapon', 'talent(3,2)'},
	{'Howling Blast', 'player.buff(Rime)'},
}

local Generic = {
	{'Howling Blast', '!dot(Frost Fever).ticking'},
	{'Howling Blast', 'player.buff(Rime)'},
	{'Frost Strike', 'runic_power>70'},
	{Core},
	{BoS_check},
}

local Shatter = {
	{'Frost Strike'},
	{'Howling Blast'},
	{'Howling Blast'},
	{'Frost Strike'},
	{Core},
	{BoS_check},
}

local MACHINEGUN = {
	{'Frost Strike', 'player.buff(Icy Talons).remains<1.5'},
	{'Howling Blast', '!dot(Frost Fever).ticking'},
	{'Howling Blast', 'player.buff(Rime)'},
	{'Frost Strike', 'runic_power>70||player.buff(Icy Talons).stack<3'},
	{'Frostscythe', 'talent(6,1)&!talent(7,2)&{player.buff(Killing Machine)||player.area(8).enemies>3}'},
	{'Glacial Advance', 'talent(7,3)'},
	{'Frost Strike', 'player.buff(Obliteration)&!player.buff(Killing Machine)'},
	{'Remorseless Winter', '!cooldown(Remorseless Winter)'},
	{'Obliterate', '!talent(6,1)&player.buff(Killing Machine)'},
	{'Obliterate', 'talent(6,1)&!player.buff(Killing Machine)'},
	{'Frostscythe', 'talent(6,1)&talent(2,2)'},
}

local xCombat = {
	{Cooldowns, 'toggle(Cooldowns)'},
	{BoS, 'dot(Breath of Sindragosa).ticking'},
	{Shatter, 'talent(1,1)'},
	{IcyTalons, 'talent(1,2)'},
	{Generic, '!talent(1,1)&!talent(1,2)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&inFront&range<25', 'target'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)&inFront&range<25', 'enemies'},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{MACHINEGUN, 'toggle(xMACHINEGUN)&inMelee&inFront', 'target'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!}
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
}
NeP.CR:Add(251, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death Knight - Frost',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
