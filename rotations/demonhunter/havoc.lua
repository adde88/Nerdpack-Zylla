local _, Zylla = ...
local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rDEMON HUNTER |cffADFF2FHavoc|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")
end

local Util = {
	-- ETC.
	{'%pause' , 'player.debuff(200904)||player.debuff(Sapped Soul)'}, -- Vault of the Wardens, Sapped Soul
}

local Trinkets = {
	{'#trinket1', 'UI(kT1)'},
	{'#trinket2', 'UI(kT2)'},
	{'#Ring of Collapsing Futures', 'equipped(142173)&!player.debuff(Temptation)&UI(kRoCF)', 'target.enemy'},
}

local Heirlooms = {
	{'#Eternal Horizon Choker', 'equipped(122664)&UI(k_HEIR)&player.health<=UI(k_HeirHP)'},
	{'#Eternal Amulet of the Redeemed', 'equipped(122663)&UI(k_HEIR)&player.health<=UI(k_HeirHP)'},
	{'#Eternal Woven Ivy Necklace', 'equipped(122666)&UI(k_HEIR)&player.health<=UI(k_HeirHP)'},
	{'#Eternal Emberfury Talisman', 'equipped(122667)&UI(k_HEIR)&player.health<=UI(k_HeirHP)'},
	{'#Eternal Will of the Martyr', 'equipped(122668)&UI(k_HEIR)&player.health<=UI(k_HeirHP)'},
	{'#Touch of the Void', 'equipped(128318)&UI(k_HEIR)&player.area(8).enemies>=3'},
	{'#Inherited Mark of Tyranny', 'equipped(122530)&UI(k_HEIR)&player.incdmg(2.5)>player.health.max*0.50'},
	{'#Inherited Insignia of the Alliance', 'equipped(44098)&UI(k_HEIR)&{player.state.incapacitate||player.state.stun||player.state.fear||player.state.horror||player.state.sleep||player.state.charm}'},
	{'#Inherited Insignia of the Horde', 'equipped(44097)&UI(k_HEIR)&{player.state.incapacitate||player.state.stun||player.state.fear||player.state.horror||player.state.sleep||player.state.charm}'},
	{'#Returning Champion', 'equipped(126949)&UI(k_HEIR)&{player.incdmg(2.5)>player.health.max*0.50}||{player.health<=20}'},
	{'#Defending Champion', 'equipped(126948)&UI(k_HEIR)&{player.incdmg(2.5)>player.health.max*0.50}||{player.health<=20}'},
}

local Survival = {
	{'Blur', 'player.health<=60'}
}

local Interrupts = {
	{'Consume Magic'}
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Cooldowns = {
	{'Metamorphosis', nil, 'target.ground'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(50)'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Vengeful Retreat', {'target.range<=6', 'player.spell(Fel Rush).charges>=2', 'player.fury<=85'}},
	{'Fel Rush', {'player.spell(Fel Rush).charges>=2', 'target.range>5'}},
	{'Blade Dance', {'toggle(AoE)', 'player.area(8).enemies>=4'}},
	{'Chaos Strike', 'player.fury>=70'},
	{'Demon\'s Bite'},
}

local outCombat = {
	{Keybinds}
}

NeP.CR:Add(577, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Havoc',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
