local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																		align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',								align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Death and Decay|r',			align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',	align = 'left', 		key = 'lalt', 				default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',align = 'left', 			key = 'ralt', 				default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																			key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																	align = 'center'},
	{type = 'combo',		default = 'normal',																								key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 										key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																	key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',					key = 'prepot', 			default = false},
	{type = 'combo',		default = '3',																										key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 															key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Death Grip as backup Interrupt', 													key = 'DGInt', 				default = false},
	{type = 'checkbox', text = 'Death Grip as backup Taunt', 															key = 'DGTaunt', 			default = false},
	{type = 'checkbox', text = 'Use Trinket #1', 																					key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																					key = 'trinket2', 		default = false,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Kil\'Jaeden\'s Burning Wish - Units', 										key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',																			align = 'center',			size = 16},
	{type = 'checkspin',text = 'Dancing Rune Weapon',																			key = 'drw', 					spin = 70, step = 5, shiftStep = 10, max = 100, min = 1},
	{type = 'checkspin',text = 'Death Strike - Min. HP%',																	key = 'DSA', 					spin = 70, step = 5, shiftStep = 10, max = 100, min = 1},
	{type = 'checkspin',text = 'Death Strike - Runic Power cap',													key = 'DSb', 					spin = 85, step = 5, shiftStep = 10, max = 100, min = 1},
	{type = 'checkspin',text = 'Icebound Fortitude',																			key = 'IwF', 					spin = 30, step = 5, shiftStep = 10, max = 100, min = 1},
	{type = 'checkspin',text = 'Vampiric Blood',																					key = 'VB', 					spin = 50, step = 5, shiftStep = 10, max = 100, min = 1},
	{type = 'checkspin',text = 'Healthstone', 																						key = 'HS',	 					spin = 45, step = 5, shiftStep = 10, max = 100, min = 1},
	{type = 'checkspin',text = 'Ancient Healing Potion', 																	key = 'AHP',	 				spin = 45, step = 5, shiftStep = 10, max = 100, min = 1},
	{type = 'ruler'},	 {type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDeath-Knight |cffADFF2FBlood |r')
	print('|cffADFF2F --- |rRecommended Talents: 2112133')
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
	{'%pause', 'buff(Shadowmeld)'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127850', 'item(127850).usable&item(127850).count>0&UI(prepot)&!buff(Flask of Ten Thousand Scars)'},	--XXX: Flask of Ten Thousand Scars
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},					--XXX: Lightforged Augment Rune
}

local Survival = {
	{'Icebound Fortitude', 'UI(IF_check)&health<=(IF_spin)&{{incdmg(2.5)>health.max*0.50}||state(stun)}'},
	{'Anti-Magic Shell', 'incdmg(2.5).magic>health.max*0.70'},
	{'Wraith Walk', 'state(root)||state(snare)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Death and Decay', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
}

local Cooldowns = {
	{'Dancing Rune Weapon', 'inFront&inMelee&UI(drw_check)&{{player.incdmg(2.5)>player.health.max*0.50}||{player.health<=UI(drw_spin)}}'},
	{'Vampiric Blood', 'UI(VB_check)&{incdmg(2.5)>health.max*0.50||health<=UI(VB_spin)}', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)}
}

local Interrupts = {
	{'&Mind Freeze', 'inFront&range<=15'},
	{'!Asphyxiate', 'range<=30&inFront&spell(Mind Freeze).cooldown>=gcd&!player.lastgcd(Mind Freeze)'},
	{'!Death Grip', 'UI(DGInt)&range<=30&inFront&spell(Mind Freeze).cooldown>=gcd&spell(Asphyxiate).cooldown>=gcd'},
	{'!Arcane Torrent', 'inMelee&spell(Mind Freeze).cooldown>=gcd&!player.lastgcd(Mind Freeze)'},
}

local xTaunts = {
	{'Dark Command', 'inMelee&combat&alive&threat<100'},
	{'Death Grip', 'UI(DGTaunt)&range<=30&combat&alive&threat<100&spell(Dark Command).cooldown>=gcd&!player.lastgcd(Dark Command)'},
}

local xCombat = {
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Death Strike', 'inFront&inMelee&player.runicpower>65&player.health<=UI(DSA_spin)&UI(DSA_check)'},
	{'Death Strike', 'inFront&inMelee&player.runicpower>=UI(DSb_spin)&UI(DSb_check)'},
	{'Death\'s Caress', 'range<=40&debuff(Blood Plague).remains<3'},
	{'Marrowrend', 'player.buff(Bone Shield).duration<4&inFront&inMelee'},
	{'Marrowrend', 'player.buff(Bone Shield).count<7&talent(3,1)&inFront&inMelee'},
	{'Blood Boil', 'range<=10'},
	{'Death and Decay', 'advanced&range<=30&{{talent(2,1)&player.buff(Crimson Scourge)}||{area(10).enemies>=2&player.buff(Crimson Scourge}}', 'target.ground'},
	{'Death and Decay', 'advanced&range<=30&{{talent(2,1)&player.runes>=3}||{area(10).enemies>=3}}', 'target.ground'},
	{'Death and Decay', 'advanced&!talent(2,1)&range<=30&area(10).enemies==1&player.buff(Crimson Scourge)', 'target.ground'},
	{'Heart Strike', 'inFront&inMelee&{player.runes>=3||player.buff(Death and Decay)}'},
	{'Consumption', 'inFront&inMelee'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)', 'target'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)', 'enemies'},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{xTaunts, 'toggle(super_taunt)', 'enemies'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'}
}

NeP.CR:Add(250, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death-Knight - Blood',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
