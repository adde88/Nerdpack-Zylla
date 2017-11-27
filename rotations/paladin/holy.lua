local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds:',	 																align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',							align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Mouseover Healing|r',	align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',										align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																		key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings:',											align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',	key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																						key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4, step = 1, max = 20, check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Dispel Everyone',																	key = 'dispelall', 		default = true},
	{type = 'checkbox', text = 'Dispel Player',																		key = 'dispelself', 	default = true},
	{type = 'checkspin',text = 'DPS while avg. party HP% above', 									key = 'G_DPS', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 70, max = 100, min = 1, check = true},
	{type = 'checkbox', text = 'Auto-Target Enemies while DPSing', 								key = 'kAutoTarget', 	default = true},
	{type = 'spinner', 	text = 'Critical HP%', 																		key = 'G_CHP', 				default = 30},
	{type = 'spinner', 	text = 'Mana Restore', 																		key = 'P_MR', 				default = 20},
	{type = 'checkbox',	text = 'Offensive Holy Shock', 														key = 'O_HS', 				default = true},
	{type = 'checkspin',text = 'Use Gift of the Naaru', 													key = 'GotN', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 40, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healthstone',																			key = 'HS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																	key = 'AHP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Mana Potion',																			key = 'AMP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 30, max = 100, min = 1, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	-- Toggles
	{type = 'header', 	size = 16, text = 'Toggles:', 														align = 'center'},
	{type = 'checkbox',	text = 'Avenging Wrath', 																	key = 'AW', 					default = true},
	{type = 'checkbox',	text = 'Aura Mastery', 																		key = 'AM', 					default = true},
	{type = 'checkbox',	text = 'Holy Avenger', 																		key = 'HA', 					default = false},
	{type = 'checkbox',	text = 'Lay on Hands', 																		key = 'LoH', 					default = true},
	{type = 'checkspin',text = 'Healing Potion', 																	key = 'P_HP', 				default = false},
	{type = 'checkspin',text = 'Mana Potion', 																		key = 'P_MP', 				default = false},
	{type = 'ruler'},		{type = 'spacer'},
	-- TANK
	{type = 'header', 	size = 16, text = 'Tank:', 																align = 'center'},
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', 												key = 'T_LoH', 				default = 20},
	{type = 'spinner', 	text = 'Blessing of Sacrifice (Health %)', 								key = 'T_BoS', 				default = 30},
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', 									key = 'T_LotM', 			default = 35},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', 													key = 'T_HS', 				default = 100},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', 											key = 'T_FoL', 				default = 75},
	{type = 'spinner', 	text = 'Holy Light (Health %)', 													key = 'T_HL', 				default = 90},
	{type = 'ruler'},		{type = 'spacer'},
	-- LOWEST
	{type = 'header', 	size = 16, text = 'Lowest:', 															align = 'center'},
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', 												key = 'L_LoH', 				default = 15},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', 													key = 'L_HS', 				default = 100},
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', 									key = 'L_LotM', 			default = 40},
	{type = 'spinner', 	text = 'Light of the Martyr moving (Health %)', 					key = 'L_LotMm',			default = 65},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', 											key = 'L_FoL', 				default = 70},
	{type = 'spinner', 	text = 'Holy Light (Health %)', 													key = 'L_HL', 				default = 90},
	{type = 'ruler'},		{type = 'spacer'},
	-- LOWEST
	{type = 'header', 	size = 16, text = 'Out of combat', 												align = 'center'},
	{type = 'checkspin',text = 'Holy Shock (Health %)',														key = 'occ_HS',				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 90, max = 100, min = 1, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI)
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |Paladin |cffADFF2FHoly|r')
	print('|cffADFF2F --- |rRecommended Talents: in active development.')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

end

local PreCombat ={
	{'Bestow Faith', '!buff&dbm(pull in)<4', 'tank'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127849', 'item(127849).usable&item(127849).count>0&UI(prepot)&!buff(Flask of the Whispered Pact	)'},	--XXX: Flask of the Whispered Pact
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},						--XXX: Lightforged Augment Rune
}


local Top_Up = {
	{'Holy Shock', 'friend||ingroup'},
	{'Flash of Light', 'friend||ingroup'},
}

local Keybinds = {
	{'%pause', 'keybind(lalt)&UI(lalt)'},
	{Top_Up, 'keybind(lcontrol)&UI(lcontrol)', 'mouseover'},
}

local Interrupts = {
	{'!Hammer of Justice'},
	{'!Blinding Light', 'spell(Hammer of Justice).cooldown>=gcd!player.lastgcd(Hammer of Justice)'},
}

local Survival = {
	{'Divine Protection', 'buff(Blessing of Sacrifice)'},
	{'&Gift of the Naaru', 'UI(GotN_check)&health<=UI(GotN_spin)'},
	{'&Every Man for Himself', 'UI(EMfH)&state(stun)'},
	{'#152619', 'item(152619).usable&item(152619).count>0&mana<=UI(AMP_spin)&UI(AMP_check)'}, 														--XXX: Astral Mana Potion
	{'#127835', 'item(152619).count==0&item(127835).usable&item(127835).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Mana Potion
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local DPS = {
	{'Consecration', 'inMelee&!player.moving'},
	{'Blinding Light', 'player.area(8).enemies>=3'},
	{'Holy Shock', 'UI(O_HS)&range<=40'},
	{'Holy Prism', 'range<=40'},
	{'Judgment', 'range<=30'},
	{'Crusader Strike', 'inMelee'},
}

local Tank = {
	{'Beacon of Light', '!talent(7,3)&!buff&!buff(Beacon of Faith)', {'tank', 'tank2'}},
	{'Bestow Faith', '!buff&talent(1,1)&health<100', {'tank', 'tank2'}},
}

local AoE_Healing = {
	{'Beacon of Virtue', 'area(30,95).heal>2&talent(7,3)'},
	{'Rule of Law', 'area(20,90).heal.inFront>2&!player.buff&cooldown(Light of Dawn).remains<=gcd'},
	{'Light of Dawn', 'area(15,90).heal.inFront>2||buff(Divine Purpose)', 'player'},
	{'Holy Prism', 'area(15,80).heal>2'},
	{'Tyr\'s Deliverance', 'area(15,75).heal>2||{area(22,75).heal>2&buff(Rule of Law)}', 'player'},
}

local Healing = {
	-- Add an Aura of Sacrifice rotation here!
	--(Wings and Holy Avenger and Tyrs pre-cast)
	--(Bestow Faith or Hammer pre-cast)
	--(Divine Shield pre-cast)
	--Judgement of Light
	--Aura Mastery
	{AoE_Healing, nil, 'lowest'},
	{{
		{'Avenging Wrath', nil, 'player'},
		{'Holy Avenger', nil, 'player'},
		{'Holy Shock', nil, 'lowest'},
		{'Light of Dawn', nil, 'player'},
		{'Flash of Light', nil, 'lowest'},
	}, 'player.buff(Aura Mastery)&talent(5,2)'},

	{'Light of the Martyr', '!is(player)&player.buff(Maraad\'s Dying Breath)&health<=UI(L_FoL)'},

	--XXX: Infusion of Light
	{'Flash of Light', 'player.buff(Infusion of Light).count>1'},
	{'Flash of Light', 'health<=UI(L_FoL)&player.buff(Infusion of Light)'},
	{'Flash of Light', 'player.buff(Infusion of Light).duration<4&player.buff(Infusion of Light)'},

	{{
		{'Light of the Martyr', '!is(player)&health<=UI(T_LotM)', {'tank', 'tank2'}},
		{'Light of the Martyr', '!is(player)&health<=UI(L_LotM)'},
	}, 'player.health>30'},

	{'Holy Shock', 'health<UI(T_HS)', {'tank', 'tank2'}},
	{'Holy Shock', 'health<UI(L_HS)&friend', {'lowest', 'mouseover'}},

	--{'Flash of Light', 'health<=UI(L_FoL)', 'lbuff(Tyr\'s Deliverance)'},
	{'Flash of Light', 'health<=UI(T_FoL)', {'tank', 'tank2'}},
	{'Flash of Light', 'health<=UI(L_FoL)friend', {'lowest', 'mouseover'}},

	{'Judgment', 'enemy&combat&alive&range<=30', 'enemies'}, -- Keep up dmg reduction buff

	{'Holy Light', 'health<=UI(T_HL)', {'tank', 'tank2'}},
	{'Holy Light', 'health<=UI(L_FoL)&friend', {'lowest', 'mouseover'}},
}

local Emergency = {
	{'Lay on Hands', 'UI(LoH)&health<=UI(T_LoH)&!debuff(Forbearance).any&is(tank)'},
	{'Lay on Hands', 'UI(LoH)&health<=UI(L_LoH)&!debuff(Forbearance).any&!is(tank)'},
	{'!Holy Shock'},
	{'!Light of the Martyr', '!player.casting(Flash of Light)'},
	{'!Flash of Light', '!player.moving'},
}

local Cooldowns = {
	--TODO: Need to re-write for Raid and 5 Man
	{'Aura Mastery', 'UI(AM)&area(40,40).heal>=3'},
	{'Avenging Wrath', 'UI(AW)&area(35,65).heal>=3&spell(Holy Shock).cooldown<=gcd'},
	{'Holy Avenger', 'UI(HA)&area(40,75).heal>=2&spell(Holy Shock).cooldown<=gcd'},
	{'Blessing of Sacrifice', 'health<=UI(T_BoS)', {'tank', 'tank2'}},
}

local Moving = {
	{AoE_Healing},
	{{
		{'Light of the Martyr', '!is(player)&health<=UI(T_LotM)', {'tank', 'tank2'}},
		{'Light of the Martyr', '!is(player)&health<=UI(L_LotM)'},
	}, 'player.health>30'},
	{'Holy Shock', 'health<UI(T_HS)', {'tank', 'tank2'}},
	{'Holy Shock', 'health<UI(L_HS)'},
}

local Mana_Restore = {
	{'Holy Shock', 'health<UI(L_HS)'},
	{'Holy Light', 'health<UI(T_HL)', {'tank', 'tank2'}},
	{'Holy Light', 'health<UI(L_HL)'},
	{'Judgment', 'enemy&combat&alive&range<=30', 'enemies'},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{Interrupts, 'interruptAt(70)&inMelee&inFront', 'target'},
	{Interrupts, 'interruptAt(70)&inMelee&inFront', 'enemies'},
	{'%dispelall(Cleanse)', 'UI(dispelall)'},
	{'%dispelself(Cleanse)', 'UI(dispelself)'},
	{Cooldowns, 'toggle(cooldowns)', 'lowest'},
	{Emergency, 'health<=UI(G_CHP)&!player.casting(Tyr\'s Deliverance)', 'lowest'},
	{Tank},
	{DPS, 'UI(G_DPS_check)&enemy&combat&alive&inFront&lowest.health>=UI(G_DPS_spin)', 'enemies'},
	{Moving, 'player.moving', 'lowest'},
	{Mana_Restore, 'player.mana<=UI(P_MR)', 'lowest'},
	{Healing, '!player.moving&player.mana>=UI(P_MR)', 'lowest'},
	{Mythic_Plus, 'range<=8'}
}

local outCombat = {
	{PreCombat, nil, 'player'},
	--{Tank},
	{Keybinds},
	{'%dispelall(Cleanse)', 'UI(dispelall)'},
	{'%dispelself(Cleanse)', 'UI(dispelself)'},
	{'Holy Shock', 'UI(occ_HS_check)&health<=UI(occ_HS_spin)', 'lowest'},
}

NeP.CR.Add(65, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Paladin - Holy',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
