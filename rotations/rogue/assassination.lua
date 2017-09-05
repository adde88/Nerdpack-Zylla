local _, Zylla = ...

local GUI= {
	--Logo
	{type = 'texture',  texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = -60, align = 'center'},
	{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},
	-- Keybinds
	{type = 'header', text = 'Keybinds',	 					 			align = 'center'},
	{type = 'text', 	 text = 'Left Shift: Pause',				align = 'left'},
	{type = 'text', 	 text = 'Left Ctrl: ',							align = 'left'},
	{type = 'text', 	 text = 'Left Alt: ',								align = 'left'},
	{type = 'text', 	 text = 'Right Alt: ',							align = 'left'},
	{type = 'ruler'},	 {type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',							 			align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type='checkbox',		text = 'Multi-Dot (Target/Focus/MousOver)',		key='multi', 	default=true},
	{type='checkbox',		text = 'Mantle of the Master Assassin',			key='mantle', 	default=false},
	{type = 'checkbox', 	text = 'Pause Enabled', 						key = 'kPause', default = true},
	{type='ruler'},			{type='spacer'},
	-- Survival
	{type = 'header', 		text = 'Survival', align = 'center'},
	{type='spinner', 		text = 'Crimson Vial', 							key='cv', 		default_spin=65},
	{type='spinner', 		text = 'Evasion (HP%)', 							key='E_HP', 	default_spin=40},
	{type = 'checkspin',	text = 'Healthstone',												key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',										key = 'AHP',					spin = 45, check = true},
	{type='ruler'},			{type='spacer'},
	--Cooldowns
	{type = 'header', 	text = 'Cooldowns When Toggled ON', 				align = 'center'},
	{type='checkbox',		text = 'Vanish',									key='van', 		default=true},
	{type='checkbox',		text = 'Vendetta',								key='ven', 		default=true},
	{type='checkbox',		text = 'Potion of the Old War',					key='ow', 		default=false},
	{type='ruler'},			{type='spacer'},
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
		text = 'If Enabled we will automatically use Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
	})

	NeP.Interface:AddToggle({
		key='xPickPock',
		name='Pick Pocket',
		text = 'If Enabled we will automatically Pick Pocket enemies out of combat.',
		icon='Interface\\Icons\\inv_misc_bag_11',
	})

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'!Kick', 'target.inMelee&target.inFront'},
	{'!Kidney Shot', 'target.inMelee&&target.inFront&cooldown(Kick).remains>gcd&!player.lastcast(Kick)&player.combopoints>0'},
	{'!Arcane Torrent', 'target.inMelee&spell(Kick).cooldown>gcd&!prev_gcd(Kick)'},
}

local preCombat = {
	{'Tricks of the Trade', '!focus.buff&pull_timer<5', 'focus'},
	{'Tricks of the Trade', '!tank.buff&pull_timer<5', 'tank'},
	{'#Potion of the Old War', '!player.buff&pull_timer<3&UI(ow)'},
}

local Survival = {
	--{'Feint', ''},
	{'Crimson Vial', 'player.health<=UI(cv)&player.energy>25'},
	{'Evasion', 'player.health<=UI(E_HP)'},
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 						--Health Stone
	{'Cloak of Shadows', 'incdmg(5).magic>player.health.max'},
}

local Cooldowns= {
	{'Vendetta', 'player.energy<60'},
	{'Vanish', '!player.buff(Stealth)&player.combopoints>3&UI(van)'},
	{'#Potion of the Old War', 'UI(ow)&player.hashero||UI(ow)&target.ttd<35'},
}

local TricksofTrade = {
	{'Tricks of the Trade', '!focus.buff&!focus.enemy', 'focus'},
	{'Tricks of the Trade', '!tank.buff', 'tank'},
}

local Ranged = {
	{'Poisoned Knife', 'player.energy>060&player.combopoints<5'},
	{'Poisoned Knife', '&target.debuff(Agonizing Poison).duration<3'},
}

local inStealth = {
	{'Rupture', 'player.lastcast(Vanish)&player.combopoints>4'},
	{'Garrote', 'player.buff(Stealth)&player.combopoints<5&target.debuff.duration<6.4'},
}

local Poisons = {
	{'Deadly Poison', 'player.buff.duration<700&!player.lastcast&!talent(6,1)'},
	{'Agonizing Poison', 'player.buff.duration<700&!player.lastcast&talent(6,1)'},
	{'Leeching Poison', 'player.buff.duration<700&!player.lastcast&talent(4,1)'},
	{'Crippling Poison', 'player.buff.duration<700&!player.lastcast&!talent(4,1)'},
}

local xCombat = {
	{Survival},
	-- Rupture
	{'Rupture', 'player.buff(Vanish)&toggle(cooldowns)'},
	{'Rupture', 'target.debuff.duration<8.2&player.combopoints>3&player.spell(Vanish).cooldown&target.ttd>5'},
	-- Multi DoT Rupture
	{'Rupture', 'target.enemy&target.inMelee&target.debuff.duration<8.2&player.combopoints>3', 'target'},
	{'Rupture', 'focus.enemy&focus.inMelee&focus.debuff.duration<8.2&player.combopoints>3&focus.enemy&UI(multi)', 'focus'},
	{'Rupture', 'mouseover.enemy&mouseover.inMelee&mouseover.debuff.duration<8.2&player.combopoints>3&UI(multi)', 'mouseover'},
	{'Garrote', 'target.debuff.duration<6.4&player.combopoints<5&target.inMelee'},
	-- Use Mutilate till 4/5 combopoints for rupture
	{'Mutilate', '!target.debuff(Rupture)&player.combopoints<4&target.inMelee'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&target.debuff(Vendetta)&target.debuff(Surge of Toxins)&target.ttd>00'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&player.spell(Vendetta).cooldown<6.8&target.ttd>00'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&player.spell(Vendetta).cooldown>00&target.ttd>00'},
	{'Envenom', 'player.combopoints>2&target.debuff(Surge of Toxins).duration<=0.5&target.debuff(Vendetta)'},
	{'Envenom', 'player.combopoints>3&target.debuff(Vendetta)'},
	{'Envenom', 'player.combopoints>3&target.debuff(Surge of Toxins).duration<=0.5'},
	{'Envenom', 'player.combopoints>3&player.energy>060'},
	{'Fan of Knives', 'player.area(10).enemies>2&player.combopoints<5'},
	{'Mutilate', 'player.combopoints<4&player.buff(Envenom)&target.inMelee'},
	{'Mutilate', 'player.spell(Vendetta).cooldown<6&player.combopoints<4&target.inMelee'},
	{'Mutilate', 'player.combopoints<4&target.inMelee'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{TricksofTrade},
	{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, 'target.inMelee&!player.buff(Stealth)'},
	{inStealth},
	{Ranged, '!target.inMelee&target.inRanged'},
}

local outCombat= {
	-- Poisons
	{Poisons},
	{'Rupture', 'target.inMelee&target.enemy&player.buff(Vanish)'},
	{'Garrote', 'target.inMelee&target.enemy&player.buff(Stealth)&player.combopoints<5&target.debuff.duration<6.4'},
	{'Stealth', 'toggle(xStealth)&!player.buff&!player.buff(Vanish)&!nfly'},
	{Keybinds},
	{preCombat},
	{'Pick Pocket', 'toggle(xPickPock)&enemy&alive&range<=10&player.buff(Stealth)' ,'enemies'},
}

NeP.CR:Add(259, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Assassination',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
