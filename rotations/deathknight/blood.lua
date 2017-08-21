local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
	{type = 'texture', texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	  {type = 'spacer'},
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
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
	 key = 'super_taunt',
	 name = 'Taunt Lowest Threat',
	 text = 'Taunt a nearby enemy in combat, when threat gets low, without targeting it.',
	 icon = 'Interface\\Icons\\spell_nature_reincarnation',
 })

end

local PreCombat = {}

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

local Interrupts_Random = {
	{'!Mind Freeze', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&inMelee', 'enemies'},
	{'!Asphyxiate', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Mind Freeze).cooldown>gcd&!prev_gcd(Mind Freeze)&inFront&range<21', 'enemies'},
	{'!Arcane Torrent', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Mind Freeze).cooldown>gcd&player.spell(Asphyxiate).cooldown>gcd&inMelee', 'enemies'},
}

local xTaunts = {
	{'Dark Command', 'player.area(30).enemies>=1&combat&alive&threat<100', 'enemies'},
}

local xCombat = {
	{'Death Grip', 'target.range>10&target.range<41&target.threat<99&target.combat'},
	{'Death\'s Caress', 'range<41&debuff(Blood Plague).remains<3', 'target'},
	{'Marrowrend', 'player.buff(Bone Shield).duration<4&target.inFront&target.inMelee'},
	{'Marrowrend', 'player.buff(Bone Shield).count<7&talent(3,1)&target.inFront&target.inMelee'},
	{'Blood Boil', '!target.debuff(Blood Plague)&target.range<20'},
	{'Death and Decay', 'range<41&{{talent(2,1)&player.buff(Crimson Scourge)}||{player.area(10).enemies>1&player.buff(Crimson Scourge}}', 'target.ground'},
	{'Death and Decay', 'range<41&{{talent(2,1)&player.runes>2}||{player.area(10).enemies>2}}', 'target.ground'},
	{'Death and Decay', '!talent(2,1)&range<41&player.area(10).enemies==1&player.buff(Crimson Scourge)', 'target.ground'},
	{'Death Strike', 'player.runicpower>65&inFront&inMelee', 'target'},
	{'Heart Strike', 'inFront&inMelee&{player.runes>2||player.buff(Death and Decay)}', 'target'},
	{'Consumption', 'target.inFront&target.inMelee'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Trinkets},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Interrupts_Random},
	{Survival},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat},
	{xTaunts, 'toggle(super_taunt)'},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Interrupts_Random},
}

NeP.CR:Add(250, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death-Knight - Blood',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
