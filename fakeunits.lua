local _, Zylla = ...
local _G = _G
local NeP = _G.NeP

-- Healing stuff
NeP.Units:Add('healingCandidate', function(nump)
      local tempTable = {}
      local num = nump or 1
      for _, Obj in pairs(NeP.OM:Get('Friendly')) do
         if _G.UnitPlayerOrPetInParty(Obj.key) or _G.UnitIsUnit('player', Obj.key) then
            local healthRaw = Zylla.GetPredictedHealth(Obj.key)
            local maxHealth = _G.UnitHealthMax(Obj.key)
            local healthPercent =  (healthRaw / maxHealth) * 100
            tempTable[#tempTable+1] = {
               key = Obj.key,
               health = healthPercent,
            }
         end
      end
      table.sort( tempTable, function(a,b) return a.health < b.health end )
      print("Zylla Unit: " ..tempTable[num].key .." Health: " ..tempTable[num].health)
      return tempTable[num].key
end)

-- Customized for Windwalker Rotation
NeP.Units:Add('Zylla_sck', function(debuff)
      for _, Obj in pairs(NeP.OM:Get('Enemy')) do
         if _G.UnitExists(Obj.key) then
            if (NeP.Condition:Get('combat')(Obj.key) or Obj.isdummy) then
               if (NeP.Condition:Get('infront')(Obj.key) and NeP.Condition:Get('inMelee')(Obj.key)) then
                  local _,_,_,_,_,_,debuffDuration = _G.UnitDebuff(Obj.key, debuff, nil, 'PLAYER')
                  if not debuffDuration or debuffDuration - _G.GetTime() < 1.5 then
                     --print("Zylla_sck: returning "..Obj.name.." ("..Obj.key.." - "..Obj.guid..' :'..time()..")");
                     return Obj.key
                  end
               end
            end
         end
      end
end)

-- Highest Health Enemy
NeP.Units:Add({'highestenemy', 'higheste', 'he'}, function(num)
      local tempTable = {}
      for _, Obj in pairs(NeP.OM:Get('Enemy')) do
         if _G.UnitExists(Obj.key) then
            tempTable[#tempTable+1] = {
               key = Obj.key,
               health = NeP.Condition:Get("health")(Obj.key)
            }
         end
      end
      table.sort( tempTable, function(a,b) return a.health > b.health end )
      return tempTable[num] and tempTable[num].key
end)

-- Feral Druid Stuff         XXX: Remember to set the 'ptf_timer' variable in your UI Settings.
NeP.Units:Add({'nobleedenemy', 'nobleede'}, function()
      local ptf_timer    = tonumber(NeP.Condition:Get('UI')(nil, 'ptftimer_spin'))
      for _, Obj in pairs(NeP.OM:Get('Enemy')) do
         if _G.UnitExists(Obj.key) then
            local rip_duration         = tonumber(NeP.Condition:Get('debuff.duration')(Obj.key, 'Rip'))
            local rake_duration     = tonumber(NeP.Condition:Get('debuff.duration')(Obj.key, 'Rake'))
            local thrash_duration = tonumber(NeP.Condition:Get('debuff.duration')(Obj.key, 'Thrash'))
            if (NeP.Condition:Get('inFront')(Obj.key) and NeP.Condition:Get('inMelee')(Obj.key)) and
            rip_duration         < ptf_timer and
            rake_duration     < ptf_timer and
            thrash_duration < ptf_timer then
               return Obj.key
            end
         end
      end
end)

-- Nearest Enemy
NeP.Units:Add({'nearestenemy', 'neareste', 'ne'}, function(num)
      local tempTable = {}
      for _, Obj in pairs(NeP.OM:Get('Enemy')) do
         if _G.UnitExists(Obj.key) then
            tempTable[#tempTable+1] = {
               key = Obj.key,
               range = NeP.Condition:Get("range")(Obj.key)
            }
         end
      end
      table.sort( tempTable, function(a,b) return a.range < b.range end )
      return tempTable[num] and tempTable[num].key
end)

-- Furthest Enemy (Within 60 yd)
NeP.Units:Add({'furthestenemy', 'furtheste', 'fe'}, function(num)
      local tempTable = {}
      for _, Obj in pairs(NeP.OM:Get('Enemy')) do
         if _G.UnitExists(Obj.key) and
				 NeP.Condition:Get("range")(Obj.key) <= 60 then
            tempTable[#tempTable+1] = {
               key = Obj.key,
               range = NeP.Condition:Get("range")(Obj.key)
            }
         end
      end
      table.sort( tempTable, function(a,b) return a.range > b.range end )
      return tempTable[num] and tempTable[num].key
end)
