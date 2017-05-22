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
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FDemonology |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "target.dead||!target.exists" },
}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	{'Summon Felguard', '!pet.exists&!talent(6,1)'},
	{'Summon Infernal', '!pet.exists&talent(6,1)&artifact(Lord of Flames).rank>0'},
	{'Summon Infernal', '!pet.exists&talent(6,1)&player.area(30).enemies>=3'},
	{'Summon Doomguard', '!pet.exists&talent(6,1)&player.area(30).enemies<3&artifact(Lord of Flames).rank=0'},
	{'Demonic Empowerment', '!prev_gcd(Demonic Empowerment)&pet.exists&warlock.empower<action(Demonic Empowerment).cast_time+gcd'},
}

local xCombat = {
	--# Executed every time the actor is available.
	{'Implosion', 'talent(2,3)&{warlock(Wild Imp).remaining_duration<=action(Shadow Bolt).execute_time&player.buff(Demonic Synergy).remains}'},
	{'Implosion', 'talent(2,3)&{prev_gcd(Hand of Gul\'dan)&warlock(Wild Imp).remaining_duration<=3&player.buff(Demonic Synergy).remains}'},
	{'Implosion', 'talent(2,3)&{warlock(Wild Imp).count<=4&warlock(Wild Imp).remaining_duration<=action(Shadow Bolt).execute_time&target.area(8).enemies>1}'},
	{'Implosion', 'talent(2,3)&{prev_gcd(Hand of Gul\'dan)&warlock(Wild Imp).remaining_duration<=4&target.area(8).enemies>2}'},
	{'Shadowflame', 'talent(2,1)&{target.debuff(Shadowflame)stack>0&target.debuff(Shadowflame)remains<action(Shadow Bolt).cast_time+travel_time(Shadow Flame)}'},
	{'Grimoire: Felguard', 'talent(6,2)&{cooldown(Summon Doomguard).remains<=gcd&soul_shard>=2}'},
	{'Grimoire: Felguard', 'talent(6,2)&{cooldown(Summon Doomguard).remains>25}'},
	{'Summon Doomguard', 'talent(6,2)&{prev(Grimoire: Felguard)&target.area(10).enemies<3}'},
	{'Summon Doomguard', 'talent(6,3)&target.area(10).enemies<3'},
	{'Summon Infernal', 'talent(6,2)&{prev(Grimoire: Felguard)&target.area(10).enemies>=3}'},
	{'Summon Infernal', 'talent(6,3)&target.area(10).enemies>=3'},
	{'Call Dreadstalkers', '!talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}'},
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&soul_shard>=4&!talent(7,1)'},
	{'Summon Darkglare', 'talent(7,1)&{prev_gcd(Hand of Gul\'dan)}'},
	{'Summon Darkglare', 'talent(7,1)&{Call Dreadstalkers}'},
	{'Summon Darkglare', 'talent(7,1)&{cooldown(Call Dreadstalkers).remains>5&soul_shard<3}'},
	{'Summon Darkglare', 'talent(7,1)&{cooldown(Call Dreadstalkers).remains<=action(Summon Darkglare).cast_time&soul_shard>=3}'},
	{'Summon Darkglare', 'talent(7,1)&{cooldown(Call Dreadstalkers).remains<=action(Summon Darkglare).cast_time&soul_shard>=1&player.buff(Demonic Calling)}'},
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&cooldown(Summon Darkglare).remains>2'},
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&prev_gcd(Summon Darkglare)'},
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&cooldown(Summon Darkglare).remains<=action(Call Dreadstalkers.cast_time)&soul_shard>=3'},
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&cooldown(Summon Darkglare).remains<=action(Call Dreadstalkers.cast_time)&soul_shard>=1&player.buff(Demonic Calling)'},
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&soul_shard>=3&prev_gcd(Call Dreadstalkers)'},
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&talent(7,1)&{soul_shard>=5&cooldown(Summon Darkglare).remains<=action(Hand of Gul\'dan).cast_time}'},
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&talent(7,1)&{soul_shard>=4&cooldown(Summon Darkglare).remains>2}'},
	{'Demonic Empowerment', '!prev_gcd(Demonic Empowerment)&warlock.empower<action(Demonic Empowerment).cast_time+gcd'},
	{'Command Demon', 'pet_range<8'},
	{'Doom', '!talent(4,1)&target.time_to_die>target.dot(Doom).duration&{!target.dot(Doom).ticking||target.dot(Doom).remains<target.dot(Doom).duration*0.3}'},
	{'Shadowflame', 'action(Shadowflame).charges=2'},
	{'Thal\'kiel\'s Consumption', '{warlock(Dreadstalkers).remaining_duration>action(Thal\'kiel\'s Consumption).execute_time||talent(2,3)&target.area(8).enemies=>3}&warlock(Wild Imp).count>3&warlock(Wild Imp).remaining_duration>action(Thal\'kiel\'s Consumption).execute_time'},
	{'Life Tap', 'mana.pct<=30'},
	{'Demonwrath', 'xmoving=0&target.area(10).enemies>=3'},
	{'Demonwrath', 'xmoving=1'},
	{'Demonbolt', 'talent(7,2)'},
	{'Shadow Bolt', '!talent(7,2)'},
	{'Life Tap', 'mana.pct<=50'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'Arcane Torrent', 'target.range<=8'},
}

local Survival = {

}

local Cooldowns = {
	{'Berserking'},
	{'Blood Fury'},
	{'Soul Harvest', 'talent(4,3)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<40'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(Cooldowns)'},
	{xCombat, {'target.range<40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(266, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Demonology',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
