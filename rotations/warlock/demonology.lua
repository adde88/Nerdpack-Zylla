local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 															align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',					align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Shadowfury|r',			align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Demonic Circle|r',	align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',								align = 'left', 			key = 'ralt', 		default = true},
	{type = 'checkbox', size = 10, text = Zylla.ClassColor..'Summon Pets                                  Select Pet: |r',		align = 'right', 	key = 'epets', 		default = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 																key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',														align = 'center'},
	{type = 'combo',		default = 'normal',																					key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',													align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 							key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',														key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',		key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																							key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 												key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Summon Pet',																				key = 'kPet',					default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																		key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																		key = 'trinket2',		 	default = false,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', text = 'Kil\'Jaeden\'s Burning Wish - Units', 							key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 0, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'spacer'}, 	{type = 'ruler'},
	-- Survival
	{type = 'header',		size = 16, text = 'Survival', 															align = 'center'},
	{type = 'checkspin',text = 'Unending Resolve',																	key = 'uer',  				align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 40, check = true},
	{type = 'checkspin',text = 'Dark Pact',																					key = 'dp',  					align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 50, check = true},
	{type = 'checkspin',text = 'Drain Life',																				key = 'dl',  					align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 30, check = true},
	{type = 'checkspin',text = 'Healtn Funnel',																			key = 'hf',  					align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 60, check = true},
	{type = 'checkspin',text = 'Gift of the Naaru',																	key = 'gotn',  				align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 45, check = true},
	{type = 'checkspin',text = 'Healthstone',																				key = 'HS',  					align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 45, check = true},
	{type = 'checkspin',text = 'Ancient Healing Potion', 														key = 'AHP',  				align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 40, check = true},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarlock |cffADFF2FDemonology |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'Doom',
		name = 'Doom',
		text = 'Enable/Disable: Casting of Doom on targets',
		icon = 'Interface\\ICONS\\spell_shadow_auraofdarkness',
	})

	NeP.Interface:AddToggle({
	 key = 'xIntRandom',
	 name = 'Interrupt Anyone',
	 text = 'Interrupt all nearby enemies, without targeting them.',
	 icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

end

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<5'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<5'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<5'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127847', 'item(127847).usable&item(127847).count>0&UI(prepot)&!buff(Flask of the Whispered Pact)'},	--XXX:  Flask of the Whispered Pact
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},					--XXX: Lightforged Augment Rune
}

local Survival = {
	{'&Unending Resolve', 'UI(uer_check)&player.health<=UI(uer_spin)'},
	{'&Dark Pact', 'UI(dp_check)&talent(5,3)&pet.exists&player.health<=UI(dp_spin)'},
	{'&Gift of the Naaru', 'UI(gotn_check)&player.health<=UI(gotn_spin)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Interrupts = {
	{'!Shadowfury', 'range<41&inFront&!player.moving&UI(K_SF)', {ground=true}},
	{'!Shadowfury', 'range<41&inFront&!player.moving&UI(K_SF)&area(10).enemies>2', 'target.ground'},
	{'!Mortal Coil', 'range<30&inFront'},
	{'&89766', 'petrange<9&pet.exists'},
}

local Player = {
	{'!Drain Life', 'UI(dl_check)&player.health<=UI(dl_spin)'},
	{'!Health Funnel', 'UI(hf_check)&pet.alive&health<=UI(hf_spin)', 'pet'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Shadowfury', '!player.moving&UI(K_SF)&talent(3,3)&keybind(lcontrol)', 'cursor.ground'},
	{'!Demonic Circle', 'UI(K_DC)&talent(3,1)&keybind(lalt)&UI(lalt)'},
}

local Cooldowns = {
	{'&Arcane Torrent'},
	{'&Berserking'},
	{'&Blood Fury'},
	{'Grimoire: Felguard', 'talent(6,2)'},
	{'Summon Doomguard', '!talent(6,1)&target.area(10).enemies<3'},
	{'Summon Infernal', '!talent(6,1)&player.area(10).enemies>2&!advanced', 'player.ground'},
	{'Summon Infernal', '!talent(6,1)&target.area(10).enemies>2&advanced', 'target.ground'},
	{'Summon Doomguard', 'talent(6,1)&target.area(10).enemies==1&player.buff(Sin\'dorei Spite)'},
	{'Summon Infernal', 'talent(6,1)&player.area(10).enemies>1&player.buff(Sin\'dorei Spite)&!advanced', 'player.ground'},
	{'Summon Infernal', 'talent(6,1)&target.area(10).enemies>1&player.buff(Sin\'dorei Spite)&advanced', 'target.ground'},
	{'Summon Darkglare', 'talent(7,1)&target.area(10).enemies>1&target.debuff(Doom)&player.soulshards>0'},
	{'Soul Harvest', 'talent(4,3)&xtime>0'},
}

local DW_Clip = {
	{'!Summon Felguard', '!player.moving&!pet.exists&!talent(6,1)'},
	{'!Call Dreadstalkers', 'player.buff(Demonic Calling)'},
	{'!Hand of Gul\'dan', '!player.moving&player.soulshards>3'},
	{'!Thal\'kiel\'s Consumption', '!player.moving&spell(Call Dreadstalkers).cooldown>3&player.lastgcd(Hand of Gul\'dan)'},
	{'!Demonic Empowerment', '!player.moving&!player.lastgcd(Demonic Empowerment)&{warlock.empower==0||player.lastgcd(Summon Felguard)||player.lastgcd(Call Dreadstalkers)||player.lastgcd(Hand of Gul\'dan)||player.lastgcd(Summon Darkglare)||player.lastgcd(Summon Doomguard)||player.lastgcd(Grimoire: Felguard)||player.lastgcd(Thal\'kiel\'s Consumption)}'},
	{'!Doom', '!talent(4,1)&toggle(Doom)&!debuff'},
	{'!Life Tap', 'player.mana<40&player.health>05&{!player.lastgcd(Summon Felguard)||!player.lastgcd(Call Dreadstalkers)||!player.lastgcd(Hand of Gul\'dan)||!player.lastgcd(Summon Darkglare)||!player.lastgcd(Summon Doomguard)||!player.lastgcd(Grimoire: Felguard)}'},
	{'!Demonbolt', '!player.moving&talent(7,2)&!player.soulshards==4'},
	{'!Shadow Bolt', '!player.moving&!talent(7,2)&!player.soulshards==4'},
	{'&89751', 'petrange<9&player.area(8).enemies>2'},
}

local ST = {
	{DW_Clip, 'player.channeling(Demonwrath)&pet.exists'},
	{'!Summon Felguard', '!player.moving&!pet.exists&!talent(6,1)'},
	{'Call Dreadstalkers', '!player.moving&player.buff(Demonic Calling)'},
	{'Hand of Gul\'dan', '!player.moving&player.soulshards>3'},
	{'Thal\'kiel\'s Consumption', '!player.moving&spell(Call Dreadstalkers).cooldown>3&player.lastgcd(Hand of Gul\'dan)'},
	{'Demonic Empowerment', '!player.moving&!player.lastgcd(Demonic Empowerment)&{warlock.empower==0||player.lastgcd(Summon Felguard)||player.lastgcd(Call Dreadstalkers)||player.lastgcd(Hand of Gul\'dan)||player.lastgcd(Summon Darkglare)||player.lastgcd(Summon Doomguard)||player.lastgcd(Grimoire: Felguard)||player.lastgcd(Thal\'kiel\'s Consumption)}'},
	{'Doom', '!talent(4,1)&toggle(Doom)&!debuff&inRanged'},
	{'Life Tap', 'player.mana<40&player.health>05&{!player.lastgcd(Summon Felguard)||!player.lastgcd(Call Dreadstalkers)||!player.lastgcd(Hand of Gul\'dan)||!player.lastgcd(Summon Darkglare)||!player.lastgcd(Summon Doomguard)||!player.lastgcd(Grimoire: Felguard)}'},
	{'Demonwrath', 'movingfor>1&player.combat.time>2'},
	{'Demonbolt', '!player.moving&talent(7,2)&!player.soulshards==4'},
	{'Shadow Bolt', '!player.moving&!talent(7,2)&!player.soulshards==4'},
	{'&89751', 'petrange<9&player.area(8).enemies>2&pet.exists'},
}

local xCombat = {
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)&inFront&range<31'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)&inFront&range<31', 'enemies'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Player, '!player.moving'},
	{ST, 'inFront&range<31'},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'range<31'},
}

local outCombat = {
	{PreCombat, nil, 'player'},
	{'Summon Felguard', '{!pet.exists||!pet.alive}&!talent(6,1)}'},
	{'Life Tap', 'player.mana<70&player.health>50'},
	{'Create Healthstone', 'item(5512).count==0&!lastcast(Create Healthstone)', 'player'},
	{'Soulstone', 'UI(ss)&!buff', 'player'}
}

NeP.CR:Add(266, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Demonology',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
