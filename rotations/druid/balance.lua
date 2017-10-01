local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
	--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',								key = 'prepot', 			default = false},
	{type = 'combo',		default = "1",																						key = "list", 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',															align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FBalance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/2 - 3/X - 4/X - 5/2 - 6/3 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
	{'Moonkin Form', '!buff&!player.buff(Travel Form)', 'player'},
	{'Blessing of the Ancients', '!buff(Blessing of Elune)', 'player'},
	{'%pause', 'player.buff(Shadowmeld)'},
	-- Pots
	{'#127844', '{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3', 'player'}, 	--XXX: Potion of the Old War
	{'#127843', '{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3', 'player'}, 	--XXX: Potion of Deadly Grace
	{'#142117', '{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3', 'player'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)', 'player'},	--XXX: Flask of the Seventh Demon
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Interrupts = {
	{'!Skull Bash'},
	{'!Typhoon', 'talent(4,3)'},
	{'!Mighty Bash', 'talent(4,1)'},
}

local Interrupt_Random = {
	{'!Skull Bash', nil, 'enemies'},
	{'!Typhoon', 'talent(4,3)&combat&alive', 'enemies'},
	{'!Mighty Bash', 'talent(4,1)', 'enemies'},
}

local Survival = {
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<85'},
	{'Swiftmend', 'talent(3,3)&player.health<85', 'player'},
}

local Cooldowns = {
	{'Incarnation: Chosen of Elune', 'astralpower>75&!player.buff(The Emerald Dreamcatcher)'},
	{'Astral Communion', 'astralpower.deficit>75&player.buff(The Emerald Dreamcatcher)', 'player'},
	{'Blood Fury', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{'Berserking', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)', 'target'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Celestial_Alignment = {
	{'Starfall', '{target.area(15).enemies>1&talent(5,3)||target.area(15).enemies>2}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Starsurge', 'target.area(15).enemies<3'},
	{'Warrior of Elune', ''},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astralpower.deficit>12||player.buff(Incarnation: Chosen of Elune)}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains'},
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>1'},
	{'Solar Wrath'},
}

local Emerald_Dreamcatcher = {
	{'Celestial Alignment', 'astralpower>75&!player.buff(The Emerald Dreamcatcher)'},
	{'Starsurge', '{player.buff(The Emerald Dreamcatcher).remains<gcd.max}||astralpower>80||{{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astralpower>75}', 'target'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&debuff.remains<7.2&astralpower>05}', 'target'},
	{'Moonfire', '{talent(7,3)&debuff.remains<3}||{debuff.remains<6.6&!talent(7,3)}', 'target'},
	{'Sunfire', '{talent(7,3)&debuff.remains<3}||{debuff.remains<5.4&!talent(7,3)}', 'target'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Solar Wrath).execute_time&astralpower>02&dot(Sunfire).remains<5.4&dot(Moonfire).remains>6.6'},
	{'Lunar Strike', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Lunar Strike).execute_time&astralpower>7&{!{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}||{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astralpower<87}', 'target'},
	{'New Moon', 'astralpower<100', 'target'},
	{'Half Moon', 'astralpower<90', 'target'},
	{'Full Moon', 'astralpower<70', 'target'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)', 'target'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)', 'target'},
	{'Solar Wrath', 'astralpower<100', 'target'},
}

local Fury_of_Elune = {
	{'Incarnation: Chosen of Elune', 'astralpower>85&cooldown(Fury of Elune).remains<=gcd'},
	{'Fury of Elune', 'astralpower>85'},
	{'New Moon', '{{cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges==3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astralpower<100}}'},
	{'Half Moon', '{{cooldown(New Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges==3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astralpower<90}}'},
	{'Full Moon', '{{cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges==3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astralpower<70}}'},
	{'Astral Communion', 'player.buff(Fury of Elune)&astralpower.deficit>75'},
	{'Warrior of Elune', 'player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>25&player.buff(Lunar Empowerment)}'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'New Moon', 'astralpower.deficit>0&player.buff(Fury of Elune)'},
	{'Half Moon', 'astralpower.deficit>10&player.buff(Fury of Elune)&astralpower>action(Half Moon).cast_time*12'},
	{'Full Moon', 'astralpower.deficit>30&player.buff(Fury of Elune)&astralpower>action(Full Moon).cast_time*12'},
	{'Moonfire', '!player.buff(Fury of Elune)&target.dot(Moonfire).remains<7.6'},
	{'Sunfire', '!player.buff(Fury of Elune)&target.dot(Sunfire).remains<6.4'},
	{'Stellar Flare', 'target.dot(Stellar Flare).remains<8.2&player.area(40).enemies==1'},
	{'Starfall', '{target.area(15).enemies>1&talent(5,3)||target.area(15).enemies>2}&player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>10', 'target.ground'},
	{'Starsurge', 'target.area(15).enemies<3&!player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>7'},
	{'Starsurge', '!player.buff(Fury of Elune)&{{astralpower>82&cooldown(Fury of Elune).remains>gcd*3}||{cooldown(Warrior of Elune).remains<6&cooldown(Fury of Elune).remains>25&player.buff(Lunar Empowerment).stack<2}}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack==3||{player.buff(Lunar Empowerment).remains<5&buff(Lunar Empowerment)}||target.area(5).enemies>1'},
	{'Solar Wrath'},
}

local Single_Target = {
	{'New Moon', 'astralpower.deficit>0'},
	{'Half Moon', 'astralpower.deficit>10'},
	{'Full Moon', 'astralpower.deficit>30'},
	{'Starfall', '{target.area(15).enemies>1&talent(5,3)||target.area(15).enemies>2}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Starsurge', 'player.area(40).enemies<3&{player.buff(Solar Empowerment).stack<3||player.buff(Lunar Empowerment).stack<3}'},
	{'Warrior of Elune'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)&{astralpower.deficit>8||{astralpower.deficit>12&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)&{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains&{astralpower.deficit>8||{astralpower.deficit>12&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}'},
	{'Lunar Strike', '{astralpower.deficit>12||{astralpower.deficit>18&{player.buff(Incarnation: Chosen of Elune)}||player.buff(Celestial Alignment}}&{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>1'},
	{'Solar Wrath'},
}

local xCombat = {
	{'Blessing of the Ancients', 'player.area(40).enemies<3&talent(6,3)&!player.buff(Blessing of Elune)', 'player'},
	{'Blessing of the Ancients', 'player.area(40).enemies>2&talent(6,3)&!player.buff(Blessing of An\'she)', 'player'},
	{Fury_of_Elune, 'talent(7,1)&cooldown(Fury of Elune).remains<target.ttd'},
	{Emerald_Dreamcatcher, 'equipped(137062)'},
	{'New Moon', 'cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges==3', 'target'},
	{'Half Moon', 'cooldown(Half Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges==3||{ttd<15&cooldown(Half Moon).charges<3}', 'target'},
	{'Full Moon', 'cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges==3||ttd<15', 'target'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&target.debuff(Stellar Flare).remains<7.2&astralpower>50}', 'target'},
	{'Moonfire', '{talent(7,3)&target.debuff(Moonfire).remains<3}||{target.debuff(Moonfire).remains<6.6&!talent(7,3)}', 'target'},
	{'Sunfire', '{talent(7,3)&target.debuff(Sunfire).remains<3}||{target.debuff(Sunfire).remains<5.4&!talent(7,3)}', 'target'},
	{'Astral Communion', 'astralpower.deficit>75', 'player'},
	{'Incarnation: Chosen of Elune', 'astralpower>30', 'player'},
	{'Celestial Alignment', 'astralpower>30', 'player'},
	{'Starfall', 'player.buff(Oneth\'s Overconfidence)', 'target.ground'},
	{'Solar Wrath', 'player.buff(Solar Empowerment).stack==3&area(5).enemies', 'target'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack==3', 'target'},
	{Celestial_Alignment, 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{Single_Target},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<40'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Mythic_Plus, 'range<=40'},
	{xCombat, 'target.range<40&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(102, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Balance',
	pooling = true,
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
