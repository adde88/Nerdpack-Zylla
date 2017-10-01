local _, Zylla = ...
local _G = _G
local NeP = _G.NeP

NeP.FakeUnits:Add('healingCandidate', function(nump)
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

NeP.FakeUnits:Add('Zylla_sck', function(debuff)
  for _, Obj in pairs(NeP.OM:Get('Enemy')) do
    if _G.UnitExists(Obj.key) then
      if (NeP.DSL:Get('combat')(Obj.key) or Obj.isdummy) then
        if (NeP.DSL:Get('infront')(Obj.key) and NeP.DSL:Get('inMelee')(Obj.key)) then
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
