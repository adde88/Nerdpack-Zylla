local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Tar Trap', align = 'center'},
	{type = 'text', 	text = 'Left Alt: Binding Shot', align = 'center'},
	{type = 'text', 	text = 'Right Alt: Freezing Trap', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Summon Pet', key = 'kPet', default = true},
	{type = 'checkbox', text = 'Barrage Enabled', key = 'kBarrage', default = false},
  {type = 'checkbox', text = 'Volley Enabled', key = 'kVolley', default = true},
	{type = 'checkbox', text = 'Misdirect Focus/Pet', key = 'kMisdirect', default = true},
	{type = 'ruler'},	{type = 'spacer'},
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHunter |cffADFF2FBeast Mastery [EMPTY] |r')
	print('|cffADFF2F --- |rEMPTY DEV. PROFILE')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'example',
		name = 'Example',
		text = 'Example Toggle.',
		icon = 'Interface\\Icons\\ability_hunter_misdirection',
	})

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Tar Trap', 'keybind(lcontrol)', 'target.ground'},
	{'Freezing Trap', 'keybind(lalt)', 'target.ground'},
}

local inCombat = {
	{'Binding Shot', nil, 'target.ground'},
	{Keybinds},
}

local outCombat = {
	{'Binding Shot', nil, 'target.ground'},
	{Keybinds},
}

NeP.CR:Add(253, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Beast Mastery [EMTPTY]',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
