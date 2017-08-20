local _, Zylla = ...
local NeP = NeP

-- Thanks to Silver for a 'working' Holy routine!

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

--[[
	TO DO:
	Add Nighthold encounter support
	Add mythic 5 man utility
	Add support for all talents
--]]

local GUI = {
	{type = 'checkspin',text = 'Mana Potion', key = 'P_MP', default = false},
	{type = 'header', 	text = 'Generic', align = 'center'},
	{type = 'spinner', 	text = 'DPS while lowest above % ', key = 'G_DPS', default = 70},
	{type = 'checkbox', text = 'Auto-Target Enemies while DPSing', key = 'kAutoTarget', default = true},
	{type = 'spinner', 	text = 'Critical health %', key = 'G_CHP', default = 30},
	{type = 'spinner', 	text = 'Mana Restore', key = 'P_MR', default = 20},
	{type = 'checkbox',	text = 'Offensive Holy Shock', key = 'O_HS', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	--------------------------------
	-- Toggles
	--------------------------------
	{type = 'header', 	text = 'Toggles', align = 'center'},
	{type = 'checkbox',	text = 'Avenging Wrath', key = 'AW', default = true},
	{type = 'checkbox',	text = 'Aura Mastery', key = 'AM', default = true},
	{type = 'checkbox',	text = 'Holy Avenger', key = 'HA', default = false},
	{type = 'checkbox',	text = 'Lay on Hands', key = 'LoH', default = true},
	{type = 'checkbox',	text = 'Encounter Support', key = 'ENC', default = true},
	{type = 'checkspin',text = 'Healing Potion', key = 'P_HP', default = false},
	{type = 'checkspin',text = 'Mana Potion', key = 'P_MP', default = false},
	{type = 'ruler'},	{type = 'spacer'},

	--------------------------------
	-- TANK
	--------------------------------
	{type = 'header', 	text = 'Tank', align = 'center'},
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', key = 'T_LoH', default = 20},
	{type = 'spinner', 	text = 'Blessing of Sacrifice (Health %)', key = 'T_BoS', default = 30},
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', key = 'T_LotM', default = 35},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', key = 'T_HS', default = 100},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', key = 'T_FoL', default = 75},
	{type = 'spinner', 	text = 'Holy Light (Health %)', key = 'T_HL', default = 90},
	{type = 'ruler'},	{type = 'spacer'},

	--------------------------------
	-- LOWEST
	--------------------------------
	{type = 'header', 	text = 'Lowest', align = 'center'},
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', key = 'L_LoH', default = 15},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', key = 'L_HS', default = 100},
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', key = 'L_LotM', default = 40},
	{type = 'spinner', 	text = 'Light of the Martyr moving (Health %)', key = 'L_LotMm',default = 65},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', key = 'L_FoL', default = 70},
	{type = 'spinner', 	text = 'Holy Light (Health %)', key = 'L_HL', default = 90},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1',	default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2',	default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF',	default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR',	default = true},
	{type = 'ruler'},	{type = 'spacer'},

	--------------------------------
	-- LOWEST
	--------------------------------
	{type = 'header', 	text = 'Out of combat', align = 'center'},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', key = 'occ_HS', default = 100},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	NeP.Interface:AddToggle({
		key = 'dps',
		name='DPS',
		text = 'DPS while healing',
		icon='Interface\\Icons\\spell_holy_crusaderstrike',
	})

	NeP.Interface:AddToggle({
		key = 'disp',
		name='Dispell',
		text = 'ON/OFF Dispel All',
		icon='Interface\\ICONS\\spell_holy_purify',
	})

end

local Top_Up = {
	{'Holy Shock'},
	{'Flash of Light'},
}

local Keybinds = {
	{'%pause', 'keybind(lalt)'},
	{Top_Up, 'keybind(lcontrol)', 'mouseover'},
}

-- Cast that should be interrupted
local Interrupts = {
	{'!Hammer of Justice', nil, 'target'},
	{'!Blinding Light', 'target.range<8'},
}

local Survival = {
	{'#127834', 'UI(P_HP_check)&player.health<=UI(P_HP_spin)'},		-- Health Pot
	{'#127835', 'UI(P_MP_check)&player.mana<=UI(P_MP_spin)'},		-- Mana Pot
	{'Divine Protection', 'player.buff(Blessing of Sacrifice)'},
}

local DPS = {
	{'Consecration', 'target.range<7&target.enemy&!player.moving'},
	{'Blinding Light', 'player.area(8).enemies>2'},
	{'Holy Shock', 'UI(O_HS)', 'target'},
	{'Holy Prism', nil, 'target'},
	{'Judgment', 'enemy', 'target'},
	{'Crusader Strike', 'target.inMelee', 'target'},
}

local Tank = {
	{'Beacon of Light', '!talent(7,3)&!buff&!buff(Beacon of Faith)', 'tank'},
	{'Beacon of Faith', '!talent(7,3)&!buff&!buff(Beacon of Light)', 'tank2'},
	{'Bestow Faith', '!buff&talent(1,1)&health<100', {'tank', 'tank2'}},
}

local Encounters = {
}

local AoE_Healing = {
	{'Beacon of Virtue', 'lowest.area(30,95).heal>2&talent(7,3)'},
	{'Rule of Law', 'area(22,90).heal.inFront>2&!player.buff&cooldown(Light of Dawn).remains<gcd'},
	--{'Light of Dawn', 'area(15,90).heal.inFront>2&player.buff(Rule of Law)'}, LINE BELLOW MAKES THIS REDUNTANTE
	{'Light of Dawn', 'area(15,90).heal.inFront>2||buff(Divine Purpose)', 'player'},
	{'Holy Prism', 'target.area(15,80).heal>2', ''},
	{'Tyr\'s Deliverance', 'area(15,75).heal>2||{area(22,75).heal>2&player.buff(Rule of Law)}', 'player'},
}

local Healing = {
	-- Add an Aura of Sacrifice rotation here!
	--(Wings and Holy Avenger and Tyrs pre-cast)
	--(Bestow Faith or Hammer pre-cast)
	--(Divine Shield pre-cast)
	--Judgement of Light
	--Aura Mastery

	{{
		{'Avenging Wrath', nil, 'player'},
		{'Holy Avenger', nil, 'player'},
		{'Holy Shock', nil, 'lowest'},
		{'Light of Dawn', nil, 'player'},
		{'Flash of Light', nil, 'lowest'},
	}, 'player.buff(Aura Mastery)&talent(5,2)'},

	{AoE_Healing},
	{Encounters, 'UI(ENC)'},

	{'Light of the Martyr', '!is(player)&player.buff(Maraad\'s Dying Breath)&health<=UI(L_FoL)', 'lowest'},

	-- Infusion of Light
	--{'Flash of Light', 'player.buff(Infusion of Light).count>1', 'lowest'},
	{'Flash of Light', 'health<=UI(L_FoL)&player.buff(Infusion of Light)', 'lowest'},
	{'Flash of Light', 'player.buff(Infusion of Light).duration<4&player.buff(Infusion of Light)', 'lowest'},

	-- Need player health spinner added
	{{
		{'Light of the Martyr', '!is(player)&health<=UI(T_LotM)', {'tank', 'tank2'}},
		{'Light of the Martyr', '!is(player)&health<=UI(L_LotM)', 'lowest'},
	}, 'player.health>30'},

	{'Holy Shock', 'health<UI(T_HS)', {'tank', 'tank2'}},
	{'Holy Shock', 'health<UI(L_HS)!enemy', {'lowest', 'mouseover'}},

	--{'Flash of Light', 'health<=UI(L_FoL)', 'lbuff(Tyr\'s Deliverance)'},
	{'Flash of Light', 'health<=UI(T_FoL)', {'tank', 'tank2'}},
	{'Flash of Light', 'health<=UI(L_FoL)!enemy', {'lowest', 'mouseover'}},

	{'Judgment', 'enemy', 'target'}, -- Keep up dmg reduction buff

	{'Holy Light', 'health<=UI(T_HL)', {'tank', 'tank2'}},
	{'Holy Light', 'health<=UI(L_FoL)&!enemy', {'lowest', 'mouseover'}},
}

local Emergency = {
	{'Lay on Hands', 'UI(LoH)&health<=UI(T_LoH)&!debuff(Forbearance).any', 'lowest(tank)'},
	{'Lay on Hands', 'UI(LoH)&health<=UI(L_LoH)&!debuff(Forbearance).any', 'lowest'},
	{'!Holy Shock', nil, 'lowest'},
	{'!Light of the Martyr', '!player.casting(Flash of Light)', 'lowest'},
	{'!Flash of Light', '!player.moving', 'lowest'},
}

local Cooldowns = {
	-- Need to re-write for Raid and 5 Man
	{'Aura Mastery', 'UI(AM)&area(40,40).heal>3', 'player'},
	{'Avenging Wrath', 'UI(AW)&area(35,65).heal>3&spell(Holy Shock).cooldown<gcd', 'player'},
	{'Holy Avenger', 'UI(HA)&area(40,75).heal>2&spell(Holy Shock).cooldown<gcd', 'player'},

	{'Blessing of Sacrifice', 'health<=UI(T_BoS)', {'tank', 'tank2'}},
}

local Moving = {
	{AoE_Healing},

	{{
		{'Light of the Martyr', '!is(player)&health<=UI(T_LotM)', {'tank', 'tank2'}},
		{'Light of the Martyr', '!is(player)&health<=UI(L_LotM)', 'lowest'},
	}, 'player.health>30'},

	{'Holy Shock', 'health<UI(T_HS)', 'tank'},
	{'Holy Shock', 'health<UI(L_HS)', 'lowest'},

	{'Judgment', 'enemy', 'target'},
}

local Mana_Restore = {
	{'Holy Shock', 'health<UI(L_HS)', 'lowest'},
	{'Holy Light', 'health<UI(T_HL)', {'tank', 'tank2'}},
	{'Holy Light', 'health<UI(L_HL)', 'lowest'},
	{'Judgment', 'enemy', 'target'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Survival},
	{Interrupts, 'target.interruptAt(70)&target.inMelee&target.inFront'},
	{'%dispelall', 'toggle(disp)'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Emergency, 'lowest.health<=UI(G_CHP)&!player.casting(200652)'},
	{Tank},
	{DPS, 'toggle(dps)&target.enemy&target.inFront&lowest.health>=UI(G_DPS)'},
	{Moving, 'player.moving'},
	{Mana_Restore, 'player.mana<=UI(P_MR)'},
	{Healing, '!player.moving&player.mana>=UI(P_MR)'},
}

local outCombat = {
	-- Need to prevent this while eating
	--{Tank},
	{Keybinds},
	-- Precombat
	{'Bestow Faith', '!buff & dbm(pull in)<4', 'tank'},
	{'#Potion of Prolonged Power', '!player.buff&dbm(pull in)<3'},
	{'%dispelall', 'toggle(disp)'},
	--some heals
	{'Holy Shock', 'health<UI(occ_HS)', 'lowest'},
}

NeP.CR:Add(65, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Paladin - Holy',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
