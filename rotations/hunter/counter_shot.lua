local _, Zylla = ...

local GUI = {

}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHunter |cffADFF2FInterrups, keybinds, and heals ONLY! |r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
-- Some non-SiMC stuffs
	{'@Zylla.Targeting()', {'!target.alive&UI(kAutoTarget)'}},

}

local Survival = {
	{'Exhilaration', 'player.health<66'},
	{'#Ancient Healing Potion', 'player.health<42'},
	{'#Healthstone', 'player.health<38'},
	{'Aspect of the Turtle', 'player.health<22'},
}

local Interrupts = {
	{'Counter Shot'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)'},
	{'Binding Shot', 'keybind(lalt)', 'mouseover.ground'},
	{'Tar Trap', 'keybind(lcontrol)', 'mouseover.ground'},
	{'Freezing Trap', 'keybind(ralt)', 'mouseover.ground'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<=50'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(3, {
	name = '[|cff'..Zylla.addonColor..'Zylla|r] Hunter - Interrupts, heals, keybinds',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
