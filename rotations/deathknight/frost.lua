local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
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

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDEATH KNIGHT |cffADFF2FFrost (MACHINEGUN =v required talets v=) |r')
	print('|cffADFF2F --- |rIf you want use MACHINEGUN =v required talents v= AND enable toggle button) |r')
	print('|cffADFF2F --- |rRecommended Talents:  1/2 - 2/2 - 3/3 - 4/X - 5/X - 6/1 - 7/3')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xMACHINEGUN',
		name = 'MACHINEGUN',
		text = 'ON/OFF using MACHINEGUN rotation',
		icon = 'Interface\\Icons\\Inv_misc_2h_farmscythe_a_01',
	})

end

local PreCombat = {

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'!Mind Freeze'},
	{'!Arcane Torrent', 'target.inMelee&spell(Mind Freeze).cooldown>gcd&!prev_gcd(Mind Freeze)'},
}

local Survival = {
	{'Death Strike', 'player.health<80&player.buff(Dark Succor)'},
}

local BoS_check = {
	{'Horn of Winter', 'talent(2,2)&talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
	{'Horn of Winter', 'talent(2,2)&!talent(7,2)'},
	{'Frost Strike', 'talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
	{'Frost Strike', '!talent(7,2)'},
	{'Empower Rune Weapon', 'talent(7,2)&cooldown(Breath of Sindragosa).remains>15&runes<1'},
	{'Empower Rune Weapon', '!talent(7,2)&runes<1'},
	{'Hungering Rune Weapon', 'talent(3,2)&talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
	{'Hungering Rune Weapon', 'talent(3,2)&!talent(7,2)'},
}

local Cooldowns = {
	{'Blood Fury', '!talent(7,2)||target.dot(Breath of Sindragosa).ticking'},
	{'Berserking', 'player.buff(Pillar of Frost)'},
	{'Pillar of Frost'},
	{'Sindragosa\'s Fury', 'player.buff(Pillar of Frost)&target.debuff(Razorice).count>4'},
	{'Obliteration'},
	{'Breath of Sindragosa', 'talent(7,2)&runic_power>40'},
	{BoS_check},
}

local Core = {
	{'Frostscythe', 'talent(6,1)&!talent(7,2)&{player.buff(Killing Machine)||player.area(8).enemies>3}'},
	{'Glacial Advance', 'talent(7,3)'},
	{'Frost Strike', 'player.buff(Obliteration)&!player.buff(Killing Machine)'},
	{'Obliterate', 'player.buff(Killing Machine)'},
	{'Obliterate'},
	{'Remorseless Winter', '!cooldown(Remorseless Winter)'},
	{'Frostscythe', 'talent(6,1)&talent(2,2)'},
	{'Howling Blast', 'talent(2,2)'},
}

local IcyTalons = {
	{'Frost Strike', 'player.buff(Icy Talons).remains<1.5'},
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
	{'Howling Blast', 'player.buff(Rime)'},
	{'Frost Strike', 'runic_power>70||player.buff(Icy Talons).stack<3'},
	{Core},
	{BoS_check},
}

local BoS = {
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
	{Core},
	{'Horn of Winter', 'talent(2,3)'},
	{'Empower Rune Weapon', 'runic_power<80'},
	{'Hungering Rune Weapon', 'talent(3,2)'},
	{'Howling Blast', 'player.buff(Rime)'},
}

local Generic = {
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
	{'Howling Blast', 'player.buff(Rime)'},
	{'Frost Strike', 'runic_power>70'},
	{Core},
	{BoS_check},
}

local Shatter = {
	{'Frost Strike'},
	{'Howling Blast'},
	{'Howling Blast'},
	{'Frost Strike'},
	{Core},
	{BoS_check},
}

local MACHINEGUN = {
	{'Frost Strike', 'player.buff(Icy Talons).remains<1.5'},
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
	{'Howling Blast', 'player.buff(Rime)'},
	{'Frost Strike', 'runic_power>70||player.buff(Icy Talons).stack<3'},
	{'Frostscythe', 'talent(6,1)&!talent(7,2)&{player.buff(Killing Machine)||player.area(8).enemies>3}'},
	{'Glacial Advance', 'talent(7,3)'},
	{'Frost Strike', 'player.buff(Obliteration)&!player.buff(Killing Machine)'},
	{'Remorseless Winter', '!cooldown(Remorseless Winter)'},
	{'Obliterate', '!talent(6,1)&player.buff(Killing Machine)'},
	{'Obliterate', 'talent(6,1)&!player.buff(Killing Machine)'},
	{'Frostscythe', 'talent(6,1)&talent(2,2)'},
}

local xCombat = {
	{BoS, 'target.dot(Breath of Sindragosa).ticking'},
	{Shatter, 'talent(1,1)'},
	{IcyTalons, 'talent(1,2)'},
	{Generic, '!talent(1,1)&!talent(1,2)'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<25'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)&target.inMelee'},
	{MACHINEGUN, 'toggle(xMACHINEGUN)&target.inMelee&target.inFront'},
	{xCombat, '!toggle(xMACHINEGUN)&target.inMelee&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}
NeP.CR:Add(251, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death Knight - Frost',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
