local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds',	 														align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',				align = 'left', 		key = 'lshift', 	default = true},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'lcontrol',	default = true},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'lalt', 		default = true},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r',							align = 'left', 		key = 'ralt', 		default = true},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 			width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Class Settings',												align = 'center'},
	{type = 'checkbox', text = 'Enable DBM Integration',													key = 'kDBM', 			default = true},
	{type = 'checkbox', text = 'Enable \'pre-potting\' and Flasks',								key = 'prepot', 		default = false},
	{type = 'combo',		default = '3',																						key = 'list', 			list = Zylla.prepots, 	width = 175},
	{type = 'spacer'},	{type = 'spacer'},
	{type = 'checkspin',text = 'Light\'s Judgment - Units', 											key = 'LJ',					spin = 4,	step = 1,	max = 20, min = 1,	check = true,	desc = Zylla.ClassColor..'World Spell usable on Argus.|r'},
	{type = 'checkbox', text = 'Use Trinket #1', 																	key = 'trinket1',		default = false},
	{type = 'checkbox', text = 'Use Trinket #2', 																	key = 'trinket2', 	default = false,		desc = Zylla.ClassColor..'Trinkets will be used whenever possible!|r'},
	{type = 'ruler'},	 	{type = 'spacer'},
	-- Survival
	{type = 'header', 	size = 16, text = 'Survival',															align = 'center'},
	{type = 'checkspin',text = 'Swiftmend', 																			key = 'swiftm', 		spin = 85, step = 5, max = 100, check = true},
	{type = 'checkspin',text = 'Survival Instincts', 															key = 'sint', 			spin = 50, step = 5, max = 100, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDruid |cffADFF2FFeral |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key='xStealth',
		name='Auto Stealth',
		text = 'If Enabled we will automatically use Stealth out of combat.',
		icon='Interface\\Icons\\ability_stealth',
	})

	NeP.Interface:AddToggle({
		key = 'xFORM',
		name = 'Handle Forms',
		text = 'Automatically handle player forms',
		icon = 'Interface\\Icons\\inv-mount_raven_54',
	})

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local PreCombat = {
	{'Travel Form', 'toggle(xFORM)&movingfor>0.75&!indoors&!buff&!buff(Prowl)', 'player'},
	{'!Regrowth', 'talent(7,2)&target.enemy&target.alive&!buff(Prowl)&!lastcast(Regrowth)&buff(Bloodtalons).stack<2', 'player'},
	{'Cat Form', 'toggle(xFORM)&movingfor>0.75&indoors&!buff&!buff(Travel Form)&!buff(Prowl)', 'player'},
	{'Prowl', 'toggle(xFORM)&toggle(xStealth)&!buff&{!buff(Travel Form)||{buff(Travel Form)&target.enemy&target.range<=25}}', 'player'},
	{'Rake', 'player.buff(Prowl)&inMelee&inFront&enemy&alive', 'target'},
	-- Pots
	{'#127844', 'UI(list)==1&item(127844).usable&item(127844).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of the Old War)&dbm(pull in)<3', 'player'}, 			--XXX: Potion of the Old War
	{'#127843', 'UI(list)==2&item(127843).usable&item(127843).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Deadly Grace)&dbm(pull in)<3', 'player'}, 		--XXX: Potion of Deadly Grace
	{'#142117', 'UI(list)==3&item(142117).usable&item(142117).count>0&UI(kDBM)&UI(prepot)&!buff(Potion of Prolonged Power)&dbm(pull in)<3', 'player'},	--XXX: Potion of Prolonged Power
	-- Flasks
	{'#127848', 'item(127848).usable&item(127848).count>0&UI(prepot)&!buff(Flask of the Seventh Demon)', 'player'},	--XXX: Flask of the Seventh Demon
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(lshift)'}
}

local Interrupts = {
	{'!Skull Bash', 'player.form~=0&range<14'},
	{'!Typhoon', 'interruptAt(60)&player.spell(Skull Bash).cooldown>gcd&range<16'},
	{'!Mighty Bash', 'inMelee&player.spell(Skull Bash).cooldown>gcd'}
}

local Bear_Healing = {
	{'Bear Form', 'form~=1', 'player'},
	{'Frenzied Regeneration', nil, 'player'}
}

local Survival = {
	{Bear_Healing, 'talent(3,2)&player.incdmg(5)>player.health.max*0.20&!player.buff(Frenzied Regeneration)'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'cooldown(Swiftmend).up.&form>0&talent(3,3)&player.health<=UI(swiftm_spin)&UI(swiftm_check)'},
	{'Swiftmend', 'talent(3,3)&health<=UI(swiftm_spin)&UI(swiftm_check)', 'player'},
	{'Survival Instincts', 'player.health<=UI(sint_spin)&UI(sint_check)', 'player'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 													-- Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)', 'player'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)', 'player'}, 																	-- Health Stone
}

local SBT_Opener = {
	--# Hard-cast a Regrowth for Bloodtalons buff. Use Dash to re-enter Cat Form.
	{'!Regrowth', 'talent(7,2)&combopoints==5&!buff(Bloodtalons)&!target.dot(Rip).ticking', 'player'},
	--# Force use of Tiger's Fury before applying Rip.
	{'Tiger\'s Fury', '!target.dot(Rip).ticking&combopoints==5', 'player'}
}

local Cooldowns = {
	{'Rake', 'player.buff(Prowl)||player.buff(Shadowmeld)', 'target'},
	{'Berserk', 'buff(Tiger\'s Fury)', 'player'},
	{'Incarnation: King of the Jungle', '{spell(Tiger\'s Fury).cooldown<gcd||{energy.time_to_max>1&energy>25}}', 'player'},
	{'Tiger\'s Fury', '{!buff(Clearcasting)&energy.deficit>50}||energy.deficit>70', 'player'},
	{'Ferocious Bite', 'player.combopoints>0&dot(Rip).ticking&dot(Rip)remains<3&ttd>3&{health<25||talent(6,1)}', 'target'},
	{'!Regrowth', 'talent(7,2)&buff(Predatory Swiftness)&{player.combopoints>4||buff(Predatory Swiftness).remains<1.5||{talent(7,2)&combopoints==2&!buff(Bloodtalons)&spell(Ashamane\'s Frenzy).cooldown<gcd}}', 'player'},
	{SBT_Opener, 'talent(6,1)&xtime<20'},
	{'!Regrowth', 'equipped(137024)&talent(7,2)&buff(Predatory Swiftness).stack>1&!buff(Bloodtalons)', 'player'},		--XXX: Special logic for Ailuro Pouncers legendary.
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
	{'Light\'s Judgment', 'UI(LJ_check)&range<61&area(15).enemies>=UI(LJ_spin)', 'enemies.ground'}
}

local Finisher = {
	{'Savage Roar', 'talent(6,3)&{!buff(Savage Roar)&{combopoints==5||talent(6,2)&action(Brutal Slash).charges>0}}', 'player'},
	{'Savage Roar', 'talent(6,3)&{{{buff(Savage Roar).duration<20.5&talent(5,3)}||{buff(Savage Roar).duration<8.2&!talent(5,3)}}&combopoints==5&{energy.time_to_max<1||buff(Berserk)||buff(Incarnation: King of the Jungle)||spell(Tiger\'s Fury).cooldown<3||buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5&area(8).enemies.inFront<6}}}', 'player'},
	{'Thrash', 'dot.remains<=dot.duration*0.3&player.area(8).enemies.inFront>4', 'target'},
	{'Swipe', 'player.combopoints==5&{player.area(8).enemies.inFront>5||{player.area(8).enemies.inFront>2&!talent(7,2)}}&player.combopoints==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(7,3)&player.buff(Clearcasting)}}', 'target'},
	{'Swipe', 'player.area(8).enemies.inFront>7', 'target'},
	{'Rip', '{!dot.ticking||{dot.remains<8&health>25&!talent(6,1)}||persistent_multiplier>dot.pmultiplier}&{dot.remains>dot.tick_time*4&player.combopoints==5}&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(6,2)&player.buff(Clearcasting)}||talent(5,1)||!dot.ticking||{dot(Rake).remains<1.5&player.area(8).enemies.inFront<6}}', 'target'},
	{'Ferocious Bite', '	player.combopoints==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(7,3)&player.buff(Clearcasting)}}', 'target'}
}

local Generator = {
	{'Brutal Slash', 'talent(6,2)&player.combopoints<5', 'target'},
	{'!Ashamane\'s Frenzy', 'player.combopoints<3&toggle(Cooldowns)&{player.buff(Bloodtalons)||!talent(7,2)}&{player.buff(Savage Roar)||!talent(5,3)}', 'target'},
	{'Elune\'s Guidance', 'talent(5,3)&{combopoints==0&energy<action(Ferocious Bite).cost+25-energy.regen*spell(Elune\'s Guidance).cooldown}', 'player'},
	{'Elune\'s Guidance', 'talent(5,3)&{combopoints==0&energy>=action(Ferocious Bite).cost+25}', 'player'},
	{'Thrash', 'talent(6,2)&player.area(8).enemies.inFront>8', 'target'},
	{'Thrash', 'dot.remains<=dot.duration*0.3&player.area(8).enemies.inFront>1', 'target'},
	{'Swipe', 'player.area(8).enemies.inFront>5', 'target'},
	{'Swipe', 'player.combopoints<5&player.area(8).enemies.inFront>2', 'target'},
	{'Rake', 'player.combopoints<5&{!dot.ticking||{!talent(7,2)&dot.remains<dot.duration*0.3}||{talent(7,2)&player.buff(Bloodtalons)&{!talent(5,1)&dot.remains<8||dot.remains<6}&persistent_multiplier>dot.pmultiplier*0.80}}&dot.remains>dot.tick_time', 'target'},
	{'Moonfire', 'talent(1,3)&player.combopoints<5&dot.remains<5.2&dot.remains>dot.tick_time*2', 'target'},
	{'Shred', 'player.combopoints<5&{player.area(8).enemies.inFront<3||talent(6,2)}', 'target'}
}

local xCombat = {
	{Finisher},
	{Generator}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'interruptAt(70)&toggle(Interrupts)&inFront', 'target'},
	{Interrupts, 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront', 'enemies'},
	{Survival, 'player.health<100'},
	{'Cat Form', '!buff(Frenzied Regeneration)&{!buff(Cat Form)&{!buff(Travel Form)||area(8).enemies.inFront>0}}', 'player'},
	{Cooldowns, '!player.buff(Frenzied Regeneration)&toggle(Cooldowns)'},
	{'Moonfire', 'talent(1,3)&!inMelee&range<41&inFront&!player.buff(Prowl)&!debuff', 'target'},
	{Mythic_Plus, 'inMelee&inFront'},
	{xCombat, '!player.buff(Frenzied Regeneration)&target.inMelee&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(103, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Feral',
	pooling = true,
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='760', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
