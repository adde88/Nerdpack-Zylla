local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', 	text = 'Keybinds', 							align = 'center'},
	{type = 'checkbox', text = 'L-Control: Shadowfury @ Cursor',	key = 'K_SF',		default = true},
	{type = 'checkbox', text = 'L-Alt: Demonic Circle', 			key = 'K_DC',		default = true},
	{type = 'checkbox', text = 'L-Shift: Pause', 					key = 'kPause', 	default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',	align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',		key = 'kPause',	default = true},
	{type = 'checkbox', text = 'Summon Pet',		key = 'kPet',	default = true},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Survival
	{type = 'header',	text = 'Survival', 							align = 'center'},
	{type = 'checkbox',	text = 'Enable Unending Resolve', 			key = 'S_UEE', 		default = true},
	{type = 'spinner',	text = '',									key = 'S_UE', 		default = 40},
	{type = 'checkbox', text = 'Enable Dark Pact', 					key = 'S_DPE', 		default = true},
	{type = 'spinner',	text = '',									key = 'S_DP', 		default = 50},
	{type = 'checkbox',	text = 'Enable Drain Life', 				key = 'S_DLE', 		default = true},
	{type = 'spinner',	text = '',									key = 'S_DL', 		default = 30},
	{type = 'checkbox',	text = 'Enable Health Funnel', 				key = 'S_HFE', 		default = true},
	{type = 'spinner',	text = '',									key = 'S_HF', 		default = 60},
	{type = 'checkbox',	text = 'Enable Gift of the Naaru', 			key = 'S_GOTNE', 	default = true},
	{type = 'spinner',	text = '',									key = 'S_GOTN', 	default = 40},
	{type = 'checkbox',	text = 'Enable Healthstone', 				key = 'S_HSE', 		default = true},
	{type = 'spinner',	text = '',									key = 'S_HS', 		default = 20},
	{type = 'checkbox',	text = 'Enable Ancient Healing Potion', 	key = 'S_AHPE', 	default = true},
	{type = 'spinner',	text = '',									key = 'S_AHP', 		default = 20},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarlock |cffADFF2FDemonology |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		-- Doom
		key = 'Doom',
		name = 'Doom',
		text = 'Enable/Disable: Casting of Doom on targets',
		icon = 'Interface\\ICONS\\spell_shadow_auraofdarkness',
	})

	NeP.Interface:AddToggle({
	 key = 'xIntRandom',
	 name = 'Interrupt Anyone',
	 text = 'Interrupt all nearby enemies, without targeting them.',
	 icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

end

local Survival = {
	{'&Unending Resolve', 'UI(S_UEE)&player.health<=UI(S_UE)'},
	{'&Dark Pact', 'UI(S_DPE)&talent(5,3)&pet.exists&player.health<=UI(S_DP)'},
	{'&Gift of the Naaru', 'UI(S_GOTNE)&player.health<=UI(S_GOTN)'},
	{'#127834', 'item(127834).count>0&player.health<UI(S_HS)'},        -- Ancient Healing Potion
  {'#5512', 'item(5512).count>0&player.health<UI(S_AHP)', 'player'},  --Health Stone
}

local Interrupts = {
	{'!Shadowfury', 'target.range<41&target.inFront&!player.moving&UI(K_SF)&target.interruptAt(70)', 'target.ground'},
	{'!Shadowfury', 'target.range<41&target.inFront&!player.moving&UI(K_SF)&target.area(10).enemies>2', 'target.ground'},
	{'!Mortal Coil', 'target.range<30&target.inFront&target.interruptAt(70)', 'target'},
	{'&89766', 'target.petrange<9&pet.exists&target.interruptAt(70)', 'target'},
}

local Interrupts_Random = {
	{'!Shadowfury', 'inFront&range<40&!player.moving&interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)', 'enemies'},
	{'!Shadowfury', 'inFront&range<40&!player.moving&toggle(xIntRandom)&toggle(Interrupts)&area(10).enemies>2', 'enemies'},
	{'!Mortal Coil', 'inFront&range<31&toggle(xIntRandom)&toggle(Interrupts)&interruptAt(70)', 'enemies'},
	{'&89766', 'petrange<9&pet.exists&interruptAt(70)', 'enemies'},
}

local Player = {
	{'!Drain Life', 'UI(S_DLE)&player.health<=UI(S_DL)', 'target'},
	{'!Health Funnel', 'UI(S_HFE)&pet.alive&pet.health<=UI(S_HF)', 'pet'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Shadowfury', '!player.moving&UI(K_SF)&talent(3,3)&keybind(lcontrol)', 'cursor.ground'},
	{'!Demonic Circle', 'UI(K_DC)&talent(3,1)&keybind(lalt)'},
}

local Cooldowns = {
	{'&Arcane Torrent'},
	{'&Berserking'},
	{'&Blood Fury'},
	{'Grimoire: Felguard', 'talent(6,2)'},
	{'Summon Doomguard', '!talent(6,1)&target.area(10).enemies<3'},
	{'Summon Infernal', '!talent(6,1)&player.area(10).enemies>2&!advanced', 'player.ground'},
	{'Summon Infernal', '!talent(6,1)&target.area(10).enemies>2&advanced', 'target.ground'},
	{'Summon Doomguard', 'talent(6,1)&target.area(10).enemies==1&player.buff(Sin\'dorei Spite)'},
	{'Summon Infernal', 'talent(6,1)&player.area(10).enemies>1&player.buff(Sin\'dorei Spite)&!advanced', 'player.ground'},
	{'Summon Infernal', 'talent(6,1)&target.area(10).enemies>1&player.buff(Sin\'dorei Spite)&advanced', 'target.ground'},
	{'Summon Darkglare', 'talent(7,1)&target.area(10).enemies>1&target.debuff(Doom)&player.soulshards>0'},
	{'Soul Harvest', 'talent(4,3)&xtime>0'},
}

local DW_Clip = {
	{'!Summon Felguard', '!player.moving&!pet.exists&!talent(6,1)'},
	{'!Call Dreadstalkers', 'player.buff(Demonic Calling)'},
	{'!Hand of Gul\'dan', '!player.moving&player.soulshards>3'},
	{'!Thal\'kiel\'s Consumption', '!player.moving&player.spell(Call Dreadstalkers).cooldown>3&player.lastgcd(Hand of Gul\'dan)', 'target'},
	{'!Demonic Empowerment', '!player.moving&!player.lastgcd(Demonic Empowerment)&{warlock.empower==0||player.lastgcd(Summon Felguard)||player.lastgcd(Call Dreadstalkers)||player.lastgcd(Hand of Gul\'dan)||player.lastgcd(Summon Darkglare)||player.lastgcd(Summon Doomguard)||player.lastgcd(Grimoire: Felguard)||player.lastgcd(Thal\'kiel\'s Consumption)}'},
	{'!Doom', '!talent(4,1)&toggle(Doom)&!target.debuff(Doom)'},
	{'!Life Tap', 'player.mana<40&player.health>05&{!player.lastgcd(Summon Felguard)||!player.lastgcd(Call Dreadstalkers)||!player.lastgcd(Hand of Gul\'dan)||!player.lastgcd(Summon Darkglare)||!player.lastgcd(Summon Doomguard)||!player.lastgcd(Grimoire: Felguard)}'},
	{'!Demonbolt', '!player.moving&talent(7,2)&!player.soulshards==4'},
	{'!Shadow Bolt', '!player.moving&!talent(7,2)&!player.soulshards==4'},
	{'&89751', 'target.petrange<9&player.area(8).enemies>2'},
}

local ST = {
	{DW_Clip, 'player.channeling(Demonwrath)&pet.exists'},
	{'!Summon Felguard', '!player.moving&!pet.exists&!talent(6,1)'},
	{'Call Dreadstalkers', '!player.moving&player.buff(Demonic Calling)'},
	{'Hand of Gul\'dan', '!player.moving&player.soulshards>3'},
	{'Thal\'kiel\'s Consumption', '!player.moving&player.spell(Call Dreadstalkers).cooldown>3&player.lastgcd(Hand of Gul\'dan)', 'target'},
	{'Demonic Empowerment', '!player.moving&!player.lastgcd(Demonic Empowerment)&{warlock.empower==0||player.lastgcd(Summon Felguard)||player.lastgcd(Call Dreadstalkers)||player.lastgcd(Hand of Gul\'dan)||player.lastgcd(Summon Darkglare)||player.lastgcd(Summon Doomguard)||player.lastgcd(Grimoire: Felguard)||player.lastgcd(Thal\'kiel\'s Consumption)}'},
	{'Doom', '!talent(4,1)&toggle(Doom)&!target.debuff(Doom)&target.inRanged'},
	{'Life Tap', 'player.mana<40&player.health>05&{!player.lastgcd(Summon Felguard)||!player.lastgcd(Call Dreadstalkers)||!player.lastgcd(Hand of Gul\'dan)||!player.lastgcd(Summon Darkglare)||!player.lastgcd(Summon Doomguard)||!player.lastgcd(Grimoire: Felguard)}'},
	{'Demonwrath', 'movingfor>1&player.combat.time>2'},
	{'Demonbolt', '!player.moving&talent(7,2)&!player.soulshards==4'},
	{'Shadow Bolt', '!player.moving&!talent(7,2)&!player.soulshards==4'},
	{'&89751', 'target.petrange<9&player.area(8).enemies>2&pet.exists'},
}

local inCombat = {
	{Keybinds},
	{Interrupts_Random},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<31'},
	{Survival},
	{Player, '!player.moving'},
	{Fel_Explosives, 'range<31'},
	{Cooldowns, 'toggle(cooldowns)'},
	{ST, 'target.inFront&target.range<31'},
}

local outCombat = {
	{'Summon Felguard', '{!pet.exists||!pet.alive}&!talent(6,1)}'},
	{'Life Tap', 'player.mana<70&player.health>50'},
	{Interrupts_Random},
	{Interrupts, 'toggle(Interrupts)'},
	{'Create Healthstone', 'item(5512).count<1&!lastcast(Create Healthstone)'},
}

NeP.CR:Add(266, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Demonology',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
