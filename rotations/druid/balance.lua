local _, Zylla = ...

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
	--# Executed before combat begins. Accepts non-harmful actions only.
	{'Moonkin Form', '!player.buff(Moonkin Form)&!player.buff(Travel Form)'},
	{'Blessing of the Ancients', '!player.buff(Blessing of Elune)'},
	--{'New Moon', 'artifact(New Moon).enabled'},
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

local Survival = {
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<85'},
	{'Swiftmend', 'talent(3,3)&player.health<85', 'player'},
}

local Cooldowns = {
}

local CA = {
	{'Starfall', '{target.area(15).enemies>1&talent(5,3)||target.area(15).enemies>2}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Starsurge', 'target.area(15).enemies<3'},
	{'Warrior of Elune', ''},
	{'Lunar Strike', 'player.buff(Warrior of Elune)'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains'},
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>1'},
	{'Solar Wrath'},
}

local ED = {
	{'Astral Communion', 'astral_power.deficit>65&player.buff(The Emerald Dreamcatcher)'},
	{'Incarnation: Chosen of Elune', 'astral_power>75&!player.buff(The Emerald Dreamcatcher)'},
	{'Celestial Alignment', 'astral_power>75&!player.buff(The Emerald Dreamcatcher)'},
	{'Starsurge', '{player.buff(The Emerald Dreamcatcher).remains<gcd.max}||astral_power>80||{{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astral_power>75}'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&target.debuff(Stellar Flare).remains<7.2&astral_power>05}'},
	{'Moonfire', '{talent(7,3)&target.debuff(Moonfire).remains<3}||{target.debuff(Moonfire).remains<6.6&!talent(7,3)}'},
	{'Sunfire', '{talent(7,3)&target.debuff(Sunfire).remains<3}||{target.debuff(Sunfire).remains<5.4&!talent(7,3)}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Solar Wrath).execute_time&astral_power>02&dot(Sunfire).remains<5.4&dot(Moonfire).remains>6.6'},
	{'Lunar Strike', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Lunar Strike).execute_time&astral_power>7&{!{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}||{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astral_power<87}'},
	{'New Moon', 'astral_power<100'},
	{'Half Moon', 'astral_power<90'},
	{'Full Moon', 'astral_power<70'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath'},
}

local FoE = {
	{'Incarnation: Chosen of Elune', 'astral_power>85&cooldown(Fury of Elune).remains<=gcd'},
	{'Fury of Elune', 'astral_power>85'},
	{'New Moon', '{{cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<100}}'},
	{'Half Moon', '{{cooldown(New Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<90}}'},
	{'Full Moon', '{{cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<70}}'},
	{'Astral Communion', 'player.buff(Fury of Elune)&astral_power<35'},
	{'Warrior of Elune', 'player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>25&player.buff(Lunar Empowerment)}'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astral_power<100||{astral_power<95&player.buff(Incarnation: Chosen of Elune)}}'},
	{'New Moon', 'astral_power<100&player.buff(Fury of Elune)'},
	{'Half Moon', 'astral_power<90&player.buff(Fury of Elune)&astral_power>action(Half Moon).cast_time*12'},
	{'Full Moon', 'astral_power<70&player.buff(Fury of Elune)&astral_power>action(Full Moon).cast_time*12'},
	{'Moonfire', '!player.buff(Fury of Elune)&target.dot(Moonfire).remains<7.6'},
	{'Sunfire', '!player.buff(Fury of Elune)&target.dot(Sunfire).remains<6.4'},
	{'Stellar Flare', 'target.dot(Stellar Flare).remains<8.2&player.area(40).enemies==1'},
	{'Starfall', '{target.area(15).enemies>1&talent(5,3)||target.area(15).enemies>2}&player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>10', 'target.ground'},
	{'Starsurge', 'target.area(15).enemies<3&!player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>7'},
	{'Starsurge', '!player.buff(Fury of Elune)&{{astral_power>82&cooldown(Fury of Elune).remains>gcd*3}||{cooldown(Warrior of Elune).remains<6&cooldown(Fury of Elune).remains>25&player.buff(Lunar Empowerment).stack<2}}'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack=3||{player.buff(Lunar Empowerment).remains<5&buff(Lunar Empowerment)}||target.area(5).enemies>1'},
	{'Solar Wrath'},
}

local ST = {
	{'New Moon', 'astral_power<100'},
	{'Half Moon', 'astral_power<90'},
	{'Full Moon', 'astral_power<70'},
	{'Starfall', '{target.area(15).enemies>1&talent(5,3)||target.area(15).enemies>2}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
	{'Starsurge', 'player.area(40).enemies<3&{player.buff(Solar Empowerment).stack<3||player.buff(Lunar Empowerment).stack<3}'},
	{'Warrior of Elune'},
	{'Lunar Strike', 'player.buff(Warrior of Elune)'},
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains'},
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>1'},
	{'Solar Wrath'},
}

local xCombat = {
	--# Executed every time the actor is available.
	{'#Deadly Grace', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{'Blessing of the Ancients', 'player.area(40).enemies<3&talent(6,3)&!player.buff(Blessing of Elune)'},
	{'Blessing of the Ancients', 'player.area(40).enemies>2&talent(6,3)&!player.buff(Blessing of An\'she)'},
	{'Blood Fury', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{'Berserking', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{FoE, 'talent(7,1)&{cooldown(Fury of Elune).remains<target.time_to_die}'},
	{ED, 'xequipped(137062)'},
	{'New Moon', 'cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges=3'},
	{'Half Moon', 'cooldown(Half Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges=3||{target.time_to_die<15&cooldown(Half Moon).charges<3}'},
	{'Full Moon', 'cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges=3||target.time_to_die<15'},
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&target.debuff(Stellar Flare).remains<7.2&astral_power>05}'},
	{'Moonfire', '{talent(7,3)&target.debuff(Moonfire).remains<3}||{target.debuff(Moonfire).remains<6.6&!talent(7,3)}'},
	{'Sunfire', '{talent(7,3)&target.debuff(Sunfire).remains<3}||{target.debuff(Sunfire).remains<5.4&!talent(7,3)}'},
	{'Astral Communion', 'astral_power.deficit>65'},
	{'Incarnation: Chosen of Elune', 'astral_power>30'},
	{'Celestial Alignment', 'astral_power>30'},
	{'Starfall', 'player.buff(Oneth\'s Overconfidence)', 'target.ground'},
	{'Solar Wrath', 'player.buff(Solar Empowerment).stack=3'},
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack=3'},
	{CA, 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
	{ST},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<50'},
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
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
