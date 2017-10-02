local _, Zylla = ...
local _G = _G
local NeP = _G.NeP

Zylla.Version = '2.3'
Zylla.Branch = 'RELEASE'
Zylla.Name = 'NerdPack - Zylla\'s Rotations'
Zylla.Author = 'Zylla'
Zylla.addonColor = '8801C0'
Zylla.ClassColor = '|cff'..NeP.Core:ClassColor('player', 'hex')..''
Zylla.wow_ver = '7.3.0'
Zylla.nep_ver = '1.11'
Zylla.spell_timers = {}
Zylla.isAFK = false;
Zylla.Class = select(3,_G.UnitClass("player"))
Zylla.timer = {}
Zylla.DonateURL = 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=23HX4QKDAD4YG'

--XXX: Lets try going global.
--TODO: Just testing speed improvement stuff.
Zylla = _G.Zylla

local Parse = NeP.DSL.Parse
local Zframe = _G.CreateFrame('GameTooltip', 'Zylla_ScanningTooltip', _G.UIParent, 'GameTooltipTemplate')

function Zylla.timer:useTimer(timerName, interval)
	 if self[timerName] == nil then self[timerName] = 0 end
	 if _G.GetTime()-self[timerName] >= interval then
		  self[timerName] = _G.GetTime()
		  return true
	 else
		  return false
	 end
end

function Zylla.onFlagChange()	--XXX: Toggles off the CR if the player becomes AFK. And toggle back on when player is un-AFKed.
  if (_G.UnitIsAFK("player") and not Zylla.isAFK) then	--XXX: Player has become AFK
	 if (_G.C_PetBattles.IsInBattle()==false) then
		--XXX: Contains the stuff to be executed when the player is flagged as AFK
		NeP.Interface:toggleToggle('mastertoggle')
	 end
	 _G.DEFAULT_CHAT_FRAME:AddMessage("|cffC41F3BPlayer is AFK! Stopping Zylla's Combat Routine.|r");
	 Zylla.isAFK = true;
  elseif (not _G.UnitIsAFK("player") and Zylla.isAFK) then	--XXX: Player has been flagged un-AFK
	 --XXX: Contains the stuff to be executed when the player is flagged as NOT AFK
	 NeP.Interface:toggleToggle('mastertoggle')
	 _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFFFB2FPlayer is unAFK! Restarting Zylla's Combat Routine.|r")
	 Zylla.isAFK = false;
  -- else
  --XXX: Player's flag change concerned DND, not becoming AFK or un-AFK
  end
end

function Zylla.AFKCheck()
  local frame = _G.CreateFrame("FRAME", "AfkFrame");
  frame:RegisterEvent("PLAYER_FLAGS_CHANGED"); --XXX: "PLAYER_FLAGS_CHANGED" This will trigger when the player becomes unAFK and unDND
  frame:SetScript("OnEvent", Zylla.onFlagChange);
end

Zylla.GuiSettings = {
  title='Zylla\'s Combat Routines',
  width='256',
  height='960',
  color='A330C9'
}

function Zylla.ExeOnLoad()
  print('|cffFFFB2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Thank you for selecting Zylla\'s Combat Routines for NerdPack!|r')
  print('|cffFFFB2F Some routines require tweaking the settings to perform optimal.|r')
  print('|cffFFFB2F If you encounter errors, bugs, or you simply have a suggestion,|r')
  print('|cffFFFB2F i recommend that you visit the GitHub repo.|r')
  print('|cffFFFB2F You can also get support from the NerdPack community on Discord.|r')
  print('|cffFFFB2F ----------------------------------------------------------------------|r')

	Zylla.Splash() --XXX: Call the Splash-screen on all CR's...

end

function Zylla.ExeOnUnload()
  print('|cffFFFB2F Thank you for using Zylla\'s Combat Routines.|r')
end

function Zylla.Donate()
	_G.OpenURL(Zylla.DonateURL)
end

function Zylla.Round(num, idp)
  if num then
	 local mult = 10^(idp or 0)
	 return math.floor(num * mult + 0.5) / mult
  else
	 return 0
  end
end

function Zylla.ShortNumber(number)
  local affixes = { "", "k", "m", "b", }
  local affix = 1
  local dec = 0
  local num1 = math.abs(number)
  while num1 >= 1000 and affix < #affixes do
	 num1 = num1 / 1000
	 affix = affix + 1
  end
  if affix > 1 then
	 dec = 2
	 local num2 = num1
	 while num2 >= 10 do
		num2 = num2 / 10
		dec = dec - 1
	 end
  end
  if number < 0 then
	 num1 = - num1
  end
  return string.format("%."..dec.."f"..affixes[affix], num1)
end

--XXX: Auto Dotting

function Zylla.AutoDoT(debuff,spellx)
  for _, Obj in pairs(NeP.OM:Get('Enemy')) do
	 if _G.UnitExists(Obj.key) then
		if (NeP.DSL:Get('combat')(Obj.key) or Obj.isdummy) then
		  local objRange = NeP.DSL:Get('range')(Obj.key)
		  local _,_,_, cast_time_ms, minRange, maxRange = _G.GetSpellInfo(spellx)
		  local cast_time_sec = cast_time_ms / 1000
		  if maxRange == 0 then maxRange = 5 end
		  --print('spell: '..spellx..' skill range: '..minRange..', '..maxRange..' obj range: '..objRange)
		  if (NeP.DSL:Get('infront')(Obj.key) and objRange >= minRange and objRange <= maxRange) then
			 local Travel_Times = Zylla.Round((NeP.DSL:Get('travel_time')(Obj.key, spellx)), 3)
			 local _, _, _, lagWorld = _G.GetNetStats()
			 local latency = ((((lagWorld / 1000) * 1.1) + (Travel_Times * 1.25)))
			 local debuffDuration = NeP.DSL:Get('debuff.duration')(Obj.key, debuff)
			 if (debuffDuration < (NeP.DSL:Get('gcd')() + latency + cast_time_sec)) then
				--print('debuff: '..debuff..' key: '..Obj.key..' duration: '..debuffDuration)
				--print(' lag: '..(lagWorld / 1000)..' traveltime: '..Travel_Times..' latency: '..latency)
				_G.C_Timer.After(latency, function ()
				  if (debuffDuration < (NeP.DSL:Get('gcd')() + cast_time_sec)) then
					 --print('/run CastSpellByName("'..spellx..'","'..Obj.key..'")')
					 _G.RunMacroText('/run CastSpellByName("'..spellx..'","'..Obj.key..'")')
					 --NeP:Queue(debuff, Obj.key)
					 return true
				  end
				end)
			 end
		  end
		end
	 end
  end
end

function Zylla.AutoDoT2(debuff)
	for _, Obj in pairs(NeP.OM:Get('Enemy')) do
		if _G.UnitExists(Obj.key) then
			if (NeP.DSL:Get('combat')(Obj.key) or Obj.isdummy) then
				local objRange = NeP.DSL:Get('range')(Obj.key)
				local _,_,_,_, minRange, maxRange = _G.GetSpellInfo(debuff)
				if (NeP.DSL:Get('infront')(Obj.key) and objRange >= minRange and objRange <= maxRange) then
					if (NeP.DSL:Get('debuff.duration')(Obj.key, debuff) < NeP.DSL:Get('gcd')()) then
						local _, _, _, lagWorld = _G.GetNetStats()
						local latency = lagWorld / 1000
						_G.C_Timer.After(latency, function ()
							if (NeP.DSL:Get('debuff.duration')(Obj.key, debuff) < NeP.DSL:Get('gcd')()) then
								_G.RunMacroText('/run CastSpellByName("'..debuff..'","'..Obj.key..'")')
								--NeP:Queue(debuff, Obj.key)
								return true
							end
						end)
					end
				end
			end
		end
	end
end

--XXX: Tooltips

--/dump Zylla.Scan_SpellCost('Rake')
function Zylla.Scan_SpellCost(spell)
  local spellID = NeP.Core:GetSpellID(spell)
  Zframe:SetOwner(_G.UIParent, 'ANCHOR_NONE')
  Zframe:SetSpellByID(spellID)
  for i = 2, Zframe:NumLines() do
	 local tooltipText = _G['Zylla_ScanningTooltipTextLeft' .. i]:GetText()
	 if tooltipText then return tooltipText end
  end
  return false
end

--/dump Zylla.Scan_IgnorePain()
function Zylla.Scan_IgnorePain()
  for i = 1, 40 do
	 local debuff = select(11,_G.UnitBuff('player', i))
	 if debuff == 190456 then
		Zframe:SetOwner(_G.UIParent, 'ANCHOR_NONE')
		Zframe:SetUnitBuff('player', i)
		local tooltipText = _G['Zylla_ScanningTooltipTextLeft2']:GetText()
		local match = tooltipText:lower():match('of the next.-$')
		return _G.gsub(match, '%D', '') + 0
	 end
  end
  return false
end

--XXX: NeP HoT / DoT API

local function oFilter(owner, spell, spellID, caster)
  if not owner then
	 if spellID == tonumber(spell) and (caster == 'player' or caster == 'pet') then
		return false
	 end
  elseif owner == 'any' then
	 if spellID == tonumber(spell) then
		return false
	 end
  end
  return true
end

function Zylla.UnitHot(target, spell, owner)
	local name, count, caster, expires, spellID
	if tonumber(spell) then
		local go, i = true, 0
		while i <= 40 and go do
			i = i + 1
			name,_,_,count,_,_,expires,caster,_,_,spellID = _G['_G.UnitBuff'](target, i)
			go = oFilter(owner, spell, spellID, caster)
		end
	else
		name,_,_,count,_,_,expires,caster = _G['_G.UnitBuff'](target, spell)
	end
	return name, count, expires, caster	 -- This adds some random factor
end

function Zylla.UnitDot(target, spell, owner)
local name, count, caster, expires, spellID, power, duration
if tonumber(spell) then
  local go, i = true, 0
  while i <= 40 and go do
	 i = i + 1
	 name,_,_,count,_,duration,expires,caster,_,_,spellID,_,_,_,power = _G['UnitDebuff'](target, i)
	 go = oFilter(owner, spell, spellID, caster)
  end
else
  name,_,_,count,_,duration,expires,caster = _G['UnitDebuff'](target, spell)
end
return name, count, duration, expires, caster, power	 -- This adds some random factor
end

--XXX: Warrior

--/dump Zylla.getIgnorePain()
function Zylla.getIgnorePain()
	local matchTooltip = false
	local curRage = _G.UnitPower('player')
	local costs = _G.GetSpellPowerCost(190456)
	local minRage = costs[1].minCost or 20
	local maxRage = costs[1].cost or 60
	local calcRage = math.max(minRage, math.min(maxRage, curRage))
	local apBase, apPos, apNeg = _G.UnitAttackPower('player')
	local vers = 1 + ((_G.GetCombatRatingBonus(29) + _G.GetVersatilityBonus(30)) / 100)
	local scales = _G.UnitBuff('player', _G.GetSpellInfo(203581)) and 1.6 or 1
	local curHP = _G.UnitHealth('player')
	local maxHP = _G.UnitHealthMax('player')
	local misPerc = (maxHP - curHP) / maxHP
	local nevSur = select(4, _G.GetTalentInfo(5, 2, 1))
	local nevSurPerc = nevSur and (1 + 0.75 * misPerc) or 1
	local indom = select(4, _G.GetTalentInfo(5, 3, 1)) and 1.25 or 1
	local t18 = _G.UnitBuff("player", _G.GetSpellInfo(12975)) and Zylla.GetNumberSetPieces("T18") >= 4 and 2 or 1
	local curIP = select(17, _G.UnitBuff('player', _G.GetSpellInfo(190456))) or 0
	if matchTooltip then
		curIP = curIP / 0.9 --get the tooltip value instead of the absorb
	end
	local maxIP = (apBase + apPos + apNeg) * 18.6 * vers * indom * scales
	if not matchTooltip then --some TODO notes so i wont forget fix it:
		--maxIP = Zylla.Round(maxIP * 0.9) - missing dragon skin arti passive -> * trait!!! missing 0.02-0.06
		maxIP = Zylla.Round(maxIP * 1.04) -- tooltip value my test with 2/3 dragon skin
		--maxIP = Zylla.Round((maxIP * 0.9) * trait) -- need enable after got arti lib again
	end
	local newIP = Zylla.Round(maxIP * (calcRage / maxRage) * 1 * nevSurPerc * t18) --*t18 *trait instead 1
	local cap = Zylla.Round(maxIP * 3)
	if nevSur then
		cap = cap * 1.75
	end
	local diff = cap - curIP
	local castIP = math.min(diff, newIP)
	local castPerc = Zylla.Round((castIP / cap) * 100)
	local curPerc = Zylla.Round((curIP / cap) * 100)
	return cap, diff, curIP, curPerc, castIP, castPerc, maxIP, newIP, minRage, maxRage, calcRage
	--maxIP = 268634.7
end

Zylla.setsTable = {
	["DEATH KNIGHT"] = {
		["T19"] = {
		138355, --Dreadwyrm Crown
		138349, --Dreadwyrm Breastplate
		138361, --Dreadwyrm Shoulderguards
		138352, --Dreadwyrm Gauntlets
		138358, --Dreadwyrm Legplates
		138364, --Dreadwyrm Greatcloak
		},
		["T20"] = {
		147121, --Gravewarden Chestplate
		147122, --Gravewarden Cloak
		147123, --Gravewarden Handguards
		147124, --Gravewarden Visage
		147125, --Gravewarden Legplates
		147126, --Gravewarden Pauldrons
		},
	},
	["DEMON HUNTER"] = {
		["T19"] = {
		138378, --Mask of Second Sight
		138376, --Tunic of Second Sight
		138380, --Shoulderguards of Second Sight
		138377, --Gloves of Second Sight
		138379, --Legwraps of Second Sight
		138375, --Cape of Second Sight
		},
		["T20"] = {
		147127, --Demonbane Harness
		147128, --Demonbane Shroud
		147129, --Demonbane Gauntlets
		147130, --Demonbane Faceguard
		147131, --Demonbane Leggings
		147132, --Demonbane Shoulderpads
		},
	},
	["DRUID"] = {
		["T19"] = {
		138330, --Hood of the Astral Warden
		138324, --Robe of the Astral Warden
		138336, --Mantle of the Astral Warden
		138327, --Gloves of the Astral Warden
		138333, --Leggings of the Astral Warden
		138366, --Cloak of the Astral Warden
		},
		["T20"] = {
		147133, --Stormheart Tunic
		147134, --Stormheart Drape
		147135, --Stormheart Gloves
		147136, --Stormheart Headdress
		147137, --Stormheart Legguards
		147138, --Stormheart Mantle
		},
	},
	["HUNTER"] = {
		["T19"] = {
		138342, --Eagletalon Cowl
		138339, --Eagletalon Tunic
		138347, --Eagletalon Spaulders
		138340, --Eagletalon Gauntlets
		138344, --Eagletalon Legchains
		138368, --Eagletalon Cloak
		},
		["T20"] = {
		147139, --Wildstalker Chestguard
		147140, --Wildstalker Cape
		147141, --Wildstalker Gauntlets
		147142, --Wildstalker Helmet
		147143, --Wildstalker Leggings
		147144, --Wildstalker Spaulders
		},
	},
	["MAGE"] = {
		["T19"] = {
		138312, --Hood of Everburning Knowledge
		138318, --Robe of Everburning Knowledge
		138321, --Mantle of Everburning Knowledge
		138309, --Gloves of Everburning Knowledge
		138315, --Leggings of Everburning Knowledge
		138365, --Cloak of Everburning Knowledge
		},
		["T20"] = {
		147145, --Drape of the Arcane Tempest
		147146, --Gloves of the Arcane Tempest
		147147, --Crown of the Arcane Tempest
		147148, --Leggings of the Arcane Tempest
		147149, --Robes of the Arcane Tempest
		147150, --Mantle of the Arcane Tempest
		},
	},
	["MONK"] = {
		["T19"] = {
		138331, --Hood of Enveloped Dissonance
		138325, --Tunic of Enveloped Dissonance
		138337, --Pauldrons of Enveloped Dissonance
		138328, --Gloves of Enveloped Dissonance
		138334, --Leggings of Enveloped Dissonance
		138367, --Cloak of Enveloped Dissonance
		},
		["T20"] = {
		147151, --Xuen's Tunic
		147152, --Xuen's Cloak
		147153, --Xuen's Gauntlets
		147154, --Xuen's Helm
		147155, --Xuen's Legguards
		147156, --Xuen's Shoulderguards
		},
	},
	["PALADIN"] = {
		["T19"] = {
		138356, --Helmet of the Highlord
		138350, --Breastplate of the Highlord
		138362, --Pauldrons of the Highlord
		138353, --Gauntlets of the Highlord
		138359, --Legplates of the Highlord
		138369, --Greatmantle of the Highlord
		},
		["T20"] = {
		147157, --Radiant Lightbringer Breastplate
		147158, --Radiant Lightbringer Cape
		147159, --Radiant Lightbringer Gauntlets
		147160, --Radiant Lightbringer Crown
		147161, --Radiant Lightbringer Greaves
		147162, --Radiant Lightbringer Shoulderguards
		},
	},
	["PRIEST"] = {
		["T19"] = {
		138313, --Purifier's Gorget
		138319, --Purifier's Cassock
		138322, --Purifier's Mantle
		138310, --Purifier's Gloves
		138316, --Purifier's Leggings
		138370, --Purifier's Drape
		},
		["T20"] = {
		147163, --Shawl of Blind Absolution
		147164, --Gloves of Blind Absolution
		147165, --Hood of Blind Absolution
		147166, --Leggings of Blind Absolution
		147167, --Robes of Blind Absolution
		147168, --Mantle of Blind Absolution
		},
	},
	["ROGUE"] = {
		["T19"] = {
		138332, --Doomblade Cowl
		138326, --Doomblade Tunic
		138338, --Doomblade Spaulders
		138329, --Doomblade Gauntlets
		138335, --Doomblade Pants
		138371, --Doomblade Shadowwrap
		},
		["T20"] = {
		147169, --Fanged Slayer's Chestguard
		147170, --Fanged Slayer's Shroud
		147171, --Fanged Slayer's Handguards
		147172, --Fanged Slayer's Helm
		147173, --Fanged Slayer's Legguards
		147174, --Fanged Slayer's Shoulderpads
		},
	},
	["SHAMAN"] = {
		["T19"] = {
		138343, --Helm of Shackled Elements
		138346, --Raiment of Shackled Elements
		138348, --Pauldrons of Shackled Elements
		138341, --Gauntlets of Shackled Elements
		138345, --Leggings of Shackled Elements
		138372, --Cloak of Shackled Elements
		},
		["T20"] = {
		147175, --Harness of the Skybreaker
		147176, --Drape of the Skybreaker
		147177, --Grips of the Skybreaker
		147178, --Helmet of the Skybreaker
		147179, --Legguards of the Skybreaker
		147180, --Pauldrons of the Skybreaker
		},
	},
	["WARLOCK"] = {
		["T19"] = {
		138314, --Eyes of Azj'Aqir
		138320, --Finery of Azj'Aqir
		138323, --Pauldrons of Azj'Aqir
		138311, --Clutch of Azj'Aqir
		138317, --Leggings of Azj'Aqir
		138373, --Cloak of Azj'Aqir
		},
		["T20"] = {
		147181, --Diabolic Shroud
		147182, --Diabolic Gloves
		147183, --Diabolic Helm
		147184, --Diabolic Leggings
		147185, --Diabolic Robe
		147186, --Diabolic Mantle
		},
	},
	["WARRIOR"] = {
		["T19"] = {
		138357, --Warhelm of the Obsidian Aspect
		138351, --Chestplate of the Obsidian Aspect
		138363, --Shoulderplates of the Obsidian Aspect
		138354, --Gauntlets of the Obsidian Aspect
		138360, --Legplates of the Obsidian Aspect
		138374, --Greatcloak of the Obsidian Aspect
		},
		["T20"] = {
		147187, --Titanic Onslaught Breastplate
		147188, --Titanic Onslaught Cloak
		147189, --Titanic Onslaught Handguards
		147190, --Titanic Onslaught Greathelm
		147191, --Titanic Onslaught Greaves
		147192, --Titanic Onslaught Pauldrons
		},
	},
}

--set bonuses
--/dump Zylla.GetNumberSetPieces('T18', 'WARRIOR')
function Zylla.GetNumberSetPieces(set, class)
  class = class or select(2, _G.UnitClass("player"))
  local pieces = Zylla.setsTable[class][set] or {}
  local counter = 0
  for _, itemID in ipairs(pieces) do
	 if _G.IsEquippedItem(itemID) then
		counter = counter + 1
	 end
  end
  return counter
end

--XXX: Priest

Zylla.Voidform_Summary = true
Zylla.S2M_Summary = true

--Zylla.Voidform_Drain_Stacks = 0
--Zylla.Voidform_Current_Drain_Rate = 0
--Zylla.SA_TOTAL = 0

function Zylla.SA_Cleanup(guid)
  if _G.Zylla_SA_STATS[guid] then
	 _G.Zylla.SA_TOTAL = _G.Zylla.SA_TOTAL - _G.Zylla_SA_STATS[guid].Count
	 if Zylla.SA_TOTAL < 0 then
		Zylla.SA_TOTAL = 0
	 end
	 _G.Zylla_SA_STATS[guid].Count = nil
	 _G.Zylla_SA_STATS[guid].LastUpdate = nil
	 _G.Zylla_SA_STATS[guid] = nil
	 _G.Zylla_SA_NUM_UNITS = _G.Zylla_SA_NUM_UNITS - 1
	 if _G.Zylla_SA_NUM_UNITS < 0 then
		_G.Zylla_SA_NUM_UNITS = 0
	 end
  end
end

--XXX: Druid

Zylla.f_pguid = _G.UnitGUID("player")
Zylla.f_tguid = _G.UnitGUID("target")
Zylla.f_cp = 0
Zylla.f_cleanUpTimer = nil
Zylla.f_lastUpdate = 0
Zylla.f_nextUpdateDmg = nil

Zylla.f_buffs = {
  ["tigersFury"]  = 0,
  ["savageRoar"]  = 0,
  ["bloodtalons"] = 0,
  ["incarnation"] = 0,
  ["prowl"]		 		= 1,
  ["shadowmeld"]  = 1,
}

Zylla.f_events = {
  ["SPELL_AURA_APPLIED"] = true,
  ["SPELL_AURA_REFRESH"] = true,
  ["SPELL_AURA_REMOVED"] = true,
  ["SPELL_CAST_SUCCESS"] = true,
  ["SPELL_MISSED"]		 = true,
}

Zylla.f_buffID = {
  [5217]		= "tigersFury",
  [52610]  	= "savageRoar",
  [145152] 	= "bloodtalons",
  [102543] 	= "incarnation",
  [5215]		= "prowl",
  [102547] 	= "prowl",
  [58984]  	= "shadowmeld",
}

Zylla.f_debuffID = {
  [163505] 	= "rake", --stun effect
  [1822]		= "rake", --initial dmg
  [1079]		= "rip",
  [106830] 	= "thrash",
  [155722] 	= "rake", --dot
  [155625] 	= "moonfire",
}

--Initialize tables to hold all snapshot data
Zylla.f_Snapshots = {
  ["rake"]	  	= {},
  ["rip"]				= {},
  ["thrash"]		= {},
  ["moonfire"] 	= {},
}

--Create localization strings
Zylla.f_strings = {
  ["tigersFury"]  = _G.GetSpellInfo(5217) or "Tiger's Fury",
  ["savageRoar"]  = _G.GetSpellInfo(52610) or "Savage Roar",
  ["bloodtalons"] = _G.GetSpellInfo(145152) or "Bloodtalons",
  ["incarnation"] = _G.GetSpellInfo(102543) or "Incarnation: King of the Jungle",
  ["prowl"]		 = _G.GetSpellInfo(5215) or "Prowl",
  ["shadowmeld"]  = _G.GetSpellInfo(58984) or "Shadowmeld",
}

--Create update function for checking for buffs
function Zylla.f_update()
  local b = Zylla.f_buffs
  local s = Zylla.f_strings
  local now = _G.GetTime()
  Zylla.f_lastUpdate = now

  b.tigersFury  = select(7,_G.UnitBuff("player", s.tigersFury)) or b.tigersFury
  b.savageRoar  = select(7,_G.UnitBuff("player", s.savageRoar)) or b.savageRoar
  b.bloodtalons = select(7,_G.UnitBuff("player", s.bloodtalons)) or b.bloodtalons
  b.incarnation = select(7,_G.UnitBuff("player", s.incarnation)) or b.incarnation
  b.prowl		 = select(7,_G.UnitBuff("player", s.prowl)) or b.prowl
  b.shadowmeld  = select(7,_G.UnitBuff("player", s.shadowmeld)) or b.shadowmeld
  Zylla.f_updateDmg()
end

--Create update function for calculating current snapshot strength
function Zylla.f_updateDmg()
  local b 								= Zylla.f_buffs
  local now 							= _G.GetTime()
  local dmgMulti 					= 1
  local rakeMulti 				= 1
  local bloodtalonsMulti 	= 1
  local currentCP 				= _G.UnitPower("player",4)
  if currentCP 						~= 0 then
	 Zylla.f_cp = currentCP
  end
  if b.tigersFury 	> now then dmgMulti 				= dmgMulti * 1.15 end
  if b.savageRoar 	> now then dmgMulti 				= dmgMulti * 1.25 end
  if b.bloodtalons 	> now then bloodtalonsMulti = 1.5 end
  if b.incarnation 	> now or b.prowl 						> now or b.shadowmeld > now then rakeMulti = 2
  elseif b.prowl 		== 0 or b.shadowmeld 				== 0 then rakeMulti = 2 end
  Zylla.f_Snapshots.rip.current				= dmgMulti*bloodtalonsMulti*Zylla.f_cp
  Zylla.f_Snapshots.rip.current5CP		= dmgMulti*bloodtalonsMulti*5
  Zylla.f_Snapshots.rake.current	  	= dmgMulti*bloodtalonsMulti*rakeMulti
  Zylla.f_Snapshots.thrash.current		= dmgMulti*bloodtalonsMulti
  Zylla.f_Snapshots.moonfire.current 	= dmgMulti
end

--Create function for handling clean up of the snapshot table
function Zylla.f_cleanUp()
  --Cancel existing scheduled cleanup first if there is one
  if Zylla.f_cleanUpTimer then Zylla.f_cancelCleanUp() end
  Zylla.f_cleanUpTimer = _G.C_Timer.NewTimer(30,function()
	 if _G.UnitIsDeadOrGhost("player") or not _G.UnitAffectingCombat("player") then
	 --if not _G.UnitAffectingCombat("player") then
		Zylla.f_Snapshots = {
		  ["rake"]	  	= {},
		  ["rip"]				= {},
		  ["thrash"]		= {},
		  ["moonfire"] 	= {}
		}
	 end
  end)
end

--Create clean up function
function Zylla.f_cancelCleanUp()
  if Zylla.f_cleanUpTimer then
	 Zylla.f_cleanUpTimer:Cancel()
	 Zylla.f_cleanUpTimer = nil
  end
end

--XXX: Travel Speed

-- List of known spells travel-speed. Non charted spells will be considered traveling 40 yards/s
-- To recover travel speed, open up /eventtrace, calculate difference between SPELL_CAST_SUCCESS and SPELL_DAMAGE events

Zylla.Travel_Times = {
  [116]	 = 23.174,  -- Frostbolt
  [228597] = 23.174,  -- Frostbolt
  [133]	 = 45.805,  -- Fireball
  [11366]  = 52,		-- Pyroblast
  [29722]  = 18,		-- Incinerate
  [30455]  = 33.264,  -- Ice Lance
  [105174] = 33,		-- Hand of Gul'dan
  [120644] = 10,		-- Halo
  [122121] = 25,		-- Divine Star
  [127632] = 19,		-- Cascade
  [210714] = 38,		-- Icefury
  [51505]  = 38.090,  -- Lava Burst
  [205181] = 32.737,  -- Shadowflame
}

-- Return the time a spell will need to travel to the current target
function Zylla.TravelTime(unit, spell)
  local spellID = NeP.Core:GetSpellID(spell)
  if Zylla.Travel_Times[spellID] then
	 local Travel_Speed = Zylla.Travel_Times[spellID]
	 return NeP.DSL:Get("distance")(unit) / Travel_Speed
  else
	 return 0
  end
end

Zylla.flySpells = {
	 [0]	 =  90267,  -- Eastern Kingdoms = Flight Master's License
	 [1]	 =  90267,  -- Kalimdor			= Flight Master's License
	 [646]  =  90267,  -- Deepholm			= Flight Master's License
	 [571]  =  54197,  -- Northrend		  = Cold Weather Flying
	 [870]  = 115913,  -- Pandaria			= Wisdom of the Four Winds
	 [1116] = 191645,  -- Draenor			 = Draenor Pathfinder
	 [1464] = 191645,  -- Tanaan Jungle	 = Draenor Pathfinder
	 [1191] = -1,		-- Ashran - World PvP
	 [1265] = -1,		-- Tanaan Jungle Intro
	 [1220] = 233368,  -- Broken Isles	  = Broken Isles Pathfinder Rank 2
}

function Zylla.dynEval(condition, spell)
  return Parse(condition, spell or '')
end

function Zylla.GetPredictedHealth(unit)
  return _G.UnitHealth(unit) - (_G.UnitGetTotalHealAbsorbs(unit) or 0) + (_G.UnitGetIncomingHeals(unit) or 0)
end

function Zylla.NrHealsAroundFriendly(healthp, distance, unit)
  local health = healthp
  local range = distance
  local total = 0
  if not _G.UnitExists(unit) then return total end
  for _, Obj in pairs(NeP.OM:Get('Roster')) do
	 if NeP.Protected.Distance(unit, Obj.key) <= tonumber(range) and Obj.health < health then
		total = total +1
	 end
  end
  return total
end

function Zylla.tt()
  if NeP.Unlocked and _G.UnitAffectingCombat('player') and not NeP.DSL:Get('casting')('player', 'Fists of Fury') then
	 NeP:Queue('Transcendence: Transfer', 'player')
  end
end

function Zylla.ts()
  if NeP.Unlocked and _G.UnitAffectingCombat('player') and not NeP.DSL:Get('casting')('player', 'Fists of Fury') then
	 NeP:Queue('Transcendence', 'player')
  end
end
