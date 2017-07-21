local _, Zylla = ...

-- Creds to Yobleed for this routine!

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']


local GUI = {
	-- GUI Header
	{type = 'texture',
	texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\shadow.blp',
	width = 512,
	height = 256,
	offset = 90,
	y = 42,
	center = true},

	-- GENERAL
	{type = 'header', text = 'General', align = 'center'},
	{type = 'text', text = 'Before Pull.', align = 'center'},
	{type = 'checkbox', text = 'Potion of Prolonged Power', key = 's_pull', width = 55, default =  false},
	{type = 'checkbox', text = 'Mind Blast', key = 'pull_MB', width = 55, default =  true},
	{type = 'text', text = 'Movement', align = 'center'},
	{type = 'checkbox', text = 'Body and Soul', key = 'm_Body', width = 55, default = true},
    {type = 'ruler'}, {type = 'spacer'},

    -- COOLDOWNS
    {type = 'header', text = 'Cooldowns if Toggled', align = 'center'},
    {type = 'checkbox', text = 'Hero Potion of Prolonged Power', key = 's_PP', width = 55, default =  false},
    {type = 'text', text = 'Trinkets', align = 'center'},
    {type = 'checkbox', text = 'Top Trinket', key = 'trinket_1', width = 55, default = false},
	{type = 'checkbox', text = 'Bottom Trinket', key = 'trinket_2', width = 55, default = false},
	{type = 'text', text = 'Power Infusion', align = 'center'},
	{type = 'checkbox', text = 'ON/OFF', key = 'dps_PI', width = 55, default =  false},
	{type = 'spinner', text = 'Target<45%', key = 'dps_PIspin1', align = 'left', width = 55, step = 1, default = 15},
	{type = 'spinner', text = 'Target>35%', key = 'dps_PIspin2', align = 'left', width = 55, step = 1, default = 15},
	{type = 'text', text = 'Shadowfiend', align = 'center'},
	{type = 'checkbox', text = 'ON/OFF', key = 'dps_fiend', width = 55, default =  true},
    {type = 'spinner', text = 'Shadowfiend Stacks', key = 'dps_SFspin', align = 'left', width = 55, step = 1, default = 22},
    {type = 'text', text = 'Void Torrent', align = 'center'},
    {type = 'checkbox', text = 'ON/OFF', key = 'dps_void', width = 55, default =  true},
	{type = 'text', text = 'Dispersion', align = 'center'},
	{type = 'checkbox', text = 'ON/OFF', key = 'dps_D', width = 55, default =  true},
	{type = 'spinner', text = 'Target<45%', key = 'dps_Dspin', align = 'left', width = 55, min = 15, max = 50, step = 1, default = 44},
	{type = 'spinner', text = 'Target>35%', key = 'dps_D2spin', align = 'left', width = 55, min = 15, max = 50, step = 1, default = 30},
	{type = 'text', text = 'Arcane Torrent', align = 'center'},
	{type = 'checkbox', text = 'ON/OFF', key = 'dps_at', width = 55, default =  true},
	{type = 'ruler'}, {type = 'spacer'},
	-- GUI Survival & Potions
	{type = 'header', text = 'Survival&Potions', align = 'center'},
	{type = 'checkbox', text = 'Self Heal Below X%', key = 'k_SH', width = 55, default =  true},
	{type = 'spinner', text = '', key = 'k_SHspin', width = 55, default = 66},
	{type = 'checkbox', text = 'Fade', key = 's_F', width = 55, default =  false},
	{type = 'checkbox', text = 'Power Word: Shield', key = 's_PWS', width = 55, default = true},
	{type = 'spinner', text = '', key = 's_PWSspin', width = 55, default = 75},
	{type = 'checkbox', text = 'Dispersion', key = 's_D', width = 55, default = true},
	{type = 'spinner', text = '', key = 's_Dspin', align = 'left', width = 55, default = 20},
	{type = 'checkbox', text = 'Vampiric Embrace Below X%', key = 's_VE', width = 55, default = true},
	{type = 'spinner', text = '', key = 's_VEspin', width = 55, default = 35, align = 'left'},
	{type = 'checkbox', text = 'Gift of the Naaru', key = 's_GotN', width = 55, default = false},
	{type = 'spinner', text = '', key = 's_GotNspin', width = 55, default = 40},
	{type = 'checkbox', text = 'Healthstone', key = 's_HS', width = 55, default = false},
	{type = 'spinner', text = '', key = 's_HSspin', width = 55, default = 20},
	{type = 'checkbox', text = 'Ancient Healing Potion', key = 's_AHP', width = 55, default = false},
	{type = 'spinner', text = '', key = 's_AHPspin', width = 55, default = 20, align = 'left'},
	{type = 'ruler'}, {type = 'spacer'},
	-- GUI Party Support
	{type = 'header', text = 'Party Support', align = 'center'},
	{type = 'checkbox', text = 'Gift of the Naaru', key = 'sup_GotN', width = 55, default = false},
	{type = 'spinner', text = '', key = 'sup_GotNspin', width = 55, default = 20},
	{type = 'checkbox', text = 'Power Word: Shield', key = 'sup_PWS', width = 55, default = true},
	{type = 'spinner', text = '', key = 'sup_PWSspin', width = 55, default = 20},
	{type = 'checkbox', text = 'Heal Party Below X%', key = 'k_PH', width = 55, default =  true},
	{type = 'spinner', text = '', key = 'k_PHspin', width = 55, default = 30},
	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'text', text = 'Left Shift: Force AoE | Left Ctrl: Mass Dispel | Alt: Shadow Word Pain - Mass DoT', align = 'center'},
	{type = 'checkbox', text = 'Force AOE', key = 'k_AOE', width = 55, default = true},
	{type = 'checkbox', text = 'Mass Dispel', key = 'k_MD', width = 55, default = true},
	{type = 'ruler'},	{type = 'spacer'},
	-- Trinkets + Heirlooms for leveling
	{type = 'header', 	text = 'Trinkets/Heirlooms', align = 'center'},
	{type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
	{type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
	{type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
	{type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
	{type = 'ruler'},	{type = 'spacer'},
}

local exeOnLoad=function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPriest: |cff6c00ffShadow|r')
	print('|cffADFF2F --- |rSupported Talents:ToF,Body&Soul,Mind Bomb, LI, LoS, Tier 5&6&7')
	print('|cffADFF2F --- |cffff6800Mangaza\'s Madness&Norgannon\'s Foresight|r Supported')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rQuestions or Issues? @Zylla NerdPack Discord|')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'abc',
		name='Mind Bomb AoE',
		text = 'Enable/Disable: Mind Bomb in rotation.',
		icon='Interface\\ICONS\\Spell_shadow_mindbomb',
	})

	NeP.Interface:AddToggle({
		key = 's2m',
		name='Surrender to Madness',
		text = 'Enable/Disable: Automatic S2M',
		icon='Interface\\ICONS\\Achievement_boss_generalvezax_01',
	})

end

local Survival = {
	{'Fade', 'target.threat==100&UI(s_F)'},
	{'Power Word: Shield', 'player.health<=UI(s_PWSspin)&UI(s_PWS)', 'player'},
	{'!Dispersion', 'player.health<=UI(s_Dspin)&UI(s_D)'},
	{'!Gift of the Naaru', 'player.health<=UI(s_GotNspin)&UI(s_GotN)'},
	{'!Shadow Mend', 'UI(k_SH)&player.health<=UI(k_SHspin)', 'player'},
	{'!Vampiric Embrace', 'toggle(cooldowns)&player.health<=UI(s_VEspin)&UI(s_VE)'},
}

local Potions = {
	{'#142117', 'player.hashero&!player.buff(Potion of Prolonged Power)&UI(s_PP)'},
	{'#5512', 'player.health<=UI(s_HSspin)&UI(s_HS)'},
	{'#127834', 'player.health<=UI(s_AHPspin)&UI(s_AHP)'},
}

local Keybinds = {
	{'!Shadow Word: Pain', 'keybind(lalt)&range<50&debuff.duration<3', 'enemies'},
	{'!Void Eruption', 'UI(k_AOE)&keybind(lshift)&!player.buff(Voidform)', 'target'},
	{'!Shadow Crash', 'advanced&keybind(lshift)&!target.moving', 'target.ground'},
	{'!Shadow Crash', '!advanced&keybind(lshift)&!target.moving', 'cursor.ground'},
	{'!Shadow Word: Pain', '!target.debuff(Shadow Word: Pain)&UI(k_AOE)&keybind(lshift)', 'target'},
	{'!Shadow Word: Pain', '!mouseover.debuff(Shadow Word: Pain)&UI(k_AOE)&keybind(lshift)', 'mouseover'},
	{'!Mind Flay', 'target.debuff(Shadow Word: Pain)&UI(k_AOE)&keybind(lshift)', 'target'},
	{'!Mass Dispel', 'keybind(lcontrol)&UI(k_MD)&!advanced', 'cursor.ground'},
	{'!Mass Dispel', 'keybind(lcontrol)&UI(k_MD)', 'mouseover.ground'},
}

local Movement = {
	{'!Power Word: Shield', 'talent(2,2)&player.movingfor>0&UI(m_Body) ', 'player'},
}

local Support = {
	{'!Gift of the Naaru', 'lowest.health<=UI(sup_GotNspin)&UI(sup_GotN)', 'lowest'},
	{'!Power Word: Shield', 'lowest.health<=UI(sup_PWSspin)&UI(sup_PWS)', 'lowest'},
	{'!Shadow Mend', 'UI(k_PH)&lowest.health<=UI(k_PHspin)&lowest.range<50', 'lowest'},
}

local Interrupts = {
	{'!Silence'},
	{'!Arcane Torrent', 'target.inMelee&spell(Silence).cooldown>gcd&!lastgcd(Silence)'},
}

local Surrender = {
	{'!Surrender to Madness', 'talent(7,3)&target.deathin<200&toggle(s2m)&!player.buff(Surrender to Madness)&target.boss&boss.exists'},
	{'!Surrender to Madness', 'talent(7,3)&player.debuff(Dream Simulacrum)&toggle(s2m)&!player.buff(Surrender to Madness)'},
}

local Insight = {
	{'!Mindblast', '!spell(Void Eruption).cooldown==0'},
}

local Emergency = {
	{'!Dispersion', 'player.spell(Shadow Word: Death).charges<1&!spell(Void Torrent).cooldown>0&player.insanity<30&!talent(7,1)&!talent(7,2)&UI(dps_D)'},
	{'!Arcane Torrent', 'UI(dps_at)&player.insanity<45&{!spell(Shadow Word: Death).cooldown>0||!target.health<45}&!spell(Dispersion).cooldown>0'},
	{'!Power Infusion', 'talent(6,1)&player.buff(voidform).count>70&spell(Shadow Word: Death).charges<1&player.insanity<70&UI(dps_PI)'},
}

local cooldowns = {
	{'!Void Torrent', 'player.spell(Void Eruption).cooldown>0&UI(dps_void)'},
	{'!Power Infusion', 'talent(6,1)&player.buff(Surrender to Madness)&player.buff(voidform).count>40&player.insanity>40&!spell(Void Eruption).cooldown==0&!spell(Void Torrent).cooldown==0&!spell(Dispersion).cooldown=0&UI(dps_PI)', 'player'},
	{'Power Infusion', 'talent(6,1)&!player.buff(Surrender to Madness)&player.buff(voidform).count>=UI(dps_PIspin1)&target.health<45&UI(dps_PI)', 'player'},
	{'Power Infusion', 'talent(6,1)&!player.buff(Surrender to Madness)&player.buff(voidform).count>=UI(dps_PIspin2)&target.health>35&UI(dps_PI)', 'player'},
	{'!Mindbender', 'talent(6,3)&player.buff(Surrender to Madness)'},
	{'!Mindbender', 'talent(6,3)&!player.buff(Surrender to Madness)&player.buff(voidform).count>5'},
	{'!Shadowfiend', '!talent(6,3)&!spell(Void Eruption).cooldown=0&player.buff(voidform).count>=UI(dps_SFspin)&!talent(6,1)&UI(dps_fiend)'},
	{'!Shadowfiend', 'player.buff(Power Infusion)&player.buff(voidform).count>=UI(dps_SFspin)&UI(dps_fiend)'},
}


local AOE = {
	{'Shadow Crash', '{target.area(8).enemies>1&advanced&toggle(AOE)&player.buff(Voidform)&!target.moving&player.spell(Void Eruption).cooldown>0}||{!advanced&toggle(AOE)&player.buff(Voidform)&!target.moving&player.spell(Void Eruption).cooldown>0}', 'target.ground'},
}

local ST1 = {
	{'!Void Eruption','target.debuff(Vampiric Touch).duration>13&player.buff(Surrender to Madness)&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)'},
	{'!Void Eruption', 'target.debuff(Vampiric Touch).duration>4&!player.buff(Surrender to Madness)&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)'},
	{'!Shadow Word: Death', '{talent(7,1)&!player.insanity>55&!player.channeling(Void Eruption)}||{target.health<45&talent(7,3) ||talent(7,2)&!player.insanity = 100&!player.channeling(Void Eruption)}'},
	{'!Vampiric Touch', '!target.debuff(Shadow Word: Pain)&talent(6,2)'},
	{'!Mind Blast', 'player.channeling(Mind Flay)'},
	{'Mind Blast', '{talent(6,1)&!player.insanity>55}||{talent(7,3) ||talent(7,2)&!player.insanity = 100}'},
	{'Shadow Word: Pain', '{target.debuff(Shadow Word: Pain).duration<3&!talent(6,2)}||{!target.debuff(Shadow Word: Pain)&!talent(6,2)}'},
	{'!Vampiric Touch', '{target.debuff(Vampiric Touch).duration<4&!lastcast(Vampiric Touch)}||{!target.debuff(Vampiric Touch)&!lastcast(Vampiric Touch)}||{{target.debuff(Shadow Word: Pain).duration<2.3||!target.debuff(Shadow Word: Pain)}&talent(6,2)}'},
	{'Mind Flay', '!spell(Mind Blast).cooldown=0&target.debuff(Shadow Word: Pain)&target.debuff(Vampiric Touch)&{talent(7,1)&!player.insanity>55}||{talent(7,3) ||talent(7,2)&!player.insanity = 100}'},
}

local lotv1 = {
	{'!Dispersion', 'player.buff(voidform).count>=UI(dps_Dspin)&UI(dps_D)&spell(Shadow Word: Death).charges<1&player.insanity<40&target.health<45&!player.spell(Void Torrent).cooldown==0'},
	{'!Dispersion', 'player.buff(voidform).count>=UI(dps_D2spin)&UI(dps_D)&!player.buff(Surrender to Madness)&player.insanity<40&target.health>35&!player.spell(Void Torrent).cooldown==0'},
	{'!Shadow Word: Death', '{!player.channeling(Mind Blast)&player.spell(Shadow Word: Death).charges>1&player.insanity<80}||{!player.channeling(Mind Blast)&player.insanity<45}'},
	{'!Void Eruption', '!player.channeling(Mind Blast)||player.insanity<30'},
	{'!Vampiric Touch', '!target.debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', 'player.spell(Void Eruption).cooldown>gcd'},
	{'!Mind Blast', 'player.spell(Void Eruption).cooldown>gcd&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'Shadow Word: Pain', '{target.debuff(Shadow Word: Pain).duration<3&!talent(6,2)}||{!target.debuff(Shadow Word: Pain)&!talent(6,2)}||{moving&!target.debuff(Shadow Word: Pain)}'},
	{'!Vampiric Touch', '{target.debuff(Vampiric Touch).duration<4&!lastcast(Vampiric Touch)}||{!target.debuff(Vampiric Touch)&!lastcast(Vampiric Touch)}||{{target.debuff(Shadow Word: Pain).duration<2.3||!target.debuff(Shadow Word: Pain)}&talent(6,2)}'},
	{'Mind Flay', '!player.spell(Void Eruption).cooldown==0&!player.spell(Mind Blast).cooldown==0&target.debuff(Shadow Word: Pain)&target.debuff(Vampiric Touch)'},
}

local s2m1 = {
	{'!Dispersion', 'player.buff(voidform).count>5&player.buff(voidform).count<10&!lastcast(Void Torrent)&UI(dps_D)'},
	{'!Void Torrent', 'UI(dps_void)'},
	{'!Shadow Word: Death', 'player.buff(voidform).count<10&target.debuff(Shadow Word: Pain).duration>6&target.debuff(Vampiric Touch).duration>6'},
	{'!Shadow Word: Death', 'player.insanity<30'},
	{'!Void Eruption', '!player.channeling(Mind Blast)||player.insanity<50'},
	{'!Vampiric Touch', '!target.debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', '!player.spell(Void Eruption).cooldown==0'},
	{'!Mind Blast', '!player.spell(Void Eruption).cooldown==0&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'!Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration<3||!target.debuff(Shadow Word: Pain)'},
	{'!Vampiric Touch', 'target.debuff(Vampiric Touch).duration<4||!target.debuff(Vampiric Touch)'},
	{'Mind Flay', '!player.spell(Void Eruption).cooldown==0&!player.spell(Mind Blast).cooldown==0&target.debuff(Shadow Word: Pain)&target.debuff(Vampiric Touch)'},
}

local ST2 = {
	{'!Void Eruption','target.debuff(Vampiric Touch).duration>13&player.buff(Surrender to Madness)&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)'},
	{'!Void Eruption', 'target.debuff(Vampiric Touch).duration>4&!player.buff(Surrender to Madness)&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)'},
	{'!Shadow Word: Death', '{talent(7,1)&!player.insanity>55&!player.channeling(Void Eruption)}||{target.health<45&talent(7,3) ||talent(7,2)&!player.insanity = 100&!player.channeling(Void Eruption)}'},
	{'!Vampiric Touch', '!target.debuff(Shadow Word: Pain)&talent(6,2)'},
	{'!Mind Blast', 'player.channeling(Mind Flay)'},
	{'Mind Blast', 'target.debuff(Shadow Word: Pain)&target.debuff(Vampiric Touch)'},
	{'Mind Blast', '!target.debuff(Shadow Word: Pain)&!target.debuff(Vampiric Touch)&!lastcast(Mind Blast)&{talent(7,1)&!player.insanity>55}||{talent(7,3) ||talent(7,2)&!player.insanity = 100}'},
	{'Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration<3||!target.debuff(Shadow Word: Pain)'},
	{'!Vampiric Touch', '{target.debuff(Vampiric Touch).duration<4&!lastcast(Vampiric Touch)}||{!target.debuff(Vampiric Touch)&!lastcast(Vampiric Touch)}||{{target.debuff(Shadow Word: Pain).duration<2.3||!target.debuff(Shadow Word: Pain)}&talent(6,2)}'},
	{'Mind Flay', '!spell(Mind Blast).cooldown==0&target.debuff(Shadow Word: Pain)&target.debuff(Vampiric Touch)&{talent(7,1)&!player.insanity>55}||{talent(7,3) ||talent(7,2)&!player.insanity = 100}'},
}

local lotv2 = {
	{'!Dispersion', 'player.buff(voidform).count>=UI(dps_Dspin)&UI(dps_D)&spell(Shadow Word: Death).charges<1&player.insanity<40&target.health<45'},
	{'!Dispersion', 'player.buff(voidform).count>=UI(dps_D2spin)&UI(dps_D)&!player.buff(Surrender to Madness)&player.insanity<40&target.health>35'},
	{'!Void Torrent', '{player.buff(voidform).count>13&spell(Shadow Word: Death).charges<1&player.insanity<40&UI(dps_void)}||{player.buff(voidform).count>06&!player.buff(Surrender to Madness)&player.insanity<40&target.health>35&UI(dps_void)} '},
	{'!Shadow Word: Death', '{player.insanity<50}||{target.health<45&player.buff(voidform).count<25&player.insanity<70}'},
	{'!Void Eruption', '!player.channeling(Mind Blast)||player.insanity<50'},
	{'!Vampiric Touch', '!target.debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', '!player.spell(Void Eruption).cooldown==0'},
	{'!Mind Blast', '!player.spell(Void Eruption).cooldown==0&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'Shadow Word: Pain', '{target.debuff(Shadow Word: Pain).duration<3&!talent(6,2)}||{!target.debuff(Shadow Word: Pain)&!talent(6,2)}||{moving&!target.debuff(Shadow Word: Pain)}'},
	{'!Vampiric Touch', '{target.debuff(Vampiric Touch).duration<4&!lastcast(Vampiric Touch)}||{!target.debuff(Vampiric Touch)&!lastcast(Vampiric Touch)}||{{target.debuff(Shadow Word: Pain).duration<2.3||!target.debuff(Shadow Word: Pain)}&talent(6,2)}'},
	{'Mind Flay', '!player.spell(Void Eruption).cooldown==0&!player.spell(Mind Blast).cooldown==0&target.debuff(Shadow Word: Pain)&target.debuff(Vampiric Touch)'},
}

local s2m2 = {
	{'!Dispersion', 'player.buff(voidform).count>5&player.buff(voidform).count<10&!lastcast(Void Torrent)&UI(dps_D)'},
	{'!Void Torrent', 'UI(dps_void)'},
	{'!Shadow Word: Death', 'player.buff(voidform).count<10&target.debuff(Shadow Word: Pain).duration>6&target.debuff(Vampiric Touch).duration>6'},
	{'!Shadow Word: Death', 'player.insanity<30'},
	{'!Void Eruption', '!player.channeling(Mind Blast)||player.insanity<50'},
	{'!Vampiric Touch', '!target.debuff(Shadow Word: Pain)&talent(6,2)'},
	{'Mind Blast', '!player.spell(Void Eruption).cooldown==0'},
	{'!Mind Blast', '!player.spell(Void Eruption).cooldown==0&target.debuff(Vampiric Touch)&target.debuff(Shadow Word: Pain)&player.channeling(Mind Flay)'},
	{'!Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration<3||!target.debuff(Shadow Word: Pain)'},
	{'!Vampiric Touch', 'target.debuff(Vampiric Touch).duration<4||!target.debuff(Vampiric Touch)'},
	{'Mind Flay', '!player.spell(Void Eruption).cooldown==0&player.spell(Mind Blast).charges<1&target.debuff(Shadow Word: Pain)&target.debuff(Vampiric Touch)'},
}

local inCombat = {
	{Util},
	{Trinkets},
	{Heirlooms},
	--Shadowform if no voidform and no shadowform.
	{'Shadowform', '!player.buff(Voidform)&!player.buff(Shadowform)'},
	{Movement, '!player.buff(Voidform||{player.buff Voidform&!spell(Void Eruption).cooldown==0&!player.channeling(Void Torrent)}'},
	{Surrender, '!player.channeling(Void Torrent)'},
	{'Mind Bomb', '{toggle(abc)&target.area(8).enemies>2&!player.buff(Surrender To Madness)&!player.channeling(Void Torrent)&!talent(7,2)}||{toggle(abc)&target.area(8).enemies>2&talent(7,2)&spell(Shadow Crash).cooldown==0&player.buff(Voidform)&!player.channeling(Void Torrent)}'},
	{Emergency, '!player.channeling(Void Torrent)'},
	{Potions, '!player.channeling(Void Torrent)'},
	{Survival, 'player.health<100&!player.channeling(Void Torrent)&!player.buff(Surrender to Madness)'},
	{Support, '!player.buff(Surrender to Madness)&!player.channeling(Void Torrent)'},
	{cooldowns, 'player.buff(voidform)&!player.channeling(Void Torrent)&toggle(cooldowns)'},
	{Insight, 'player.buff(Shadowy Insight)&{!player.channeling(Void Torrent)&{talent(7,1)&!player.insanity>55}||{talent(7,3) ||talent(7,2)&!player.insanity = 100}}||{player.moving&!player.buff(Surrender to Madness)}'},
	{Keybinds},
	{Trinkets, '!player.channeling(Void Torrent)'},
	{Interrupts, 'toggle(interrupts)&target.interruptAt(70)&target.inFront&target.range<40&!player.channeling(Void Torrent)'},
	{AOE, 'talent(7,2)&!player.channeling(Void Torrent)'},
	{s2m2, "equipped(Mangaza's Madness)&player.buff(voidform)&!player.channeling(Void Torrent)&player.buff(Surrender to Madness)"},
	{s2m1, 'player.buff(Voidform)&!player.channeling(Void Torrent)&player.buff(Surrender to Madness)'},
	{lotv2, "{equipped(Mangaza's Madness)&player.buff(voidform)&!player.channeling(Void Torrent)&talent(7,1)}||{talent(7,3)&!player.buff(Surrender to Madness)&equipped(Mangaza's Madness)&player.buff(voidform)&!player.channeling(Void Torrent)}||{talent(7,2)&!player.buff(Surrender to Madness)&!equipped(Mangaza's Madness)&player.buff(voidform)&!player.channeling(Void Torrent)}"},
	{lotv1, "{player.buff(voidform)&!player.channeling(Void Torrent)&talent(7,1)}||{talent(7,3)&!player.buff(Surrender to Madness)&!equipped(Mangaza's Madness)&player.buff(voidform)&!player.channeling(Void Torrent)}||{talent(7,2)&!player.buff(Surrender to Madness)&!equipped(Mangaza's Madness)&player.buff(voidform)&!player.channeling(Void Torrent)}"},
	{ST2, "equipped(Mangaza's Madness)&!player.buff(voidform)&!player.channeling(Void Torrent)"},
	{ST1, "!player.buff(voidform)&!player.channeling(Void Torrent)"},
	{'Mind Flay'},
}

local outCombat = {
	{Keybinds},
	-- Potion of Prolonged Power usage before pull if enabled in UI.
	{'#142117', 'pull_timer<4&UI(s_pull)'},
	-- Mind Blast before Pull.
	{'Mind Blast', 'pull_timer<2.2&UI(pull_MB)'},
	{'Shadowform', '!player.buff(Shadowform)'},
	--No Body and Soul from Class Hall.
	{Movement, '!player.buff(Body and Soul)&!inareaid==1040'},
}

NeP.CR:Add(258, {
	name='[|cff'..Zylla.addonColor..'Zylla\'s|r] Priest - Shadow',
	  ic=inCombat,
	 ooc=outCombat,
	 gui=GUI,
	load=exeOnLoad
})
