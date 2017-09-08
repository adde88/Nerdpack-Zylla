local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', 		text = 'Keybinds', 																				align = 'center',	size = 16},
	{type = 'text', 			text = 'Left Shift: |cffABD473Pause|r', 									align = 'center'},
	{type = 'text', 			text = 'Left Ctrl: |cffABD473Death and Decay @ cursor|r', align = 'center'},
	{type = 'text', 			text = 'Left Alt: ', 																			align = 'center'},
	{type = 'text', 			text = 'Right Alt: ', 																		align = 'center'},
	{type = 'ruler'},			{type = 'spacer'},
	-- Settings
	{type = 'header', 		text = 'Class Settings',																	align = 'center',	size = 16},
	{type = 'checkbox', 	text = 'Pause Enabled', key = 'kPause', 									default = true},
	{type = 'checkspin',	text = 'Light\'s Judgment - Units', 											key = 'LJ',				spin = 4, step = 1, max = 20, check = true,	desc = '|cffC41F3BWorld Spell usable on Argus.|r'},
	{type = 'checkbox', 	text = 'Use Death Grip as backup Interrupt', 							key = 'DGInt', 		default = false},
	{type = 'checkbox', 	text = 'Use Death Grip as backup Taunt', 									key = 'DGTaunt', 	default = false},
	{type = 'checkbox', 	text = 'Use Trinket #1', 																	key = 'trinket1',	default = true},
	{type = 'checkbox', 	text = 'Use Trinket #2', 																	key = 'trinket2', default = true,	desc = '|cffC41F3BTrinkets will be used whenever possible!|r'},
	{type = 'ruler'},			{type = 'spacer'},
	-- Survival
	{type = 'header', 		text = 'Survival',																				align = 'center',	size = 16},
	{type = 'checkspin',	text = 'Death Strike below HP%',													key = 'DSA', 			spin = 70, step = 5, max = 100},
	{type = 'checkspin',	text = 'Death Strike above RP',														key = 'DSb', 			spin = 85, step = 5, max = 100},
	{type = 'checkspin', 	text = 'Icebound Fortitude below HP%',										key = 'IwF', 			spin = 30, step = 5, max = 100},
	{type = 'checkspin', 	text = 'Vampiric Blood below HP%',												key = 'VB', 			spin = 50, step = 5, max = 100},
	{type = 'checkspin',	text = 'Healthstone', 																		key = 'HS',	 			spin = 45, step = 5, max = 100},
	{type = 'checkspin',	text = 'Ancient Healing Potion', 													key = 'AHP',	 		spin = 45, step = 5, max = 100},
	{type = 'ruler'},	 {type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDeath-Knight |cffADFF2FBlood |r')
	print('|cffADFF2F --- |rRecommended Talents: 2112133')
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

local Survival = {
	{'Icebound Fortitude', 'UI(IF_check)&health<=(IF_spin)&{{incdmg(2.5)>health.max*0.50}||state(stun)}', 'player'},
	{'Anti-Magic Shell', 'incdmg(2.5).magic>health.max*0.70', 'player'},
	{'Wraith Walk', 'state(root)||state(snare)', 'player'},
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 						--Health Stone
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Death and Decay', 'keybind(lcontrol)', 'cursor.ground'},
}

local Cooldowns = {
	{'Dancing Rune Weapon', 'inFront&range<=5&{{player.incdmg(2.5)>player.health.max*0.50}||{player.health<30}}', 'target'},
	{'Vampiric Blood', 'UI(VB_check)&{incdmg(2.5)>health.max*0.50||health<=UI(VB_spin)}', 'player'},
	{'#Trinket1', 'UI(trinket1)'},
	{'#Trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Interrupts = {
	{'!Mind Freeze', 'inFront&range<=5', 'target'},
	{'!Asphyxiate', 'range<31&inFront&player.spell(Mind Freeze).cooldown>gcd&!player.lastgcd(Mind Freeze)', 'target'},
	{'!Death Grip', 'UI(DGInt)&range<31&inFront&player.spell(Mind Freeze).cooldown>gcd&player.spell(Asphyxiate).cooldown>gcd', 'target'},
	{'!Arcane Torrent', 'range<=5&player.spell(Mind Freeze).cooldown>gcd&!player.lastgcd(Mind Freeze)', 'target'},
}

local Interrupts_Random = {
	{'!Mind Freeze', 'inFront&range<=5', 'enemies'},
	{'!Asphyxiate', 'player.spell(Mind Freeze).cooldown>gcd&!player.lastgcd(Mind Freeze)&inFront&range<21&combat&alive&', 'enemies'},
	{'!Death Grip', 'UI(DGInt)&range<31&player.spell(Mind Freeze).cooldown>gcd&player.spell(Asphyxiate).cooldown>gcd&combat&alive&', 'enemies'},
	{'!Arcane Torrent', 'player.spell(Mind Freeze).cooldown>gcd&player.spell(Asphyxiate).cooldown>gcd&range<=5', 'enemies'},
}

local xTaunts = {
	{'Dark Command', 'player.area(30).enemies>=1&combat&alive&threat<100', 'enemies'},
	{'Death Grip', 'UI(DGTaunt)&player.area(30).enemies>0&combat&alive&threat<100&player.spell(Dark Command).cooldown>gcd&!player.lastgcd(Dark Command)', 'enemies'},
}

local xCombat = {
	{'Death Strike', 'inFront&range<=5&player.runicpower>65&player.health<=UI(DSA_spin)&UI(DSA_check)', 'target'},
	{'Death Strike', 'inFront&range<=5&player.runicpower>=UI(DSb_spin)&UI(DSb_check)', 'target'},
	{'Death\'s Caress', 'range<41&debuff(Blood Plague).remains<3', 'target'},
	{'Marrowrend', 'player.buff(Bone Shield).duration<4&inFront&range<=5', 'target'},
	{'Marrowrend', 'player.buff(Bone Shield).count<7&talent(3,1)&inFront&range<=5', 'target'},
	{'Blood Boil', 'target.range<11'},
	{'Death and Decay', 'range<31&{{talent(2,1)&player.buff(Crimson Scourge)}||{player.area(10).enemies>1&player.buff(Crimson Scourge}}', 'target.ground'},
	{'Death and Decay', 'range<31&{{talent(2,1)&player.runes>2}||{player.area(10).enemies>2}}', 'target.ground'},
	{'Death and Decay', '!talent(2,1)&range<31&target.area(10).enemies==1&player.buff(Crimson Scourge)', 'target.ground'},
	{'Heart Strike', 'inFront&range<=5&{player.runes>2||player.buff(Death and Decay)}', 'target'},
	{'Consumption', 'inFront&range<=5', 'target'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&{channeling.percent(5)||interruptAt(70)}'},
	{Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)&{channeling.percent(5)||interruptAt(70)}'},
	{Survival},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Fel_Explosives, 'range<=5'},
	{xCombat},
	{xTaunts, 'toggle(super_taunt)'},
}

local outCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&{channeling.percent(5)||interruptAt(70)}'},
	{Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)&{channeling.percent(5)||interruptAt(70)}'},
}

NeP.CR:Add(250, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death-Knight - Blood',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='760', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
