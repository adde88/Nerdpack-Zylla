local _, Zylla = ...

local NeP = Zylla.NeP

--XXX: Splash logo for the combat-routine
local Splash_Frame = _G.CreateFrame("Frame", "Zylla_SPLASH", _G.UIParent)

Splash_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 }
});

Splash_Frame:SetBackdropColor(0,0,0,1);
Splash_Frame:Hide()

local texture = Splash_Frame:CreateTexture()
texture:SetPoint("LEFT",-4,0)
texture:SetSize(100,100)

local text = Splash_Frame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");
text:SetPoint("RIGHT",-4,0)

local callTime = 0

_G.C_Timer.NewTicker(0.01, (function()
	if Splash_Frame:IsShown() then
		if _G.GetTime()-callTime>=5 then
			local Alpha = Splash_Frame:GetAlpha()
			Splash_Frame:SetAlpha(Alpha-.01)
			if Alpha<=0 then
				Splash_Frame:Hide()
				Splash_Frame:SetAlpha(1)
			end
		end
	end
end), nil)

local AddonInfo = '|cff'..Zylla.addonColor..Zylla.Name

function Zylla.Splash()
	Splash_Frame:SetAlpha(1)
	Splash_Frame:Show()
	_G.PlaySound(124, "SFX");
	local color = NeP.Core.ClassColor('player', 'hex')
	local currentSpec = _G.GetSpecialization()
	local _, SpecName, _, icon, _ = _G.GetSpecializationInfo(currentSpec)
	local class = _G.UnitClass('player')
	texture:SetTexture(icon)
	text:SetText(AddonInfo..'\n|cff'..color..class..' - '..SpecName..' \n|cffD11E0E--- Version: '..Zylla.Version..' ---\n|cff0e89d1'..Zylla.Branch..'')
	callTime = _G.GetTime()
	local Width = text:GetStringWidth()+texture:GetWidth()+8
	Splash_Frame:SetSize(Width,100)
	Splash_Frame:SetPoint("CENTER",0,335	)
end
