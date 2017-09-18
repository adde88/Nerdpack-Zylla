local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Mythic_Plus = _G.Mythic_Plus
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header',  	size = 16, text = 'Keybinds',	 												align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: |cffABD473Pause|r',								align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: |cffABD473Efflorescence|r',				align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: |cffABD473Healing Routine (OOC)|r',	align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: ',																	align = 'left', 			key = 'ralt', 		default = true},
	{type = 'ruler'},	 	{type = 'spacer'},
	-- General Class/Spec Settings
	{type = 'header',	text = 'General Settings',					align = 'center'},
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
		key='xStealth',
		name='Auto Stealth',
		text = 'If Enabled we will automatically use Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
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
	{'Travel Form', 'toggle(xFORM)&movingfor>0.75&!indoors&!buff&!buff(Prowl)', 'player'},
	{'Cat Form', 'toggle(xFORM)&movingfor>0.75&indoors&!buff&!buff(Travel Form)&!buff(Prowl)', 'player'},
	{'Prowl', 'toggle(xFORM)&toggle(xStealth)&!buff', 'player'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Efflorescence', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'Skull Bash', 'player.form>0', 'target'},
	{'!Mighty Bash', nil, 'target'},
}

local Interrupts_Random = {
	{'!Skull Bash', 'interruptAt(70)&player.form>0&toggle(xIntRandom)&toggle(Interrupts)&range<14&combat&alive', 'enemies'},
	{'!Mighty Bash', 'interruptAt(60)&toggle(xIntRandom)&toggle(Interrupts)&inFront&inMelee&combat&alive', 'enemies'},
}

local DPS = {
	{'Moonfire', 'debuff.duration<3&range<41&combat&alive', 'enemies'},
	{'Sunfire', 'debuff.duration<3&range<41&combat&alive', 'enemies'},
	{'Solar Wrath', 'debuff(Moonfire)&debuff(Sunfire)&range<41&combat&alive', 'enemies'},
}

local Innervate = {
	{'Rejuvenation', nil, 'lnbuff(Rejuvenation)'},
	{'Rejuvenation', 'talent(6,3)&buff(Rejuvenation)', 'lnbuff(Rejuvenation (Germination))'},
	{'Regrowth', nil, 'lowest'},
}

local Emergency = {
	{'!Swiftmend', nil, 'lowest'},
	{'!Regrowth', nil, 'lowest'},
}

local Cooldowns = {
	{'Tranquility', 'area(40,75).heal>2', 'player'},
	{'Innervate', 'mana<60', 'player'},
}

local Mitigations = {
	{'Barkskin', 'health<40', 'player'},
	{'Ironbark', 'health<30', '{tank, lowest}'},
	--{'Ironbark', 'health<30', 'lowest'},
}

local Moving = {
	{'Lifebloom', 'buff.duration<5.5&health>=UI(tsm)||!buff(Lifebloom)', 'tank'},
	-- Wardz
	{'Cenarion Ward', '!buff', {'tank', 'tank2', 'lowest'}},
	-- Rejuvzzzz
	{'Rejuvenation', 'health<=UI(trejuv)&!buff', {'tank', 'tank2'}},
	{'Rejuvenation', 'health<=UI(lrejuv)', 'lnbuff(Rejuvenation)'},
	-- Germs
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(lgerm)', {'tank', 'tank2'}},
	{'Rejuvenation', 'talent(6,3)&buff&health<=UI(lgerm)', 'lnbuff(Rejuvenation (Germination))'},
	-- Swifties
	{'Swiftmend', 'health<=UI(tsm)', {'tank', 'tank2'}},
	{'Swiftmend', 'health<=UI(lsm)', 'lowest'},
}

local Mass_Rejuv = {
	{'Rejuvenation', 'range<41&combat&alive&count.friendly.buffs<UI(REJUV_UNITS)&buff.duration<3&health<=UI(MASS_REJUV_HP)', 'lowest'}
}

local xHealing = {
	{Emergency, 'lowest.health<=UI(k_CH)'},
	{Innervate, 'player.buff(Innervate)'},
	{'Lifebloom', 'buff.duration<5.5&health>=UI(tsm)||!buff(Lifebloom)', 'tank'},
	{'Cenarion Ward', '!buff', {'tank', 'tank2', 'lowest'}},
	{'Wild Growth', 'area(30,75).heal>2', 'lowest'},
	{'Essence of G\'Hanir', 'area(30,75).heal>2', 'lowest'},
	{'Flourish', 'lastcast(Wild Growth)&lowest.health<60', 'player'},
	{'Regrowth', 'player.buff(Clearcasting)', 'lowest'},
	-- Rejuvzzzz
	{'Rejuvenation', 'health<=UI(trejuv)&!buff', {'tank', 'tank2'}},
	{'Rejuvenation', 'health<=UI(lrejuv)', 'lnbuff(Rejuvenation)'},
	-- Germination
	{'Rejuvenation', 'talent(6,3)&buff&!buff(Rejuvenation (Germination))&health<=UI(lgerm)', {'tank', 'tank2'}},
	{'Rejuvenation', 'talent(6,3)&buff&health<=UI(lgerm)', 'lnbuff(Rejuvenation (Germination))'},
	-- Swifties
	{'Swiftmend', 'health<=UI(tsm)', {'tank', 'tank2'}},
	{'Swiftmend', 'health<=UI(lsm)', 'lowest'},
	{'Regrowth', 'health<=UI(trg)', {'tank', 'tank2'}},
	{'Regrowth', 'health<=UI(lrg)', 'lowest'},
	{'Healing Touch', 'health<=UI(tht)', {'tank', 'tank2'}},
	{'Healing Touch', 'health<=UI(lht)', 'lowest'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Interrupts_Random},
	{Mitigations},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'%dispelall', 'toggle(disp)'},
	{xHealing, '!player.moving'},
	{Moving, 'player.moving'},
	{DPS, 'toggle(xDPS)&lowest.health>=UI(k_DPSHP)'},
	{Mass_Rejuv, 'toggle(xRejuv)'},
	{Mythic_Plus, 'range<41'},
	{'Cat Form', 'movingfor>0.75&toggle(xFORM)&!buff(Cat Form)&{!buff(Travel Form)||area(8).enemies.inFront>0}', 'player'},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Interrupts_Random}
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
