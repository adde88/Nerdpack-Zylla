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

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDeath-Knight |cffADFF2FBlood |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
}

local Survival = {
	{'Icebound Fortitude', 'player.health<=25||player.incdmg(2.5)>player.health.max*0.50||player.state(stun)'},
	{'Anti-Magic Shell', 'player.incdmg(2.5).magic>player.health.max*0.50'},
	{'Wraith Walk', 'player.state(root)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Death and Decay', 'keybind(lcontrol)', 'cursor.ground'},
}

local Cooldowns = {
	{'Dancing Rune Weapon', 'target.inFront&target.inMelee&{{player.incdmg(2.5)>player.health.max*0.50}||{player.health<=20}}'},
	{'Vampiric Blood', 'player.incdmg(2.5)>player.health.max*0.50||player.health<=40'},
}

local Interrupts = {
	{'!Mind Freeze', 'target.inFront&target.inMelee'},
	{'!Asphyxiate', 'target.range<=20&cooldown(Mind Freeze).remains>gcd&!prev_gcd(Mind Freeze)'},
	{'!Arcane Torrent', 'target.inMelee&cooldown(Mind Freeze).remains>gcd&!prev_gcd(Mind Freeze)'},
}

local xCombat = {
	{'Death Grip', '!target.inMelee&target.range<=30&target.threat<99&target.combat'},
	{'Death\'s Caress', 'target.range<=30&{{!target.debuff(Blood Plague)}||{target.debuff(Blood Plague).remains<=2}}'},
	{'Marrowrend', 'player.buff(Bone Shield).duration<=3&target.inFront&target.inMelee'},
	{'Marrowrend', 'player.buff(Bone Shield).count<=6&talent(3,1)&target.inFront&target.inMelee'},
	{'Blood Boil', '!target.debuff(Blood Plague)&target.range<=10'},
	{'Death and Decay', 'target.range<=30&{{talent(2,1)&player.buff(Crimson Scourge)}||{player.area(10).enemies>1&player.buff(Crimson Scourge}}', 'target.ground'},
	{'Death and Decay', 'target.range<=30&{{talent(2,1)&player.runes>=3}||{player.area(10).enemies>=3}}', 'target.ground'},
	{'Death and Decay', '!talent(2,1)&target.range<=30&player.area(10).enemies=1&player.buff(Crimson Scourge)', 'target.ground'},
	{'Death Strike', 'player.runicpower>=75&target.inFront&target.inMelee'},
	{'Heart Strike', 'player.runes>=3&target.inFront&target.inMelee'},
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
	load = exeOnLoad
})
