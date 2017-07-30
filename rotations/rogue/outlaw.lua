local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Cannonball Barrage (Cursor}', align = 'center'},
	{type = 'text', 	text = 'Left Alt: Grappling Hook (Cursor)', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
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

	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rRogue |cffFFF569Outlaw |r")
	print("|cffFFFF00 --- |rRecommended Talents: 1/1 - 2/3 - 3/1 - 4/X - 5/1 - 6/2 - 7/2")
	print("|cffFFFF00 ----------------------------------------------------------------------|r")

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

end

local Survival ={
	{'Crimson Vial', 'player.health<75'},
	{'Riposte', 'player.health<55||player.incdmg(5)>player.health.max*0.20'},
	{'Cloak of Shadows', 'incdmg(5).magic>player.health.max'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'!Cannonball Barrage', 'keybind(lcontrol)', 'cursor.ground'},
	{'!Grappling Hook', 'talent(2,1)&keybind(lalt)', 'cursor.ground'},
}

local Interrupts = {
	{'!Kick', 'target.inMelee'},
	{'!Between the Eyes', 'target.range<30&cooldown(Kick).remains>gcd&combo_points>0'},
	{'!Blind', 'target.range<25&cooldown(Kick).remains>gcd&cooldown(Between the Eyes)>gcd'},
	{'!Cloak of Shadows', 'cooldown(Kick).remains>gcd&cooldown(Between the Eyes)>gcd&cooldown(Blind)>gcd'},
}

local Build = {
	{'Ghostly Strike', 'target.inMelee&combo_points.deficit>0&target.debuff(Ghostly Strike).duration<2'},
	{'Pistol Shot', 'target.range<30&player.buff(Opportunity)&combo_points<5'},
	{'Saber Slash', 'target.inMelee&{combo_points<5||{combo_points<6&player.buff(Broadsides)}}'},
}

local Finishers = {
	{'Between the Eyes', 'target.range<30&combo_points>4&player.buff(Shark Infested Waters)'},
	{'Run Through', 'target.inMelee&combo_points>4'},
	{'Death from Above', 'talent(7,3)&target.area(8).enemies>4&combo_points>4'},
	{'Slice and Dice', 'talent(7,1)&combo_points>4&player.buff(Slice and Dice).remains<3'},
}

local Blade_Flurry = {
	{'Blade Flurry', 'player.area(7).enemies>2&!player.buff(Blade Flurry)'},
	{'Blade Flurry', 'player.area(7).enemies<3&player.buff(Blade Flurry)'},
}

local Cooldowns = {
	{'Cannonball Barrage', 'target.area(10).enemies<4', 'target.ground'},
	{'Adrenaline Rush', 'target.inMelee&energy.deficit>0'},
	{'Marked for Death', 'talent(7,2)&{combo_points<6&player.energy>16}||pull_timer<20'},
	{'Curse of the Dreadblades', 'combo_points.deficit>3&{!talent(1,1)||target.debuff(Ghostly Strike)}'},
	{'Killing Spree', 'talent(6,3)&energy.time_to_max>5||player.energy<15'},
}

local RollingBones ={
	{'Roll the Bones', 'player.combopoints>4&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)'},
	{'Roll the Bones', 'player.combopoints>4&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.talent(7,1)&player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>4&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>4&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>4&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>4&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)'},
	{'Roll the Bones', '!RtB'},
}

local TricksofTrade = {
	{'Tricks of the Trade', '!focus.buff&focus.range<99', 'focus'},
	{'Tricks of the Trade', '!tank.is(player)&!tank.buff&tank.range<99', 'tank'},
}

local Stealth_Opener = {
	{'Stealth', '&toggle(xStealth)&!player.buff&!player.buff(Vanish)&!nfly'},
	{'Ambush', 'target.enemy&target.inMelee&target.inFront&player.buff(Stealth)&toggle(opener)'},
	{'Cheap Shot', 'target.enemy&target.inMelee&target.inFront&player.buff(Stealth)&!toggle(opener)'},
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
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.inFront&target.inMelee'},
	{TricksofTrade},
}

local outCombat = {
	{Stealth_Opener},
	{Keybinds},
	{TricksofTrade},
}

NeP.CR:Add(260, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Outlaw',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
