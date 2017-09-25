local _, Zylla = ...

NeP.Library:Add('Zylla', {

  hitcombo = function(_, spell)
    local HitComboLastCast = ''
    if not spell then return true end
    local _, _, _, _, _, _, spellID = GetSpellInfo(spell)
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
		local ax, ay = ObjectPosition('player')
		local bx, by = ObjectPosition(target)
		if not ax or not bx then return end
		local angle = rad(atan2(by - ay, bx - ax))
		if angle < 0 then
			FaceDirection(angle + 360)
		else
			FaceDirection(angle + 360)
		end
	end,

  staggered = function()
    local stagger = UnitStagger("player");
    local percentOfHealth = (100/UnitHealthMax("player")*stagger);
    -- TODO: We are targetting 4.5% stagger value - too low?  I think we used 25% or heavy stagger before as the trigger
    if (percentOfHealth > 4.5) or UnitDebuff("player", GetSpellInfo(124273)) then
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
	-- If only Shark or True Bearing and CDs ready
    elseif (bearing or shark) and ((GetSpellCooldown(13750) == 0) or (GetSpellCooldown(202665) == 0)) then
        return true --"AR/Curse NOW and keep!"
	--if we have only ONE bad buff BUT AR/curse is active:
    elseif int ==1 and ((UnitBuff("player", GetSpellInfo(13750)) or UnitDebuff("player", GetSpellInfo(202665)))) then
        return true
	-- If only one bad buff:
    else return false	--"Reroll now!"
    end
	end,

	cancelRush = function(target)
		local cookie = 0
		if GetUnitSpeed("player") == 0 and cookie == 0 then
			MoveBackwardStart()
			JumpOrAscendStart()
			CastSpellByName('Fel Rush', target)
			MoveBackwardStop()
			AscendStop()
		end
		return
	end,

	cancelRetreat = function(target)
		if Zylla.castable.vengefulRetreat then
			-- C_Timer.After(.001, function() HackEnabled("NoKnockback", true) end)
			-- C_Timer.After(.35, function() CastSpellByName('Vengeful Retreat', target) end)
			-- C_Timer.After(.55, function() HackEnabled("NoKnockback", false) end)
			HackEnabled("NoKnockback", true)
			CastSpellByName('Vengeful Retreat', target)
			HackEnabled("NoKnockback", false)
    end
    return
  end,

	--usage "@zylla.areaHeal(VAR1, VAR2, VAR3)"
	areaHeal = (function(nil, args)
		local a,b,c = strsplit(",", args, 3)
		a = NeP.DSL:Get("ui")(nil, a)
		b =NeP.DSL:Get("ui")(nil, b)
		c = NeP.DSL:Get("ui")(nil, c)
		return NeP.DSL:Get("area.heal")("lowest", a..","..b) > c
	end,

})
