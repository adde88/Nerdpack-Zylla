local _, Zylla = ...
local unpack = _G.unpack
local NeP = Zylla.NeP
local Mythic_Plus = _G.Zylla.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'|r',						align = 'left', 			key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'Pause|r',					align = 'left', 			key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 			key = 'ralt', 		default = true},
	{type = 'checkbox', size = 10, text = Zylla.ClassColor..'Summon Pets                                  Select Pet: |r',		align = 'right', 	key = 'epets', 		default = true},
	{type = 'combo',		default = '1',																						key = 'pets', 				list = Zylla.wpets, 	width = 50},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type = 'header', 	size = 16, text = 'Targetting:',													align = 'center'},
	{type = 'combo',		default = 'normal',																				key = 'target', 					list = Zylla.faketarget, 	width = 75},
	{type = 'spacer'},
	{type = 'text', 		text = Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type = 'spacer'},		{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'spinner',	size = 11, text = 'Interrupt at percentage:', 						key = 'intat',				default = 60,	step = 5, shiftStep = 10,	max = 100, min = 1},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 				default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',	key = 'prepot', 			default = false},
	{type = 'combo',		default = '1',																						key = 'list', 				list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',						spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkspin',text = 'Agony', 																					key = 'agony_u', 			align = 'left', check = true, width = 55, step = 1, shiftStep = 2, spin = 10, max = 20},
	{type = 'checkspin',text = 'Corruption', 																			key = 'corr_u', 			align = 'left', check = true, width = 55, step = 1, shiftStep = 2, spin = 5, max = 20, desc = Zylla.ClassColor..'Amount of enemies to use Agony and Corruption on.|r'},
	{type = 'spacer'},
	{type = 'checkspin',text = 'Soul Harvest - Agony (Units)', 										key = 'SH_units', 		align = 'left', check = true, width = 55, step = 1, spin = 3, max = 20},
	{type = 'spacer'},
	{type = 'spinner', 	text = 'Reap Souls - Agony (Stacks)', 										key = 'rs', 					align = 'left', width = 55, step = 1, default = 5, max = 20},
	{type = 'spinner', 	text = 'Reap Souls - Tormented Souls (Stacks)', 					key = 'rs_ts',				align = 'left', width = 55, step = 1, default = 5, max = 20},
	{type = 'spacer'},
	{type = 'text', 		text = 'Grimoire of Supremacy/Sacrifice', 								align = 'center'},
	{type = 'checkbox', text = 'Use Infernal as Pet', 														key = 'kINF',					default = false},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',	default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', default = false,	desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'spacer'},
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', 					key = 'kj', 			align = 'left', width = 55, step = 1, shiftStep = 2, spin = 4, max = 20, min = 0, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type = 'spacer'}, 	{type = 'ruler'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival', 														align = 'center'},
	{type = 'checkspin',text = 'Gift of the Naaru',																key = 'gotn',  				align = 'left', width = 55, step = 5, shiftStep = 10, max = 20, min = 1, spin = 45, check = true},
	{type = 'checkbox', text = 'Soulstone on yourself', 													key = 'ss',						default = true},
	{type = 'checkbox', text = 'Fear to Interrupt', 															key = 'fear',					default = false},
	{type = 'checkspin',text = 'Unending Resolve', 																check= true, 					key = 'UR',		spin = 40},
	{type = 'checkspin',text = 'Cauterize Master', 																check= true, 					key = 'CM',		spin = 65},
	{type = 'checkspin',text = 'Healthstone',																			check= true, 					key = 'HS', 	spin = 45},
	{type = 'checkspin',text = 'Ancient Healing Potion', 													check = true, 				key = 'AHP',	spin = 40},
	{type = 'spinner', 	text = 'Life Tap above HP%', 															key = 'lt',						default = 70},
	{type = 'spacer'},
	{type = 'header', 	text = 'Health Funnel - Health Settings', 								align = 'center'},
	{type = 'spinner',	text = 'PET is <= HP%', 																	key = 'hf_pethp', 		default = 30},
	{type = 'spinner',	text = 'PLAYER >= HP%', 																	key = 'hf_pethp2', 		default = 40},
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

local PreCombat = {
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<5'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<5'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<5'}, 	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127847', 'item(127847).usable&item(127847).count>0&UI(prepot)&!buff(Flask of the Whispered Pact)'},	--XXX:  Flask of the Whispered Pact
	{'#153023', 'item(153023).usable&item(153023).count>0&UI(prepot)&!buff(Defiled Augmentation)'},					--XXX: Lightforged Augment Rune
}

local Pets = {
	{'Summon Felhunter', 'UI(pets)==1&{!pet.exists||pet.dead}'},
	{'Summon Doomguard', 'UI(pets)==2&{!pet.exists||pet.dead}'},
	{'Summon Infernal', 'UI(pets)==3&{!pet.exists||pet.dead}'},
	{'Summon Felguard', 'UI(pets)==4&{!pet.exists||pet.dead}'},
	{'Summon Succubus', 'UI(pets)==5&{!pet.exists||pet.dead}'},
	{'Summon Imp', 'UI(pets)==6&{!pet.exists||pet.dead}'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lalt)&UI(lalt)'},
}

local Interrupts = {
	{'!Fear', '!player.moving&interruptAt(5)&UI(fear)'},
	{'!Howl of Terror', 'range<=10', 'target.ground'},
	{'!Howl of Terror', 'toggle(xIntRandom)&range<=10', 'enemies.ground'},
	{'!Mortal Coil', 'range<21'}
}

local Survival = {
	{'Unending Resolve', 'health<=UI(UR_spin)&UI(UR_check)'},
	{'Health Funnel', 'alive&health<=UI(hf_pethp)&player.health>=UI(hf_pethp2)', 'pet'},
	{'&Gift of the Naaru', 'UI(gotn_check)&health<=UI(gotn_spin)'},
	{'&119899', 'pet.exists&player.health<=UI(CM_spin)&UI(CM_check)'},																										--XXX: Cauterize Master
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'}, 																	--XXX: Health Stone
}

local Cooldowns = {
	{'Summon Infernal', '!player.moving&toggle(aoe)&UI(epets)&!talent(6,1)&target.area(10).enemies>2'},
	{'Summon Doomguard', '!player.moving&UI(epets)&!talent(6,1)&target.area(10).enemies<3'},
	{'Soul Harvest', '{count(Agony).enemies.debuffs>UI(SH_units)}||{area(20).enemies==1&target.debuff(Agony).count==15}', 'target'},
	{'Grimoire: Felhunter', 'talent(6,2)'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}, 		--XXX: Argus World Spell
	{'&#144259', 'UI(kj_check)&range<=40&area(10).enemies>=UI(kj_spin)&equipped(144259)'}, 							--XXX: Kil'jaeden's Burning Wish (Legendary)
}

local AOE = {
	{'Phantom Singularity', '!player.moving&ttd>4'},
	{'Seed of Corruption', 'player.soulshards>=1&!player.moving&ttd>4'},
}

local AutoDots = {
	{'!Agony', 'UI(agony_u_check)&count.enemies.debuffs<UI(agony_u_spin)&debuff.duration<5.4'},
	{'!Corruption', 'UI(corr_u_check)&!talent(2,2)&count.enemies.debuffs<UI(corr_u_spin)&debuff.duration<=4.2'},
	{'!Corruption', 'UI(corr_u_check)&talent(2,2)&count.enemies.debuffs<UI(corr_u_spin)&!debuff'},
	{'!Siphon Life', 'count(Agony).enemies.debuffs>0&count(Corruption).enemies.debuffs>0&ttd>5'},
}

local ST = {
	{'Life Tap', 'player.mana<30&player.health>=UI(lt_spin)&UI(lt_check)', 'player'},
	{'!Unstable Affliction', '!player.moving&player.soulshards>=4'},
	{'!Unstable Affliction', '!player.moving&talent(1,2)&debuff.count=1&debuff.duration<=2.0'},
	{'!Unstable Affliction', '!player.moving&talent(1,2)&!debuff'},
	{'Reap Souls', 'buff(Tormented Souls).count>=UI(rs_ts)&target.debuff(Unstable Affliction}', 'player'},
  {'!Corruption', '!talent(2,2)&debuff.duration<=4.2'},
	{'!Corruption', 'talent(2,2)&!debuff'},
	{'!Agony', 'UI(agony_u_check)&debuff.count<UI(agony_u_spin)&debuff.duration<=5.4'},
	{'!Siphon Life', 'ctalent(7,2)&debuff.duration<=4.5&ttd>9&debuff(Agony)&debuff(Corruption)'},
	--{'Unstable Affliction', '!player.moving&debuff.count<4&player.soulshards<=3'},  *add malefic grasp support
	{'!Drain Soul', '!player.moving&debuff(Agony)&debuff(Corruption)&debuff(Unstable Affliction)'},
	--{'Drain Soul', '!player.moving&debuff(Haunt)&debuff(Unstable Affliction).count>=3'},  *add haunt support
}

local xCombat = {
	{Cooldowns, 'toggle(cooldowns)'},
	{Interrupts, 'toggle(Interrupts)&@Zylla.InterruptAt(intat)&inFront&range<=40'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&@Zylla.InterruptAt(intat)&inFront&range<=40', 'enemies'},
	{AOE, 'keybind(lshift)&UI(lshift)'},
	{AutoDots, 'combat&alive&range<=40', 'enemies'},
	{ST},
}

local inCombat = {
	{Survival, nil, 'player'},
	{Pets, 'UI(epets)'},
	{Keybinds},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.Condition.Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
}

local outCombat = {
	{PreCombat, nil, 'player'},
	{Pets, 'UI(epets)'},
	{Keybinds},
	{'Create Healthstone', 'item(5512).count==0&!lastcast(Create Healthstone)', 'player'},
	{'Soulstone', 'UI(ss)&!buff', 'player'}
}

NeP.CR.Add(265, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Affliction (DEV)',
	ic =  {{inCombat, '!player.casting(Summon Succubus)&!player.casting(Summon Voidwalker)&!player.casting(Summon Felhunter)&!player.casting(Summon Imp)&!player.casting(Summon Infernal)&!player.casting(Summon Doomguard)&!player.casting(Unstable Affliction)&!player.casting(Seed of Corruption)'}},
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='690', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
