local _, Zylla = ...

Zylla.Blacklist = {	--TODO: Let's use this later when i find something useful for it...
--units = {"UNIT_ID", ####},
--buffs = {{name = "special_buff", count = 2}, "special_buff", ####},
--debuff = {####, ####, ####}
}

Zylla.Logo_GUI = {	--XXX: Zylla's Combat Routine Logo
	{type = 'texture', texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = -30, align = 'center'},
	{type = 'spacer'}, {type = 'spacer'}, {type = 'spacer'}, {type = 'ruler'},
}

Zylla.PayPal_IMG = {
	{type = 'texture',  texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\paypal.blp', width = 69, height = 35, y = -5,align = 'center'},
}

Zylla.PayPal_GUI = {	--XXX: Donation logo
	{type = 'button', 	text = '|cffFFFFFFDonate to Zylla\'s Project|r',	width = 155, height = 25, callback = function() Zylla.Donate() end},
}

Zylla.PaidCR_GUI = {	--XXX: For those who have purchased custom routines.
	{type = 'text', 	size = 11,	text = '|cffFFFF00Thanks for purchasing this CR!|r',	width = 175, height = 25, align = 'center'},
}

Zylla.Mythic_GUI = {	--XXX: Mythic + / Raiding
	{type = 'header', 	size = 14, text = 'Mythic+ Raid Settings', 		align = 'center'},
	{type = 'text',  		size = 10, text = 'Fel Explosives',	 					align = 'left'},
	{type = 'checkbox', text = 'Fel Explosives [Affix]', 							key = 'mythic_fel', width = 55, default = true, desc = '|cffC41F3BThis will automatically target the \'Fel Explosives\' in Mythic+ dungeons!|r'},
	{type = 'text',  		size = 10, text = 'Quaking',	 								align = 'left'},
	{type = 'checkbox', text = 'Quaking [Affix]', 										key = 'quaking', 		width = 55, default = true, desc = '|cffC41F3BThis will automatically interrupt your casts at the end of your Quaking Debuff from Mythic+ dungeons!|r'},
	{type = 'ruler'},		--XXX: Global GUI-part to be used on all combat routines.
}

Zylla.Mythic_Plus = {
	{{
			{'%target', 'id(120651)&inFront', 'enemies'},
			{'%target', 'id(121499)&inFront', 'enemies'},
	},	'UI(mythic_fel)'}, 																																						--XXX: Fel Explosives Mythic+ Affix
	{'&/stopcasting', 'debuff(Quake).any.duration<gcd&UI(quaking)', 'player'},												--XXX: Quaking Mythic+ Affix
	{'%pause', 'player.debuff(Sapped Soul)||player.debuff(Shadowmeld)||player.debuff(Ice Block)'},		--XXX: General Stuff to Pause the CR
}

Zylla.Item_KJ =	{{type = 'checkspin', text = 'Kil\'Jaeden\'s Burning Wish - Units', key = 'kj', 	align = 'left', width = 55, step = 1, shiftStep = 2, 	spin = 4,  max = 20,  min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only on selected amount of units!|r'}}
Zylla.Item_HS = {{type = 'checkspin',	text = 'Healthstone', 												key = 'HS', 	align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true}}
Zylla.Item_HP = {{type = 'checkspin',	text = 'Healing Potion', 											key = 'AHP', 	align = 'left', width = 55, step = 5, shiftStep = 10, spin = 45, max = 100, min = 1, check = true}}

Zylla.prepots = {
	{key = '1', text = 'Potion of the Old War'},
	{key = '2', text = 'Potion of Deadly Grace'},
	{key = '3', text = 'Potion of Prolonged Power'}
}

Zylla.pets = {
	{key = '1', text = 'Pet 1'},
	{key = '2', text = 'Pet 2'},
	{key = '3', text = 'Pet 3'},
	{key = '4', text = 'Pet 4'},
	{key = '5', text = 'Pet 5'}
}

Zylla.wpets = {
	{key = '1', text = 'Felhunter'},
	{key = '2', text = 'Doomguard'},
	{key = '3', text = 'Infernal'},
	{key = '4', text = 'Felguard'},
	{key = '5', text = 'Succubus'},
	{key = '6', text = 'Imp'}

}

Zylla.faketarget = {
	{key = 'target', 				text = 'Normal'},
	{key = 'lowestenemy', 	text = 'Lowest'},
	{key = 'highestenemy', 	text = 'Highest'},
	{key = 'nearestenemy', 	text = 'Nearest'},
	{key = 'furthestenemy', text = 'Furthest'}
}
