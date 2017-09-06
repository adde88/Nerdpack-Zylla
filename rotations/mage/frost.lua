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
	{type = 'checkbox', text = 'Use Timewarp', key = 'kTW', default = false},
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
	print('|cffADFF2F --- |rMage |cffADFF2FFrost |r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffADFF2FVERSION 1 : RoF+IN+CS|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/1 - 5/1 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffADFF2FVERSION 2 : BC+FT+TV |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/1 - 3/2 - 4/2 - 5/1 - 6/1 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
	{'Summon Water Elemental', '!pet.exists'},
}

local Cooldowns = {
	{'Time Warp', 'UI(kTW)&{xtime==0&!player.buff(Bloodlust)}||{!player.buff(Bloodlust)&xequipped(132410)}'},
	{'Rune of Power', '!player.buff(Rune of Power)&{cooldown(Icy Veins).remains<cooldown(Rune of Power).cast_time||cooldown(Rune of Power).charges<1.9&cooldown(Icy Veins).remains>10||player.buff(Icy Veins)||{target.time_to_die+5<cooldown(Rune of Power).charges*10}}'},
	{'Icy Veins', '!player.buff(Icy Veins)'},
	{'Mirror Image'},
	{'Blood Fury'},
	{'Berserking'},
}

local xCombat = {
	{'Ice Lance', '!player.buff(Fingers of Frost)&prev_gcd(Flurry)'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Blizzard', 'player.buff(Potion of Deadly Grace)&!target.debuff(Water Jet)'},
	{'!Ice Nova', 'target.debuff(Winter\'s Chill)'},
	{'Frostbolt', 'target.debuff(Water Jet).remains>action(Frostbolt).cast_time&player.buff(Fingers of Frost).stack<2'},
	{'&Water Jet', 'prev_gcd(Frostbolt)&player.buff(Fingers of Frost).stack<{2+artifact(Icy Hand).enabled}&!player.buff(Brain Freeze)'},
	{'Ray of Frost', 'player.buff(Icy Veins)||{cooldown(Icy Veins).remains>action(Ray of Frost).cooldown&!player.buff(Rune of Power)}'},
	{'Flurry', 'player.buff(Brain Freeze)&!player.buff(Fingers of Frost)&!prev_gcd(Flurry)'},
	{'Glacial Spike'},
	{'Frozen Touch', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).enabled}'},
	{'Frost Bomb', 'target.debuff(Frost Bomb).remains<action(Ice Lance).travel_time&player.buff(Fingers of Frost).stack>0'},
	{'Ice Lance', 'player.buff(Fingers of Frost).stack>0&cooldown(Icy Veins).remains>10||player.buff(Fingers of Frost).stack>2'},
	{'Frozen Orb'},
	{'Ice Nova'},
	{'Comet Storm'},
	{'Blizzard', 'talent(6,3)', 'target.ground'},
	{'Ebonbolt', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).enabled}'},
	{'Ice Barrier', '!player.buff(Ice Barrier)&!player.buff(Rune of Power)'},
	{'Ice Floes', 'gcd.remains<0.2&xmoving==1&!prev_gcd(Ice Floes)&!player.buff(Ice Floes)'},
	{'Summon Water Elemental', '!pet.exists'},
	{'Frostbolt', 'xmoving==0||player.buff(Ice Floes)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'!Counterspell'},
	{'!Arcane Torrent', 'target.inMelee&spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)'},
}

local Survival = {
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<50'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<50&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(64, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Frost',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
