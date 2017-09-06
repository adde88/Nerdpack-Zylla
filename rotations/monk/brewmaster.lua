local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', text = 'Keybinds', 																align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', 											align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Transcendence/Transfer', 			align = 'center'},
	{type = 'text', 	text = 'Left Alt: Black Ox Statue @cursor',				align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Class Settings
	{type = 'spacer'},	{type = 'rule'},
	{type = 'header', 	text = 'General', 											align = 'center'},
	{type = 'checkbox', text = 'Automatic Ressurect', 					key = 'auto_res', 		default = true},
	{type = 'checkbox', text = 'Pause Enbled', 									key = 'kPause', 			default = true},
	{type = 'checkbox',	text = 'Use: Crackling Jade Lightning',	key = 'e_cjl',				default = false},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',												align = 'center'},
	{type = 'checkbox',	text = 'Enable Self-Heal (Effuse)', 			key = 'kEffuse',					default = false},
	{type = 'spinner', 	text = 'Effuse (HP%)', 										key = 'E_HP',							default = 60},
	{type = 'spinner',	text = 'Healthstone below HP%',						key = 'hs_hp',						default = 45},
	{type = 'spinner',	text = 'Ancient Healing Potion HP%',			key = 'ahp_hp',						default = 40},
	{type = 'spinner',	text = 'Healing Elixir', 									key = 'Healing Elixir',		default = 70},
	{type = 'spinner',	text = 'Expel Harm', 											key = 'Expel Harm',				default = 100},
	{type = 'spinner',	text = 'Fortifying Brew',									key = 'Fortifying Brew',	default = 20},
	{type = 'spinner',	text = 'Ironskin Brew',										key = 'Ironskin Brew',		default = 80},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Mythic_GUI),
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
		-- Dispels
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

local TransferBack = {
    {'!Transcendence: Transfer'},
    {'!/cancelaura Transcendence', 'lastcast(Transcendence: Transfer)'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Summon Black Ox Statue', 'talent(4,2)&keybind(lalt)', 'cursor.ground'},
    {'!Transcendence', 'keybind(lcontrol)&!player.buff(Transcendence)'},
    {TransferBack, 'keybind(lcontrol)&player.buff(Transcendence)'},
}

local Dispel = {
	{'%dispelSelf'},
	{'%dispelAll', 'UI(E_disAll)'},
}

local Snares = {
	{'Nimble Brew', 'spell.exists(213664)&{player.state(disorient)||player.state(stun)||player.state(fear)||player.state(horror)}'},
	{'Tiger\'s Lust', 'talent(2,2)&{player.state(disorient)||player.state(stun)||player.state(root)||player.state(snare)}'},
}

local Cooldowns = {
	{'Fortifying Brew', 'player.health<=UI(Fortifying Brew)'},
}

local Mitigations = {
	{'Black Ox Brew', 'player.spell(Purifying Brew).charges<1&player.spell(purifying brew).recharge>2'},
	{'Purifying Brew', '@Zylla.staggered&player.spell(Purifying Brew).charges>0'},
	{'Ironskin Brew', 'player.health<=UI(Ironskin Brew)&player.spell(Purifying Brew).charges>1&!player.buff(Ironskin Brew)'},
	{'Ironskin Brew', '@Zylla.purifyingCapped&player.health<100&!player.buff(Ironskin Brew)'},
}

local Survival = {
	{'Healing Elixir', '{player.spell(Healing Elixir).charges>1||{player.spell(Healing Elixir).charges==1&player.spell(Healing Elixir).cooldown<3&!lastcast(Healing Elixir)}}&player.health<=UI(Healing Elixir)', 'player'},
	{'#127834', 'item(127834).count>0&player.health<UI(hs_hp)'},        -- Ancient Healing Potion
  {'#5512', 'item(5512).count>0&player.health<UI(ahp_hp)', 'player'},  --Health Stone
	{'Expel Harm', 'player.health<=UI(Expel Harm)&player.spell(Expel Harm).count>0', 'player'},
	{'Effuse', 'player.health<=UI(E_HP)&player.lastmoved>0&UI(kEffuse)', 'player'},
}

local Interrupts = {
	{'!Spear Hand Strike', 'interruptAt(70)&inMelee&inFront', 'target'},
	{'!Paralysis', 'interruptAt(70)&!immune(incapacitate)&range<21&player.energy>19&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'target'},
	{'!Ring of Peace', 'interruptAt(5)&advanced&range<40&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'target.ground'},
	{'!Leg Sweep', 'interruptAt(70)&!immune(stun)&inMelee&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'target'},
	{'!Quaking Palm', 'interruptAt(70)&!immune(incapacitate)&inMelee&inFront&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'target'},
}

local Interrupts_Random = {
	{'!Spear Hand Strike', 'interruptAt(70)&inFront&inMelee', 'enemies'},
	{'!Paralysis', 'interruptAt(70)&!immune(incapacitate)&range<21&player.energy>19&player.area(20).enemies>1&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'enemies'},
	{'!Ring of Peace', 'interruptAt(5)&advanced&range<40&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'enemies.ground'},
	{'!Leg Sweep', 'interruptAt(70)&!immune(stun)&inMelee&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastgcd(Spear Hand Strike)', 'enemies'},
	{'!Quaking Palm', 'interruptAt(70)&!immune(incapacitate)&inMelee&inFront&player.spell(Spear Hand Strike).cooldown>gcd&!player.lastcast(Spear Hand Strike)', 'enemies'},
}

local Artifact = {
	{'Exploding Keg', 'advanced&target.range<50&{{target.area(8).enemies>2}||{player.incdmg(5)>=health.max*0.70}}', 'target.ground'},
}

local Crackle = {
	{'Crackling Jade Lightning', '!player.moving&UI(e_cjl)&!target.inMelee'},
}

local xCombat = {
	{'Blackout Strike', 'target.inMelee&target.inFront&talent(7,2)&!player.buff(Blackout Combo)&{player.spell(Keg Smash).cooldown>3||player.spell(Keg Smash).cooldown<1.5}'},
	{'Keg Smash', 'target.range<25&target.inFront&talent(7,2)&{player.buff(Blackout Combo)||@Zylla.purifyingCapped}'},
	{'Keg Smash', 'target.range<25&target.inFront&!talent(7,2)'},
	{{
		{'Blackout Strike', 'target.inMelee&target.inFront&!player.buff(Blackout Combo)&talent(7,2)&player.area(10).enemies>0'},
		{'Breath of Fire', 'target.range<22&target.inFront&player.buff(Blackout Combo)&talent(7,2)&player.area(10).enemies>0'},
		{'Blackout Strike', 'target.inMelee&talent(7,2)&!player.buff(Blackout Combo)&{player.energy>35||player.spell(Keg Smash).cooldown>3}'},
		{'Tiger Palm', 'target.inMelee&target.inFront&talent(7,2)&player.buff(Blackout Combo)'},
		{'Blackout Strike', 'target.inMelee&target.inFront&'},
		{'Breath of Fire', 'target.range<22&target.inFront&target.debuff(Keg Smash)&!talent(7,2)&player.area(10).enemies>0'},
		{'Chi Burst', 'talent(1,1)&target.inFront&player.area(40).enemies>0'},
		{'Chi Wave', 'target.range<50&target.inFront&player.area(10).enemies>1', 'target.enemy'},
		{'Rushing Jade Wind', 'talent(6,1)&player.area(8).enemies>1'},
		{'Tiger Palm', 'target.inMelee&target.inFront&!talent(7,2)||{target.inMelee&target.inFront&player.energy>60&{player.energy>45||player.spell(Keg Smash).cooldown>3}}'},
	},	{'player.spell(Keg Smash).cooldown>=0.5||{!talent(7,2)&!player.buff(Blackout Combo)&player.spell(Keg Smash).cooldown>1&@Zylla.purifyingCapped}'}},
}

local inCombat = {
	{Artifact},
	{Keybinds},
	{Snares},
	{Dispel, 'toggle(dispels)&!player.spell(Detox).cooldown'},
	{Survival},
	{Interrupts, 'toggle(Interrupts)'},
	{Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)'},
	{Mitigations, 'target.inMelee&{!talent(7,2)||!player.buff(Blackout Combo)||player.spell(Keg Smash).cooldown>gcd}'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat},
	{Fel_Explosives, 'range<=5'},
	{Crackle, 'target.range>8&target.range<41&target.inFront'},
	{'Provoke', 'target.range<45&target.combat&target.threat<100&toggle(xTaunt)'},
}

local outCombat={
	{Keybinds},
	{'%ressdead(Resuscitate)', 'UI(auto_res)'},
	{'Effuse', 'UI(kEffuse)&player.health<90&player.lastmoved>0', 'player'},
}

NeP.CR:Add(268, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Brewmaster',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
