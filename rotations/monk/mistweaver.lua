local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	--XXX: Header
	{type = 'header',  	size = 16, text = 'Keybinds',											align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',						align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
  --{type = 'checkbox', text = 'Enable Chatoverlay', 												key = 'chat', 				width = 55, 		default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',										align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',										key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',								key = 'prepot', 			default = false},
	{type = 'combo',	default = '1',															key = 'list',				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 									key = 'LJ',					spin = 4, step = 1, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'ruler'},	{type = 'spacer'},
	--XXX: HEALING
	{type = 'header', 	size = 16, text = 'Healing:',									align = 'center'},
	{type = 'checkspin',text = 'Soothing Mist - Below %', 										key = 'sm',					spin = 100, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'spinner', 	text = '',																key = '',					default = 0},
	{type = 'spinner',	text = '',																key = '',					default = 0},
	{type = 'spinner',	text = '',																key = '',					default = 0},
	{type = 'spinner',	text = '',																key = '',					default = 0},
	{type = 'spinner',	text = '',																key = '',					default = 0},
	{type = 'spinner',	text = '',																key = '',					default = 0},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad=function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMonk |cffADFF2FMistweaver  |r')
	print('|cffADFF2F --- |rRecommended Talents:  In development.')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		-- Dispels
		key = 'dispels',
		name = 'Detox',
		text = 'Enable/Disable: Automatic Removal of Poison and Diseases',
		icon = 'Interface\\ICONS\\spell_holy_renew',
	})

	NeP.Interface:AddToggle({
	 key = 'xIntRandom',
	 name = 'Interrupt Anyone',
	 text = 'Interrupt all nearby enemies, without targeting them.',
	 icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

 NeP.Interface:AddToggle({
 	key = 'xDPS',
 	name = 'Enable DPS',
 	text = 'Use damaging abilites when possible, between healing!',
 	icon = 'Interface\\Icons\\spell_fire_lavaspawn',
 })

end

local PreCombat = {

}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Heals = {
	--XXX: {'&Soothing Mist', '', ''},
  -- Cocoon	TANK + LOWEST
	--XXX: Effuse: LOWEST + Emergency
	{'&Effuse', 'player.mana>80&health<87', 'lowest'},
	{'&Effuse', 'player.mana>70&health<80', 'lowest'},
	{'&Effuse', 'player.mana>60&health<70', 'lowest'},
	{'&Effuse', 'player.mana>50&health<60', 'lowest'},
	{'&Effuse', 'health<30', 'lowest'},
	--XXX: Life Cocoon: TANK + LOWEST
	{'&Life Cocoon', 'health<51&incdmg(3)>health.max*0.1', 'tank'},
  {'&Life Cocoon', 'health<37&incdmg(3)>health.max*0.1', 'lowest'},
	--XXX: Refreshin Jade Wind: PLAYER
  {'&Refreshing Jade Wind', '{mana>24&moving&area(10,80).heal>1}||area(10,75).heal>2||{mana>70&area(10,86).heal>4}||{mana>50&area(10,86).heal>2}', 'player'},
  --XXX: Zen Pulse	TANK + LOWEST + PLAYER
	{'&Zen Pulse', 'health<95&area(10).enemies>0', 'tank'},
  {'&Zen Pulse', 'health<90&area(10).enemies>0', 'lowest'},
  {'&Zen Pulse', 'health<90&area(10).enemies>0', 'player'},
	--XXX: Enveloping Mist:	TANK
  {'&Enveloping Mist', '!player.lastcast&!player.lastgcd&health<80&!buff', 'tank'},
  {'&Enveloping Mist', '!player.lastcast&!player.lastgcd&health<80&!buff', 'tank'},
  {'&Enveloping Mist', '!player.lastcast&!player.lastgcd&player.mana>75&health<90&!buff', 'tank'},
	--XXX: Renewing Mist: TANK + LOWEST
	{'&Renewing Mist', '!buff&player.mana>33', {'tank', 'tank2'}},
	{'&Renewing Mist', 'player.mana>70&health<100&!buff', 'lowest'},
	{'&Renewing Mist', 'player.mana>40&&lnbuff(Renewing Mist)', 'lowest'},
	{'&Renewing Mist', 'incdmg(6)>health.max*0.01&player.mana>40&!buff', 'lowest'},
	{'&Renewing Mist', 'mana>40&!buff', 'player'},
	--XXX: Sheilun's Gift:	TANK + LOWEST
  {'&Sheilun\'s Gift', 'spell(Sheilun\'s Gift).charges>4&health<65', 'tank'},
  {'&Sheilun\'s Gift', 'spell(Sheilun\'s Gift).charges>4&health<65', 'lowest'},
  {'&Sheilun\'s Gift', 'player.mana<20&health<80', 'lowest'},
	--XXX: Vivify: TANK + LOWEST
  {'&Vivify', 'player.buff(Thunder Focus Tea)&health<90', 'tank'},
  {'&Vivify', 'player.buff(Thunder Focus Tea)&health<90', 'lowest'},
	{'&Vivify', 'player.buff(Thunder Focus Tea)&health<85', 'lowest'},
  {'&Vivify', 'player.buff(Uplifting Trance)&area(30,75).heal>1', 'lowest'},
  {'&Vivify', 'area(30,50).heal==2||area(15,50).heal==3 ', 'lowest'},
	--XXX: Essence Font: PLAYER
  {'&Essence Font', 'mana>35&!lastcast&!lastgcd&area(25,70).heal>3', 'player'},
  {'&Essence Font', 'mana>35!channeling(Essence Font)&area(25,50).heal>3', 'player'},
}

local AoE = {
	{'Zen Pulse', 'target.area(10).enemies>2'},
	{'Chi Burst'}
}

local Cooldowns = {
	{'&Revival', 'toggle(cooldowns)&{area(40,50).heal>7||area(40,80).heal>11||area(40,85).heal>15||area(40,70).heal>10||area(40,60).heal>8||area(40,65).heal>6||area(40,30).heal>4||area(40,20).heal>2}', 'player'},
	{'Thunder Focus Tea'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local DPS = {

}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)', 'target'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)', 'enemies'},
	{Mythic_Plus, 'inMelee'},
	{DPS, 'toggle(xDPS)', 'target'},
}

local outCombat={
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(268, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Mistweaver',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
