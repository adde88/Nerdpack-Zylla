local _, Zylla = ...
local GUI = {
}
local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMAGE |cffADFF2FFrost |r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffADFF2FVERSION 1 : RoF+IN+CS|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/1 - 5/1 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffADFF2FVERSION 2 : BC+FT+TV |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/1 - 3/2 - 4/2 - 5/1 - 6/1 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
	{'@Zylla.Targeting()', {'!target.alive&toggle(AutoTarget)'}},
}

local PreCombat = {
	{'Summon Water Elemental', '!pet.exists'},
}

local Cooldowns = {
	--{'Time Warp', '{xtime=0&!player.buff(Bloodlust)}||{!player.buff(Bloodlust)&xequipped(132410)}'},
	{'Rune of Power', '!player.buff(Rune of Power)&{cooldown(Icy Veins).remains<cooldown(Rune of Power).cast_time||cooldown(Rune of Power).charges<1.9&cooldown(Icy Veins).remains>10||player.buff(Icy Veins)||{target.time_to_die+5<cooldown(Rune of Power).charges*10}}'},
	{'Icy Veins', '!player.buff(Icy Veins)'},
	{'Mirror Image'},
	{'Blood Fury'},
	{'Berserking'},
	--{'#Deadly Grace'},
}

local xCombat = {
	{'Ice Lance', '!player.buff(Fingers of Frost)&prev_gcd(Flurry)'},
	{Cooldowns, 'toggle(cooldowns)'},
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
	{'Ice Floes', 'gcd.remains<0.2&xmoving=1&!prev_gcd(Ice Floes)&!player.buff(Ice Floes)'},
	{'Summon Water Elemental', '!pet.exists'},
	{'Frostbolt', 'xmoving=0||player.buff(Ice Floes)'},
}


local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}

local Interrupts = {
	{'Counterspell'},
	{'Arcane Torrent', 'target.range<=8&spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)'},
}

local Survival = {

}

local inCombat = {
	{_Zylla},
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<40'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<40&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(64, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] MAGE - Frost',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
