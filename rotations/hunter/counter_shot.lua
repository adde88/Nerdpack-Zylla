local _, Zylla = ...

local GUI = {

}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHUNTER |cffADFF2FInterrups, keybinds, and heals ONLY! |r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
-- Some non-SiMC stuffs
	{'@Zylla.Targeting()', {'!target.alive&toggle(AutoTarget)'}},

}

local Survival = {
	{'Exhilaration', 'player.health<66'},
	{'#127834', 'player.health<42'},
	{'#5512', 'player.health<38'},
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
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=50'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(3, {
	name = '[|cff'..Zylla.addonColor..'ZYLLA|r] HUNTER - Interrupts, heals, keybinds',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
