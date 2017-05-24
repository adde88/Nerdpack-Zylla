local _, Zylla = ...

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Tar Trap', align = 'center'},
	{type = 'text', 	text = 'Left Alt: Binding Shot', align = 'center'},
	{type = 'text', 	text = 'Right Alt: Freezing Trap', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},
	{type = 'checkbox', text = 'Summon Pet', key = 'kPet', default = true},
	{type = 'checkbox', text = 'Barrage Enabled', key = 'kBarrage', default = false},
   	{type = 'checkbox', text = 'Volley Enabled', key = 'kVolley', default = true},
	{type = 'checkbox', text = 'Misdirect Focus/Pet', key = 'kMisdirect', default = true},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = false},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = false},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true}
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHunter |cffADFF2FSurvival |r')
	print('|cffADFF2F --- |WARNING: This rotation is in development, and it\'s not complete!')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	
end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "{target.dead||!target.exists}&!player.area(40).enemies=0" },
}

local PreCombat = {
	{Pet},	
}

local Survival = {
	{'Exhilaration', 'player.health<66'},
	{'#Ancient Healing Potion', 'player.health<42'},
	{'#Healthstone', 'player.health<38'},
	{'Aspect of the Turtle', 'player.health<22'},
	{'Feign Death', 'player.health<19&equipped(137064)'},
}

local Pet = {
	{'Mend Pet', 'pet.health<100'},
	{'Revive Pet', 'pet.dead'},
	{'/cast Call Pet 2', '!pet.exists&!pet.dead'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)'},
	{'Explosive Trap', 'keybind(lalt)', 'cursor.ground'},
	{'Tar Trap', 'keybind(lcontrol)', 'cursor.ground'},
	{'Freezing Trap', 'keybind(ralt)', 'cursor.ground'},
}

local Interrupts = {
	{'Muzzle'},	
}

local RangedNoMok = {
	{'Harpoon'},
	{'A Murder of Crows', 'talent(2,1)cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4'},
	{'Steel Trap', 'talent(4,3)&player.buff(Mongoose Fury).duration>=gcd&player.buff(Mongoose Fury).stack<4', 'target.ground'},
	{'Steel Trap', 'talent(4,3)&player.buff(Mongoose Fury).duration>=gcd&player.buff(Mongoose Fury).stack<4', 'target.ground'},
	{'Caltrops', '{talent(4,1)&!target.dot(Caltrops).ticking}', 'target.ground'},
	{'Caltrops', '{talent(4,1)&player.buff(Mongoose Fury).duration>=gcd&player.buff(Mongoose Fury).stack<4&!target.dot(Caltrops).ticking}', 'target.ground'},
	{'Explosive Trap', 'player.buff(Mongoose Fury).duration>=gcd&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4', 'target.ground'},
	{'Throwing Axes', 'talent(1,2)'},
}

local RangedMok = {
	{'Harpoon'},
	{'A Murder of Crows', 'talent(2,1)&player.focus>55&player.buff(Mongoose Fury).stack<4&player.buff(Mongoose Fury).duration>=gcd'},
	{'Steel Trap', 'talent(4,3)&player.buff(Mongoose Fury).duration>=gcd&player.buff(Mongoose Fury).stack<4', 'target.ground'},
	{'Steel Trap', 'talent(4,3)&player.buff(Mongoose Fury).duration>=gcd&player.buff(Mongoose Fury).stack<4', 'target.ground'},
	{'Caltrops', 'talent(4,1)&player.buff(Mongoose Fury).duration>=gcd&player.buff(Mongoose Fury).stack<4&!target.dot(Caltrops).ticking', 'target.ground'},
	{'Caltrops', '{talent(4,1)&!target.dot(Caltrops).ticking}', 'target.ground'},
	{'Explosive Trap', 'player.buff(Mongoose Fury).duration>=gcd&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4', 'target.ground'},
	{'Throwing Axes', 'talent(1,2)'},
}

local Moknathal = {
	{'Aspect of the Eagle', 'toggle(Cooldowns)&player.buff(Mongoose Fury)&player.buff(Mongoose Fury).remains>6&cooldown(Mongoose Bite).charges>=2'},
	{'Snake Hunter', 'toggle(Cooldowns)&talent(2,3)&cooldown(Mongoose Bite).charges<=0&player.buff(Mongoose Fury.remains>3*gcd'},
	{'Flanking Strike', 'player.focus>75'},
	{'Flanking Strike', 'cooldown(Mongoose Bite).charges<=0&player.buff(Aspect of the Eagle).duration>=gcd&player.focus>75'},
	{'Lacerate', 'player.focus>60&player.buff(Mongoose Fury).duration>=gcd&target.dot(Lacerate)<=3&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4'},
	{'Spitting Cobra', 'player.buff(Mongoose Fury).duration>=gcd&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4'},
	{'Raptor Strike', 'talent(Serpent_sting)&target.dot(Serpent Sting).remains<gcd'},
	{'Raptor Strike', 'player.buff(201082).remains<4&player.buff(Mongoose Fury).stack=6&player.buff(Mongoose Fury).remains>=gcd'},
	{'Raptor Strike', 'player.focus>75-cooldown(Flanking Strike).remains*focus.regen'},
	--{'Raptor Strike', 'player.buff(201082).stack<=3'},
	--{'Raptor Strike', 'player.buff(201082).stack<=1'},
	--{'Raptor Strike', 'player.buff(201082).duration<gcd'},
	{'Flanking Strike', 'cooldown(Mongoose Bite).charges<=2&player.buff(Mongoose Fury).remains>{1+action(Mongoose Bite).charges*gcd}&player.focus>75'},
	{'Mongoose Bite', 'player.buff(Aspect of the Eagle)&player.buff(Mongoose Fury)&player.buff(201082).stack>=4'},
	{'Mongoose Bite', 'player.buff(Mongoose Fury)&player.buff(Mongoose Fury).remains<cooldown(Aspect of the Eagle).remains'},
	{'Mongoose Bite', '{cooldown(Mongoose Bite).charges>=2&spell(Mongoose Bite).cooldown<=gcd||cooldown(Mongoose Bite).charges=3}'},
}

local Nomok = {
	{'Aspect of the Eagle', 'toggle(Cooldowns)&player.buff(Mongoose Fury)&player.buff(Mongoose Fury).duration>6&cooldown(Mongoose Bite).charges>=2'},
	{'Snake Hunter', 'toggle(Cooldowns)&talent(2,3)&action(Mongoose Bite).charges<=0&player.buff(Mongoose Fury).remains>3*gcd'},
	{'Flanking Strike', 'cooldown(Mongoose Bite).charges<2&player.buff(Mongoose Fury).remains>(1+action(Mongoose Bite).charges*gcd)'},
	{'Flanking Strike', 'cooldown(Mongoose Bite).charges<=0&player.buff(Aspect of the Eagle).remains>=gcd'},
	{'Flanking Strike', 'talent(1,1)&cooldown(Mongoose Bite).charges<3'},
	{'Flanking Strike'},
	{'Lacerate', 'player.buff(Mongoose Fury).duration>=gcd&target.dot(Lacerate).remains<=1&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4'},
	{'Lacerate', '{!target.dot(Lacerate).ticking||target.dot(Lacerate).remains<3}'},
	{'Spitting Cobra', 'talent(7,1)&player.buff(Mongoose Fury).duration>=gcd&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4'},
	{'Raptor Strike', 'player.focus>75-cooldown(Flanking Strike)remains*focus.regen'},
	{'Raptor Strike', 'talent(6,3)&target.dot(Serpent Sting).remains<gcd'},
	{'Mongoose Bite', 'player.buff(Mongoose Fury)&player.buff(Mongoose Fury).remains<cooldown(Aspect of the Eagle).remains'},
	{'Mongoose Bite', '{cooldown(Mongoose Bite).charges>=2&cooldown(Mongoose Bite).remains<=gcd|charges=3}'},
}

local AoEMok = {
	{'Butchery', '{talent(6,1)&cooldown(Butchery).charges=3&player.focus>65}'},
	{'Butchery', 'talent(6,1)&player.focus>65'},
	{'Dragonsfire Grenade', 'talent(6,2)&player.buff(Mongoose Fury).duration>=gcd&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4'},
	{'Fury of the Eagle', '{player.buff(201082).remains>4&(player.buff(Mongoose Fury).stack=6&cooldown(Mongoose Bite).charges<=0||player.buff(Mongoose Fury)&player.buff(Mongoose Fury).remains<=2*gcd}}'},
	{'Fury of the Eagle', 'player.buff(201082).remains>4&player.buff(Mongoose Fury).stack=6&cooldown(Mongoose Bite).charges<=2'},	
}

local AoEnoMok = {
	{'Dragonsfire Grenade', 'talent(6,2)&player.buff(Mongoose Fury).duration>=gcd&cooldown(Mongoose Bite).charges>=0&player.buff(Mongoose Fury).stack<4'},
	{'Butchery', 'talent(6,1)'},
	{'Fury of the Eagle', 'player.buff(Mongoose Fury).stack=6&cooldown(Mongoose Bite).charges<=2'},
	{'Fury of the Eagle', 'player.buff(Aspect of the Eagle)&player.buff(Mongoose Fury)'},
	{'Fury of the Eagle', 'cooldown(Mongoose Bite).charges<=0&player.buff(Mongoose Fury).duration>6'},
}

local Ranged = {
	{RangedNoMok, 'talent(1,3)'},
	{RangedMok, '!talent(1,3)'},
}

local AoE = {
	{AoEMok, 'talent(1,3)'},
	{AoEnoMok, '!talent(1,3)'},
}

local Melee = {
	{Moknathal, 'talent(1,3)'},
	{Nomok, '!talent(1,3)'},
}

local inCombat = {
	{_Zylla, 'UI(kAutoTarget)'},
	{'Mongoose Bite', 'lastcast(Mongoose Bite)'},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<=5'},
	{Pet, 'pet.exists&pet.alive'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>=3'},
	{Melee, 'target.range<8&target.infront'},
	{Ranged, 'target.range>8&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(255, {
	name = '[|cff'..Zylla.addonColor..'Zylla|r] Hunter - Survival (DEV)',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
