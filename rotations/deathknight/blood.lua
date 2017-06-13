local _, Zylla = ...

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = false},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = false},
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDeath-Knight |cffADFF2FBlood |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	
end

local Util = {
	-- ETC.
	{'%pause' , 'player.debuff(200904)||player.debuff(Sapped Soul)'}, -- Vault of the Wardens, Sapped Soul
}

local PreCombat = {

}

local Survival = {
	{'Death Strike', 'player.health<=80&player.buff(Dark Succor)'},
	{'Icebound Fortitude', 'player.health<=25||player.incdmg(2.5)>player.health.max*0.50||player.state.stun'},
}

local Keybinds = {
	-- Pause       
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Death and Decay', 'keybind(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'Mind Freeze'},
	{'Asphyxiate', 'target.range<=20&cooldown(Mind Freeze).remains>gcd&!prev_gcd(Mind Freeze)'},
	{'Arcane Torrent', 'target.inMelee&cooldown(Mind Freeze).remains>gcd&!prev_gcd(Mind Freeze)'},
}

local xCombat = {
	{'Marrowrend', 'player.buff(Bone Shield).duration<=3&target.inFront&target.inMelee'},
	{'Blood Boil', '!target.debuff(Blood Plague)'},
	-- DnD here w/ crimson scourge proc
	{'Death and Decay', 'player.buff(Crimson Scourge)&talent(2,1)&target.range<=30', 'player.ground'},
	{'Death Strike', 'player.runicpower>=75&target.inFront&target.inMelee'},
	{'Marrowrend', 'player.buff(Bone Shield).count<=6&target.inFront&target.inMelee'},
	-- DnD here 3 or more runes and usiwwwwng talent
	{'Heart Strike', 'player.runes>=3&target.inFront&target.inMelee'},
	{'Consumption', 'target.inFront&target.inMelee'},
	{'Blood Boil'}, 
}

local inCombat = {
	{Util},
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival},
	{xCombat},
}

local outCombat = {
	{PreCombat},
	{Keybinds},
}

NeP.CR:Add(250, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death-Knight - Blood',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
