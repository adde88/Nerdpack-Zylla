local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
	{type = "texture", texture = "Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp", width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Lay on Hands', key = 'E_LoH', default = true},
	{type = 'spinner', text = '', key = 'HP_LoH', default = 10},
	{type = 'checkbox', text = 'Enable Flash of Light', key = 'E_FoL', default = true},
	{type = 'spinner', text = '', key = 'HP_FoL', default = 40},
	{type = 'checkbox', text = 'Enable Shield of Vengeance', key = 'E_SoV', default = true},
	{type = 'spinner', text = '', key = 'HP_SoV', default = 75},
	{type = 'checkbox', text = 'Enable Eye for an Eye', key = 'E_EfaE', default = true},
	{type = 'spinner', text = '', key = 'HP_EfaE', default = 90},
	{type = 'checkbox', text = 'Dispel Party Members, when dispelling', key = 'E_disAll', default = true},
	{type = 'checkbox', text = 'Enable Every Man for Himself (Stun)', key = 'E_EMfH', default = true},
	{type = 'checkbox', text = 'Enable Blessing of Freedom (Root/Snare)', key = 'E_BoF', default = true},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'E_GotN', default = true},
	{type = 'spinner', text = '', key = 'HP_GotN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'E_HS', default = true},
	{type = 'spinner', text = '', key = 'HP_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'E_AHP', default = true},
	{type = 'spinner', text = '', key = 'HP_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Emergency Group Assistance
	{type = 'header', text = 'Emergency Group Assistance', align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Group Assistance', key = 'E_Group', default = false},
	{type = 'text', text = 'Flash of Light'},
	{type = 'spinner', text = '', key = 'G_FoL', default = 35},
	{type = 'text', text = 'Lay on Hands'},
	{type = 'spinner', text = '', key = 'G_LoH', default = 10},
	{type = 'text', text = 'Blessing of Protection'},
	{type = 'spinner', text = '', key = 'G_BoP', default = 10},
	{type = 'ruler'},{type = 'spacer'},
	-- GUI Blessings
	{type = 'header', text = 'Blessings', align = 'center'},
	{type = 'text', text = 'Check to Enable blessings on yourself'},
	{type = 'checkbox', text = 'Blessing of Kings', key = 'B_BoK', default = false},
	{type = 'checkbox', text = 'Blessing of Wisdom', key = 'B_BoW', default = false},
	{type = 'ruler'},{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms',                  align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1',                      key = 'kT1',            default = true},
	{type = 'checkbox', text = 'Use Trinket #2',                      key = 'kT2',            default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures',          key = 'kRoCF',          default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR',         default = true},
	{type = 'spinner',	text = '',                                    key = 'k_HeirHP',       default = 40},
	{type = 'ruler'},	  {type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cfff58cba ----------------------------------------------------------------------|r')
	print('|cfff58cba --- |rPaladin: |cfff58cbaRETRIBUTION|r')
	print('|cfff58cba --- |rTalents: 1/2 - 2/2 - 3/1 - 4/2 - 5/2 - 6/1 - 7/2|r')
	print('|cfff58cba ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		-- Dispels
		key = 'dispels',
		name = 'Cleanse Toxin',
		text = 'Enable/Disable: Automatic removal of Poison and Diseases',
		icon = 'Interface\\ICONS\\spell_holy_renew',
	})
	NeP.Interface:AddToggle({
		-- Group Healing
		key = 'groupAssist',
		name = 'Group Assistance',
		text = 'Enable/Disable: Automatic LoH/BoP/FoL on Party Members',
		icon = 'Interface\\ICONS\\spell_shadow_darksummoning',
	})
end

local Survival = {
	{'&Lay on Hands', 'UI(E_LoH)&player.health<=UI(HP_LoH)'},
	{'&Shield of Vengeance', 'UI(E_SoV)&player.health<=UI(HP_SoV)'},
	{'Eye for an Eye', 'UI(E_EfaE)&player.health<=UI(HP_EfaE)'},
	{'&Every Man for Himself', 'UI(E_EMfH)&player.state(stun)'},
	{'!Blessing of Freedom', 'UI(E_BoF)&{player.state(root)||player.state(snare)}'},
	{'&Gift of the Naaru', 'UI(E_GotN)&player.health<=UI(HP_GotN)'},
	{'#127834', 'UI(E_HS)&item(127834).count>0&player.health<UI(HP_HS)'},        	-- Ancient Healing Potion
	{'#5512', 'UI(E_AHP)&item(5512).count>0&player.health<UI(HP_AHP)', 'player'},	--Health Stone
}

local Player = {
	{'!Flash of Light', 'UI(E_FoL)&player.health<=UI(HP_FoL)', 'player'},
}

local Emergency = {
	{'!Flash of Light', 'UI(E_Group)&lowest.health<=UI(G_FoL)', 'lowest'},
	{'!Lay on Hands', 'UI(E_Group)&lowest.health<=UI(G_LoH)', 'lowest'},
	{'!Blessing of Protection', 'UI(E_Group)&lowest.health<=UI(G_BoP)', 'lowest'},
}

local Interrupts = {
	{'&Rebuke', 'target.inMelee'},
	{'Hammer of Justice', '!equipped(Justice Gaze)&target.range<20&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
	{'Hammer of Justice', 'equipped(Justice Gaze)&target.health>74&target.range<20&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
	{'Blinding Light', 'target.range<20&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
	{'&Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
}

local Dispel = {
	{'%dispelSelf'},
	{'%dispelAll', 'UI(E_disAll)'},
}

local Blessings = {
	{'Greater Blessing of Kings', 'UI(B_BoK)&!player.buff(Greater Blessing of Kings)', 'player'},
	{'Greater Blessing of Wisdom', 'UI(B_BoW)&!player.buff(Greater Blessing of Wisdom)', 'player'},
}

local Cooldowns = {
	{'&Arcane Torrent', 'holypower<5&{player.buff(Crusade)||player.buff(Avenging Wrath)||combat(player).time<2}'},
	{'Holy Wrath'},
	{'&Avenging Wrath', '!talent(7,2)'},
	{'&Crusade', '{holypower>4&!equipped(Liadrin\'s Fury Unleashed)}||{equipped(Liadrin\'s Fury Unleashed)&holypower>1}'},
	{'#Trinket1', 'UI(kT1)'},
	{'#Trinket2', 'UI(kT2)'},
}

local xAoE = {
	{'Divine Storm', 'holypower>4&player.buff(Divine Purpose)'},
	{'Divine Storm', 'holypower>4&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||player.spell(Crusade).cooldown>gcd*3}'},
	{'Divine Storm', 'holypower>3&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||player.spell(Crusade).cooldown>gcd*4}'},
	{'Divine Storm', 'holypower>2&{player.spell(Wake of Ashes).cooldown<gcd*2||player.buff(Whisper of the Nathrezim).duration<gcd}&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*4}'},
	{'Divine Storm', 'holypower>2&{player.buff(Crusade)&{player.buff(Crusade).count<15||hashero}||player.buff(Liadrin\'s Fury Unleashed)}'},
	{'Divine Storm', 'holypower>2&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*5}'},
	{'Divine Storm', 'player.buff(The Fires of Justice)&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*3}'},
	}

local xST = {
	{"Templar's Verdict", 'holypower>4&player.buff(Divine Purpose)'},
	{"Templar's Verdict", 'holypower>4&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||player.spell(Crusade).cooldown>gcd*3}&{!talent(1,2)||spell(Execution Sentence).cooldown>gcd}'},
	{"Templar's Verdict", 'holypower>3&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||player.spell(Crusade).cooldown>gcd*4}&{!talent(1,2)||spell(Execution Sentence).cooldown>gcd*2}'},
	{"Templar's Verdict", 'holypower>2&{player.spell(Wake of Ashes).cooldown<gcd*2||player.buff(Whisper of the Nathrezim).duration<gcd}&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*4}'},
	{"Templar's Verdict", 'holypower>2&{player.buff(Crusade)&{player.buff(Crusade).count<15||hashero}||player.buff(Liadrin\'s Fury Unleashed)}'},
	{"Templar's Verdict", 'holypower>2&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*5}'},
	{"Templar's Verdict", 'player.buff(The Fires of Justice)&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*3}'},
}

local Combat = {
	{xAoE, 'target.debuff(Judgment)&player.area(8).enemies>1'},
	{xST, 'target.debuff(Judgment)'},
	{'Blade of Justice', 'combat(player).time<2&equipped(137048)'},
	{'Divine Hammer', 'combat(player).time<2&equipped(137048)'},
	{'Wake of Ashes', 'combat(player).time<2&holypower<2'},
	{'Blade of Justice', '{holypower<3&set_bonus(T20)>1}||{holypower<4&set_bonus(T20)==0}'},
	{'Divine Hammer', '{holypower<3&set_bonus(T20)>1}||{holypower<4&set_bonus(T20)==0}'},
	{'Execution Sentence','player.area(8).enemies<4&{spell(Judgment).cooldown<gcd*4.5||target.debuff(Judgment).duration>gcd*4.5}&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*2}'},
	{'Wake of Ashes', 'holypower==0||{holypower==1&{spell(Blade of Justice).cooldown>gcd||spell(Divine Hammer).cooldown>gcd}}||{holypower==2&{spell(Zeal).charges<=0.65||spell(Crusader Strike).charges<=0.65}}'},
	{'Zeal', 'spell(Zeal).charges==2&{set_bonus(T20)==0&holypower<3||{holypower<5&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}||{set_bonus(T20)>1&holypower<2||{holypower<5&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}'},
	{'Crusader Strike', '!talent(2,2)&spell(Crusader Strike).charges==2&{set_bonus(T20)==0&holypower<3||{holypower<5&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}||{set_bonus(T20)>1&holypower<2||{holypower<5&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}'},
	{'Consecration'},
	{'Judgment', 'target.debuff(Execution Sentence).duration<gcd*2&target.debuff(Judgment).duration<gcd*2'},
	{'Judgment'},
	{'Zeal'},
	{'Crusader Strike', 'holypower<5&!talent(2,2)'},
	{'Hammer of Justice', 'holypower<5&equipped(Justice Gaze)&target.health>74'},
	{"Justicar's Vengeance", '{player.health<87&holypower>4&target.state(stun)}'},
}

local inCombat = {
	{Dispel, 'toggle(dispels)&!spell(Cleanse Toxins).cooldown'},
	{Survival},
	{Blessings},
	{Player, '!moving'},
	{Emergency, '!moving&inGroup&toggle(groupAssist)'},
	{Interrupts, 'toggle(interrupts)&target.interruptAt(70)&target.inFront'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Combat, 'target.inFront&target.inMelee'},
}

local outCombat = {
	{Dispel, 'toggle(dispels)&!spell(Cleanse Toxins).cooldown'},
	{Interrupts, 'toggle(interrupts)&target.interruptAt(70)&target.inFront'},
	{Blessings},
	{Emergency, '!moving&inGroup&toggle(groupAssist)'},
	{'Flash of Light', '!moving&player.health<98', 'player'},
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
