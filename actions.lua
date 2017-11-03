local _, NeP = ...
local _G = _G
local LibDisp = _G.LibStub('LibDispellable-1.0')

local funcs = {
  noop = function() end,
  Cast = function(eva)
    NeP.Parser.LastCast = eva.spell
    NeP.Parser.LastGCD = not eva.nogcd and eva.spell or NeP.Parser.LastGCD
    NeP.Parser.LastTarget = eva.target
    NeP.Protected["Cast"](eva.spell, eva.target)
    return true
  end,
  UseItem = function(eva) NeP.Protected["UseItem"](eva.spell, eva.target); return true end,
  Macro = function(eva) NeP.Protected["Macro"]("/"..eva.spell, eva.target); return true end,
  Lib = function(eva) return NeP.Library:Parse(eva.spell, eva.target, eva[1].args) end,
  C_Buff = function(eva) _G.CancelUnitBuff('player', _G.GetSpellInfo(eva[1].args)) end
}

local function IsSpellReady(spell)
  if _G.GetSpellBookItemInfo(spell) ~= 'FUTURESPELL'
  and (_G.GetSpellCooldown(spell) or 0) <= NeP.DSL:Get('gcd')() then
    return _G.IsUsableSpell(spell)
  end
end

-- USAGE: {"%dispel", nil, UNIT}
-- this will dispel any spell if any from the unit
NeP.Actions:Add('dispel', function(eval)
  if not _G.UnitExists(eval[3].target) then return end
  for _, spellID, _,_,_,_,_, duration, expires in LibDisp:IterateDispellableAuras(eval[3].target) do
    local spell = _G.GetSpellInfo(spellID)
    if IsSpellReady(spell)
    and (expires - eval.master.time) < (duration - math.random(1, 3)) then
      eval.spell = spell
      eval.exe = funcs["Cast"]
      return true
    end
  end
end)
