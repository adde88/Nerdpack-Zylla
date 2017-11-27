local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 																			align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',									align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'Mass Dispel|r',						align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Force AoE Dotting|r',				align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'',													align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 																				key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																		align = 'center'},
	{type = 'combo',		default = 'target',																									key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																	align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 											key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Stuff.', 																				key = 'dbm_key', 			align = 'left', width = 55, default = false},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',						key = 'prepot', 			default = false},
	{type = 'checkbox', text = 'Mind Blast - Pre-pull', 																		key = 'precast', 			align = 'left', width = 55, 		default = true},
	{type = 'combo',		default = '3',																											key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Body and Soul', 																						key = 'm_Body', 			align = 'left', width = 55, 		default = true},
	{type = 'checkspin',text = 'SW: Pain - Units to dot', 																	key = 'SWP_UNITS', 		align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 40, min = 1, check = true},
	{type = 'ruler'}, 	{type = 'spacer'},
	-- COOLDOWNS
	{type = 'header', 	size = 16, text = 'Cooldowns (if Toggled ON)', 											align = 'center'},
	{type = 'checkspin',text = 'Mindbender - Void Count', 																	key = 'mb_vfc', 			align = 'left', width = 55, step = 1, shiftStep = 2, spin = 5, max = 100, min = 1, check = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Power Infusion - Void Count:',															key = 'dps_PI', 			align = 'left', width = 55, default = false},
	{type = 'spinner', 	text = 'Target <= 45%', 																						key = 'dps_PIspin1', 	align = 'left', width = 55, step = 1, default = 15},
	{type = 'spinner', 	text = 'Target >= 35%', 																						key = 'dps_PIspin2', 	align = 'left', width = 55, step = 1, default = 15},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Dispersion - Void Count:', 																	key = 'dps_D', 				align = 'left', width = 55, default = true},
	{type = 'spinner', 	text = 'Target <= 45%', 																						key = 'dps_Dspin', 		align = 'left', width = 55, min = 15, max = 50, step = 1, default = 44},
	{type = 'spinner', 	text = 'Target >= 35%', 																						key = 'dps_D2spin', 	align = 'left', width = 55, min = 15, max = 50, step = 1, default = 30},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Shadowfiend - Stacks', 																			key = 'dps_fiend', 		align = 'left', width = 55, step = 1, shiftStep = 10, spin = 22, max = 100, min = 1, check = true},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Arcane Torrent', 																						key = 'dps_at', 			align = 'left', width = 55, default = true},
	{type = 'checkbox', text = 'Void Torrent', 																							key = 'dps_void', 		align = 'left', width = 55, default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																						key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																						key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},	{type = 'ruler'}, 	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 										key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- GUI Survival & Potions
	{type = 'header', 	size = 16, text = 'Survival', 																			align = 'center'},
	{type = 'checkspin',text = 'Self Healing', 																							key = 'k_SH', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 66, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Power Word: Shield', 																				key = 's_PWS', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 75, max = 100, min = 1, check = true},
	{type = 'checkbox', text = 'Fade (when aggro, in party)', 															key = 's_F', 					align = 'left', width = 55, default = false},
	{type = 'checkspin',text = 'Dispersion', 																								key = 's_D', 					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 20, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Vampiric Embrace', 																					key = 's_VE', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 35, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Gift of the Naaru', 																				key = 's_GotN', 			align = 'left', width = 55, step = 5, shiftStep = 10, spin = 40, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healthstone',																								key = 'HS',						align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																						key = 'AHP',					align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true},
	{type = 'ruler'}, 	{type = 'spacer'},
	-- GUI Party Support
	{type = 'header', 	size = 16, text = 'Party Support', 																	align = 'center'},
	{type = 'checkspin',text = 'Gift of the Naaru', 																				key = 'sup_GotN', 		align = 'left', width = 55, step = 5, shiftStep = 10, spin = 20, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Power Word: Shield', 																				key = 'sup_PWS', 			align = 'left', width = 55, step = 5, shiftStep = 10, spin = 20, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Heal Party', 																								key = 'k_PH', 				align = 'left', width = 55, step = 5, shiftStep = 10, spin = 30, max = 100, min = 1, check = true},
	{type = 'ruler'}, 	{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad=function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPriest: |cff6c00ffShadow|r')
	print('|cffADFF2F --- |rSupported Talents:ToF,Body&Soul,Mind Bomb, LI, LoS, Tier 5&6&7')
	print('|cffADFF2F --- |cffff6800Mangaza\'s Madness & Norgannon\'s Foresight|r Supported')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rQuestions or Issues? @|cffFF0000Zylla|r NerdPack Discord|r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'abc',
		name='Mind Bomb AoE',
		text = 'Enable/Disable: Mind Bomb in rotation.',
		icon='Interface\\ICONS\\Spell_shadow_mindbomb',
	})

	NeP.Interface:AddToggle({
		key = 's2m',
		name='Surrender to Madness',
		text = 'Enable/Disable: Automatic S2M',
		icon='Interface\\ICONS\\Achievement_boss_generalvezax_01',
	})

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'lshiftupt Anyone',
		text = 'lshiftupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

	NeP.Interface:AddToggle({
		key = 'disp',
		name='Dispel',
		text = 'ON/OFF Dispel All',
		icon='Interface\\ICONS\\spell_holy_purify',
	})

end

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<5'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<5'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<5'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127847', 'item(127847).usable&item(127847).count>0&UI(prepot)&!buff(Flask of the Whispered Pact)'},	--XXX:  Flask of the Whispered Pact
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},					--XXX: Lightforged Augment Rune
	{'Mind Blast', 'UI(precast)&UI(kDBM)&dbm(pull in)<=spell(11366).casttime+gcd', 'target'}								--TODO: Fix SpellID issue (spell.casttime)
}

local SWP_MASS = {
	{'Shadow Word: Pain', 'range<41&combat&alive&count.enemies.debuffs<UI(SWP_UNITS_spin)&debuff.duration<3'}
}

local Survival = {
	{'Fade', 'target.threat>99&UI(s_F)&ingroup'},
	{'Power Word: Shield', 'health<=UI(s_PWS_spin)&UI(s_PWS_check)'},
	{'!Dispersion', 'health<=UI(s_D_spin)&UI(s_D_check)'},
	{'!Gift of the Naaru', 'health<=UI(s_GotN_spin)&UI(s_GotN_check)'},
	{'!Shadow Mend', 'UI(k_SH_check)&health<=UI(k_SH_spin)', 'player'},
	{'!Vampiric Embrace', 'toggle(cooldowns)&health<=UI(s_VE_spin)&UI(s_VE_check)'}
}

local Potions = {
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Shadow Word: Pain', 'keybind(lalt)&UI(lalt)&combat&alive&range<41&debuff.duration<3', 'enemies'},
	{'!Mass Dispel', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'}
}

local Movement = {
	{'!Power Word: Shield', 'talent(2,2)&movingfor>0.75&UI(m_Body)'}
}

local Support = {
	{'!Gift of the Naaru', 'health<=UI(sup_GotN_spin)&UI(sup_GotN_check)'},
	{'!Power Word: Shield', 'health<=UI(sup_PWS_spin)&UI(sup_PWS_check)'},
	{'!Shadow Mend', 'UI(k_PH_check)&health<=UI(k_PH_spin)&range<41'}
}

local Interrupts = {
	{'&Silence'},
	{'!Arcane Torrent', 'inMelee&spell(Silence).cooldown>=gcd&!player.lastgcd(Silence)'}
}

local Surrender = {
	{'!Surrender to Madness', 'target.ttd<180&toggle(s2m)&!buff&target.boss&boss.exists', 'player'}
}

local Insight = {
	{'!Mindblast', 'spell(Void Eruption).cooldown>=gcd'},
}

local Emergency = {
	{'!Dispersion', 'spell(Shadow Word: Death).charges<1&!spell(Void Torrent).cooldown>=gcd&insanity<30&!talent(7,1)&!talent(7,2)&UI(dps_D)'},
	{'!Arcane Torrent', 'UI(dps_at)&player.insanity<45&{!spell(Shadow Word: Death).cooldown>=gcd||!health<45}&!spell(Dispersion).cooldown>=gcd'},
	{'!Power Infusion', 'talent(6,1)&buff(Voidform).count>70&spell(Shadow Word: Death).charges<1&insanity<70&UI(dps_PI)'}
}

local Cooldowns = {
	{'!Void Torrent', '!player.moving&spell(Void Eruption).cooldown>=gcd&UI(dps_void)'},
	{'!Power Infusion', 'talent(6,1)&buff(Surrender to Madness)&buff(Voidform).count>40&insanity>40&spell(Void Eruption).cooldown>=gcd&spell(Void Torrent).cooldown>=gcd&spell(Dispersion).cooldown>=gcd&UI(dps_PI)', 'player'},
	{'Power Infusion', 'talent(6,1)&!buff(Surrender to Madness)&buff(Voidform).count>=UI(dps_PIspin1)&target.health<45&UI(dps_PI)', 'player'},
	{'Power Infusion', 'talent(6,1)&!buff(Surrender to Madness)&buff(Voidform).count>=UI(dps_PIspin2)&target.health>35&UI(dps_PI)', 'player'},
	{'!Mindbender', 'talent(6,3)&player.buff(Surrender to Madness)', 'target'},
	{'!Mindbender', 'talent(6,3)&!player.buff(Surrender to Madness)&UI(mb_vfc_check)&player.buff(Voidform).count>UI(mb_vfc_spin)'},
	{'!Shadowfiend', '!talent(6,3)&spell(Void Eruption).cooldown>=gcd&player.buff(Voidform).count>=UI(dps_SF_spin)&!talent(6,1)&UI(dps_SF_check)'},
	{'!Shadowfiend', 'player.buff(Power Infusion)&player.buff(Voidform).count>=UI(dps_fiend_spin)&UI(dps_fiend_check)'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<41&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, --XXX: Kil'jaeden's Burning Wish (Legendary)
}

local AOE = {
	{'Shadow Crash', '{area(8).enemies>1&advanced&toggle(AOE)&player.buff(Voidform)&!moving&spell(Void Eruption).cooldown>=gcd}||{!advanced&toggle(AOE)&player.buff(Voidform)&!moving&spell(Void Eruption).cooldown>=gcd}', 'target.ground'},
}

local ST1 = {
	{'!Void Eruption','!player.moving&debuff(Vampiric Touch).duration>13&player.buff(Surrender to Madness)&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)'},
	{'!Void Eruption', '!player.moving&debuff(Vampiric Touch).duration>4&!player.buff(Surrender to Madness)&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)'},
	{'!Shadow Word: Death', '{talent(7,1)&!player.insanity>55&!player.channeling(Void Eruption)}||{health<45&talent(7,3)||talent(7,2)&!player.insanity==100&!player.channeling(Void Eruption)}'},
	{'!Vampiric Touch', '!player.moving&!debuff(Shadow Word: Pain)&talent(6,2)'},
	{'!Mind Blast', '!player.moving&player.channeling(Mind Flay)'},
	{'Mind Blast', '!player.moving&{{talent(6,1)&!player.insanity>55}||{talent(7,3)||talent(7,2)&!player.insanity==100}}'},
	{'Shadow Word: Pain', '{debuff(Shadow Word: Pain).duration<3&!talent(6,2)}||{!debuff(Shadow Word: Pain)&!talent(6,2)}'},
	{'!Vampiric Touch', '!player.moving&{{debuff(Vampiric Touch).duration<4&!player.lastcast(Vampiric Touch)}||{!debuff(Vampiric Touch)&!player.lastcast(Vampiric Touch)}||{{debuff(Shadow Word: Pain).duration<2.3||!debuff(Shadow Word: Pain)}&talent(6,2)}}'},
	{'Mind Flay', '!player.moving&{spell(Mind Blast).cooldown>=gcd&debuff(Shadow Word: Pain)&debuff(Vampiric Touch)&{talent(7,1)&!player.insanity>55}||{talent(7,3)||talent(7,2)&!player.insanity==100}}'}
}

local lotv1 = {
	{'!Dispersion', 'player.buff(Voidform).count>=UI(dps_Dspin)&UI(dps_D)&spell(Shadow Word: Death).charges<1&player.insanity<40&health<45&spell(Void Torrent).cooldown>=gcd', 'player'},
	{'!Dispersion', 'player.buff(Voidform).count>=UI(dps_D2spin)&UI(dps_D)&!player.buff(Surrender to Madness)&player.insanity<40&health>35&spell(Void Torrent).cooldown>=gcd', 'player'},
	{'!Shadow Word: Death', '{!player.channeling(Mind Blast)&spell(Shadow Word: Death).charges>1&player.insanity<80}||{!player.channeling(Mind Blast)&player.insanity<45}'},
	{'!Void Eruption', '!player.moving&!player.channeling(Mind Blast)||player.insanity<30'},
	{'!Vampiric Touch', '!player.moving&!debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd'},
	{'!Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'Shadow Word: Pain', '{debuff(Shadow Word: Pain).duration<3&!talent(6,2)}||{!debuff(Shadow Word: Pain)&!talent(6,2)}||{player.moving&!debuff(Shadow Word: Pain)}'},
	{'!Vampiric Touch', '!player.moving&{{debuff(Vampiric Touch).duration<4&!player.lastcast(Vampiric Touch)}||{!debuff(Vampiric Touch)&!player.lastcast(Vampiric Touch)}||{{debuff(Shadow Word: Pain).duration<2.3||!debuff(Shadow Word: Pain)}&talent(6,2)}}'},
	{'Mind Flay', '!player.moving&spell(Void Eruption).cooldown>=gcd&spell(Mind Blast).cooldown>=gcd&debuff(Shadow Word: Pain)&debuff(Vampiric Touch)'}
}

local s2m1 = {
	{'!Dispersion', 'player.buff(Voidform).count>5&player.buff(Voidform).count<10&!player.lastcast(Void Torrent)&UI(dps_D)', 'player'},
	{'!Void Torrent', '!player.moving&UI(dps_void)'},
	{'!Shadow Word: Death', 'player.buff(Voidform).count<10&debuff(Shadow Word: Pain).duration>6&debuff(Vampiric Touch).duration>6'},
	{'!Shadow Word: Death', 'player.insanity<30'},
	{'!Void Eruption', '!player.moving&{!player.channeling(Mind Blast)||player.insanity<50}'},
	{'!Vampiric Touch', '!player.moving&!debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd'},
	{'!Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'!Shadow Word: Pain', 'debuff(Shadow Word: Pain).duration<3||!debuff(Shadow Word: Pain)'},
	{'!Vampiric Touch', '!player.moving&{debuff(Vampiric Touch).duration<4||!debuff(Vampiric Touch)}'},
	{'Mind Flay', '!player.moving&spell(Void Eruption).cooldown>=gcd&spell(Mind Blast).cooldown>=gcd&debuff(Shadow Word: Pain)&debuff(Vampiric Touch)'}
}

local ST2 = {
	{'!Void Eruption','!player.moving&debuff(Vampiric Touch).duration>13&player.buff(Surrender to Madness)&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)'},
	{'!Void Eruption', '!player.moving&debuff(Vampiric Touch).duration>4&!player.buff(Surrender to Madness)&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)'},
	{'!Shadow Word: Death', '{talent(7,1)&!player.insanity>55&!player.channeling(Void Eruption)}||{health<45&talent(7,3)||talent(7,2)&!player.insanity==100&!player.channeling(Void Eruption)}'},
	{'!Vampiric Touch', '!player.moving&!debuff(Shadow Word: Pain)&talent(6,2)'},
	{'!Mind Blast', '!player.moving&player.channeling(Mind Flay)'},
	{'Mind Blast', '!player.moving&debuff(Shadow Word: Pain)&debuff(Vampiric Touch)'},
	{'Mind Blast', '!player.moving&!debuff(Shadow Word: Pain)&!debuff(Vampiric Touch)&!player.lastcast(Mind Blast)&{talent(7,1)&!player.insanity>55}||{talent(7,3)||talent(7,2)&!player.insanity==100}'},
	{'Shadow Word: Pain', 'debuff(Shadow Word: Pain).duration<3||!debuff(Shadow Word: Pain)'},
	{'!Vampiric Touch', '!player.moving&{{debuff(Vampiric Touch).duration<4&!player.lastcast(Vampiric Touch)}||{!debuff(Vampiric Touch)&!player.lastcast(Vampiric Touch)}||{{debuff(Shadow Word: Pain).duration<2.3||!debuff(Shadow Word: Pain)}&talent(6,2)}}'},
	{'Mind Flay', '!player.moving&{!spell(Mind Blast).cooldown==0&debuff(Shadow Word: Pain)&debuff(Vampiric Touch)&{talent(7,1)&!player.insanity>55}||{talent(7,3)||talent(7,2)&!player.insanity==100}}'}
}

local lotv2 = {
	{'!Dispersion', 'player.buff(Voidform).count>=UI(dps_Dspin)&UI(dps_D)&spell(Shadow Word: Death).charges<1&player.insanity<40&health<45', 'player'},
	{'!Dispersion', 'player.buff(Voidform).count>=UI(dps_D2spin)&UI(dps_D)&!player.buff(Surrender to Madness)&player.insanity<40&health>35', 'player'},
	{'!Void Torrent', '!player.moving&{{player.buff(Voidform).count>13&spell(Shadow Word: Death).charges<1&player.insanity<40&UI(dps_void)}||{player.buff(Voidform).count>6&!player.buff(Surrender to Madness)&player.insanity<40&health>35&UI(dps_void)}}'},
	{'!Shadow Word: Death', '{player.insanity<50}||{health<45&player.buff(Voidform).count<25&player.insanity<70}'},
	{'!Void Eruption', '!player.moving&{!player.channeling(Mind Blast)||player.insanity<50}'},
	{'!Vampiric Touch', '!player.moving&!debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd'},
	{'!Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'Shadow Word: Pain', '{debuff(Shadow Word: Pain).duration<3&!talent(6,2)}||{!debuff(Shadow Word: Pain)&!talent(6,2)}||{player.moving&!debuff(Shadow Word: Pain)}'},
	{'!Vampiric Touch', '!player.moving&{{debuff(Vampiric Touch).duration<4&!player.lastcast(Vampiric Touch)}||{!debuff(Vampiric Touch)&!player.lastcast(Vampiric Touch)}||{{debuff(Shadow Word: Pain).duration<2.3||!debuff(Shadow Word: Pain)}&talent(6,2)}}'},
	{'Mind Flay', '!player.moving&spell(Void Eruption).cooldown>=gcd&spell(Mind Blast).cooldown>=gcd&debuff(Shadow Word: Pain)&debuff(Vampiric Touch)'}
}

local s2m2 = {
	{'!Dispersion', 'player.buff(Voidform).count>5&player.buff(Voidform).count<10&!player.lastcast(Void Torrent)&UI(dps_D)', 'player'},
	{'!Void Torrent', '!player.moving&UI(dps_void)'},
	{'!Shadow Word: Death', 'player.buff(Voidform).count<10&debuff(Shadow Word: Pain).duration>6&debuff(Vampiric Touch).duration>6'},
	{'!Shadow Word: Death', 'player.insanity<30'},
	{'!Void Eruption', '!player.moving&{!player.channeling(Mind Blast)||player.insanity<50}'},
	{'!Vampiric Touch', '!player.moving&!debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd'},
	{'!Mind Blast', '!player.moving&spell(Void Eruption).cooldown>=gcd&debuff(Vampiric Touch)&debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'!Shadow Word: Pain', 'debuff(Shadow Word: Pain).duration<3||!debuff(Shadow Word: Pain)'},
	{'!Vampiric Touch', '!player.moving&{debuff(Vampiric Touch).duration<4||!debuff(Vampiric Touch)}'},
	{'Mind Flay', '!player.moving&spell(Void Eruption).cooldown>=gcd&spell(Mind Blast).charges<1&debuff(Shadow Word: Pain)&debuff(Vampiric Touch)'}
}

local Zek_Support = {
  {'!Shadow Word: Death', 'equipped(144438)&!player.buff(Voidform)&spell(Mind Blast).cooldown>=gcd'},
  {'!Shadow Word: Death', 'equipped(144438)&spell(Void Eruption).cooldown>=gcd&spell(Mind Blast).cooldown>=gcd&player.buff(Voidform)'},
}

local xCombat= {
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)&inFront&&range<40', 'target'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)&inFront&range<40', 'enemies'},
	{SWP_MASS, 'UI(SWP_UNITS_check)', 'enemies'},
	{'Shadowform', '!buff(Voidform)&!buff', 'player'},
	{'Mind Bomb', '{toggle(abc)&area(8).enemies>2&!player.buff(Surrender To Madness)&!talent(7,2)}||{toggle(abc)&area(8).enemies>2&talent(7,2)&spell(Shadow Crash).cooldown==0&player.buff(Voidform)}'},
	{Cooldowns, 'player.buff(Voidform)&toggle(cooldowns)'},
	{Insight, 'player.buff(Shadowy Insight)&{{talent(7,1)&!player.insanity>55}||{talent(7,3)||talent(7,2)&!player.insanity==100}}||{player.moving&!player.buff(Surrender to Madness)}'},
	{s2m2, 'equipped(132864)&player.buff(Voidform)&player.buff(Surrender to Madness)'}, --XXX: Mangaza's Madness stuff...
	{s2m1, 'player.buff(Voidform)&player.buff(Surrender to Madness)'},
	{lotv2, '{equipped(132864)&player.buff(Voidform)&talent(7,1)}||{talent(7,3)&!player.buff(Surrender to Madness)&equipped(132864)&player.buff(Voidform)&!player.channeling(Void Torrent)}||{talent(7,2)&!player.buff(Surrender to Madness)&!equipped(132864)&player.buff(Voidform)&!player.channeling(Void Torrent)}'}, -- Mangaza's Madness stuff...
	{lotv1, '{player.buff(Voidform)&talent(7,1)}||{talent(7,3)&!player.buff(Surrender to Madness)&!equipped(132864)&player.buff(Voidform)}||{talent(7,2)&!player.buff(Surrender to Madness)&!equipped(132864)&player.buff(Voidform)}'},
	{ST2, 'equipped(132864)&!player.buff(Voidform)'},																		--XXX: Mangaza's Madness stuff...
	{ST1, '!player.buff(Voidform)'},
	{Zek_Support, nil},																																	--XXX: Shadow Word Death with Zek's Exterminatus
	{AOE, 'talent(7,2)'},
	{'Mind Flay', '!player.moving'},
}

local inCombat = {
	{Mythic_Plus, 'range<=40'},
	{Movement, '!buff(Voidform)||{buff(Voidform)&spell(Void Eruption).cooldown>=gcd}', 'player'},
	{Surrender, nil, 'player'},
	{Emergency, nil, 'player'},
	{Potions, nil, 'player'},
	{Survival, 'health<100&!buff(Surrender to Madness)', 'player'},
	{Support, '!player.buff(Surrender to Madness)', 'lowest'},
	{Keybinds},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.Condition:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{'%dispelall', 'toggle(disp)'},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
	{'Shadowform', '!buff', 'player'},
	{Movement, '!player.buff(Body and Soul)&!inareaid==1040'},
}

NeP.CR:Add(258, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Priest - Shadow',
	ic = {{inCombat, '!player.channeling(Void Torrent)'}},
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
