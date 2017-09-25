local _, Zylla = ...

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings', 																	align = 'center'},
	{type = 'checkbox', text = 'Handle Pets (Imp, Doomguard, Infernal)', 					key = 'pet',					default = true},
	{type = 'checkbox', text = 'Use Trinket #1 on Cooldown', 											key = 'trinket1',			default = false},
	{type = 'checkbox', text = 'Use Trinket #2 on Cooldown', 											key = 'trinket2',			default = false},
	{type = 'spinner', 	text = 'Agony - Units', 																	key = 'agony_u', 			align = 'left', width = 55, step = 1, default = 10, max = 20},
	{type = 'spinner', 	text = 'Corruption (Units)', 															key = 'corr_u', 			align = 'left', width = 55, step = 1, default = 5, max = 20},
	{type = 'spacer'},
	{type = 'spinner', 	text = 'Soul Harvest - Agony (Units)', 										key = 'SH_units', 		align = 'left', width = 55, step = 1, default = 3, max = 20},
	{type = 'spacer'},
	{type = 'spinner', 	text = 'Reap Souls - Agony (Stacks)', 										key = 'rs', 					align = 'left', width = 55, step = 1, default = 5, max = 20},
	{type = 'spinner', 	text = 'Reap Souls - Tormented Souls (Stacks)', 					key = 'rs_ts',				align = 'left', width = 55, step = 1, default = 5, max = 20},
	{type = 'spacer'},
	{type = 'text', 		text = 'Grimoire of Supremacy/Sacrifice', 								align = 'center'},
	{type = 'checkbox', text = 'Use Doomguard as Pet', 														key = 'kDG',					default = false},
	{type = 'checkbox', text = 'Use Infernal as Pet', 														key = 'kINF',					default = false},
	{type = 'spacer'}, 	{type = 'ruler'},
	-- Survival
	{type = 'header', 	text = 'Survival', 																				align = 'center'},
	{type = 'checkbox', text = 'Use Soulstone on yourself', 											key = 'ss',						default = true},
	{type = 'checkbox', text = 'Use Fear to Interrupt', 													key = 'fear',					default = false},
	{type = 'checkspin',text = 'Unending Resolve below HP%', 											check= true, 					key = 'UR',		spin = 40},
	{type = 'checkspin',text = 'Cauterize Master below HP%', 											check= true, 					key = 'CM',		spin = 65},
	{type = 'checkspin',text = 'Healthstone',																			check= true, 					key = 'HS', 	spin = 45},
	{type = 'checkspin',text = 'Ancient Healing Potion', 													check = true, 				key = 'AHP',	spin = 40},
	{type = 'spinner', 	text = 'Life Tap above HP%', 															key = 'lt',						default = 70},
	{type = 'spacer'},
	{type = 'header', 	text = 'Health Funnel', 																	align = 'center'},
	{type = 'spinner',	text = 'Health Funnel When PET is below HP%', 						key = 'hf_pethp', 		default = 30},
	{type = 'spinner',	text = 'Health Funnel When PLAYER is above HP%', 					key = 'hf_pethp2', 		default = 40},
	{type = 'spacer'},
	{type = 'spacer'}, {type = 'ruler'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local Pets = {
	{'Summon Felhunter', 'UI(pet)&!UI(kDG)&!UI(kINF)&!talent(6,1)&{!pet.exists||pet.dead}'},
	{'Summon Doomguard', 'UI(pet)&UI(kDG)&!UI(kINF)&talent(6,1)&{!pet.exists||pet.dead}'},
	{'Summon Infernal', 'UI(pet)&!UI(kDG)&UI(kINF)&talent(6,1)&{!pet.exists||pet.dead}'},
	{'Grimoire: Felhunter', 'talent(6,2)'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Interrupts = {
	{'!Fear', '!player.moving&interruptAt(5)&UI(fear)', 'target'},
	{'!Howl of Terror', 'interruptAt(70)&range<10', 'target.ground'},
	{'!Mortal Coil', 'interruptAt(70)&range<21', 'target'}
}

local Interrupts_Random = {
	{'!Fear', '!player.moving&interruptAt(5)&inFront&range<41&UI(fear)&combat&alive', 'enemies'},
	{'!Howl of Terror', 'interruptAt(70)&range<10&combat&alive', 'enemies'},
	{'!Mortal Coil', 'interruptAt(70)&inFront&range<21&UI(xIntRandom)&combat&alive', 'enemies'}
}

local Survival = {
	{'Unending Resolve', 'health<=UI(UR_spin)&UI(UR_check)', 'player'},
	{'Health Funnel', 'alive&health<=UI(hf_pethp)&player.health>=UI(hf_pethp2)', 'pet'},
	{'&119899', 'pet.exists&player.health<=UI(CM_spin)&UI(CM_check)'},																		-- Cauterize Master
	{'#127834', 'item(127834).usable&item(127834).count>0&player.health<UI(AHP_spin)&UI(AHP_check)'},     -- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<UI(HS_spin)&UI(HS_check)', 'player'}	  -- Health Stone
}

local Cooldowns = {
	{'Summon Infernal', '!player.moving&toggle(aoe)&UI(kPet)&!talent(6,1)&target.area(10).enemies>2'},
	{'Summon Doomguard', '!player.moving&UI(kPet)&!talent(6,1)&target.area(10).enemies<3'},
	{'Soul Harvest', '{count(Agony).enemies.debuffs>UI(SH_units)||target.area(20).enemies==1&target.debuff(Agony).count==15	}'},
	{'Grimoire: Felhunter', 'talent(6,2)'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'}
}

local Corruption = {
	{'!Corruption', 'range<41&combat&alive&count.enemies.debuffs<UI(corr_u)&debuff.duration<=4.2&!talent(2,2)', 'enemies'},
	{'!Corruption', 'range<41&combat&alive&count.enemies.debuffs<UI(corr_u)&!debuff&talent(2,2)', 'enemies'}
}

local xCombat = {
	{Pets},
	{Corruption},
	{'Life Tap', 'player.mana<30&player.health>=UI(lt)'},
	{'!Agony', 'range<41&combat&alive&count.enemies.debuffs<UI(agony_u)&debuff.duration<5.4', 'enemies'},
	{'Siphon Life', '!player.moving&debuff.duration<=4.5&ttd>9&count(Agony).enemies.debuffs>0&count(Corruption).enemies.debuffs>0', 'target'},
	{'Siphon Life', 'range<41&!player.moving&combat&alive&debuff.duration<=4.5&ttd>9&count(Agony).enemies.debuffs>0&count(Corruption).enemies.debuffs>0', 'enemies'},
	{'Unstable Affliction', 'range<41&!player.moving&combat&alive&{{debuff.count<2}||{debuff.count<4&player.soulshards<=3}||{debuff.count<4&count(Agony).enemies.debuffs>10}}', 'enemies'},
	{'Unstable Affliction', 'range<41&!player.moving&combat&alive&debuff(Haunt).duration>5&debuff.count<4', 'enemies'},
	{'!Drain Soul', 'range<41&!player.moving&combat&alive&{{debuff(Agony).duration<=5.4||debuff(Unstable Affliction).duration<=5||ttd<5}}', 'enemies'},
	{'Drain Soul', 'range<41&!player.moving&combat&alive&debuff(Haunt)&debuff(Unstable Affliction).count>=3', 'enemies'},
	{'Haunt', 'range<41&!player.moving&combat&alive&{ttd<=10||ttd>=45}', 'enemies'},
	{'Seed of Corruption', 'range<41&player.soulshards>=1&!player.moving&toggle(AoE)&area(8).enemies>2&ttd>8&combat&alive', 'enemies'},
	{'Siphon Life', 'count(Agony).enemies.debuffs>0&count(Corruption).enemies.debuffs>0&count(Unstable Affliction).enemies.debuffs>0', 'target'},
	{'Reap Souls', 'player.soulshards>=3&{player.buff(Tormented Souls).count>UI(rs_ts)&target.debuff(Agony).count>UI(rs)}', 'player'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<41'},
	{Interrupts_Random, 'toggle(Interrupts)&toggle(xIntRandom)'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Mythic_Plus, 'range<41'},
	{xCombat, 'range<41&inFront'},
	{Pets}
}

local outCombat = {
	{Pets},
	{Keybinds},
	{Interrupts, 'toggle(Interrupts)&target.inFront&target.range<41'},
	{Interrupts_Random, 'toggle(Interrupts)&toggle(xIntRandom)'},
	{'Create Healthstone', 'item(5512).count==0&!lastcast(Create Healthstone)'},
	{'Soulstone', 'UI(ss)&!buff', 'player'}
}

NeP.CR:Add(265, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Affliction',
	ic =  {{inCombat, '!player.casting(Summon Succubus)||!player.casting(Summon Voidwalker)||!player.casting(Summon Felhunter)||!player.casting(Summon Imp)||!player.casting(Summon Infernal)||!player.casting(Summon Doomguard)||!player.casting(Unstable Affliction)||!player.channeling(Drain Soul)'}},
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='690', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
