local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds', align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',											align = 'left',				key = 'lshift', 	default = false},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'DnD/Defile|r', 								align = 'left', 			key = 'lcontrol',	default = false},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r', 														align = 'left', 			key = 'lalt',			default = false},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r', 													align = 'left', 			key = 'ralt', 		default = false},
	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 																						key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',																				align = 'center'},
	{type = 'combo',		default = 'target',																											key = 'target', 			list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',																			align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 													key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',																				key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',								key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																													key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 																		key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Death Grip as backup Interrupt',														key = 'DGInt', 				default = false},
	{type = 'checkbox', text = 'Wraithwalk out of Root', 																				key = 'wraithroot', 	default = false},
	{type = 'checkspin',text = 'DnD/Defile on Target w/ # Enemies', 														key = 'dndtarget', 		spin = 2, step = 1, shiftStep = 1, max = 10, min = 1, check = true},
	{type = 'checkspin',text = 'DnD/Defile on Player w/ # Enemies', 														key = 'dndplayer', 		spin = 2, step = 1, shiftStep = 1, max = 10, min = 1, check = false},
		-- Cooldowns
	{type = 'header', 	size = 16, text = 'Cooldowns',																					align = 'center'},
	{type = 'checkspin',text = 'Apocalypse', 																										key = 'apoc',					spin = 6, step = 1, shiftStep = 1, max = 8, min = 1, check = true},
	{type = 'checkspin',text = 'Army of the Dead', 																							key = 'aotd',					spin = 20, step = 5, shiftStep = 1, max = 180, min = 0, check = true},
	{type = 'checkbox',	text = 'Blighted Rune Weapon', 																					align = 'left', 			key = 'brw', default = true},
	{type = 'checkspin',text = 'Dark Arbiter', 																									key = 'darb', 				spin = 20, step = 5, shiftStep = 1, max = 180, min = 0, check = true},
	{type = 'checkbox',	text = 'Dark Transformation', 																					align = 'left', 			key = 'dtran', default = true},
	{type = 'checkspin',text = 'Summon Gargoyle', 																							key = 'garg',					spin = 20, step = 5, shiftStep = 1, max = 180, min = 0, check = true},
	{type = 'checkbox', text = 'Use Trinket #1', 																								key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																								key = 'trinket2', 		default = false, desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Kil\'Jaeden\'s Burning Wish - Units', 													key = 'kj', 					align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',																						align = 'center'},
	{type = 'checkbox',	text = 'Anti-Magic Shell',																							align = 'left', 			key = 'ams', default = false},
	{type = 'checkspin',text = 'Icebound Fortitude',																						key = 'IwF', 					spin = 30, step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',text = 'Healthstone', 																									key = 'HS', 					spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',text = 'Ancient Healing Potion', 																				key = 'AHP', 					spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'spinner', 	text = 'Death Strike', 																									key = 'ds', 					default_spin = 35},
	{type = 'ruler'}, {type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDEATH KNIGHT |cffADFF2FUnholy|r')
	print('|cffADFF2F --- |rRecommended Talents: 3211x11')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Death and Decay', 'keybind(lalt)&UI(lalt)', 'cursor.ground'},
	{'!Defile', 'keybind(lcontrol)&UI(lcontrol)', 'cursor.ground'}
}

local Survival = {
	{'Death Strike', 'player.health<=75&player.buff(Dark Succor)', 'target'},
	{'Death Strike', 'player.health<=UI(ds)&player.runicpower>= 45', 'target'},
	{'Icebound Fortitude', 'UI(IF_check)&health<=(IF_spin)&{{incdmg(2.5)>health.max*0.50}||state(stun)}'},
	{'Anti-Magic Shell', 'incdmg(2.5).magic>health.max*0.70&UI(ams)'},
	{'Wraith Walk', 'state(root)&UI(wraithroot)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'},
}

local Interrupts = {
	{'!Mind Freeze', 'inFront&range<=15'},
	{'!Asphyxiate', 'range<=30&inFront&spell(Mind Freeze).cooldown>=gcd&!player.lastgcd(Mind Freeze)'},
	{'!Death Grip', 'UI(DGInt)&range<=30&inFront&spell(Mind Freeze).cooldown>=gcd&spell(Asphyxiate).cooldown>=gcd'},
	{'!Arcane Torrent', 'inMelee&spell(Mind Freeze).cooldown>=gcd&!player.lastgcd(Mind Freeze)'},
}

local Cooldowns = {
	{'Blood Fury'},
	{'Berserking'},
	{'Army of the Dead', 'toggle(cooldowns)&UI(aotd_check)&ttd>UI(aotd_spin)'},
	{'Blighted Rune Weapon', 'player.runes<=3&UI(brw)', 'target'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'advanced&UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'},
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)', 'target'}, 	--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local Dark_Transformation = {
	{'Dark Transformation', 'equipped(137075)&spell(Dark Arbiter).cooldown>165'},
	{'Dark Transformation', 'equipped(137075)&!talent(6,1)&spell(Dark Arbiter).cooldown>55'},
	{'Dark Transformation', 'equipped(137075)&talent(6,1)&spell(Dark Arbiter).cooldown>35'},
	{'Dark Transformation', 'equipped(137075)&ttd<spell(Dark Arbiter).cooldown-8'},
	{'Dark Transformation', 'equipped(137075)&spell(Summon Gargoyle).cooldown>160&UI(dtran)'},
	{'Dark Transformation', 'equipped(137075)&!talent(6,1)&spell(Summon Gargoyle).cooldown>55&UI(dtran)'},
	{'Dark Transformation', 'equipped(137075)&talent(6,1)&spell(Summon Gargoyle).cooldown>35&UI(dtran)'},
	{'Dark Transformation', 'equipped(137075)&ttd<spell(Summon Gargoyle).cooldown-8'},
	{'Dark Transformation', '!equipped(137075)&player.runes<=3&UI(dtran)'},
}

local AoE = {
	{'Death and Decay', 'area(10).enemies>=UI(dndtarget_spin)&UI(dndtarget_check)', 'target.ground'},
	{'Death and Decay', 'area(10).enemies>=UI(dndplayer_spin)&UI(dndplayer_check)', 'player.ground'},
	{'Epidemic', 'count(Virulent Plague).enemies.debuffs>4'},
	{'Scourge Strike', 'area(10).enemies>=2&{ player.buff(Death and Decay)||player.buff(Defile)}'},
	{'Clawing Shadows', 'area(10).enemies>=2&{ player.buff(Death and Decay)||player.buff(Defile)}'},
	{'Epidemic', 'count(Virulent Plague).enemies.debuffs>2'},
}

local Generic = {
	{AoE, 'toggle(aoe)'},
	{'Dark Arbiter', 'toggle(cooldowns)&!equipped(137075)&deficit<30&UI(darb_check)&ttd>UI(darb_spin)'},
	{'Apocalypse', 'equipped(137075)&UI(apoc_check)&debuff(Festering Wound).count>=UI(apoc_spin)&talent(7,1) '},
	{'Dark Arbiter', 'toggle(cooldowns)&equipped(137075)&deficit<30&spell(Dark Transformation).cooldown<2&UI(darb_check)&ttd>UI(darb_spin)'},
	{'Summon Gargoyle', 'toggle(cooldowns)&!equipped(137075)&runes<=3 &UI(garg_check)&ttd>UI(garg_spin)'},
	{'Chains of Ice', 'player.buff(Unholy Strength)&player.buff(Cold Heart).count>19'},
	{'Summon Gargoyle', 'toggle(cooldowns)&equipped(137075)&spell(Dark Transformation).cooldown<10&runes<=3 &UI(garg_check)&ttd>UI(garg_spin)'},
	{'Soul Reaper', 'debuff(Festering Wound).count>=6&spell(Apocalypse).cooldown<4'},
	{'Apocalypse', 'toggle(cooldowns)&UI(apoc_check)&debuff(Festering Wound).count>=UI(apoc_spin)'},
	{'Death Coil', 'player.deficit<10'},
	{'Death Coil', '!talent(7,1)&player.buff(Sudden Doom)&!player.buff(Necrosis)&runes<=3'},
	{'Death Coil', 'talent(7,1)&player.buff(Sudden Doom)&{ spell(Dark Arbiter).cooldown>5&toggle(cooldowns)||!toggle(cooldowns) }&runes<=3'},
	{'Festering Strike', 'debuff(Festering Wound).count<6&spell(Apocalypse).cooldown<=6'},
	{'Soul Reaper', 'debuff(Festering Wound).count>=3'},
	{'Festering Strike', 'debuff(Soul Reaper)&!debuff(Festering Wound)'},
	{'Scourge Strike', 'debuff(Soul Reaper)&debuff(Festering Wound).count>=1'},
	{'Clawing Shadows', 'debuff(Soul Reaper)&debuff(Festering Wound).count>=1'},
	{'Defile', 'UI(dndtarget_check)', 'target.ground'},
	{'Defile', 'UI(dndplayer_check)', 'player.ground'},
  {'Festering Strike', 'debuff(Festering Wound).count<=2&{talent(3,2)||debuff(Festering Wound).count<=4||{player.buff(Blighted Rune Weapon) }}&player.deficit>5&{player.deficit>23||!talent(3,2)}'},
  {'Death Coil', 'talent(6,2)&!player.buff(Necrosis)&player.runes>=3'},
	{'Scourge Strike', '{player.buff(Necrosis)||player.buff(Unholy Strength)||player.runes>=2}&debuff(Festering Wound).count>=3 &deficit>9'},
	{'Clawing Shadows', '{player.buff(Necrosis)||player.buff(Unholy Strength)||player.runes>=2}&debuff(Festering Wound).count>=3 &deficit>9'},
	{'Death Coil', 'talent(6,1)&talent(7,1)&!Pet.buff(Dark Transformation)&spell(Dark Arbiter).cooldown>10'},
	{'Death Coil', 'talent(6,1)&!talent(7,1)&!Pet.buff(Dark Transformation)'},
	{'Death Coil', 'talent(7,1)&spell(Dark Arbiter).cooldown>10'},
	{'Death Coil', '!talent(6,1)&!talent(7,1)'},
}

local Valkyr = {
	--{'Dark Transformation', 'UI(dtran)'},
	{'Death Coil', nil},
	{'Apocalypse', 'debuff(Festering Wound).count>=6'},
	{'Festering Strike', 'debuff(Festering Wound).count<5&spell(Apocalypse).cooldown<3'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>2'},
	{'Festering Strike', 'debuff(Festering Wound).count<=4'},
	{'Scourge Strike', 'debuff(Festering Wound)'},
	{'Clawing Shadows', 'debuff(Festering Wound)'},
}

local xCombat = {
	{'&/startattack', '!isattacking&enemy'},
	{'Arcane Torrent', 'player.deficit>20'},
	{'Outbreak', 'debuff(Virulent Plague).duration<=2'},
	{Cooldowns, 'toggle(cooldowns)&inMelee&ttd>10'},
	{Mythic_Plus, 'range<=31'},
	{Dark_Transformation, 'UI(dtran)'},
	{Valkyr, 'player.totem(Val\'kyr Battlemaiden)'},
	{Generic, 'inFront'}
}

local inCombat = {
	{'Raise Dead', '!pet.exists||pet.dead'},
	{Keybinds},
	{Survival, nil, 'player'},
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)', 'enemies'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.Condition:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(252, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death Knight - Unholy',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
