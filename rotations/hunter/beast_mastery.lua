local _, Zylla = ...

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Tar Trap|r',			align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Binding Shot|r',	align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'Freezing Trap|r',align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and flasks',								key = 'prepot', 			default = false},
	{type = 'combo',		default = "1",																						key = "list", 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Summon Pet',									 										key = 'kPet', 				default = true},
	{type = 'checkbox', text = 'Barrage Enabled',							 										key = 'kBarrage', 		default = false},
	{type = 'checkbox', text = 'Volley Enabled',																	key = 'kVolley', 			default = true},
	{type = 'checkbox', text = 'Misdirect Focus/Pet',															key = 'kMisdirect', 	default = true},
	{type = 'checkbox', text = 'Freezing Trap (Interrupt)' ,											key = 'FT_Int', 			default = false},
	{type = 'checkbox', text = 'Tarnished Sentinel Medallion',										key = 'e_TSM', 				default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',			default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 		default = true, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',															align = 'center'},
	{type = 'checkspin',text = 'Heal Pet below HP%', 															key = 'P_HP', 				spin = 75, check = true},
	{type = 'checkspin',text = 'Exhileration below HP%', 													key = 'E_HP', 				spin = 67, check = true},
	{type = 'checkspin',text = 'Healthstone',																			key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',text = 'Healing Potion',																	key = 'AHP',					spin = 45, check = true},
	{type = 'checkspin',text = 'Aspect of the Turtle', 														key = 'AotT', 				spin = 20, check = true},
	{type = 'checkspin',text = 'Feign Death (Legendary Healing) %',								key = 'FD',		 				spin = 16, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
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
	{'Call Pet 1', '!pet.exists&UI(kPet)', 'player'},
	{'Volley', '{UI(kVolley)&toggle(aoe)&!buff}||{{buff&{!toggle(aoe)||!UI(kVolley)}}}', 'player'},
	{'%pause', 'player.buff(Feign Death)'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3', 'player'}, 	--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3', 'player'}, 	--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3', 'player'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)', 'player'},	--XXX: Flask of the Seventh Demon
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'Binding Shot', 'keybind(lalt)&UI(lalt)', 'cursor.ground'},
	{'Tar Trap', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
	{'Freezing Trap', 'keybind(ralt)&UI(ralt)', 'cursor.ground'},
}

local Survival = {
	{'Exhilaration', 'player.health<=UI(E_HP_spin)&UI(E_HP_check)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 													-- Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 																	-- Health Stone
	{'Aspect of the Turtle', 'health<=UI(AotT_spin)&UI(AotT_check)', 'player'},
	{'Feign Death', 'health<=UI(FD_spin)&UI(FD_check)&equipped(137064)', 'player'},
	{'%pause', 'player.buff(Feign Death)'},
}

local Cooldowns = {
	{'#147017', 'UI(e_TSM)&equipped(147017)'},	-- Tarnished Sentinel Medallion
	{'!Bestial Wrath', nil, 'player'},
	{'Titan\'s Thunder', '{buff(Bestial Wrath)||spell(Dire Beast).cooldown>35}||{spell(Dire Beast).cooldown>2||{buff(Bestial Wrath)&buff(Dire Beast)}}', 'player'},
	{'Aspect of the Wild', 'buff(Bestial Wrath)||target.ttd<12', 'player'},
	{'Blood Fury'},
	{'Berserking'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Interrupts = {
	{'!Counter Shot', nil, 'target'},
	{'!Intimidation', 'player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&!immune(Stun)', 'target'},
	{'!Freezing Trap', 'UI(FT_Int)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)', 'target.ground'},
}

local Interrupts_Random = {
	{'!Counter Shot', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<41', 'enemies'},
	{'!Intimidation', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&inFront&range<41', 'enemies'},
	{'!Freezing Trap', 'interruptAt(5)&UI(FT_Int)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&range<41', 'enemies.ground'},
}

local xCombat = {
	{'A Murder of Crows', 'inFront', 'target'},
	{'Stampede', 'inFront&{{player.buff(Bloodlust)||player.buff(Bestial Wrath)||player.spell(Bestial Wrath).cooldown<3}||ttd<24}', 'target'},
	{'Dire Beast', 'player.spell(Bestial Wrath).cooldown>3', 'target'},
	{'Dire Frenzy', '{pet.buff(Dire Frenzy).duration<=gcd.max*1.2}||player.spell(Dire Frenzy).charges>0.8||target.ttd<9'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)&{player.area(15).enemies.infront>1||{player.area(15).enemies.infront==1&player.focus>90}}', 'target'},
	{'Multi-Shot', 'inFront&toggle(aoe)&area(10).enemies>=5&{pet.buff(Beast Cleave).duration<gcd.max||!pet.buff(Beast Cleave)}', 'target'},
	{'Multi-Shot', 'inFront&toggle(aoe)&area(10).enemies>=2&{pet.buff(Beast Cleave).duration<gcd.max*2||!pet.buff(Beast Cleave)}', 'target'},
	{'Chimaera Shot', 'inFront&player.focus<90'},
	{'Cobra Shot', 'inFront&{{player.spell(Kill Command).cooldown>focus.time_to_max&player.spell(Bestial Wrath).cooldown>focus.time_to_max}||{player.buff(Bestial Wrath)&focus.regen*player.spell(Kill Command).cooldown>action(Kill Command).cost}||ttd<player.spell(Kill Command).cooldown||{equipped(Parsel\'s Tongue)&player.buff(Parsel\'s Tongue).duration<=gcd.max*2}}', 'target'}
}

local xPet = {
	{'Call Pet 1', '!pet.exists&UI(kPet)'},
	{'Mend Pet', 'pet.alive&pet.health<=UI(P_HP_spin)&UI(P_HP_check)&!pet.buff(Mend Pet)'},
		{{ 																			 																			-- Pet Dead
			{'Heart of the Phoenix', '!player.debuff(Weakened Heart)&player.combat'}, 	-- Heart of the Phoenix
			{'Revive Pet'} 																															-- Revive Pet
	}, {'pet.dead', 'UI(kPet)'}},
	{'&Kill Command', 'alive&combat&pet.exists&pet.alive', 'target'},
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
	{'Volley', '{UI(kVolley)&toggle(aoe)&!buff}||{{buff&{!toggle(aoe)||!UI(kVolley)}}}', 'player'},
	{Keybinds},
	{Survival},
	{Interrupts_Random},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)&inFront&range<41'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'range<41'},
	{xCombat, 'range<41'},
	{xPet},
	{xPvP},
}

local outCombat = {
	{xPet},
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)&inFront&range<41'},
}

NeP.CR:Add(253, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Beast Mastery',
	pooling = true,
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
