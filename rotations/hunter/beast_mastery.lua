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
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
	{type = 'ruler'},	{type = 'spacer'},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHunter |cffADFF2FBeast Mastery [T-19] |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/1 - 3/X - 4/2 - 5/X - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xMisdirect',
		name = 'Misdirection',
		text = 'Automatically use Misdirection on current Focus-target or Pet.',
		icon = 'Interface\\Icons\\ability_hunter_misdirection',
	})

end

local PreCombat = {
	{'/cast Call Pet 1', '!pet.exists&UI(kPet)'},
	{'Heart of the Phoenix', '!player.debuff(Weakened Heart)&pet.dead&UI(kPet)'},
	{'Revive Pet', 'pet.dead&UI(kPet)'},
	{'Volley', 'toggle(aoe)&talent(6,3)&!player.buff(Volley)&UI(kVolley)'},
	{'Volley', 'talent(6,3)&player.buff(Volley)&{!UI(kVolley)||!toggle(aoe)}'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Binding Shot', 'keybind(lalt)', 'cursor.ground'},
	{'!Tar Trap', 'keybind(lcontrol)', 'cursor.ground'},
	{'!Freezing Trap', 'keybind(ralt)', 'cursor.ground'},
}

local Survival = {
	{'Exhilaration', 'player.health<=66'},
	{'#Ancient Healing Potion', 'player.health<=42'},
	{'#Healthstone', 'player.health<=40'},
	{'Aspect of the Turtle', 'player.health<=22'},
	{'Feign Death', 'player.health<=15&equipped(137064)'},
}

local Cooldowns = {
	{'Bestial Wrath'},
	{'Titan\'s Thunder', 'talent(2,2)||player.spell(Dire Beast).cooldown>=3||{player.buff(Bestial Wrath)&player.buff(Dire Beast)}'},
	{'Aspect of the Wild', 'player.buff(Bestial Wrath)||target.time_to_die<12'},
}

local Interrupts = {
	{'!Counter Shot'},
	{'!Intimidation', 'talent(6,3)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)'},
}

local xCombat = {
	{'Blood Fury'},
	{'Berserking'},
	{'A Murder of Crows', 'talent(6,1)'},
	{'Stampede', 'talent(7,1)&{player.buff(Bloodlust)||player.buff(Bestial Wrath)||player.spell(Bestial Wrath).cooldown<=2}||target.time_to_die<=14'},
	{'Dire Beast', 'player.spell(Bestial Wrath).cooldown>3'},
	--actions+=/dire_frenzy,if=(pet.cat.buff.dire_frenzy.remains<=gcd.max*1.2)|(charges_fractional>=1.8)|target.time_to_die<9  ** Dire Frenzy tweaked 28.06.2016 - Zylla.
	{'Dire Frenzy', 'talent(2,2)&{pet.buff(Dire Frenzy).remains<=gcd.max*1.2}||action(Dire Frenzy).fractional>=1.8||target.ttd<9'},
	{'Barrage', 'toggle(aoe)&UI(kBarrage)&talent(6,1)&{target.area(15).enemies>1||{target.area(15).enemies=1&player.focus>90}}'},
	{'Multi-Shot', 'toggle(aoe)&target.area(10).enemies>4&{pet.buff(Beast Cleave).remains<gcd.max||!pet.buff(Beast Cleave)}'},
	{'Multi-Shot', 'toggle(aoe)&target.area(10).enemies>1&{pet.buff(Beast Cleave).remains<gcd.max*2||!pet.buff(Beast Cleave)}'},
	{'Chimaera Shot', 'talent(2,3)&player.focus<90'},
	--actions+=/cobra_shot,if=(cooldown.kill_command.remains>focus.time_to_max&cooldown.bestial_wrath.remains>focus.time_to_max)|(buff.bestial_wrath.up&focus.regen*cooldown.kill_command.remains>action.kill_command.cost)|target.time_to_die<cooldown.kill_command.remains|(equipped.parsels_tongue&buff.parsels_tongue.remains<=gcd.max*2)  ** Cobra Shot tweaked 28.06.2016 - Zylla.
	{'Cobra Shot', '{player.spell(Kill Command).cooldown>focus.time_to_max&player.spell(Bestial Wrath).cooldown>focus.time_to_max}||{player.buff(Bestial Wrath)&focus.regen*player.spell(Kill Command).cooldown>action(Kill Command).cost}||target.time_to_die<player.spell(Kill Command).cooldown||{equipped(Parsel\'s Tongue)&player.buff(Parsel\'s Tongue).remains<=gcd.max*2}'},
	{'Volley', 'toggle(aoe)&talent(6,3)&!player.buff(Volley)&UI(kVolley)'},
}

local xPetCombat = {
	{'!Kill Command'},
	{'Mend Pet', 'pet.exists&pet.alive&pet.health<100&!pet.buff(Mend Pet)'},
	{'Heart of the Phoenix', '!player.debuff(Weakened Heart)&pet.dead&UI(kPet)'},
	{'Revive Pet', 'pet.dead&UI(kPet)'},
	{'/cast Call Pet 1', '!pet.exists&UI(kPet)'},
	{'/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'player.spell(Misdirection).cooldown<=gcd&toggle(xMisdirect)'},
}

local xPvP = {
	{'Gladiator\'s Medallion', 'spell.exists(208683)&{player.state(incapacitate)||player.state(stun)||player.state(fear)||player.state(horror)||player.state(sleep)||player.state(charm)}'},
	{'Viper Sting', 'spell.exists(Viper Sting)&target.range<=40&target.health<80'},
	{'Scorpid Sting', 'spell.exists(Scorpid Sting)&target.inMelee'},
	{'Spider Sting', 'spell.exists(Spider Sting)&target.range<=40'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{'Cobra Shot', 'player.focus>=85&player.spell(Kill Command).cooldown&target.area(10).enemies<4'},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<=40'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'target.range<=40&target.inFront'},
	{xPetCombat},
	{xPvP},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<=40'},
}

NeP.CR:Add(253, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Beast Mastery',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
	--blacklist = _G['Zylla.Blacklist']
})
