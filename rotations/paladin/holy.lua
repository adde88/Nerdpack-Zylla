local _, Zylla = ...

-- Thanks to Silver for a "working" Holy routine!

--[[
	TO DO:
	Add Nighthold encounter support
	Add mythic 5 man utility
	Add support for all talents
--]]

local GUI={
	{type='header', 	text='Generic', align='center'},
	{type='spinner', 	text='DPS while lowest health%', 				key='G_DPS', 			default=70},
	{type = 'checkbox', text = 'Auto-Target Enemies when DPSing',		key = 'kAutoTarget', 	default = true},
	{type='spinner', 	text='Critical health%', 						key='G_CHP', 			default=30},
	{type='spinner', 	text='Mana Restore', 							key='P_MR', 			default=20},
	{type='checkbox',	text='Offensive Holy Shock',					key='O_HS', 			default=false},
	{type='ruler'}, {type='spacer'},
	
	--------------------------------
	-- Toggles
	--------------------------------
	{type='header', 	text='Toggles', align='center'},
	{type='checkbox',	text='Avenging Wrath',						key='AW', 		default=false},
	{type='checkbox',	text='Aura Mastery',						key='AM', 		default=false},
	{type='checkbox',	text='Holy Avenger',						key='HA', 		default=false},
	{type='checkbox',	text='Lay on Hands',						key='LoH', 		default=false},
	{type='checkbox',	text='Encounter Support',					key='ENC', 		default=true},
	{type='checkspin',text='Healing Potion',						key='P_HP', 	default=false},
	{type='checkspin',text='Mana Potion',							key='P_MP', 	default=false},
	{type='ruler'}, {type='spacer'},
		
	--------------------------------
	-- TANK
	--------------------------------
	{type='header', 	text='Tank', align='center'},											
	{type='spinner', 	text='Blessing of Sacrifice (Health %)', 	key='T_BoS', 	default=30},	
	{type='spinner', 	text='Light of the Martyr (Health %)', 		key='T_LotM', 	default=35},
	{type='spinner', 	text='Holy Shock (Health %)', 				key='T_HS', 	default=90},
	{type='spinner', 	text='Flash of Light (Health %)', 			key='T_FoL', 	default=75},
	{type='spinner', 	text='Holy Light (Health %)', 				key='T_HL', 	default=90},
	{type='ruler'}, {type='spacer'},
	
	--------------------------------
	-- LOWEST
	--------------------------------
	{type='header', 	text='Lowest', align='center'},
	{type='spinner', 	text='Lay on Hands (Health %)', 				key='L_LoH', 		default=10},
	{type='spinner', 	text='Holy Shock (Health %)', 					key='L_HS', 		default=90},
	{type='spinner', 	text='Light of the Martyr (Health %)', 			key='L_LotM', 		default=40},
	{type='spinner', 	text='Light of the Martyr moving (Health %)', 	key='L_LotMm',		default=65},
	{type='spinner', 	text='Flash of Light (Health %)', 				key='L_FoL', 		default=70},
	{type='spinner', 	text='Holy Light (Health %)', 					key='L_HL', 		default=90},
}

local exeOnLoad=function()
	NeP.Interface:AddToggle({
		key='dps',
		name='DPS',
		text='DPS while healing',
		icon='Interface\\Icons\\spell_holy_crusaderstrike',
	})
	NeP.Interface:AddToggle({
		key='disp',
		name='Dispell',
		text='ON/OFF Dispel All',
		icon='Interface\\ICONS\\spell_holy_purify', 
	})
end

local _Zylla = {
    {'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

-- Cast that should be interrupted
local interrupts={
	{'Hammer of Justice', nil, 'target'},
	{'Blinding Light', 'target.range<=7'},
}

local survival={
	{'#127834', 'UI(P_HP_check)&player.health<=UI(P_HP_spin)'}, -- Health Pot
	{'#127835', 'UI(P_MP_check)&player.mana<=UI(P_MP_spin)'}, -- Mana Pot
	{'Divine Protection', 'player.buff(Blessing of Sacrifice)'},
}

local topUp={
	{'Holy Shock', nil, 'mouseover'},
	{'Flash of Light', nil, 'mouseover'},
}

local DPS={
	{'/startattack', '!isattacking'},
	{'Consecration', 'target.range<=6&target.enemy&!player.moving'},
	{'Blinding Light', 'player.area(8).enemies>=3'},
	{'Holy Shock', 'UI(O_HS)', 'target'},
	{'Holy Prism', nil, 'target'},
	{'Judgment'},
	{'Crusader Strike', 'target.range<=8'},
}

local tank={
	{{
		{'Beacon of Light', '!tank.buff(Beacon of Faith)&!tank.buff(Beacon of Light)', 'tank'},
		{'Beacon of Faith', '!tank2.buff(Beacon of Faith)&!tank2.buff(Beacon of Light)', 'tank2'},
	}, '!talent(7,3)'},
	{'Bestow Faith', '!tank.buff&talent(1,1)&tank.health<=90', 'tank'},
	{'Bestow Faith', '!tank2.buff&talent(1,1)&tank2.health<=90', 'tank2'},
}

local encounters={
	-- Time Release
	{'Holy Shock', 'lowest.debuff(Time Release)', 	'lowest'},
	{'Holy Shock', 'lowest2.debuff(Time Release)', 'lowest2'},
	{'Holy Shock', 'lowest3.debuff(Time Release)', 'lowest3'},
	{'Holy Shock', 'lowest4.debuff(Time Release)', 'lowest4'},
	{'Holy Shock', 'lowest5.debuff(Time Release)', 'lowest5'},
	{'Holy Shock', 'lowest6.debuff(Time Release)', 'lowest6'},
	{'Holy Shock', 'lowest7.debuff(Time Release)', 'lowest7'},
	{'Holy Shock', 'lowest8.debuff(Time Release)', 'lowest8'},
	{'Holy Shock', 'lowest9.debuff(Time Release)', 'lowest9'},
	{'Holy Shock', 'lowest10.debuff(Time Release)', 'lowest10'},
	{'Holy Shock', 'lowest11.debuff(Time Release)', 'lowest11'},
	{'Holy Shock', 'lowest12.debuff(Time Release)', 'lowest12'},
	{'Holy Shock', 'lowest13.debuff(Time Release)', 'lowest13'},
	{'Holy Shock', 'lowest14.debuff(Time Release)', 'lowest14'},
	{'Holy Shock', 'lowest15.debuff(Time Release)', 'lowest15'},
	{'Holy Shock', 'lowest16.debuff(Time Release)', 'lowest16'},
	{'Holy Shock', 'lowest17.debuff(Time Release)', 'lowest17'},
	{'Holy Shock', 'lowest18.debuff(Time Release)', 'lowest18'},
	{'Holy Shock', 'lowest19.debuff(Time Release)', 'lowest19'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest20'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest21'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest22'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest23'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest24'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest25'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest26'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest27'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest28'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest29'},
	{'Holy Shock', 'lowest20.debuff(Time Release)', 'lowest30'},
	{'Flash of Light', 'lowest.debuff(Time Release).duration>=1', 'lowest'},
	{'Flash of Light', 'lowest2.debuff(Time Release).duration>=1', 'lowest2'},
	{'Flash of Light', 'lowest3.debuff(Time Release).duration>=1', 'lowest3'},
	{'Flash of Light', 'lowest4.debuff(Time Release).duration>=1', 'lowest4'},
	{'Flash of Light', 'lowest5.debuff(Time Release).duration>=1', 'lowest5'},
	{'Flash of Light', 'lowest6.debuff(Time Release).duration>=1', 'lowest6'},
	{'Flash of Light', 'lowest7.debuff(Time Release).duration>=1', 'lowest7'},
	{'Flash of Light', 'lowest8.debuff(Time Release).duration>=1', 'lowest8'},
	{'Flash of Light', 'lowest9.debuff(Time Release).duration>=1', 'lowest9'},
	{'Flash of Light', 'lowest10.debuff(Time Release).duration>=1', 'lowest10'},
	{'Flash of Light', 'lowest11.debuff(Time Release).duration>=1', 'lowest11'},
	{'Flash of Light', 'lowest12.debuff(Time Release).duration>=1', 'lowest12'},
	{'Flash of Light', 'lowest13.debuff(Time Release).duration>=1', 'lowest13'},
	{'Flash of Light', 'lowest14.debuff(Time Release).duration>=1', 'lowest14'},
	{'Flash of Light', 'lowest15.debuff(Time Release).duration>=1', 'lowest15'},
	{'Flash of Light', 'lowest16.debuff(Time Release).duration>=1', 'lowest16'},
	{'Flash of Light', 'lowest17.debuff(Time Release).duration>=1', 'lowest17'},
	{'Flash of Light', 'lowest18.debuff(Time Release).duration>=1', 'lowest18'},
	{'Flash of Light', 'lowest19.debuff(Time Release).duration>=1', 'lowest19'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest20'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest21'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest22'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest23'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest24'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest25'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest26'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest27'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest28'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest29'},
	{'Flash of Light', 'lowest20.debuff(Time Release).duration>=1', 'lowest30'},
	
	-- M Bot
	{'Divine Protection', 'player.debuff(Toxic Spores)'},
}

local aoeHealing={
	{'Beacon of Virtue', 'lowestpredicted.area(30,95).heal>=3&talent(7,3)'},
	{'Rule of Law', 'area(22,90).heal.infront>=3&!player.buff&spell(Light of Dawn).cooldown=0'},
	{'Light of Dawn', 'area(15,90).heal.infront>=3&player.buff(Rule of Law)'},
	{'Light of Dawn', 'area(15,90).heal.infront>=3'},
	{'Light of Dawn', 'player.buff(Divine Purpose)'},
	{'Holy Prism', 'target.area(15,80).heal>=3'},
}

local healing={
	-- Add an Aura of Sacrifice rotation here!
	--(Wings and Holy Avenger and Tyrs pre cast)
	--(Bestow Faith or Hammer pre cast)
	--(Divine Shield pre cast)
	--Judgement of Light 
	--Aura Mastery 

	{{
		{'Avenging Wrath'},
		{'Holy Avenger'},
		{'Holy Shock', nil, 'lowestpredicted'},
		{'Light of Dawn'},
		{'Flash of Light', nil, 'lowestpredicted'},
	}, 'player.buff(Aura Mastery)&talent(5,2)'},
		
	{aoeHealing},
	
	-- Tyrs Deliverance
	{'200652', 'player.area(15,75).heal>=3'},
	{'200652', 'player.area(22,75).heal>=3&player.buff(Rule of Law)'},
	
	{encounters, 'UI(ENC)'},
	
	{'Light of the Martyr', '!player&player.buff(Maraad\'s Dying Breath)&lowestpredicted.health<=UI(L_FoL)', 'lowestpredicted'},
	
	-- Infusion of Light
	--{'Flash of Light', 'player.buff(Infusion of Light).count>=2', 'lowestpredicted'},
	{'Flash of Light', 'lowestpredicted.health<=UI(L_FoL)&player.buff(Infusion of Light)', 'lowestpredicted'},
	{'Flash of Light', 'player.buff(Infusion of Light).duration<=3&player.buff(Infusion of Light)', 'lowestpredicted'},
	
	-- Need player health spinner added
	{{
		{'Light of the Martyr', '!player&tank.health<=UI(T_LotM)', 'tank'},
		{'Light of the Martyr', '!player&tank2.health<=UI(T_LotM)', 'tank2'},
		{'Light of the Martyr', '!player&lowestpredicted.health<=UI(L_LotM)', 'lowestpredicted'},
	}, 'player.health>=40'},
	
	{'Holy Shock', 'tank.health<=UI(T_HS)', 'tank'},
	{'Holy Shock', 'tank2.health<=UI(T_HS)', 'tank2'},
	{'Holy Shock', 'lowestpredicted.health<=UI(L_HS)', 'lowestpredicted'},
	{'Holy Shock', 'mouseover.health<=UI(L_HS)&!mouseover.enemy', 'mouseover'},
	
	{'Flash of Light', 'lbuff(200654).health<=UI(L_FoL)', 'lbuff(200654)'},
	
	{'Flash of Light', 'tank.health<=UI(T_FoL)', 'tank'},
	{'Flash of Light', 'tank2.health<=UI(T_FoL)', 'tank2'},
	{'!Flash of Light', 'lowestpredicted.health<=UI(L_FoL)&player.casting(Holy Light)&player.casting.percent<=50', 'lowestpredicted'},
	{'Flash of Light', 'lowestpredicted.health<=UI(L_FoL)', 'lowestpredicted'},
	{'Flash of Light', 'mouseover.health<=UI(L_FoL)&!mouseover.enemy', 'mouseover'},
	
	{'Judgment', 'target.enemy'}, -- Keep up dmg reduction buff
	
	{'Holy Light', 'tank.health<=UI(T_HL)', 'tank'},
	{'Holy Light', 'tank2.health<=UI(T_HL)', 'tank2'},
	{'Holy Light', 'mouseover.health<=UI(L_FoL)&!mouseover.enemy', 'mouseover'},
	{'Holy Light', 'lowestpredicted.health<=UI(L_HL)', 'lowestpredicted'},
}

local emergency={
	{'!Holy Shock', '!player.casting(200652)', 'lowestpredicted'},
	{'!Flash of Light', '!player.moving&!player.casting(200652)', 'lowestpredicted'},
	{'!Light of the Martyr', '!player.casting(Flash of Light)&!player.casting(200652)', 'lowestpredicted'},
}

local cooldowns={
	-- Need to rewrite for Raid and 5 Man
	{'Lay on Hands', 'UI(LoH)&lowestpredicted.health<=UI(L_LoH)&!lowestpredicted.debuff(Forbearance).any', 'lowestpredicted'},
	{'Aura Mastery', 'UI(AM)&player.area(40,40).heal>=4'},
	{'Avenging Wrath', 'UI(AW)&player.area(35,65).heal>=4&player.spell(Holy Shock).cooldown=0'},
	{'Holy Avenger', 'UI(HA)&player.area(40,75).heal>=3&player.spell(Holy Shock).cooldown=0'},
	
	{'Blessing of Sacrifice', 'tank.health<=UI(T_BoS)', 'tank'}, 
	{'Blessing of Sacrifice', 'tank2.health<=UI(T_BoS)', 'tank2'}, 
	
	--{'#trinket2', 'player.area(40,95).heal>=3'},
}

local moving={
	{aoeHealing},
	
	{{
		{'Light of the Martyr', '!player&tank.health<=UI(T_LotM)', 'tank'},
		{'Light of the Martyr', '!player&tank2.health<=UI(T_LotM)', 'tank2'},
		{'Light of the Martyr', '!player&lowestpredicted.health<=UI(L_LotM)', 'lowestpredicted'},
	}, 'player.health>=40'},
	
	{'Holy Shock', 'tank.health<=UI(T_HS)', 'tank'},
	{'Holy Shock', 'lowestpredicted.health<=UI(L_HS)', 'lowestpredicted'},
	
	{'Judgment', 'target.enemy'},
}

local manaRestore={
	{'Holy Shock', 'lowestpredicted.health<=UI(L_HS)', 'lowestpredicted'},
	{'Holy Light', 'tank.health<=UI(T_HL)', 'tank'},
	{'Holy Light', 'tank2.health<=UI(T_HL)', 'tank2'},
	{'Holy Light', 'lowestpredicted.health<=UI(L_HL)', 'lowestpredicted'},
	
	{'Judgment', 'target.enemy'},
}

local inCombat={
	{_Zylla, 'UI(kAutoTarget)&toggle(dps)'},
	{pause, 'keybind(lalt)'},
	{topUp, 'keybind(lcontrol)'},
	{survival}, 
	{interrupts, 'target.interruptAt(35)'},
	{'%dispelall', 'toggle(disp)&spell(Cleanse).cooldown=0'},
	{cooldowns, 'toggle(cooldowns)'},
	{emergency, 'lowestpredicted.health<=UI(G_CHP)&!player.casting(200652)'},
	{tank},
	{DPS, 'toggle(dps)&target.enemy&target.infront&lowestpredicted.health>=UI(G_DPS)'},
	{moving, 'player.moving'},
	{manaRestore, 'player.mana<=UI(P_MR)'},
	{healing, '!player.moving&player.mana>=UI(P_MR)'},
	{DPS, 'toggle(dps)&target.enemy&target.infront'},
}

local outCombat={
	-- Need to prevent this while eating
	{tank},
	{topUp, 'keybind(lcontrol)'},
	
	-- Precombat
	{'Bestow Faith', 'pull_timer<=3', 'tank'},
	{'#Potion of Prolonged Power', '!player.buff&pull_timer<=2'},
	{'%dispelall', 'toggle(disp)&spell(Cleanse).cooldown=0'},
}

NeP.CR:Add(65, {
	name='[|cff'..Zylla.addonColor..'Zylla|r] Paladin - Holy',
	ic=inCombat,
	ooc=outCombat,
	gui=GUI,
	load=exeOnLoad
})