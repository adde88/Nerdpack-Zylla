local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Astral Shift', key = 'S_ASE', default = true},
	{type = 'spinner', text = '', key = 'S_AS', default = 40},
	{type = 'checkbox', text = 'Enable Healing Surge', key = 'S_HSGE', default = true},
	{type = 'spinner', text = '', key = 'S_HSG', default = 35},
	{type = 'checkbox', text = 'Enable Earth Elemental', key = 'S_EEE', default = true},
	{type = 'spinner', text = '', key = 'S_EE', default = 20},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkspin',	text = 'Healthstone',												key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',										key = 'AHP',					spin = 45, check = true},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Emergency Group Healing
	{type = 'header', text = 'Emergency Group Healing', align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Group Healing', key = 'E_HSGE', default = false},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'E_HSG', default = 35},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'L-Shift: Liquid Magma Totem @ Cursor', key = 'K_LMT', default = true},
	{type = 'checkbox', text = 'L-Control: Lightning Surge Totem @ Cursor', key = 'K_LST', default = true},
	{type = 'checkbox', text = 'L-Alt: Earthbind Totem @ Cursor', key = 'K_ET', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cff0070de --- |rShaman: |cff0070deELEMENTAL|r')
	print('|cff0070de --- |rLightning Rod: 1/3 - 2/1 - 3/1 - 4/2 - 5/3||5/2 (Tyrannical) - 6/1 - 7/2|r')
	print('|cff0070de --- |rIcefury: 1/3 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3||6/1 (Mythic+ AoE) - 7/3|r')
	print('|cff0070de --- |rAscendance: 1/1 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3||6/1 (Mythic+ AoE)- 7/1|r')
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		-- Cleanse Spirit
		key = 'yuPS',
		name = 'Cleanse Spirit',
		text = 'Enable/Disable: Automatic removal of curses',
		icon = 'Interface\\ICONS\\ability_shaman_cleansespirit',
	})

end

local Survival = {
	{'&Astral Shift', 'UI(S_ASE)&player.health<=UI(S_AS)'},
	{'Earth Elemental', '!ingroup&UI(S_EEE)&player.health<=UI(S_EE)'},
	{'&Gift of the Naaru', 'UI(S_GOTNE)&player.health<=UI(S_GOTN)'},
	{'#127834', 'item(127834).usable&item(127834).count>0&player.health<=UI(AHP_spin)&UI(AHP_check)'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<=UI(HS_spin)&UI(HS_check)', 'player'}, 	--Health Stone
}

local Player = {
	{'!Healing Surge', 'UI(S_HSGE)&player.health<=UI(S_HSG)', 'player'},
}

local Emergency = {
	{'!Healing Surge', 'UI(E_HSGE)&lowest.health<=UI(E_HSG)', 'lowest'},
}

local Keybinds = {
	{'!Liquid Magma Totem', 'UI(K_LMT)&talent(6,1)&keybind(lshift)', 'cursor.ground'},
	{'!Lightning Surge Totem', 'UI(K_LST)&keybind(lcontrol)', 'cursor.ground'},
	{'!Earthbind Totem', 'UI(K_ET)&keybind(lalt)', 'cursor.ground'},
}

local Interrupts = {
	{'!Wind Shear'},
}

local Dispel = {
	{'%dispelself'},
}

local AoE = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Stormkeeper'},
	{'Liquid Magma Totem', '{!moving||moving}&talent(6,1)&!advanced', 'cursor.ground'},
	{'Liquid Magma Totem', '{!moving||moving}&talent(6,1)&advanced', 'target.ground'},
	--***Flame Shock according to AoE Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Flame Shock', '{!moving||moving}&!talent(7,2)&player.maelstrom>10&target.debuff(Flame Shock).duration<gcd'},
	{'Flame Shock', '{!moving||moving}&talent(7,2)&target.area(10).enemies<4&!target.debuff(Flame Shock)'},
	{'Earthquake', '{!moving||moving}&player.maelstrom>40&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.maelstrom>40&advanced', 'target.ground'},
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||!moving&!talent(7,2)&target.debuff(Flame Shock).duration>spell(Lava Burst).casttime'},
	--***Elemental Blast according to Fortified affix Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Elemental Blast', 'talent(5,3)'},
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)'},
	--***Chain Lightning according to AoE Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Chain Lightning', 'talent(7,2)&{!target.debuff(Lightning Rod)||player.buff(Stormkeeper)}'},
	{'Chain Lightning', nil, 'target'},
}

-- Lightning Rod Rotation
local LRCooldowns = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Stormkeeper'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
}

local LRSingle = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)||target.debuff(Flame Shock).duration<=gcd'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>76&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>76&advanced', 'target.ground'},
	{'Earth Shock', '{!moving||moving}&player.maelstrom>82'},
	{'Stormkeeper'},
	{'Elemental Blast', 'talent(5,3)'},
	--***Lava Burst according to Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&spell(Lava Burst).cooldown==0&{!player.buff(Stormkeeper)||player.buff(Stormkeeper).duration>spell(Lava Burst).casttime+{1.5*{spell_haste}*player.buff(Stormkeeper).count+1}}'},
	{'Flame Shock', '{!moving||moving}&player.maelstrom>10&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	--***Earth Shock according to Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Earth Shock', '{!moving||moving}&player.maelstrom>76&!player.buff(Lava Surge)'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&advanced', 'target.ground'},
	--***Lightning Bolt according to Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&{!target.debuff(Lightning Rod)||player.buff(Stormkeeper)&!toggle(aoe)}'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	{'Lightning Bolt', '!target.debuff(Lightning Rod)'},
	{'Lightning Bolt', nil, 'target'},
}

-- Icefury Rotation
local IFCooldowns = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
}

local IFSingle = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)||target.debuff(Flame Shock).duration<=gcd'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>76&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>76&advanced', 'target.ground'},
	{'Frost Shock', 'player.buff(Icefury)&player.maelstrom>76'},
	{'Earth Shock', '{!moving||moving}&player.maelstrom>82'},
	{'Stormkeeper', '!player.buff(Icefury)'},
	{'Elemental Blast', 'talent(5,3)'},
	{'Icefury', 'player.maelstrom<86&!player.buff(Stormkeeper)'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&player.buff(Stormkeeper)'},
	--***Lava Burst according to Icefury Rotaion from Storm, Earth and Lava***
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&{spell(Lava Burst).cooldown==0||player.maelstrom<98&spell(Lava Burst).charges<3}'},
	--***Frost Shock according to Icefury Rotaion from Storm, Earth and Lava***
	{'Frost Shock', '{!moving||moving}&player.buff(Icefury)&{lastcast(Icefury)||player.maelstrom>10||player.buff(Icefury).duration<{1.5*{spell_haste}*player.buff(Icefury).count+1}}'},
	{'Flame Shock', '{!moving||moving}&player.maelstrom>10&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	{'Frost Shock', '{!moving||moving}&player.buff(Icefury)'},
	{'Earth Shock', '{!moving||moving}&player.maelstrom>76'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&advanced', 'target.ground'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	{'Lightning Bolt', nil, 'target'},
}

-- Ascendance Rotation
local ASCooldowns = {
	{'Ascendance', 'target.debuff(Flame Shock).duration>player.buff(Ascendance).duration&{combat(player).time>50||hashero}&spell(Lava Burst).cooldown>0&!player.buff(Stormkeeper)'},
	{'Ascendance', 'spell(Lava Burst).cooldown>0&!player.buff(Stormkeeper)'},
	{'Stormkeeper', '!player.buff(Ascendance)'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
	{'Elemental Mastery', 'talent(4,3)&player.buff(Ascendance)'},
}

local ASSingle = {
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)||target.debuff(Flame Shock).duration<=gcd'},
	{'Flame Shock', 'player.maelstrom>10&target.debuff(Flame Shock).duration<=player.buff(Ascendance).duration&spell(Ascendance).cooldown+player.buff(Ascendance).duration<=target.debuff(Flame Shock).duration'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&player.maelstrom>76&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&player.maelstrom>76&advanced', 'target.ground'},
 	{'Earth Shock', '{!moving||moving}&player.maelstrom>82&!player.buff(Ascendance)'},
	{'Stormkeeper', '!player.buff(Ascendance)'},
	{'Elemental Blast', 'talent(5,3)'},
	--***Lightning Bolt according to Ascendance Rotaion from Storm, Earth and Lava***
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&{player.buff(Stormkeeper)||spell(Lava Burst).charges<3}'},
	--***Lava Burst according to Ascendance Rotaion from Storm, Earth and Lava***
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&{spell(Lava Burst).cooldown==0||player.buff(Ascendance)||!player.buff(Ascendance)&player.buff(Stormkeeper).duration>spell(Lava Burst).casttime+{1.5*{spell_haste}*player.buff(Stormkeeper).count+1}}'},
	{'Flame Shock', '{!moving||moving}&player.maelstrom>10&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	--***Earth Shock according to Ascendance Rotaion from Storm, Earth and Lava***
	{'Earth Shock', '{!moving||moving}&player.maelstrom>76&{!player.buff(Lava Surge)||!player.buff(Ascendance)}'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&advanced', 'target.ground'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	{'Lightning Bolt', nil, 'target'},
}

local inCombat = {
	{Keybinds},
	{Dispel, 'toggle(yuPS)&spell(Cleanse Spirit).cooldown==0'},
	{Survival},
	{Player, '!player.moving'},
	{Emergency, '!player.moving'},
	{Fel_Explosives, 'range<41'},
	{Interrupts, 'toggle(Interrupts)&target.interruptAt(70)&target.inFront&target.range<40'},
	{LRCooldowns, '&talent(7,2)&toggle(Cooldowns)'},
	{IFCooldowns, 'talent(7,3)&toggle(Cooldowns)'},
	{ASCooldowns, 'talent(7,1)&toggle(Cooldowns)'},
	{AoE, 'toggle(aoe)&player.area(40).enemies>2'},
	{LRSingle, 'talent(7,2)&target.inFront&target.range<41'},
	{IFSingle, 'talent(7,3)&target.inFront&target.range<41'},
	{ASSingle, 'talent(7,1)&target.inFront&target.range<41'},
}

local outCombat = {
	{Dispel, 'toggle(yuPS)&spell(Cleanse Spirit).cooldown<gcd'},
	{Interrupts, 'toggle(Interrupts)&target.interruptAt(70)&target.inFront&target.range<41'},
	{Emergency, '!moving&ingroup'},
	{'Healing Surge', '!moving&player.health<80', 'player'},
	{'Ghost Wolf', 'movingfor>1&!player.buff(Ghost Wolf)'},
}

NeP.CR:Add(262, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Elemental',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
