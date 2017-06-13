local _, Zylla = ...
local GUI = {
	-- General
	{type = 'header', 	text = 'Keybinds', 							align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', 				align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', 						align = 'center'},
	{type = 'text', 	text = 'Left Alt: ',						align = 'center'},
	{type = 'text', 	text = 'Right Alt: ',						align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',						key = 'kPause', 	default = true},
	-- Survival
	{type='spacer'},	{type='rule'},
	{type='header', 	text='Survival',							align='center'},
	{type='checkbox',	text='Enable Self-Heal (Flash of Light)',	key='kFoL',			default=false},
	{type='spinner', 	text='Flash of Light (HP%)',				key='E_FoL',		default=60},
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/3 - 4/1 - 5/2 - 6/2 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'AutoTaunt',
		name = 'Auto Taunt',
		text = 'Automatically taunt nearby enemies.',
		icon = 'Interface\\Icons\\spell_nature_shamanrage.png',
	})
end

local _Zylla = {
    {'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

local Util = {
	-- ETC.
	{'%pause' , 'player.debuff(200904)||player.debuff(Sapped Soul)'} -- Vault of the Wardens, Sapped Soul
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'Rebuke'},
	{'Hammer of Justice', 'cooldown(Rebuke).remains>gcd'},
	{'Arcane Torrent', 'target.inMelee&spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)'},
}

local Survival ={
	{'Flash of Light', 'player.health<=UI(E_FoL)&player.lastmoved>=1&UI(kFoL)', 'player'},
	{'Light of the Protector', 'player.health<=68&player.buff(Consecration)'},
}

local PreCombat = {

}

local Cooldowns = {
	{'Seraphim', 'talent(7,2)&spell(Shield of the Righteous).charges>=2'},
	{'Shield of the Righteous', 'target.inMelee&target.inFront&{!talent(7,2)||spell(Shield of the Righteous).charges>2}&!{player.buff(Eye of Tyr)&player.buff(Aegis of Light)&player.buff(Ardent Defender)&player.buff(Guardian of Ancient Kings)&player.buff(Divine Shield)}'},
	{'Bastion of Light', 'talent(2,2)&spell(Shield of the Righteous).charges<1'},
	{'Light of the Protector', 'player.health<40'},
	{'Hand of the Protector', 'talent(5,1)&player.health<40'},
	{'Light of the Protector', '{player.incdmg(10)>player.health.max*1.25}&player.health<55&talent(7,1)'},
	{'Light of the Protector', '{player.incdmg(13)>player.health.max*1.6}&player.health<55'},
	{'Hand of the Protector', 'talent(5,1)&{player.incdmg(6)>player.health.max*0.7}&player.health<55&talent(7,1)'},
	{'Hand of the Protector', 'talent(5,1)&{player.incdmg(9)>player.health.max*1.2}&player.health<55'},
	{'Divine Steed', 'talent(5,2)&player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	{'Eye of Tyr', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	{'Aegis of Light', 'talent(6,1)&player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	{'Guardian of Ancient Kings', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	{'Divine Shield', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	{'Ardent Defender', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	{'Lay on Hands', 'player.health<15'},
	{'Avenging Wrath', '!talent(7,2)'},
	{'Avenging Wrath', 'talent(7,2)&player.buff(Seraphim)'}
}

local AoE = {
	{'Avenger\'s Shield'},
	{'Blessed Hammer'},
	{'Judgment'},
	{'Consecration', 'target.range<7'},
	{'Hammer of the Righteous', '!talent(1,2)'},
}

local ST = {
	{'Judgment'},
	{'Blessed Hammer'},
	{'Avenger\'s Shield'},
	{'Consecration', 'target.range<7'},
	{'Blinding Light'},
	{'Hammer of the Righteous', '!talent(1,2)'},
}

local inCombat = {
	--{_Zylla, 'toggle(AutoTarget)'},
	{Util},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>=3'},
	{ST, 'target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(66, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Paladin - Protection',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
