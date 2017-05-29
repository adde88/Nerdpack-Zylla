local _, Zylla = ...
local GUI= {
	-- General
	{type='header', 		text='General', 								align='center'},
	{type='checkbox',		text='Multi-Dot (Target/Focus/MousOver)',		key='multi', 	default=true},
	{type='checkbox',		text='Mantle of the Master Assassin',			key='mantle', 	default=false},
	{type='ruler'},			{type='spacer'},
	
	-- Survival
	{type='header', 		text='Survival', align='center'},
	{type='spinner', 		text='Crimson Vial', 							key='cv', 		default_spin=65},
	{type='spinner', 		text='Evasion (HP%)', 							key='E_HP', 	default_spin=40},
	{type='checkspin', 		text='Health Potion', 							key='hp', 		default_check=true, default_spin=25},
	{type='checkspin',		text='Healthstone', 							key='hs', 		default_check=true, default_spin=25},
	{type='ruler'},			{type='spacer'},
	
	--Cooldowns
	{type='header', 		text='Cooldowns When Toggled ON', 				align='center'},
	{type='checkbox',		text='Vanish',									key='van', 		default=true},
	{type='checkbox',		text='Vendetta',								key='ven', 		default=true},
	{type='checkbox',		text='Potion of the Old War',					key='ow', 		default=false},
	{type='ruler'},			{type='spacer'},
}  
 
local exeOnLoad=function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |Rogue |cffADFF2FAssassination|r")
	print("|cffADFF2F ---")
	print("|cffADFF2F --- |rRecommended Talents: 1,1 / 2,1 / 3,3 / any / any / 6,1 or 6,2 / 7,1")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	
end

local _Zylla = {
    {'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

local Interrupts = {
	{'Kick', 'target.inmelee'},
	{'Kidney Shot', 'target.inmelee&cooldown(Kick).remains>gcd&!player.lastcast(Kick)&player.combopoints>0'},
	{'Arcane Torrent', 'target.range<=8&spell(Kick).cooldown>gcd&!prev_gcd(Kick)'},
}

local preCombat = {
	{'Tricks of the Trade', '!focus.buff&pull_timer<=4', 'focus'},
	{'Tricks of the Trade', '!tank.buff&pull_timer<=4', 'tank'},
	{'#Potion of the Old War', '!player.buff&pull_timer<=2&UI(ow)'},
}

local Survival = {
	--{'Feint', ''},
	{'Crimson Vial', 'player.health<=UI(cv)&player.energy>=35'},
	{'Evasion', 'player.health<=UI(E_HP)'},
	{'#Ancient Healing Potion', 'UI(hp_check)&player.health<=UI(hp_spin)'},
	{'#Healthstone', 'UI(hs_check)&player.health<=UI(hs_spin)'},
	{'Cloak of Shadows', 'incdmg(5).magic>player.health.max'},
}

local Cooldowns= {
	{'Vendetta', 'player.energy<=50'},
	{'Vanish', '!player.buff(Stealth)&player.combopoints>=4&UI(van)'},
	{'#Potion of the Old War', 'UI(ow)&player.hashero||UI(ow)&target.ttd<=25'},
}

local TricksofTrade = {
	{'Tricks of the Trade', '!focus.buff&!focus.enemy', 'focus'},
	{'Tricks of the Trade', '!tank.buff', 'tank'},
}

local Ranged = {
	{'Poisoned Knife', 'player.energy>=160&player.combopoints<=4'},
	{'Poisoned Knife', '&target.debuff(Agonizing Poison).duration<=2'},
}

local inStealth = {
	{'Rupture', 'player.lastcast(Vanish)&player.combopoints>=5'},
	{'Garrote', 'player.buff(Stealth)&player.combopoints<=4&target.debuff.duration<=5.4'},
}

local xCombat = {
	{Survival},	
	-- Rupture
	{'Rupture', 'player.buff(Vanish)&toggle(cooldowns)'},
	{'Rupture', 'target.debuff.duration<=7.2&player.combopoints>=4&player.spell(Vanish).cooldown&target.ttd>=6'},
	-- Multi DoT Rupture
	{'Rupture', 'target.enemy&target.inmelee&target.debuff.duration<=7.2&player.combopoints>=4', 'target'},
	{'Rupture', 'focus.enemy&focus.inmelee&focus.debuff.duration<=7.2&player.combopoints>=4&focus.enemy&UI(multi)', 'focus'},
	{'Rupture', 'mouseover.enemy&mouseover.inmelee&mouseover.debuff.duration<=7.2&player.combopoints>=4&UI(multi)', 'mouseover'},
	{'Garrote', 'target.debuff.duration<=5.4&player.combopoints<=4&target.inmelee'},
	-- Use Mutilate till 4/5 combopoints for rupture
	{'Mutilate', '!target.debuff(Rupture)&player.combopoints<=3&target.inmelee'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&target.debuff(Vendetta)&target.debuff(Surge of Toxins)&target.ttd>=10'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&player.spell(Vendetta).cooldown<=5.8&target.ttd>=10'},
	{'Kingsbane', '!talent(6,3)&player.buff(Envenom)&player.spell(Vendetta).cooldown>=10&target.ttd>=10'},
	{'Envenom', 'player.combopoints>=3&target.debuff(Surge of Toxins).duration<=0.5&target.debuff(Vendetta)'},
	{'Envenom', 'player.combopoints>=4&target.debuff(Vendetta)'},
	{'Envenom', 'player.combopoints>=4&target.debuff(Surge of Toxins).duration<=0.5'},
	{'Envenom', 'player.combopoints>=4&player.energy>=160'},
	{'Fan of Knives', 'player.area(10).enemies>=3&player.combopoints<=4'},
	{'Mutilate', 'player.combopoints<=3&player.buff(Envenom)&target.inmelee'},
	{'Mutilate', 'player.spell(Vendetta).cooldown<=5&player.combopoints<=3&target.inmelee'},
	{'Mutilate', 'player.combopoints<=3&target.inmelee'},
}

local inCombat = {
	{_Zylla},
	{Keybinds},
	{Interrupts, 'target.interruptAt(55)'},
	{TricksofTrade},
	{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, 'target.inmelee&!player.buff(Stealth)'},
	{inStealth},
	{Ranged, 'target.range>=10'},
}

local outCombat= {
	-- Poisons
	{'Deadly Poison', 'player.buff.duration<=600&!player.lastcast&!talent(6,1)'},
	{'Agonizing Poison', 'player.buff.duration<=600&!player.lastcast&talent(6,1)'},
	{'Leeching Poison', 'player.buff.duration<=600&!player.lastcast&talent(4,1)'},
	{'Crippling Poison', 'player.buff.duration<=600&!player.lastcast&!talent(4,1)'},
	{'Rupture', 'target.inmelee&target.enemy&player.buff(Vanish)'},
	{'Garrote', 'target.inmelee&target.enemy&player.buff(Stealth)&player.combopoints<=4&target.debuff.duration<=5.4'},
	{'Stealth', '!player.buff&!player.buff(Vanish)'},
	{Keybinds},
	{preCombat},
}

NeP.CR:Add(259, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Assassination',
	  ic=inCombat,
	 ooc=outCombat,
	 gui=GUI,
	load=exeOnLoad
})
