local _, Zylla = ...
local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/3 - 4/1 - 5/2 - 6/2 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	
	NeP.Interface.CreateToggle(
		'AutoTaunt',
		'Interface\\Icons\\spell_nature_shamanrage.png',
		'Auto Taunt',
		'Automatically taunt nearby enemies.')
end

local _Zylla = {
	{"/targetenemy [noexists]", "!target.exists" },
    {"/targetenemy [dead][noharm]", "target.dead" },
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}

local Interrupts = {
	{'Rebuke'},
	{'Hammer of Justice', 'spell(Rebuke).cooldown>gcd'},
	{'Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)'},
}

local Survival ={

}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
}

local Cooldowns = {
	{'Seraphim', 'talent(7,2)&spell(Shield of the Righteous).charges>=2'},
	{'Shield of the Righteous', {'target.range<8', 'target.infront', '{!talent(7,2)||spell(Shield of the Righteous).charges>2}&!{player.buff(Eye of Tyr)&player.buff(Aegis of Light)&player.buff(Ardent Defender)&player.buff(Guardian of Ancient Kings)&player.buff(Divine Shield)}'}},
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
	{Keybinds},
	{_Zylla, 'UI(kAutoTarget)'},
	--{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<=8'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, 'toggle(AoE)&player.area(8).enemies>=3'},
	{ST, 'target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(66, {
	name = '[|cff'..Zylla.addonColor..'ZYLLA\'s|r] PALADIN - Protection',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
