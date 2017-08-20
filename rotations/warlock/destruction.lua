local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
	{type = 'texture', texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Keybinds
	{type = 'header', 	text = 'Keybinds',										align = 'center'},
	{type = 'text', 		text = 'Left Shift: Pause',								align = 'center'},
	{type = 'text', 		text = 'Left Ctrl: Cataclysm',							align = 'center'},
	{type = 'text', 		text = 'Left Alt: Rain of Fire',						align = 'center'},
	{type = 'text', 		text = 'Right Alt: ',									align = 'center'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',	align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',		key = 'kPause',	default = true},
	{type = 'checkbox', text = 'Summon Pet (Imp)',		key = 'kPet',	default = true},
	{type = 'checkbox', text = 'Use Doomguard as Pet',		key = 'kDG',	default = false},
	{type = 'checkbox', text = 'Use Infernal as Pet',		key = 'kINF',	default = false},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 		text = 'Survival',	align = 'center'},
	{type = 'spinner',		text = 'Unending Resolve below HP%',						key = 'UR_HP',		default = 40},
	{type = 'spinner',		text = 'Cauterize Master below HP%',						key = 'CM_HP',		default = 65},
	{type = 'spinner',		text = 'Healthstone or Healing Potions',	key = 'Health Stone',	default = 45},
	{type = 'checkbox', 	text = 'Use Fear to Interrupt',							key = 'k_FEAR',		default = false},
	{type = 'spinner',		text = 'Life Tap below HP%',					key = 'k_LTHP',		default = 35},
	{type = 'spinner',		text = 'Drain Life below HP%',						key = 'k_DLHP',		default = 40},
	{type = 'spinner',		text = 'Health Funnel When PET is below HP%',		key = 'k_HFHP',		default = 30},
	{type = 'spinner',		text = 'Health Funnel When PLAYER is above HP%',	key = 'k_HFHP2',	default = 40},
	{type = 'ruler'},			{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'checkbox', 	text = 'Use Trinket #1',								key = 'kT1',		default = true},
	{type = 'checkbox', 	text = 'Use Trinket #2',								key = 'kT2',		default = true},
	{type = 'checkbox', 	text = 'Ring of Collapsing Futures',					key = 'kRoCF',		default = true},
	{type = 'checkbox', 	text = 'Use Heirloom Necks When Below X% HP',			key = 'k_HEIR',		default = true},
	{type = 'spinner',		text = '',												key = 'k_HeirHP',	default = 40},
	{type = 'ruler'},		{type = 'spacer'},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarlock |cffADFF2FDestruction |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

end

local Pets = {
	{'Summon Imp', 'UI(kPet)&!UI(kDG)&!UI(kINF)&!talent(6,1)&!lastcast(Summon Imp)&{!pet.exist||pet.dead}'},
	{'Summon Doomguard', 'UI(kPet)&UI(kDG)&!UI(kINF)&talent(6,1)&!lastcast(Summon Doomguard)&{!pet.exist||pet.dead}'},
	{'Summon Infernal', 'UI(kPet)&!UI(kDG)&UI(kINF)&talent(6,1)&!lastcast(Summon Infernal)&{!pet.exist||pet.dead}'},
}

local Survival = {
	{'Life Tap', 'player.moving&player.health>=UI(k_LTHP)'},
	{'Life Tap', 'talent(2,3)&!player.buff(Empowered Life Tap)&player.health<=90'},
	{'Unending Resolve', 'player.health<UI(UR_HP)'},
	{'Dark Pact', 'player.health<40&pet.health>25'},
	{'Drain Life', 'player.health<=UI(k_DLHP)'},
	{'Health Funnel', 'pet.health<=UI(k_HFHP)&player.health>=UI(k_HFHP2)'},
	{'119899', 'pet.exists&player.health<UI(CM_HP)'},
	{'#127834', 'item(127834).count>0&player.health<UI(Health Stone)'},        -- Ancient Healing Potion
	{'#5512', 'item(5512).count>0&player.health<UI(Health Stone)', 'player'},  --Health Stone
}

local Cooldowns = {
	{'Soul Harvest', 'count(Immolate).debuffs>=1'},
	{'Grimoire: Imp'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Cataclysm', 'toggle(aoe)&keybind(lcontrol)', 'target.ground'},
	{'!Rain of Fire', 'toggle(aoe)&keybind(lalt)', 'target.ground'},
}

local Interrupts = {
	{'!Fear', 'target.inFront&target.range<=40&UI(k_FEAR)'},
	{'!Mortal Coil', 'target.inFront&target.range<=20'},
}

local xCombat = {
	{'Havoc', 'toggle(aoe)&player.soulshards==5&player.area(40).enemies>1&!debuff(Havoc)', 'enemies'},
	{'Chaos Bolt', 'player.soulshards==5&{{player.area(40).enemies==1}||{player.area(40).enemies>1&enemies.debuff(Havoc).duration>=3*gcd}}'},
	{'Dimensional Rift', 'player.soulshards<5', 'target'},
	{'Channel Demonfire', 'debuff(Immolate)&range<40', 'enemies'},
	{'Rain of Fire', 'toggle(aoe)&{{target.area(10).enemies>=3}||{player.area(10).enemies>=3}}', 'target.ground'},
	{'Shadowburn', 'player.soulshards<5', 'target'},
	{'Conflagrate', 'player.soulshards<5', 'target'},
	{'Incinerate', 'player.soulshards<5', 'target'},
	{'Immolate', 'target.debuff(Immolate).duration<2*gcd&player.area(40).enemies==1', 'target'},
	{'Immolate', 'debuff(Immolate).duration<2*gcd&player.area(40).enemies>1', 'enemies'},
	{'Cataclysm', 'talent(4,1)&target.area(8).enemies>2', 'target.ground'},
	{'Summon Imp', '!lastcast(Summon Imp)&{!pet.exist||pet.dead}'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<=40'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'range<40&inFront'},
}

local outCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<=30'},
	{Pets},
	{'Create Healthstone', 'item(5512).count<1&!lastcast(Create Healthstone)'},
}

NeP.CR:Add(267, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Destruction',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
