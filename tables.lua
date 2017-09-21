local _, Zylla = ...
local NeP = _G.NeP
local _G = _G

_G.Blacklist = {	--TODO: Let's use this later when i find something useful for it...
--units = {"UNIT_ID", ####},
--buffs = {{name = "special_buff", count = 2}, "special_buff", ####},
--debuff = {####, ####, ####}
}

_G.Logo_GUI = {	--XXX: Zylla's Combat Routine Logo
	{type = 'texture', texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = -30, align = 'center'},
	{type = 'spacer'}, {type = 'spacer'}, {type = 'spacer'}, {type = 'ruler'},
}

_G.PayPal_IMG = {
	{type = 'texture',  texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\paypal.blp', width = 69, height = 35, y = -5,align = 'center'},
}

_G.PayPal_GUI = {	--XXX: Donation logo
	{type = 'button', 	text = '|cffFFFFFFDonate to Zylla\'s Project|r',	width = 155, height = 25, callback = function() Zylla.Donate() end},
}

_G.PaidCR_GUI = {	--XXX: For those who have purchased custom routines.
	{type = 'text', 	text = '|cffFFFF00Thanks for purchasing this CR!|r',	width = 175, height = 25, align = 'center'},
}

_G.Mythic_GUI = {	--XXX: Mythic + / Raiding
	{type = 'header', 	size = 14, text = 'Mythic+ Raid Settings', 		align = 'center'},
	{type = 'text',  		size = 10, text = 'Fel Explosives',	 					align = 'left'},
	{type = 'checkbox', text = 'Fel Explosives [Affix]', 							key = 'mythic_fel', width = 55, default = true, desc = '|cffC41F3BThis will automatically target the \'Fel Explosives\' in Mythic+ dungeons!|r'},
	{type = 'text',  		size = 10, text = 'Quaking',	 								align = 'left'},
	{type = 'checkbox', text = 'Quaking [Affix]', 										key = 'quaking', 		width = 55, default = true, desc = '|cffC41F3BThis will automatically interrupt your casts at the end of your Quaking Debuff from Mythic+ dungeons!|r'},
	{type = 'ruler'},		--XXX: Global GUI-part to be used on all combat routines.
}

_G.Mythic_Plus = {
	{{
			{"/target 'Fel Explosives'", 'id(120651)&inFront', 'enemies'},
			{"/target 'Fel Surge Totem'", 'id(121499)&inFront', 'enemies'},
	},	'UI(mythic_fel)'}, 																																				--XXX: Fel Explosives Mythic+ Affix
	{'!/stopcasting','debuff(Quake).any.duration<gcd&debuff(Quake).any&UI(quaking)', 'player'},		--XXX: Quaking Mythic+ Affix
	{'%pause' , 'player.debuff(200904)||player.debuff(Sapped Soul)'},															--XXX: Vault of the Wardens - Sapped Soul Encounter
}

_G.KilJaedenTrinket ={
	{type = 'checkspin', 	text = 'Kil\'Jaeden\'s Burning Wish - Units', key = 'kj', align = 'left', width = 55, step = 1, spin = 4, max = 20, min = 1, check = true, desc = Zylla.ClassColor..'Legendary will be used only when selected amount of units are present!|r'},
}
