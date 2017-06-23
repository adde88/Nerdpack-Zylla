local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	{type='header', 	text='Keybinds', 							align='center'},
	{type='text', 		text='Left Shift: Pause', 					align='center'},
	{type='text', 		text='Left Ctrl: Efflorescence', 			align='center'},
	{type='text', 		text='Left Alt: Healing Routine (OOC)',		align='center'},
	{type='text', 		text='Right Alt: ', 						align='center'},
	{type='ruler'},		{type='spacer'},
	-- General Class/Spec Settings
	{type = 'header',	text = 'General Settings',					align = 'center'},
	{type='checkbox',	text='Pause Enabled',						key='kPause',	default=true},
	{type = 'spinner', 	text = 'Critical Health %',					key = 'k_CH',	default = 33},
	{type = 'spinner', 	text = 'DPS while ppl. are above HP %',		key = 'k_DPSHP',default = 90},
	-- TANK
	{type = 'header', 	text = 'Tank Healing',						align = 'center'},
	{type = 'spinner', 	text = 'Rejuvenation',						key = 'trejuv',	default = 99},
	{type = 'spinner', 	text = 'Germination',						key = 'tgerm',	default = 90},
	{type = 'spinner', 	text = 'Swiftmend',							key = 'tsm',	default = 80},
	{type = 'spinner', 	text = 'Healing Touch)',					key = 'tht',	default = 90},
	{type = 'spinner', 	text = 'Regrowth',							key = 'trg',	default = 60},
	{type='ruler'},		{type='spacer'},
	-- LOWEST
	{type = 'header', 	text = 'Lowest Healing', 							align = 'center'},
	{type = 'spinner', 	text = 'Rejuv', 							key = 'lrejuv', default = 90},
	{type = 'spinner', 	text = 'Germ', 								key = 'lgerm', 	default = 75},
	{type = 'spinner', 	text = 'Swiftmend', 						key = 'lsm', 	default = 80},
	{type = 'spinner', 	text = 'Healing touch)', 					key = 'lht',	default = 90},
	{type = 'spinner', 	text = 'Regrowth', 							key = 'lrg', 	default = 60},
	{type='ruler'},		{type='spacer'},
	-- Trinkets + Heirlooms for leveling
	{type='header',		text='Trinkets/Heirlooms', 					align='center'},
	{type='checkbox',	text='Use Trinket #1', 						key='kT1',		default=true},
	{type='checkbox',	text='Use Trinket #2', 						key='kT2',		default=true},
	{type='checkbox',	text='Ring of Collapsing Futures', 			key='kRoCF',	default=true},
	{type='checkbox',	text='Use Heirloom Necks When Below X% HP',	key='k_HEIR',	default=true},
	{type='spinner',	text='', 									key='k_HeirHP',	default=40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FGuardian |r')
	print('|cffADFF2F --- |')
	print('|cffADFF2F --- |rCheck Setting to go over important healing stuff! |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON.')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xDPS',
		name = 'DPS',
		text = 'Do damage in combat when possible.',
		icon = 'Interface\\Icons\\ability_backstab',
	})

end

local PreCombat = {
	{'Travel Form', '!indoors&!player.buff(Travel Form)&!player.buff(Prowl)&{!target.enemy||target.enemy&!target.alive}'},
	{'Cat Form', '!player.buff(Cat Form)&!player.buff(Travel Form)'},
 	{'Prowl', '!player.buff(Prowl)&player.area(40).enemies>0'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)'},
	{'!Efflorescence', 'keybind(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'!Mighty Bash', 'talent(4,1)'},
}

local DPS = {
	{'Moonfire', nil, 'endebuff(Moonfire)'},
	{'Sunfire', nil, 'endebuff(Sunfire)'},
	{'Solar Wrath', 'target.debuff(Moonfire)&target.debuff(Sunfire)'},
}

local Innervate = {
	{'Rejuvenation', nil, 'lnbuff(Rejuvenation)'},
	{'Rejuvenation', 'talent(6,3)&buff(Rejuvenation)', 'lnbuff(Rejuvenation (Germination))'},
	{'Regrowth', nil, 'lowest'},
}

local TreeForm = {
}

local Emergency = {
	{'!Swiftmend', nil, 'lowest'},
	{'!Regrowth', nil, 'lowest'},
}

local Cooldowns = {
	{'Tranquility', 'player.area(40,75).heal>=3'},
	{'Innervate', 'player.mana<=50'},
}

local Mitigations = {
	{'Barkskin', 'player.health<=30'},
	{'Ironbark', 'tank.health<=20', 'tank'},
	{'Ironbark', 'lowest.health<=20', 'lowest'},
}

local Moving = {
	{'Lifebloom', 'tank.buff(Lifebloom).duration<=4.5', 'tank'},

	{'Cenarion Ward', 'talent(1,2)&!tank.buff(Cenarion Ward)', 'tank'},
	{'Cenarion Ward', 'talent(1,2)&!tank2.buff(Cenarion Ward)', 'tank2'},
	{'Cenarion Ward', 'talent(1,2)', 'lnbuff(Cenarion Ward)'},
	-- Rejuv
	{'Rejuvenation', 'tank.health<=UI(trejuv)&!tank.buff(Rejuvenation)', 'tank'},
	{'Rejuvenation', 'tank2.health<=UI(trejuv)&!tank2.buff(Rejuvenation)', 'tank2)'},
	{'Rejuvenation', 'health<=UI(lrejuv)&!buff(Rejuvenation)', 'lnbuff(Rejuvenation)'},
	-- Germ
	{'Rejuvenation', 'talent(6,3)&tank.buff(Rejuvenation)&!tank.buff(Rejuvenation (Germination))&tank.health<=UI(lgerm)', 'tank'},
	{'Rejuvenation', 'talent(6,3)&tank2.buff(Rejuvenation)&!tank2.buff(Rejuvenation (Germination))&tank2.health<=UI(lgerm)', 'tank2'},
	{'Rejuvenation', 'talent(6,3)&buff(Rejuvenation)&health<=UI(lgerm)', 'lnbuff(Rejuvenation (Germination))'},

	{'Swiftmend', 'tank.health<=UI(tsm)', 'tank'},
	{'Swiftmend', 'tank2.health<=UI(tsm)', 'tank2'},
	{'Swiftmend', 'lowest.health<=UI(lsm)', 'lowest'},
}

local xHealing = {
	{Emergency, 'lowest.health<=UI(k_CH)'},
	{Innervate, 'player.buff(Innervate)'},
	{'Lifebloom', 'tank.buff(Lifebloom).duration<=4.5&tank.health>=UI(tsm)||!tank.buff(Lifebloom)', 'tank'},

	{'Cenarion Ward', 'talent(1,2)&!tank.buff(Cenarion Ward)', 'tank'},
	{'Cenarion Ward', 'talent(1,2)&!tank2.buff(Cenarion Ward)', 'tank2'},
	{'Cenarion Ward', 'talent(1,2)', 'lnbuff(Cenarion Ward)'},

	{'Wild Growth', 'lowest.area(30,75).heal>=3', 'lowest'},
	{'Essence of G\'Hanir', 'player.area(30,75).heal>=3'},
	{'Flourish', 'talent(7,3)&player.lastcast(Wild Growth)&lowest.health<=50'},

	{'Regrowth', 'player.buff(Clearcasting)', 'lowest'},

	-- Rejuv
	{'Rejuvenation', 'tank.health<=UI(trejuv)&!tank.buff(Rejuvenation)', 'tank'},
	{'Rejuvenation', 'tank2.health<=UI(trejuv)&!tank2.buff(Rejuvenation)', 'tank2)'},
	{'Rejuvenation', 'health<=UI(lrejuv)&!buff(Rejuvenation)', 'lnbuff(Rejuvenation)'},
	-- Germ
	{'Rejuvenation', 'talent(6,3)&tank.buff(Rejuvenation)&!tank.buff(Rejuvenation (Germination))&tank.health<=UI(lgerm)', 'tank'},
	{'Rejuvenation', 'talent(6,3)&tank2.buff(Rejuvenation)&!tank2.buff(Rejuvenation (Germination))&tank2.health<=UI(lgerm)', 'tank2'},
	{'Rejuvenation', 'talent(6,3)&buff(Rejuvenation)&health<=UI(lgerm)&!buff', 'lnbuff(Rejuvenation (Germination))'},

	{'Swiftmend', 'tank.health<=UI(tsm)', 'tank'},
	{'Swiftmend', 'tank2.health<=UI(tsm)', 'tank2'},
	{'Swiftmend', 'lowest.health<=UI(lsm)', 'lowest'},

	{'Regrowth', 'tank.health<=UI(trg)', 'tank'},
	{'Regrowth', 'tank2.health<=UI(trg)', 'tank2'},
	{'Regrowth', 'lowest.health<=UI(lrg)', 'lowest'},

	{'Healing Touch', 'tank.health<=UI(tht)', 'tank'},
	{'Healing Touch', 'tank2.health<=UI(tht)', 'tank2'},
	{'Healing Touch', 'lowest.health<=UI(lht)', 'lowest'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(80)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Mitigations},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xHealing, '!player.moving'},
	{Moving, 'player.moving'},
	{DPS, 'toggle(xDPS)&lowest.health>=UI(k_DPSHP)'},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
}

NeP.CR:Add(105, {
  name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Restoration',
  ic=inCombat,
  ooc=outCombat,
  gui=GUI,
  load=exeOnLoad
})
