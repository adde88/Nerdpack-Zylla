local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
  --Logo
  {type = "texture", texture = "Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp", width = 128, height = 128, offset = 90, y = 42, center = true},
  {type = 'ruler'},	  {type = 'spacer'},
  -- Keybinds
  {type = 'header',   text = 'Keybinds',	  					              align = 'center'},
  {type = 'text', 	  text = 'Left Shift: Pause',						        align = 'center'},
  {type = 'text', 	  text = 'Left Ctrl: Tar Trap',						      align = 'center'},
  {type = 'text', 	  text = 'Left Alt: Binding Shot',						  align = 'center'},
  {type = 'text', 	  text = 'Right Alt: Freezing Trap',						align = 'center'},
  {type = 'ruler'},	  {type = 'spacer'},
  -- Settings
  {type = 'header', 	text = 'Class Settings',									    align = 'center'},
  {type = 'checkbox', text = 'Pause Enabled',									      key = 'kPause',         default = true},
  {type = 'checkbox', text = 'Summon Pet',									        key = 'kPet',           default = true},
  {type = 'checkbox', text = 'Barrage Enabled',									    key = 'kBarrage',       default = false},
  {type = 'checkbox', text = 'Volley Enabled',									    key = 'kVolley',        default = true},
  {type = 'checkbox', text = 'Misdirect Focus/Pet',									key = 'kMisdirect',     default = true},
  {type = 'checkbox', text = 'Freezing Trap (Interrupt)'  ,					key = 'FT_Int',         default = false},
  {type = 'checkbox', text = 'Tarnished Sentinel Medallion',				key = 'e_TSM',          default = true},
  {type = 'ruler'},	  {type = 'spacer'},
  -- Survival
  {type = 'header', 	text = 'Survival',									  	      align = 'center'},
  {type = 'spinner', 	text = 'Heal Pet below HP%',                  key = 'P_HP',           default = 75},
  {type = 'spinner', 	text = 'Exhileration below HP%',              key = 'E_HP',           default = 67},
  {type = 'spinner',	text = 'Healthstone or Healing Potions',      key = 'Health Stone',	  default = 45},
  {type = 'spinner',	text = 'Aspect of the Turtle',                key = 'AotT',           default = 21},
  {type = 'spinner',	text = 'Feign Death (Legendary Healing) %',	  key = 'FD',		          default = 16},
  {type = 'ruler'},	  {type = 'spacer'},
  -- Trinkets + Heirlooms for leveling
  {type = 'header', 	text = 'Trinkets/Heirlooms',                  align = 'center'},
  {type = 'checkbox', text = 'Use Trinket #1',                      key = 'kT1',            default = true},
  {type = 'checkbox', text = 'Use Trinket #2',                      key = 'kT2',            default = true},
  {type = 'checkbox', text = 'Ring of Collapsing Futures',          key = 'kRoCF',          default = true},
  {type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR',         default = true},
  {type = 'spinner',	text = '',                                    key = 'k_HeirHP',       default = 40},
  {type = 'ruler'},	  {type = 'spacer'},
}

local exeOnLoad = function()
  Zylla.ExeOnLoad()
  Zylla.AFKCheck()

  print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffADFF2F --- |rHunter |cffADFF2FBeast Mastery [T-20] |r')
  print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/1 - 3/X - 4/2 - 5/X - 6/1 - 7/2')
  print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

  NeP.Interface:AddToggle({
    key = 'xMisdirect',
    name = 'Misdirection',
    text = 'Automatically use Misdirection on current Focus-target or Pet.',
    icon = 'Interface\\Icons\\ability_hunter_misdirection',
  })

   NeP.Interface:AddToggle({
    key = 'xIntRandom',
    name = 'Interrupt Anyone',
    text = 'Interrupt all nearby enemies, without targeting them.',
    icon = 'Interface\\Icons\\inv_ammo_arrow_04',
  })

end

local PreCombat = {
  {'Call Pet 1', '!pet.exists&UI(kPet)'},
  {'Volley', '{toggle(aoe)&!player.buff(Volley)}||{player.buff(Volley)&!toggle(aoe)}'},
  {'%pause', 'player.buff(Feign Death)'},
}

local Keybinds = {
  {'%pause', 'keybind(lshift)&UI(kPause)'},
  {'Binding Shot', 'keybind(lalt)', 'cursor.ground'},
  {'Tar Trap', 'keybind(lcontrol)', 'cursor.ground'},
  {'Freezing Trap', 'keybind(ralt)', 'cursor.ground'},
}

local Survival = {
  {'Exhilaration', 'player.health<UI(E_HP)'},
  {'#127834', 'item(127834).count>0&player.health<UI(Health Stone)'},        -- Ancient Healing Potion
  {'#5512', 'item(5512).count>0&player.health<UI(Health Stone)', 'player'},  --Health Stone
  {'Aspect of the Turtle', 'player.health<UI(AotT)'},
  {'Feign Death', 'player.health<UI(FD)&equipped(137064)'},
  {'%pause', 'player.buff(Feign Death)'},
}

local Cooldowns = {
  {'#147017', 'UI(e_TSM)&equipped(147017)'}, -- Tarnished Sentinel Medallion
  {'Bestial Wrath'},
  {'Titan\'s Thunder', '{player.buff(Bestial Wrath)||player.spell(Dire Beast).cooldown>35}||{player.spell(Dire Beast).cooldown>2||{player.buff(Bestial Wrath)&player.buff(Dire Beast)}}'},
  {'Aspect of the Wild', 'player.buff(Bestial Wrath)||target.time_to_die<12'},
  {'Blood Fury'},
  {'Berserking'},
  {'#Trinket1', 'UI(kT1)'},
  {'#Trinket2', 'UI(kT2)'},
}

local Interrupts_Normal = {
	{'!Counter Shot'},
	{'!Intimidation', 'player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&!target.immune(Stun)'},
  {'!Freezing Trap', 'UI(FT_Int)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)', 'target.ground'},
}

local Interrupts_Random = {
	{'!Counter Shot', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<41', 'enemies'},
  {'!Intimidation', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&inFront&range<41', 'enemies'},
  {'!Freezing Trap', 'UI(FT_Int)&interruptAt(1)&toggle(xIntRandom)&toggle(Interrupts)&player.spell(Counter Shot).cooldown>gcd&!prev_gcd(Counter Shot)&range<41', 'enemies.ground'},
}

local xCombat = {
  {'A Murder of Crows'},
  {'Stampede', '{player.buff(Bloodlust)||player.buff(Bestial Wrath)||player.spell(Bestial Wrath).cooldown<3}||target.time_to_die<24'},
  {'Dire Beast', 'player.spell(Bestial Wrath).cooldown>3'},
  {'Dire Frenzy', '{pet.buff(Dire Frenzy).duration<=gcd.max*1.2}||player.spell(Dire Frenzy).charges>0.8||target.ttd<9'},
  {'Barrage', 'toggle(aoe)&UI(kBarrage)&{target.area(15).enemies>1||{target.area(15).enemies==1&player.focus>90}}'},
  {'Multi-Shot', 'toggle(aoe)&target.area(10).enemies>4&{pet.buff(Beast Cleave).duration<gcd.max||!pet.buff(Beast Cleave)}'},
  {'Multi-Shot', 'toggle(aoe)&target.area(10).enemies>1&{pet.buff(Beast Cleave).duration<gcd.max*2||!pet.buff(Beast Cleave)}'},
  {'Chimaera Shot', 'player.focus<90'},
  {'Cobra Shot', '{player.spell(Kill Command).cooldown>focus.time_to_max&player.spell(Bestial Wrath).cooldown>focus.time_to_max}||{player.buff(Bestial Wrath)&focus.regen*player.spell(Kill Command).cooldown>action(Kill Command).cost}||target.time_to_die<player.spell(Kill Command).cooldown||{equipped(Parsel\'s Tongue)&player.buff(Parsel\'s Tongue).duration<=gcd.max*2}'},
  {'Volley', '{toggle(aoe)&!player.buff(Volley)}||{player.buff(Volley)&!toggle(aoe)}'},
}

local xPet = {
  {'Call Pet 1', '!pet.exists&UI(kPet)'},
  {'Mend Pet', 'pet.alive&pet.health<UI(P_HP)&!pet.buff(Mend Pet)'},
  {{ 																			                                        -- Pet Dead
    {'Heart of the Phoenix', '!player.debuff(Weakened Heart)&player.combat'},     -- Heart of the Phoenix
    {'Revive Pet'} 																                                -- Revive Pet
  }, {'pet.dead', 'UI(kPet)'}},
  {'!Kill Command', '{pet.exists&pet.alive&{talent(4,3)&petrange<31}||{petrange<10}}', 'target'},
  {'Misdirection', 'player.spell(Misdirection).cooldown<=gcd&toggle(xMisdirect)', 'focus'},
}

local xPvP = {
  {'Gladiator\'s Medallion', 'player.state(incapacitate)||player.state(stun)||player.state(fear)||player.state(horror)||player.state(sleep)||player.state(charm)', 'player'},
  {'Viper Sting', 'target.range<41&target.health<80', 'target'},
  {'Scorpid Sting', 'target.inMelee', 'target'},
  {'Spider Sting', 'target.range<41', 'target'},
  {'Dire Beast: Hawk', 'target.range<41', 'target.ground'},
  {'Dire Beast: Basilisk', 'target.range<41', 'target.ground'},
  {'Interlope', 'target.range<41'},
}

local inCombat = {
  {Util},
  {Trinkets},
  {Heirlooms},
  {Keybinds},
  {Survival},
  {Interrupts_Random},
  {Interrupts_Normal, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<41'},
  {Cooldowns, 'toggle(Cooldowns)'},
  {xCombat, 'target.range<41&target.inFront'},
  {xPet},
  {xPvP},
}

local outCombat = {
  {xPet},
  {Keybinds},
  {PreCombat},
  {Interrupts_Random},
  {Interrupts_Normal, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<41'},
}

NeP.CR:Add(253, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Beast Mastery',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
--blacklist = Zylla.Blacklist
})
