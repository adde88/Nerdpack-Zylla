local _, Zylla = ...
local GUI = {
}
local exeOnLoad = function()
	Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FGuardian |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
	-- some non-SiMC stuffs
	{'@Zylla.Targeting()', {'!target.alive&UI(kAutoTarget)'}},
}

local PreCombat = {

}

local Interrupts = {
	{'Skull Bash'},
	{'Typhoon', 'talent(4,3)&cooldown(Skull Bash).remains>gcd'},
	{'Mighty Bash', 'talent(4,1)&cooldown(Skull Bash).remains>gcd'},
}

local Survival = {
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<=75'},
	--{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
	{'Barkskin'},
	{'Bristling Fur', 'player.buff(Ironfur).remains<2&player.rage<40'},
	{'Mark of Ursol', '!player.buff(Mark of Ursol)&player.incdmg_magic(5)>1'},
	{'Ironfur', '!player.buff(Ironfur)||rage.deficit<25'},
	{'Frenzied Regeneration', '!player.buff(Frenzied Regeneration)&player.incdmg(6)/player.health.max>{0.25+{2-cooldown(Frenzied Regeneration).charges}*0.15}'},
}

local Cooldowns = {
	{'Bloodfury'},
	{'Berserking'},
}

local xCombat = {
	{'Moonfire', 'player.buff(Galactic Guardian)&rage.deficit>=20'},
	{'Pulverize', 'talent(7,3)&!player.buff(Pulverize)'},
	{'Mangle'},
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<gcd'},
	{'Lunar Beam'},
	{'Incarnation: Guardian of Ursoc'},
	{'Thrash', 'player.area(8).enemies>=2'},
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
	{'Thrash', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
	{'Moonfire', '!target.dot(Moonfire).ticking||target.dot(Moonfire).remains<=gcd'},
	{'&Maul', 'rage.deficit<=20'},
	{'Swipe'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Bear Form', 'form~=1'},
	{xCombat, 'target.range<8&target.infront'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(104, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] DRUID - Guardian',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
