local _, Zylla = ...

local strmatch = _G.strmatch
local gsub = _G.gsub
local IsFlying = _G.IsFlying
local GetCurrentMapAreaID = _G.GetCurrentMapAreaID
local IsIndoors = _G.IsIndoors
local GetUnitSpeed = _G.GetUnitSpeed
local UnitDebuff = _G.UnitDebuff
local GetTime = _G.GetTime
local GetSpellCharges = _G.GetSpellCharges
local UnitPowerMax = _G.UnitPowerMax
local UnitPower = _G.UnitPower
local GetComboPoints = _G.GetComboPoints
local GetPowerRegen = _G.GetPowerRegen
local GetSpellInfo = _G.GetSpellInfo
local IsEquippedItem = _G.IsEquippedItem
local UnitClass = _G.UnitClass
local HasTalent = _G.HasTalent
local UnitBuff = _G.UnitBuff
local GetSpellCooldown = _G.GetSpellCooldown
local GetMasteryEffect = _G.GetMasteryEffect
local GetCritChance = _G.GetCritChance
local UnitStat = _G.UnitStat
local GetCombatRatingBonus = _G.GetCombatRatingBonus
local IsInRaid = _G.IsInRaid
local IsInGroup = _G.IsInGroup

--------------------------------------------------------------------------------
-----------------------------------MISC CONDITIONS------------------------------
--------------------------------------------------------------------------------

--/dump NeP.DSL:Get('nfly')()  Thanks to [EU]Noel on Discord for this function.
NeP.DSL:Register('nfly', function()
  return IsFlying()
end)

--/dump NeP.DSL:Get('map_area_id')()
NeP.DSL:Register('map_area_id', function()
    return  GetCurrentMapAreaID()
end)

--/dump NeP.DSL:Get('casting.left')('player', 'Fireball')
NeP.DSL:Register('casting.left', function(target, spell)
    local reverse = NeP.DSL:Get('casting.percent')(target, spell)
    if reverse ~= 0 then
        return 100 - reverse
    end
    return 0
end)

--/dump NeP.DSL:Get('indoors')()
NeP.DSL:Register('indoors', function()
    return IsIndoors()
end)
--------------------------------------------------------------------------------
--------------------------------SimulationCraft CONDITIONS----------------------
--------------------------------------------------------------------------------
--/dump NeP.DSL:Get('buff.react')('player','Incanter\'s Flow')
NeP.DSL:Register('buff.react', function(target, spell)
  local x = NeP.DSL:Get('buff.count')(target, spell)
  if x == 1 then
    return true
  elseif x == 0 then
    return false
  else
    return x
  end
end)

NeP.DSL:Register('xmoving', function()
    local speed = GetUnitSpeed('player')
    if speed ~= 0 then
        return 1
    else
        return 0
    end
end)

--[[
local classTaunt = {
  [1] = 'Taunt',
  [2] = 'Hand of Reckoning',
  [6] = 'Dark Command',
  [10] = 'Provoke',
  [11] = 'Growl',
  [12] = 'Torment'
}
--]]

local PowerT = {
    [0] = ('^.-Mana'),
    [1] = ('^.-Rage'),
    [2] = ('^.-Focus'),
    [3] = ('^.-Energy'),
}

--/dump NeP.DSL:Get('action.cost')(nil,'Rake')
--/dump NeP.DSL:Get('action.cost')(nil, 'Rejuvenation')
NeP.DSL:Register('action.cost', function(_, spell)
    local costText = Zylla.Scan_SpellCost(spell)
    local numcost = 0
    for i = 0, 3 do
        local cost = strmatch(costText, PowerT[i])
        if cost ~= nil then
            numcost = gsub(cost, '%D', '') + 0
        end
    end
    if numcost > 0 then
        return numcost
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('dot.refreshable')('target','Nightblade')
NeP.DSL:Register('dot.refreshable', function(_, spell)
    local _,_,_,_,_,duration,expires,_,_,_,spellID = UnitDebuff('target', spell, nil, 'PLAYER|HARMFUL')
    if spellID and expires then
        local time_left = expires - GetTime()
        if time_left < (duration/3) then
            return true
        end
    end
    return false
end)

--/dump NeP.DSL:Get('dot.duration')('target','Doom')
NeP.DSL:Register('dot.duration', function(target, spell)
    local debuff,_,duration,_,caster = Zylla.UnitDot(target, spell, _)
    if debuff and (caster == 'player' or caster == 'pet') then
        return duration
    end
    return 0
end)

--/dump NeP.DSL:Get('debuff')('target', 'Deep Wounds')
--/dump NeP.DSL:Get('dot.ticking')('target', 'Deep Wounds')
NeP.DSL:Register('dot.ticking', function(target, spell)
    if NeP.DSL:Get('debuff')(target, spell) then
        return true
    else
        return false
    end
end)

--/dump NeP.DSL:Get('dot.remains')('target','Rip')
NeP.DSL:Register('dot.remains', function(target, spell)
    return NeP.DSL:Get('debuff.duration')(target, spell)
end)
--[[
NeP.DSL:Register('dot.ticks_remain', function(target, spell)
    end)

NeP.DSL:Register('dot.current_ticks', function(target, spell)
    end)

NeP.DSL:Register('dot.ticks', function(target, spell)
    end)

NeP.DSL:Register('dot.tick_time_remains', function(target, spell)
    end)

NeP.DSL:Register('dot.active_dot', function(target, spell)
    end)
]]--
--/dump NeP.DSL:Get('buff.up')('player','Incanter\'s Flow')
--/dump NeP.DSL:Get('buff')('player','Rejuvenation')
--/dump NeP.DSL:Get('debuff')('target','Sunfire')
NeP.DSL:Register('buff.up', function(target, spell)
    local x = NeP.DSL:Get('buff.count')(target, spell)
    if x == 1 then
        return true
    elseif x == 0 then
        return false
    else
        return x
    end
end)

--/dump NeP.DSL:Get('buff.stack')('player','Incanter\'s Flow')
NeP.DSL:Register('buff.stack', function(target, spell)
    return NeP.DSL:Get('buff.count')(target, spell)
end)

--/dump NeP.DSL:Get('buff.remains')('pet','Demonic Empowerment')
NeP.DSL:Register('buff.remains', function(target, spell)
    return NeP.DSL:Get('buff.duration')(target, spell)
end)

NeP.DSL:Register('debuff.up', function(target, spell)
    local x = NeP.DSL:Get('debuff.count')(target, spell)
    if x == 1 then
        return true
    elseif x == 0 then
        return false
    else
        return x
    end
end)

--/dump NeP.DSL:Get('debuff.stack')('target','Thrash')
NeP.DSL:Register('debuff.stack', function(target, spell)
    return NeP.DSL:Get('debuff.count')(target, spell)
end)

--/dump UnitDebuff('target', 'Thrash')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Thrash')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Rake')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Rip')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Moonfire')
NeP.DSL:Register('debuff.remains', function(target, spell)
    return NeP.DSL:Get('debuff.duration')(target, spell)
end)

--TODO: work out off gcd/gcd only skills now all of this is just like SiMC 'prev'

--/dump NeP.DSL:Get('prev_off_gcd')('player', 'Water Jet')
NeP.DSL:Register('prev_off_gcd', function(_, spell)
    return NeP.DSL:Get('lastcast')('player', spell)
end)

--/dump NeP.DSL:Get('prev_gcd')(nil, 'Shadowstrike')
--/dump NeP.DSL:Get('lastcast')('player', 'Fireball')
NeP.DSL:Register('prev_gcd', function(_, spell)
    return NeP.DSL:Get('lastgcd')('player', spell)
end)

--/dump NeP.DSL:Get('prev')('player', 'Thrash')
NeP.DSL:Register('prev', function(_, spell)
    return NeP.DSL:Get('lastcast')('player', spell)
        --end
end)

--/dump NeP.DSL:Get('time_to_die')('target')
NeP.DSL:Register('time_to_die', function(target)
    return NeP.DSL:Get('deathin')(target)
end)

--/dump NeP.DSL:Get('xtime')()
NeP.DSL:Register('xtime', function()
    return NeP.DSL:Get('combat.time')('player')
end)

--/dump NeP.DSL:Get('spell.cooldown')('player', '61304')
--/dump NeP.DSL:Get('cooldown.remains')('player','Mind Blast')
NeP.DSL:Register('cooldown.remains', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.cooldown')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('spell.exists')('player','Vanish')
--/dump NeP.DSL:Get('cooldown.up')('player','Vanish')
--/dump NeP.DSL:Get('spell.cooldown')('player','Vanish')
NeP.DSL:Register('cooldown.up', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        if NeP.DSL:Get('spell.cooldown')(_, spell) == 0 then
            return true
        end
    else
        return false
    end
end)

--/dump GetSpellCooldown(61304)
--/dump GetSpellCharges(108853)
--/dump GetSpellCharges(116011)
--/dump NeP.DSL:Get('action.cooldown_to_max')('player','Fire Blast')
--/dump NeP.DSL:Get('action.cooldown_to_max')('player','Rune of Power')
--/dump NeP.DSL:Get('action.cooldown_to_max')('player','Frost Nova')
--/dump NeP.DSL:Get('spell.recharge')('player','Fire Blast')
--/dump NeP.DSL:Get('spell.charges')('player','Fire Blast')
NeP.DSL:Register('action.cooldown_to_max', function(_, spell)
    local charges, maxCharges, start, duration = GetSpellCharges(spell)
    if duration and charges ~= maxCharges then
        local charges_to_max = maxCharges - ( charges + ((GetTime() - start) / duration))
        local cooldown = duration * charges_to_max
        return cooldown
    else
        return 0
    end
end)

--/dump GetSpellBaseCooldown(61304)
--return GetSpellBaseCooldown(spellID) / 1000
--/dump NeP.DSL:Get('action.cooldown')('player','Fire Blast')
NeP.DSL:Register('action.cooldown', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.cooldown')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('action.charges')('player','Fire Blast')
NeP.DSL:Register('action.charges', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('cooldown.charges')('player','Fire Blast')
NeP.DSL:Register('cooldown.charges', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('cooldown.recharge_time')('player','Fire Blast')
NeP.DSL:Register('cooldown.recharge_time', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.recharge')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('charges_fractional')('player','Phoenix\'s Flames')
NeP.DSL:Register('charges_fractional', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('spell_haste')()
NeP.DSL:Register('spell_haste', function()
    local shaste = NeP.DSL:Get('haste')('player')
    return math.floor((100 / ( 100 + shaste )) * 10^3 ) / 10^3
end)

--/dump NeP.DSL:Get('gcd.remains')()
NeP.DSL:Register('gcd.remains', function()
    return NeP.DSL:Get('spell.cooldown')('player', '61304')
end)

--/dump NeP.DSL:Get('gcd.max')()
NeP.DSL:Register('gcd.max', function()
    return NeP.DSL:Get('gcd')()
end)

--/dump NeP.DSL:Get('action.execute_time')('player','Aimed Shot')
--/dump NeP.DSL:Get('action.execute_time')('player','Shadow Bolt')

NeP.DSL:Register('action.execute_time', function(_, spell)
    return NeP.DSL:Get('execute_time')(_, spell)
end)

NeP.DSL:Register('execute_time', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        local GCD = NeP.DSL:Get('gcd')()
        local CTT = NeP.DSL:Get('spell.casttime')(_, spell)
        if CTT > GCD then
            return CTT
        else
            return GCD
        end
    end
    return false
end)

--/dump NeP.DSL:Get('deficit')()
NeP.DSL:Register('deficit', function()
    local max = UnitPowerMax('player')
    local curr = UnitPower('player')
    return (max - curr)
end)

--/dump NeP.DSL:Get('energy.deficit')()
NeP.DSL:Register('energy.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('focus.deficit')()
NeP.DSL:Register('focus.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('rage.deficit')()
NeP.DSL:Register('rage.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('astral_power.deficit')()
NeP.DSL:Register('astral_power.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('combo_points.deficit')()
NeP.DSL:Register('combo_points.deficit', function(target)
    return (UnitPowerMax(target, SPELL_POWER_COMBO_POINTS)) - (UnitPower(target, SPELL_POWER_COMBO_POINTS))
end)

--/dump NeP.DSL:Get('combo_points')()
NeP.DSL:Register('combo_points', function()
    return GetComboPoints('player', 'target')
end)

--/dump NeP.DSL:Get('cast_regen')('player', 'Shockwave')
NeP.DSL:Register('cast_regen', function(target, spell)
    local regen = select(2, GetPowerRegen(target))
    local _, _, _, cast_time = GetSpellInfo(spell)
    return math.floor(((regen * cast_time) / 1000) * 10^3 ) / 10^3
end)

--/dump NeP.DSL:Get('mana.pct')()
NeP.DSL:Register('mana.pct', function()
    return NeP.DSL:Get('mana')('player')
end)

--max_energy=1, this means that u will get energy cap in less than one GCD
--/dump NeP.DSL:Get('max_energy')('player')
NeP.DSL:Register('max_energy', function()
    local ttm = NeP.DSL:Get('energy.time_to_max')()
    local GCD = NeP.DSL:Get('gcd')()
    if GCD > ttm then
        return 1
    else
        return false
    end
end)

--/dump NeP.DSL:Get('energy.regen')()
NeP.DSL:Register('energy.regen', function()
    local eregen = select(2, GetPowerRegen('player'))
    return eregen
end)

--/dump NeP.DSL:Get('energy.time_to_max')()
NeP.DSL:Register('energy.time_to_max', function()
    local deficit = NeP.DSL:Get('deficit')()
    local eregen = NeP.DSL:Get('energy.regen')()
    return deficit / eregen
end)

--/dump NeP.DSL:Get('focus.regen')()
NeP.DSL:Register('focus.regen', function()
    local fregen = select(2, GetPowerRegen('player'))
    return fregen
end)

--/dump NeP.DSL:Get('focus.time_to_max')()
NeP.DSL:Register('focus.time_to_max', function()
    local deficit = NeP.DSL:Get('deficit')()
    local fregen = NeP.DSL:Get('focus.regen')('player')
    return deficit / fregen
end)

--/dump NeP.DSL:Get('astral_power')()
NeP.DSL:Register('astral_power', function()
    return NeP.DSL:Get('lunarpower')('player')
end)

--/dump NeP.DSL:Get('runic_power')()
NeP.DSL:Register('runic_power', function()
    return NeP.DSL:Get('runicpower')('player')
end)

--/dump NeP.DSL:Get('holy_power')()
NeP.DSL:Register('holy_power', function()
    return NeP.DSL:Get('holypower')('player')
end)

--/dump NeP.DSL:Get('action.cast_time')('player','Frostbolt')
NeP.DSL:Register('action.cast_time', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.casttime')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('health.pct')('player')
NeP.DSL:Register('health.pct', function(target)
    return NeP.DSL:Get('health')(target)
end)

NeP.DSL:Register('active_enemies', function(unit, distance)
    return NeP.DSL:Get('area.enemies')(unit, distance)
end)

--/dump NeP.DSL:Get('talent.enabled')(nil, '4,2')
NeP.DSL:Register('talent.enabled', function(_, x,y)
    if NeP.DSL:Get('talent')(_, x,y) then
        return 1
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('xequipped')(2575)
NeP.DSL:Register('xequipped', function(item)
    if IsEquippedItem(item) then
        return 1
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('line_cd')(_, 'Cobra Shot')
NeP.DSL:Register('line_cd', function(_, spell)
    local spellID = NeP.Core:GetSpellID(spell)
    if Zylla.spell_timers[spellID] then
        return GetTime() - Zylla.spell_timers[spellID].time
    end
    return 0
end)

--------------------------------------------------------------------------------
---------------------------------PROT WARRIOR CONDITIONS------------------------
--------------------------------------------------------------------------------

--UnitBuff(Unit,GetSpellInfo(SpellID))
--/dump GetSpellInfo(190456)
--/dump UnitBuff('player',GetSpellInfo(190456))

--/dump NeP.DSL:Get('ignorepain_cost')()
NeP.DSL:Register('ignorepain_cost', function()
    return Zylla.Scan_IgnorePain()
end)

--/dump NeP.DSL:Get['ignorepain_max')()
NeP.DSL:Register('ignorepain_max', function()
    local ss = NeP.DSL:Get('health.max')('player')
    if HasTalent(5,2) then
        return NeP.Core.Round((((77.86412474516502 * 1.70) * ss) / 100))
    else
        return NeP.Core.Round(((77.86412474516502 * ss) / 100))
    end
end)

--------------------------------------------------------------------------------
---------------------------------FERAL DRUID CONDITIONS-------------------------
--------------------------------------------------------------------------------

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

--/dump NeP.DSL:Get('dot.tick_time')(_, 'Moonfire')
NeP.DSL:Register('dot.tick_time', function(_, spell)
    spell = NeP.Core:GetSpellID(spell)
    if not spell then return end
    local class = select(3,UnitClass('player'))
    if class == 11 and GetSpecialization() == 2 then
        if NeP.DSL:Get('talent')(nil, '6,2') and DotTicks[1][spell] then
            return DotTicks[1][spell] * 0.67
        else
            if DotTicks[1][spell] then
                return DotTicks[1][spell]
            else
                local tick = DotTicks[2][spell]
                return math.floor((tick / ((GetHaste() / 100) + 1)) * 10^3 ) / 10^3
            end
        end
    else
        return DotTicks[3][spell]
    end
end)

--/dump NeP.DSL:Get('dot.pmultiplier')(nil, 'Rip')
NeP.DSL:Register('dot.pmultiplier', function(_, spell)
    local GUID = UnitGUID('target')
    local name = string.lower(spell)
    if Zylla.f_Snapshots[name][GUID] then
      return Zylla.f_Snapshots[name][GUID]
    else
      return 0
    end
end)

--/dump NeP.DSL:Get('persistent_multiplier')(nil, 'Rip')
NeP.DSL:Register('persistent_multiplier', function(_, spell)
  local name = string.lower(spell)
  if Zylla.f_Snapshots[name].current then
    return Zylla.f_Snapshots[name].current
  else
    return 1
  end
end)

--/dump NeP.DSL:Get('f_test')()
NeP.DSL:Register('f_test', function()
  return Zylla.f_Snapshots
end)

--------------------------------------------------------------------------------
--------------------------------WARLOCK CONDITIONS------------------------------
--------------------------------------------------------------------------------

NeP.DSL:Register('petexists', function()
  return NeP.DSL:Get('exists')('pet')
end)

--/dump NeP.DSL:Get('warlock.remaining_duration')('Dreadstalker')
--/dump NeP.DSL:Get('warlock.remaining_duration')('Wild Imp')
NeP.DSL:Register('warlock.remaining_duration', function(demon)
    return Zylla.remaining_duration(demon)
end)

--/dump NeP.DSL:Get('warlock.count')('Wild Imp')
NeP.DSL:Register('warlock.count', function(demon)
    return Zylla.count_active_demon_type(demon)
end)

--------------------------------------------------------------------------------

--/dump NeP.DSL:Get('warlock.active_pets_list')()
NeP.DSL:Register('warlock.active_pets_list', function()
    return Zylla.active_demons
end)

--/dump NeP.DSL:Get('warlock.sorted_pets_list')()
NeP.DSL:Register('warlock.sorted_pets_list', function()
    return Zylla.demons_sorted
end)

--/dump NeP.DSL:Get('warlock.demon_count')()
NeP.DSL:Register('warlock.demon_count', function()
    return Zylla.demon_count
end)

--GetNotDemonicEmpoweredDemonsCount
--/dump NeP.DSL:Get('warlock.no_de')()
--NeP.DSL:Register('warlock.no_de', function(demon)
-- return Zylla.Empower_no_de(demon)
--end)

--/dump NeP.DSL:Get('soul_shard')()
NeP.DSL:Register('soul_shard', function()
    return NeP.DSL:Get('soulshards')('player')
end)

--------------------------------------------------------------------------------
-------------------------------- PRIEST CONDITIONS------------------------------
--------------------------------------------------------------------------------

--actions+=/variable,op=set,name=actors_fight_time_mod,value=0
--actions+=/variable,op=set,name=actors_fight_time_mod,value=-((-(450)+(time+target.time_to_die))%10),if=time+target.time_to_die>450&time+target.time_to_die<600
--actions+=/variable,op=set,name=actors_fight_time_mod,value=((450-(time+target.time_to_die))%5),if=time+target.time_to_die<=450

--/dump NeP.DSL:Get('variable.actors_fight_time_mod')()
NeP.DSL:Register('variable.actors_fight_time_mod', function()
    local time = NeP.DSL:Get('xtime')()
    local target_time_to_die = NeP.DSL:Get('time_to_die')('target')
    -- time+target.time_to_die>450&time+target.time_to_die<600
    if (time + target_time_to_die)>450 and (time + target_time_to_die)<600 then
        -- -((-(450)+(time+target.time_to_die))%10)
        return -(( -(450) +( time + target_time_to_die)) / 10)
            -- time+target.time_to_die<=450
    elseif time + target_time_to_die<=450 then
        -- ((450-(time+target.time_to_die))%5)
        return ((450 - (time + target_time_to_die)) / 5)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('shadowy_apparitions_in_flight')()
NeP.DSL:Register('shadowy_apparitions_in_flight', function()
    local x = Zylla.SA_TOTAL
    return x
end)

NeP.DSL:Register('parser_bypass1', function()
    --player.insanity-current_insanity_drain*gcd.max
    local x = (NeP.DSL:Get('insanity')('player') - (NeP.DSL:Get('current_insanity_drain')() * NeP.DSL:Get('gcd.max')()))
    return x
end)

--/dump NeP.DSL:Get('insanity_drain_stacks')()
NeP.DSL:Register('insanity_drain_stacks', function()
    local x = Zylla.Voidform_Drain_Stacks
    return x
end)

--/dump NeP.DSL:Get('current_insanity_drain')()
NeP.DSL:Register('current_insanity_drain', function()
    local x = Zylla.Voidform_Current_Drain_Rate
    return x
end)

--{current_insanity_drain*gcd.max>player.insanity}&{player.insanity-{current_insanity_drain*gcd.max}+90}<100
--/dump (NeP.DSL:Get('current_insanity_drain')() * NeP.DSL:Get('gcd.max')())>NeP.DSL:Get('insanity')('player')
--/dump (NeP.DSL:Get('insanity')('player') - (NeP.DSL:Get('current_insanity_drain')() * NeP.DSL:Get('gcd.max')()) + 90)<100

--------------------------------------------------------------------------------
--------------------------------- ROGUE CONDITIONS------------------------------
--------------------------------------------------------------------------------

NeP.DSL:Register('parser_bypass2', function()
    local x = NeP.DSL:Get('xtime')()
    if x<10 then
        return 1
    else
        return 0
    end
end)

NeP.DSL:Register('parser_bypass3', function()
    local x = NeP.DSL:Get('xtime')()
    if x>=10 then
        return 1
    else
        return 0
    end
end)

NeP.DSL:Register('stealthed', function()
    if NeP.DSL:Get('buff')('player', 'Shadow Dance') or NeP.DSL:Get('buff')('player', 'Stealth') or NeP.DSL:Get('buff')('player', 'Subterfuge') or NeP.DSL:Get('buff')('player', 'Shadowmeld') or NeP.DSL:Get('buff')('player', 'Prowl') then
        return true
    else
        return false
    end
end)

--/dump NeP.DSL:Get('variable.ssw_er')()
NeP.DSL:Register('variable.ssw_er', function()
    --actions=variable,name=ssw_er,value=equipped.shadow_satyrs_walk*(10+floor(target.distance*0.5))
    local range_check
    if NeP.DSL:Get('range')('target') then
        range_check = NeP.DSL:Get('range')('target')
    else
        range_check = 0
    end
    local x = (NeP.DSL:Get('xequipped')('137032') * (10 + (range_check * 0.5)))
    return x
end)

--/dump NeP.DSL:Get('variable.ed_threshold')()
NeP.DSL:Register('variable.ed_threshold', function()
    --actions+=/variable,name=ed_threshold,value=energy.deficit<=(20+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+variable.ssw_er)
    local x = (NeP.DSL:Get('energy.deficit')()<=((20 + NeP.DSL:Get('talent.enabled')(nil, '3,3')) * (35 + NeP.DSL:Get('talent.enabled')(nil, '7,1')) * (25 + NeP.DSL:Get('variable.ssw_er')())))
    return x
end)

NeP.DSL:Register('RtB', function()
    local int = 0
    local bearing = false
    local shark = false

    -- Shark Infested Waters
    if UnitBuff('player', GetSpellInfo(193357)) then
        shark = true
        int = int + 1
    end

    -- True Bearing
    if UnitBuff('player', GetSpellInfo(193359)) then
        bearing = true
        int = int + 1
    end

    -- Jolly Roger
    if UnitBuff('player', GetSpellInfo(199603)) then
        int = int + 1
    end

    -- Grand Melee
    if UnitBuff('player', GetSpellInfo(193358)) then
        int = int + 1
    end

    -- Buried Treasure
    if UnitBuff('player', GetSpellInfo(199600)) then
        int = int + 1
    end

    -- Broadsides
    if UnitBuff('player', GetSpellInfo(193356)) then
        int = int + 1
    end

    -- If all six buffs are active:
    if int == 6 then
        return true --"LEEEROY JENKINS!"

    -- If two or Shark/Bearing and AR/Curse active:
    elseif int == 2 or int == 3 or ((bearing or shark) and ((UnitBuff("player", GetSpellInfo(13750)) or UnitDebuff("player", GetSpellInfo(202665))))) then
        return true --"Keep."

    --[[
	If only True Bearing
	elseif bearing then
	return true --"Keep. AR/Curse if ready."
    --]]

	-- If only Shark or True Bearing and CDs ready
    elseif (bearing or shark) and ((GetSpellCooldown(13750) == 0) or (GetSpellCooldown(202665) == 0)) then
        return true --"AR/Curse NOW and keep!"

	--if we have only ONE bad buff BUT AR/curse is active:
    elseif int ==1 and ((UnitBuff("player", GetSpellInfo(13750)) or UnitDebuff("player", GetSpellInfo(202665)))) then
        return true

	-- If only one bad buff:
    else return false	--"Reroll now!"
    end
end)

--------------------------------------------------------------------------------
--------------------------------- HUNTER CONDITIONS-----------------------------
--------------------------------------------------------------------------------

--/dump NeP.DSL:Get('maxRange')(spellID)  -- This is used to get a spells maxRange
NeP.DSL:Register('maxRange', function(spell)
    local _, _, _, _, _, maxRange = GetSpellInfo(spell)
    if maxRange == nil then return false end
    return maxRange
end)

--/dump NeP.DSL:Get('variable.safe_to_build')()
--actions+=/variable,name=safe_to_build,value=debuff.hunters_mark.down|(buff.trueshot.down&buff.marking_targets.down)
NeP.DSL:Register('variable.safe_to_build', function()
    local x = NeP.DSL:Get('debuff')('target','Hunter\'s Mark')
    local y = NeP.DSL:Get('buff')('player','Trueshot')
    local z = NeP.DSL:Get('buff')('player','Marking Targets')
    if x == nil or (y == nil and z == nil) then
        return true
    end
    return false
end)

--/dump NeP.DSL:Get('variable.use_multishot')()
--actions+=/variable,name=use_multishot,value=((buff.marking_targets.up|buff.trueshot.up)&spell_targets.multishot>1)|(buff.marking_targets.down&buff.trueshot.down&spell_targets.multishot>2)
NeP.DSL:Register('variable.use_multishot', function()
    local x = NeP.DSL:Get('buff')('player','Marking Targets')
    local y = NeP.DSL:Get('buff')('player','Trueshot')
    local z = NeP.DSL:Get('area.enemies')('target','8')
    if ((x or y) and z>=1) or (x == nil and y == nil and z>=2) then
        return true
    end
    return false
end)

--/dump NeP.DSL:Get('travel_time')('target','Frostbolt')
NeP.DSL:Register('travel_time', function(unit, spell)
    return Zylla.TravelTime(unit, spell)
end)

--  inareaid = ID
--/dump NeP.DSL:Get('inareaid')()
NeP.DSL:Register('inareaid', function()
    return  GetCurrentMapAreaID()
end)

local setsTable = {
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

--{'set_bonus(T19)=2||set_bonus(T19)>=4'}
--/dump NeP.DSL:Get('set_bonus')('player', 'T19')
NeP.DSL:Register("set_bonus", function(_, set)
	local class = select(2,UnitClass('player'))
	local pieces = setsTable[class][set] or {}
	local counter = 0
	for _, itemID in ipairs(pieces) do
		if IsEquippedItem(itemID) then
			counter = counter + 1
			--print(counter)
		end
	end
	return counter
end)

--[[
RABBS CONDITIONS BELOW
]]--
NeP.DSL:Register('rejuvraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*10)
end)

NeP.DSL:Register('germraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*4.9/((NeP.DSL:Get('mana')('player')/100)^.66))*3
end)

NeP.DSL:Register('htraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*4.9/((NeP.DSL:Get('mana')('player')/100)^.4))*1.5
end)

NeP.DSL:Register('wgraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*4.9)*2
end)

NeP.DSL:Register('regrowthraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*4.9/((NeP.DSL:Get('mana')('player')/100)^1.25))*5
end)

NeP.DSL:Register('smraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*4.9)*3
end)

NeP.DSL:Register('cwraid.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*8)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('rejuvparty.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*5.5)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('htparty.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*4)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('htpartytank.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*3)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('htpartyhealer.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*3.2)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('htpartydamager.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*3.2)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('wgparty.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*4.5)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('regrowthparty.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*7)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('regrowthpartytank.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*6.6)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('regrowthpartyhealer.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*6.8)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('regrowthpartydamager.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*7)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('smparty.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*6)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('cwparty.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*6)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('rejuvsolo.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*4)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('htsolo.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*3)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('wgsolo.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*5.5)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('regrowthsolo.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*5)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('smsolo.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*5.5)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('cwsolo.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetMasteryEffect()*2)^2/NeP.DSL:Get('mana')('player'))
end)


NeP.DSL:Register('chainheal.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)*GetCombatRatingBonus(CR_CRIT_SPELL)*1.2)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('healingsurge.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)*GetCombatRatingBonus(CR_CRIT_SPELL)*1.44)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('healingwave.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)*GetCombatRatingBonus(CR_CRIT_SPELL)*1.44)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('riptide.heals', function()
    return math.sqrt((UnitStat("player", 4)*GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)*GetCombatRatingBonus(CR_CRIT_SPELL)*1.6)^2/NeP.DSL:Get('mana')('player'))
end)

NeP.DSL:Register('holyshockraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*3)
end)

NeP.DSL:Register('holyshockparty.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*3)
end)

NeP.DSL:Register('holyshocksolo.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*3)
end)

NeP.DSL:Register('bfraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*6)
end)

NeP.DSL:Register('bfshockparty.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*6)
end)

NeP.DSL:Register('bfshocksolo.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*6)
end)

NeP.DSL:Register('folraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*7/((NeP.DSL:Get('mana')('player')/100)^.7))
end)

NeP.DSL:Register('folparty.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*6.5/((NeP.DSL:Get('mana')('player')/100)^.7))
end)

NeP.DSL:Register('folsolo.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*6/((NeP.DSL:Get('mana')('player')/100)^.7))
end)

NeP.DSL:Register('holiraid.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*3/((NeP.DSL:Get('mana')('player')/100)^.2))
end)

NeP.DSL:Register('holiparty.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*3/((NeP.DSL:Get('mana')('player')/100)^.2))
end)

NeP.DSL:Register('holisolo.heals', function()
    return (((100+GetMasteryEffect())/100)*((100+GetCritChance())/100)*(UnitStat("player", 4))*3/((NeP.DSL:Get('mana')('player')/100)^.2))
end)

NeP.DSL:Register('loh.heals', function()
    return (NeP.DSL:Get('health.actual')('player')*.8)
end)

NeP.DSL:Register('lohraidtank.heals', function()
    return (NeP.DSL:Get('health.actual')('player')*1)
end)

NeP.DSL:Register('partycheck', function()
        if IsInRaid() then
            return 3
        elseif IsInGroup() then
            return 2
        else
            return 1
        end
end)
