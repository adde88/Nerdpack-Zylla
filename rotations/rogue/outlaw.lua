local _, Zylla = ...
local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'checkbox', text = 'Auto-Target Enemies', key = 'kAutoTarget', default = true},
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rROGUE |cffFFF569Outlaw |r")
	print("|cffFFFF00 --- |rRecommended Talents: 1/1 - 2/3 - 3/1 - 4/X - 5/1 - 6/2 - 7/2")
	print("|cffFFFF00 ----------------------------------------------------------------------|r")

end

local _Zylla = {
	{"/targetenemy [noexists]", "!target.exists" },
    {"/targetenemy [dead][noharm]", "target.dead" },
}

local Interrupts = {
	{'Kick'},
}

local build = {
	--# Builders
	--{'Ghostly Strike', {'player.buff(Broadsides)', '!player.buff(Curse of the Dreadblades)', 'target.debuff(Ghostly Strike).duration<2'}},
	--{'Ghostly Strike', {'player.spell(Curse of the Dreadblades).cooldown>1', 'player.combodeficit>=1',  'target.debuff{Ghostly Strike).duration<2'}},
	{'Ghostly Strike', 'combo_points.deficit>=1&target.debuff(Ghostly Strike).duration<2'},
	--{'Pistol Shot', {'player.buff(Opportunity)', 'combo_points.deficit>= 1' }},
	{'Pistol Shot', 'player.buff(Opportunity)&combo_points<5'},
	--{'Saber Slash', 'combo_points<5'},
	{'Saber Slash', 'combo_points<5||{combo_points<=5&player.buff(Broadsides)}'},
}

local finish = {
	--# Finishers
	{'Between the Eyes', 'combo_points>=5&player.buff(Shark Infested Waters)'},
	--{'Run Through', {'combo_points>=5', '!player.talent(7,3)'}},
	{'Run Through', 'combo_points>=5'},
}

local bf = {
	--# Blade Flurry
	--{'Blade Flurry', {'player.equipped()', 'player.area(7).enemies>=2'}},
	{'Blade Flurry', 'player.area(7).enemies>3&!player.buff(Blade Flurry)'},
	{'Blade Flurry', 'player.area(7).enemies<2&player.buff(Blade Flurry)'},
}


local cds = {
	--# Cooldowns
	{'Cannonball Barrage', 'player.area(7).enemies<=3', 'target.ground'},
	{'Adrenaline Rush', 'energy.deficit>0'},
	{'Marked for Death', 'combo_points<=5&player.energy>=26'},
	{'Curse of the Dreadblades', 'combo_points.deficit>=4&{!talent(1,1)||target.debuff(Ghostly Strike)}'},
}

local xCombat = {
	--{'Roll the Bones', {'!player.talent(7,1)', '!player.buff(Broadsides)', '!player.buff(Jolly Roger)', '!player.buff(Grand Melee)', '!player.buff(Shark Infested Waters)', '!player.buff(True Bearing)', '!player.buff(Buried Treasure)', 'or', '!player.buff(Adrenaline Rush)', '!player.buff(Curse of the Dreadblades)', '!player.talent(7,1)', 'player.buff(Broadsides)', '!player.buff(Jolly Roger)', '!player.buff(Grand Melee)', '!player.buff(Shark Infested Waters)', '!player.buff(True Bearing)', '!player.buff(Buried Treasure)', 'or', '!player.buff(Adrenaline Rush)', '!player.buff(Curse of the Dreadblades)', '!player.talent(7,1)', '!player.buff(Broadsides)', 'player.buff(Jolly Roger)', '!player.buff(Grand Melee)', '!player.buff(Shark Infested Waters)', '!player.buff(True Bearing)', '!player.buff(Buried Treasure)', 'or', '!player.buff(Adrenaline Rush)', '!player.buff(Curse of the Dreadblades)', '!player.talent(7,1)', '!player.buff(Broadsides)', '!player.buff(Jolly Roger)', 'player.buff(Grand Melee)', '!player.buff(Shark Infested Waters)', '!player.buff(True Bearing)', '!player.buff(Buried Treasure)', 'or', '!player.buff(Adrenaline Rush)', '!player.buff(Curse of the Dreadblades)', '!player.talent(7,1)', '!player.buff(Broadsides)', '!player.buff(Jolly Roger)', '!player.buff(Grand Melee)', 'player.buff(Shark Infested Waters)', '!player.buff(True Bearing)', '!player.buff(Buried Treasure)', 'or', '!player.buff(Adrenaline Rush)', '!player.buff(Curse of the Dreadblades)', '!player.talent(7,1)', '!player.buff(Broadsides)', '!player.buff(Jolly Roger)', '!player.buff(Grand Melee)', '!player.buff(Shark Infested Waters)', 'player.buff(True Bearing)', '!player.buff(Buried Treasure)', 'or', '!player.buff(Adrenaline Rush)', '!player.buff(Curse of the Dreadblades)', '!player.talent(7,1)', '!player.buff(Broadsides)', '!player.buff(Jolly Roger)', '!player.buff(Grand Melee)', '!player.buff(Shark Infested Waters)', '!player.buff(True Bearing)', 'player.buff(Buried Treasure)'}},
	--{'Roll the Bones', '!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&player.buff(True Bearing)&!player.buff(Buried Treasure)||!player.buff(Adrenaline Rush)&!player.buff(Curse of the Dreadblades)&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)'},
	{'Roll the Bones', {'player.combopoints>=5', '!player.talent(7,1)', '!player.buff(Broadsides)', '!player.buff(Jolly Roger)', '!player.buff(Grand Melee)', '!player.buff(Shark Infested Waters)', '!player.buff(True Bearing)', '!player.buff(Buried Treasure)'}},
	--{'Roll the Bones', 'toggle(Cooldowns)&player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown<15&!player.buff(Shark Infested Waters)||toggle(Cooldowns)&player.combopoints>=5&!player.talent(7,1)&player.spell(Curse of the Dreadblades).cooldown<15&!player.buff(Shark Infested Waters)'},
	--(This one is with the 2 buff combinations - Not sure its wrong yet) {'Roll the Bones', 'player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.talent(7,1)&player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)'},
	{'Roll the Bones', 'player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.talent(7,1)&player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)'},
	{'Roll the Bones', '!RtB'},
	{Main_rotation, 'RtB'},
	--call_action_list,name=bf
	{bf},
	--call_action_list,name=cds
	{cds, 'toggle(Cooldowns)'},
	--call_action_list,name=stealth,if=stealthed|cooldown.vanish.up|cooldown.shadowmeld.up
	--death_from_above,if=energy.time_to_max>2&!variable.ss_useable_noreroll
	--slice_and_dice,if=!variable.ss_useable&buff.slice_and_dice.remains<target.time_to_die&buff.slice_and_dice.remains<(1+combo_points)*1.8
	--roll_the_bones,if=!variable.ss_useable&buff.roll_the_bones.remains<target.time_to_die&(buff.roll_the_bones.remains<=3|variable.rtb_reroll)
	--killing_spree,if=energy.time_to_max>5|energy<15
	--call_action_list,name=build
	{build},
	--call_action_list,name=finish,if=!variable.ss_useable
	{finish},
	--gouge,if=talent.dirty_tricks.enabled&combo_points.deficit>=1

}

local Survival ={
	{'Crimson Vial', 'player.health<=60'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(lalt)'},
}


local inCombat = {
	{_Zylla, 'UI(kAutoTarget)'},
	{Keybinds},
	{Interrupts, 'target.interruptAt(46)&toggle(Interrupts)&target.infront&target.range<8'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<8&target.infront'},
}

local outCombat = {
	{'Stealth', '!player.buff(Stealth)'},
	{'Ambush', 'target.range<5&target.infront&player.buff(Stealth)'},
	{Keybinds},
}

NeP.CR:Add(260, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] ROGUE - Outlaw',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
