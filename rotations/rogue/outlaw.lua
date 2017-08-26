local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	--Logo
  {type = 'texture', texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = 42, center = true},
  {type = 'ruler'},	  {type = 'spacer'},
	-- General
	{type = 'header', 	text = 'General', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Cannonball Barrage (Cursor}', align = 'center'},
	{type = 'text', 	text = 'Left Alt: Grappling Hook (Cursor)', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
  -- Survival
	{type = 'header', 	text = 'Survival',							align = 'center'},
	{type = 'spinner',	text = 'Use Crisom Vial when below %',		key = 'h_CV',	default = 75},
	{type = 'spinner',	text = 'Use Riposte when below %',			key = 'h_RIP',	default = 25},
	{type = 'spinner',	text = 'Healthstone or Healing Potions',	key = 'Health Stone',	default = 45},
	{type = 'ruler'},	  {type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'spinner',	text = '', key = 'k_HeirHP', default = 40},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffFFFF00 ----------------------------------------------------------------------|r')
	print('|cffFFFF00 --- |rRogue |cffFFF569Outlaw |r')
	print('|cffFFFF00 --- |rRecommended Talents: 1/1 - 2/3 - 3/1 - 4/X - 5/1 - 6/2 - 7/2')
  print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key='opener',
		name='Opener',
		text = 'If Enabled we will Open with Ambush when Stealthed. If not Cheap Shot will be used.',
		icon='Interface\\Icons\\ability_rogue_ambush',
	})

	NeP.Interface:AddToggle({
		key='xStealth',
		name='Auto Stealth',
		text = 'If Enabled we will automatically use Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
	})

	NeP.Interface:AddToggle({
		key='xPickPock',
		name='Pick Pocket',
		text = 'If Enabled we will automatically Pick Pocket enemies out of combat.',
		icon='Interface\\Icons\\inv_misc_bag_11',
	})

  NeP.Interface:AddToggle({
   key = 'xIntRandom',
   name = 'Interrupt Anyone',
   text = 'Interrupt all nearby enemies, without targeting them.',
   icon = 'Interface\\Icons\\inv_ammo_arrow_04',
 })

end

local Survival ={
	{'Crimson Vial', 'player.health<UI(h_CV)'},
	{'Riposte', 'player.health<UI(h_RIP)||player.incdmg(5)>player.health.max*0.20'},
	{'Cloak of Shadows', 'incdmg(5).magic>player.health.max*0.20'},
	{'#127834', 'item(127834).count>0&player.health<UI(Health Stone)'},        -- Ancient Healing Potion
	{'#5512', 'item(5512).count>0&player.health<UI(Health Stone)', 'player'},  --Health Stone
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Cannonball Barrage', 'keybind(lcontrol)', 'cursor.ground'},
	{'!Grappling Hook', 'talent(2,1)&keybind(lalt)', 'cursor.ground'},
}

local Interrupts = {
	{'!Kick', 'target.range<=5&target.inFront'},
	{'!Between the Eyes', 'target.range<21&target.inFront&player.spell(Kick).cooldown>gcd&combo_points>0&!player.lastgcd(Kick)'},
	{'!Cloak of Shadows', 'player.spell(Kick).cooldown>gcd&player.spell(Between the Eyes).cooldown>gcd'},
}

local Interrupts_Random = {
	{'!Kick', 'interruptAt(70)&inFront&range<=5', 'enemies'},
  {'!Between the Eyes', 'interruptAt(70)&player.spell(Kick).cooldown>gcd&!player.lastgcd(Kick)&inFront&range<21', 'enemies'},
}

local Build = {
	{'Ghostly Strike', 'target.range<=5&combo_points.deficit>0&target.debuff(Ghostly Strike).duration<2'},
	{'Pistol Shot', 'target.range<30&player.buff(Opportunity)&combo_points<5'},
	{'Saber Slash', 'target.range<=5&{combo_points<5||{combo_points<6&buff(Broadsides)}}'},
}

local Finishers = {
	{'Between the Eyes', 'target.range<30&combo_points>4&buff(Shark Infested Waters)'},
	{'Run Through', 'target.range<=5&combo_points>4'},
	{'Death from Above', 'talent(7,3)&target.area(8).enemies>4&combo_points>4'},
	{'Slice and Dice', 'talent(7,1)&combo_points>4&player.buff(Slice and Dice).remains<3'},
}

local Blade_Flurry = {
	{'Blade Flurry', 'player.area(8).enemies>=3&!player.buff(Blade Flurry)'},
	{'Blade Flurry', 'player.area(8).enemies<=2&player.buff(Blade Flurry)'},
}

local Cooldowns = {
	{'Cannonball Barrage', 'target.area(10).enemies<4', 'target.ground'},
	{'Adrenaline Rush', 'target.range<=5&energy.deficit>0'},
	{'Marked for Death', 'talent(7,2)&{combo_points<6&player.energy>16}||pull_timer<20'},
	{'Curse of the Dreadblades', 'combo_points.deficit>3&{!talent(1,1)||target.debuff(Ghostly Strike)}'},
	{'Killing Spree', 'talent(6,3)&energy.time_to_max>5||player.energy<15'},
}

local RollingBones ={
	--[[{'Roll the Bones', '{!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&buff(Buried Treasure)}', 'player'},]]
	--[[{'Roll the Bones', '!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)'},]]
	{'Roll the Bones', 'combopoints>=5&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)', 'player'},
	{'Roll the Bones', 'combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!talent(7,1)&buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&buff(Buried Treasure)', 'player'},
	{'Roll the Bones', 'combopoints>4&!talent(7,1)&!RtB', 'player'},
}

local TricksofTrade = {
	{'Tricks of the Trade', '!is(player)&!buff&range<99', {'focus', 'tank'}},
}

local Stealth_Opener = {
	{'Ambush', 'enemy&range<=5&inFront&player.buff(Stealth)&toggle(opener)', 'target'},
	{'Cheap Shot', 'enemy&range<=5&inFront&player.buff(Stealth)&!toggle(opener)', 'target'},
}

local xCombat = {
	{RollingBones},
	{Blade_Flurry},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Build},
	{Finishers},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	{Keybinds},
  {Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)'},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.inFront&target.range<=5'},
	{TricksofTrade},
}

local outCombat = {
	{'Stealth', 'toggle(xStealth)&!player.buff&!player.buff(Vanish)&!nfly'},
	{Stealth_Opener, '!toggle(xPickPock)'},
  {Blade_Flurry},
	{Keybinds},
	{TricksofTrade},
  {Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)'},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{'Pick Pocket', 'toggle(xPickPock)&enemy&alive&range<=10&player.buff(Stealth)', 'enemies'},
}

NeP.CR:Add(260, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Outlaw',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
