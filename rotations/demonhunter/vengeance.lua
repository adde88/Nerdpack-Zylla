local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', 		text = 'Keybinds', 																					align = 'center'},
	{type = 'text', 			text = 'Left Shift: Pause', 																align = 'center'},
	{type = 'text', 			text = 'Left Ctrl: Infernal Strike @ Cursor',						 		align = 'center'},
	{type = 'text', 			text = 'Left Alt: Sigil of Flame @ Cursor', 								align = 'center'},
	{type = 'ruler'},			{type = 'spacer'},
	-- Settings
	{type = 'header', 		text = 'Class Settings',																		align = 'center'},
	{type = 'checkbox', 	text = 'Pause Enabled', 																		key = 'kPause', 	default = true},
	{type = 'checkspin',	text = 'Light\'s Judgment - Units', 												key = 'LJ',				spin = 4, step = 1, max = 20, check = true,	desc = '|cffABD473World Spell usable on Argus.|r'},
	{type = 'checkbox', 	text = 'Auto use Infernal Strike with Flame Crash Talent', 	key = 'kIS', 			default = true},
	{type = 'checkbox', 	text = 'Use Trinket #1', 																		key = 'trinket1',	default = true},
	{type = 'checkbox', 	text = 'Use Trinket #2', 																		key = 'trinket2', default = true,	desc = '|cffABD473Trinkets will be used whenever possible!|r'},
	{type = 'ruler'},			{type = 'spacer'},
	-- Survival
	{type = 'header', 		text = 'Survival',									  	      							align = 'center'},
	{type = 'spinner', 		text = 'Soul Cleave below HP%',               							key = 'SC_HP',    default = 85},
  {type = 'checkspin',	text = 'Healthstone',																				key = 'HS',				spin = 45, check = true},
  {type = 'checkspin',	text = 'Healing Potion',																		key = 'AHP',			spin = 45, check = true},
	{type = 'ruler'},	  	{type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDemon Hunter |cffADFF2FVengeance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

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

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Sigil of Flame', 'keybind(lalt)', 'cursor.ground'},
	{'Infernal Strike', 'keybind(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'!Consume Magic', 'target.interruptAt(70)&target.inFront&target.range<=5'},
	{'!Sigil of Misery', 'advanced&target.interruptAt(1)&target.range<31&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)', 'target.ground'},
	{'!Sigil of Silence', 'advanced&target.interruptAt(5)&target.range<31&spell(Sigil of Misery).cooldown>gcd&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)', 'target.ground'},
	{'!Arcane Torrent', 'target.interruptAt(70)&target.inFront&target.range<=5&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)'},
}

local Interrupts_Random = {
	{'!Consume Magic', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<=5', 'enemies'},
	{'!Sigil of Misery', 'advanced&interruptAt(1)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)&range<31', 'enemies.ground'},
	{'!Sigil of Silence', 'advanced&interruptAt(5)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Sigil of Misery).cooldown>gcd&player.spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)&range<31', 'enemies.ground'},
	{'!Arcane Torrent', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)&range<=5'},
}

local Survival ={
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}	 						--Health Stone
}

local xTaunts = {
	{'Torment', 'player.area(30).enemies>=1&combat&alive&threat<100', 'enemies'},
}

local Mitigations = {
	{'Metamorphosis', 'toggle(cooldowns)&!player.buff(Demon Spikes)&!target.debuff(Fiery Brand)&!player.buff(Metamorphosis)&player.incdmg(1)>=player.health.max*0.50'},
	{'Fiery Brand', '!player.buff(Demon Spikes)&!player.buff(Metamorphosis)', 'target'},
	{'Demon Spikes', 'player.spell(Demon Spikes).charges>0&!player.buff(Demon Spikes)&!target.debuff(Fiery Brand)&!player.buff(Metamorphosis)'},
	{'!Empower Wards', 'target.casting.percent>80'},
	{'Soul Barrier', 'player.buff(Soul Fragments).count>4'},
}

local xCombat = {
	{'#Trinket1', 'UI(trinket1)'},
	{'#Trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>UI(LJ_spin)', 'enemies'},
	{'Spirit Bomb', 'count(Frailty).enemies.debuffs==0&player.buff(Soul Fragments).count>0', 'target'},
	{'Immolation Aura'},
	{'Felblade', 'player.pain<81', 'target'},
	{'Fel Devastation', 'player.incdmg(1)>=player.health.max*0.25'},
	{'Soul Cleave', 'player.pain>69||player.incdmg(1)>=player.health.max*0.25', 'target'},
	{'Soul Carver', nil, 'target'},
	{'Fel Eruption', nil, 'target'},
	{'Shear', nil, 'target'},
	{'Fracture', 'player.pain>49||player.buff(Soul Fragments).count<5', 'target'},
	{'Infernal Strike', 'advanced&UI(kIS)&talent(3,2)&target.debuff(Sigil of Flame).duration<gcd&player.spell(Sigil of Flame).cooldown>gcd*3&player.spell(Infernal Strike).charges>0', 'target.ground'}, -- Uses Infernal Strike automatically when you have the appropriate talent, can be disabled.
	{'Infernal Strike', '!advanced&UI(kIS)&talent(3,2)&target.debuff(Sigil of Flame).duration<gcd&player.spell(Sigil of Flame).cooldown>gcd*3&player.spell(Infernal Strike).charges>0', 'player.ground'}, -- Uses Infernal Strike automatically when you have the appropriate talent, can be disabled.
}

local Ranged = {
	{'Throw Glaive', 'toggle(aoe)&range>8&range<31&inFront', 'target'},
	{'Sigil of Chains', 'advanced&range<31&area(8).enemies>2&combat', 'enemies.ground'},
	{'Sigil of Flame', 'toggle(aoe)&advanced&range<31&!target.debuff(Sigil of Flame)', 'target.ground'},
	{'Sigil of Flame', '!advanced&range<31&!target.debuff(Sigil of Flame)', 'player.ground'},
}

local inCombat = {
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'toggle(Interrupts)'},
	{xTaunts, 'toggle(super_taunt)'},
	{Ranged},
	{Mitigations},
  {Survival},
	{Fel_Explosives, 'range<=5'},
	{xCombat, 'target.inFront&target.range<=5'}
}

local outCombat = {
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'toggle(Interrupts)'},
}

NeP.CR:Add(581, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Vengeance',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
  gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
