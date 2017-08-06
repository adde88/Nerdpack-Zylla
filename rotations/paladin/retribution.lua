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
	{type = 'checkbox', text = 'Use Lay on Hands', key = 'E_LoH', default = true},
	{type = 'spinner', text = '', key = 'HP_LoH', default = 10},
	{type = 'checkbox', text = 'Use Flash of Light', key = 'E_FoL', default = true},
	{type = 'spinner', text = '', key = 'HP_FoL', default = 40},
	{type = 'checkbox', text = 'Use Shield of Vengeance', key = 'E_SoV', default = true},
	{type = 'spinner', text = '', key = 'HP_SoV', default = 75},
	{type = 'checkbox', text = 'Use Eye for an Eye', key = 'E_EfaE', default = true},
	{type = 'spinner', text = '', key = 'HP_EfaE', default = 90},
	{type = 'checkbox', text = 'Dispel Party Members', key = 'E_disAll', default = true},
	{type = 'checkbox', text = 'Use Every Man for Himself', key = 'E_EMfH', default = true},
	{type = 'checkbox', text = 'Use Blessing of Freedom', key = 'E_BoF', default = true},
	{type = 'checkbox', text = 'Use Gift of the Naaru', key = 'E_GotN', default = true},
	{type = 'spinner', text = '', key = 'HP_GotN', default = 40},
	{type = 'checkbox', text = 'Use Healthstone', key = 'E_HS', default = true},
	{type = 'spinner', text = '', key = 'HP_HS', default = 20},
	{type = 'checkbox', text = 'Use Ancient Healing Potion', key = 'E_AHP', default = true},
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

	NeP.Interface:AddToggle({
	 key = 'xIntRandom',
	 name = 'Interrupt Anyone',
	 text = 'Interrupt all nearby enemies, without targeting them.',
	 icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

end

local Survival = {
	{'!Flash of Light', '!player.moving&UI(E_FoL)&player.health<=UI(HP_FoL)', 'player'},
	{'!Lay on Hands', 'UI(E_LoH)&player.health<=UI(HP_LoH)', 'player'},
	{'!Shield of Vengeance', 'UI(E_SoV)&player.health<=UI(HP_SoV)', 'player'},
	{'Eye for an Eye', 'UI(E_EfaE)&player.health<=UI(HP_EfaE)'},
	{'&Every Man for Himself', 'UI(E_EMfH)&player.state(stun)'},
	{'!Blessing of Freedom', 'UI(E_BoF)&{player.state(root)||player.state(snare)}' ,'player'},
	{'&Gift of the Naaru', 'UI(E_GotN)&player.health<=UI(HP_GotN)' ,'player'},
	{'#127834', 'UI(E_HS)&item(127834).count>0&player.health<UI(HP_HS)'},        	-- Ancient Healing Potion
	{'#5512', 'UI(E_AHP)&item(5512).count>0&player.health<UI(HP_AHP)', 'player'},	--Health Stone
}

local Group = {
	{'!Flash of Light', 'UI(E_Group)&lowest.health<=UI(G_FoL)', 'lowest'},
	{'!Lay on Hands', 'UI(E_Group)&lowest.health<=UI(G_LoH)', 'lowest'},
	{'!Blessing of Protection', 'UI(E_Group)&lowest.health<=UI(G_BoP)', 'lowest'},
}

local Interrupts = {
	{'!Rebuke', 'target.inMelee'},
	{'!Hammer of Justice', '!equipped(137065)&target.range<20&player.spell(Rebuke).cooldown>gcd&!player.lastgcd(Rebuke)', 'target'},
	{'!Hammer of Justice', 'equipped(137065)&target.health>74&target.range<20&player.spell(Rebuke).cooldown>gcd&!player.lastgcd(Rebuke)', 'target'},
	{'!Blinding Light', 'target.range<20&spell(Rebuke).cooldown>gcd&!player.lastgcd(Rebuke)'},
	{'!Arcane Torrent', 'target.inMelee&spell(Rebuke).cooldown>gcd&!player.lastgcd(Rebuke)'},
}

local Interrupts_Random = {
	{'!Rebuke', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&inMelee', 'enemies'},
	{'!Hammer of Justice', '!equipped(137065)&range<20&player.spell(Rebuke).cooldown>gcd&!player.lastgcd(Rebuke)', 'enemies'},
	{'!Hammer of Justice', 'equipped(137065)&health>74&range<20&player.spell(Rebuke).cooldown>gcd&!player.lastgcd(Rebuke)', 'enemies'},
	{'!Blinding Light', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)&!immune(Stun)&inFront&range<20', 'enemies'},
	{'!Arcane Torrent', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)&!immune(Stun)&inFront&inMelee', 'enemies'},
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
	{'&Arcane Torrent', 'player.holypower<=4&{player.buff(Crusade)||player.buff(Avenging Wrath)||xtime<2}', 'target'},
	{'Holy Wrath', 'toggle(aoe)&player.area(8).enemies>=2&player.health<51', 'target'},
	{'&Avenging Wrath'},
	{'&Crusade', 'player.holypower>=5&!equipped(137048)||{{equipped(137048)||player.race(Blood Elf)}&player.holypower>=2}'},
}

local DS_Castable = {
	{'Divine Storm', 'toggle(aoe)&target.debuff(Judgment)&player.buff(Divine Purpose).duration<gcd*2', 'target'},
	{'Divine Storm', 'toggle(aoe)&target.debuff(Judgment)&player.holypower>=5&player.buff(Divine Purpose)', 'target'},
	{'Divine Storm', 'toggle(aoe)&target.debuff(Judgment)&player.holypower>=5&{!talent(7,2)||player.buff(Crusade).duration>gcd*3}', 'target'},
	{'Divine Storm', 'toggle(aoe)&player.spell(Wake of Ashes).cooldown<gcd*2', 'target'},
	{'Divine Storm', 'toggle(aoe)&player.buff(Whisper of the Nathrezim).duration<gcd*1.5&{!talent(7,2)||player.buff(Crusade).duration>gcd*3}', 'target'},
	{'Divine Storm', 'toggle(aoe)&player.buff(Divine Purpose)', 'target'},	-- Might Get removed...
	{'Divine Storm', 'toggle(aoe)&player.buff(The Fires of Justice)&{!talent(7,2)||player.buff(Crusade).duration>gcd*3}', 'target'},
	{'Divine Storm', 'toggle(aoe)&player.holypower>=3&{player.spell(Judgment).cooldown&!target.debuff(Judgment)}', 'target'}, -- Attempt to fix target-issue with Judgment
}

local Templar = {
	{"Templar's Verdict", 'target.debuff(Judgment)&player.buff(Divine Purpose).duration<gcd*2', 'target'},
	{"Templar's Verdict", 'target.debuff(Judgment)&player.holypower>=5&player.buff(Divine Purpose)', 'target'},
	{"Templar's Verdict", 'target.debuff(Judgment)&player.holypower>=3&{player.buff(Crusade).stack<15|||player.buff(137048)}', 'target'},
	{"Templar's Verdict", 'target.debuff(Judgment)&player.holypower>=5&{!equipped(137048)||{equipped(137048)&||player.race(Blood Elf)}}', 'target'},
	{"Templar's Verdict", '{equipped(137020)||target.debuff(Judgment)}&player.spell(Wake of Ashes).cooldown<gcd*2&{!talent(7,2)||player.buff(Crusade).duration>gcd*3}', 'target'},
	{"Templar's Verdict", 'target.debuff(Judgment)&player.buff(Whisper of the Nathrezim).duration<gcd*1.5&{{!talent(7,2)||player.buff(Crusade).duration>gcd*3}}', 'target'},
	{"Templar's Verdict", 'player.holypower>=3&{player.spell(Judgment).cooldown&!target.debuff(Judgment)}', 'target'}, -- Attempt to fix target-issue with Judgment
}


local Combat = {
	{DS_Castable, 'player.area(6).enemies>=2||{player.buff(Scarlet Inquisitor\'s Expurgation).stack>=29}&{player.buff(Avenging Wrath)||{player.buff(Crusade).stack>=15}||{player.spell(Crusade).cooldown>15&!player.buff(Crusade)}||player.spell(Avenging Wrath).cooldown>15}'},
	{Templar},
	{'Execution Sentence','player.area(6).enemies<=3&{player.spell(Judgment).cooldown<gcd*4.5||target.debuff(Judgment).duration>gcd*4.5}', 'target'},
	{'Divine Storm', 'toggle(aoe)&target.debuff(Judgment)&player.area(6).enemies>=2&player.holypower>=3&{player.buff(Crusade).stack<15||player.buff(137048)}', 'target'},
	{"Justicar's Vengeance", 'target.debuff(Judgment)&player.buff(Divine Purpose)&!equipped(137020)', 'target'},
	{"Justicar's Vengeance", 'target.debuff(Judgment)&player.holypower>=5&player.buff(Divine Purpose)&!equipped(137020)', 'target'},
	{'Judgment', 'target.debuff(Execution Sentence).duration<gcd*2&target.debuff(Judgment).duration<gcd*2', 'target'},
	{'Consecration', 'toggle(aoe)&{player.spell(Blade of Justice).cooldown>gcd*2||player.spell(Divine Hammer).cooldown>gcd*2}'},
	{'Wake of Ashes', 'toggle(aoe)&{player.holypower==0||player.holypower==1&{player.spell(Blade of Justice).cooldown>gcd||player.spell(Divine Hammer).cooldown>gcd}||player.holypower==2&{{player.spell(Zeal).charges<=0.65||player.spell(Crusader Strike).charges<=0.65}}}', 'target'},
	{'Blade of Justice', 'player.holypower<=3-set_bonus(T20)', 'target'},
	{'Divine Hammer', 'toggle(aoe)&player.holypower<=3-set_bonus(T20)', 'target'},
	{'Hammer of Justice', 'equipped(137065)&target.health>=75&player.holypower<=4', 'target'},
	{'Hammer of Justice', 'player.holypower<=5&equipped(137065)&target.health>74', 'target'},
	{'Zeal', 'player.spell(Zeal).charges>=1.65&player.holypower<=4&{player.spell(Blade of Justice).cooldown>gcd*2||player.spell(Divine Hammer).cooldown>gcd*2}&target.debuff(Judgment).duration>gcd', 'target'},
	{'Zeal', 'player.holypower<=4||{player.spell(Judgment).cooldown&!target.debuff(Judgment)}', 'target'},
	{'Crusader Strike', 'player.spell(Crusader Strike).charges>=1.65-talent(2,1).enabled*0.25&player.holypower<=4&{player.spell(Blade of Justice).cooldown>gcd*2||player.spell(Divine Hammer).cooldown>gcd*2}&target.debuff(Judgment).duration>gcd', 'target'},
	{'Crusader Strike', 'player.holypower<=4||{player.spell(Judgment).cooldown&!target.debuff(Judgment)}', 'target'},
}

local Opener = {
	{'Judgment', 'target.enemy&target.range<=30&target.inFront', 'target'},
	{'Blade of Justice', 'target.enemy&target.range<=12&target.inFront&{equipped(137048)||player.race(Blood Elf)||player.spell(Wake of Ashes).cooldown}' ,'target'},
	{'Divine Hammer', 'toggle(aoe)&target.inMelee&target.inFront&target.enemy&{equipped(137048)||player.race(Blood Elf)||player.spell(Wake of Ashes).cooldown}', 'target'},
	{'Wake of Ashes', 'toggle(aoe)&target.inMelee&target.inFront', 'target'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Dispel, 'toggle(dispels)&!player.spell(Cleanse Toxins).cooldown'},
	{Survival},
	{Blessings},
	{Opener, 'target.inMelee&target.inFront&xtime<2&{player.spell(Judgment).cooldown||player.spell(Blade of Justice).cooldown||player.spell(Wake of Ashes).cooldown}'},
	{Combat, 'target.enemy&target.inMelee&target.inFront'},
	{Group, '!player.moving&inGroup&toggle(groupAssist)'},
	{Interrupts_Random},
	{Interrupts, 'toggle(interrupts)&target.interruptAt(70)&target.inFront'},
	{Cooldowns, 'toggle(cooldowns)&target.inMelee'},
}

local outCombat = {
	{Dispel, 'toggle(dispels)&!spell(Cleanse Toxins).cooldown'},
	{Interrupts_Random},
	{Interrupts, 'toggle(interrupts)&target.interruptAt(70)&target.inFront'},
	{Blessings},
	{Group, '!player.moving&inGroup&toggle(groupAssist)'},
	{'Flash of Light', '!player.moving&player.health<98', 'player'},
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
