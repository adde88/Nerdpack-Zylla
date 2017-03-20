local _, Zylla = ...

local GUI = {

}
local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |PRIEST |cffADFF2FHoly|r")
	print("|cffADFF2F --- |rRecommended Talents: Not ready yet.")
	print("|cffADFF2F --- |r")
	print("|cffADFF2F --- |rThis rotation does not work at the moment!|")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")

local _Zylla = {
	{'@Zylla.Targeting()', {'!target.alive&toggle(AutoTarget)'}},
}

local Keybinds = {

}


local Cooldowns = {

}


local inCombat = {

}

local outCombat = {

}

NeP.CR:Add(256, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] PRIEST - Holy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
