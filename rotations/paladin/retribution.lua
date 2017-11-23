local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																				align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',										align = 'left', 		key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Divine Steed|r',							align = 'left', 		key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',													align = 'left', 		key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',													align = 'left', 		key = 'ralt', 		default = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 																					key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																			align = 'center'},
	{type = 'combo',		default = 'target',																										key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																		align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',																			key = 'kDBM', 			default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',							key = 'prepot', 		default = false},
	{type = 'combo',		default = '1',																												key = 'list', 			list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																	key = 'LJ',					spin = 4, step = 1, shiftStep = 2, max = 20, min = 1, check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Blessing of Kings', 																					key = 'BoK', 				default = true},
	{type = 'checkbox', text = 'Blessing of Wisdom', 																					key = 'BoW', 				default = true, desc = Zylla.ClassColor..'Check to Enable Blessings on yourself.|r'},
	{type = 'checkbox', text = 'Use Every Man for Himself', 																	key = 'EMfH', 			default = true},
	{type = 'checkbox', text = 'Use Blessing of Freedom', 																		key = 'BoF', 				default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																							key = 'trinket1',		default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																							key = 'trinket2', 	default = false,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Kil\'Jaeden\'s Burning Wish - Units', 												key = 'kj', 				align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival', 																				align = 'center'},
	{type = 'checkspin',text = 'Gift of the Naaru', 																					key = 'GotN', 			spin = 40, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Lay on Hands', 																								key = 'LoH', 				spin = 5,  step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Flash of Light', 																							key = 'FoL', 				spin = 40, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Shield of Vengeance', 																				key = 'SoV', 				spin = 75, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Eye for an Eye', 																							key = 'EfaE', 			spin = 90, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healthstone',																									key = 'HS',					spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																							key = 'AHP',				spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	-- Group Assistance
	{type = 'header', 	size = 16, text = 'Emergency Group Assistance', 											align = 'center'},
	{type = 'checkspin',text = 'Flash of Light', 																							key = 'G_FoL', 			spin = 35, step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',text = 'Lay on Hands', 																								key = 'G_LoH', 			spin = 5,  step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',text = 'Blessing of Protection', 																			key = 'G_BoP', 			spin = 5,  step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',text = 'Blessing of Protection on TANKS',															key = 'T_BoP', 			spin = 5,  step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkbox',	text = 'Dispel Party Members',																				key = 'disAll', 		default = true},
	{type = 'checkbox', text = 'Use Blessing of Freedom', 																		key = 'G_BoF', 			default = false},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()
	print(Zylla.ClassColor..' ----------------------------------------------------------------------|r')
	print(Zylla.ClassColor..' --- |rPaladin: |cfff58cbaRETRIBUTION|r')
	print(Zylla.ClassColor..' --- |rTalents: 1/2 - 2/2 - 3/1 - 4/2 - 5/2 - 6/1 - 7/2|r')
	print(Zylla.ClassColor..' ----------------------------------------------------------------------|r')
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

local PreCombat ={
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127849', 'item(127849).usable&item(127849).count>0&UI(prepot)&!buff(Flask of the Countless Armies)'},	--XXX: Flask of the Countless Armies
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},						--XXX: Lightforged Augment Rune
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'Divine Steed', 'keybind(lcontrol)&UI(lcontrol)', 'player'}
}

local Survival = {
	{'!Flash of Light', 'movingfor<0.75&UI(FoL_check)&health<=UI(FoL_spin)'},
	{'!Lay on Hands', 'UI(LoH_check)&health<=UI(LoH_spin)'},
	{'!Shield of Vengeance', 'UI(SoV_check)&health<=UI(SoV_spin)'},
	{'Eye for an Eye', 'UI(EfaE_check)&health<=UI(EfaE_spin)'},
	{'!Blessing of Freedom', 'UI(BoF)&{state(root)||state(snare)}'},
	{'&Gift of the Naaru', 'UI(GotN_check)&health<=UI(GotN_spin)'},
	{'&Every Man for Himself', 'UI(EMfH)&state(stun)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Group = {
	{'!Flash of Light', 'UI(G_FoL_check)&health<=UI(G_FoL_spin)'},
	{'!Lay on Hands', 'UI(G_LoH_check)&health<=UI(G_LoH_spin)'},
	{'!Blessing of Protection', 'UI(G_BoP_check)&health<=UI(G_BoP_spin)&!role(tank)'},
	{'!Blessing of Protection', 'UI(T_BoP_check)&health<=UI(T_BoP_spin)&role(tank)', 'tank'},
	{'!Blessing of Freedom', 'player.ingroup&ingroup&inMelee&UI(G_BoF)&{state(root)||state(snare)}', 'friendly'},
}

local Interrupts = {
	{'&Rebuke', 'inFront&inMelee'},
	{'!Hammer of Justice', '!equipped(137065)&range<=20&spell(Rebuke).cooldown>=gcd&!player.lastgcd(Rebuke)'},
	{'!Hammer of Justice', 'equipped(137065)&health>=75&range<=20&spell(Rebuke).cooldown>=gcd&!player.lastgcd(Rebuke)'},
	{'!Blinding Light', 'range<=20&spell(Rebuke).cooldown>=gcd&!player.lastgcd(Rebuke)'},
	{'!Arcane Torrent', 'inMelee&spell(Rebuke).cooldown>=gcd&!player.lastgcd(Rebuke)'}
}

local Dispel = {
	{'%dispelSelf'},
	{'%dispelAll', 'UI(DisAll)'}
}

local Blessings = {
	{'Greater Blessing of Kings', 'UI(BoK)&!buff'},
	{'Greater Blessing of Wisdom', 'UI(BoW)&!buff'}
}

local Cooldowns = {
	{'&Arcane Torrent', 'player.holypower<=4&{player.buff(Crusade)||player.buff(Avenging Wrath)}', 'target'},
	{'Holy Wrath', 'toggle(aoe)&player.area(8).enemies>=2&player.health<51', 'target'},
	{'&Avenging Wrath', nil, 'target'},
	{'&Crusade', 'holypower>=5&!equipped(137048)||{{equipped(137048)||race(Blood Elf)}&holypower>=2}', 'player'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&inMelee&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local DS_Castable = {
	{'Divine Storm', 'toggle(aoe)&debuff(Judgment)&player.buff(Divine Purpose).duration<=gcd*2'},
	{'Divine Storm', 'toggle(aoe)&debuff(Judgment)&player.holypower>=5&player.buff(Divine Purpose)'},
	{'Divine Storm', 'toggle(aoe)&debuff(Judgment)&player.holypower>=5&{!talent(7,2)||player.buff(Crusade).duration>=gcd*3}'},
	{'Divine Storm', 'toggle(aoe)&spell(Wake of Ashes).cooldown<=gcd*2'},
	{'Divine Storm', 'toggle(aoe)&player.buff(Whisper of the Nathrezim).duration<=gcd*1.5&{!talent(7,2)||player.buff(Crusade).duration>=gcd*3}'},
	{'Divine Storm', 'toggle(aoe)&player.buff(Divine Purpose)'},	-- Might Get removed...
	{'Divine Storm', 'toggle(aoe)&player.buff(The Fires of Justice)&{!talent(7,2)||player.buff(Crusade).duration>=gcd*3}'},
	{'Divine Storm', 'toggle(aoe)&player.holypower>=3&{spell(Judgment).cooldown&!debuff(Judgment)}'} -- Attempt to fix target-issue with Judgment
}

local Templar = {
	{'Templar\'s Verdict', 'debuff(Judgment)&player.buff(Divine Purpose).duration<=gcd*2'},
	{'Templar\'s Verdict', 'debuff(Judgment)&player.holypower>=5&player.buff(Divine Purpose)'},
	{'Templar\'s Verdict', 'debuff(Judgment)&player.holypower>=3&{player.buff(Crusade).stack<15|||player.buff(137048)}'},
	{'Templar\'s Verdict', 'debuff(Judgment)&player.holypower>=5&{!equipped(137048)||{equipped(137048)&||player.race(Blood Elf)}}'},
	{'Templar\'s Verdict', '{equipped(137020)||debuff(Judgment)}&spell(Wake of Ashes).cooldown<=gcd*2&{!talent(7,2)||player.buff(Crusade).duration>=gcd*3}'},
	{'Templar\'s Verdict', 'debuff(Judgment)&player.buff(Whisper of the Nathrezim).duration<=gcd*1.5&{{!talent(7,2)||player.buff(Crusade).duration>=gcd*3}}'},
	{'Templar\'s Verdict', 'player.holypower>=3&{spell(Judgment).cooldown&!debuff(Judgment)}'} --XXX: Attempt to fix target-issues with Judgment
}

local Combat = {
	{DS_Castable, 'player.area(6).enemies>=2||{player.buff(Scarlet Inquisitor\'s Expurgation).stack>=29}&{player.buff(Avenging Wrath)||{player.buff(Crusade).stack>=15}||{spell(Crusade).cooldown>15&!player.buff(Crusade)}||spell(Avenging Wrath).cooldown>15}'},
	{Templar},
	{'Execution Sentence','player.area(6).enemies<=3&{spell(Judgment).cooldown<=gcd*4.5||debuff(Judgment).duration>=gcd*4.5}'},
	{'Divine Storm', 'toggle(aoe)&debuff(Judgment)&player.area(6).enemies>=2&player.holypower>=3&{player.buff(Crusade).stack<15||player.buff(137048)}'},
	{'Justicar\'s Vengeance', 'debuff(Judgment)&player.buff(Divine Purpose)&!equipped(137020)'},
	{'Justicar\'s Vengeance', 'debuff(Judgment)&player.holypower>=5&player.buff(Divine Purpose)&!equipped(137020)'},
	{'Judgment', 'debuff(Execution Sentence).duration<=gcd*2&debuff(Judgment).duration<=gcd*2'},
	{'Consecration', 'toggle(aoe)&{spell(Blade of Justice).cooldown>=gcd*2||spell(Divine Hammer).cooldown>=gcd*2}'},
	{'Wake of Ashes', 'toggle(aoe)&{player.holypower==0||player.holypower==1&{spell(Blade of Justice).cooldown>=gcd||spell(Divine Hammer).cooldown>=gcd}||player.holypower==2&{{spell(Zeal).charges<=0.65||spell(Crusader Strike).charges<=0.65}}}'},
	{'Blade of Justice', 'player.holypower<=3-set_bonus(T20)'},
	{'Divine Hammer', 'toggle(aoe)&player.holypower<=3-set_bonus(T20)'},
	{'Hammer of Justice', 'equipped(137065)&health>=75&player.holypower<=4'},
	{'Hammer of Justice', 'player.holypower<=5&equipped(137065)&health>=75'},
	{'Zeal', 'spell(Zeal).charges>=1.65&player.holypower<=4&{spell(Blade of Justice).cooldown>=gcd*2||spell(Divine Hammer).cooldown>=gcd*2}&debuff(Judgment).duration>=gcd'},
	{'Zeal', 'player.holypower<=4||{spell(Judgment).cooldown&!debuff(Judgment)}'},
	{'Crusader Strike', 'spell(Crusader Strike).charges>=1.65-talent(2,1).enabled*0.25&player.holypower<=4&{spell(Blade of Justice).cooldown>=gcd*2||spell(Divine Hammer).cooldown>=gcd*2}&debuff(Judgment).duration>=gcd'},
	{'Crusader Strike', 'player.holypower<=4||{spell(Judgment).cooldown&!debuff(Judgment)}'}
}

local Opener = {
	{'Judgment', 'enemy&range<=30&inFront'},
	{'Blade of Justice', 'enemy&range<=12&inFront&{equipped(137048)||player.race(Blood Elf)||spell(Wake of Ashes).cooldown}'},
	{'Divine Hammer', 'toggle(aoe)&inMelee&inFront&enemy&{equipped(137048)||player.race(Blood Elf)||spell(Wake of Ashes).cooldown}'},
	{'Wake of Ashes', 'toggle(aoe)&inMelee&inFront'}
}

local xCombat = {
	{Interrupts, 'toggle(interrupts)&@Zylla.InterruptAt(intat)'},
	{Interrupts, 'toggle(interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)', 'enemies'},
	{Cooldowns, 'toggle(cooldowns)&inMelee&ttd>10'},
	{Opener, 'xtime<3&{spell(Judgment).cooldown<=gcd||spell(Blade of Justice).cooldown<=gcd||spell(Wake of Ashes).cooldown<=gcd}'},
	{Combat, 'inMelee&inFront'},
}

local inCombat = {
	{Keybinds},
	{Dispel, 'toggle(dispels)&spell(Cleanse Toxins).cooldown<=gcd'},
	{Survival, nil, 'player'},
	{Blessings, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{Group, 'player.movingfor<0.75&inGroup&toggle(groupAssist)', 'lowest'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{PreCombat, nil, 'player'},
	{Keybinds},
	{Dispel, 'toggle(dispels)&spell(Cleanse Toxins).cooldown<=gcd'},
	{Blessings, nil, 'player'},
	{Group, 'player.movingfor<0.75&inGroup&toggle(groupAssist)', 'lowest'},
	{'Flash of Light', 'movingfor<0.75&health<90&UI(FoL_check)', 'player'}
}

NeP.CR:Add(70, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Paladin - Retribution',
--pooling = true, --TODO: TEST!!!
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
