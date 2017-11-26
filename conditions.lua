local _, Zylla = ...
local _G = _G
local NeP = Zylla.NeP

--XXX: Miscellaneous conditions

NeP.Condition:Register('isflyable', function()
      if _G.IsFlyableArea() then
         local _, _, _, _, _, _, _, instanceMapID = _G.GetInstanceInfo()
         local reqSpell = Zylla.flySpells[instanceMapID]
         if reqSpell then
            return reqSpell > 0 and _G.IsSpellKnown(reqSpell)
         elseif not _G.IsOnGarrisonMap() and not _G.IsOnShipyardMap() then
              return _G.IsSpellKnown(34090) or _G.IsSpellKnown(34091) or _G.IsSpellKnown(90265)
         end
      end
end)

NeP.Condition:Register('nfly', function()
  return _G.IsFlying()
end)

NeP.Condition:Register('map_area_id', function()
    return  _G.GetCurrentMapAreaID()
end)

NeP.Condition:Register('casting.left', function(target, spell)
    local reverse = NeP.Condition:Get('casting.percent')(target, spell)
    if reverse ~= 0 then
        return 100 - reverse
    end
    return 0
end)

NeP.Condition:Register('indoors', function()
    return _G.IsIndoors()
end)

--XXX: SimulationCraft Conditions

NeP.Condition:Register('buff.react', function(target, spell)
  local x = NeP.Condition:Get('buff.count')(target, spell)
  if x == 1 then
    return true
  elseif x == 0 then
    return false
  else
    return x
  end
end)

NeP.Condition:Register('xmoving', function()
    local speed = _G.GetUnitSpeed('player')
    if speed ~= 0 then
        return 1
    else
        return 0
    end
end)

local PowerT = {
    [0] = ('^.-Mana'),
    [1] = ('^.-Rage'),
    [2] = ('^.-Focus'),
    [3] = ('^.-Energy'),
		[4] = ('^.-Astral Power'),
		[5] = ('^.-Runic Power'),
}

NeP.Condition:Register('action.cost', function(_, spell)
    local costText = Zylla.Scan_SpellCost(spell)
    local numcost = 0
    for i = 0, 5 do
        local cost = _G.strmatch(costText, PowerT[i])
        if cost ~= nil then
            numcost = _G.gsub(cost, '%D', '') + 0
        end
    end
    if numcost > 0 then
        return numcost
    else
        return 0
    end
end)

NeP.Condition:Register('dot.refreshable', function(_, spell)
    local _,_,_,_,_,duration,expires,_,_,_,spellID = _G.UnitDebuff('target', spell, nil, 'PLAYER|HARMFUL')
    if spellID and expires then
        local time_left = expires - _G.GetTime()
        if time_left < (duration/3) then
            return true
        end
    end
    return false
end)

NeP.Condition:Register('dot.duration', function(target, spell)
    local debuff,_,duration,_,caster = Zylla.UnitDot(target, spell, _)
    if debuff and (caster == 'player' or caster == 'pet') then
        return duration
    end
    return 0
end)

NeP.Condition:Register('dot.ticking', function(target, spell)
    if NeP.Condition:Get('debuff')(target, spell) then
        return true
    else
        return false
    end
end)

NeP.Condition:Register('dot.remains', function(target, spell)
    return NeP.Condition:Get('debuff.duration')(target, spell)
end)


NeP.Condition:Register('buff.down', function(target, spell)
    local x = NeP.Condition:Get('buff.count')(target, spell)
    if x == 0 then
        return true
    elseif x ~= 0 then
        return false
    else
        return x
    end
end)

NeP.Condition:Register('buff.up', function(target, spell)
    local x = NeP.Condition:Get('buff.count')(target, spell)
    if x == 1 then
        return true
    elseif x == 0 then
        return false
    else
        return x
    end
end)

NeP.Condition:Register('buff.stack', function(target, spell)
    return NeP.Condition:Get('buff.count')(target, spell)
end)

NeP.Condition:Register('buff.remains', function(target, spell)
    return NeP.Condition:Get('buff.duration')(target, spell)
end)

NeP.Condition:Register('debuff.up', function(target, spell)
    local x = NeP.Condition:Get('debuff.count')(target, spell)
    if x == 1 then
        return true
    elseif x == 0 then
        return false
    else
        return x
    end
end)

NeP.Condition:Register('debuff.stack', function(target, spell)
    return NeP.Condition:Get('debuff.count')(target, spell)
end)

NeP.Condition:Register('debuff.remains', function(target, spell)
    return NeP.Condition:Get('debuff.duration')(target, spell)
end)

--TODO: (Work out off gcd/gcd only skills. Now all of this is just like SiMC 'prev')

NeP.Condition:Register('prev_off_gcd', function(_, spell)
    return NeP.Condition:Get('lastcast')('player', spell)
end)

NeP.Condition:Register('prev_gcd', function(_, spell)
    return NeP.Condition:Get('lastgcd')('player', spell)
end)

NeP.Condition:Register('prev', function(_, spell)
    return NeP.Condition:Get('lastcast')('player', spell)
        --end
end)

NeP.Condition:Register('time_to_die', function(target)
    return NeP.Condition:Get('deathin')(target)
end)

NeP.Condition:Register('xtime', function()
    return NeP.Condition:Get('combat.time')('player')
end)

NeP.Condition:Register('cooldown.remains', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        return NeP.Condition:Get('spell.cooldown')(_, spell)
    else
        return 0
    end
end)

NeP.Condition:Register('cooldown.up', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        if NeP.Condition:Get('spell.cooldown')(_, spell) == 0 then
            return true
        end
    else
        return false
    end
end)

NeP.Condition:Register('action.cooldown_to_max', function(_, spell)
    local charges, maxCharges, start, duration = _G.GetSpellCharges(spell)
    if duration and charges ~= maxCharges then
        local charges_to_max = maxCharges - ( charges + ((_G.GetTime() - start) / duration))
        local cooldown = duration * charges_to_max
        return cooldown
    else
        return 0
    end
end)

NeP.Condition:Register('action.cooldown', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        return NeP.Condition:Get('spell.cooldown')(_, spell)
    else
        return 0
    end
end)

NeP.Condition:Register('action.charges', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        return NeP.Condition:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

NeP.Condition:Register('cooldown.charges', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        return NeP.Condition:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

NeP.Condition:Register('cooldown.recharge_time', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        return NeP.Condition:Get('spell.recharge')(_, spell)
    else
        return 0
    end
end)

NeP.Condition:Register('charges_fractional', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        return NeP.Condition:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

NeP.Condition:Register('spell_haste', function()
    local shaste = NeP.Condition:Get('haste')('player')
    return math.floor((100 / ( 100 + shaste )) * 10^3 ) / 10^3
end)

NeP.Condition:Register('gcd.remains', function()
    return NeP.Condition:Get('spell.cooldown')('player', '61304')
end)

NeP.Condition:Register('gcd.max', function()
    return NeP.Condition:Get('gcd')()
end)

NeP.Condition:Register('action.execute_time', function(_, spell)
    return NeP.Condition:Get('execute_time')(_, spell)
end)

NeP.Condition:Register('execute_time', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        local GCD = NeP.Condition:Get('gcd')()
        local CTT = NeP.Condition:Get('spell.casttime')(_, spell)
        if CTT > GCD then
            return CTT
        else
            return GCD
        end
    end
    return false
end)

NeP.Condition:Register('deficit', function()
    local max = _G.UnitPowerMax('player')
    local curr = _G.UnitPower('player')
    return (max - curr)
end)

NeP.Condition:Register('energy.deficit', function()
    return NeP.Condition:Get('deficit')()
end)

NeP.Condition:Register('focus.deficit', function()
    return NeP.Condition:Get('deficit')()
end)

NeP.Condition:Register('rage.deficit', function()
    return NeP.Condition:Get('deficit')()
end)

NeP.Condition:Register('astralpower.deficit', function()
    return NeP.Condition:Get('deficit')()
end)

NeP.Condition:Register('combo_points.deficit', function(target)
    return (_G.UnitPowerMax(target, _G.SPELL_POWER_COMBO_POINTS)) - (_G.UnitPower(target, _G.SPELL_POWER_COMBO_POINTS))
end)

NeP.Condition:Register('combo_points', function()
    return _G.GetComboPoints('player', 'target')
end)

NeP.Condition:Register('cast_regen', function(target, spell)
    local regen = select(2, _G.GetPowerRegen(target))
    local _, _, _, cast_time = _G.GetSpellInfo(spell)
    return math.floor(((regen * cast_time) / 1000) * 10^3 ) / 10^3
end)

NeP.Condition:Register('mana.pct', function()
    return NeP.Condition:Get('mana')('player')
end)

NeP.Condition:Register('max_energy', function()             --XXX: max_energy=1, this means that u will get energy cap in less than one GCD
    local ttm = NeP.Condition:Get('energy.time_to_max')()
    local GCD = NeP.Condition:Get('gcd')()
    if GCD > ttm then
        return 1
    else
        return false
    end
end)

NeP.Condition:Register('energy.regen', function()
    local eregen = select(2, _G.GetPowerRegen('player'))
    return eregen
end)

NeP.Condition:Register('energy.time_to_max', function()
    local deficit = NeP.Condition:Get('deficit')()
    local eregen = NeP.Condition:Get('energy.regen')()
    return deficit / eregen
end)

NeP.Condition:Register('focus.regen', function()
    local fregen = select(2, _G.GetPowerRegen('player'))
    return fregen
end)

NeP.Condition:Register('focus.time_to_max', function()
    local deficit = NeP.Condition:Get('deficit')()
    local fregen = NeP.Condition:Get('focus.regen')('player')
    return deficit / fregen
end)

NeP.Condition:Register('astralpower', function()
    return NeP.Condition:Get('lunarpower')('player')
end)

NeP.Condition:Register('runic_power', function()
    return NeP.Condition:Get('runicpower')('player')
end)

NeP.Condition:Register('holy_power', function()
    return NeP.Condition:Get('holypower')('player')
end)

NeP.Condition:Register('action.cast_time', function(_, spell)
    if NeP.Condition:Get('spell.exists')(_, spell) then
        return NeP.Condition:Get('spell.casttime')(_, spell)
    else
        return 0
    end
end)

NeP.Condition:Register('health.pct', function(target)
    return NeP.Condition:Get('health')(target)
end)

NeP.Condition:Register('active_enemies', function(unit, distance)
    return NeP.Condition:Get('area.enemies')(unit, distance)
end)

NeP.Condition:Register('talent.enabled', function(_, x,y)
    if NeP.Condition:Get('talent')(_, x,y) then
        return 1
    else
        return 0
    end
end)

NeP.Condition:Register('xequipped', function(item)
    if _G.IsEquippedItem(item) then
        return 1
    else
        return 0
    end
end)

NeP.Condition:Register('line_cd', function(_, spell)
    local spellID = NeP.Core:GetSpellID(spell)
    if Zylla.spell_timers[spellID] then
        return _G.GetTime() - Zylla.spell_timers[spellID].time
    end
    return 0
end)

--XXX: Protection Warrior Conditions

NeP.Condition:Register('ignorepain_cost', function()
    return Zylla.Scan_IgnorePain()
end)

NeP.Condition:Register('ignorepain_max', function()
    local ss = NeP.Condition:Get('health.max')('player')
    if _G.HasTalent(5,2) then
        return NeP.Core.Round((((77.86412474516502 * 1.70) * ss) / 100))
    else
        return NeP.Core.Round(((77.86412474516502 * ss) / 100))
    end
end)

--XXX: Feral Druid Conditions

local DotTicks = {
    [1] = {
        [1822] = 3,
        [1079] = 2,
        [106832] = 3,
    },
    [2] = {
        [8921] = 2,
        [155625] = 2,
    },
    [3] = {
        [195452] = 2,
    },
}

NeP.Condition:Register('dot.tick_time', function(_, spell)
    spell = NeP.Core:GetSpellID(spell)
    if not spell then return end
    local class = select(3,_G.UnitClass('player'))
    if class == 11 and _G.GetSpecialization() == 2 then
        if NeP.Condition:Get('talent')(nil, '5,3') and DotTicks[1][spell] then
            return DotTicks[1][spell] * 0.67
        else
            if DotTicks[1][spell] then
                return DotTicks[1][spell]
            else
                local tick = DotTicks[2][spell]
                return math.floor((tick / ((_G.GetHaste() / 100) + 1)) * 10^3 ) / 10^3
            end
        end
    else
        return DotTicks[3][spell]
    end
end)

NeP.Condition:Register('dot.pmultiplier', function(_, spell)
  return Zylla.f_Snapshots[spell:lower()][_G.UnitGUID('target')] or 0
end)

NeP.Condition:Register('persistent_multiplier', function(_, spell)
  return Zylla.f_Snapshots[spell:lower()].current or 1
end)

NeP.Condition:Register('f_test', function()	-- This is for debugging purposes.
	return Zylla.f_Snapshots
end)

--XXX: Warlock Conditions

NeP.Condition:Register('petexists', function()
  return NeP.Condition:Get('exists')('pet')
end)

NeP.Condition:Register('warlock.remaining_duration', function(demon)
    return Zylla.remaining_duration(demon)
end)

NeP.Condition:Register('warlock.count', function(demon)
    return Zylla.count_active_demon_type(demon)
end)

NeP.Condition:Register('warlock.active_pets_list', function()
    return Zylla.active_demons
end)

NeP.Condition:Register('warlock.sorted_pets_list', function()
    return Zylla.demons_sorted
end)

NeP.Condition:Register('warlock.demon_count', function()
    return Zylla.demon_count
end)

--NeP.Condition:Register('warlock.no_de', function(demon)
-- return Zylla.Empower_no_de(demon)
--end)

NeP.Condition:Register('soul_shard', function()
    return NeP.Condition:Get('soulshards')('player')
end)

--XXX: Priest Conditions

NeP.Condition:Register('variable.actors_fight_time_mod', function()
    local time = NeP.Condition:Get('xtime')()
    local target_time_to_die = NeP.Condition:Get('time_to_die')('target')
    -- time+target.time_to_die>450&time+target.time_to_die<600
    if (time + target_time_to_die)>450 and (time + target_time_to_die)<600 then
        -- -((-(450)+(time+target.time_to_die))%10)
        return -(( -(450) +( time + target_time_to_die)) / 10)
            -- time+target.time_to_die<=450
    elseif time + target_time_to_die<=450 then
        -- ((450-(time+target.time_to_die))%5)
        return ((450 - (time + target_time_to_die)) / 5)
    end
    return 0
end)

NeP.Condition:Register('shadowy_apparitions_in_flight', function()
    return Zylla.SA_TOTAL
end)

NeP.Condition:Register('insanity_drain_stacks', function()
    return Zylla.Voidform_Drain_Stacks
end)

NeP.Condition:Register('current_insanity_drain', function()
    return Zylla.Voidform_Current_Drain_Rate
end)

--{current_insanity_drain*gcd.max>player.insanity}&{player.insanity-{current_insanity_drain*gcd.max}+90}<100

--XXX: Rogue Conditions

NeP.Condition:Register('stealthed', function()
    if NeP.Condition:Get('buff')('player', 'Shadow Dance') or NeP.Condition:Get('buff')('player', 'Stealth') or NeP.Condition:Get('buff')('player', 'Subterfuge') or NeP.Condition:Get('buff')('player', 'Shadowmeld') or NeP.Condition:Get('buff')('player', 'Prowl') then
        return true
    else
        return false
    end
end)

NeP.Condition:Register('variable.ssw_er', function()
    local range_check
    if NeP.Condition:Get('range')('target') then
        range_check = NeP.Condition:Get('range')('target')
    else
        range_check = 0
    end
    local x = (NeP.Condition:Get('xequipped')('137032') * (10 + (range_check * 0.5)))
    return x
end)

NeP.Condition:Register('variable.ed_threshold', function()
    local x = (NeP.Condition:Get('energy.deficit')()<=((20 + NeP.Condition:Get('talent.enabled')(nil, '3,3')) * (35 + NeP.Condition:Get('talent.enabled')(nil, '7,1')) * (25 + NeP.Condition:Get('variable.ssw_er')())))
    return x
end)

NeP.Condition:Register('RtB', function()
    local int = 0
    local bearing = false
    local shark = false

    -- Shark Infested Waters
    if _G.UnitBuff('player', _G.GetSpellInfo(193357)) then
        shark = true
        int = int + 1
    end

    -- True Bearing
    if _G.UnitBuff('player', _G.GetSpellInfo(193359)) then
        bearing = true
        int = int + 1
    end

    -- Jolly Roger
    if _G.UnitBuff('player', _G.GetSpellInfo(199603)) then
        int = int + 1
    end

    -- Grand Melee
    if _G.UnitBuff('player', _G.GetSpellInfo(193358)) then
        int = int + 1
    end

    -- Buried Treasure
    if _G.UnitBuff('player', _G.GetSpellInfo(199600)) then
        int = int + 1
    end

    -- Broadsides
    if _G.UnitBuff('player', _G.GetSpellInfo(193356)) then
        int = int + 1
    end

    -- If all six buffs are active:
    if int == 6 then
        return true --"LEEEROY JENKINS!"

    -- If two or Shark/Bearing and AR/Curse active:
    elseif int == 2 or int == 3 or ((bearing or shark) and ((_G.UnitBuff("player", _G.GetSpellInfo(13750)) or _G.UnitDebuff("player", _G.GetSpellInfo(202665))))) then
        return true --"Keep."

    --[[
	If only True Bearing
	elseif bearing then
	return true --"Keep. AR/Curse if ready."
    --]]

	-- If only Shark or True Bearing and CDs ready
    elseif (bearing or shark) and ((_G.GetSpellCooldown(13750) == 0) or (_G.GetSpellCooldown(202665) == 0)) then
        return true --"AR/Curse NOW and keep!"

	--if we have only ONE bad buff BUT AR/curse is active:
    elseif int ==1 and ((_G.UnitBuff("player", _G.GetSpellInfo(13750)) or _G.UnitDebuff("player", _G.GetSpellInfo(202665)))) then
        return true

	-- If only one bad buff:
    else return false	--"Reroll now!"
    end
end)

--XXX: Hunter Conditions

NeP.Condition:Register('maxRange', function(spell)
    local _, _, _, _, _, maxRange = _G.GetSpellInfo(spell)
    if maxRange == nil then return false end
    return maxRange
end)

NeP.Condition:Register('variable.safe_to_build', function()
    local x = NeP.Condition:Get('debuff')('target','Hunter\'s Mark')
    local y = NeP.Condition:Get('buff')('player','Trueshot')
    local z = NeP.Condition:Get('buff')('player','Marking Targets')
    if x == nil or (y == nil and z == nil) then
        return true
    end
    return false
end)

NeP.Condition:Register('variable.use_multishot', function()
    local x = NeP.Condition:Get('buff')('player','Marking Targets')
    local y = NeP.Condition:Get('buff')('player','Trueshot')
    local z = NeP.Condition:Get('area.enemies')('target','8')
    if ((x or y) and z>=1) or (x == nil and y == nil and z>=2) then
        return true
    end
    return false
end)

NeP.Condition:Register('travel_time', function(unit, spell)
    return Zylla.TravelTime(unit, spell)
end)

NeP.Condition:Register('inareaid', function()
    return  _G.GetCurrentMapAreaID()
end)

NeP.Condition:Register("set_bonus", function(_, set)
	local class = select(2,_G.UnitClass('player'))
	local pieces = Zylla.setsTable[class][set] or {}
	local counter = 0
	for _, itemID in ipairs(pieces) do
		if _G.IsEquippedItem(itemID) then
			counter = counter + 1
			--print(counter)
		end
	end
	return counter
end)

NeP.Condition:Register('partycheck', function()
  if _G.IsInRaid() then
    return 3
  elseif _G.IsInGroup() then
    return 2
  else
    return 1
  end
end)

NeP.Condition:Register('artifact.zenabled', function(_, spell)
    if select(10,NeP.Artifact:TraitInfo(spell)) then
        return 1
    else
        return 0
    end
end)
