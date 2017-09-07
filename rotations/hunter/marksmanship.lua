local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', 	text = 'Keybinds',								align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause',						align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Tar Trap',					align = 'center'},
	{type = 'text', 	text = 'Left Alt: Binding Shot',				align = 'center'},
	{type = 'text', 	text = 'Right Alt: Freezing Trap',				align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',						align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',							key = 'kPause',			default = true},
	{type = 'checkbox', text = 'Summon Pet',							key = 'kPet',			default = false},
	{type = 'checkbox', text = 'Barrage Enabled',						key = 'kBarrage',		default = false},
   	{type = 'checkbox', text = 'Volley Enabled',						key = 'kVolley',		default = true},
	{type = 'checkbox', text = 'Misdirect Focus/Pet', 					key = 'kMisdirect',		default = true},
	{type = 'ruler'},	{type = 'spacer'},
  	-- Survival
	{type = 'header', 	text = 'Survival',								align = 'center'},
	{type = 'spinner', 	text = 'Exhileration below HP%',				key = 'E_HP',			default = 67},
	{type = 'spinner',	text = 'Healthstone or Healing Potions',		key = 'Health Stone',	default = 45},
	{type = 'spinner',	text = 'Aspect of the Turtle',					key = 'AotT',           default = 21},
	{type = 'spinner',	text = 'Feign Death (Legendary Healing) %',		key = 'FD',				default = 16},
  	{type = 'ruler'},	{type = 'spacer'},
	unpack(Mythic_GUI),
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

local PreCombat = {
	{'/cast Call Pet 1', '!pet.exists&UI(kPet)'},
	{'Heart of the Phoenix', '!player.debuff(Weakened Heart)&pet.dead&UI(kPet)'},
	{'Revive Pet', 'pet.dead&UI(kPet)'},
	{'Volley', '{toggle(aoe)&!player.buff(Volley)}||{player.buff(Volley)&!toggle(aoe)}'},
	{'%pause', 'player.buff(Feign Death)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Binding Shot', 'keybind(lalt)', 'cursor.ground'},
	{'!Tar Trap', 'keybind(lcontrol)', 'cursor.ground'},
	{'!Freezing Trap', 'keybind(ralt)', 'cursor.ground'},
}

local Survival = {
	{'Exhilaration', 'player.health<UI(E_HP)'},
	{'#127834', 'item(127834).count>0&player.health<UI(Health Stone)'},        -- Ancient Healing Potion
	{'#5512', 'item(5512).count>0&player.health<UI(Health Stone)', 'player'},  --Health Stone
	{'Aspect of the Turtle', 'player.health<UI(AotT)'},
	{'Feign Death', 'player.health<UI(FD)&equipped(137064)'},
}

local Cooldowns = {
	{'Trueshot', 'xtime<5||player.buff(Bloodlust)||target.time_to_die>={180-artifact(Quick Shot).rank*10+15}||player.buff(Bullseye).stack>25||target.time_to_die<16'},
	{'Blood Fury', 'player.buff(Trueshot)'},
	{'Berserking', 'player.buff(Trueshot)'},
}

local Interrupts_Normal = {
	{'!Counter Shot'},
}

local Interrupts_Random = {
	{'!Counter Shot', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<51', 'enemies'},
}

local TargetDie = {
	{'Marked Shot', 'toggle(aoe)'},
	{'Windburst', '!moving'},
	{'Aimed Shot', '!moving&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&target.time_to_die>action(Aimed Shot).execute_time'},
	{'Sidewinders', 'toggle(aoe)'},
	{'Aimed Shot', '!moving||'},
	{'Arcane Shot'},
}

local TrueshotAoE = {
	{'Marked Shot', 'toggle(aoe)'},
	{'Barrage', 'toggle(aoe)&!talent(4,3)&UI(kBarrage)'},
	{'Piercing Shot', 'toggle(aoe)'},
	{'Explosive Shot', 'toggle(aoe)&target.area(8).enemies>2&target.range<10'},
	{'Aimed Shot', '!moving&{!talent(4,3)||talent(7,3)}&target.area(8).enemies==1&player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
	{'Multi-Shot', 'toggle(aoe)'},
}

local Non_Patient_Sniper = {
	{'Windburst', '!moving'},
	{'Piercing Shot', 'player.focus>90&target.area(8).enemies>2&target.debuff(Vulnerable).duration<3'},
	{'Sentinel', '!target.debuff(Hunter\'s Mark)&player.focus>30&!player.buff(Trueshot)'},
	{'Sidewinders', 'toggle(aoe)&target.debuff(Vulnerable).remains<gcd&xtime>6'},
	{'Aimed Shot', '!moving&player.buff(Lock and Load)&player.area(50).enemies.inFront<3'},
	{'Marked Shot', 'toggle(aoe)'},
	{'Explosive Shot', 'target.area(8).enemies>2&target.range<10'},
	{'Sidewinders', 'toggle(aoe)&{{{player.buff(Marking Targets)||player.buff(Trueshot)}&focus.deficit>70}||action(Sidewinders).charges>0.9}'},
	{'Arcane Shot', '!variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
	{'Multi-Shot', 'variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
	{'Aimed Shot', '!moving&!talent(7,2)||{talent(7,2)&player.spell(Piercing Shot).cooldown>3}'},
	{'Arcane Shot', '!variable.use_multishot'},
	{'Multi-Shot', 'variable.use_multishot'},
}

local Opener = {
	{'A Murder of Crows'},
	{'True Shot', 'xtime>5'},
	{'Piercing Shot', 'target.debuff(Vulnerable).duration<3||target.area(8).enemies>2'},
	{'Explosive Shot', 'toggle(aoe)&target.area(8).enemies>2&target.range<10'},
	{'Arcane Shot', 'line_cd(Arcane Shot)>16&!talent(4,3)'},
	{'Sidewinders', 'toggle(aoe)&{{!player.buff(Marking Targets)&player.buff(Trueshot).remains<2}||{Action(Sidewinders).charges>0.9&player.focus<80}}'},
	{'Sidewinders', 'toggle(aoe)'},
	{'Barrage', 'toggle(aoe)&player.buff(Bloodlust)&UI(kBarrage)'},
	{'Barrage', 'toggle(aoe)&!talent(4,3)&UI(kBarrage)'},
	{'Aimed Shot', '!moving&{player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains}||player.focus>90&!talent(4,3)&talent(7,3)'},
	{'Aimed Shot', '!moving&player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
	{'Aimed Shot', '!moving&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
	{'Aimed Shot', '!moving'},
	{'Black Arrow'},
	{'Marked Shot', 'toggle(aoe)'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)'},
	{'Arcane Shot'},
}

local Patient_Sniper = {
	{'Marked Shot', '{talent(7,1)&talent(6,2)&player.area(50).enemies.inFront>2}||target.debuff(Hunter\'s Mark).remains<2||{{target.debuff(Vulnerable)||talent(7,1)}&target.debuff(Vulnerable).remains<gcd)}'},
	{'Windburst', 'talent(7,1)&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>40}}||player.buff(Trueshot)'},
	{'Sidewinders', 'toggle(aoe)&player.buff(Trueshot)&{{!player.buff(Marking Targets&player.buff(Trueshot).remains<2)}||{action(Sidewinders).charges>0.9&{focus.deficit>70||player.area(50).enemies.inFront>1}}}'},
	{'Multi-Shot', 'toggle(aoe)&player.buff(Marking Targets)&!target.debuff(Hunter\'s Mark)&variable.use_multishot&focus.deficit>2*target.area(8).enemies+gcd*focus.regen'},
	{'Aimed Shot', '!moving&player.buff(Lock and Load)&player.buff(Trueshot)&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
	{'Marked Shot', 'player.buff(Trueshot)&!talent(7,1)'},
	{'Arcane Shot', 'player.buff(Trueshot)'},
	{'Aimed Shot', '!moving&!target.debuff(Hunter\'s Mark)&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
	{'Aimed Shot', '!moving&talent(7,1)&target.debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.focus+target.debuff(Hunter\'s Mark).remains*focus.regen>70&player.focus+focus.regen*target.debuff(Vulnerable).remains>70}}&{!talent(7,2)||{talent(7,2)&player.spell(Piercing Shot).cooldown>5}||player.focus>120}'},
	{'Aimed Shot', '!moving&!talent(7,1)&target.debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.buff(Trueshot)&player.focus>70}||{!player.buff(Trueshot)&player.focus+target.debuff(Hunter\'s Mark).remains*focus.regen>70&player.focus+focus.regen*target.debuff(Vulnerable).remains>70}}&{!talent(7,2)||{talent(7,2)&player.spell(Piercing Shot).cooldown>5}||player.focus>120}'},
	{'Windburst', '!moving&!talent(7,1)&player.focus>80{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>40}}'},
	{'Marked Shot', '{talent(7,1)&player.area(50).enemies.inFront>1}||focus.deficit<50||player.buff(Trueshot)||{player.buff(Marking Targets)&{!talent(7,1)||player.spell(Sidewinders).charges>0.2}}'},
	{'Piercing Shot', 'player.focus>80&target.area(8).enemies>2&target.debuff(Vulnerable).duration<3'},
	{'Sidewinders', 'toggle(aoe)&variable.safe_to_build&{{player.buff(Trueshot)&focus.deficit>70}||action(Sidewinders).charges>0.9}'},
	{'Sidewinders', 'toggle(aoe)&{player.buff(Marking Targets)&!target.debuff(Hunter\'s Mark)&!player.buff(Trueshot)}||{player.spell(Sidewinders).charges>1&target.time_to_die<11}'},
	{'Arcane Shot', 'variable.safe_to_build&!variable.use_multishot&focus.deficit>5+gcd*focus.regen'},
	{'Multi-Shot', 'toggle(aoe)&variable.safe_to_build&variable.use_multishot&focus.deficit>2*target.area(8).enemies+gcd*focus.regen'},
	{'Aimed Shot', '!moving&!target.debuff(Vulnerable)&focus>80&player.spell(Windburst).cooldown>focus.time_to_max'},
}

 local xCombat = {
	{'Volley', '{toggle(aoe)&!player.buff(Volley)}||{player.buff(Volley)&!toggle(aoe)}'},
	{'Aimed Shot', 'moving&player.buff(Gyroscopic Stabilization)'},
	{'Arcane Torrent', 'focus.deficit>30&{!talent(7,1)||player.spell(Sidewinders).charges<2}'},
	{Opener, 'player.area(50).enemies==1&xtime<25'},
	{'A Murder of Crows', '{target.time_to_die>65||target.health<20&target.boss}&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&target.debuff(Vulnerable).remains>target.action(A Murder of Crows).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>50&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>50}}'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{TrueshotAoE, '{target.time_to_die>={180-artifact(Quick Shot).rank*10+15}||target.health<20&target.boss}&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&target.debuff(Vulnerable).remains>target.action(A Murder of Crows).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>50&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>50}}'},
	{'Black Arrow', '!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Black Arrow).execute_time&target.debuff(Vulnerable).remains>target.action(Black Arrow).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>60&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>60}}'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)&{target.area(15).enemies>1||{target.area(15).enemies==1&player.focus>90}}'},
	{TargetDie},
	{Patient_Sniper, 'talent(4,3)'},
	{Non_Patient_Sniper, '!talent(4,3)'},
}

local xPetCombat = {
	{'Mend Pet', 'pet.exists&pet.alive&pet.health<75&!pet.buff(Mend Pet)'},
	{'Heart of the Phoenix', '!player.debuff(Weakened Heart)&pet.dead&UI(kPet)'},
	{'Revive Pet', 'pet.dead&UI(kPet)'},
	{'/cast Call Pet 1', '!pet.exists&UI(kPet)'},
	{'/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'player.spell(Misdirection).cooldown<=gcd&toggle(xMisdirect)'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Survival},
	{Interrupts_Random},
	{Interrupts_Normal, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<51'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Fel_Explosives, 'range<51'},
	{xCombat,'target.range<51&target.inFront'},
	{xPetCombat, 'UI(kPet)&!talent(1,1)'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts_Random},
	{Interrupts_Normal, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<51'},
}

NeP.CR:Add(254, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Marksmanship',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
