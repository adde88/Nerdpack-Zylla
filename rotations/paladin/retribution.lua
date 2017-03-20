local _, Zylla = ...
local GUI = {
}
local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FRetribution |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/1 - 4/2 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end


local PreCombat = {
	{'Greater Blessing of Wisdom', '!player.buff(Greater Blessing of Wisdom)', 'player'},
	{'Greater Blessing of Might', '!player.buff(Greater Blessing of Might)', 'player'},
	{'Greater Blessing of Kings', '!player.buff(Greater Blessing of Kings)', 'player'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}
local Survival = {
	{'Lay on Hands', 'player.health<=20'},
	--{'Flash of Light', 'player.health<=40'},
}

local Interrupts = {
	{'Rebuke'},
	{'Hammer of Justice', 'cooldown(Rebuke).remains>gcd'},
	{'Arcane Torrent', 'target.range<=8&cooldown(Rebuke).remains>gcd&!prev_gcd(Rebuke)'},
}

local Cooldowns = {
	{'Holy Wrath'},
	{'Avenging Wrath', '!talent(7,2)'},
	{'Shield of Vengeance'},
	{'Crusade', 'talent(7,2)&holy_power>=5'},
	{'Wake of Ashes', 'holy_power>=0&xtime<2'},
	{'Execution Sentence','talent(1,2)&{player.area(6).enemies<=3&{cooldown(Judgment).remains<gcd*4.5||target.debuff(judgment).remains>gcd*4.67}&{!talent(7,2)||cooldown(Crusade).remains>gcd*2}}'},
	{'Blood Fury'},
	{'Berserking'},
}

local xCombat = {
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&holy_power>=5&player.buff(Divine Purpose)'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&holy_power>=5&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2&!equipped(Whisper of the Nathrezim)'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&holy_power>=5&player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=5&player.buff(Divine Purpose)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=5&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Divine Storm', 'target.debuff(Judgment)&holy_power>=3&player.area(6).enemies>=2&{cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim)&player.buff(Whisper of the Nathrezim).remains<gcd}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&holy_power>=3&player.buff(Divine Purpose)&cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=3&{cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim).remains<gcd}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Wake of Ashes', 'holy_power=0||holy_power=1&cooldown(Blade of Justice).remains>gcd||holy_power=2&{cooldown(Zeal).charges<=0.65||cooldown(Crusader Strike).charges<=0.65}'},
	{'Zeal', 'talent(2,2)&{cooldown(Zeal).charges=2&holy_power<=4}'},
	{'Crusader Strike', 'cooldown(Crusader Strike).charges=2&holy_power<=4'},
	{'Blade of Justice', 'holy_power<=2||{holy_power<=3&{cooldown(Zeal).charges<=1.34||cooldown(Crusader Strike).charges<=1.34}}'},
	{'Judgment', 'holy_power>=3||{{cooldown(Zeal).charges<=1.67||cooldown(Crusader Strike).charges<=1.67}&cooldown(Blade of Justice).remains>gcd}||{talent(2,3)&target.health>50}'},
	{'Consecration', 'talent(1,3)'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&player.buff(Divine Purpose)'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&player.buff(The Fires of Justice)&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&{holy_power>=4||{{cooldown(Zeal).charges<=1.34||cooldown(Crusader Strike).charges<=1.34}&cooldown(Blade of Justice).remains>gcd}}&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose)'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(The Fires of Justice)&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&{holy_power>=4||{{cooldown(Zeal).charges<=1.34||cooldown(Crusader Strike).charges<=1.34}&cooldown(Blade of Justice).remains>gcd}}&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
	{'Zeal', 'talent(2,2)&holy_power<=4'},
	{'Crusader Strike', 'holy_power<=4'},
	{'Divine Storm', 'target.debuff(Judgment)&holy_power>=3&player.area(6).enemies>=2&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*5}'},
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=3&{{talent(7,2)&!toggle(cooldowns)}||!talent(7,2)||cooldown(Crusade).remains>gcd*5}'},
}

local Util = {
	-- Add stuff that should be done part of encounter, dont cast while, dont attack, dont etc
	--BOSS
	{ '%pause' , 'player.debuff(200904)' },			--Sapped Soul
	{ '%pause' , 'player.debuff(Sapped Soul)' }, 	--Sapped Soul
	-- FREEDOOM! --Should add a toggle for this
	{ 'Blessing of Freedom', 'player.state.stun' },
	{ 'Blessing of Freedom', 'player.state.root' },
	{ 'Blessing of Freedom', 'player.state.snare' },
}

local inCombat = {
	{Util},
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, 'target.range<8&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(70, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] PALADIN - Retribution',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
