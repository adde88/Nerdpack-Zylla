local _G = _G
local CreateFrame = _G.CreateFrame
local GetSetting = _G.GetSetting
local FireHack = _G.FireHack
local SetSetting = _G.SetSetting
local SetHackEnabled = _G.SetHackEnabled
local Hacks = _G.Hacks
local IsHackEnabled = _G.IsHackEnabled
local FireHack_Print = _G.FireHack_Print

CreateFrame("Frame"):SetScript("OnUpdate",
   function ()
      if not _G.Once then
         _G.Once = true;

         FireHack = CreateFrame("Frame", "FireHack");
         FireHack:ClearAllPoints();

         local Backdrop = {
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            tileSize = 32,
            edgeFile = "Interface\\FriendsFrame\\UI-Toast-Border",
            tile = 1,
            edgeSize = 7,
            insets = {
               top = 2,
               right = 2,
               left = 3,
               bottom = 3,
            },
         };

         FireHack:SetBackdrop(Backdrop);
         FireHack:SetHeight(348);
         FireHack:SetWidth(210);
         FireHack:SetFrameStrata("HIGH");
         FireHack:SetMovable(true);

         local AnchorPoint = GetSetting("UIAnchorPoint");
         local X = GetSetting("UIX");
         local Y = GetSetting("UIY");
         FireHack:SetPoint(AnchorPoint ~= "" and AnchorPoint or "CENTER", X ~= "" and tonumber(X) or -200, Y ~= "" and tonumber(Y) or 100);

         FireHack:SetScript("OnShow", function () SetSetting("UIVisible", "true"); end);
         FireHack:SetScript("OnHide", function () SetSetting("UIVisible", "false"); end);

         if GetSetting("UIVisible") == "false" then
            FireHack:Hide();
         end

         local TitleBar = CreateFrame("Frame", nil, FireHack);
         TitleBar:SetPoint("TOPLEFT", 1, -1);
         TitleBar:SetPoint("TOPRIGHT", -2, -1);
         TitleBar:SetHeight(16);

         Backdrop.edgeSize = 2;
         Backdrop.insets.bottom = 1;
         TitleBar:SetBackdrop(Backdrop);
         TitleBar:SetBackdropColor(0, 0, 0, 1);

         TitleBar:SetScript("OnMouseUp",
            function ()
               FireHack:StopMovingOrSizing();

               local Point, RelativeTo, RelativePoint, X, Y = FireHack:GetPoint();
               SetSetting("UIAnchorPoint", Point);
               SetSetting("UIX", X);
               SetSetting("UIY", Y);
            end
         );
         TitleBar:SetScript("OnMouseDown", function () FireHack:StartMoving(); end);

         local TitleBarText = TitleBar:CreateFontString();
         TitleBarText:SetAllPoints(TitleBar);
         TitleBarText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE");
         TitleBarText:SetText("FireHack");
         TitleBarText:SetJustifyH("CENTER");

         local CloseButton = CreateFrame("Button", nil, TitleBar, "UIPanelCloseButton");
         CloseButton:SetPoint("TOPRIGHT", 1, 1);
         CloseButton:SetHeight(18);
         CloseButton:SetWidth(18);
         CloseButton:SetScript("OnClick", function () FireHack:Hide(); end);

         local AddedCount = 0;
         local function AddOption (Name, OnChange)
            local CheckBox = CreateFrame("CheckButton", nil, FireHack, "ChatConfigSmallCheckButtonTemplate");
            CheckBox:SetPoint("TOPLEFT", AddedCount % 2 == 0 and 8 or 100, -21 - math.floor(AddedCount / 2) * 25);
            CheckBox:SetScript("PostClick", OnChange);

            local Label = FireHack:CreateFontString(nil, "HIGH", "GameFontNormal");
            Label:SetAllPoints();
            Label:SetFont("Fonts\\ARIALN.TTF", 11, "OUTLINE");
            Label:SetJustifyH("LEFT");
            Label:SetText(Name);
            Label:SetPoint("TOPLEFT", AddedCount % 2 == 0 and 30 or 122, 287 - math.floor(AddedCount / 2) * 50);

            AddedCount = AddedCount + 1;
            return CheckBox;
         end

         local function AddSectionDivider (Name)
            local Label = FireHack:CreateFontString(nil, "HIGH");
            Label:SetAllPoints();
            Label:SetFont("Fonts\\ARIALN.TTF", 11, "OUTLINE");
            Label:SetJustifyH("CENTER");
            Label:SetText(Name);
            Label:SetPoint("TOPLEFT", 0, 287 - math.ceil(AddedCount / 2) * 50);
            Label:SetPoint("TOPRIGHT", 0, 287 - math.ceil(AddedCount / 2) * 50);

            AddedCount = AddedCount + (AddedCount % 2 == 0 and 2 or 3);
            return Label;
         end

         local CheckBoxes = {};

         CheckBoxes[Hacks.NoAutoAway] = AddOption("No Auto Away", function (CheckBox) SetHackEnabled(Hacks.NoAutoAway, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.Zoom] = AddOption("Zoom", function (CheckBox) SetHackEnabled(Hacks.Zoom, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.MovingLoot] = AddOption("Moving Loot", function (CheckBox) SetHackEnabled(Hacks.MovingLoot, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.MountedLoot] = AddOption("Mounted Loot", function (CheckBox) SetHackEnabled(Hacks.MountedLoot, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.Fly] = AddOption("Fly"  , function (CheckBox) SetHackEnabled(Hacks.Fly, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.Hover] = AddOption("Hover", function (CheckBox) SetHackEnabled(Hacks.Hover, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.Climb] = AddOption("Climb", function (CheckBox) SetHackEnabled(Hacks.Climb, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.WaterWalk] = AddOption("Water Walk", function (CheckBox) SetHackEnabled(Hacks.WaterWalk, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.MultiJump] = AddOption("Multi Jump", function (CheckBox) SetHackEnabled(Hacks.MultiJump, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.NoKnockback] = AddOption("No Knockback", function (CheckBox) SetHackEnabled(Hacks.NoKnockback, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.MovingCast] = AddOption("Moving Cast", function (CheckBox) SetHackEnabled(Hacks.MovingCast, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.AlwaysFacing] = AddOption("Always Facing", function (CheckBox) SetHackEnabled(Hacks.AlwaysFacing, CheckBox:GetChecked()); end);

         AddSectionDivider("Collision");
         CheckBoxes[Hacks.M2Collision] = AddOption("M2", function (CheckBox) SetHackEnabled(Hacks.M2Collision, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.WMOCollision] = AddOption("WMO", function (CheckBox) SetHackEnabled(Hacks.WMOCollision, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.TerrainCollision] = AddOption("Terrain", function (CheckBox) SetHackEnabled(Hacks.TerrainCollision, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.NoSwim] = AddOption("No Swim", function (CheckBox) SetHackEnabled(Hacks.NoSwim, CheckBox:GetChecked()); end);

         AddSectionDivider("Rendering");
         CheckBoxes[Hacks.M2Rendering] = AddOption("M2", function (CheckBox) SetHackEnabled(Hacks.M2Rendering, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.WMORendering] = AddOption("WMO", function (CheckBox) SetHackEnabled(Hacks.WMORendering, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.TerrainRendering] = AddOption("Terrain", function (CheckBox) SetHackEnabled(Hacks.TerrainRendering, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.LiquidRendering] = AddOption("Liquid", function (CheckBox) SetHackEnabled(Hacks.LiquidRendering, CheckBox:GetChecked()); end);
         CheckBoxes[Hacks.CollisionRendering] = AddOption("Collision", function (CheckBox) SetHackEnabled(Hacks.CollisionRendering, CheckBox:GetChecked()); end);

         for Hack, CheckBox in pairs(CheckBoxes) do
            CheckBox:SetChecked(IsHackEnabled(Hack));
         end

         local SetHackEnabled_Original = SetHackEnabled;
         function SetHackEnabled (Hack, Enabled)
            SetHackEnabled_Original(Hack, Enabled);

            local CheckBox = CheckBoxes[Hack];
            if CheckBox then
               CheckBox:SetChecked(Enabled);
            end
         end

         _G.SLASH_FH1 = "/fh";
         _G.SlashCmdList["FH"] = function (Message, EditBox)
            local Show = nil;
            local Lower = Message:lower();
            if Lower == "show" then
               if FireHack:IsVisible() then
                  return FireHack_Print("The user interface is already shown.");
               else
                  Show = true;
               end
            elseif Lower == "hide" then
               if FireHack:IsVisible() then
                  Show = false;
               else
                  return FireHack_Print("The user interface is already hidden.");
               end
            elseif Lower == "" then
               Show = not FireHack:IsVisible();
            else
               return FireHack_Print("Unknown option: " .. Message);
            end

            if Show then
               FireHack:Show();
            else
               FireHack:Hide();
            end
         end
      end
   end
);
