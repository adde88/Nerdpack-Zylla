local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 		key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 			width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FGuardian |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local PreCombat = {
}

local Interrupts = {
	{'!Skull Bash'},
	{'!Typhoon', 'talent(4,3)&cooldown(Skull Bash).remains>gcd'},
	{'!Mighty Bash', 'talent(4,1)&cooldown(Skull Bash).remains>gcd'},
}

local Survival = {
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<85'},
	--{'Swiftmend', 'talent(3,3)&player.health<85', 'player'},
	{'Barkskin'},
	{'Bristling Fur', 'player.buff(Ironfur).remains<2&player.rage<40'},
	{'Mark of Ursol', '!player.buff(Mark of Ursol)&player.incdmg_magic(5)>1'},
	{'Ironfur', '!player.buff(Ironfur)||rage.deficit<25'},
	{'Frenzied Regeneration', '!player.buff(Frenzied Regeneration)&player.incdmg(6)/player.health.max>{0.25+{2-cooldown(Frenzied Regeneration).charges}*0.15}'},
}

local Cooldowns = {
	{'Bloodfury'},
	{'Berserking'},
}

local xCombat = {
	{'Moonfire', 'player.buff(Galactic Guardian)&rage.deficit>10'},
	{'Pulverize', 'talent(7,3)&!player.buff(Pulverize)'},
	{'Mangle'},
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<gcd'},
	{'Lunar Beam'},
	{'Incarnation: Guardian of Ursoc'},
	{'Thrash', 'player.area(8).enemies>1'},
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
	{'Thrash', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
	{'Moonfire', '!target.dot(Moonfire).ticking||target.dot(Moonfire).remains<=gcd'},
	{'&Maul', 'rage.deficit<30'},
	{'Swipe'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Bear Form', 'form~=1'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'target.inMelee&target.inFront'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(104, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Guardian',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
