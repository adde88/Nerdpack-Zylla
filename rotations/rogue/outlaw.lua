local _, Zylla = ...

local GUI = {
	--Logo
	{type = 'texture',  texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = -60, align = 'center'},
	{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},
	-- Keybinds
	{type = 'header', text = 'Keybinds',	 					 												align = 'center'},
	{type = 'text', 	 text = 'Left Shift: Pause',													align = 'left'},
	{type = 'text', 	 text = 'Left Ctrl: Cannonball Barrage',							align = 'left'},
	{type = 'text', 	 text = 'Left Alt: Grappling Hook',										align = 'left'},
	{type = 'text', 	 text = 'Right Alt: ',																align = 'left'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',							 					align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', 												key = 'kPause', default = true},
	{type = 'checkbox', text = 'Use Tricks of the Trade on focus/tank', key = 'tot', default = true},
	{type='ruler'},			{type='spacer'},
  -- Survival
	{type = 'header', 	text = 'Survival',														align = 'center'},
	{type = 'checkspin',	text = 'Use Crisom Vial when below %',			key = 'h_CV',					spin = 75, check = true},
	{type = 'checkspin',	text = 'Use Riposte when below %',					key = 'h_RIP',				spin = 25, check = true},
	{type = 'checkspin',	text = 'Healthstone',												key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',										key = 'AHP',					spin = 45, check = true},
	{type = 'ruler'},	  {type = 'spacer'},
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
	{'Crimson Vial', 'health<UI(h_CV_spin)&UI(h_CV_check)', 'player'},
	{'Riposte', 'UI(h_RIP_check)&{health<UI(h_RIP_spin)||incdmg(5)>health.max*0.20}' ,'player'},
	{'Cloak of Shadows', 'incdmg(5).magic>health.max*0.20', 'player'},
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 						--Health Stone
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Cannonball Barrage', 'keybind(lcontrol)', 'cursor.ground'},
	{'!Grappling Hook', 'talent(2,1)&keybind(lalt)', 'cursor.ground'},
}

local Interrupts = {
	{'!Kick', 'range<=5&inFront', 'target'},
	{'!Between the Eyes', 'range<21&inFront&player.spell(Kick).cooldown>gcd&player.combopoints>0&!player.lastgcd(Kick)', 'target'},
	{'!Cloak of Shadows', 'spell(Kick).cooldown>gcd&spell(Between the Eyes).cooldown>gcd', 'player'},
}

local Interrupts_Random = {
	{'!Kick', 'interruptAt(70)&inFront&range<=5', 'enemies'},
  {'!Between the Eyes', 'interruptAt(70)&player.spell(Kick).cooldown>gcd&!player.lastgcd(Kick)&inFront&range<21', 'enemies'},
}

local Build = {
	{'Ghostly Strike', 'range<=5&combo_points.deficit>0&debuff(Ghostly Strike).duration<2', 'target'},
	{'Pistol Shot', 'range<31&player.buff(Opportunity)&player.combopoints<5', 'target'},
	{'Saber Slash', 'range<=5&{player.combopoints<5||{player.combopoints<6&buff(Broadsides)}}', 'target'},
}

local Finishers = {
	{'Between the Eyes', 'range<30&player.combopoints>4&buff(Shark Infested Waters)', 'target'},
	{'Run Through', 'range<=5&player.combopoints>4', 'target'},
	{'Death from Above', 'talent(7,3)&area(8).enemies>4&player.combopoints>4', 'target'},
	{'Slice and Dice', 'talent(7,1)&combopoints>4&buff(Slice and Dice).remains<3', 'player'},
}

local Blade_Flurry = {
	{'Blade Flurry', 'area(8).enemies>=3&!buff(Blade Flurry)', 'player'},
	{'Blade Flurry', 'area(8).enemies<=2&buff(Blade Flurry)', 'player'}
}

local Cooldowns = {
	{'Cannonball Barrage', 'area(10).enemies<4', 'target.ground'},
	{'Adrenaline Rush', 'target.range<=5&energy.deficit>0', 'player'},
	{'Marked for Death', 'talent(7,2)&{player.combopoints<6&player.energy>16}||xtime<20', 'target'},
	{'Curse of the Dreadblades', 'combo_points.deficit>3&{!talent(1,1)||debuff(Ghostly Strike)}', 'target'},
	{'Killing Spree', 'talent(6,3)&energy.time_to_max>5||player.energy<15', 'target'},
}

local RollingBones ={
	--[[{'Roll the Bones', '{!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Adrenaline Rush)&!buff(Curse of the Dreadblades)&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&buff(Buried Treasure)}', 'player'},]]
	--[[{'Roll the Bones', '!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)'},]]
	{'Roll the Bones', 'combopoints>=5&!talent(7,1)&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)', 'player'},
	{'Roll the Bones', 'combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!talent(7,1)&buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)||combopoints>=5&!talent(7,1)&spell(Adrenaline Rush).cooldown>15&spell(Curse of the Dreadblades).cooldown>15&!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&buff(Buried Treasure)', 'player'},
	{'Roll the Bones', 'combopoints>4&!talent(7,1)&!RtB', 'player'},
}

local TricksofTrade = {
	{'Tricks of the Trade', 'UI(tott)&!is(player)&!buff&range<99', {'focus', 'tank'}},
}

local Stealth_Opener = {
	{'Ambush', 'enemy&range<=5&inFront&player.buff(Stealth)&toggle(opener)', 'target'},
	{'Cheap Shot', 'enemy&range<=5&inFront&player.buff(Stealth)&!toggle(opener)', 'target'}
}

local xCombat = {
	{RollingBones},
	{Blade_Flurry},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Build},
	{Finishers},
}

local inCombat = {
	{Keybinds},
  {Interrupts_Random, 'toggle(xIntRandom)&toggle(Interrupts)'},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Survival, 'player.health<100'},
	{Blade_Flurry},
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
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
