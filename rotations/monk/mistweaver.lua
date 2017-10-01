--[[
local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

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
	{type = 'checkbox', text = 'Automatic Res', 												key = 'auto_res', 			default = true},
	{type = 'ruler'},	{type = 'spacer'},
	--XXX: HEALING
	{type = 'header', 	size = 16, text = 'Healing/Survival',									align = 'center'},
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

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Heals = {
	--{'&Soothing Mist', '', ''},
	{'&Revival', 'toggle(cooldowns)&{area(40,50).heal>7||area(40,80).heal>11||area(40,85).heal>15||area(40,70).heal>10||area(40,60).heal>8||area(40,65).heal>6||area(40,30).heal>4||area(40,20).heal>2}', 'player'},
    -- Cocoon	TANK + LOWEST
	{'&Life Cocoon', 'health<51&incdmg(3)>health.max*0.1', 'tank'},
    {'&Life Cocoon', 'health<37&incdmg(3)>health.max*0.1', 'lowest'},
	-- Refreshin Jade Wind
    {'&Refreshing Jade Wind', '{mana>24&moving&area(10,80).heal>1}||area(10,75).heal>2||{mana>70&area(10,86).heal>4}||{mana>50&area(10,86).heal>2}', 'player'},
    -- Zen Pulse	TANK + LOWEST + PLAYER
	{'&Zen Pulse', 'health<95&area(10).enemies>0', 'tank'},
    {'&Zen Pulse', 'health<90&area(10).enemies>0', 'lowest'},
    {'&Zen Pulse', 'health<90&area(10).enemies>0', 'player'},
	-- Enveloping Mist	TANK
    {'&Enveloping Mist', '!player.lastcast&!player.lastgcd&health<80&!buff', 'tank'},
    {'&Enveloping Mist', '!player.lastcast&!player.lastgcd&health<80&!buff', 'tank'},
    {'&Enveloping Mist', '!player.lastcast&!player.lastgcd&player.mana>75&health<90&!buff', 'tank'},
	-- Sheilun's Gift	TANK + LOWEST
    {'&Sheilun\'s Gift', 'player.spell(Sheilun\'s Gift).charges>4&health<65', 'tank'},
    {'&Sheilun\'s Gift', 'player.spell(Sheilun\'s Gift).charges>4&health<65', 'lowest'},
    {'&Sheilun\'s Gift', 'player.mana<20&health<80', 'lowest'},
	-- Vivify
    {'&Vivify', 'player.buff(Thunder Focus Tea)&health<90', 'tank'},
    {'&Vivify', 'player.buff(Thunder Focus Tea)&health<90', 'lowest'},
	{'&Vivify', 'player.buff(Thunder Focus Tea)&health<85', 'lowest'},
    {'&Vivify', 'player.buff(Uplifting Trance)&area(30,75).heal>1', 'lowest'},
    {'&Vivify', 'area(30,50).heal==2||area(15,50).heal==3 ', 'lowest'},
	-- Essence Font
    {'&Essence Font', 'mana>35&!lastcast&!lastgcd&area(25,70).heal>3', 'player'},
    {'&Essence Font', 'mana>35!channeling(Essence Font)&area(25,50).heal>3', 'player'},
	-- Renewing Mist
	{'&Renewing Mist', '!buff&player.mana>33', {'tank', 'tank2'}},
    }

local AoE = {
	{'Zen Pulse', 'target.area(10).enemies>2'},
	{'Chi Burst'}
	ooc = outCombat,
--	blacklist =
]]--
