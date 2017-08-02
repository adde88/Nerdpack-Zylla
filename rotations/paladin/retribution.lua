local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
	{type = "texture", texture = "Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp", width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',									  	      		  align = 'center'},
	{type = 'spinner', 	text = 'Heal Self below HP%',                 key = 'FoL_HP',         default = 80},
	{type = 'spinner', 	text = 'Lay on Hands below HP%',              key = 'LoH_HP',         default = 15},
	{type = 'spinner',	text = 'Healthstone or Healing Potions',      key = 'Health Stone',	  default = 45},
	{type = 'spinner',	text = 'Divine Shield below HP%',             key = 'DS_HP',          default = 13},
	{type = 'spinner',	text = 'BoP on lowest in party below HP%',    key = 'BoP_HP',          default = 20},
	{type = 'spinner',	text = 'Feign Death (Legendary Healing) %',	  key = 'FD',		      default = 16},
	{type = 'ruler'},	  {type = 'spacer'},
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
	{'Flash of Light', 'player.health<UI(FoL_HP)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}
local Survival = {
	{'%dispelself'},
	{'!Lay on Hands', 'player.health<UI(LoH_HP)'},
	{'!Divine Shield', 'player.health<UI(DS_HP)'},
	{'!Flash of Light', 'player.health<UI(FoL_HP)'},
	{'#127834', 'item(127834).count>0&player.health<UI(Health Stone)'},        -- Ancient Healing Potion
	{'#5512', 'item(5512).count>0&player.health<UI(Health Stone)', 'player'},  --Health Stone
	{'!Blessing of Freedom', 'player.state(root)||player.state(snare)'},
	{'!Blessing of Protection', 'health<UI(BoP_HP)&!debuff(Forbearance)', 'lowest'},
}

local Interrupts = {
	{'!Rebuke', 'target.inMelee'},
	{'!Hammer of Justice', 'target.range<11&player.spell(Rebuke).duration>gcd'},
	{'!Arcane Torrent', 'target.inMelee&player.spell(Rebuke).duration>gcd&!prev_gcd(Rebuke)'},
}

local Cooldowns = {
	{'Holy Wrath'},
	{'Avenging Wrath', '!talent(7,2)'},
	{'Shield of Vengeance'},
	{'Crusade', 'holy_power>4'},
	{'Wake of Ashes', 'holy_power<5'},
	{'Execution Sentence','{player.area(6).enemies<4&{player.spell(Judgment).duration<gcd*4.5||target.debuff(Judgment).duration>gcd*4.67}&{!talent(7,2)||player.spell(Crusade).duration>gcd*2}}'},
	{'Blood Fury'},
	{'Berserking'},
}

local xAoE = {
	{'Divine Storm', 'holy_power>2&{player.spell(Wake of Ashes).duration<gcd*2||player.buff(Whisper of the Nathrezim)&player.buff(Whisper of the Nathrezim).duration<gcd}&{!talent(7,2)||player.spell(Crusade).duration>gcd*4}'},
	{'Divine Storm', 'holy_power>4&player.buff(Divine Purpose)'},
	{'Divine Storm', 'holy_power>4&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*3}'},
	{'Divine Storm', 'player.buff(Divine Purpose)'},
	{'Divine Storm', 'player.buff(The Fires of Justice)&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*3}'},
	{'Divine Storm', 'holy_power>3||{{player.spell(Zeal).charges<2.34||player.spell(Crusader Strike).charges<2.34}&player.spell(Blade of Justice).duration>gcd}&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*4}'},
	{'Divine Storm', 'holy_power>2&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*5}'},
}

local xJudgeDebuff = {
	{xAoE, 'player.area(6).enemies>1'},	
	{'Justicar\'s Vengeance', 'player.buff(Divine Purpose)&player.buff(Divine Purpose).duration<gcd*2&!equipped(Whisper of the Nathrezim)'},
	{'Justicar\'s Vengeance', 'holy_power>4&player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'player.buff(Divine Purpose)&player.buff(Divine Purpose).duration<gcd*2'},
	{'Templar\'s Verdict', 'holy_power>4&player.buff(Divine Purpose)'},
	{'Templar\'s Verdict', 'holy_power>4&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*3}'},
	{'Justicar\'s Vengeance', 'holy_power>2&player.buff(Divine Purpose)&player.spell(Wake of Ashes).duration<gcd*2&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'holy_power>2&{player.spell(Wake of Ashes).duration<gcd*2||player.buff(Whisper of the Nathrezim).duration<gcd}&{!talent(7,2)||player.spell(Crusade).duration>gcd*4}'},
	{'Justicar\'s Vengeance', 'player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	{'Templar\'s Verdict', 'player.buff(Divine Purpose)'},
	{'Templar\'s Verdict', 'player.buff(The Fires of Justice)&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*3}'},
	{'Templar\'s Verdict', '{holy_power>3||{{player.spell(Zeal).charges<2.34||player.spell(Crusader Strike).charges<2.34}&player.spell(Blade of Justice).duration>gcd}}&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*4}'},
	{'Templar\'s Verdict', 'holy_power>2&{{talent(7,2)&!toggle(Cooldowns)}||!talent(7,2)||player.spell(Crusade).duration>gcd*5}'},
}

local xNoJudgeDebuff = {
	{'Wake of Ashes', 'holy_power==0||{holy_power==1&player.spell(Blade of Justice).duration>gcd}||{holy_power==2&{player.spell(Zeal).charges<=0.65||player.spell(Crusader Strike).charges<=0.65}}'},
	{'Crusader Strike', 'player.spell(Crusader Strike).charges==2&holy_power<5'},
	{'Blade of Justice', 'holy_power<3||{holy_power<4&{player.spell(Zeal).charges<2.34||player.spell(Crusader Strike).charges<2.34}}'},
	{'Judgment', 'holy_power>2||{{player.spell(Zeal).charges<2.67||player.spell(Crusader Strike).charges<2.67}&player.spell(Blade of Justice).duration>gcd}||{talent(2,3)&target.health>50}'},
	{'Consecration'},
	{'Zeal', 'holy_power<5'},
	{'Crusader Strike', 'holy_power<5'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xJudgeDebuff, 'target.inMelee&target.inFront'},
	{xNoJudgeDebuff, 'target.inMelee&target.inFront'},
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
	 wow_ver = Zylla.wow_ver,
	 nep_ver = Zylla.nep_ver,
	 load = exeOnLoad
})
