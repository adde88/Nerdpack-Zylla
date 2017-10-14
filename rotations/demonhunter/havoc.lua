local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	--XXX: Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 															align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',					align = 'left', 		key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Metamorphosis|r',	align = 'left', 		key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Netherwalk|r',			align = 'left', 		key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'Darkness|r',				align = 'left', 		key = 'ralt', 		default = true},
	{type = 'spacer'},
	--{type = 'checkbox', text = 'Enable Chatoverlay', 																key = 'chat', 			width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 		size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',			default = 'normal',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 			text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 		size = 16, text = 'Class Settings',							 					align = 'center'},
	{type = 'spinner',		size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', 	text = 'Enable DBM Integration',													key = 'kDBM', 			default = true, desc = Zylla.ClassColor..'This is needed to enable use of pre-pots.|r'},
	{type = 'checkbox', 	text = 'Enable \'pre-potting\' and flasks',								key = 'prepot', 		default = false},
	{type = 'combo',			default = "1",																						key = "list", 			list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},		{type = 'spacer'},
	{type = 'checkspin',	text = 'Light\'s Judgment - Units', 											key = 'LJ',					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
--{type = 'checkbox', 	text = 'Auto-target enemy during Eye Beam',								key = 'eyeface', 		default = false},	-- Will be implemented soon...
--{type = 'checkbox', 	text = 'Cancel Movement/Action Animations',								key = 'kanime', 		default = false},	-- Will be implemented soon...
	{type = 'checkbox', 	text = 'Use \'Vengeful Retreat\'',												key = 'vengeful', 	default = true},
	{type = 'checkbox', 	text = 'Use \'Fel Rush\'',																key = 'felrush', 		default = true},
	{type = 'checkspin', 	text = 'Use \'Metamorphosis + Units\'',										key = 'meta',       align = 'left', width = 55, step = 1, shiftStep = 2, spin = 1, max = 20, min = 1, check = true},
	{type = 'checkspin', 	text = 'Use \'Chaos Nova + Units\'',											key = 'chaos',      align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true},
	{type = 'checkbox', 	text = 'Use Trinket #1', 																	key = 'trinket1',		default = false},
	{type = 'checkbox', 	text = 'Use Trinket #2', 																	key = 'trinket2', 	default = false, width = 55, desc = Zylla.ClassColor..'Trinkets will be on cooldown!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 						key = 'kj', 				align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},			{type = 'spacer'},
	--XXX: Survival
	{type = 'header', 		size = 16, text = 'Survival',									  	    		align = 'center'},
	{type = 'checkspin', 	text = 'Blur',               															key = 'blur',       align = 'left', width = 55, step = 5, shiftStep = 10, spin = 60, max = 100, min = 1, check = true},
	{type = 'checkspin', 	text = 'Netherwalk',              												key = 'nether',     align = 'left', width = 55, step = 5, shiftStep = 10, spin = 25, max = 100, min = 1, check = true},
  {type = 'checkspin',	text = 'Healthstone',																			key = 'HS',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
  {type = 'checkspin',	text = 'Healing Potion',																	key = 'AHP',				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'ruler'},	  	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDemon Hunter |cffADFF2FHavoc (Custom build.)|r')
	print('|cffADFF2F --- |rWarning: Rotation is in dev. phase. Please report any issues found!')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
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
	{'Metamorphosis', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
	{'Netherwalk', 'keybind(lalt)&UI(lalt)', 'player'},
	{'Darkness', 'keybind(ralt)&UI(ralt)', 'player'}
}

local Survival = {
	{'Blur', 'health<=UI(blur_spin)&UI(blur_check)'},
	{'Netherwalk', 'health<=UI(nether_spin)&UI(nether_check)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Interrupts = {
	{'!Consume Magic'},
	{'!Chaos Nova', 'UI(chaos_check)&player.spell(Consume Magic).cooldown>gcd&!player.lastgcd(Consume Magic)'}
}

local Cooldowns = {
	{'Metamorphosis', 'inMelee&combat&area(8).enemies>=UI(meta_spin)&UI(meta_check)', 'target.ground'},
	{'Nemesis', 'player.spell(Chaos Blades).cooldown<=gcd'},
	{'Chaos Nova', 'player.area(8).enemies>UI(chaos_spin)&UI(chaos_check)'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'&#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>UI(LJ_spin)', 'enemies.ground'},
	{'Chaos Blades', nil, 'player'},
}

local xAoECombat = {
	{'Vengeful Retreat', '{UI(vengeful)&{{talent(2,1)&fury<=85}||{state(snare)}||{talent(5,1)&!buff(Momentum)}}}', 'player'},
	{'Eye Beam', '{talent(5,1)&player.buff(Momentum)}||{!talent(5,1)}'},
	{'Blade Dance', 'player.area(8).enemies>3||talent(3,2)'},
	{'Death Sweep', 'player.area(8).enemies>3||talent(3,2)'},
	{'Throw Glaive', '{talent(3,3)&{player.buff(Momentum)||!talent(5,1)}}||{area(8).enemies>=2}'},
	{'Chaos Strike', '{player.area(8).enemies>2&talent(3,1)}||{player.fury>70||{player.fury>60&talent(2,2)}}'},
	{'Demon\'s Bite', '!talent(2,2)'}
}

local xSTCombat = {
	{'Blade Dance', 'talent(3,2)&player.fury>=15'},
	{'Death Sweep', 'talent(3,2)&player.fury>=15'},
	{'Chaos Strike',  'player.fury>=40'},
	{'Annihilation', 'player.fury>=40'},
	{'Demon\'s Bite', '!talent(2,2)'},
}

local Ranged = {
	{{
		{'Fel Rush', 'range<=15&UI(felrush)&target.area(5).enemies>=2&spell.charges>=1&spell.recharge<=2', 'player'},
		{'Fel Barrage', 'range<=30'},
		{'Fury of the Illidari', 'range<=40'},
		{'Throw Glaive', 'range<=30&talent(2,2)'},
		{'Felblade', 'range<=15&player.fury.diff>30'},
	}, 'player.area(15).enemies<3'}, 							--XXX: Ranged ST
	{{
		{'Fel Rush', 'target.range<=15&{UI(felrush)&{{talent(1,1)&fury.diff<=30}||{spell.charges>=1&spell.recharge<=2&area(8).enemies>3}||{talent(5,1)&!buff(Momentum)}}}', 'player'},
		{'Fel Barrage', 'range<=30&{{talent(5,1)&player.buff(Momentum)}||{!talent(5,1)}}'},
		{'Fury of the Illidari', 'range<=40&{{talent(5,1)&player.buff(Momentum)}||{!talent(5,1)}}'},
	}, 'player.area(15).enemies>2&toggle(aoe)'}, 	--XXX: Ranged AoE
}

local xCombat ={
	{Cooldowns, 'toggle(cooldowns)'},
	{Interrupts, 'toggle(Interrupts)&interruptAt(70)'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&interruptAt(70)', 'enemies'},
	{xSTCombat, 'inMelee&player.area(15).enemies<=2'},
	{xAoECombat, 'inMelee&player.area(15).enemies>=3&toggle(aoe)'},
	{Ranged},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{'Fel Rush', 'UI(felrush)&target.range>=13&target.range<=40&target.inFront', 'player'},
	{xCombat, 'UI(target)==normal', 'target'},
	{xCombat, 'combat&alive&UI(target)==lowest', 'lowestenemy'},
	{xCombat, 'combat&alive&UI(target)==highest', 'highestenemy'},
	{xCombat, 'combat&alive&UI(target)==nearest', 'nearestenemy'},
	{xCombat, 'combat&alive&UI(target)==furthest', 'furthestenemy'},
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'}
}

NeP.CR:Add(577, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Havoc',
	ic = {
		{inCombat, '!player.channeling(Eye Beam)'}
	--{'&@Zylla.face', 'UI(eyeface)&player.channeling(Eye Beam)', 'target'} -- Temp disabled.
	},
	--pooling = true,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
