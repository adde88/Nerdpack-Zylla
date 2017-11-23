local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  		size = 16, text = 'Keybinds',	 																align = 'center'},
	{type = 'checkbox',		text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',						align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',		text = 'Left Ctrl: '..Zylla.ClassColor..'Infernal Strike|r',	align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',		text = 'Left Alt: '..Zylla.ClassColor..'Sigil of Flame|r',		align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',		text = 'Right Alt: '..Zylla.ClassColor..'|r',									align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', 	text = 'Enable Chatoverlay', 																	key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 		size = 16, text = 'Targetting:',															align = 'center'},
	{type = 'combo',			default = 'target',																						key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 			text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 		size = 16, text = 'Class Settings',														align = 'center'},
	{type = 'spinner',		size = 10, text = 'Interrupt at percentage:', 														key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', 	text = 'Enable DBM Integration',															key = 'kDBM', 				default = true},
	{type = 'checkbox', 	text = 'Enable \'pre-potting\' and Flasks',										key = 'prepot', 			default = false},
	{type = 'combo',			default = "1",																								key = "list", 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},		{type = 'spacer'},
	{type = 'checkspin',	text = 'Light\'s Judgment - Units', 													key = 'LJ',						spin = 4, max = 20, min = 1, step = 1, shiftStep = 5, check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', 	text = 'Infernal Strike (Flame Crash Talent)', 								key = 'kIS', 					default = false},
	{type = 'checkbox', 	text = 'Use Trinket #1', 																			key = 'trinket1',			default = false},
	{type = 'checkbox', 	text = 'Use Trinket #2', 																			key = 'trinket2', 		default = false,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 								key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 5, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},			{type = 'spacer'},
	-- Survival
	{type = 'header', 		text = 'Survival',									  	      								align = 'center'},
	{type = 'spinner', 		text = 'Soul Cleave',               													key = 'SC_HP',    		default = 85, max = 100, min = 1, step = 5, shiftStep = 10,},
	{type = 'checkspin', 	text = 'Soul Barrier - Soul Fragments',               				key = 'sb',    				spin = 4,  		max = 10,  min = 1, step = 1, shiftStep = 2,  check = true},
	{type = 'spinner', 		text = 'Soul Barrier - Health Threshold',               			key = 'sbhp',    			default = 60, max = 100, min = 1, step = 5, shiftStep = 10, check = true},
	{type = 'checkspin', 	text = 'Metamorphosis'								,               				key = 'meta',  				spin = 15, 		max = 100, min = 1, step = 5, shiftStep = 10, check = true},
  {type = 'checkspin',	text = 'Healthstone',																					key = 'HS',						spin = 45, 		max = 100, min = 1, step = 5, shiftStep = 10, check = true},
  {type = 'checkspin',	text = 'Healing Potion',																			key = 'AHP',					spin = 45, 		max = 100, min = 1, step = 5, shiftStep = 10, check = true},
	{type = 'ruler'},	  	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDemon Hunter |cffADFF2FVengeance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

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
	{'%pause', 'player.buff(Shadowmeld)'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'Sigil of Flame', 'keybind(lalt)', 'cursor.ground'},
	{'&Infernal Strike', 'keybind(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'&Consume Magic', 'inFront&inMelee'},
	{'!Sigil of Misery', 'advanced&interruptAt(5)&range<=30&spell(Consume Magic).cooldown>=gcd&!player.lastgcd(Consume Magic)', 'target.ground'},
	{'!Sigil of Misery', 'toggle(xIntRandom)&advanced&interruptAt(5)&range<=30&spell(Consume Magic).cooldown>=gcd&!player.lastgcd(Consume Magic)', 'enemies.ground'},
	{'!Sigil of Silence', 'advanced&interruptAt(5)&range<=30&spell(Sigil of Misery).cooldown>=gcd&spell(Consume Magic).cooldown>=gcd&!player.lastgcd(Consume Magic)', 'target.ground'},
	{'!Sigil of Silence', 'toggle(xIntRandom)&advanced&interruptAt(5)&ange<=30&spell(Sigil of Misery).cooldown>=gcd&spell(Consume Magic).cooldown>=gcd&!player.lastgcd(Consume Magic)', 'enemies.ground'},
	{'!Arcane Torrent', 'inFront&inMelee&spell(Consume Magic).cooldown>=gcd&!player.lastgcd(Consume Magic)'},
}

local Survival ={
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local xTaunts = {
	{'Torment', 'combat&alive&threat<100&range<=30'},
}

local Cooldowns = {
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>UI(LJ_spin)', 'enemies'},
	{'&#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Mitigations = {
	{'!Metamorphosis', 'toggle(cooldowns)&UI(meta_check)&!buff(Demon Spikes)&!target.debuff(Fiery Brand)&!buff&{{health<75&incdmg(1)>=health.max*0.50}||health<=UI(meta_spin)}'},
	{'!Demon Spikes', 'player.pain>21&spell.charges>0&!buff&!target.debuff(Fiery Brand)&!buff(Metamorphosis)'},
	{'!Empower Wards', 'incdmg(3).magic>player.health.max*0.1&health<75'},
	{'!Soul Barrier', 'buff(Soul Fragments).count>UI(sb_spin)&UI(sb_check)&health<=UI(sbhp)'},
	{'Immolation Aura', 'area(8).enemies>0'},
}

local xCombat = {
	{Cooldowns},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)', 'enemies'},
	{'Fiery Brand', 'inFront&inMelee&!player.buff(Demon Spikes)&!player.buff(Metamorphosis)'},
	{'Soul Carver', 'inFront&inMelee&{spell(Fiery Brand).cooldown>50||player.incdmg(3)>player.health.max*0.2}'},
	{'Shear', 'inFront&inMelee&player.pain<90'},
	{'Sever', 'inFront&inMelee'},
	{'Fracture', 'inFront&inMelee&player.buff(Soul Fragments).count<=4'},
	{'Spirit Bomb', 'inFront&inMelee&count(Frailty).enemies.debuffs==0&player.buff(Soul Fragments).count>=4'},
	{'Fel Devastation', 'inFront&inMelee&player.incdmg(1)>=player.health.max*0.25'},
	{'Soul Cleave', 'inFront&inMelee&{{player.pain>=60}||{player.health<UI(SC_HP)}}'},
	{'Fel Eruption', 'inFront&inMelee'},
	{'Felblade', 'inFront&inMelee'},
	{'&Infernal Strike', 'advanced&UI(kIS)&inFront&inMelee&talent(3,2)&debuff(Sigil of Flame).duration<=gcd&spell(Sigil of Flame).cooldown>=gcd*3&spell(Infernal Strike).charges>0', 'target.ground'},
	{'Throw Glaive', 'toggle(aoe)&!inMelee&range<=30&inFront'},
	{'Sigil of Chains', 'toggle(aoe)&advanced&range<=30&area(8).enemies>=3&combat&alive', 'enemies.ground'},
	{'Sigil of Flame', 'toggle(aoe)&advanced&range<=30&!debuff', 'target.ground'},
}

local inCombat = {
	{Keybinds},
	{xTaunts, 'toggle(super_taunt)', 'enemies'},
  {Survival, nil, 'player'},
	{Mitigations, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
		{PreCombat, nil, 'player'},
		{Keybinds},
}

NeP.CR:Add(581, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Vengeance',
	pooling = true,
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
  gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
