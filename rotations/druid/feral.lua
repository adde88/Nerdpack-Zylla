local _, Zylla = ...

local GUI = {
	--Logo
	{type = 'texture',texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = 42, center = true},
	{type = 'ruler'},	{type = 'spacer'},
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',				align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',					key = 'kPause', 		default = true},
	{type = 'checkbox', text = 'Use Trinket #1', 				key = 'trinket1',		default = true},
	{type = 'checkbox', text = 'Use Trinket #2', 				key = 'trinket2', 	default = true},
	{type = 'ruler'},	 {type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',						align = 'center'},
	{type = 'checkspin',text = 'Swiftmend below HP%', key = 'swiftm', 		spin = 85, step = 5, max = 100, check = true},
	{type = 'ruler'},		{type = 'spacer'},
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
	{'Travel Form', 'toggle(xFORM)&movingfor>0.75&!indoors&!buff(Travel Form)&!buff(Prowl)', 'player'},
	{'!Regrowth', 'talent(7,2)&target.enemy&target.alive&!buff(Prowl)&!lastcast(Regrowth)&buff(Bloodtalons).stack<2', 'player'},
	{'Cat Form', 'toggle(xFORM)&player.movingfor>1&indoors&!player.buff(Cat Form)&!player.buff(Travel Form)&!player.buff(Prowl)', 'player'},
	{'Prowl', 'toggle(xFORM)&!buff&target.enemy&target.alive&target.range<21', 'player'},
	{'Rake', 'player.buff(Prowl)&range<=5&inFront', 'target'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'}
}

local Interrupts = {
	{'!Skull Bash', 'player.form>0&range<14&inFront', 'target'},
	{'!Typhoon', 'talent(4,3)&player.spell(Skull Bash).cooldown>gcd&range<16&inFront', 'target'},
	{'!Mighty Bash', 'player.spell(Skull Bash).cooldown>gcd&range<=5&inFront', 'target'}
}

local Interrupts_Random = {
	{'!Skull Bash', 'interruptAt(70)&player.form>0&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<14', 'enemies'},
	{'!Typhoon', 'interruptAt(60)&toggle(xIntRandom)&toggle(Interrupts)&player.area(15).enemies.inFront>=1&player.spell(Skull Bash).cooldown>gcd', 'enemies'},
	{'!Mighty Bash', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inMelee&inFront&player.spell(Skull Bash).cooldown>gcd', 'enemies'}
}

local Bear_Healing = {
	{'Bear Form', 'form~=1', 'player'},
	{'Frenzied Regeneration', nil, 'player'}
}

local SBT_Opener = {
	--# Hard-cast a Regrowth for Bloodtalons buff. Use Dash to re-enter Cat Form.
	{'!Regrowth', 'talent(7,2)&combopoints==5&!buff(Bloodtalons)&!target.dot(Rip).ticking', 'player'},
	--# Force use of Tiger's Fury before applying Rip.
	{'Tiger\'s Fury', '!target.dot(Rip).ticking&combopoints==5', 'player'}
}

local Cooldowns = {
	{'#trinket1', 'UI(trinket1)', 'target'},
	{'#trinket2', 'UI(trinket2)', 'target'},
	{'Rake', 'player.buff(Prowl)||player.buff(Shadowmeld)', 'target'},
	{'Berserk', 'buff(Tiger\'s Fury)', 'player'},
	{'Incarnation: King of the Jungle', 'talent(5,2)&{spell(Tiger\'s Fury).cooldown<gcd||{energy.time_to_max>1&energy>25}}', 'player'},
	{'Tiger\'s Fury', '{!buff(Clearcasting)&energy.deficit>50}||energy.deficit>70', 'player'},
	{'Ferocious Bite', 'dot(Rip).ticking&dot(Rip)remains<3&ttd>3&{health<25||talent(6,1)}', 'target'},
	{'!Regrowth', 'talent(7,2)&buff(Predatory Swiftness)&{player.combopoints>4||buff(Predatory Swiftness).remains<1.5||{talent(7,2)&combopoints==2&!buff(Bloodtalons)&spell(Ashamane\'s Frenzy).cooldown<gcd}}', 'player'},
	{SBT_Opener, 'talent(6,1)&xtime<20'},
	--# Special logic for Ailuro Pouncers legendary.
	{'!Regrowth', 'equipped(137024)&talent(7,2)&buff(Predatory Swiftness).stack>1&!buff(Bloodtalons)', 'player'}
}

local Finisher = {
	{'Savage Roar', 'talent(5,3)&{!buff(Savage Roar)&{combopoints==5||talent(7,3)&action(Brutal Slash).charges>0}}', 'player'},
	{'Savage Roar', 'talent(5,3)&{{{buff(Savage Roar).duration<20.5&talent(6,2)}||{buff(Savage Roar).duration<8.2&!talent(6,2)}}&combopoints==5&{energy.time_to_max<1||buff(Berserk)||buff(Incarnation: King of the Jungle)||spell(Tiger\'s Fury).cooldown<3||buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5&area(8).enemies.inFront<6}}}', 'player'},
	{'Thrash', 'dot.remains<=dot.duration*0.3&player.area(8).enemies.inFront>4', 'target'},
	{'Swipe', 'player.combopoints==5&{player.area(8).enemies.inFront>5||{player.area(8).enemies.inFront>2&!talent(7,2)}}&player.combopoints==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(7,3)&player.buff(Clearcasting)}}', 'target'},
	{'Swipe', 'player.area(8).enemies.inFront>7', 'target'},
	{'Rip', '{!dot.ticking||{dot.remains<8&health>25&!talent(6,1)}||persistent_multiplier>dot.pmultiplier}&{dot.remains>dot.tick_time*4&player.combopoints==5}&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(7,3)&player.buff(Clearcasting)}||talent(5,1)||!dot.ticking||{dot(Rake).remains<1.5&player.area(8).enemies.inFront<6}}', 'target'},
	{'Ferocious Bite', 'energy.deficit==0&player.combopoints==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(7,3)&player.buff(Clearcasting)}}', 'target'}
}

local Generator = {
	{'Brutal Slash', 'talent(7,1)&player.combopoints<5', 'target'},
	{'!Ashamane\'s Frenzy', 'player.combopoints<3&toggle(Cooldowns)&{player.buff(Bloodtalons)||!talent(7,2)}&{player.buff(Savage Roar)||!talent(5,3)}', 'target'},
	{'Elune\'s Guidance', 'talent(6,3)&{combopoints==0&energy<action(Ferocious Bite).cost+25-energy.regen*spell(Elune\'s Guidance).cooldown}', 'player'},
	{'Elune\'s Guidance', 'talent(6,3)&{combopoints==0&energy>=action(Ferocious Bite).cost+25}', 'player'},
	{'Thrash', 'talent(7,1)&player.area(8).enemies.inFront>8', 'target'},
	{'Thrash', 'dot.remains<=dot.duration*0.3&player.area(8).enemies.inFront>1', 'target'},
	{'Swipe', 'player.area(8).enemies.inFront>5', 'target'},
	{'Swipe', 'player.combopoints<5&player.area(8).enemies.inFront>2', 'target'},
	{'Rake', 'player.combopoints<5&{!dot.ticking||{!talent(7,2)&dot.remains<dot.duration*0.3}||{talent(7,2)&player.buff(Bloodtalons)&{!talent(5,1)&dot.remains<8||dot.remains<6}&persistent_multiplier>dot.pmultiplier*0.80}}&dot.remains>dot.tick_time', 'target'},
	{'Moonfire', 'talent(1,3)&player.combopoints<5&dot.remains<5.2&dot.remains>dot.tick_time*2', 'target'},
	{'Shred', 'player.combopoints<5&{player.area(8).enemies.inFront<3||talent(7,1)}', 'target'}
}

local xCombat = {
	{Finisher, 'player.combopoints>0'},
	{Generator}
}

local Survival = {
	{Bear_Healing, 'talent(3,2)&player.incdmg(5)>player.health.max*0.20&!player.buff(Frenzied Regeneration)'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'cooldown(Swiftmend).up.&form>0&talent(3,3)&player.health<=UI(swiftm_spin)&UI(swiftm_check)'},
	{'Swiftmend', 'talent(3,3)&health<=UI(swiftm_spin)&UI(swiftm_check)', 'player'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.inMelee'},
	{Interrupts_Random},
	{Survival, 'player.health<100'},
	{'Cat Form', '!buff(Frenzied Regeneration)&{!buff(Cat Form)&{!buff(Travel Form)||area(8).enemies.inFront>0}}', 'player'},
	{Cooldowns, '!player.buff(Frenzied Regeneration)&toggle(Cooldowns)'},
	{'Moonfire', 'talent(1,3)&!range>8&range<41&inFront&!player.buff(Prowl)&!debuff(Moonfire)', 'target'},
	{xCombat, '!player.buff(Frenzied Regeneration)&target.inMelee&target.inFront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)'},
	{Interrupts_Random}
}

NeP.CR:Add(103, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Druid - Feral',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
