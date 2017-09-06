local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type='header', 	text='Keybinds', 							align='center'},
	{type='text', 		text='Left Shift: Pause', 					align='center'},
	{type='text', 		text='Left Ctrl: Efflorescence', 			align='center'},
	{type='text', 		text='Left Alt: Healing Routine (OOC)',		align='center'},
	{type='text', 		text='Right Alt: ', 						align='center'},
	{type='ruler'},		{type='spacer'},
	-- General Class/Spec Settings
	{type = 'header',	text = 'General Settings',					align = 'center'},
	{type='checkbox',	text='Pause Enabled',						key='kPause',	default=true},
	{type = 'spinner', 	text = 'Critical HP%',					key = 'k_CH',	default = 33},
	{type = 'spinner', 	text = 'DPS while ppl. are above HP%',		key = 'k_DPSHP',default = 90},
	{type = 'spinner', text = 'Rejuvenation - Player amount', key = 'REJUV_UNITS', align = 'left', width = 55, step = 1, default = 8, max = 40},
	{type = 'spinner', text = 'Rejuvenation - when below HP%', key = 'MASS_REJUV_HP', align = 'left', width = 55, step = 5, default = 95, max = 100},
	{type='ruler'},		{type='spacer'},
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
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDruid |cffADFF2FRestoration |r')
	print('|cffADFF2F --- |')
	print('|cffADFF2F --- |rCheck Setting to go over important healing stuff! |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON.')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xDPS',
		name = 'DPS',
		text = 'Do damage in combat when possible.',
		icon = 'Interface\\Icons\\ability_backstab',
	})

	NeP.Interface:AddToggle({
		key = 'xFORM',
		name = 'Handle Forms',
		text = 'Automatically handle player forms',
		icon = 'Interface\\Icons\\inv-mount_raven_54',
	})

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
		key = 'xRejuv',
		name = 'Rejuvenation on many players.',
		text = 'Keep Rejuvenation up on several party/raid members. (Units and HP% changable within settings).',
		icon = 'Interface\\Icons\\spell_nature_rejuvenation',
	})

	NeP.Interface:AddToggle({
		key = 'disp',
		name='Dispel',
		text = 'ON/OFF Dispel All',
		icon='Interface\\ICONS\\spell_holy_purify',
	})

end

local PreCombat = {
	--{'Travel Form', 'toggle(xFORM)&movingfor>2&!indoors&!player.form==0'},
	{'Cat Form', 'toggle(xFORM)&indoors&!player.buff(Cat Form)&!player.buff(Travel Form)'},
 	{'Prowl', '!player.buff(Prowl)&player.area(40).enemies>0'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)'},
	{'!Efflorescence', 'keybind(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'Skull Bash', 'player.form>0', 'target'},
	{'!Mighty Bash', nil, 'target'},
}

local Interrupts_Random = {
	{'!Skull Bash', 'interruptAt(70)&player.form>0&toggle(xIntRandom)&toggle(Interrupts)&range<14', 'enemies'},
	{'!Mighty Bash', 'interruptAt(60)&toggle(xIntRandom)&toggle(Interrupts)&inFront&inMelee', 'enemies'},
}

local DPS = {
	{'Moonfire', 'debuff.duration<3&range<41&combat', 'enemies'},
	{'Sunfire', 'debuff.duration<3&range<41&combat', 'enemies'},
	{'Solar Wrath', 'debuff(Moonfire)&debuff(Sunfire)&range<41&combat', 'enemies'},
}

local Innervate = {
	{'Rejuvenation', nil, 'lnbuff(Rejuvenation)'},
	{'Rejuvenation', 'talent(6,3)&buff(Rejuvenation)', 'lnbuff(Rejuvenation (Germination))'},
	{'Regrowth', nil, 'lowest'},
}

local TreeForm = {}

local Emergency = {
	{'!Swiftmend', nil, 'lowest'},
	{'!Regrowth', nil, 'lowest'},
}

local Cooldowns = {
	{'Tranquility', 'player.area(40,75).heal>2'},
	{'Innervate', 'player.mana<60'},
}

local Mitigations = {
	{'Barkskin', 'player.health<40'},
	{'Ironbark', 'health<30', '{tank, lowest}'},
	--{'Ironbark', 'lowest.health<30', 'lowest'},
}

local Moving = {
	{'Lifebloom', 'tank.buff(Lifebloom).duration<5.5', 'tank'},
	-- Wardz
	{'Cenarion Ward', 'talent(1,2)&!tank.buff(Cenarion Ward)', 'tank'},
	{'Cenarion Ward', 'talent(1,2)&!tank2.buff(Cenarion Ward)', 'tank2'},
	{'Cenarion Ward', 'talent(1,2)', 'lnbuff(Cenarion Ward)'},
	-- Rejuvs
	{'Rejuvenation', 'tank.health<=UI(trejuv)&!tank.buff(Rejuvenation)', 'tank'},
	{'Rejuvenation', 'tank2.health<=UI(trejuv)&!tank2.buff(Rejuvenation)', 'tank2)'},
	{'Rejuvenation', 'health<=UI(lrejuv)&!buff(Rejuvenation)', 'lnbuff(Rejuvenation)'},
	-- Germs
	{'Rejuvenation', 'talent(6,3)&tank.buff(Rejuvenation)&!tank.buff(Rejuvenation (Germination))&tank.health<=UI(lgerm)', 'tank'},
	{'Rejuvenation', 'talent(6,3)&tank2.buff(Rejuvenation)&!tank2.buff(Rejuvenation (Germination))&tank2.health<=UI(lgerm)', 'tank2'},
	{'Rejuvenation', 'talent(6,3)&buff(Rejuvenation)&health<=UI(lgerm)', 'lnbuff(Rejuvenation (Germination))'},
	-- Swifties
	{'Swiftmend', 'tank.health<=UI(tsm)', 'tank'},
	{'Swiftmend', 'tank2.health<=UI(tsm)', 'tank2'},
	{'Swiftmend', 'lowest.health<=UI(lsm)', 'lowest'},
}

local SWP_MASS = {
	{'Rejuvenation', 'range<41&combat&alive&buff.count.any<UI(REJUV_UNITS)&buff.duration<3&health<=UI(MASS_REJUV_HP)', 'lnbuff(Rejuvenation)'}
}

local xHealing = {
	{Emergency, 'lowest.health<=UI(k_CH)'},
	{Innervate, 'player.buff(Innervate)'},
	{'Lifebloom', 'tank.buff(Lifebloom).duration<5.5&tank.health>=UI(tsm)||!tank.buff(Lifebloom)', 'tank'},

	{'Cenarion Ward', 'talent(1,2)&!tank.buff(Cenarion Ward)', 'tank'},
	{'Cenarion Ward', 'talent(1,2)&!tank2.buff(Cenarion Ward)', 'tank2'},
	{'Cenarion Ward', 'talent(1,2)', 'lnbuff(Cenarion Ward)'},

	{'Wild Growth', 'lowest.area(30,75).heal>2', 'lowest'},
	{'Essence of G\'Hanir', 'player.area(30,75).heal>2'},
	{'Flourish', 'talent(7,3)&player.lastcast(Wild Growth)&lowest.health<60'},

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
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Mitigations},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'%dispelall', 'toggle(disp)'},
	{xHealing, '!player.moving'},
	{Moving, 'player.moving'},
	{DPS, 'toggle(xDPS)&lowest.health>=UI(k_DPSHP)'},
	{Rejuvenation, 'toggle(xRejuv)'},
	{Fel_Explosives, 'range<=40'},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
}

NeP.CR:Add(105, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Restoration',
	ic =  {{inCombat, '!player.channeling(Tranquility)'}},
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
