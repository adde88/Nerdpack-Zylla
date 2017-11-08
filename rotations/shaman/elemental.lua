local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																			align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',									align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Liquid Magma Totem|r',			align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Lightning Surge Totem|r',		align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'Earthbind Totem|r',				align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 																				key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																		align = 'center'},
	{type = 'combo',		default = 'normal',																									key = 'target', 			list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																	align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 											key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																		key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',						key = 'prepot', 			default = false},
	{type = 'combo',		default = '3',																											key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																						key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																						key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', text = 'Kil\'Jaeden\'s Burning Wish - Units', 											key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival', 																			align = 'center'},
	{type = 'checkspin',text = 'Astral Shift',																							key = 'AS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 40, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Surge',																							key = 'HSP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 35, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Earth Elemental',																						key = 'eele',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 25, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Gift of the Naaru',																					key = 'gotn',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healthstone',																								key = 'HS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																						key = 'AHP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	-- GUI Emergency Group Healing
	{type = 'header', 	text = 'Emergency Group Healing', 																	align = 'center'},
	{type = 'checkspin',text = 'Healing Surge',																							key = 'hs_p',					spin = 35, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cff0070de --- |rShaman: |cff0070deElemental|r')
	print('|cff0070de --- |rLightning Rod: 1/3 - 2/1 - 3/1 - 4/2 - 5/3||5/2 (Tyrannical) - 6/1 - 7/2|r')
	print('|cff0070de --- |rIcefury: 1/3 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3||6/1 (Mythic+ AoE) - 7/3|r')
	print('|cff0070de --- |rAscendance: 1/1 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3||6/1 (Mythic+ AoE)- 7/1|r')
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
		key = 'dispels',
		name = 'Cleanse Spirit',
		text = 'Enable/Disable: Automatic removal of curses',
		icon = 'Interface\\ICONS\\ability_shaman_cleansespirit',
	})

end

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127847', 'ingroup&item(127847).usable&item(127847).count>0&UI(prepot)&!buff(Flask of the Whispered Pact)'},	--XXX: Flask of the Whispered Pact
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},					--XXX: Lightforged Augment Rune
}

local Survival = {
	{'&Astral Shift', 'UI(AS_check)&health<=UI(AS_spin)'},
	{'Earth Elemental', '!ingroup&UI(eele_check)&health<=UI(eele_spin)'},
	{'&Gift of the Naaru', 'UI(gotn_check)&health<=UI(gotn_spin)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Player = {
	{'!Healing Surge', 'UI(S_HSGE)&health<=UI(S_HSG)'},
}

local Emergency = {
	{'!Healing Surge', 'UI(hs_p_check)&health<=UI(hs_p_spin)'},
}

local Keybinds = {
	{'!Liquid Magma Totem', 'UI(lshift)&talent(6,1)&keybind(lshift)', 'cursor.ground'},
	{'!Lightning Surge Totem', 'UI(lcontrol)&keybind(lcontrol)', 'cursor.ground'},
	{'!Earthbind Totem', 'UI(lalt)&keybind(ralt)', 'cursor.ground'},
}

local Interrupts = {
	{'&Wind Shear'},
	{'!Lightning Surge Totem', 'advanced&interruptAt(5)&spell(Wind Shear).cooldown>=gcd&!player.lastgcd(Wind Shear)', 'target.ground'},
	{'!Lightning Surge Totem', 'toggle(xIntRandom)&advanced&interruptAt(5)&spell(Wind Shear).cooldown>=gcd&!player.lastgcd(Wind Shear)', 'enemies.ground'},
}

local Dispel = {
	{'%dispelself'},
}

local AoE = {
	{'Totem Mastery', 'talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Stormkeeper'},
	{'Liquid Magma Totem', 'talent(6,1)&advanced', 'target.ground'},
	--XXX: Flame Shock according to AoE Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Flame Shock', '!talent(7,2)&player.maelstrom>10&debuff(Flame Shock).duration<gcd'},
	{'Flame Shock', 'talent(7,2)&area(10).enemies<4&!debuff(Flame Shock)'},
	{'Earthquake', 'player.maelstrom>40&advanced', 'target.ground'},
	{'Lava Burst', 'player.buff(Lava Surge)||!moving&!talent(7,2)&debuff(Flame Shock).duration>spell(Lava Burst).casttime'},
	--XXX: Elemental Blast according to Fortified affix Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Elemental Blast', 'talent(5,3)'},
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)'},
	--XXX: Chain Lightning according to AoE Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Chain Lightning', 'talent(7,2)&{!debuff(Lightning Rod)||player.buff(Stormkeeper)}'},
	{'Chain Lightning', nil, 'target'},
}

--XXX: Lightning Rod Rotation
local LRCooldowns = {
	{'Totem Mastery', 'talent(1,3)&{totem(Totem Mastery).duration<1||!buff(Tailwind Totem)||!buff(Storm Totem)||!buff(Resonance Totem)||!buff(Ember Totem)}'},
	{'Stormkeeper'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
}

local LRSingle = {
	{'Totem Mastery', 'talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Flame Shock', '!debuff(Flame Shock)||debuff(Flame Shock).duration<=gcd'},
	{'Earthquake', 'player.buff(Echoes of the Great Sundering)&player.maelstrom>76&advanced', 'target.ground'},
	{'Earth Shock', 'player.maelstrom>82'},
	{'Stormkeeper'},
	{'Elemental Blast', 'talent(5,3)'},
	--XXX: Lava Burst according to Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Lava Burst', 'player.buff(Lava Surge)||debuff(Flame Shock).duration>spell(Lava Burst).casttime&spell(Lava Burst).cooldown==0&{!player.buff(Stormkeeper)||player.buff(Stormkeeper).duration>spell(Lava Burst).casttime+{1.5*{spell_haste}*player.buff(Stormkeeper).count+1}}'},
	{'Flame Shock', 'player.maelstrom>10&player.buff(Elemental Focus)&debuff(Flame Shock).duration<9'},
	--XXX: Earth Shock according to Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Earth Shock', 'player.maelstrom>76&!player.buff(Lava Surge)'},
	{'Earthquake', 'player.buff(Echoes of the Great Sundering)&advanced', 'target.ground'},
	--XXX: Lightning Bolt according to Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&{!debuff(Lightning Rod)||player.buff(Stormkeeper)&!toggle(aoe)}'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	{'Lightning Bolt', '!debuff(Lightning Rod)'},
	{'Lightning Bolt', nil, 'target'},
}

--XXX: Icefury Rotation
local IFCooldowns = {
	{'Totem Mastery', 'talent(1,3)&{totem(Totem Mastery).duration<1||!buff(Tailwind Totem)||!buff(Storm Totem)||!buff(Resonance Totem)||!buff(Ember Totem)}'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
}

local IFSingle = {
	{'Totem Mastery', 'talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Flame Shock', '!debuff(Flame Shock)||debuff(Flame Shock).duration<=gcd'},
	{'Earthquake', 'player.buff(Echoes of the Great Sundering)&player.maelstrom>76&advanced', 'target.ground'},
	{'Frost Shock', 'player.buff(Icefury)&player.maelstrom>76'},
	{'Earth Shock', 'player.maelstrom>82'},
	{'Stormkeeper', '!player.buff(Icefury)'},
	{'Elemental Blast', 'talent(5,3)'},
	{'Icefury', 'player.maelstrom<86&!player.buff(Stormkeeper)'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&player.buff(Stormkeeper)'},
	--XXX: Lava Burst according to Icefury Rotaion from Storm, Earth and Lava***
	{'Lava Burst', 'player.buff(Lava Surge)||debuff(Flame Shock).duration>spell(Lava Burst).casttime&{spell(Lava Burst).cooldown==0||player.maelstrom<98&spell(Lava Burst).charges<3}'},
	--XXX: Frost Shock according to Icefury Rotaion from Storm, Earth and Lava***
	{'Frost Shock', 'player.buff(Icefury)&{lastcast(Icefury)||player.maelstrom>10||player.buff(Icefury).duration<{1.5*{spell_haste}*player.buff(Icefury).count+1}}'},
	{'Flame Shock', 'player.maelstrom>10&player.buff(Elemental Focus)&debuff(Flame Shock).duration<9'},
	{'Frost Shock', 'player.buff(Icefury)'},
	{'Earth Shock', 'player.maelstrom>76'},
	{'Earthquake', 'player.buff(Echoes of the Great Sundering)&advanced', 'target.ground'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	{'Lightning Bolt', nil, 'target'},
}

--XXX: Ascendance Rotation
local ASCooldowns = {
	{'Ascendance', 'debuff(Flame Shock).duration>buff(Ascendance).duration&{combat(player).time>50||hashero}&spell(Lava Burst).cooldown>0&!buff(Stormkeeper)'},
	{'Ascendance', 'spell(Lava Burst).cooldown>0&!buff(Stormkeeper)'},
	{'Stormkeeper', '!buff(Ascendance)'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
	{'Elemental Mastery', 'talent(4,3)&buff(Ascendance)'},
}

local ASSingle = {
	{'Flame Shock', '!debuff(Flame Shock)||debuff(Flame Shock).duration<=gcd'},
	{'Flame Shock', 'player.maelstrom>10&debuff(Flame Shock).duration<=player.buff(Ascendance).duration&spell(Ascendance).cooldown+player.buff(Ascendance).duration<=debuff(Flame Shock).duration'},
	{'Earthquake', 'player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&player.maelstrom>76&advanced', 'target.ground'},
	{'Earth Shock', 'player.maelstrom>82&!player.buff(Ascendance)'},
	{'Stormkeeper', '!player.buff(Ascendance)'},
	{'Elemental Blast', 'talent(5,3)'},
	--XXX: Lightning Bolt according to Ascendance Rotaion from Storm, Earth and Lava***
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&{player.buff(Stormkeeper)||spell(Lava Burst).charges<3}'},
	--XXX: Lava Burst according to Ascendance Rotaion from Storm, Earth and Lava***
	{'Lava Burst', 'player.buff(Lava Surge)||debuff(Flame Shock).duration>spell(Lava Burst).casttime&{spell(Lava Burst).cooldown==0||player.buff(Ascendance)||!player.buff(Ascendance)&player.buff(Stormkeeper).duration>spell(Lava Burst).casttime+{1.5*{spell_haste}*player.buff(Stormkeeper).count+1}}'},
	{'Flame Shock', 'player.maelstrom>10&player.buff(Elemental Focus)&debuff(Flame Shock).duration<9'},
	--XXX: Earth Shock according to Ascendance Rotaion from Storm, Earth and Lava***
	{'Earth Shock', 'player.maelstrom>76&{!player.buff(Lava Surge)||!player.buff(Ascendance)}'},
	{'Earthquake', 'player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&advanced', 'target.ground'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	{'Lightning Bolt'},
}

local Cooldowns = {
	{ASCooldowns, 'talent(7,1)||player.level~=110'},
	{LRCooldowns, 'talent(7,2)'},
	{IFCooldowns, 'talent(7,3)'},
}

local xCombat ={
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)&inFront&range<40'},
	{Interrupts, 'toggle(xIntRandom)&toggle(Interrupts)&@Zylla.InterruptAt(intat)&inFront&range<40', 'enemies'},
	{Cooldowns, 'toggle(Cooldowns)', 'player'},
	{AoE, 'toggle(aoe)&player.area(40).enemies>=3'},
	{ASSingle, 'talent(7,1)||player.level~=110'},
	{LRSingle, 'talent(7,2)'},
	{IFSingle, 'talent(7,3)'},
}

local inCombat = {
	{Keybinds},
	{Dispel, 'toggle(dispels)&spell(Cleanse Spirit).cooldown<gcd'},
	{Survival, nil, 'player'},
	{Player, '!player.moving', 'player'},
	{Emergency, '!player.moving', 'lowest'},
	{xCombat, nil, (function() return NeP.DSL:Get("UI")(nil, 'target') end)},
	{Mythic_Plus, 'range<=40'},
}

local outCombat = {
	{PreCombat, nil, 'player'},
	{Dispel, 'toggle(dispels)&spell(Cleanse Spirit).cooldown<gcd'},
	{Emergency, '!moving&ingroup', 'lowest'},
	{'Healing Surge', '!moving&player.health<80', 'player'},
	{'Ghost Wolf', 'movingfor>0.75&!buff', 'player'},
}

NeP.CR:Add(262, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Elemental',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
