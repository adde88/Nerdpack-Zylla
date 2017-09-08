local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header',  size = 16, text = 'Keybinds',	 								align = 'center'},
	{type = 'text', 	 text = 'Left Shift: |cffABD473Pause|r',				align = 'center'},
	{type = 'text', 	 text = 'Left Ctrl: |cffABD473Tar Trap|r',			align = 'center'},
	{type = 'text', 	 text = 'Left Alt: |cffABD473Binding Shot|r',		align = 'center'},
	{type = 'text', 	 text = 'Right Alt: |cffABD473Freezing Trap|r',	align = 'center'},
	{type = 'ruler'},	 {type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',					align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',								 			key = 'kPause', 		default = true},
	{type = 'checkbox', text = 'Enable DBM Integration',						key = 'kDBM', 			default = true},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 				key = 'LJ',					spin = 4, step = 1, max = 20, check = true,	desc = '|cffABD473World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Summon Pet',									 			key = 'kPet', 			default = true},
	{type = 'checkbox', text = 'Barrage Enabled',							 			key = 'kBarrage', 	default = false},
	{type = 'checkbox', text = 'Volley Enabled',										key = 'kVolley', 		default = true},
	{type = 'checkbox', text = 'Misdirect Focus/Pet',								key = 'kMisdirect', default = true},
	{type = 'checkbox', text = 'Freezing Trap (Interrupt)' ,				key = 'FT_Int', 		default = false},
	{type = 'checkbox', text = 'Tarnished Sentinel Medallion',			key = 'e_TSM', 			default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 										key = 'trinket1',		default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 										key = 'trinket2', 	default = true,	desc = '|cffABD473Trinkets will be used whenever possible!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 		size = 16, text = 'Survival',								align = 'center'},
	{type = 'checkspin', 	text = 'Heal Pet below HP%', 								key = 'P_HP', 				spin = 75, check = true},
	{type = 'checkspin', 	text = 'Exhileration below HP%', 						key = 'E_HP', 				spin = 67, check = true},
	{type = 'checkspin',	text = 'Healthstone',												key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',										key = 'AHP',					spin = 45, check = true},
	{type = 'checkspin',	text = 'Aspect of the Turtle', 							key = 'AotT', 				spin = 20, check = true},
	{type = 'checkspin',	text = 'Feign Death (Legendary Healing) %',	key = 'FD',		 				spin = 16, check = true},
	{type = 'ruler'},		  {type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHunter |cffADFF2FBeast Mastery|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/1 - 3/X - 4/2 - 5/X - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xMisdirect',
		name = 'Misdirection',
		text = 'Automatically use Misdirection on current Focus-target or Pet.',
		icon = 'Interface\\Icons\\ability_hunter_misdirection',
	})

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
	{'Call Pet 1', '!pet.exists&UI(kPet)'},
	{'Volley', '{UI(kVolley)&toggle(aoe)&!player.buff(Volley)}||{{player.buff(Volley)&{!toggle(aoe)||!UI(kVolley)}}}'},
	{'%pause', 'player.buff(Feign Death)'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Binding Shot', 'keybind(lalt)', 'cursor.ground'},
	{'Tar Trap', 'keybind(lcontrol)', 'cursor.ground'},
	{'Freezing Trap', 'keybind(ralt)', 'cursor.ground'},
}

local Survival = {
	{'Exhilaration', 'player.health<=UI(E_HP_spin)&UI(E_HP_check)'},
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 						--Health Stone
	{'Aspect of the Turtle', 'player.health<=UI(AotT_spin)&UI(AotT_check)'},
	{'Feign Death', 'player.health<=UI(FD_spin)&UI(FD_check)&equipped(137064)'},
	{'%pause', 'player.buff(Feign Death)'},
}

local Cooldowns = {
	{'#147017', 'UI(e_TSM)&equipped(147017)'},	-- Tarnished Sentinel Medallion
	{'Bestial Wrath'},
	{'Titan\'s Thunder', '{player.buff(Bestial Wrath)||player.spell(Dire Beast).cooldown>35}||{player.spell(Dire Beast).cooldown>2||{player.buff(Bestial Wrath)&player.buff(Dire Beast)}}'},
	{'Aspect of the Wild', 'player.buff(Bestial Wrath)||target.time_to_die<12'},
	{'Blood Fury'},
	{'Berserking'},
	{'#Trinket1', 'UI(trinket1)'},
	{'#Trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Interrupts = {
	{'!Counter Shot', nil, 'target'},
	{'!Intimidation', 'player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&!immune(Stun)', 'target'},
	{'!Freezing Trap', 'UI(FT_Int)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)', 'target.ground'},
}

local Interrupts_Random = {
	{'!Counter Shot', '{channeling.percent(5)||interruptAt(70)}&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<41', 'enemies'},
	{'!Intimidation', '{channeling.percent(5)||interruptAt(70)}&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&inFront&range<41', 'enemies'},
	{'!Freezing Trap', '{channeling.percent(5)||interruptAt(5)}&UI(FT_Int)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&range<41', 'enemies.ground'},
}

local xCombat = {
	{'A Murder of Crows'},
	{'Stampede', '{player.buff(Bloodlust)||player.buff(Bestial Wrath)||player.spell(Bestial Wrath).cooldown<3}||target.time_to_die<24'},
	{'Dire Beast', 'player.spell(Bestial Wrath).cooldown>3', 'target'},
	{'Dire Frenzy', '{pet.buff(Dire Frenzy).duration<=gcd.max*1.2}||player.spell(Dire Frenzy).charges>0.8||target.ttd<9'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)&{target.area(15).enemies>1||{target.area(15).enemies==1&player.focus>90}}'},
	{'Multi-Shot', 'toggle(aoe)&target.area(10).enemies>4&{pet.buff(Beast Cleave).duration<gcd.max||!pet.buff(Beast Cleave)}'},
	{'Multi-Shot', 'toggle(aoe)&target.area(10).enemies>1&{pet.buff(Beast Cleave).duration<gcd.max*2||!pet.buff(Beast Cleave)}'},
	{'Chimaera Shot', 'player.focus<90'},
	{'Cobra Shot', '{player.spell(Kill Command).cooldown>focus.time_to_max&player.spell(Bestial Wrath).cooldown>focus.time_to_max}||{player.buff(Bestial Wrath)&focus.regen*player.spell(Kill Command).cooldown>action(Kill Command).cost}||target.time_to_die<player.spell(Kill Command).cooldown||{equipped(Parsel\'s Tongue)&player.buff(Parsel\'s Tongue).duration<=gcd.max*2}'},
	{'Volley', '{toggle(aoe)&!player.buff(Volley)}||{player.buff(Volley)&!toggle(aoe)}'},
}

local xPet = {
	{'Call Pet 1', '!pet.exists&UI(kPet)'},
	{'Mend Pet', 'pet.alive&pet.health<=UI(P_HP_spin)&UI(P_HP_check)&!pet.buff(Mend Pet)'},
		{{ 																			 																			-- Pet Dead
			{'Heart of the Phoenix', '!player.debuff(Weakened Heart)&player.combat'}, 	-- Heart of the Phoenix
			{'Revive Pet'} 																															-- Revive Pet
	}, {'pet.dead', 'UI(kPet)'}},
	{'&Kill Command', 'alive&combat&pet.exists&pet.alive&{{talent(4,3)&petrange<31}||!talent(4,3)&petrange<10}', 'target'},
	{'/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'player.spell(Misdirection).cooldown<gcd&UI(kDBM)&toggle(xMisdirect)&{player.combat||{!player.combat&dbm(pull in)<3}}'},
	{'/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'player.spell(Misdirection).cooldown<gcd&!UI(kDBM)&toggle(xMisdirect)&player.combat'},
}

local xPvP = {
	{'Gladiator\'s Medallion', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Adaptation', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Viper Sting', 'range<41&health<80', 'target'},
	{'Scorpid Sting', 'inMelee', 'target'},
	{'Spider Sting', 'range<41', 'target'},
	{'Dire Beast: Hawk', 'range<41', 'target.ground'},
	{'Dire Beast: Basilisk', 'range<41', 'target.ground'},
	{'Interlope', 'range<41'},
}

local inCombat = {
	{Keybinds},
	{Survival},
	{Interrupts_Random},
	{Interrupts, '{channeling.percent(5)||interruptAt(70)}&toggle(Interrupts)&inFront&range<41'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Fel_Explosives, 'range<41'},
	{xCombat, 'target.range<41&target.inFront'},
	{xPet},
	{xPvP},
}

local outCombat = {
	{xPet},
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, '{channeling.percent(5)||interruptAt(70)}&toggle(Interrupts)&inFront&range<41'},
}

NeP.CR:Add(253, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Beast Mastery',
	waitfor = true,
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='760', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
	--blacklist = Zylla.blacklist
})
