local _, Zylla = ...

Zylla.ClassTable = {}

local rangex = {
   ["melee"] = 5,
   ["ranged"] = 40,
}

local Warrior = {
   class = 'Warrior',
   specs = {
      [71] = {
         range = rangex["melee"],
         name = 'Arms',
         role = 'DPS'
      },
      [72] = {
         range = rangex["melee"],
         name = 'Fury',
         role = 'DPS'
      },
      [73] = {
         range = rangex["melee"],
         name = 'Protection',
         role = 'TANK'
      }
   }
}

local Paladin = {
   class = 'Paladin',
   specs = {
      [65] = {
         range = rangex["melee"],
         name = 'Holy',
         role = 'HEALER'
      },
      [66] = {
         range = rangex["melee"],
         name = 'Protection',
         role = 'TANK'
      },
      [70] = {
         range = rangex["melee"],
         name = 'Retribution',
         role = 'DPS'
      }
   }
}

local Hunter = {
   class = 'Hunter',
   specs = {
      [253] = {
         range = rangex["ranged"],
         name = 'Beast Mastery',
         role = 'DPS'
      },
      [254] = {
         range = rangex["ranged"],
         name = 'Marksmanship',
         role = 'DPS'
      },
      [255] = {
         range = rangex["melee"],
         name = 'Survival',
         role = 'DPS'
      }
   }
}

local Rogue = {
   class = 'Rogue',
   specs = {
      [259] = {
         range = rangex["melee"],
         name = 'Assassination',
         role = 'DPS'
      },
      [260] = {
         range = rangex["melee"],
         name = 'Outlaw',
         role = 'DPS'
      },
      [261] = {
         range = rangex["melee"],
         name = 'Subtlety',
         role = 'DPS'
      }
   }
}

local Priest = {
   class = 'Priest',
   specs = {
      [256] = {
         range = rangex["ranged"],
         name = 'Discipline',
         role = 'HEALER'
      },
      [257] = {
         range = rangex["ranged"],
         name = 'Holy',
         role = 'HEALER'
      },
      [258] = {
         range = rangex["ranged"],
         name = 'Shadow',
         role = 'HEALER'
      }
   }
}

local DeathKnight = {
   class = 'DeathKnight',
   specs = {
      [250] = {
         range = rangex["melee"],
         name = 'Blood',
         role = 'TANK'
      },
      [251] = {
         range = rangex["melee"],
         name = 'Frost',
         role = 'DPS'
      },
      [252] = {
         range = rangex["melee"],
         name = 'Unholy',
         role = 'DPS'
      }
   }
}

local Shaman = {
   class = 'Shaman',
   specs = {
      [262] = {
         range = rangex["ranged"],
         name = 'Elemental',
         role = 'DPS'
      },
      [263] = {
         range = rangex["melee"],
         name = 'Enhancement',
         role = 'DPS'
      },
      [264] = {
         range = rangex["ranged"],
         name = 'Restoration',
         role = 'HEALER'
      }
   }
}

local Mage = {
   class = 'Mage',
   specs = {
      [62] = {
         range = rangex["ranged"],
         name = 'Arcane',
         role = 'DPS'
      },
      [63] = {
         range = rangex["ranged"],
         name = 'Fire',
         role = 'DPS'
      },
      [64] = {
         range = rangex["ranged"],
         name = 'Frost',
         role = 'DPS'
      }
   }
}

local Warlock = {
   class = 'Warlock',
   specs = {
      [265] = {
         range = rangex["ranged"],
         name = 'Affliction',
         role = 'DPS'
      },
      [266] = {
         range = rangex["ranged"],
         name = 'Demonology',
         role = 'DPS'
      },
      [267] = {
         range = rangex["ranged"],
         name = 'Destruction',
         role = 'DPS'
      }
   }
}

local Monk = {
   class = 'Monk',
   specs = {
      [268] = {
         range = rangex["melee"],
         name = 'Brewmaster',
         role = 'TANK'
      },
      [269] = {
         range = rangex["melee"],
         name = 'Windwalker',
         role = 'DPS'
      },
      [270] = {
         range = rangex["ranged"],
         name = 'Mistweaver',
         role = 'HEALER'
      }
   }
}

local Druid = {
   class = 'Druid',
   specs = {
      [102] = {
         range = rangex["ranged"],
         name = 'Balance',
         role = 'DPS'
      },
      [103] = {
         range = rangex["melee"],
         name = 'Feral Combat',
         role = 'DPS'
      },
      [104] = {
         range = rangex["melee"],
         name = 'Guardian',
         role = 'TANK'
      },
      [105] = {
         range = rangex["ranged"],
         name = 'Restoration',
         role = 'HEALER'
      }
   }
}

local Demon_Hunter = {
   class = 'Demon Hunter',
   specs = {
      [577] = {
         range = rangex["melee"],
         name = 'Havoc',
         role = 'DPS'
      },
      [581] = {
         range = rangex["melee"],
         name = 'Vengeance',
         role = 'TANK'
      }
   }
}

local Classes = {
   [1] = Warrior,
   [2] = Paladin,
   [3] = Hunter,
   [4] = Rogue,
   [5] = Priest,
   [6] = DeathKnight,
   [7] = Shaman,
   [8] = Mage,
   [9] = Warlock,
   [10] = Monk,
   [11] = Druid,
   [12] = Demon_Hunter
}

function Zylla.ClassTable.GetClass(_, classid)
	classid = tonumber(classid)
  return Classes[classid]
end

function Zylla.ClassTable.GetSpec(_, specid)
	specid = tonumber(specid)
   for i=1, #Classes do
      if Classes[i].specs[specid] then
         return Classes[i].specs[specid]
      end
   end
end

function Zylla.ClassTable:GetClassSpecs(classid)
   local class = self:GetClass(classid)
   local tmp = {}
   for specid in pairs (class.specs) do
      tmp[#tmp+1] = specid
   end
   return tmp
end

function Zylla.ClassTable:SpecIsFromClass(classid, specid)
   local class = self:GetClass(classid)
   return not not class.specs[specid]
end

function Zylla.ClassTable:GetRange(specid)
   local spec = self:GetSpec(specid)
   return spec.range
end

function Zylla.ClassTable:GetRole(specid)
   local spec = self:GetSpec(specid)
   return spec.role
end
