local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

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
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

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
	{'Consume Magic', 'target.interruptAt(70)&target.inFront&target.inMelee'},
	{'Sigil of Silence', 'target.interruptAt(1)&target.range<39&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)', 'target.ground'},
	{'Arcane Torrent', 'target.interruptAt(70)&target.inFront&target.inMelee&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)'},
}

local ST = {
	{'Sigil of Flame', 'target.range<25&!target.debuff(Sigil of Flame)', 'target.ground'},
	{'Fiery Brand', '!player.buff(Demon Spikes)&!player.buff(Metamorphosis)'},
	{'Demon Spikes', '{spell(Demon Spikes)charges=2||!player.buff(Demon Spikes)}&!target.debuff(Fiery Brand)&!player.buff(Metamorphosis)'},
	{'!Empower Wards', 'target.casting.percent>80'},
	{'Spirit Bomb', '!target.debuff(Frailty)&player.buff(Soul Fragments).count>0'},
	{'Soul Carver', 'target.debuff(Fiery Brand)'},
	{'Immolation Aura', 'player.pain<90'},
	{'Felblade', 'talent(3,1)&player.pain<80'},
	{'Soul Barrier', 'talent(7,3)'},
	{'Metamorphosis', '!player.buff(Demon Spikes)&!target.dot(Fiery Brand).ticking&!player.buff(Metamorphosis)&player.incdmg(5)>=player.health.max*0.70'},
	{'Fel Devastation', 'talent(6,1)&player.incdmg(5)>=player.health.max*0.70'},
	{'Fel Eruption', 'talent(3,3)'},
	{'Soul Cleave', 'player.buff(Soul Fragments).count=5'},
	{'Soul Cleave', 'player.incdmg(5)>=player.health.max*0.70'},
	{'Soul Cleave', 'player.pain>70&player.buff(Soul Fragments).count<4&player.incdmg(4)<=player.health.max*0.20'},
	{'Soul Cleave', 'player.pain>70'},
	{'Shear', 'player.buff(Blade Turning)'},
	{'Shear'},
	{'Fracture', 'talent(4,2)&player.pain>50'},
	{'Infernal Strike', 'talent(3,2)&!target.debuff(Sigil of Flame).remaining<gcd&player.spell(Sigil of Flame).cooldown>4&player.spell(Infernal Strike).charges>0', 'target.ground'},
}

local Ranged = {
	{'Throw Glaive'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)'},
	{Ranged, '!target.inMelee&target.range<40'},
	{ST, 'target.inFront&target.inMelee'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(581, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Vengeance',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
