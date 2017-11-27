local _, Zylla = ...

local NeP = _G["NerdPack"]
_G.Zylla = Zylla

Zylla.NeP = NeP
Zylla.Version = '2.8'
Zylla.Branch = 'DEV'
Zylla.Name = 'NerdPack - Zylla\'s Rotations'
Zylla.Author = 'Zylla'
Zylla.addonColor = '8801C0'
Zylla.ClassColor = '|cff'..NeP.Core.ClassColor('player', 'hex')..''
Zylla.wow_ver = '7.3.2'
Zylla.nep_ver = '2'
Zylla.timer = {}
Zylla.spell_timers = {}
Zylla.isAFK = false;
Zylla.Class = select(3, _G.UnitClass("player"))
Zylla.Spec = _G.GetInspectSpecialization('player')
Zylla.DonateURL = 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=23HX4QKDAD4YG'
Zylla.GuiSettings = {title='Zylla\'s Combat Routines', width='256', height='960', color='A330C9'}
Zylla.PetMode = 0
Zylla.GuiSettings = {
  title='Zylla\'s Combat Routines',
  width='256',
  height='960',
  color='A330C9'
}

_G.C_Timer.NewTicker(1, function()
	local specid = Zylla.Spec
	if specid == 0 then
		Zylla.Spec = _G.GetInspectSpecialization('player')
	end
end)
