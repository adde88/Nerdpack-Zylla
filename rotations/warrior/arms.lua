local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',						align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Heroic Leap|r',			align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',									align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',									align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 																		key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																align = 'center'},
	{type = 'combo',		default = 'normal',																							key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',															align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 									key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',				key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																									key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 														key = 'LJ',						spin = 4,	step = 1,	max = 20,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																				key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																				key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 								key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 		size = 16, text = 'Survival',																	align = 'center'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarrior |cffADFF2FArms |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/2 - 5/3 - 6/1 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127850', 'ingroup&item(127850).usable&item(127850).count>0&UI(prepot)&!buff(Flask of Ten Thousand Scars)'},														--XXX: Flask of Ten Thousand Scars
	{'#127849', 'item(127850).count==0&ingroup&item(127849).usable&item(127849).count>0&UI(prepot)&!buff(Flask of the Countless Armies)'},		--XXX: Flask of the Countless Armies (IF WE DON'T HAVE THOUSAND SCARS FLASKS)
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},																		--XXX: Lightforged Augment Rune
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'!Pummel'},
	{'!Arcane Torrent', 'inMelee&cooldown(Pummel).remains>gcd&!player.lastgcd(Pummel)'},
}

local Survival = {
	{'Victory Rush', 'player.health<UI(vr_spin)&UI(vr_check)'},
}

local Cooldowns = {
	{'Blood Fury', 'buff(Battle Cry)', 'player'},
	{'Berserking', 'buff(Battle Cry)', 'player'},
	{'Arcane Torrent', 'buff(Battle Cry)&talent(6,1)&rage.deficit>40', 'player'},
	{'Battle Cry', '{player.buff(Bloodlust)||xtime>0}&gcd.remains<0.5&{player.buff(Shattered Defenses)||{cooldown(Colossus Smash).remains>gcd&cooldown(Warbreaker).remains>gcd}}', 'player'},
	{'Avatar', 'talent(3,3)&{buff(Bloodlust)||xtime>0}', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Etc = {
	{Cooldowns, 'toggle(Cooldowns)'},
	--{'Hamstring', 'player.buff(Battle Cry)&talent(6,1)&!target.debuff(Hamstring)'},	--waste of player.rage i would say unless ... it's PvP, maybe?
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<gcd'},
	--# The tl;dr of this line is to spam focused player.rage inside battle cry, the added nonsense is to help modeling the difficulty of timing focused player.rage immediately after mortal strike.
	--# In game, if focused player.rage is used the same instant as mortal strike, player.rage will be deducted for focused player.rage, the buff is immediately consumed, but it does not buff the damage of mortal strike.
	{'Focused Rage', 'player.buff(Battle Cry)&talent(6,1)&player.buff(Focused Rage).stack<3'},
	{'Colossus Smash', '!target.debuff(Colossus Smash)'},
	{'Warbreaker', 'artifact(Warbreaker).equipped&!target.debuff(Colossus Smash)'},
	{'Ravager', 'talent(7,3)'},
	{'Overpower', 'player.buff(Overpower!)'}
}

local AoE = {
	{'Mortal Strike', 'player.buff(Focused Rage).stack>1'},
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)'},
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<5.5'},
	{'Bladestorm'},
	{'Cleave'},
	{'Execute', 'player.rage>80'},
	{'Whirlwind', 'player.rage>30'},
	{'Shockwave', 'talent(2,1)'},
	{'Storm Bolt', 'talent(2,2)'}
}

local Cleave = {
	{'Mortal Strike', 'player.buff(Focused Rage).stack>1'},
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)'},
	{'Focused Rage', '!player.buff(Shattered Defenses)'},
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<5.5'},
	{'Bladestorm'},
	{'Cleave'},
	{'Whirlwind', 'player.rage>000||player.buff(Focused Rage).stack=3'},
	{'Shockwave', 'talent(2,1)'},
	{'Storm Bolt', 'talent(2,2)'}
}

local Execute = {
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).stack=3'},
	{'Execute', 'player.buff(Battle Cry)&talent(6,1)'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)&player.rage<40'},
	{'Execute', 'player.buff(Shattered Defenses)&player.rage>22'},
	{'Execute', '!player.buff(Shattered Defenses)&{{equipped(137060)&rage>40}||!equipped(137060)}'},
	{'Mortal Strike', 'equipped(137060)'},
	{'Execute', '!player.buff(Shattered Defenses)'},
	{'Bladestorm'},
}

local ST = {
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).stack>0&cooldown(Battle Cry).remains<gcd'},
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	{'Warbreaker', '!player.buff(Shattered Defenses)&cooldown(Mortal Strike).remains<gcd'},
	{'Focused Rage', '{{{!player.buff(Focused Rage)&prev_gcd(Mortal Strike)}||!prev_gcd(Mortal Strike)}&player.buff(Focused Rage).stack<3&{player.buff(Shattered Defenses)||cooldown(Colossus Smash).remains>gcd}}&player.rage>60'},
	{'Mortal Strike', 'player.buff(Focused Rage).stack>0'},
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	--Whirlwind instead of Slam if 'Fevor of Battle' is picked
	{'Whirlwind', 'talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).stack=3||rage.deficit<40}'},
	{'Slam', '!talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).stack=3||rage.deficit<40}'},
	{'Mortal Strike', '!talent(5,3)'},
	{'Whirlwind', 'player.area(8).enemies>1||talent(3,1)&player.rage>35'},
	{'Slam', '!talent(3,1)&player.area(8).enemies==1&player.rage>22'},
	{'Execute', 'equipped(137060)'},
	{'Focused Rage', 'equipped(137060)'},
	{'Bladestorm'},
}

local xCombat = {
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)&toggle(xIntRandom)', 'enemies'},
	{Cooldowns, 'toggle(Cooldowns)&inMelee'},
	{Etc, 'inMelee&inFront'},
	{Cleave, 'toggle(aoe)&player.area(8).enemies>1&talent(1,3)'},
	{AoE, 'toggle(aoe)&player.area(8).enemies>4&!talent(1,3)'},
	{Execute, 'inMelee&inFront&health<30&player.area(8).enemies<5'},
	{ST, 'inMelee&inFront&health>20'},
}

local inCombat = {
	{Keybinds},
	{Survival, nil, 'player'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.Condition.Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{Mythic_Plus, 'inMelee'},
}

local outCombat = {
	{Keybinds},
	{PreCombat, nil, 'player'},
}

NeP.CR.Add(71, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warrior - Arms',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})

--[[
TODO:

Opener:
Charge
Focused Rage -> Colossus Smash
Focused Rage -> Battle Cry
Avatar
Mortal Strike
Focused Rage -> Colossus Smash (Slam if Tactician didn’t proc)
Focused Rage -> Colossus Smash (Slam if Tactician didn’t proc, or if you have Shattered Defenses)
Focused Rage -> Mortal Strike (Slam if Tactician didn’t proc)

Standard Rotation/Priority list:
Above 20%:
Use Colossus Smash and Mortal Strike on cooldown (Don't overwrite Shattered Defenses).
If you get a Colossus Smash proc, do Colossus Smash Focused Rage -> Mortal Strike.
Use slam when above 32 rage and both Colossus Smash and Mortal Strike are on cd.
Use Focused Rage to not avoid ragecapping (about 25 rage from cap).

Below 20%:
Use Colossus Smash on CD (Don't overwrite Shattered Defenses) -> 22 (18 with Dauntless and 3/3 PS) rage
Execute with the Shattered Defenses -> spam Execute when you don’t have Shattered Defenses.
Use Focused Rage if you're about to rage cap (about 25 rage from cap), save Focused Rage stacks for Battle Cry.

Battle Cry Rotation:
Above 20%:
Colossus Smash -> Battle Cry
Focused Rage
Mortal Strike -> Focused Rage
Colossus Smash (Slam if no Colossus Smash) -> Focused Rage
Colossus Smash (Slam if no Colossus Smash, or Shattered Defenses proc) -> Mortal Strike (Colossus Smash if Mortal Strike isn't up and no Shattered Defenses buff, Slam if neither Colossus Smash/Mortal Strike is up)
Below 20%:
Colossus Smash -> Battle Cry
Execute
Focused Rage -> Execute
Focused Rage -> Execute
Focused Rage -> x3 Focused Rage
Mortal Strike (Only use Colossus Smash if the debuff isn’t on the target. 2 Executes are more damage than 1 Colossus Smash + 1 Shattered Defenses Execute)
--]]
