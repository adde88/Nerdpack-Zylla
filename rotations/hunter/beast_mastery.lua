local _, Zylla = ...

local Util = _G['Zylla.Util']
local Trinkets = _G['Zylla.Trinkets']
local Heirlooms = _G['Zylla.Heirlooms']

local GUI = {
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
  {type = 'ruler'},	  {type = 'spacer'},
  	-- Survival
  {type = 'header', 	text = 'Survival',									  	      align = 'center'},
  {type = 'spinner', 	text = 'Heal Pet when below HP%',              key = 'P_HP',           default = 70},
  {type = 'spinner', 	text = 'Exhileration below HP%',              key = 'E_HP',           default = 67},
  {type = 'spinner',	text = 'Healthstone or Healing Potions',      key = 'Health Stone',	  default = 45},
  {type = 'spinner',	text = 'Aspect of the Turtle',								key = 'AotT',           default = 21},
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
  print('|cffADFF2F --- |rHunter |cffADFF2FBeast Mastery [T-19] |r')
  print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/1 - 3/X - 4/2 - 5/X - 6/1 - 7/2')
  print('|cffADFF2F ----------------------------------------------------------------------|r')

  NeP.Interface:AddToggle({
    key = 'xMisdirect',
    name = 'Misdirection',
    text = 'Automatically use Misdirection on current Focus-target or Pet.',
    icon = 'Interface\\Icons\\ability_hunter_misdirection',
  })

end

local PreCombat = {
  {'/cast Call Pet 1', '!pet.exists&UI(kPet)'},
  {'Heart of the Phoenix', '!player.debuff(Weakened Heart)&pet.dead&UI(kPet)'},
  {'Revive Pet', 'pet.dead&UI(kPet)'},
  {'Volley', '{toggle(aoe)&!player.buff(Volley)&UI(kVolley)}||{player.buff(Volley)&{!UI(kVolley)||!toggle(aoe)}}'},
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
  {'#127834', 'player.health<UI(Health Stone)'},  -- Ancient Healing Potion
  {'#5512', 'item(5512).count>0&player.health<UI(Health Stone)', 'player'},  --Health Stone
  {'Aspect of the Turtle', 'player.health<UI(AotT)'},
  {'Feign Death', 'player.health<UI(FD)&equipped(137064)'},
  {'%pause', 'player.buff(Feign Death)'},
}

local Cooldowns = {
  {'Bestial Wrath'},
  --actions+=/titans_thunder,if=(talent.dire_frenzy.enabled&(buff.bestial_wrath.up|cooldown.bestial_wrath.remains>35))|cooldown.dire_beast.remains>=3|(buff.bestial_wrath.up&pet.dire_beast.active)
  {'Titan\'s Thunder', '{talent(2,2)&{player.buff(Bestial Wrath)||cooldown(Dire Beast).remains>35}}||cooldown(Dire Beast).remains>2||{player.buff(Bestial Wrath)&player.buff(Dire Beast)}'},
  {'Aspect of the Wild', 'player.buff(Bestial Wrath)||target.time_to_die<12'},
  {'Blood Fury'},
  {'Berserking'},
}

local Interrupts = {
  {'!Counter Shot'},
  {'!Intimidation', 'cooldown(Counter Shot).remains>gcd&!prev_gcd(Counter Shot)'},
}

local xCombat = {
  {'A Murder of Crows'},
  {'Stampede', '{player.buff(Bloodlust)||player.buff(Bestial Wrath)||cooldown(Bestial Wrath).remains<3}||target.time_to_die<24'},
  {'Dire Beast', 'cooldown(Bestial Wrath).remains>3'},
  --actions+=/dire_frenzy,if=(pet.cat.buff.dire_frenzy.remains<=gcd.max*1.2)|(charges_fractional>=1.8)|target.time_to_die<9
  {'Dire Frenzy', '{pet.buff(Dire Frenzy).remains<=gcd.max*1.2}||player.spell(Dire Frenzy).charges>0.8||target.ttd<9'},
  {'Barrage', 'toggle(aoe)&UI(kBarrage)&{target.area(15).enemies>1||{target.area(15).enemies==1&player.focus>90}}'},
  {'Chimaera Shot', 'player.focus<90'},
  {'Cobra Shot', '{player.focus>75&cooldown(Kill Command).remains>gcd&target.area(10).enemies<2}||{cooldown(Kill Command).remains>focus.time_to_max&cooldown(Bestial Wrath).remains>focus.time_to_max}||{player.buff(Bestial Wrath)&focus.regen*cooldown(Kill Command).remains>action(Kill Command).cost}||target.time_to_die<cooldown(Kill Command).remains||{equipped(Parsel\'s Tongue)&player.buff(Parsel\'s Tongue).remains<=gcd.max*2}'},
  {'Volley', '{toggle(aoe)&!player.buff(Volley)&UI(kVolley)}||{player.buff(Volley)&{!UI(kVolley)||!toggle(aoe)}}'},
}

local xPetCombat = {
  {'!Kill Command', 'pet.exists&pet.alive'},
  {'Mend Pet', 'pet.exists&pet.alive&pet.health<UI(P_HP)&!pet.buff(Mend Pet)'},
  {'Heart of the Phoenix', '!player.debuff(Weakened Heart)&pet.dead&UI(kPet)'},
  {'Revive Pet', 'pet.dead&UI(kPet)'},
  {'/cast Call Pet 1', '!pet.exists&UI(kPet)'},
  {'/cast [@focus, help] [@pet, nodead, exists] Misdirection', 'cooldown(Misdirection).remains<gcd&toggle(xMisdirect)'},
}

local xPvP = {
  {'Gladiator\'s Medallion', 'player.state(incapacitate)||player.state(stun)||player.state(fear)||player.state(horror)||player.state(sleep)||player.state(charm)'},
  {'Viper Sting', 'target.range<41&target.health<80', 'target'},
  {'Scorpid Sting', 'target.inMelee', 'target'},
  {'Spider Sting', 'target.range<41', 'target'},
  {'Dire Beast: Hawk', 'target.range<41', 'target.ground'},
  {'Dire Beast: Basilisk', 'target.range<41', 'target.ground'},
  {'Interlope', 'target.range<41'},
}

local xAoE = {  -- Trying to fix a wierd issue where Multi-Shot is being used, even when the conditions are not met.
  {'Multi-Shot', 'target.area(10).enemies>4&{pet.buff(Beast Cleave).remains<gcd.max||!pet.buff(Beast Cleave)}'},
  {'Multi-Shot', 'pet.buff(Beast Cleave).remains<gcd.max*2||!pet.buff(Beast Cleave)'},
}

local inCombat = {
  {Util},
  {Trinkets},
  {Heirlooms},
  {Keybinds},
  {Survival},
  {Interrupts, 'interruptAt(70)&toggle(Interrupts)&inFront&range<40', 'enemies'},
  {Cooldowns, 'toggle(Cooldowns)'},
  {xCombat, 'target.range<41&target.inFront'},
  {xAoE, 'toggle(aoe)&target.area(10).enemies>1&target.range<41&target.inFront'},
  {xPetCombat},
  {xPvP},
}

local outCombat = {
  {Keybinds},
  {PreCombat},
  {Interrupts, 'interruptAt(70)&toggle(Interrupts)&inFront&range<40', 'enemies'},
}

NeP.CR:Add(253, {
  name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Hunter - Beast Mastery',
  ic = inCombat,
  ooc = outCombat,
  gui = GUI,
  load = exeOnLoad
--blacklist = _G['Zylla.Blacklist']
})