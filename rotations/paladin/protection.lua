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
	{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
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
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Kil\'Jaeden\'s Burning Wish - Units', 						key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
  {type='spacer'}, 		{type='rule'},
  {type = 'header', 	size = 16, text = 'Survival', 														align = 'center'},
	{type = 'checkspin',text = 'Flash of Light', 																	key = 'fol', 					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 75, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Light of the Protector', 													key = 'lotp', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 75, max = 100, min = 1, check = true},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
  Zylla.ExeOnLoad()
  Zylla.AFKCheck()

  print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffADFF2F --- |rPALADIN |cffADFF2FProtection |r')
  print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/3 - 4/1 - 5/2 - 6/2 - 7/3')
  print('|cffADFF2F ----------------------------------------------------------------------|r')

  NeP.Interface:AddToggle({
  key = 'AutoTaunt',
  name = 'Auto Taunt',
  text = 'Automatically taunt nearby enemies.',
  icon = 'Interface\\Icons\\spell_nature_shamanrage.png',
  })

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat ={
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127850', 'item(127850).usable&item(127850).count>0&UI(prepot)&!buff(Flask of Ten Thousand Scars)'},		--XXX: Flask of Ten Thousand Scars
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},						--XXX: Lightforged Augment Rune
}

local Keybinds = {
  {'%pause', 'keybind(lshift)&UI(lshift)'},
	{'Divine Steed', 'keybind(lcontrol)&UI(lcontrol)', 'player'}
}

local Interrupts = {
  {'!Rebuke'},
  {'!Hammer of Justice', 'cooldown(Rebuke).remains>=gcd'},
  {'!Arcane Torrent', 'inMelee&spell(Rebuke).cooldown>=gcd&!player.lastgcd(Rebuke)'},
}

local Survival ={
  {'Flash of Light', 'health<=UI(fol_check)&lastmoved>0&UI(fol_spin)'},
  {'Light of the Protector', 'UI(lotp_check)&health<UI(lotp_spin)&buff(Consecration)'},
}

local EyeofTyr = {
  {'Divine Steed', 'talent(5,2)'},
  {'Eye of Tyr'},
  {'Aegis of Light', 'talent(6,1)'},
  {'Guardian of Ancient Kings'},
  {'Divine Shield'},
  {'Ardent Defender'},
}

local Cooldowns = {
  {'Seraphim', 'spell(Shield of the Righteous).charges>1', 'player'},
  {'Shield of the Righteous', 'inMelee&inFront&{!talent(7,2)||spell(Shield of the Righteous).charges>=3}&!{player.buff(Eye of Tyr)&player.buff(Aegis of Light)&player.buff(Ardent Defender)&player.buff(Guardian of Ancient Kings)&player.buff(Divine Shield)}', 'target'},
  {'Bastion of Light', 'talent(2,2)&spell(Shield of the Righteous).charges<1', 'player'},
  {'Light of the Protector', 'health<40', 'player'},
  {'Hand of the Protector', 'talent(5,1)&health<40', 'player'},
  {'Light of the Protector', '{incdmg(10)>health.max*1.25}&health<55&talent(7,1)', 'player'},
  {'Light of the Protector', '{incdmg(13)>health.max*1.6}&health<55', 'player'},
  {'Hand of the Protector', 'talent(5,1)&{incdmg(6)>health.max*0.7}&health<55&talent(7,1)', 'player'},
  {'Hand of the Protector', 'talent(5,1)&{incdmg(9)>health.max*1.2}&health<55', 'player'},
  {EyeofTyr, 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
  {'Lay on Hands', 'health<15', 'player'},
  {'Avenging Wrath', '!talent(7,2)||talent(7,2)&buff(Seraphim)', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local AoE = {
  {'Avenger\'s Shield'},
  {'Blessed Hammer'},
  {'Judgment'},
  {'Consecration'},
  {'Hammer of the Righteous', '!talent(1,2)'},
}

local ST = {
  {'Judgment'},
  {'Blessed Hammer'},
  {'Avenger\'s Shield'},
  {'Consecration'},
  {'Blinding Light'},
  {'Hammer of the Righteous', '!talent(1,2)'},
}

local xCombat = {
	{Interrupts, 'toggle(interrupts)&@Zylla.interruptAt(intat)'},
	{Interrupts, 'toggle(interrupts)&toggle(xIntRandom)&@Zylla.interruptAt(intat)', 'enemies'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>=3'},
	{ST, 'inFront&inMelee'}
}

local inCombat = {
  {Keybinds},
  {Survival, nil, 'player'},
  {'%taunt(Hand of Reckoning)', 'toggle(aoe)'},
  {'Shield of the Righteous', '!player.buff&{player.health<60||spell.count>1}', 'target'},
	{xCombat, 'inMelee&UI(target)==normal', 'target'},
	{xCombat, 'combat&alive&inMelee&UI(target)==highest', 'highestenemy'},
	{xCombat, 'combat&alive&inMelee&UI(target)==lowest', 'lowestenemy'},
	{xCombat, 'combat&alive&inMelee&UI(target)==nearest', 'nearestenemy'},
	{xCombat, 'combat&alive&inMelee&UI(target)==furthest', 'furthestenemy'},
	{Mythic_Plus, 'inMelee'},
}

local outCombat = {
  {Keybinds},
  {PreCombat, nil, 'player'}
}

NeP.CR:Add(66, {
  name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Paladin - Protection',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
