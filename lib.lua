local _, Zylla = ...
local _G = _G
local NeP = _G.NeP

NeP.Library:Add('Zylla', {

  hitcombo = function(_, spell)
    local HitComboLastCast = ''
    if not spell then return true end
    local _, _, _, _, _, _, spellID = _G.GetSpellInfo(spell)
    if NeP.DSL:Get('buff')('player', 'Hit Combo') then
      -- We're using hit-combo and we need to check if the spell we've passed is in the list
      if HitComboLastCast == spellID then
        -- If the passed spell is in the list as flagged, we need to return false and exit
        --print('hitcombo('..spell..') and it is was flagged ('..HitComboLastCast..'), returning false');
        return false
      end
    end
    return true
  end,

	face = function(target)
		local ax, ay = _G.ObjectPosition('player')
		local bx, by = _G.ObjectPosition(target)
		if not ax or not bx then return end
		local angle = _G.rad(_G.atan2(by - ay, bx - ax))
		if angle < 0 then
			_G.FaceDirection(angle + 360)
		else
			_G.FaceDirection(angle + 360)
		end
	end,

  staggered = function()
    local stagger = _G.UnitStagger("player");
    local percentOfHealth = (100/_G.UnitHealthMax("player")*stagger);
    -- TODO: We are targetting 4.5% stagger value - too low?  I think we used 25% or heavy stagger before as the trigger
    if (percentOfHealth > 4.5) or _G.UnitDebuff("player", _G.GetSpellInfo(124273)) then
      return true
    end
    return false
  end,

  purifyingCapped = function()
    local MaxBrewCharges = 3
    if NeP.DSL:Get('talent')(nil, '3,1') then
      MaxBrewCharges = MaxBrewCharges + 1
    end
    if (NeP.DSL:Get('spell.charges')('player', 'Purifying Brew') == MaxBrewCharges) or ((NeP.DSL:Get('spell.charges')('player', 'Purifying Brew') == MaxBrewCharges - 1) and NeP.DSL:Get('spell.recharge')('player', 'Purifying Brew') < 3 ) then
      return true
    end
    return false
  end,

	rollingbones = function()
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
	-- If only Shark or True Bearing and CDs ready
    elseif (bearing or shark) and ((_G.GetSpellCooldown(13750) == 0) or (_G.GetSpellCooldown(202665) == 0)) then
        return true --"AR/Curse NOW and keep!"
	--if we have only ONE bad buff BUT AR/curse is active:
    elseif int ==1 and ((_G.UnitBuff("player", _G.GetSpellInfo(13750)) or _G.UnitDebuff("player", _G.GetSpellInfo(202665)))) then
        return true
	-- If only one bad buff:
    else return false	--"Reroll now!"
    end
	end,

	cancelRush = function(target)
		local cookie = 0
		if _G.GetUnitSpeed("player") == 0 and cookie == 0 then
			_G.MoveBackwardStart()
			_G.JumpOrAscendStart()
			_G.CastSpellByName('Fel Rush', target)
			_G.MoveBackwardStop()
			_G.AscendStop()
		end
		return
	end,

	cancelRetreat = function(target)
		if Zylla.castable.vengefulRetreat then
			-- C_Timer.After(.001, function() HackEnabled("NoKnockback", true) end)
			-- C_Timer.After(.35, function() CastSpellByName('Vengeful Retreat', target) end)
			-- C_Timer.After(.55, function() HackEnabled("NoKnockback", false) end)
			_G.HackEnabled("NoKnockback", true)
			_G.CastSpellByName('Vengeful Retreat', target)
			_G.HackEnabled("NoKnockback", false)
    end
    return
  end,

	--usage "@Zylla.areaHeal(VAR1, VAR2, VAR3)"
	areaHeal = function(target, args)
		args = args:gsub("%s+", "")
		local a, b, c = _G.strsplit(",", args, 3)
		a = tonumber(a) or NeP.DSL:Get("ui")(nil, a)	--XXX: Range
		b = tonumber(b) or NeP.DSL:Get("ui")(nil, b)	--XXX: HP%
		c = tonumber(c) or NeP.DSL:Get("ui")(nil, c)	--XXX: Units
		return a and b and c and NeP.DSL:Get("area.heal")(target, a..","..b) >= c - 1	--TODO: Check if it's inheriting unit correctly.
	end,

	--usage "@Zylla.felExplosive()"
	felExplosiveFind = function()
    local count = 0
    for i=1, _G.GetObjectCount() do
      local unit = _G.GetObjectWithIndex(i)
      if _G.ObjectName(unit) == "Fel Explosives"
      and not _G.UnitIsDead(unit)
      and NeP.DSL:Get('range')(unit) < 40 then
      count = count + 1
      _G.Zylla.FelUnit = unit
      print('FEL EXPLOSIVES UP: ', count)
      return true
			end
      return false
		end
	end,

  felExplosiveTarget = function()
    local unit = _G.Zylla.FelUnit
    if _G.ObjectName(unit) == "Fel Explosives"
    and not _G.UnitIsDead(unit)
    and NeP.DSL:Get('range')(unit) < 40 then
      _G.TargetUnit(unit)
      _G.StartAttack(unit)
      print('Attacking Fel Explosive!')
    end
  end,


	--usage "@Zylla.InterruptAt(VAR1)"
	InterruptAt = function(target, args)
		local a = args
		a = tonumber(a) or NeP.DSL:Get("ui")(nil, a)	--XXX: InterruptAt
		--print(a and NeP.DSL:Get("interruptAt")(target, a))
		return a and NeP.DSL:Get("interruptAt")(target, a) --TODO: Test it + Make function inherit UNIT from DSL if specified, otherwise resort to lowest/player?
	end,

})
