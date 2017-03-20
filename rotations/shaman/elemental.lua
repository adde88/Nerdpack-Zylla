local _, Zylla = ...
local GUI = {
}
local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSHAMAN |cffADFF2FElemental |r')
	print('|cffADFF2F --- |r TOTEM MASTERY FIXED? if no report it to me please!|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/1 - 3/1 - 4/2 - 5/2 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
	{'@Zylla.Targeting()', {'!target.alive&toggle(AutoTarget)'}},
}

local Survival = {

}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	{'Stormkeeper'},
	{'Totem Mastery', '!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)'},
}

local Cooldowns = {
	--# Executed every time the actor is available.
	--# In-combat potion is preferentially linked to Ascendance, unless combat will end shortly
	--{'Totem Mastery', 'totem(Totem Mastery).duration<1'},
	{'Totem Mastery', '!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)'},
	{'Fire Elemental', '!talent(6,2)'},
	{'Storm Elemental', 'talent(6,2)'},
	{'Elemental Mastery', 'talent(6,1)'},
	{'Blood Fury', '!talent(7,1)||player.buff(Ascendance)||spell(Ascendance)cooldown>50'},
	{'Berserking', '!talent(Ascendance)||player.buff(Ascendance)'}
}

local Interrupts = {
	{'Wind Shear'},
}

local AoE = {
	{'Stormkeeper'},
	{'Ascendance'},
	{'Liquid Magma Totem', 'talent(7,3)'},
	{'Flame Shock', 'player.maelstrom>=20&target.debuff(Flame Shock).duration<gcd'},
	{'Earthquake', 'player.maelstrom>=50', 'cursor.ground'},
	{'Lava Burst', '!player.buff(Lava Surge)'},
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)'},
	{'Chain Lightning', 'talent(7,2)&!target.debuff(Lightning Rod)'},
	{'Chain Lightning'},
	{'Lava Burst', 'xmoving=1'},
	{'Flame Shock', 'xmoving=1&target.debuff(Flame Shock).duration<gcd'}
}

local ST = {
	{'Ascendance', 'target.debuff(Flame Shock).duration>player.buff(Ascendance).duration&{combat(player).time>=60||player.buff(Bloodlust)}&spell(Lava Burst).cooldown>0&!player.buff(Stormkeeper)'},
	{'Flame Shock', '!target.debuff(Flame Shock)'},
	{'Flame Shock', 'player.maelstrom>=20&target.debuff(Flame Shock).duration<player.buff(Ascendance).duration&spell(Ascendance).cooldown+player.buff(Ascendance).duration<=target.debuff(Flame Shock).duration'},
	{'Earth Shock', 'player.maelstrom>=92'},
	--{'Icefury', 'talent(5,3)'},
	{'Lava Burst', 'target.debuff(Flame Shock).duration>action(Lava Burst).cast_time&{spell(Lava Burst).cooldown=0||player.buff(Ascendance)}'},
	{'Elemental Blast', '(4,1)'},
	{'Earthquake Totem', '{player.buff(Echoes of the Great Sundering)&totem(Earthquake Totem).duration<1}', 'target.ground'},
	{'Flame Shock', 'player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<gcd'},
	{'Frost Shock', 'talent(5,3)&player.buff(Icefury)&{player.maelstrom>=20||player.buff(Icefury).duration<{1.5*{spell_haste}*player.buff(Icefury).stack}}'},
	{'Frost Shock', 'xmoving=1&player.buff(Icefury)'},
	{'Earth Shock', 'player.maelstrom>=86'},
	{'Icefury', 'talent(5,3)&player.maelstrom<=70&{{talent(7,1)&spell(Ascendance).cooldown>player.buff(Icefury).duration}||!talent(7,1)}'},
	--{'Liquid Magma Totem', '...'},
	{'Stormkeeper', '{talent(7,1)&spell(Ascendance).cooldown>10}||!talent(7,1)'},
	--{'Totem Mastery', 'totem(Totem Mastery).duration<1||{!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Totem Mastery', 'totem(Totem Mastery).duration<1'},
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)&player.area(40).enemies>1'},
	{'Lightning Bolt', 'talent(7,2)&player.buff(Power of the Maelstrom)&!target.debuff(Lightning Rod)'},
	{'Lightning Bolt', '!talent(7,2)&player.buff(Power of the Maelstrom)'},
	{'Chain Lightning', 'talent(7,2)&player.area(40).enemies>1&!target.debuff(Lightning Rod)'},
	{'Chain Lightning', '!talent(7,2)&player.area(40).enemies>1'},
	{'Lightning Bolt', '!talent(7,2)&!target.debuff(Lightning Rod)'},
	{'Lightning Bolt', 'talent(7,2)'},
	{'Flame Shock', 'xmoving=1&target.debuff(Flame Shock).duration<gcd'},
	{'Earth Shock', 'xmoving=1'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'},
}

local inCombat = {
	{_Zylla},
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=30'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, 'toggle(aoe)&player.area(40).enemies>2'},
	{ST, 'target.range<40&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(262, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Shaman - Elemental',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
