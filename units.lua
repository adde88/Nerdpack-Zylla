local _, Zylla = ...
local _G = _G
local NeP = _G.NeP

-- Healing stuff
NeP.Unit:Add('healingCandidate', function(nump)
      local tmp = {}
      local num = nump or 1
			for i=1, NeP.Protected.GetObjectCount() do
				local Obj = NeP.Protected.GetObjectWithIndex(i)
				if NeP.Protected.omVal(Obj)
				and _G.UnitIsFriend('player', Obj)
        and (_G.UnitInRaid(Obj) or _G.UnitInParty(Obj)) then
            local healthRaw = Zylla.GetPredictedHealth(Obj)
            local maxHealth = _G.UnitHealthMax(Obj)
            local healthPercent =  (healthRaw / maxHealth) * 100
            tmp[#tmp+1] = {
               key = Obj,
               prio = healthPercent,
            }
         end
      end
      table.sort( tmp, function(a,b) return a.prio < b.prio end )
      print("Zylla Unit: " ..tmp[num].key .." Health: " ..tmp[num].prio)
      return tmp
end)

-- Customized for Windwalker Rotation
NeP.Unit:Add('Zylla_sck', function(debuff)
	for i=1, NeP.Protected.GetObjectCount() do
		local Obj = NeP.Protected.GetObjectWithIndex(i)
		if NeP.Protected.omVal(Obj)
		and NeP.Condition:Get('combat')(Obj)
		and (NeP.Condition:Get('infront')(Obj)
		and NeP.Condition:Get('inMelee')(Obj)) then
			local _,_,_,_,_,_,debuffDuration = _G.UnitDebuff(Obj, debuff, nil, 'PLAYER')
			if not debuffDuration or debuffDuration - _G.GetTime() < 1.5 then
				print("Zylla_sck: returning "..Obj.name.." ("..Obj.." - "..Obj.guid..' :'.._G.time()..")");
				return Obj
			end
		end
	end
end)

-- Highest Health Enemy
NeP.Unit:Add({'highestenemy', 'higheste', 'he'}, function(num)
      local tmp = {}
      for i=1, NeP.Protected.GetObjectCount() do
				local Obj = NeP.Protected.GetObjectWithIndex(i)
				if NeP.Protected.omVal(Obj)
				and _G.UnitCanAttack('player', Obj)
				and NeP.Condition:Get('combat')(Obj)
				and NeP.Condition:Get('alive')(Obj) then
					tmp[#tmp+1] = {
						key = Obj,
						prio = _G.UnitHealthMax(Obj)
					}
				end
			end
			table.sort( tmp, function(a,b) return a.prio > b.prio end )
			return tmp
end)

-- Feral Druid Stuff         XXX: Remember to set the 'ptf_timer' variable in your UI Settings.
	NeP.Unit:Add({'nobleedenemy', 'nobleede'}, function()
      local ptf_timer = tonumber(NeP.Condition:Get('UI')(nil, 'ptftimer_spin'))
      for i=1, NeP.Protected.GetObjectCount() do
				local Obj = NeP.Protected.GetObjectWithIndex(i)
        if NeP.Protected.omVal(Obj) then
					local rip_duration = tonumber(NeP.Condition:Get('debuff.duration')(Obj, 'Rip'))
          local rake_duration = tonumber(NeP.Condition:Get('debuff.duration')(Obj, 'Rake'))
          local thrash_duration = tonumber(NeP.Condition:Get('debuff.duration')(Obj, 'Thrash'))
          if (NeP.Condition:Get('inFront')(Obj) and NeP.Condition:Get('inMelee')(Obj))
          and rip_duration < ptf_timer
          and rake_duration < ptf_timer
          and thrash_duration < ptf_timer then
						return Obj
					end
				end
			end
end)

-- Nearest Enemy
NeP.Unit:Add({'nearestenemy', 'neareste', 'ne'}, function(num)
      local tmp = {}
			for i=1, NeP.Protected.GetObjectCount() do
				local Obj = NeP.Protected.GetObjectWithIndex(i)
				if NeP.Protected.omVal(Obj)
				and _G.UnitCanAttack('player', Obj)
				and NeP.Condition:Get('combat')(Obj)
				and NeP.Condition:Get('alive')(Obj) then
            tmp[#tmp+1] = {
               key = Obj,
               prio = NeP.Condition:Get("range")(Obj)
            }
         end
      end
      table.sort( tmp, function(a,b) return a.prio < b.prio end )
      return tmp
end)

-- Furthest Enemy (Within 60 yd)
NeP.Unit:Add({'furthestenemy', 'furtheste', 'fe'}, function(num)
      local tmp = {}
			for i=1, NeP.Protected.GetObjectCount() do
				local Obj = NeP.Protected.GetObjectWithIndex(i)
				if NeP.Protected.omVal(Obj)
				and _G.UnitCanAttack('player', Obj)
				and NeP.Condition:Get('combat')(Obj)
				and NeP.Condition:Get('alive')(Obj)
				and NeP.Condition:Get("range")(Obj) <= 60 then
					tmp[#tmp+1] = {
						key = Obj,
						prio = NeP.Condition:Get("range")(Obj)
					}
				end
			end
			table.sort( tmp, function(a,b) return a.prio > b.prio end )
			return tmp
end)
