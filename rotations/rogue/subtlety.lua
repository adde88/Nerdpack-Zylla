local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	-- Keybinds
	{type = 'header', text = 'Keybinds',	 					 			align = 'center'},
	{type = 'text', 	 text = 'Left Shift: Pause',				align = 'left'},
	{type = 'text', 	 text = 'Left Ctrl: ',							align = 'left'},
	{type = 'text', 	 text = 'Left Alt: ',								align = 'left'},
	{type = 'text', 	 text = 'Right Alt: ',							align = 'left'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type='spinner', 	text = 'Crimson Vial Below (HP%)', key='E_HP', default = 60},
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival', align = 'center'},
	{type = 'checkspin',	text = 'Healthstone',												key = 'HS',						spin = 45, check = true},
	{type = 'checkspin',	text = 'Healing Potion',										key = 'AHP',					spin = 45, check = true},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	 print('|cffADFF2F ----------------------------------------------------------------------|r')
	 print('|cffADFF2F --- |rRogue |cffADFF2FSubtlety |r')
	 print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/X - 5/X - 6/1 - 7/1')
   print('|cffADFF2F ----------------------------------------------------------------------|r')
   print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	 NeP.Interface:AddToggle({
		 key='opener',
		 name='Opener',
		 text = 'If Enabled we will Open with Ambush when Stealthed. If not Cheap Shot will be used.',
		 icon='Interface\\Icons\\ability_rogue_ambush',
	 })

	NeP.Interface:AddToggle({
		key='xStealth',
		name='Auto Stealth',
		text = 'If Enabled we will automatically use Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
	})

	NeP.Interface:AddToggle({
		key='xPickPock',
		name='Pick Pocket',
		text = 'If Enabled we will automatically Pick Pocket enemies out of combat.',
		icon='Interface\\Icons\\inv_misc_bag_11',
	})

end

local PreCombat = {
	{'Shadowstrike', 'stealthed&target.range<25&target.inFront'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'!Kick'},
	{'!Cheap Shot', 'cooldown(Kick).remains>gcd&player.buff(Stealth)&target.inFront&target.inMelee'},
	{'!Kidney Shot', 'cooldown(Kick).remains>gcd&combo_points>0&target.inFront&target.inMelee'},
	{'!Blind', 'cooldown(Kick).remains>gcd&target.inFront&target.range<25&cooldown(Kidney Shot).remains>gcd'},
}

local Survival ={
	{'Crimson Vial', 'player.health<=UI(k_CVHP)'},
	{'#127834', 'item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 						--Health Stone
}

local Builders = {
	{'Shuriken Storm', 'player.area(10).enemies>1'},
	--{'Gloomblade'},
	{'Backstab'},
}

local Cooldowns ={
	{'Blood Fury', 'stealthed'},
	{'Berserking', 'stealthed'},
	{'Shadow Blades', '!stealthed||!player.buff(Shadowmeld)'},
	{'Goremaw\'s Bite', '!player.buff(Shadow Dance)&{{combo_points.deficit>={4-parser_bypass2}*2&energy.deficit>{50+talent(3,3).enabled*25-parser_bypass3}*15}||target.time_to_die<8}'},
	{'Marked for Death', 'target.time_to_die<combo_points.deficit||combo_points.deficit>4'},
}

local Finishers = {
	{'Enveloping Shadows', 'player.buff(Enveloping Shadows).remains<target.time_to_die&player.buff(Enveloping Shadows).remains<=combo_points*1.8'},
	{'Death from Above', 'player.area(8).enemies>5'},
	{'Nightblade', 'target.time_to_die>8&{{dot.refreshable(Nightblade){!artifact(Finality).enabled||player.buff(Finality: Nightblade)}}||target.dot(Nightblade).remains<target.dot(Nightblade).tick_time}'},
	{'Death from Above'},
	{'Eviscerate'},
}

local Stealth_Cooldowns = {
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>1.65'},
	{'Vanish', '!stealthed'},
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>1&combo_points<2'},
	{'Shadowmeld', 'player.energy>30-variable.ssw_er&energy.deficit>10'},
	{'Shadow Dance', '!stealthed&combo_points<2'},
}

local Stealthed = {
	{'Symbols of Death', '!player.buff(Shadowmeld)&{{player.buff(Symbols of Death).remains<target.time_to_die-4&player.buff(Symbols of Death).remains<=player.buff(Symbols of Death).duration*0.3}||{xequipped(137032)&energy.time_to_max<0.25}}'},
	{Finishers, 'combo_points>4'},
	{'Shuriken Storm', '!player.buff(Shadowmeld)&{{combo_points.deficit>2&player.area(10).enemies>1+talent(6,1).enabled+xequipped(137032)}||player.buff(The Dreadlord\'s Deceit).stack>19}'},
	{'Shadowstrike'},
}

local xCombat = {
	{Cooldowns, 'toggle(Cooldowns)'},
	--# Fully switch to the Stealthed Rotation {by doing so, it forces pooling if nothing is available}
	{Stealthed, 'stealthed||player.buff(Shadowmeld)'},
	{Finishers, 'combo_points>4||{combo_points>3&player.area(10).enemies>2&player.area(10).enemies<5}'},
	{Stealth_Cooldowns, 'combo_points.deficit>1+talent(6,1).enabled&{variable.ed_threshold||{cooldown(Shadowmeld).up&!cooldown(Vanish).up&cooldown(Shadow Dance).charges<2}||target.time_to_die<12||player.area(10).enemies>4}'},
	{Builders, 'variable.ed_threshold'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Survival, 'player.health<100'},
	{Fel_Explosives, 'inMelee'},
	{xCombat, 'target.inMelee&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat, '!toggle(xPickPock)'},
	{'Stealth', 'toggle(xStealth)&!player.buff&!player.buff(Vanish)&!nfly'},
	{'Pick Pocket', 'toggle(xPickPock)&enemy&alive&range<=10&player.buff(Stealth)' ,'enemies'},
}

NeP.CR:Add(261, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Subtlety',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
