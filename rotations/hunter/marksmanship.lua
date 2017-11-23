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
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
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
	{type = 'combo',		default = '3',																						key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Barrage Enabled',																	key = 'kBarrage',			default = false},
  {type = 'checkbox', text = 'Volley Enabled',																	key = 'kVolley',			default = true},
	{type = 'checkbox', text = 'Misdirect Focus/Pet', 														key = 'kMisdirect',		default = true},
	{type = 'ruler'},		{type = 'spacer'},
  -- Survival
	{type = 'header', 	size = 16, text = 'Survival:',														align = 'center'},
	{type = 'spinner', 	text = 'Exhileration below HP%',													key = 'E_HP',					default = 67},
	{type = 'spinner',	text = 'Healthstone or Healing Potions',									key = 'Health Stone',	default = 45},
	{type = 'spinner',	text = 'Aspect of the Turtle',														key = 'AotT',         default = 21},
	{type = 'spinner',	text = 'Feign Death (Legendary Healing) %',								key = 'FD',						default = 16},
  {type = 'ruler'},	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHunter |cffADFF2FMarksmanship |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/X - 4/3 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

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

local PreCombat = {
	{CallPet, '!pet.exists&UI(kPets)'},
	{'Volley', '{toggle(aoe)&!buff}||{buff&!toggle(aoe)}'},
	{'%pause', 'player.buff(Feign Death)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Binding Shot', 'keybind(lalt)', 'cursor.ground'},
	{'!Tar Trap', 'keybind(lcontrol)', 'cursor.ground'},
	{'!Freezing Trap', 'keybind(ralt)', 'cursor.ground'},
}

local Survival = {
	{'Exhilaration', 'player.health<UI(E_HP)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
	{'Aspect of the Turtle', 'player.health<UI(AotT)'},
	{'Feign Death', 'player.health<UI(FD)&equipped(137064)'},
}

local Cooldowns = {
	{'Trueshot', 'xtime<5||player.buff(Bloodlust)||ttd>={180-artifact(Quick Shot).rank*10+15}||player.buff(Bullseye).stack>25||ttd<16', 'player'},
	{'Blood Fury', 'buff(Trueshot)', 'player'},
	{'Berserking', 'buff(Trueshot)', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Interrupts = {
	{'!Counter Shot'},
}

local TargetDie = {
	{'Marked Shot', 'toggle(aoe)'},
	{'Windburst', '!player.moving'},
	{'Aimed Shot', '!player.moving&debuff(Vulnerable).remains>action(Aimed Shot).execute_time&ttd>action(Aimed Shot).execute_time'},
	{'Sidewinders', 'toggle(aoe)'},
	{'Aimed Shot', '!player.moving||'},
	{'Arcane Shot'},
}

local TrueshotAoE = {
	{'Marked Shot', 'toggle(aoe)'},
	{'Barrage', 'toggle(aoe)&!talent(4,3)&UI(kBarrage)'},
	{'Piercing Shot', 'toggle(aoe)'},
	{'Explosive Shot', 'toggle(aoe)&area(8).enemies>2&range<10'},
	{'Aimed Shot', '!player.moving&{!talent(4,3)||talent(7,3)}&area(8).enemies==1&player.buff(Lock and Load)&action(Aimed Shot).execute_time<debuff(Vulnerable).remains'},
	{'Multi-Shot', 'toggle(aoe)'},
}

local Non_Patient_Sniper = {
	{'Windburst', '!player.moving'},
	{'Piercing Shot', 'player.focus>90&area(8).enemies>2&debuff(Vulnerable).duration<3'},
	{'Sentinel', '!debuff(Hunter\'s Mark)&player.focus>30&!player.buff(Trueshot)'},
	{'Sidewinders', 'toggle(aoe)&debuff(Vulnerable).remains<gcd&xtime>6'},
	{'Aimed Shot', '!player.moving&player.buff(Lock and Load)&player.area(50).enemies.inFront<3'},
	{'Marked Shot', 'toggle(aoe)'},
	{'Explosive Shot', 'area(8).enemies>2&range<10'},
	{'Sidewinders', 'toggle(aoe)&{{{player.buff(Marking Targets)||player.buff(Trueshot)}&player.focus.deficit>70}||action(Sidewinders).charges>0.9}'},
	{'Arcane Shot', '!variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
	{'Multi-Shot', 'variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
	{'Aimed Shot', '!player.moving&!talent(7,2)||{talent(7,2)&spell(Piercing Shot).cooldown>3}'},
	{'Arcane Shot', '!variable.use_multishot'},
	{'Multi-Shot', 'variable.use_multishot'},
}

local Opener = {
	{'A Murder of Crows'},
	{'True Shot', 'xtime>5'},
	{'Piercing Shot', 'debuff(Vulnerable).duration<3||area(8).enemies>2'},
	{'Explosive Shot', 'toggle(aoe)&area(8).enemies>2&range<10'},
	{'Arcane Shot', 'line_cd(Arcane Shot)>16&!talent(4,3)'},
	{'Sidewinders', 'toggle(aoe)&{{!player.buff(Marking Targets)&player.buff(Trueshot).remains<2}||{Action(Sidewinders).charges>0.9&player.focus<80}}'},
	{'Sidewinders', 'toggle(aoe)'},
	{'Barrage', 'toggle(aoe)&player.buff(Bloodlust)&UI(kBarrage)'},
	{'Barrage', 'toggle(aoe)&!talent(4,3)&UI(kBarrage)'},
	{'Aimed Shot', '!player.moving&{player.buff(Lock and Load)&action(Aimed Shot).execute_time<debuff(Vulnerable).remains}||player.focus>90&!talent(4,3)&talent(7,3)'},
	{'Aimed Shot', '!player.moving&player.buff(Lock and Load)&action(Aimed Shot).execute_time<debuff(Vulnerable).remains'},
	{'Aimed Shot', '!player.moving&action(Aimed Shot).execute_time<debuff(Vulnerable).remains'},
	{'Aimed Shot', '!player.moving'},
	{'Black Arrow'},
	{'Marked Shot', 'toggle(aoe)'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)'},
	{'Arcane Shot'},
}

local Patient_Sniper = {
	{'Marked Shot', '{talent(7,1)&talent(6,2)&player.area(50).enemies.inFront>2}||debuff(Hunter\'s Mark).remains<2||{{debuff(Vulnerable)||talent(7,1)}&debuff(Vulnerable).remains<gcd)}'},
	{'Windburst', 'talent(7,1)&{!debuff(Hunter\'s Mark)||{debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&player.focus+{focus.regen*debuff(Hunter\'s Mark).remains}>40}}||player.buff(Trueshot)'},
	{'Sidewinders', 'toggle(aoe)&player.buff(Trueshot)&{{!player.buff(Marking Targets&player.buff(Trueshot).remains<2)}||{action(Sidewinders).charges>0.9&{focus.deficit>70||player.area(50).enemies.inFront>1}}}'},
	{'Multi-Shot', 'toggle(aoe)&player.buff(Marking Targets)&!debuff(Hunter\'s Mark)&variable.use_multishot&player.focus.deficit>2*area(8).enemies+gcd*focus.regen'},
	{'Aimed Shot', '!player.moving&player.buff(Lock and Load)&player.buff(Trueshot)&debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
	{'Marked Shot', 'player.buff(Trueshot)&!talent(7,1)'},
	{'Arcane Shot', 'player.buff(Trueshot)'},
	{'Aimed Shot', '!player.moving&!debuff(Hunter\'s Mark)&debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
	{'Aimed Shot', '!player.moving&talent(7,1)&debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.focus+debuff(Hunter\'s Mark).remains*focus.regen>70&player.focus+focus.regen*debuff(Vulnerable).remains>70}}&{!talent(7,2)||{talent(7,2)&spell(Piercing Shot).cooldown>5}||player.focus>120}'},
	{'Aimed Shot', '!player.moving&!talent(7,1)&debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.buff(Trueshot)&player.focus>70}||{!player.buff(Trueshot)&player.focus+debuff(Hunter\'s Mark).remains*focus.regen>70&player.focus+focus.regen*debuff(Vulnerable).remains>70}}&{!talent(7,2)||{talent(7,2)&spell(Piercing Shot).cooldown>5}||player.focus>120}'},
	{'Windburst', '!player.moving&!talent(7,1)&player.focus>80{!debuff(Hunter\'s Mark)||{debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&player.focus+{focus.regen*debuff(Hunter\'s Mark).remains}>40}}'},
	{'Marked Shot', '{talent(7,1)&player.area(50).enemies.inFront>1}||focus.deficit<50||player.buff(Trueshot)||{player.buff(Marking Targets)&{!talent(7,1)||spell(Sidewinders).charges>0.2}}'},
	{'Piercing Shot', 'player.focus>80&area(8).enemies>2&debuff(Vulnerable).duration<3'},
	{'Sidewinders', 'toggle(aoe)&variable.safe_to_build&{{player.buff(Trueshot)&player.focus.deficit>70}||action(Sidewinders).charges>0.9}'},
	{'Sidewinders', 'toggle(aoe)&{player.buff(Marking Targets)&!debuff(Hunter\'s Mark)&!player.buff(Trueshot)}||{spell(Sidewinders).charges>1&ttd<11}'},
	{'Arcane Shot', 'variable.safe_to_build&!variable.use_multishot&player.focus.deficit>5+gcd*focus.regen'},
	{'Multi-Shot', 'toggle(aoe)&variable.safe_to_build&variable.use_multishot&player.focus.deficit>2*area(8).enemies+gcd*focus.regen'},
	{'Aimed Shot', '!player.moving&!debuff(Vulnerable)&player.focus>80&spell(Windburst).cooldown>focus.time_to_max'},
}

 local xCombat = {
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&inFront&range<51'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)&inFront&range<51', 'enemies'},
	{'Volley', '{toggle(aoe)&!buff}||{buff&!toggle(aoe)}', 'player'},
	{'Aimed Shot', 'player.moving&player.buff(Gyroscopic Stabilization)'},
	{'Arcane Torrent', 'focus.deficit>30&{!talent(7,1)||spell(Sidewinders).charges<2}'},
	{Opener, 'player.area(50).enemies==1&xtime<25'},
	{'A Murder of Crows', '{ttd>65||health<20&boss}&{!debuff(Hunter\'s Mark)||{debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&debuff(Vulnerable).remains>action(A Murder of Crows).execute_time&player.focus+{focus.regen*debuff(Vulnerable).remains}>50&player.focus+{focus.regen*debuff(Hunter\'s Mark).remains}>50}}'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{TrueshotAoE, '{ttd>={180-artifact(Quick Shot).rank*10+15}||health<20&boss}&{!debuff(Hunter\'s Mark)||{debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&debuff(Vulnerable).remains>action(A Murder of Crows).execute_time&player.focus+{focus.regen*debuff(Vulnerable).remains}>50&player.focus+{focus.regen*debuff(Hunter\'s Mark).remains}>50}}'},
	{'Black Arrow', '!debuff(Hunter\'s Mark)||{debuff(Hunter\'s Mark).remains>action(Black Arrow).execute_time&debuff(Vulnerable).remains>action(Black Arrow).execute_time&player.focus+{focus.regen*debuff(Vulnerable).remains}>60&player.focus+{focus.regen*debuff(Hunter\'s Mark).remains}>60}}'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)&{area(15).enemies>1||{area(15).enemies==1&player.focus>90}}'},
	{TargetDie},
	{Patient_Sniper, 'talent(4,3)'},
	{Non_Patient_Sniper, '!talent(4,3)'},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'range<51'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{xPet, 'UI(kPet)&!talent(1,1)'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(254, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Marksmanship',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
