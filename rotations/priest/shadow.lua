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
	print('|cffADFF2F --- |rPRIEST |cffADFF2FShadow |r')
	print('|cffADFF2F --- |rRecommended Talents1: 1/1 - 2/2 - 3/1 - 4/2 - 5/3 - 6/3 - 7/3')
	print('|cffADFF2F --- |rRecommended Talents2: 1/1 - 2/2 - 3/1 - 4/2 - 5/2 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xS2M',
		name = 'S2M',
		text = 'ON/OFF using S2M in rotation',
		icon = 'Interface\\Icons\\Achievement_boss_generalvezax_01',
	})

end

local _Zylla = {
    {"/targetenemy [dead][noharm]", "target.dead||!target.exists" },
}


local PreCombat = {

}

local Void_Eruption = {
	{'!Void Eruption'},
}

local Mind_Blast = {
	{'Mind Blast'},
}

local Void_Eruption_Clip = {
	{'!Void Eruption'},
}

local Mind_Blast_Clip = {
	{'!Mind Blast'},
}

local MainRotation_Clip = {
	{'!Surrender to Madness', 'toggle(xS2M)&talent(7,3)&target.time_to_die<=variable.s2mcheck'},
	{'!Mindbender', 'toggle(Cooldowns)&talent(6,3)&!talent(7,3)'},
	{'!Mindbender', 'toggle(Cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck+60'},
	{'!Shadow Word: Pain', 'target.dot(Shadow Word: Pain).remains<{3+{4/3}}*gcd'},
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&target.dot(Vampiric Touch).remains<{4+{4/3}}*gcd'},
	{'!Void Eruption', '{talent(7,1)&player.insanity>=70}||player.insanity>=85||{talent(5,2)&player.insanity>={80-shadowy_apparitions_in_flight*4}}'},
	{'!Shadow Crash', 'talent(6,2)'},

	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&talent(7,1)&player.insanity>=70'},
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&talent(7,1)&player.insanity>=70'},
	{'!Shadow Word: Death', '!talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=90'},
	{'!Shadow Word: Death', 'talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=70'},
	{'!Mind Blast', 'talent(7,1)&{player.insanity<=81||{player.insanity<=75.2&talent(1,2)}}'},
	{'!Mind Blast', '!talent(7,1)||{player.insanity<=96||{player.insanity<=95.2&talent(1,2)}}'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
	{'!Shadow Word: Void', '{player.insanity<=70&talent(7,1)}||{player.insanity<=85&!talent(7,1)}'},
}

local MainRotation = {
	{MainRotation_Clip, 'player.channeling(Mind Sear)||player.channeling(Mind Flay)'},
	{'Surrender to Madness', 'toggle(xS2M)&talent(7,3)&target.time_to_die<=variable.s2mcheck'},
	{'Mindbender', 'toggle(Cooldowns)&talent(6,3)&!talent(7,3)'},
	{'Mindbender', 'toggle(Cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck+60'},
	{'Shadow Word: Pain', 'target.dot(Shadow Word: Pain).remains<{3+{4/3}}*gcd'},
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&target.dot(Vampiric Touch).remains<{4+{4/3}}*gcd'},
	{'!Void Eruption', '{talent(7,1)&player.insanity>=70}||player.insanity>=85||{talent(5,2)&player.insanity>={80-shadowy_apparitions_in_flight*4}}'},
	{'Shadow Crash', 'talent(6,2)'},

	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&talent(7,1)&player.insanity>=70'},
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&talent(7,1)&player.insanity>=70'},
	{'Shadow Word: Death', '!talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=90'},
	{'Shadow Word: Death', 'talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=70'},
	{'Mind Blast', 'talent(7,1)&{player.insanity<=81||{player.insanity<=75.2&talent(1,2)}}'},
	{'Mind Blast', '!talent(7,1)||{player.insanity<=96||{player.insanity<=95.2&talent(1,2)}}'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
	{'Shadow Word: Void', '{player.insanity<=70&talent(7,1)}||{player.insanity<=85&!talent(7,1)}'},
	{'Mind Sear', 'target.area(10).enemies>1', 'target'},
	{'Mind Flay', '!talent(7,2)', 'target'},
	{'Mind Spike', 'talent(7,2)'},
	{'Shadow Word: Pain'},
}

local S2M_Clip = {
	{'!Void Eruption'},
	{'!Shadow Crash', 'talent(6,2)'},
	{'!Mindbender', 'toggle(Cooldowns)&talent(6,3)'},
	{'!Void Torrent', 'target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5'},
	{'!Berserking', 'toggle(Cooldowns)&player.buff(Voidform).stack>=80'},
	{'!Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+15}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
	{'!Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+65}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
	{'!Void Eruption'},
	{'!Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
	{'!Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+90}<100'},
	{'!Power Infusion', 'toggle(Cooldowns)&insanity_drain_stacks>=77'},
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.28'},
	{'!Dispersion', 'current_insanity_drain*gcd_max>player.insanity&!player.buff(Power Infusion)'},
	{'!Mind Blast'},
	{Mind_Blast_Clip, 'action(Mind Blast).cooldown<gcd.max*0.28'},
	{'!Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
	{'!Shadowfiend', 'toggle(Cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
	{'!Shadow Word: Void', '{parser_bypass1+75}<100'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.8'},
}

local S2M = {
	{S2M_Clip, 'player.channeling(Mind Sear)||player.channeling(Mind Flay)'},
	{'!Void Eruption'},
	{'Shadow Crash', 'talent(6,2)'},
	{'Mindbender', 'toggle(Cooldowns)&talent(6,3)'},
	{'Void Torrent', 'target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5'},
	{'Berserking', 'toggle(Cooldowns)&player.buff(Voidform).stack>=80'},
	{'Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+15}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
	{'Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+65}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
	{'!Void Eruption'},
	{'Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
	{'Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+90}<100'},
	{'Power Infusion', 'toggle(Cooldowns)&insanity_drain_stacks>=77'},
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.28'},
	{'Dispersion', 'current_insanity_drain*gcd_max>player.insanity&!player.buff(Power Infusion)'},
	{'Mind Blast'},
	{Mind_Blast, 'action(Mind Blast).cooldown<gcd.max*0.28'},
	{'Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
	{'Shadowfiend', 'toggle(Cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
	{'Shadow Word: Void', '{parser_bypass1+75}<100'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.8'},
	{'Mind Sear', 'target.area(10).enemies>=3', 'target'},
	{'Mind Flay', '!talent(7,2)', 'target'},
	{'Mind Spike', 'talent(7,2)'},
}

local VF_Clip = {
	{'!Void Eruption'},
	{'!Surrender to Madness', 'toggle(xS2M)&talent(7,3)&player.insanity>=25&{cooldown(Void Eruption).up||cooldown(Void Torrent).up||cooldown(Shadow Word: Death).up||player.buff(Shadowy Insight)}&target.time_to_die<=variable.s2mcheck-insanity_drain_stacks'},
	{'!Shadow Crash', 'talent(6,2)'},
	{'!Void Torrent', 'toggle(Cooldowns)&target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	{'!Void Torrent', 'toggle(Cooldowns)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	{'!Void Torrent', 'toggle(Cooldowns)&!talent(7,3)'},
	{'!Mindbender', 'toggle(Cooldowns)&talent(6,3)&!talent(7,3)'},
	{'!Mindbender', 'toggle(Cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+30'},
	{'!Power Infusion', 'toggle(Cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=30&!talent(7,3)'},
	{'!Power Infusion', 'toggle(Cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+15'},
	{'!Berserking', 'toggle(Cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=20&!talent(7,3)'},
	{'!Berserking', 'toggle(Cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+70'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
	{'!Void Eruption'},
	{'!Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+10}<100'},
	{'!Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.28'},
	{'!Mind Blast'},
	{Mind_Blast_Clip, 'action(Mind Blast).cooldown<gcd.max*0.28'},
	{'!Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
	{'!Shadowfiend', 'toggle(Cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
	{'!Shadow Word: Void', '{parser_bypass1+25}<100'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.8'},
}

local VF = {
	{VF_Clip, 'player.channeling(Mind Sear)||player.channeling(Mind Flay)'},
	{'!Void Eruption'},
	{'Surrender to Madness', 'toggle(xS2M)&talent(7,3)&player.insanity>=25&{cooldown(Void Eruption).up||cooldown(Void Torrent).up||cooldown(Shadow Word: Death).up||player.buff(Shadowy Insight)}&target.time_to_die<=variable.s2mcheck-insanity_drain_stacks'},
	{'Shadow Crash', 'talent(6,2)'},
	{'Void Torrent', 'toggle(Cooldowns)&target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	{'Void Torrent', 'toggle(Cooldowns)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	{'Void Torrent', 'toggle(Cooldowns)&!talent(7,3)'},
	{'Mindbender', 'toggle(Cooldowns)&talent(6,3)&!talent(7,3)'},
	{'Mindbender', 'toggle(Cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+30'},
	{'Power Infusion', 'toggle(Cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=30&!talent(7,3)'},
	{'Power Infusion', 'toggle(Cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+15'},
	{'Berserking', 'toggle(Cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=20&!talent(7,3)'},
	{'Berserking', 'toggle(Cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+70'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
	{'!Void Eruption'},
	{'Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+10}<100'},
	{'Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.28'},
	{'Mind Blast'},
	{Mind_Blast, 'action(Mind Blast).cooldown<gcd.max*0.28'},
	{'Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
	{'Shadowfiend', 'toggle(Cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
	{'Shadow Word: Void', '{parser_bypass1+25}<100'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.8'},
	{'Mind Sear', 'target.area(10).enemies>1', 'target'},
	{'Mind Flay', '!talet(7,2)', 'target'},
	{'Mind Spike', 'talent(7,2)'},
	{'Shadow Word: Pain'},
}

local xCombat = {
	{'#Deadly Grace', 'player.buff(Bloodlust)||target.time_to_die<=40||player.buff(Voidform).stack>80'},
	{S2M, 'player.buff(Voidform)&player.buff(Surrender to Madness)'},
	{VF, 'player.buff(Voidform)'},
	{MainRotation},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'Silence'},
	{'Arcane Torrent', 'target.range<=8&spell(Silence).cooldown>gcd&!prev_gcd(Silence)'},
}

local Survival = { -- copy&pasta from MTS core :P
	--Healthstone at or below 20% health. Active when NOT channeling Void Torrent.
	{'#Healthstone', 'player.health<=20&!player.channeling(Void Torrent)'},
	--Ancient Healing Potion at or below 20% health. Active when NOT channeling Void Torrent.
	{'#Ancient Healing Potion', 'player.health<=20&!player.channeling(Void Torrent)'},
	--Gift of the Naaru at or below 40% health. Active when NOT channeling Void Torrent.
	{'Gift of the Naaru', 'player.health<=40&!player.channeling(Void Torrent)'},
	--Power Word: Shield at or below 40% health. Active when NOT in Surrender to Madness or channeling Void Torrent.
	{'Power Word: Shield', 'player.health<=40&!player.buff(Surrender to Madness)&!player.channeling(Void Torrent)'},
	--Dispersion at or below 15% health. Last attempt at survival.
	{'!Dispersion', 'player.health<=15'},
	--Power Word: Shield for Body and Soul to gain increased movement speed if moving. Active when NOT in Surrender to Madness or channeling Void Torrent.
	{'Power Word: Shield', 'talent(2,2)&player.moving&!player.buff(Surrender to Madness)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(Interrupts)&target.infront&target.range<40'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<40&target.infront&!player.channeling(Void Torrent)'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(258, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] PRIEST - Shadow',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
