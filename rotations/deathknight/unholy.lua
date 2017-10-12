local _, Zylla = ...
local unpack = _G.unpack
local NeP = _G.NeP
local Mythic_Plus = _G.Mythic_Plus

local GUI = {
	unpack(Zylla.Logo_GUI),
	-- Header
	{type = 'header',  	size = 16, text = 'Keybinds', align = 'center'},
	{type = 'checkbox',	text = 'Left Shift: '..Zylla.ClassColor..'Pause|r',	align = 'left',	key = 'lshift', 	default = false},
	{type = 'checkbox',	text = 'Left Ctrl: '..Zylla.ClassColor..'DnD/Defile|r', align = 'left', key = 'lcontrol',	default = false},
	{type = 'checkbox',	text = 'Left Alt: '..Zylla.ClassColor..'|r', align = 'left', key = 'lalt',	default = false},
	{type = 'checkbox',	text = 'Right Alt: '..Zylla.ClassColor..'|r', align = 'left', key = 'ralt', default = false},
	{type = 'spacer'},
--{type = 'checkbox', text = 'Enable Chatoverlay', 															key = 'chat', 				width = 55, 			default = true, desc = Zylla.ClassColor..'This will enable some messages as an overlay!|r'},
	unpack(Zylla.PayPal_GUI),
	{type = 'spacer'},
	unpack(Zylla.PayPal_IMG),
	{type = 'ruler'}, {type = 'spacer'},
	-- Settings
	{type = 'header', 	size = 16, text = 'Settings',	align = 'center',	size = 16},
	{type = 'checkbox', 	text = 'Use Death Grip as backup Interrupt', key = 'DGInt', default = false},
	{type = 'checkbox', 	text = 'Wraithwalk out of Root', key = 'wraithroot', default = false},
	{type = 'checkspin', 	text = 'DnD/Defile on Target w/ # Enemies', key = 'dndtarget', spin = 2, step = 1, shiftStep = 1, max = 10, min = 1, check = true},
	{type = 'checkspin', 	text = 'DnD/Defile on Player w/ # Enemies', key = 'dndplayer', spin = 2, step = 1, shiftStep = 1, max = 10, min = 1, check = false},
		-- Cooldowns
	{type = 'header', 	size = 16, text = 'Cooldowns',	align = 'center',	size = 16},
	{type = 'checkspin',	text = 'Apocalypse', key = 'apoc',	spin = 6, step = 1, shiftStep = 1, max = 8, min = 1, check = true},
	{type = 'checkspin',	text = 'Army of the Dead', key = 'aotd',	spin = 20, step = 5, shiftStep = 1, max = 180, min = 0, check = true},
	{type = 'checkbox',	text = 'Blighted Rune Weapon', align = 'left', key = 'brw', default = true},
	{type = 'checkspin',	text = 'Dark Arbiter', key = 'darb', spin = 20, step = 5, shiftStep = 1, max = 180, min = 0, check = true},
	{type = 'checkbox',	text = 'Dark Transformation', align = 'left', key = 'dtran', default = true},
	{type = 'checkspin',	text = 'Summon Gargoyle', key = 'garg',	spin = 20, step = 5, shiftStep = 1, max = 180, min = 0, check = true},
	{type = 'checkbox',	text = 'Trinket 1',	align = 'left', key = 'trinket1', default = false},
	{type = 'checkbox',	text = 'Trinket 2',	align = 'left', key = 'trinket2', default = false},
	{type = 'ruler'}, {type = 'spacer'},

	-- Survival
	{type = 'header', 		size = 16, text = 'Survival',	align = 'center',	size = 16},
	{type = 'checkbox',		text = 'Anti-Magic Shell',	align = 'left', key = 'ams', default = false},
	{type = 'checkspin', 	text = 'Icebound Fortitude',	key = 'IwF', spin = 30, step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',	text = 'Healthstone', 	key = 'HS', spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'checkspin',	text = 'Ancient Healing Potion', key = 'AHP', spin = 45, step = 5, shiftStep = 10, max = 100, min = 1, check = false},
	{type = 'spinner', 		text = 'Death Strike', 	key = 'ds', 	default_spin = 35},
	{type = 'ruler'}, {type = 'spacer'},
	unpack(Zylla.Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDEATH KNIGHT |cffADFF2FUnholy|r')
	print('|cffADFF2F --- |rRecommended Talents: 3211x11')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})
end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(lshift)'},
	{'!Death and Decay', 'keybind(lalt)&UI(lalt)', 'cursor.ground'},
}

local Survival = {
	{'Death Strike', 'player.health <= 75 & player.buff(Dark Succor)', 'target'},
	{'Death Strike', 'player.health <= UI(ds) & player.runicpower > = 45', 'target'},
	{'Icebound Fortitude', 'UI(IF_check)&health<=(IF_spin)&{{incdmg(2.5)>health.max*0.50}||state(stun)}'},
	{'Anti-Magic Shell', 'incdmg(2.5).magic>health.max*0.70 & UI(ams)'},
	{'Wraith Walk', 'state(root) & UI(wraithroot)'},
	{'#152615', 'item(152615).usable&item(152615).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 													--XXX: Astral Healing Potion
	{'#127834', 'item(152615).count==0&item(127834).usable&item(127834).count>0&health<=UI(AHP_spin)&UI(AHP_check)'}, 		--XXX: Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&health<=UI(HS_spin)&UI(HS_check)'},
}

local Interrupts = {
	{'!Mind Freeze', 'inFront&range<=15'},
	{'!Asphyxiate', 'range<=30&inFront&spell(Mind Freeze).cooldown>=gcd&!player.lastgcd(Mind Freeze)'},
	{'!Death Grip', 'UI(DGInt)&range<=30&inFront&spell(Mind Freeze).cooldown>=gcd&spell(Asphyxiate).cooldown>=gcd'},
	{'!Arcane Torrent', 'inMelee&spell(Mind Freeze).cooldown>=gcd&!player.lastgcd(Mind Freeze)'},
}

local Cooldowns = {
	{'Blood Fury'},
	{'Berserking'},
	{'Army of the Dead', 'toggle(cooldowns) & UI(aotd_check) & ttd > UI(aotd_spin)'},
	{'Blighted Rune Weapon', 'runes <= 3 & UI(brw)', 'target'},
	{'#trinket1', 'UI(trinket1)'},
	{'#trinket2', 'UI(trinket2)'},
}

local xCombat = {
	{'/startattack', '!isattacking & target.enemy'},
	{'Arcane Torrent', 'player.deficit > 20'},
	{'Outbreak', 'debuff(Virulent Plague).duration <= 2', 'target'},
}

local dark_transformation = {
	{'Dark Transformation', 'equipped(137075) & player.spell(Dark Arbiter).cooldown > 165', 'target'},
	{'Dark Transformation', 'equipped(137075) & !talent(6,1) & player.spell(Dark Arbiter).cooldown > 55', 'target'},
	{'Dark Transformation', 'equipped(137075) & talent(6,1) & player.spell(Dark Arbiter).cooldown > 35', 'target'},
	{'Dark Transformation', 'equipped(137075) & ttd < player.spell(Dark Arbiter).cooldown - 8', 'target'},

	{'Dark Transformation', 'equipped(137075) & player.spell(Summon Gargoyle).cooldown > 160 & UI(dtran)', 'target'},
	{'Dark Transformation', 'equipped(137075) & !talent(6,1) & player.spell(Summon Gargoyle).cooldown > 55 & UI(dtran)', 'target'},
	{'Dark Transformation', 'equipped(137075) & talent(6,1) & player.spell(Summon Gargoyle).cooldown > 35 & UI(dtran)', 'target'},
	{'Dark Transformation', 'equipped(137075) & ttd < player.spell(Summon Gargoyle).cooldown - 8', 'target'},
	{'Dark Transformation', '!equipped(137075) & player.runes <= 3 & UI(dtran)', 'target'},
}

local aoe = {
	--actions.aoe=death_and_decay,if=spell_targets.death_and_decay>=2
	{'Death and Decay', 'target.area(10).enemies >= UI(dndtarget_spin) & UI(dndtarget_check)', 'target.ground'},
	{'Death and Decay', 'player.area(10).enemies >= UI(dndplayer_spin) & UI(dndplayer_check)', 'player.ground'},
	--actions.aoe+=/epidemic,if=spell_targets.epidemic>4
	{'Epidemic', 'count(Virulent Plague).enemies.debuffs > 4'},
	--actions.aoe+=/scourge_strike,if=spell_targets.scourge_strike>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
	{'Scourge Strike', 'area(10).enemies >= 2 & { player.buff(Death and Decay) || player.buff(Defile) }', 'target'},
	--actions.aoe+=/clawing_shadows,if=spell_targets.clawing_shadows>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
	{'Clawing Shadows', 'area(10).enemies >= 2 & { player.buff(Death and Decay) || player.buff(Defile) }', 'target'},
	--actions.aoe+=/epidemic,if=spell_targets.epidemic>2
	{'Epidemic', 'count(Virulent Plague).enemies.debuffs > 2'},
}

local generic = {

	--actions.generic=dark_arbiter,if=!equipped.137075&runic_power.deficit<30
	{'Dark Arbiter', 'toggle(cooldowns) & !equipped(137075) & deficit < 30 & UI(darb_check) & ttd > UI(darb_spin)', 'target'},
	--actions.generic+=/apocalypse,if=equipped.137075&debuff.festering_wound.stack>=6&talent.dark_arbiter.enabled
	{'Apocalypse', 'equipped(137075) & UI(apoc_check) & debuff(Festering Wound).count >= UI(apoc_spin) & talent(7,1) ', 'target'},
	--actions.generic+=/dark_arbiter,if=equipped.137075&runic_power.deficit<30&cooldown.dark_transformation.remains<2
	{'Dark Arbiter', 'toggle(cooldowns) & equipped(137075) & deficit < 30 & player.spell(Dark Transformation).cooldown < 2 & UI(darb_check) & ttd > UI(darb_spin)', 'target'},
	--actions.generic+=/summon_gargoyle,if=!equipped.137075,if=rune<=3
	{'Summon Gargoyle', 'toggle(cooldowns) & !equipped(137075) & runes <= 3  & UI(garg_check) & ttd > UI(garg_spin)', 'target'},
	--actions.generic+=/chains_of_ice,if=buff.unholy_strength.up&buff.cold_heart.stack>19
	{'Chains of Ice', 'player.buff(Unholy Strength) & player.buff(Cold Heart).count > 19', 'target'},
	--actions.generic+=/summon_gargoyle,if=equipped.137075&cooldown.dark_transformation.remains<10&rune<=3
	{'Summon Gargoyle', 'toggle(cooldowns) & equipped(137075) & player.spell(Dark Transformation).cooldown < 10 & runes <= 3  & UI(garg_check) & ttd > UI(garg_spin)', 'target'},
	--actions.generic+=/soul_reaper,if=debuff.festering_wound.stack>=6&cooldown.apocalypse.remains<4
	{'Soul Reaper', 'debuff(Festering Wound).count >= 6 & player.spell(Apocalypse).cooldown < 4', 'target'},
	--actions.generic+=/apocalypse,if=debuff.festering_wound.stack>=6
	{'Apocalypse', 'toggle(cooldowns) & UI(apoc_check) & debuff(Festering Wound).count >= UI(apoc_spin)', 'target'},
	--actions.generic+=/death_coil,if=runic_power.deficit<10
	{'Death Coil', 'player.deficit < 10', 'target'},
	--actions.generic+=/death_coil,if=!talent.dark_arbiter.enabled&buff.sudden_doom.up&!buff.necrosis.up&rune<=3
	{'Death Coil', '!talent(7,1) & player.buff(Sudden Doom) & !player.buff(Necrosis) & runes <= 3', 'target'},
	--actions.generic+=/death_coil,if=talent.dark_arbiter.enabled&buff.sudden_doom.up&cooldown.dark_arbiter.remains>5&rune<=3
	{'Death Coil', 'talent(7,1) & player.buff(Sudden Doom) & { player.spell(Dark Arbiter).cooldown > 5 & toggle(cooldowns) || !toggle(cooldowns) } & runes <= 3', 'target'},
	--actions.generic+=/festering_strike,if=debuff.festering_wound.stack<6&cooldown.apocalypse.remains<=6
	{'Festering Strike', 'debuff(Festering Wound).count < 6 & player.spell(Apocalypse).cooldown <= 6', 'target'},
	--actions.generic+=/soul_reaper,if=debuff.festering_wound.stack>=3
	{'Soul Reaper', 'debuff(Festering Wound).count >= 3', 'target'},
	--actions.generic+=/festering_strike,if=debuff.soul_reaper.up&!debuff.festering_wound.up
	{'Festering Strike', 'debuff(Soul Reaper) & !debuff(Festering Wound)', 'target'},
	--actions.generic+=/scourge_strike,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1
	{'Scourge Strike', 'debuff(Soul Reaper) & debuff(Festering Wound).count >= 1', 'target'},
	--actions.generic+=/clawing_shadows,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1
	{'Clawing Shadows', 'debuff(Soul Reaper) & debuff(Festering Wound).count >= 1', 'target'},
	--actions.generic+=/defile
	{'Defile', 'UI(dndtarget_check)', 'target.ground'},
	{'Defile', 'UI(dndplayer_check)', 'player.ground'},
	--actions.generic+=/call_action_list,name=aoe,if=active_enemies>=2
	{aoe, 'toggle(aoe)'},
    	--actions.generic+=/festering_strike,if=debuff.festering_wound.stack<=2&(debuff.festering_wound.stack<=4|(buff.blighted_rune_weapon.up|talent.castigator.enabled))&runic_power.deficit>5&(runic_power.deficit>23|!talent.castigator.enabled)
        {'Festering Strike', 'debuff(Festering Wound).count <= 2 & {talent(3,2) || debuff(Festering Wound).count <= 4 || {player.buff(Blighted Rune Weapon) }} & player.deficit > 5 & {player.deficit>23 || !talent(3,2)}', 'target'},
    	--actions.generic+=/death_coil,if=!buff.necrosis.up&talent.necrosis.enabled&rune.time_to_4>gcd
    	{'Death Coil', 'talent(6,2) & !player.buff(Necrosis) & player.runes >= 3', 'target'},
	--actions.generic+=/scourge_strike,if=(buff.necrosis.react|buff.unholy_strength.react|rune>=2)&debuff.festering_wound.stack>=1&(debuff.festering_wound.stack>=3|!(talent.castigator.enabled|equipped.132448))&runic_power.deficit>9&(runic_power.deficit>23|!talent.castigator.enabled)
	{'Scourge Strike', '{player.buff(Necrosis) || player.buff(Unholy Strength) || player.runes >= 2} & debuff(Festering Wound).count >= 3 &deficit > 9', 'target'},
	--actions.generic+=/clawing_shadows,if=(buff.necrosis.react|buff.unholy_strength.react|rune>=2)&debuff.festering_wound.stack>=1&(debuff.festering_wound.stack>=3|!equipped.132448)&runic_power.deficit>9
	{'Clawing Shadows', '{player.buff(Necrosis) || player.buff(Unholy Strength) || player.runes >= 2} & debuff(Festering Wound).count >= 3 &deficit > 9', 'target'},
	--actions.generic+=/death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>10
	{'Death Coil', 'talent(6,1) & talent(7,1) & !pet.buff(Dark Transformation) & player.spell(Dark Arbiter).cooldown > 10', 'target'},
	--actions.generic+=/death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
	{'Death Coil', 'talent(6,1) & !talent(7,1) & !pet.buff(Dark Transformation)', 'target'},
	--actions.generic+=/death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>10
	{'Death Coil', 'talent(7,1) & player.spell(Dark Arbiter).cooldown > 10', 'target'},
	--actions.generic+=/death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
	{'Death Coil', '!talent(6,1) & !talent(7,1)', 'target'},
}

local valkyr = {
	--{'Dark Transformation', 'UI(dtran)'},
	--actions.valkyr=death_coil
	{'Death Coil', nil, 'target'},
	--actions.valkyr+=/apocalypse,if=debuff.festering_wound.stack>=6
	{'Apocalypse', 'debuff(Festering Wound).count >= 6', 'target'},
  	--actions.valkyr+=/festering_strike,if=debuff.festering_wound.stack<6&cooldown.apocalypse.remains<3
	{'Festering Strike', 'debuff(Festering Wound).count < 5 & player.spell(Apocalypse).cooldown < 3', 'target'},
	--actions.valkyr+=/call_action_list,name=aoe,if=active_enemies>=2
	{ aoe, 'toggle(AoE)&player.area(8).enemies>2'},
  	--actions.valkyr+=/festering_strike,if=debuff.festering_wound.stack<=4
	{'Festering Strike', 'debuff(Festering Wound).count <= 4', 'target'},
	--actions.valkyr+=/scourge_strike,if=debuff.festering_wound.up
	{'Scourge Strike', 'debuff(Festering Wound)', 'target'},
	--actions.valkyr+=/clawing_shadows,if=debuff.festering_wound.up
	{'Clawing Shadows', 'debuff(Festering Wound)', 'target'},
}

local pet = {
	{'Raise Dead', '!pet.exists || pet.dead'},
}

local inCombat = {
	{pet},
	{Keybinds},
	{Survival},
	{Interrupts, 'toggle(Interrupts)&interruptAt(70)', 'target'},
	{Interrupts, 'toggle(Interrupts)&toggle(xIntRandom)&interruptAt(70)', 'enemies'},
	{xCombat},
	{Cooldowns, 'toggle(cooldowns)&inMelee&ttd>10'},
	{Mythic_Plus, 'range<=31'},
	{dark_transformation, 'UI(dtran)'},
	{valkyr, 'player.totem(Val\'kyr Battlemaiden)'},
	{generic, 'target.inFront'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(252, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Death Knight - Unholy',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = Zylla.GuiSettings,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
