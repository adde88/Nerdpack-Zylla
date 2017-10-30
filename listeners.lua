local _, Zylla = ...
local _G = _G
local NeP = _G.NeP

NeP.Listener:Add('Zylla_SA', 'COMBAT_LOG_EVENT_UNFILTERED', function(_,combatevent,_,sourceGUID,_,_,_,destGUID,_,_,_,spellid,_,_,_,_,_,_,_,_,_,_,_,_,_)
  if Zylla.Class == 5 then
    local CurrentTime 					= _G.GetTime()
    local Zylla_SA_NUM_UNITS 		= _G.Zylla_SA_NUM_UNITS or 0
		_G.Zylla_SA_STATS 					= {}
    Zylla.SA_TOTAL 							= _G.Zylla.SA_TOTAL or 0
    -- Stats buffer
    local Zylla_SA_STATS 				= _G.Zylla_SA_STATS or {}
    local Zylla_SA_DEAD 				= _G.Zylla_SA_DEAD or {}
    Zylla.LAST_CONTINUITY_CHECK = Zylla.LAST_CONTINUITY_CHECK or _G.GetTime()
    if sourceGUID == _G.UnitGUID("player") then
      if spellid == 147193 and combatevent == "SPELL_CAST_SUCCESS" then -- Shadowy Apparition Spawned
        if not Zylla_SA_STATS[destGUID] or Zylla_SA_STATS[destGUID] == nil then
          Zylla_SA_STATS[destGUID]       = {}
          Zylla_SA_STATS[destGUID].Count = 0
          Zylla_SA_NUM_UNITS             = Zylla_SA_NUM_UNITS + 1
      end
      Zylla.SA_TOTAL = Zylla.SA_TOTAL + 1
      --print('SA spawn :'..Zylla.SA_TOTAL..' remaining SA')
      Zylla_SA_STATS[destGUID].Count      = Zylla_SA_STATS[destGUID].Count + 1
      Zylla_SA_STATS[destGUID].LastUpdate = CurrentTime
      elseif spellid == 148859 and combatevent == "SPELL_DAMAGE" then --Auspicious Spirit Hit
        if Zylla.SA_TOTAL < 0 then
          Zylla.SA_TOTAL = 0
      else
        Zylla.SA_TOTAL = Zylla.SA_TOTAL - 1
      end
      --print('SA hit :'..Zylla.SA_TOTAL..' remaining SA')
      if Zylla_SA_STATS[destGUID] and Zylla_SA_STATS[destGUID].Count > 0 then
        Zylla_SA_STATS[destGUID].Count      = Zylla_SA_STATS[destGUID].Count - 1
        Zylla_SA_STATS[destGUID].LastUpdate = CurrentTime
        if Zylla_SA_STATS[destGUID].Count <= 0 then
          Zylla.SA_Cleanup(destGUID)
        end
      end
      end
    end
    if Zylla.SA_TOTAL < 0 then
      Zylla.SA_TOTAL = 0
    end
    for guid,_ in pairs(Zylla_SA_STATS) do
      if (CurrentTime - Zylla_SA_STATS[guid].LastUpdate) > 10 then
        --If we haven't had a new SA spawn in 10sec, that means all SAs that are out have hit the target (usually), or, the target disappeared.
        Zylla.SA_Cleanup(guid)
      end
    end
    if (combatevent == "UNIT_DIED" or combatevent == "UNIT_DESTROYED" or combatevent == "SPELL_INSTAKILL") then -- Unit Died, remove them from the target list.
      Zylla.SA_Cleanup(destGUID)
    end

    if _G.UnitIsDeadOrGhost("player") or not _G.UnitAffectingCombat("player") then -- We died, or, exited combat, go ahead and purge the list
      for guid,_ in pairs(Zylla_SA_STATS) do
        Zylla.SA_Cleanup(guid)
    end
    Zylla_SA_STATS     = {}
    Zylla_SA_NUM_UNITS = 0
    Zylla.SA_TOTAL     = 0
    end
    if CurrentTime - Zylla.LAST_CONTINUITY_CHECK > 10 then --Force check of unit count every 10sec
      local newUnits = 0
      for _,_ in pairs(Zylla_SA_STATS) do
        newUnits = newUnits + 1
      end
      Zylla_SA_NUM_UNITS          = newUnits
      Zylla.LAST_CONTINUITY_CHECK = CurrentTime
    end
    if Zylla_SA_NUM_UNITS > 0 then
      local totalSAs = 0
      for guid,_ in pairs(Zylla_SA_STATS) do
        if Zylla_SA_STATS[guid].Count <= 0 or (_G.UnitIsDeadOrGhost(guid)) then
          Zylla_SA_DEAD[guid] = true
        else
          totalSAs = totalSAs + Zylla_SA_STATS[guid].Count
        end
      end
      if totalSAs > 0 and Zylla.SA_TOTAL > 0 then
        return true
      end
    end
    return false
  end
end)

NeP.Listener:Add('Zylla_VF_S2M', 'COMBAT_LOG_EVENT_UNFILTERED', function(_,combatevent,_,sourceGUID,_,_,_,destGUID,_,_,_,spellid,_,_,_,_,_,_,_,_,_,_,_,_,_)
  if Zylla.Class == 5 then
    local CurrentTime = _G.GetTime()
    Zylla.Voidform_Total_Stacks        = Zylla.Voidform_Total_Stacks or 0
    Zylla.Voidform_Previous_Stack_Time = Zylla.Voidform_Previous_Stack_Time or 0
    Zylla.Voidform_Drain_Stacks        = Zylla.Voidform_Drain_Stacks or 0
    Zylla.Voidform_VoidTorrent_Stacks  = Zylla.Voidform_VoidTorrent_Stacks or 0
    Zylla.Voidform_Dispersion_Stacks   = Zylla.Voidform_Dispersion_Stacks or 0
    Zylla.Voidform_Current_Drain_Rate  = Zylla.Voidform_Current_Drain_Rate or 0
    if Zylla.Voidform_Total_Stacks >= 100 then
      if (CurrentTime - Zylla.Voidform_Previous_Stack_Time) >= 1 then
        Zylla.Voidform_Previous_Stack_Time  = CurrentTime
        Zylla.Voidform_Total_Stacks         = Zylla.Voidform_Total_Stacks + 1
        if Zylla.Voidform_VoidTorrent_Start == nil and Zylla.Voidform_Dispersion_Start == nil then
          Zylla.Voidform_Drain_Stacks       = Zylla.Voidform_Drain_Stacks + 1
          -- print('Zylla.Voidform_Drain_Stacks1: '..Zylla.Voidform_Drain_Stacks)
          Zylla.Voidform_Current_Drain_Rate = (9.0 + ((Zylla.Voidform_Drain_Stacks - 1) / 2))
          -- print('Zylla.Voidform_Current_Drain_Rate1: '..Zylla.Voidform_Current_Drain_Rate)
        elseif Zylla.Voidform_VoidTorrent_Start ~= nil then
          Zylla.Voidform_VoidTorrent_Stacks = Zylla.Voidform_VoidTorrent_Stacks + 1
        else
          Zylla.Voidform_Dispersion_Stacks  = Zylla.Voidform_Dispersion_Stacks + 1
        end
      end
    end
    if sourceGUID == _G.UnitGUID("player") then
      if spellid == 194249 then
        if combatevent == "SPELL_AURA_APPLIED" then -- Entered Voidform
          Zylla.Voidform_Previous_Stack_Time = CurrentTime
          Zylla.Voidform_VoidTorrent_Start   = nil
          Zylla.Voidform_Dispersion_Start    = nil
          Zylla.Voidform_Drain_Stacks        = 1
          Zylla.Voidform_Start_Time          = CurrentTime
          Zylla.Voidform_Total_Stacks        = 1
          Zylla.Voidform_VoidTorrent_Stacks  = 0
          Zylla.Voidform_Dispersion_Stacks   = 0
        elseif combatevent == "SPELL_AURA_APPLIED_DOSE" then -- New Voidform Stack
          Zylla.Voidform_Previous_Stack_Time  = CurrentTime
          Zylla.Voidform_Total_Stacks         = Zylla.Voidform_Total_Stacks + 1
          if Zylla.Voidform_VoidTorrent_Start == nil and Zylla.Voidform_Dispersion_Start == nil then
            Zylla.Voidform_Drain_Stacks       = Zylla.Voidform_Drain_Stacks + 1
            -- print('Zylla.Voidform_Drain_Stacks2: '..Zylla.Voidform_Drain_Stacks)
            Zylla.Voidform_Current_Drain_Rate = (9.0 + ((Zylla.Voidform_Drain_Stacks - 1) / 2))
            -- print('Zylla.Voidform_Current_Drain_Rate2: '..Zylla.Voidform_Current_Drain_Rate)
          elseif Zylla.Voidform_VoidTorrent_Start ~= nil then
            Zylla.Voidform_VoidTorrent_Stacks = Zylla.Voidform_VoidTorrent_Stacks + 1
          else
            Zylla.Voidform_Dispersion_Stacks  = Zylla.Voidform_Dispersion_Stacks + 1
          end
        elseif combatevent == "SPELL_AURA_REMOVED" then -- Exited Voidform
          if Zylla.Voidform_Summary == true then
            print("Voidform Info:")
            print("--------------------------")
            print(string.format("Voidform Duration: %.2f seconds", (CurrentTime-Zylla.Voidform_Start_Time)))
            if Zylla.Voidform_Total_Stacks > 100 then
              print(string.format("Voidform Stacks: 100 (+%.0f)", (Zylla.Voidform_Total_Stacks - 100)))
            else
              print(string.format("Voidform Stacks: %.0f", Zylla.Voidform_Total_Stacks))
            end
            print(string.format("Dispersion Stacks: %.0f", Zylla.Voidform_Dispersion_Stacks))
            print(string.format("Void Torrent Stacks: %.0f", Zylla.Voidform_VoidTorrent_Stacks))
            print("Final Drain: "..Zylla.Voidform_Drain_Stacks.." stacks, "..Zylla.Voidform_Current_Drain_Rate.." / sec")
        end
        Zylla.Voidform_VoidTorrent_Start  = nil
        Zylla.Voidform_Dispersion_Start   = nil
        Zylla.Voidform_Drain_Stacks       = 0
        Zylla.Voidform_Current_Drain_Rate = 0
        Zylla.Voidform_Start_Time         = nil
        Zylla.Voidform_Total_Stacks       = 0
        Zylla.Voidform_VoidTorrent_Stacks = 0
        Zylla.Voidform_Dispersion_Stacks  = 0
        end

      elseif spellid == 205065 then
        if combatevent == "SPELL_AURA_APPLIED" then -- Started channeling Void Torrent
          Zylla.Voidform_VoidTorrent_Start = CurrentTime
        elseif combatevent == "SPELL_AURA_REMOVED" and Zylla.Voidform_VoidTorrent_Start ~= nil then -- Stopped channeling Void Torrent
          Zylla.Voidform_VoidTorrent_Start = nil
        end

      elseif spellid == 47585 then
        if combatevent == "SPELL_AURA_APPLIED" then -- Started channeling Dispersion
          Zylla.Voidform_Dispersion_Start  = CurrentTime
        elseif combatevent == "SPELL_AURA_REMOVED" and Zylla.Voidform_Dispersion_Start ~= nil then -- Stopped channeling Dispersion
          Zylla.Voidform_Dispersion_Start  = nil
        end

      elseif spellid == 212570 then
        if combatevent == "SPELL_AURA_APPLIED" then -- Gain Surrender to Madness
          Zylla.Voidform_S2M_Activated     = true
          Zylla.Voidform_S2M_Start         = CurrentTime
        elseif combatevent == "SPELL_AURA_REMOVED" then -- Lose Surrender to Madness
          Zylla.Voidform_S2M_Activated     = false
        end
      end

    elseif destGUID == _G.UnitGUID("player") and (combatevent == "UNIT_DIED" or combatevent == "UNIT_DESTROYED" or combatevent == "SPELL_INSTAKILL") and Zylla.Voidform_S2M_Activated == true then
      Zylla.Voidform_S2M_Activated = false
      if Zylla.S2M_Summary == true then
        print("Surrender to Madness Info:")
        print("--------------------------")
        print(string.format("S2M Duration: %.2f seconds", (CurrentTime-Zylla.Voidform_S2M_Start)))
        print(string.format("Voidform Duration: %.2f seconds", (CurrentTime-Zylla.Voidform_Start_Time)))
        if Zylla.Voidform_Total_Stacks > 100 then
          print(string.format("Voidform Stacks: 100 (+%.0f)", (Zylla.Voidform_Total_Stacks - 100)))
        else
          print(string.format("Voidform Stacks: %.0f", Zylla.Voidform_Total_Stacks))
        end
        print(string.format("Dispersion Stacks: %.0f", Zylla.Voidform_Dispersion_Stacks))
        print(string.format("Void Torrent Stacks: %.0f", Zylla.Voidform_VoidTorrent_Stacks))
        print("Final Drain: "..Zylla.Voidform_Drain_Stacks.." stacks, "..Zylla.Voidform_Current_Drain_Rate.." / sec")
      end
      Zylla.Voidform_S2M_Start          = nil
      Zylla.Voidform_VoidTorrent_Start  = nil
      Zylla.Voidform_Dispersion_Start   = nil
      Zylla.Voidform_Drain_Stacks       = 0
      Zylla.Voidform_Current_Drain_Rate = 0
      Zylla.Voidform_Start_Time         = nil
      Zylla.Voidform_Total_Stacks       = 0
      Zylla.Voidform_VoidTorrent_Stacks = 0
      Zylla.Voidform_Dispersion_Stacks  = 0
    end
  end
end)

NeP.Listener:Add('Zylla_f_update1', 'ZONE_CHANGED_NEW_AREA', function()
	  if Zylla.Class == 11 then
    Zylla.f_update()
  end
end)

NeP.Listener:Add('Zylla_f_update2', 'ACTIVE_TALENT_GROUP_CHANGED', function()
  if Zylla.Class == 11 then
    Zylla.f_update()
  end
end)

NeP.Listener:Add('Zylla_f_updateDmg', 'UNIT_POWER', function(unit, type)
  if Zylla.Class == 11 then
    if unit == "player" and type == "COMBO_POINTS" then
      Zylla.f_updateDmg()
    end
  end
end)

NeP.Listener:Add('Zylla_f_Snapshot', 'COMBAT_LOG_EVENT_UNFILTERED', function(_, combatevent, _, sourceGUID, _,_,_, destGUID, _,_,_, spellID)
	if Zylla.Class == 11 then
    --This trigger listens for bleed events to record snapshots.
    --This trigger also listens for changes in buffs to recalculate bleed damage.

    --Check for only relevant player events
    if not Zylla.f_buffID[spellID] and not Zylla.f_debuffID[spellID] then return end
    if not Zylla.f_events[combatevent] then return end
    if sourceGUID ~= Zylla.f_pguid then return end

    --Handle AURA_APPLY and AURA_REFRESH as the same event type
    if combatevent == "SPELL_AURA_REFRESH" then combatevent = "SPELL_AURA_APPLIED" end

    --Convert rake stun events into rake casts to handle corner case with prowl+rake
    if spellID == 163505 and (combatevent=="SPELL_MISSED" or combatevent=="SPELL_AURA_APPLIED") then
      spellID = 1822
      combatevent = "SPELL_CAST_SUCCESS"
    end

    --Listen for buff changes on player that affect snapshots
    if destGUID == Zylla.f_pguid then
      if combatevent == "SPELL_AURA_APPLIED" then Zylla.f_update() return
      elseif combatevent == "SPELL_AURA_REMOVED" then
				local spellName = Zylla.f_buffID[spellID]
        local dur = 0
        --Add small timing window for buffs that can expire before cast
        if spellName == "bloodtalons" then dur    = 0.1
        elseif spellName == "prowl" then dur      = 0.1
        elseif spellName == "shadowmeld" then dur = 0.1
        end

        if spellName then
          Zylla.f_buffs[spellName] = _G.GetTime() + dur
          Zylla.f_nextUpdateDmg    = _G.GetTime() + dur + 0.01
          return
        end
      end
    end

    -- The following code handles application and expiration of bleeds

    -- 1. Snapshot dmg on spell cast success
    local fs = Zylla.f_Snapshots
    if combatevent == "SPELL_CAST_SUCCESS" then
      local spellName
      if spellID == 1822 then spellName       = "rake"
      elseif spellID == 1079 then spellName   = "rip"
      elseif spellID == 106830 then spellName = "thrash"
      elseif spellID == 155625 then spellName = "moonfire"
      end

      if spellName then
        Zylla.f_update()
        fs[spellName]["onCast"] = fs[spellName]["current"]
        return
      end

      --2. Record snapshot for target if and when the bleed is applied
    elseif combatevent == "SPELL_AURA_APPLIED" then
      local spellName
      if spellID == 155722 then spellName     = "rake"
      elseif spellID == 1079 then spellName   = "rip"
      elseif spellID == 106830 then spellName = "thrash"
      elseif spellID == 155625 then spellName = "moonfire"
      end

      if spellName then
        fs[spellName][destGUID] = fs[spellName]["onCast"]
        return
      end

      --3. Remove snapshot for target when bleed expires
    elseif combatevent == "SPELL_AURA_REMOVED" then
      local spellName
      if spellID == 155722 then spellName     = "rake"
      elseif spellID == 1079 then spellName   = "rip"
      elseif spellID == 106830 then spellName = "thrash"
      elseif spellID == 155625 then spellName = "moonfire"
      end

      if spellName then
        fs[spellName][destGUID] = nil
        return
      end
    end
  end
end)

NeP.Listener:Add('Zylla_OutOfCombat', 'PLAYER_REGEN_ENABLED', function()
  if Zylla.Class == 9 then
    --This trigger manages clean up of snapshots when it is safe to do so
    --1. Schedule cleanup of snapshots when combat ends
    Zylla.f_cleanUp()
  end
end)

NeP.Listener:Add('Zylla_InCombat', 'PLAYER_REGEN_DISABLED', function()
  if Zylla.Class == 9 then
    --2. Check for and cancel scheduled cleanup when combat starts
    Zylla.f_cancelCleanUp()

    _G.C_Timer.NewTicker(1.5, (function()
      --This trigger runs the update function if there have been no updates recently
      --due to a lack of relevant combat events.
      if not _G.UnitIsDeadOrGhost("player") and (_G.UnitAffectingCombat("player")) then
        if _G.GetTime() - Zylla.f_lastUpdate >= 3 then Zylla.f_update() end
        --if _G.GetTime() - Zylla.lastDmgUpdate >= 0.045 then Zylla.f_updateDmg() end
        if Zylla.f_nextUpdateDmg and _G.GetTime() > Zylla.f_nextUpdateDmg then
          Zylla.f_nextUpdateDmg = nil
          Zylla.f_updateDmg()
        end
      end
    end), nil)
  end
end)

NeP.Listener:Add('Zylla_Listener4', 'COMBAT_LOG_EVENT_UNFILTERED', function(_, combatevent, _, _, sourceName, _, _, _, _, _, _, spellID, spellName, _, _)
  if (combatevent == "SPELL_CAST_SUCCESS" and sourceName == _G.UnitName("player")) then
    Zylla.spell_timers[spellID]      = {}
    Zylla.spell_timers[spellID].name = spellName
    Zylla.spell_timers[spellID].id   = spellID
    Zylla.spell_timers[spellID].time = _G.GetTime()
  end
  if _G.UnitIsDeadOrGhost("player") or not _G.UnitAffectingCombat("player") or not _G.InCombatLockdown() then
    Zylla.spell_timers = {}
  end
end)

--[[
NeP.Listener:Add('Zylla_Listener_TravelSpeed', 'COMBAT_LOG_EVENT_UNFILTERED', function(timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, amount, ...)
  if Zylla.TTTL_enable == true then
    if (combatevent == "SPELL_CAST_SUCCESS" and sourceName == UnitName("player")) then
			if spellID ~= 228597 then
	      print('SPELL_CAST_SUCCESS: '..spellName..', '..spellID)
				Zylla.start_timer = GetTime()
	      mirror_name = spellName
			end
    end
    if (combatevent == "SPELL_DAMAGE" and spellName == mirror_name and sourceName == UnitName("player")) then
      print('SPELL_DAMAGE: '..spellName..', '..spellID)
				if uniqID == nil then uniqID = 0 end
				uniqID = uniqID + 1
				Zylla.TTTL_table[uniqID] = {}
				Zylla.TTTL_table[uniqID].name = spellName
				Zylla.TTTL_table[uniqID].spellID = spellID
				Zylla.TTTL_table[uniqID].start = Zylla.start_timer
				Zylla.TTTL_table[uniqID].distance = NeP.Condition:Get('range')('target')
	      Zylla.TTTL_table[uniqID].finish = GetTime()
	      Zylla.TTTL_table[uniqID].travel_time = 0
	      Zylla.TTTL_table[uniqID].travel_speed = 0
	      Zylla.TTTL_calc_tt()
    end
  end
end)
--]]
