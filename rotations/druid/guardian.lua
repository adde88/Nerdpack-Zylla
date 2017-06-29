local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']
local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
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
	{'%pause', 'keybind(lshift)&UI(kPause)'},
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
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<=75'},
	--{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
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
	{'Moonfire', 'player.buff(Galactic Guardian)&rage.deficit>=20'},
	{'Pulverize', 'talent(7,3)&!player.buff(Pulverize)'},
	{'Mangle'},
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<gcd'},
	{'Lunar Beam'},
	{'Incarnation: Guardian of Ursoc'},
	{'Thrash', 'player.area(8).enemies>=2'},
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
	{'Thrash', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
	{'Moonfire', '!target.dot(Moonfire).ticking||target.dot(Moonfire).remains<=gcd'},
	{'&Maul', 'rage.deficit<=20'},
	{'Swipe'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Bear Form', 'form~=1'},
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
	load = exeOnLoad
})
