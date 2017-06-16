local _, Zylla = ...

local GUI = {
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Infernal Strike @ Cursor', align = 'center'},
	{type = 'text', 	text = 'Left Alt: Sigil of Flame @ Cursor', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDEMON HUNTER |cffADFF2FVengeance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Sigil of Flame', 'keybind(lalt)', 'cursor.ground'},
	{'Infernal Strike', 'keybind(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'Consume Magic', 'target.interruptAt(50)&target.inFront&target.inMelee'},
	{'Sigil of Silence', 'target.interruptAt(1)&target.range<=29&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)', 'player.ground'},
	{'Arcane Torrent', 'target.interruptAt(50)&target.inFront&target.inMelee&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)'},
}

local ST = {
	{'Sigil of Flame', 'target.range<=15&!target.debuff(Sigil of Flame)', 'player.ground'},
	{'Fiery Brand', '!player.buff(Demon Spikes)&!player.buff(Metamorphosis)'},
	{'Demon Spikes', '{spell(Demon Spikes)charges=2||!player.buff(Demon Spikes)}&!target.debuff(Fiery Brand)&!player.buff(Metamorphosis)'},
	{'!Empower Wards', 'target.casting.percent>80'},
	{'Spirit Bomb', '!target.debuff(Frailty)&player.buff(Soul Fragments).count>=1'},
	{'Soul Carver', 'target.debuff(Fiery Brand)'},
	{'Immolation Aura', 'player.pain<=80'},
	{'Felblade', 'talent(3,1)&player.pain<=70'},
	{'Soul Barrier', 'talent(7,3)'},
	{'Metamorphosis', '!player.buff(Demon Spikes)&!target.dot(Fiery Brand).ticking&!player.buff(Metamorphosis)&player.incdmg(5)>=player.health.max*0.70'},
	{'Fel Devastation', 'talent(6,1)&player.incdmg(5)>=player.health.max*0.70'},
	{'Fel Eruption', 'talent(3,3)'},
	{'Soul Cleave', 'player.buff(Soul Fragments).count=5'},
	{'Soul Cleave', 'player.incdmg(5)>=player.health.max*0.70'},
	{'Soul Cleave', 'player.pain>=80&player.buff(Soul Fragments).count<4&player.incdmg(4)<=player.health.max*0.20'},
	{'Soul Cleave', 'player.pain>=80'},
	{'Shear', 'player.buff(Blade Turning)'},
	{'Shear'},
	{'Fracture', 'talent(4,2)&player.pain>=60'},
}

local Ranged = {
	{'Throw Glaive'},
}

local inCombat = {
	{Zylla.Util},
	{Zylla.Trinkets},
	{Zylla.Heirlooms},
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)'},
	{Ranged, '!target.inMelee&target.range<=30'},
	{ST, 'target.inFront&target.inMelee'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(581, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] DEMON HUNTER - Vengeance',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
