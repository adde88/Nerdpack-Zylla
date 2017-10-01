local _, Zylla = ...
local _G = _G
local NeP = _G.NeP

local function onUpdate(self,_)
	if self.time < _G.GetTime() - 2.0 then
		if self:GetAlpha() == 0 then
			self:Hide();
		else self:SetAlpha(self:GetAlpha() - 0.02);
		end
	end
end

Zylla.Overlay = _G.CreateFrame("Frame",nil,_G.ChatFrame1)
Zylla.Overlay:SetSize(_G.ChatFrame1:GetWidth(),50)
Zylla.Overlay:Hide()
Zylla.Overlay:SetScript("OnUpdate",onUpdate)
Zylla.Overlay:SetPoint("TOP",0,0)
Zylla.Overlay.text = Zylla.Overlay:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
Zylla.Overlay.text:SetAllPoints()
Zylla.Overlay.texture = Zylla.Overlay:CreateTexture()
Zylla.Overlay.texture:SetAllPoints()
Zylla.Overlay.texture:SetTexture(0,0,0,.50)
Zylla.Overlay.time = 0

function Zylla.ChatOverlay(Message, FadingTime)
	if NeP.DSL:Get('UI')(nil, 'chat') then
		Zylla.Overlay:SetSize(_G.ChatFrame1:GetWidth(),50)
		Zylla.Overlay.text:SetText(Message)
		Zylla.Overlay:SetAlpha(1)
		if FadingTime == nil or type(FadingTime) ~= "number" then
			Zylla.Overlay.time = _G.GetTime()
		else
			Zylla.Overlay.time = _G.GetTime() - 2 + FadingTime
		end
		Zylla.Overlay:Show()
	end
end
