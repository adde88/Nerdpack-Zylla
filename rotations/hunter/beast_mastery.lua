local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Tar Trap|r',			align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Binding Shot|r',	align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'Freezing Trap|r',align = 'left', 			key = 'ralt', 		default = true},
	{type = 'checkbox', size = 10, text = Zylla.ClassColor..'Use Call Pet                                  Select Pet: |r',		align = 'right', 	key = 'epets', 		default = true},
	{type = 'combo',		default = '1',																						key = 'pets', 				list = Zylla.pets, 	width = 50},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'target',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',	key = 'prepot', 			default = false},
	{type = 'checkbox', text = 'Force Pet Assist',																key = 'passist', 			default = true},
	{type = 'combo',		default = '1',																						key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Barrage Enabled',							 										key = 'kBarrage', 		default = false},
	{type = 'checkbox', text = 'Volley Enabled',																	key = 'kVolley', 			default = true},
	{type = 'checkbox', text = 'Freezing Trap (Interrupt)' ,											key = 'FT_Int', 			default = false},
	{type = 'checkbox', text = 'Tarnished Sentinel Medallion',										key = 'e_TSM', 				default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 					key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',															align = 'center'},
	{type = 'checkspin',text = 'Mend Pet', 																				key = 'P_HP', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 75, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Exhileration', 																		key = 'E_HP', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 67, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healthstone',																			key = 'HS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																	key = 'AHP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Aspect of the Turtle', 														key = 'AotT', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 20, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Feign Death (Legendary Healing)',									key = 'FD',		 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 16, max = 100, min = 1, check = true},
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

local CallPet = {
	{'Call Pet 1', 'UI(pets)==1'},
	{'Call Pet 2', 'UI(pets)==2'},
	{'Call Pet 3', 'UI(pets)==3'},
	{'Call Pet 4', 'UI(pets)==4'},
	{'Call Pet 5', 'UI(pets)==5'}
}

local xPvP = {
	{'Gladiator\'s Medallion', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Adaptation', 'state(incapacitate)||state(stun)||state(fear)||state(horror)||state(sleep)||state(charm)', 'player'},
	{'Viper Sting', 'range<=40&health<80'},
	{'Scorpid Sting', 'inMelee'},
	{'Spider Sting', 'range<=40'},
	{'Dire Beast: Hawk', 'advanced&range<=40', 'target.ground'},
	{'Dire Beast: Basilisk', 'advanced&range<=40', 'target.ground'},
	{'Interlope', 'range<=40&petrange<=10'},
}

local PreCombat = {
	{CallPet, '!pet.exists'},
	{'Volley', '{UI(kVolley)&toggle(aoe)&!buff}||{{buff&{!toggle(aoe)||!UI(kVolley)}}}'},
	{'%pause', 'player.buff(Feign Death)||player.buff(Shadowmeld)'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'ingroup&item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},				--XXX: Lightforged Augment Rune
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'Binding Shot', 'keybind(lalt)&UI(lalt)', 'cursor.ground'},
	{'Tar Trap', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
	{'Freezing Trap', 'keybind(ralt)&UI(ralt)', 'cursor.ground'},
}

local Survival = {
	{'Exhilaration', 'health<=UI(E_HP_spin)&UI(E_HP_check)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
	{'Aspect of the Turtle', 'health<=UI(AotT_spin)&UI(AotT_check)'},
	{'Feign Death', 'health<=UI(FD_spin)&UI(FD_check)&equipped(137064)'},
	{'%pause', 'buff(Feign Death)||player.buff(Shadowmeld)'},
}

local Cooldowns = {
	{'!Bestial Wrath', nil, 'player'},
	{'Titan\'s Thunder', '{buff(Bestial Wrath)||spell(Dire Beast).cooldown>35}||{spell(Dire Beast).cooldown>2||{buff(Bestial Wrath)&buff(Dire Beast)}}', 'player'},
	{'Aspect of the Wild', 'buff(Bestial Wrath)&target.ttd>12', 'player'},
	{'Blood Fury', nil, 'player'},
	{'Berserking', nil, 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)', 'target'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Interrupts = {
	{'&Counter Shot', 'inFront'},
	{'!Intimidation', 'spell(Counter Shot).cooldown>gcd&!player.lastgcd(Counter Shot)&inFront'},
	{'!Freezing Trap', 'advanced&UI(FT_Int)&interruptAt(5)&spell(Counter Shot).cooldown>gcd&!player.lastgcd(Counter Shot)', 'target.ground'},
	{'!Freezing Trap', 'advanced&toggle(xIntRandom)&UI(FT_Int)&interruptAt(5)&spell(Counter Shot).cooldown>gcd&!player.lastgcd(Counter Shot)', 'enemies.ground'},
}

local xCombat = {
	{'A Murder of Crows', 'inFront'},
	{'Stampede', 'inFront&ttd>24&{player.buff(Bloodlust)||player.buff(Bestial Wrath)||spell(Bestial Wrath).cooldown<3}'},
	{'Dire Beast', 'spell(Bestial Wrath).cooldown>3'},
	{'Dire Frenzy', 'pet.buff(Dire Frenzy).duration<=gcd.max*1.2||spell(Dire Frenzy).charges>0.8'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)&{player.area(15).enemies.inFront>=2||{player.area(15).enemies.inFront==1&player.focus>90}}'},
	{'Multi-Shot', 'inFront&toggle(aoe)&area(10).enemies>=5&{pet.buff(Beast Cleave).duration<gcd.max||!pet.buff(Beast Cleave)}'},
	{'Multi-Shot', 'inFront&toggle(aoe)&area(10).enemies>=2&{pet.buff(Beast Cleave).duration<gcd.max*2||!pet.buff(Beast Cleave)}'},
	{'Chimaera Shot', 'inFront&player.focus<90'},
	{'&Kill Command', '{alive&combat||isdummy}&pet.exists&pet.alive'},
	{'Cobra Shot', 'inFront&{{spell(Kill Command).cooldown>focus.time_to_max&spell(Bestial Wrath).cooldown>focus.time_to_max}||{player.buff(Bestial Wrath)&focus.regen*spell(Kill Command).cooldown>action(Kill Command).cost}||ttd<spell(Kill Command).cooldown||{equipped(Parsel\'s Tongue)&player.buff(Parsel\'s Tongue).duration<=gcd.max*2}}'},
	{xPvP},
	{'&#147017', 'UI(e_TSM)&equipped(147017)&toggle(cooldowns)'}	--XXX: Tarnished Sentinel Medallion
}

local xPet = {
	{CallPet, '!pet.exists'},
	{'Mend Pet', 'pet.alive&pet.health<=UI(P_HP_spin)&UI(P_HP_check)&!pet.buff(Mend Pet)'},
		{{ 																			 																			--XXX: Pet Dead
			{'Heart of the Phoenix', '!player.debuff(Weakened Heart)&player.combat'}, 	--XXX: Heart of the Phoenix
			{'Revive Pet', 'player.debuff(Weakened Heart)'} 														--XXX: Revive Pet
	}, 'pet.dead&UI(kPet)'},
	{'&/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'spell(Misdirection).cooldown<gcd&UI(kDBM)&toggle(xMisdirect)&{player.combat||{!player.combat&dbm(pull in)<3}}'},
	{'&/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'spell(Misdirection).cooldown<gcd&!UI(kDBM)&toggle(xMisdirect)&player.combat'},
}

local inCombat = {
	{(function() _G.RunMacroText('/petassist\n/petattack') print('Pet set to Assist')	_G.Zylla.PetMode = 1 end), (function() if _G.Zylla.PetMode == 0 and NeP.Condition:Get('UI')(nil, 'passist') then return true end end)},
	{'Volley', '{UI(kVolley)&toggle(aoe)&!buff}||{{buff&{!toggle(aoe)||!UI(kVolley)}}}', 'player'},
	{Keybinds},
	{Survival, nil, 'player'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)&range<=40', 'enemies'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&range<=40', 'target'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'range<=40'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.Condition:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{xPet}
}

local outCombat = {
	{xPet},
	{Keybinds},
	{PreCombat, nil, 'player'},
}

NeP.CR:Add(253, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Beast Mastery',
	pooling = true,
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
	--blacklist = Zylla.blacklist
})
