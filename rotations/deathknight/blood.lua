local _, Zylla = ...

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},
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

local _Zylla = {
    {"/targetenemy [dead][noharm]", "target.dead||!target.exists" },
}

local PreCombat = {

}

local Survival = {
	{'Death Strike', 'player.health<=80&player.buff(Dark Succor)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Death and Decay', 'keybind(lcontrol)', 'cursor.ground'},
}

local Interrupts = {
	{'Mind Freeze'},
	{'Arcane Torrent', 'target.range<=8&spell(Mind Freeze).cooldown>gcd&!prev_gcd(Mind Freeze)'},
}

local xCombat = {
	{'Marrowrend', 'player.buff(Bone Shield).duration<=3'},
	{'Blood Boil', '!target.debuff(Blood Plague)'},
	-- DnD here w/ crimson scourge proc
	{'Death and Decay', 'player.buff(Crimson Scourge)&talent(2,1)', 'target.ground'},
	{'Death Strike', 'player.runicpower>=75'},
	{'Marrowrend', 'player.buff(Bone Shield).count<=6'},
	-- DnD here 3 or more runes and using talent
	{'Heart Strike', 'player.runes>=3'},
	{'Consumption'},
	{'Blood Boil'},
}

local inCombat = {
	{_Zylla, 'UI(kAutoTarget)'},
	{Keybinds},
	{xCombat},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(250, {
	name = '[|cff'..Zylla.addonColor..'Zylla|r] Death-Knight - Blood',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
