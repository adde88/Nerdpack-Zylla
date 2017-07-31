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
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FRetribution |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/1 - 4/2 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
	{'Greater Blessing of Wisdom', '!player.buff(Greater Blessing of Wisdom)', 'player'},
	{'Greater Blessing of Might', '!player.buff(Greater Blessing of Might)', 'player'},
	{'Greater Blessing of Kings', '!player.buff(Greater Blessing of Kings)', 'player'},
	{'Flash of Light', 'player.health<85'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}
local Survival = {
	{'Lay on Hands', 'player.health<30'},
	{'Flash of Light', 'player.health<50'},
}

local Interrupts = {
	{'!Rebuke'},
	{'!Hammer of Justice', 'cooldown(Rebuke).remains>gcd'},
	{'!Arcane Torrent', 'target.inMelee&cooldown(Rebuke).remains>gcd&!prev_gcd(Rebuke)'},
}

local Cooldowns = {
	{'Holy Wrath'},
	{'Avenging Wrath', '!talent(7,2)'},
	{'Shield of Vengeance'},
	{'Crusade', 'talent(7,2)&holy_power>4'},
	{'Wake of Ashes', 'holy_power>=0&xtime<2'},
	{'Execution Sentence','talent(1,2)&{player.area(6).enemies<4&{cooldown(Judgment).remains<gcd*4.5||target.debuff(judgment).remains>gcd*4.67}&{!talent(7,2)||cooldown(Crusade).remains>gcd*2}}'},
	{'Blood Fury'},
	{'Berserking'},
}

local xCombat = {
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>1&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>1&holy_power>4&player.buff(Divine Purpose)'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>1&holy_power>4&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2&!equipped(Whisper of the Nathrezim)'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&holy_power>4&player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>4&player.buff(Divine Purpose)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>4&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Divine Storm', 'target.debuff(Judgment)&holy_power>2&player.area(6).enemies>1&{cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim)&player.buff(Whisper of the Nathrezim).remains<gcd}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&holy_power>2&player.buff(Divine Purpose)&cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>2&{cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim).remains<gcd}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Wake of Ashes', 'holy_power==0||holy_power==1&cooldown(Blade of Justice).remains>gcd||holy_power=2&{cooldown(Zeal).charges<=0.65||cooldown(Crusader Strike).charges<=0.65}'},
	{'Zeal', 'talent(2,2)&{cooldown(Zeal).charges=2&holy_power<5}'},
	{'Crusader Strike', 'cooldown(Crusader Strike).charges=2&holy_power<5'},
	{'Blade of Justice', 'holy_power<3||{holy_power<4&{cooldown(Zeal).charges<2.34||cooldown(Crusader Strike).charges<2.34}}'},
	{'Judgment', 'holy_power>2||{{cooldown(Zeal).charges<2.67||cooldown(Crusader Strike).charges<2.67}&cooldown(Blade of Justice).remains>gcd}||{talent(2,3)&target.health>50}'},
	{'Consecration', 'talent(1,3)'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>1&player.buff(Divine Purpose)'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>1&player.buff(The Fires of Justice)&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>1&{holy_power>3||{{cooldown(Zeal).charges<2.34||cooldown(Crusader Strike).charges<2.34}&cooldown(Blade of Justice).remains>gcd}}&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(The Fires of Justice)&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&{holy_power>3||{{cooldown(Zeal).charges<2.34||cooldown(Crusader Strike).charges<2.34}&cooldown(Blade of Justice).remains>gcd}}&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Zeal', 'talent(2,2)&holy_power<5'},
	{'Crusader Strike', 'holy_power<5'},
	{'Divine Storm', 'target.debuff(Judgment)&holy_power>2&player.area(6).enemies>1&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*5}'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>2&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*5}'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, 'target.inMelee&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(70, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Paladin - Retribution',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	 ids = Zylla.SpellIDs[Zylla.Class],
	load = exeOnLoad
})
