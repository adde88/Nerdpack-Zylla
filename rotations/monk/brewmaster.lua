local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																					align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',											align = 'left', 					key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Transcendence/Transfer|r',			align = 'left', 					key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Black Ox Statue|r',							align = 'left', 					key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',														align = 'left', 					key = 'ralt', 		default = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 																						key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																				align = 'center'},
	{type = 'combo',		default = 'normal',																											key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																			align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 													key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																				key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',								key = 'prepot', 			default = false},
	{type = 'checkbox', text = 'Force Pet Assist',																							key = 'passist', 			default = true},
	{type = 'combo',		default = '1',																													key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																		key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Automatic Ressurect', 																					key = 'auto_res', 				default = true},
	{type = 'checkbox',	text = 'Use: Crackling Jade Lightning',																	key = 'e_cjl',						default = false},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',																											align = 'center'},
	{type = 'checkbox',	text = 'Enable Self-Heal (Effuse)', 																		key = 'kEffuse',					default = false},
	{type = 'spinner', 	text = 'Effuse (HP%)', 																									key = 'E_HP',							default = 60},
	{type = 'spinner',	text = 'Healthstone below HP%',																					key = 'hs_hp',						default = 45},
	{type = 'spinner',	text = 'Ancient Healing Potion HP%',																		key = 'ahp_hp',						default = 40},
	{type = 'spinner',	text = 'Healing Elixir', 																								key = 'Healing Elixir',		default = 70},
	{type = 'spinner',	text = 'Expel Harm', 																										key = 'Expel Harm',				default = 100},
	{type = 'spinner',	text = 'Fortifying Brew',																								key = 'Fortifying Brew',	default = 20},
	{type = 'spinner',	text = 'Ironskin Brew',																									key = 'Ironskin Brew',		default = 80},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad=function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMonk |cffADFF2FBrewmaster  |r')
	print('|cffADFF2F --- |rRecommended Talents:  COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'dispels',
		name = 'Detox',
		text = 'Enable/Disable: Automatic Removal of Poison and Diseases',
		icon = 'Interface\\ICONS\\spell_holy_renew',
	})

	NeP.Interface:AddToggle({
		key = 'xTaunt',
		name = 'Taunt',
		text = 'Automatically Taunts your current target when threat gets low.',
		icon = 'Interface\\Icons\\spell_nature_reincarnation',
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
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'ingroup&item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local TransferBack = {
  {'!Transcendence: Transfer'},
  {'&/cancelaura Transcendence', 'lastcast(Transcendence: Transfer)'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Summon Black Ox Statue', 'talent(4,2)&keybind(lalt)', 'cursor.ground'},
  {'!Transcendence', 'keybind(lcontrol)&!buff(Transcendence)', 'player'},
  {TransferBack, 'keybind(lcontrol)&buff(Transcendence)', 'player'},
}

local Dispel = {
	{'%dispelSelf'},
	{'%dispelAll', 'UI(E_disAll)'},
}

local Snares = {
	{'Nimble Brew', 'spell.exists(213664)&{state(disorient)||state(stun)||state(fear)||state(horror)}'},
	{'Tiger\'s Lust', 'talent(2,2)&{state(disorient)||state(stun)||state(root)||state(snare)}'},
}

local Cooldowns = {
	{'Fortifying Brew', 'health<=UI(Fortifying Brew)'},
}

local Mitigations = {
	{'Black Ox Brew', 'spell(Purifying Brew).charges<1&spell(purifying brew).recharge>2'},
	{'Purifying Brew', '@Zylla.staggered&spell(Purifying Brew).charges>0'},
	{'Ironskin Brew', 'health<=UI(Ironskin Brew)&spell(Purifying Brew).charges>1&!buff'},
	{'Ironskin Brew', '@Zylla.purifyingCapped&health<100&!buff'},
}

local Survival = {
	{'Healing Elixir', '{spell(Healing Elixir).charges>1||{spell(Healing Elixir).charges==1&spell(Healing Elixir).cooldown<3&!lastcast(Healing Elixir)}}&player.health<=UI(Healing Elixir)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
	{'Expel Harm', 'player.health<=UI(Expel Harm)&spell(Expel Harm).count>0'},
	{'Effuse', 'player.health<=UI(E_HP)&player.lastmoved>0&UI(kEffuse)'},
}

local Interrupts = {
	{'!Spear Hand Strike', 'interruptAt(70)&inMelee&inFront'},
	{'!Paralysis', 'interruptAt(70)&!immune(incapacitate)&range<21&player.energy>19&spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)'},
	{'!Ring of Peace', 'interruptAt(5)&advanced&range<40&spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'target.ground'},
	{'!Leg Sweep', 'interruptAt(70)&!immune(stun)&inMelee&spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)'},
	{'!Quaking Palm', 'interruptAt(70)&!immune(incapacitate)&inMelee&inFront&spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)'},
}

local Artifact = {
	{'Exploding Keg', 'advanced&range<50&{{area(8).enemies>2}||{player.incdmg(5)>=health.max*0.70}}', 'target.ground'},
}

local Crackle = {
	{'Crackling Jade Lightning', '!player.moving&UI(e_cjl)&!inMelee'},
}

local xCombat = {
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)', 'enemies'},
	{Cooldowns, 'toggle(Cooldowns)', 'player'},
	{Mitigations, 'inMelee&{!talent(7,2)||!buff(Blackout Combo)||spell(Keg Smash).cooldown>gcd}', 'player'},
	{Crackle, '!inMelee&range<=40&inFront'},
	{'Blackout Strike', 'inMelee&inFront&talent(7,2)&!player.buff(Blackout Combo)&{spell(Keg Smash).cooldown>3||spell(Keg Smash).cooldown<1.5}'},
	{'Keg Smash', 'range<25&inFront&talent(7,2)&{player.buff(Blackout Combo)||@Zylla.purifyingCapped}'},
	{'Keg Smash', 'range<25&inFront&!talent(7,2)'},
	{{
		{'Blackout Strike', 'inMelee&inFront&!player.buff(Blackout Combo)&talent(7,2)&player.area(10).enemies>0'},
		{'Breath of Fire', 'range<22&inFront&player.buff(Blackout Combo)&talent(7,2)&player.area(10).enemies>0'},
		{'Blackout Strike', 'inMelee&talent(7,2)&!player.buff(Blackout Combo)&{player.energy>35||spell(Keg Smash).cooldown>3}'},
		{'Tiger Palm', 'inMelee&inFront&talent(7,2)&player.buff(Blackout Combo)'},
		{'Blackout Strike', 'inMelee&inFront&'},
		{'Breath of Fire', 'range<22&inFront&debuff(Keg Smash)&!talent(7,2)&player.area(10).enemies>0'},
		{'Chi Burst', 'talent(1,1)&inFront&player.area(40).enemies>0'},
		{'Chi Wave', 'range<50&inFront&player.area(10).enemies>1&enemy'},
		{'Rushing Jade Wind', 'talent(6,1)&player.area(8).enemies>1'},
		{'Tiger Palm', 'inMelee&inFront&!talent(7,2)||{inMelee&inFront&player.energy>60&{player.energy>45||spell(Keg Smash).cooldown>3}}'},
	},	'spell(Keg Smash).cooldown>=0.5||{!talent(7,2)&!player.buff(Blackout Combo)&spell(Keg Smash).cooldown>gcd&@Zylla.purifyingCapped}'},
}

local inCombat = {
	{'Provoke', 'range<45&combat&alive&threat<100&toggle(xTaunt)', 'enemies'},
	{Artifact},
	{Keybinds},
	{Dispel, 'toggle(dispels)&spell(Detox).cooldown<gcd'},
	{Snares, nil, 'player'},
	{Survival, nil, 'player'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{Mythic_Plus, 'inMelee'},
}

local outCombat = {
	{PreCombat, nil, 'player'},
	{Keybinds},
	{'%ressdead(Resuscitate)&UI(auto_res)'},
	{'Effuse', 'UI(kEffuse)&health<90&lastmoved>0.25', 'player'},
}

NeP.CR:Add(268, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Brewmaster',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
