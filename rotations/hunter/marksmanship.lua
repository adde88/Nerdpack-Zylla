local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Tar Trap', align = 'center'},
	{type = 'text', 	text = 'Left Alt: Binding Shot', align = 'center'},
	{type = 'text', 	text = 'Right Alt: Freezing Trap', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Summon Pet', key = 'kPet', default = true},
	{type = 'checkbox', text = 'Barrage Enabled', key = 'kBarrage', default = false},
   	{type = 'checkbox', text = 'Volley Enabled', key = 'kVolley', default = true},
	{type = 'checkbox', text = 'Misdirect Focus/Pet', key = 'kMisdirect', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = false},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = false},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHunter |cffADFF2FMarksmanship |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/X - 4/3 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
	{'/cast Call Pet 1', '!pet.exists&!pet.dead&UI(kPet)'},
	{'Revive Pet', 'pet.dead&UI(kPet)'},
	{'Volley', 'talent(6,3)&!player.buff(Volley)&UI(kVolley)'},
	{'Volley', 'talent(6,3)&player.buff(Volley)&!UI(kVolley)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Binding Shot', 'keybind(lalt)', 'target.ground'},
	{'!Tar Trap', 'keybind(lcontrol)', 'target.ground'},
	{'!Freezing Trap', 'keybind(ralt)', 'target.ground'},
}

local Survival = {
	{'Exhilaration', 'player.health<66'},
	{'#Ancient Healing Potion', 'player.health<42'},
	{'#Healthstone', 'player.health<38'},
	{'Aspect of the Turtle', 'player.health<25'},
	{'Feign Death', 'player.health<19&equipped(137064)'},
}

local Cooldowns = {
	{'Trueshot', 'xtime<5||player.buff(Bloodlust)||target.time_to_die>={180-artifact(Quick Shot).rank*10+15}||player.buff(Bullseye).stack>25||target.time_to_die<16'},
}

local Interrupts = {
	{'!Counter Shot'},
}

local TargetDie = {
	{'Marked Shot'},
	{'Windburst', 'xmoving=0'},
	{'Aimed Shot', 'xmoving=0&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&target.time_to_die>action(Aimed Shot).execute_time'},
	{'Sidewinders'},
	{'Aimed Shot', 'xmoving=0'},
	{'Arcane Shot'},
}

local TrueshotAoE = {
	{'Marked Shot'},
	{'Barrage', '!talent(4,3)&UI(kBarrage)'},
	{'Piercing Shot'},
	{'Explosive Shot', 'talent(4,1)&target.area(8).enemies>=3'},
	{'Aimed Shot', 'xmoving=0&{!talent(4,3)||talent(7,3)}&target.area(8).enemies=1&player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
	{'Multi-Shot'},
}

local Non_Patient_Sniper = {
	{'Windburst', 'xmoving=0'},
	{'Piercing Shot', 'talent(7,2)&player.focus>=100&target.area(8).enemies>=3&target.debuff(Vulnerable)'},
	{'Sentinel', '!target.debuff(Hunter\'s Mark)&player.focus>30&!player.buff(Trueshot)'},
	{'Sidewinders', 'target.debuff(Vulnerable).remains<gcd&xtime>6'},
	{'Aimed Shot', 'xmoving=0&player.buff(Lock and Load)&player.area(50).enemies.inFront<3'},
	{'Marked Shot'},
	{'Explosive Shot', 'talent(4,1)&target.area(8).enemies>=3'},
	{'Sidewinders', '{{player.buff(Marking Targets)||player.buff(Trueshot)}&focus.deficit>70}||action(Sidewinders).charges>=1.9'},
	{'Arcane Shot', '!variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
	{'Multi-Shot', 'variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
	{'Aimed Shot', 'xmoving=0&!talent(7,2)||{talent(7,2)&cooldown(Piercing Shot).remains>3}'},
	{'Arcane Shot', '!variable.use_multishot'},
	{'Multi-Shot', 'variable.use_multishot'},
}

local Opener = {
	{'A Murder of Crows'},
	{'True Shot'},
	{'Piercing Shot', 'target.debuff(Vulnerable)'},
	{'Explosive Shot', 'talent(4,1)&target.area(8).enemies>=3'},
	{'Barrage', '!talent(4,3)&UI(kBarrage)'},
	{'Arcane Shot', 'line_cd(Arcane Shot)>16&!talent(4,3)'},
	{'Sidewinders', '{!player.buff(Marking Targets)&player.buff(Trueshot).remains<2}||{Action(Sidewinders).charges>=1.9&player.focus<80}'},
	{'Marked Shot'},
	{'Barrage', 'player.buff(Bloodlust)&UI(kBarrage)'},
	{'Aimed Shot', 'xmoving=0&{player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains}||player.focus>90&!talent(4,3)&talent(7,3)'},
	{'Aimed Shot', 'xmoving=0&player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
	{'Black Arrow'},
	{'Barrage', 'UI(kBarrage)'},
	{'Arcane Shot'},
	{'Aimed Shot', 'xmoving=0&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
	{'Sidewinders'},
	{'Aimed Shot'},
}

local Patient_Sniper = {
	{'Marked Shot', '{talent(7,1)&talent(6,2)&player.area(50).enemies.inFront>2}||target.debuff(Hunter\'s Mark).remains<2||{{target.debuff(Vulnerable)||talent(7,1)}&target.debuff(Vulnerable).remains<gcd)}'},
	{'Windburst', 'talent(7,1)&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=50}}||player.buff(Trueshot)'},
	{'Sidewinders', 'player.buff(Trueshot)&{{!player.buff(Marking Targets&player.buff(Trueshot).remains<2)}||{action(Sidewinders).charges>=1.9&{focus.deficit>70||player.area(50).enemies.inFront>1}}}'},
	{'Multi-Shot', 'modifier.player.buff(Marking Targets)&!target.debuff(Hunter\'s Mark)&variable.use_multishot&focus.deficit>2*target.area(8).enemies+gcd*focus.regen'},
	{'Aimed Shot', 'xmoving=0&player.buff(Lock and Load)&player.buff(Trueshot)&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
	{'Marked Shot', 'player.buff(Trueshot)&!talent(7,1)'},
	{'Arcane Shot', 'player.buff(Trueshot)'},
	{'Aimed Shot', 'xmoving=0&!target.debuff(Hunter\'s Mark)&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
	{'Aimed Shot', 'xmoving=0&talent(7,1)&target.debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.focus+target.debuff(Hunter\'s Mark).remains*focus.regen>=80&player.focus+focus.regen*target.debuff(Vulnerable).remains>=80}}&{!talent(7,2)||{talent(7,2)&cooldown(Piercing Shot).remains>5}||player.focus>120}'},
	{'Aimed Shot', 'xmoving=0&!talent(7,1)&target.debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.buff(Trueshot)&player.focus>=80}||{!player.buff(Trueshot)&player.focus+target.debuff(Hunter\'s Mark).remains*focus.regen>=80&player.focus+focus.regen*target.debuff(Vulnerable).remains>=80}}&{!talent(7,2)||{talent(7,2)&cooldown(Piercing Shot).remains>5}||player.focus>120}'},
	{'Windburst', 'xmoving=0&!talent(7,1)&player.focus>80{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=50}}'},
	{'Marked Shot', '{talent(7,1)&player.area(50).enemies.inFront>1}||focus.deficit<50||player.buff(Trueshot)||{player.buff(Marking Targets)&{!talent(7,1)||cooldown(Sidewinders).charges>=1.2}}'},
	{'Piercing Shot', 'talent(7,2)&player.focus>80&target.area(8).enemies>=3&target.debuff(Vulnerable)'},
	{'Sidewinders', 'variable.safe_to_build&{{player.buff(Trueshot)&focus.deficit>70}||action(Sidewinders).charges>=1.9}'},
	{'Sidewinders', '{player.buff(Marking Targets)&!target.debuff(Hunter\'s Mark)&!player.buff(Trueshot)}||{cooldown(Sidewinders).charges>1&target.time_to_die<11}'},
	{'Arcane Shot', 'variable.safe_to_build&!variable.use_multishot&focus.deficit>5+gcd*focus.regen'},
	{'Multi-Shot', 'variable.safe_to_build&variable.use_multishot&focus.deficit>2*target.area(8).enemies+gcd*focus.regen'},
	{'Aimed Shot', 'xmoving=0&!target.debuff(Vulnerable)&focus>80&cooldown(Windburst).remains>focus.time_to_max'},
}

local xPetCombat = {
	{'Mend Pet', 'pet.exists&pet.alive&pet.health<100&!pet.buff(Mend Pet)'},
	{'/cast Call Pet 1', '!pet.exists&!pet.dead'},
	{'Revive Pet', 'pet.dead'},
	{'/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'cooldown(Misdirection).remains<=gcd&UI(kMisdirect)'},
}

 local xCombat = {
	{'Aimed Shot', '!xmoving=0&player.buff(Gyroscopic Stabilization)'},
	{'Arcane Torrent', 'focus.deficit>=30&{!talent(7,1)||cooldown(Sidewinders).charges<2}'},
	{'Blood Fury'},
	{'Berserking'},
	{Opener, 'player.area(50).enemies=1&xtime<=15'},
	{'A Murder of Crows', '{target.time_to_die>=75||target.health<20&target.boss}&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&target.debuff(Vulnerable).remains>target.action(A Murder of Crows).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>=60&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=60}}'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{TrueshotAoE, '{target.time_to_die>={180-artifact(Quick Shot).rank*10+15}||target.health<20&target.boss}&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&target.debuff(Vulnerable).remains>target.action(A Murder of Crows).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>=60&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=60}}'},
	{'Black Arrow', '!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Black Arrow).execute_time&target.debuff(Vulnerable).remains>target.action(Black Arrow).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>=70&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=70}}'},
	{'Barrage', 'UI(kBarrage)'},
	{TargetDie},
	{Patient_Sniper},
	{Non_Patient_Sniper},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Survival},
	{Interrupts, 'target.interruptAt(80)&toggle(Interrupts)&target.inFront&target.range<=50'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat,'target.range<50&target.inFront'},
	{xPetCombat, 'UI(kPet)'},
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(254, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Marksmanship',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
