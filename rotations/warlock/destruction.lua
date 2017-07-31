local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	{type = 'header', 		text = 'Keybinds',										align = 'center'},
	{type = 'text', 		text = 'Left Shift: Pause',								align = 'center'},
	{type = 'text', 		text = 'Left Ctrl: Cataclysm',							align = 'center'},
	{type = 'text', 		text = 'Left Alt: Rain of Fire',						align = 'center'},
	{type = 'text', 		text = 'Right Alt: ',									align = 'center'},
	{type = 'ruler'},		{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'checkbox', 	text = 'Pause Enabled',									key = 'kPause',		default = true},
	{type = 'checkbox', 	text = 'Use Trinket #1',								key = 'kT1',		default = true},
	{type = 'checkbox', 	text = 'Use Trinket #2',								key = 'kT2',		default = true},
	{type = 'checkbox', 	text = 'Ring of Collapsing Futures',					key = 'kRoCF',		default = true},
	{type = 'checkbox', 	text = 'Use Heirloom Necks When Below X% HP',			key = 'k_HEIR',		default = true},
	{type = 'spinner',		text = '',												key = 'k_HeirHP',	default = 40},
	{type = 'ruler'},		{type = 'spacer'},
	-- Survival
	{type = 'checkbox', 	text = 'Use Fear to Interrupt',							key = 'k_FEAR',		default = false},
	{type = 'spinner',		text = 'Stop Life Tapping At X% HP',					key = 'k_LTHP',		default = 35},
	{type = 'spinner',		text = 'Use Drain Life At X% HP',						key = 'k_DLHP',		default = 40},
	{type = 'spinner',		text = 'Use Health Funnel When Pet is below X% HP',		key = 'k_HFHP',		default = 30},
	{type = 'spinner',		text = 'Use Health Funnel When Player is above X% HP',	key = 'k_HFHP2',	default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarlock |cffADFF2FDestruction |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local Survival = {
	{'Life Tap', 'player.moving&player.health>=UI(k_LTHP)'},
	{'Life Tap', '{talent(2,3)&!player.buff(Empowered Life Tap)}&player.health>=UI(k_LTHP)'},
	{'Unending Resolve', 'player.health<40'},
	{'Dark Pact', 'player.health<40&pet.health>25'},
	{'Drain Life', 'player.health<=UI(k_DLHP)'},
	{'Health Funnel', 'pet.health<=UI(k_HFHP)&player.health>=UI(k_HFHP2)'},
	{'119899', 'player.health<65'}
}

local Cooldowns = {
	{'Summon Doomguard', '!target.area(10).enemies>2||!player.area(10).enemies>2'},
	{'Summon Infernal', 'target.area(10).enemies>2||player.area(10).enemies>2'},
	{'Grimoire: Imp'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Cataclysm', 'keybind(lcontrol)'},
	{'!Rain of Fire', 'keybind(lalt)'},
}

local Interrupts = {
	{'!Fear', 'target.inFront&target.range<40&UI(k_FEAR)'},
}

local xCombat = {
	{'Immolate', 'target.debuff(Immolate).duration<6.4'},
	{'Summon Infernal', 'artifact(Lord of Flames).enabled'},
	{'Soul Harvest', 'target.debuff(Immolate)'},
	{'Chaos Bolt', 'player.soulshards=5'},
	{'Dimensional Rift', '{player.spell(Dimensional Rift).charges>1}||{player.soulshards<5&player.moving}'},
	{'Channel Demonfire', 'target.debuff(Immolate)'},
	{'Rain of Fire', 'target.area(10).enemies>3||player.area(10).enemies>3'},
	{'Conflagrate', 'player.soulshards<5'},
	{'Shadowburn', 'talent(1,3)&player.soulshards<3'},
	{'Chaos Bolt'},
	{'Incinerate'},
	{'Havoc', '!focus.debuff(Havoc)', 'focus.enemy'},
	{'Cataclysm', 'talent(4,1)&target.area(8).enemies>2'},
	{'Summon Imp', '!pet.exist||!pet.alive'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<50'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'target.range<50&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<50'},
	{'Summon Imp', '!pet.exists||!pet.alive'},
	{'Create Healthstone', 'item.count(Healthstone)==0&!lastcast(Create Healthstone)'},
}

NeP.CR:Add(267, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Destruction',
	  ic=inCombat,
	 ooc=outCombat,
	 gui=GUI,
	 ids = Zylla.SpellIDs[Zylla.Class],
	load=exeOnLoad
})
