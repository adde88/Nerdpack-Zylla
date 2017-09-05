local _, Zylla = ...

local Fel_Explosives = _G.Fel_Explosives

local GUI = {
	--Logo
	{type = 'texture',  texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = -60, align = 'center'},
	{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},
	{type = 'header', 	text = 'Keybinds', align = 'center'},
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
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',						align = 'center'},
	{type = 'checkspin',text = 'Swiftmend below HP%', key = 'swiftm', 		spin = 85, step = 5, max = 100, check = true},
	{type = 'ruler'},		{type = 'spacer'},
	-- Mythic + / Raiding
	{type = 'header', 	text = 'Mythic+ Raid Settings',							align = 'center'},
	{type = 'checkbox', text = 'Attack Fel Explosives', 						key = 'mythic_fel', width = 55, default = false},
	{type = 'ruler'},	 {type = 'spacer'},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FFeral |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')
	print('| This routine does not work at the moment...')

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
--[[
		NeP.Interface:AddToggle({
		key = 'moc',
		name = 'Moment of Clarity',
		text = 'something something something.',
		icon = 'Interface\\Icons\\spell_druid_momentofclarity',
	})
]]--
end

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
	{'Skull Bash', 'player.form>0', 'target'},
	{'!Typhoon', 'talent(4,3)&player.spell(Skull Bash).cooldown>gcd'},
	{'!Mighty Bash', 'player.spell(Skull Bash).cooldown>gcd'},
}

local Interrupts_Random = {
	{'!Skull Bash', 'interruptAt(70)&player.form>0&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<14', 'enemies'},
	{'!Typhoon', 'interruptAt(60)&toggle(xIntRandom)&toggle(Interrupts)&player.area(15).enemies.inFront.inFront>=1', 'enemies'},
	{'!Mighty Bash', 'interruptAt(75)&toggle(xIntRandom)&toggle(Interrupts)&range<=5&inFront', 'enemies'},
}

-- Pooling START

local Bear_Healing = {
	{'Bear Form', 'form~=1'},
	{'Frenzied Regeneration'},
}

local Regrowth_Pool = {
	{'!Regrowth'},
}

local Moonfire_Pool = {
	{'%pause', 'player.energy<30&!player.buff(Clearcasting)'},
	{'Moonfire'},
}

local Rake_Pool = {
	{'%pause', 'player.energy<35&!player.buff(Clearcasting)'},
	{'Rake'},
}

local Rip_Pool = {
	{'%pause', 'player.energy<30&!player.buff(Clearcasting)'},
	{'Rip'},
}

local Savage_Roar_Pool = {
	{'%pause', 'player.energy<40&!player.buff(Clearcasting)'},
	{'Savage Roar'},
}

local Ferocious_Bite_Pool = {
	{'%pause', 'player.energy<25&!player.buff(Clearcasting)'},
	{'Ferocious Bite'},
}

local Thrash_Pool = {
	{'%pause', 'player.energy<50&!player.buff(Clearcasting)'},
	{'Thrash'},
}

local Swipe_Pool = {
	{'%pause', 'player.energy<45&!player.buff(Clearcasting)'},
	{'Swipe'},
}

-- Pool END

local PreCombat = {
	{'Travel Form', 'toggle(xFORM)&player.movingfor>1&!indoors&!player.buff(Travel Form)&!player.buff(Prowl)'},
	{Regrowth_Pool, 'talent(7,2)&target.enemy&target.alive&!player.buff(Prowl)&!prev(Regrowth)&player.buff(Bloodtalons).stack<2'},
	{'Cat Form', 'toggle(xFORM)&player.movingfor>1&indoors&!player.buff(Cat Form)&!player.buff(Travel Form)&!player.buff(Prowl)'},
	{'Prowl', 'toggle(xFORM)&!player.buff(Prowl)&target.enemy&target.alive&target.range<21'},
	{'Rake', 'player.buff(Prowl)&target.range<5&target.inFront'},
}

local SBT_Opener = {
	--# Hard-cast a Regrowth for Bloodtalons buff. Use Dash to re-enter Cat Form.
	{Regrowth_Pool, 'talent(7,2)&combo_points==5&!player.buff(Bloodtalons)&!target.dot(Rip).ticking'},
	--# Force use of Tiger's Fury before applying Rip.
	{'Tiger\'s Fury', '!target.dot(Rip).ticking&combo_points==5'},
}

local Cooldowns = {
	{'Rake', 'player.buff(Prowl)||player.buff(Shadowmeld)'},
	{'Berserk', 'player.buff(Tiger\'s Fury)'},
	{'Incarnation: King of the Jungle', 'player.spell(Tiger\'s Fury).cooldown<gcd'},
	{'Tiger\'s Fury', '{!player.buff(Clearcasting)&energy.deficit>50}||energy.deficit>70'},
	{'Incarnation: King of the Jungle', 'energy.time_to_max>1&player.energy>25'},
	{Ferocious_Bite_Pool, 'target.dot(Rip).ticking&target.dot(Rip)remains<3&target.time_to_die>3&{target.health<25||talent(6,1)}'},
	{Regrowth_Pool, 'talent(7,2)&player.buff(Predatory Swiftness)&{combo_points>4||player.buff(Predatory Swiftness).remains<1.5||{talent(7,2)&combo_points=2&!player.buff(Bloodtalons)&player.spell(Ashamane\'s Frenzy).cooldown<gcd}}'},
	{SBT_Opener, 'talent(6,1)&xtime<20'},
	--# Special logic for Ailuro Pouncers legendary.
	{Regrowth_Pool, 'equipped(137024)&talent(7,2)&player.buff(Predatory Swiftness).stack>1&!player.buff(Bloodtalons)'},
}

local Finisher = {
	{Savage_Roar_Pool, 'talent(6,3)&{!player.buff(Savage Roar)&{combo_points==5||talent(6,2)&action(Brutal Slash).charges>0}}'},
	{Thrash_Pool, 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies.inFront>4'},
	{Swipe_Pool, 'player.area(8).enemies.inFront>7'},
	{Rip_Pool, '{!target.dot(Rip).ticking||{target.dot(Rip).remains<8&target.health>25&!talent(6,1)}||persistent_multiplier(Rip)>dot(Rip).pmultiplier}&{target.time_to_die-target.dot(Rip).remains>dot(Rip).tick_time*4&combo_points==5}&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(6,2)&player.buff(Clearcasting)}||talent(5,1)||!target.dot(Rip).ticking||{target.dot(Rake).remains<1.5&player.area(8).enemies.inFront<6}}'},
	{Savage_Roar_Pool, 'talent(6,3)&{{{player.buff(Savage Roar).duration<20.5&talent(5,3)}||{player.buff(Savage Roar).duration<8.2&!talent(5,3)}}&combo_points==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||player.buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5&player.area(8).enemies.inFront<6}}}'},
	{'Swipe', 'combo_points==5&{player.area(8).enemies.inFront>5||{player.area(8).enemies.inFront>2&!talent(7,2)}}&combo_points==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(6,2)&player.buff(Clearcasting)}}'},
	{'Ferocious Bite', 'energy.deficit==0&combo_points==5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.spell(Tiger\'s Fury).cooldown<3||{talent(6,2)&player.buff(Clearcasting)}}'},
}

local Generator = {
	{'Brutal Slash', 'talent(6,2)combo_points<5'},
	{'!Ashamane\'s Frenzy', 'combo_points<3&toggle(Cooldowns)&{player.buff(Bloodtalons)||!talent(7,2)}&{player.buff(Savage Roar)||!talent(6,3)}'},
	{'Elune\'s Guidance', 'talent(6,3)&{combo_points==0&player.energy<action(Ferocious Bite).cost+25-energy.regen*player.spell(Elune\'s Guidance).cooldown}'},
	{'Elune\'s Guidance', 'talent(6,3)&{combo_points==0&player.energy>=action(Ferocious Bite).cost+25}'},
	{Thrash_Pool, 'talent(7,1)&player.area(8).enemies.inFront>8'},
	{Swipe_Pool, 'player.area(8).enemies.inFront>5'},
	{Rake_Pool, 'combo_points<5&{!target.dot(Rake).ticking||{!talent(7,2)&target.dot(Rake).remains<target.dot(Rake).duration*0.3}||{talent(7,2)&player.buff(Bloodtalons)&{!talent(5,1)&target.dot(Rake).remains<8||target.dot(Rake).remains<6}&persistent_multiplier(Rake)>dot(Rake).pmultiplier*0.80}}&target.dot(Rake).remains>dot(Rake).tick_time'},
	{Moonfire_Pool, 'talent(1,3)&combo_points<5&target.dot(Moonfire).remains<5.2&target.dot(Moonfire).remains>dot(Moonfire).tick_time*2'},
	{Thrash_Pool, 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies.inFront>1'},
	{'Swipe', 'combo_points<5&player.area(8).enemies.inFront>2'},
	{'Shred', 'combo_points<5&{player.area(8).enemies.inFront<3||talent(7,1)}'},
}

local xCombat = {
	{Finisher},
	{Generator},
}

local Survival = {
	{Bear_Healing, 'talent(3,2)&player.incdmg(5)>player.health.max*0.20&!player.buff(Frenzied Regeneration)'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'cooldown(Swiftmend).up.&form>0&talent(3,3)&player.health<=UI(swiftm_spin)&UI(swiftm_check)'},
	{'Swiftmend', 'talent(3,3)&health<=UI(swiftm_spin)&UI(swiftm_check)', 'player'}
}

local inCombat = {
	{Fel_Explosives, 'UI(mythic_fel)&range<=5'},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<=5'},
	{Interrupts_Random},
	{Survival, 'player.health<100'},
	{'Cat Form', 'toggle(xFORM)&!player.buff(Frenzied Regeneration)&!player.buff(Cat Form)&{!player.buff(Travel Form)||player.area(8).enemies.inFront>0}'},
	{Cooldowns, '!player.buff(Frenzied Regeneration)&toggle(Cooldowns)'},
	{Moonfire_Pool, 'talent(1,2)&!target.range<=5&target.range<50&target.inFront&!player.buff(Prowl)&!target.debuff(Moonfire)'},
	{xCombat, '!player.buff(Frenzied Regeneration)&target.range<=5&target.inFront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<=5'},
	{Interrupts_Random},
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
