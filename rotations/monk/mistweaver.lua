local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Mythic_Plus = _G.Mythic_Plus
local Logo_GUI = _G.Logo_GUI
local PayPal_GUI = _G.PayPal_GUI
local PayPal_IMG = _G.PayPal_IMG
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(PayPal_GUI),
	{type = 'spacer'},
	unpack(PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'spacer'},	{type = 'rule'},
	{type = 'header', 	text = 'General', 																				align = 'center'},
	{type = 'checkbox', text = 'Automatic Res', 																	key = 'auto_res', 		default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- HEALING
	{type = 'header', 	text = 'Healing',																					align = 'center'},
	{type = 'spinner',	text = 'Soothing Mist - Below %', 												key = 'Cap_SM',				default = 100},
	{type = 'spinner', 	text = '',																								key = '',							default = 0},
	{type = 'spinner',	text = '',																								key = '',							default = 0},
	{type = 'spinner',	text = '',																								key = '',							default = 0},
	{type = 'spinner',	text = '',																								key = '',							default = 0},
	{type = 'spinner',	text = '',																								key = '',							default = 0},
	{type = 'spinner',	text = '',																								key = '',							default = 0},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad=function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMonk |cffADFF2FMistweaver  |r')
	print('|cffADFF2F --- |rRecommended Talents:  COMING SOON...')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local AoE = {
	{'Zen Pulse', 'target.area(10).enemies>2'},
	{'Chi Burst'}
}

local xCombat = {
	{'Soothing Mist', '!channeling&health<UI(Cap_SM)&incdmg(5)>health.max', 'lowest'},
	{'Soothing Mist', '!channeling||channeling&health<50', 'tank'},
	{'&Sheilun\'s Gift', 'spell.count>4&health<25', 'lowest'},
	{'&Vivify', 'spell(Renewing Mist).proc', 'lowest'},
	{'&Enveloping Mist', '!buff', {'tank1', 'tank2'}},
	{'&Renewing Mist', 'health<100&ingroup', 'friendly'},
	{'&Effuse', 'health<UI(L_EFF)', 'lowest'},
	{AoE, 'ingroup&area(40, 100).heal>=3', 'friendly'},
	{Mythic_Plus, 'range<=10'}
}

local inCombat = {
	{xCombat},
	{Keybinds}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(270, {
  name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Mistweaver',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
--	blacklist = Zylla.Blacklist
})
