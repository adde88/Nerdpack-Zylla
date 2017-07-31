local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
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
	print('|cffADFF2F --- |rDeath-Knight |cffADFF2FBlood |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
}

local Survival = {
	{'Icebound Fortitude', 'player.health<35||player.incdmg(2.5)>player.health.max*0.50||player.state(stun)'},
	{'Anti-Magic Shell', 'player.incdmg(2.5).magic>player.health.max*0.50'},
	{'Wraith Walk', 'player.state(root)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Death and Decay', 'keybind(lcontrol)', 'cursor.ground'},
}

local Cooldowns = {
	{'Dancing Rune Weapon', 'target.inFront&target.inMelee&{{player.incdmg(2.5)>player.health.max*0.50}||{player.health<30}}'},
	{'Vampiric Blood', 'player.incdmg(2.5)>player.health.max*0.50||player.health<50'},
}

local Interrupts = {
	{'!Mind Freeze', 'target.inFront&target.inMelee'},
	{'!Asphyxiate', 'target.range<30&cooldown(Mind Freeze).remains>gcd&!prev_gcd(Mind Freeze)'},
	{'!Arcane Torrent', 'target.inMelee&cooldown(Mind Freeze).remains>gcd&!prev_gcd(Mind Freeze)'},
}

local xCombat = {
	{'Death Grip', '!target.inMelee&target.range<40&target.threat<99&target.combat'},
	{'Death\'s Caress', 'target.range<40&{{!target.debuff(Blood Plague)}||{target.debuff(Blood Plague).remains<3}}'},
	{'Marrowrend', 'player.buff(Bone Shield).duration<4&target.inFront&target.inMelee'},
	{'Marrowrend', 'player.buff(Bone Shield).count<7&talent(3,1)&target.inFront&target.inMelee'},
	{'Blood Boil', '!target.debuff(Blood Plague)&target.range<20'},
	{'Death and Decay', 'target.range<40&{{talent(2,1)&player.buff(Crimson Scourge)}||{player.area(10).enemies>1&player.buff(Crimson Scourge}}', 'target.ground'},
	{'Death and Decay', 'target.range<40&{{talent(2,1)&player.runes>2}||{player.area(10).enemies>2}}', 'target.ground'},
	{'Death and Decay', '!talent(2,1)&target.range<40&player.area(10).enemies==1&player.buff(Crimson Scourge)', 'target.ground'},
	{'Death Strike', 'player.runicpower>65&target.inFront&target.inMelee'},
	{'Heart Strike', 'player.runes>2&target.inFront&target.inMelee'},
	{'Consumption', 'target.inFront&target.inMelee'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Trinkets},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Survival},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
}

NeP.CR:Add(250, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death-Knight - Blood',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	load = exeOnLoad
})
