local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', 										align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', 							align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', 			align = 'center'},
	{type = 'text', 	text = 'Left Alt: ',			align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- General
	{type = 'spacer'},	{type = 'rule'},
	{type = 'header', 	text = 'General', 										align = 'center'},
	{type = 'checkbox', text = 'Automatic Res', 								key = 'auto_res', 		default = true},
	{type = 'checkbox', text = 'Pause Enabled', 								key = 'kPause', 		default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- HEALING
	{type = 'header', 	text = 'Healing',										align = 'center'},
	{type = 'spinner',	text = 'Soothing Mist - Below %', 						key = 'Cap_SM',			default = 100},
	{type = 'spinner', 	text = '',												key = '',				default = 0},
	{type = 'spinner',	text = '',												key = '',				default = 0},
	{type = 'spinner',	text = '',												key = '',				default = 0},
	{type = 'spinner',	text = '',												key = '',				default = 0},
	{type = 'spinner',	text = '',												key = '',				default = 0},
	{type = 'spinner',	text = '',												key = '',				default = 0},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms/etc.',						align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1',								key = 'kT1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2',								key = 'kT2',			default = false},
	{type = 'checkbox', text = 'Ring of Collapsing Futures',					key = 'kRoCF',			default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP',			key = 'k_HEIR',			default = true},
	{type = 'spinner',	text = '',												key = 'k_HeirHP',		default = 40},
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
	{'%pause', 'keybind(lshift)&UI(kPause)'},
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
}

local inCombat = {
	{xCombat},
	{Keybinds}
}

local outcombat = {
	{Keybinds},
}

NeP.CR:Add(270, {
  name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Monk - Mistweaver',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
--	blacklist = Zylla.Blacklist
})
