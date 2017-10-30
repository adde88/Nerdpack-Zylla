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
	{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'normal',																				key = 'target', 			list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',	key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																						key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type='checkbox',		text = 'AoE-Dotting',																			key='multi', 					default=true},
	{type='ruler'},			{type='spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival', 														align = 'center'},
	{type = 'checkspin',text = 'Crimson Vial', 																		key='cv', 						spin = 65, step = 5, shiftStep = 10, max = 100, min = 1,	check = true},
	{type = 'checkspin',text = 'Evasion)', 																				key='evasion',				spin = 42, step = 5, shiftStep = 10, max = 100, min = 1,	check = true},
	{type = 'checkspin',text = 'Healthstone',																			key = 'HS',						spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type = 'checkspin',text = 'Healing Potion',																	key = 'AHP',					spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = true},
	{type='ruler'},			{type='spacer'},
	--Cooldowns
	{type = 'header', 	size = 16, text = 'Cooldowns', 														align = 'center'},
	{type='checkbox',		text = 'Vanish',																					key='van', 						default=true},
	{type='checkbox',		text = 'Vendetta',																				key='ven', 						default=true},
	{type='ruler'},			{type='spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad=function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |Rogue |cffADFF2FAssassination|r')
	print('|cffADFF2F ---')
	print('|cffADFF2F --- |rRecommended Talents: 1,1 / 2,1 / 3,3 / any / any / 6,1 or 6,2 / 7,1')
  print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key='xStealth',
		name='Auto Stealth',
		text = 'If Enabled we will automatically maintain Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
	})

	NeP.Interface:AddToggle({
		key='CS',
		name='Cheap Shot',
		text = 'If Enabled we will open with Cheap Shot.',
		icon='Interface\\Icons\\ability_cheapshot',
	})

	NeP.Interface:AddToggle({
		key='xPickPock',
		name='Pick Pocket',
		text = 'If Enabled we will automatically Pick Pocket enemies out of combat.',
		icon='Interface\\Icons\\inv_misc_bag_11',
	})

end

local PreCombat = {
	{'Tricks of the Trade', '!buff&dbm(pull_in)<5', {'tank', 'focus'}},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'ingroup&item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)'},	--XXX: Flask of the Seventh Demon
	{'#153023', 'ingroup&item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'}				--XXX: Lightforged Augment Rune
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Interrupts = {
	{'&Kick', 'inMelee&inFront'},
	{'!Kidney Shot', 'inMelee&&inFront&cooldown(Kick).remains>gcd&!player.lastgcd(Kick)&player.combopoints>0'},
	{'!Arcane Torrent', 'inMelee&spell(Kick).cooldown>gcd&!player.lastgcd(Kick)'},
}

local Survival = {
	--{'Feint', ''},
	{'Crimson Vial', 'UI(cv_check)&health<=UI(cv_spin)&energy>25'},
	{'Evasion', 'UI(evasion_check)&health<=UI(evasion_spin)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
	{'Cloak of Shadows', 'incdmg(3).magic>health.max*0.25'},
}

local Cooldowns= {
	{'Vendetta', 'player.energy<60'},
	{'Vanish', '!player.buff(Stealth)&player.combopoints>3&UI(van)'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Ranged = {
	{'Poisoned Knife', 'player.energy>60&player.combopoints<5'},
	{'Poisoned Knife', 'debuff(Agonizing Poison).duration<3'},
}

local Stealthed = {
	{'Rupture', 'player.lastcast(Vanish)&player.combopoints>4'},
	{'Garrote', 'player.buff(Stealth)&player.combopoints<5&debuff.duration<6.4'},
	{'Cheap Shot', '!toggle(xPickPock)&toggle(CS)&inMelee&enemy&player.buff(Stealth)'},
	{'Stealth', 'toggle(xStealth)&!player.buff&!player.buff(Vanish)&!nfly&!combat', 'player'},
	{'Pick Pocket', 'toggle(xPickPock)&enemy&alive&range<=10&player.buff(Stealth)' ,'enemies'},
}

local Poisons = {
	{'Deadly Poison', 'duration<70&!player.lastcast&!talent(6,1)'},
	{'Agonizing Poison', 'duration<70&!player.lastcast&talent(6,1)'},
	{'Leeching Poison', 'duration<70&!player.lastcast&talent(4,1)'},
	{'Crippling Poison', 'duration<70&!player.lastcast&!talent(4,1)'},
}

local xCombat = {
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(interrupts)&toggle(xIntRandom)', 'enemies'},
	{Ranged, '!inMelee&inRanged'},
	{Cooldowns, 'toggle(cooldowns)'},
	--XXX: Rupture
	{'Rupture', 'player.buff(Vanish)'},
	{'Rupture', 'debuff.duration<8.2&player.combopoints>3&spell(Vanish).cooldown>gcd&ttd>5'},
	--XXX: Multi DoT Rupture
	{'Rupture', 'debuff.duration<8.2&player.combopoints>3'},
	{'Rupture', 'combat&alive&enemy&debuff.duration<8.2&player.combopoints>3&enemy&UI(multi)', 'enemies'},
	{'Garrote', 'debuff.duration<6.4&player.combopoints<5'},
	--XXX: Use Mutilate till 4/5 combopoints for rupture
	{'Mutilate', '!debuff(Rupture)&player.combopoints<4'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&debuff(Vendetta)&debuff(Surge of Toxins)&ttd>10'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&spell(Vendetta).cooldown<6.8&ttd>10'},
	{'Envenom', 'player.combopoints>2&debuff(Surge of Toxins).duration<=0.5&debuff(Vendetta)'},
	{'Envenom', 'player.combopoints>3&debuff(Vendetta)'},
	{'Envenom', 'player.combopoints>3&debuff(Surge of Toxins).duration<=0.5'},
	{'Envenom', 'player.combopoints>3&player.energy>60'},
	{'Fan of Knives', 'player.area(10).enemies>2&player.combopoints<5'},
	{'Mutilate', 'player.combopoints<4&player.buff(Envenom)'},
	{'Mutilate', 'spell(Vendetta).cooldown<6&player.combopoints<4'},
	{'Mutilate', 'player.combopoints<4'},
}

local inCombat = {
	{'Tricks of the Trade', '!buff&ingroup', {'tank', 'focus'}},
	{Keybinds},
	{Stealthed},
	{Survival, nil, 'player'},
	{Mythic_Plus, 'inMelee'},
	{xCombat, 'combat&alive&inMelee&inFront', (function() return NeP.Condition:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat= {
	{PreCombat, nil, 'player'},
	{Stealthed, nil, 'target'},
	{Keybinds},
	{Poisons, nil, 'player'},
}

NeP.CR:Add(259, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Assassination',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
