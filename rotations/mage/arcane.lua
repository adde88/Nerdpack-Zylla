local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type='header',  	size=16, text='Keybinds',	 																					align='center'},
	{type='checkbox',	text='Left Shift: '..Zylla.ClassColor..'Pause|r',										align='left', 			key='lshift', 	default=true},
	{type='checkbox',	text='Left Ctrl: '..Zylla.ClassColor..'|r',													align='left', 			key='lcontrol',	default=true},
	{type='checkbox',	text='Left Alt: '..Zylla.ClassColor..'|r',													align='left', 			key='lalt', 		default=true},
	{type='checkbox',	text='Right Alt: '..Zylla.ClassColor..'|r',													align='left', 			key='ralt', 		default=true},
	{type='spacer'},
	{type='checkbox', text='Enable Chatoverlay', 																					key='chat', 				width=55, 			default=true, desc=Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type='spacer'},
	unpack(Zylla.PayPal_IMG),
	{type='spacer'},		{type='ruler'},	 	{type='spacer'},
	--TODO: Targetting: Use, or NOT use?! We'll see....
	{type='header', 	size=16, text='Targetting:',																				align='center'},
	{type='combo',		default='normal',																										key='target', 			list=Zylla.faketarget, 	width=75},
	{type='spacer'},
	{type='text', 		text=Zylla.ClassColor..'Only one can be enabled.\nChose between normal targetting, or hitting the highest/lowest enemy.|r'},
	{type='spacer'},		{type='ruler'},	 	{type='spacer'},
	-- Settings
	{type='header', 	size=16, text='Class Settings',																			align='center'},
	{type='spinner',	size=11, text='Interrupt at percentage:', 													key='intat',				align='left', default=60,	step=5, shiftStep=10,	max=100, min=1},
	{type = 'checkbox', text = 'Enable DBM Integration',																	key = 'kDBM', 			default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\', flasks and Legion-rune',					key = 'prepot', 		default = false},
	{type = 'combo',		default = '3',																										key = 'list', 			list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type='checkspin',text='Evocation (Mana % to use)', 																	key='evocation', 		align='left', width=55, step=5, shiftStep=10, spin=75, max=100, min=1, check=true},
	{type='checkbox', text='Use Trinket #1', 																							key='trinket1',			align='left', default=false},
	{type='checkbox', text='Use Trinket #2', 																							key='trinket2', 		align='left', default=false, desc=Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type='spacer'},
	{type='checkspin', 	text='Kil\'Jaeden\'s Burning Wish - Units', 											key='kj', 					align='left', width=55, step=1, shiftStep=2, spin==4, max=20, min=1, check=true, desc=Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'},
	{type='ruler'},	  {type='spacer'},
	-- Survival
	{type='header', 	size=16, text='Survival',																						align='center'},
	{type='checkspin',text='Ice Block', 																									key='ib', 					align='left', width=55, step=5, shiftStep=10, spin=75, max=100, min=1, check=true},
	{type='ruler'},	{type='spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad=function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMage |cffADFF2FArcane|r')
	print('|cffADFF2F --- |rRecommended Talents: In development....')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key='xIntRandom',
		name='Interrupt Anyone',
		text='Interrupt all nearby enemies, without targeting them.',
		icon='Interface\\Icons\\inv_ammo_arrow_04',
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

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
}

local Survival = {
	{'Ice Block', 'UI(ib_check)&health<=UI(ib_spin)'},
}

local Cooldowns = {
	{'Rune of Power', 'talent(3,2)&arcanecharges==4&mana>45&!buff(Arcane Power)&spell.charges>1.5', 'player'},
	{'Arcane Power', 'buff(Rune of Power)&spell(Evocation).cooldown<=15', 'player'},
}

local Interrupts = {
	{'Counterspell'},
}

local Kilt = {
	{'Arcane Missiles', 'player.buff(Arcane Missiles!).stack==3'},
	('Mark of Aluneth'),
	{'Charged Up', 'player.arcanecharges<4'},
	{'Rune of Power', 'talent(3,2)&player.arcanecharges==4&player.mana>45&{!player.buff(Arcane Power)||player.buff(Arcane Power).remains<1}'},
	{'Nether Tempest', '{!target.debuff(Nether Tempest)||target.debuff(Nether Tempest).remains<2}&!player.buff(Arcane Power)'},
	{'Arcane Power', 'player.buff(Rune of Power)&spell(Evocation).cooldown<=15'},
	{'Arcane Missiles', 'player.buff(Arcane Missiles!).stack>=1&player.mana>=15'},
	{'Arcane Blast'},
}

local Burn = {
	{Cooldowns, 'toggle(Cooldowns)'},
	{'Arcane Missiles', 'player.buff(Arcane Missiles!).stack==3'},
	{'Arcane Explosion', 'talent(7,2)&player.buff(Quickening).remains<spell(Arcane Blast).casttime&toggle(AoE)'},
	{'Presence of Mind', 'talent(1,2)&player.buff(Arcane Power).remains<2'},
	{'Nether Tempest', '{!target.debuff(Nether Tempest)||target.debuff(Nether Tempest).remains<2}&!player.buff(Arcane Power)'},
	{'Arcane Missiles', 'player.buff(Arcane Missiles!).stack>=1'},
	{'Arcane Explosion', 'player.area(8).enemies>1&player.buff(Arcane Power).remains>1&toggle(AoE)'},
	{'Arcane Blast', 'player.buff(Presence of Mind)||player.buff(Arcane Power).remains>1'},
	{'Supernova', 'player.mana<100'},
	{'Arcane Missiles', 'player.mana>10&{talent(7,1)||!player.buff(Arcane Power)}'},
	{'Arcane Explosion', 'player.area(8).enemies>1&toggle(AoE)'},
	{'Arcane Blast'},
}

local RuneOfPower = {
	{'Arcane Missiles', 'player.buff(Arcane Missiles!).stack==3'},
	{'Arcane Explosion', 'talent(7,2)&player.buff(Quickening).remains<spell(Arcane Blast).casttime&toggle(AoE)'},
	{'Nether Tempest', '!target.debuff(Nether Tempest)||target.debuff(Nether Tempest).remains<2'},
	{'Arcane Missiles', 'player.arcanecharges==4'},
	{'Arcane Explosion', 'player.area(8).enemies>1&toggle(AoE)'},
	{'Arcane Blast', 'player.mana>45'},
	{'Arcane Barrage'},
}

local Conserve = {
	{'Mark of Aluneth'},
	{'Rune of Power', 'spell(Rune of Power).charges=2'},
	{'Arcane Missiles', 'player.buff(Arcane Missiles!).stack==3'},
	{'Arcane Orb', 'talent(7,3)&player.arcanecharges<1&target.infront'},
	{'Nether Tempest', '!target.debuff(Nether Tempest)||target.debuff(Nether Tempest).remains<4&player.arcanecharges==4'},
	{'Arcane Explosion', 'talent(7,2)&player.buff(Quickening).remains<spell(Arcane Blast).casttime&toggle(AoE)'},
	{'Arcane Blast', 'player.mana>99'},
	{'Arcane Missiles', 'player.buff(Arcane Missiles!).stack>=1&player.arcanecharges==4'},
	{'Supernova', 'talent(4,1)&player.mana<100'},
	{'Arcane Blast', 'equipped(132413)&player.buff(Rhonin\'s Assaulting Armwraps'}, --XXX: Legendary Wrists
	{'Frostnova', 'equipped(132452)&player.area(12).enemies>=1'}, --XXX: Sephuz's Secret
	{'Arcane Explosion', 'equipped(132451)&player.mana>=82&player.area(8).enemies>1&toggle(AoE)'}, --XXX: Legendary Legs
	{'Arcane Blast', 'equipped(132451)&player.mana>=82'}, --XXX: Legendary Legs
	{'Arcane Barrage', 'player.mana<90'},
	{'Arcane Explosion', 'player.area(8).enemies>3&toggle(AoE)'},
	{'Arcane Blast'},
}

local xCombat=  {
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&inFront&range<==40'},
	{Interrupts, '@Zylla.InterruptAt(intat)&toggle(Interrupts)&toggle(xIntRandom)&inFront&range<==40', 'enemies'},
	--{Kilt, 'equipped(132451)&player.mana>15'},  --TODO: Check into this later.
	{Burn, 'player.buff(Arcane Power)||{spell(Evocation).cooldown<15&spell(Evocation).cooldown>1&player.mana>20}||!spell(Evocation).cooldown'},
	{RuneOfPower, 'player.buff(Rune of Power)&!player.buff(Arcane Power)'},
	{Conserve, '{spell(Evocation).cooldown>=15&!player.buff(Arcane Power)}||{spell(Evocation).cooldown>=15&player.mana<20'},
}

local inCombat = {
	{Keybinds},
	{'Evocation', 'UI(evocation_check)&mana<=UI(evocation_spin)', 'player'},
	{'Arcane Familiar', '!buff', 'player'},
	{Survival, nil, 'player'},
	{xCombat, 'combat&alive&range<41&inFront', (function() return NeP.DSL:Get("UI")(nil, 'target') end)}, --TODO: TEST! ALOT MORE TESTING!
	{Mythic_Plus, 'range<=40'}
}

local outCombat = {
	{PreCombat, nil, 'player'},
	{Keybinds},
	{'Arcane Familiar', 'talent(1,1)&!player.buff(Arcane Familiar)'},
}

NeP.CR:Add(62, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Mage - Arcane',
	--pooling = true,
	ic=inCombat,
	ooc=outCombat,
	gui=GUI,
	gui_st=Zylla.GuiSettings,
	ids=Zylla.SpellIDs[Zylla.Class],
	wow_ver=Zylla.wow_ver,
	nep_ver=Zylla.nep_ver,
	load=exeOnLoad
})
