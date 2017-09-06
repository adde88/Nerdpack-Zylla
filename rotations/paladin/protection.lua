local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI

local GUI = {
	unpack(Logo_GUI),
  -- General
  {type = 'header', text = 'Keybinds', 		align = 'center'},
  {type = 'text', text = 'Left Shift: Pause', align = 'center'},
  {type = 'text', text = 'Left Ctrl: ', align = 'center'},
  {type = 'text', text = 'Left Alt: ', align = 'center'},
  {type = 'text', text = 'Right Alt: ', align = 'center'},
  {type = 'checkbox', text = 'Pause Enabled', key = 'kPause', 	default = true},
  {type = 'ruler'},	{type = 'spacer'},
  -- Trinkets + Heirlooms for leveling
  {type = 'header', text = 'Trinkets/Heirlooms', align = 'center'},
  {type = 'checkbox', text = 'Use Trinket #1', key = 'kT1', default = true},
  {type = 'checkbox', text = 'Use Trinket #2', key = 'kT2', default = true},
  {type = 'checkbox', text = 'Ring of Collapsing Futures', key = 'kRoCF', default = true},
  {type = 'checkbox', text = 'Use Heirloom Necks When Below X% HP', key = 'k_HEIR', default = true},
  -- Survival
  {type='spacer'}, {type='rule'},
  {type = 'header', text = 'Survival', align = 'center'},
  {type='checkbox', text = 'Enable Self-Heal (Flash of Light)',	key='kFoL', default=false},
  {type='spinner', text = 'Flash of Light (HP%)', key='E_FoL', default=60},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
  Zylla.ExeOnLoad()
  Zylla.AFKCheck()

  print('|cffADFF2F ----------------------------------------------------------------------|r')
  print('|cffADFF2F --- |rPALADIN |cffADFF2FProtection |r')
  print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/3 - 4/1 - 5/2 - 6/2 - 7/3')
  print('|cffADFF2F ----------------------------------------------------------------------|r')

  NeP.Interface:AddToggle({
  key = 'AutoTaunt',
  name = 'Auto Taunt',
  text = 'Automatically taunt nearby enemies.',
  icon = 'Interface\\Icons\\spell_nature_shamanrage.png',
  })
end

local Keybinds = {
  {'%pause', 'keybind(lshift)&UI(kPause)'},
}

local Interrupts = {
  {'!Rebuke'},
  {'!Hammer of Justice', 'cooldown(Rebuke).remains>gcd'},
  {'!Arcane Torrent', 'target.range<=5&spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)'},
}

local Survival ={
  {'Flash of Light', 'player.health<=UI(E_FoL)&player.lastmoved>0&UI(kFoL)', 'player'},
  {'Light of the Protector', 'player.health<78&player.buff(Consecration)'},
}

local PreCombat = {
}

local EyeofTyr = {
  {'Divine Steed', 'talent(5,2)'},
  {'Eye of Tyr'},
  {'Aegis of Light', 'talent(6,1)'},
  {'Guardian of Ancient Kings'},
  {'Divine Shield'},
  {'Ardent Defender'},
}
local Cooldowns = {
  {'Seraphim', 'talent(7,2)&spell(Shield of the Righteous).charges>1', 'player'},
  {'Shield of the Righteous', 'range<=5&inFront&{!talent(7,2)||spell(Shield of the Righteous).charges>2}&!{player.buff(Eye of Tyr)&player.buff(Aegis of Light)&player.buff(Ardent Defender)&player.buff(Guardian of Ancient Kings)&player.buff(Divine Shield)}', 'target'},
  {'Bastion of Light', 'talent(2,2)&spell(Shield of the Righteous).charges<1', 'player'},
  {'Light of the Protector', 'player.health<40', 'player'},
  {'Hand of the Protector', 'talent(5,1)&health<40', 'player'},
  {'Light of the Protector', '{incdmg(10)>health.max*1.25}&health<55&talent(7,1)', 'player'},
  {'Light of the Protector', '{incdmg(13)>health.max*1.6}&health<55', 'player'},
  {'Hand of the Protector', 'talent(5,1)&{incdmg(6)>health.max*0.7}&health<55&talent(7,1)', 'player'},
  {'Hand of the Protector', 'talent(5,1)&{incdmg(9)>health.max*1.2}&health<55', 'player'},
  {EyeofTyr, 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
  {'Lay on Hands', 'health<15', 'player'},
  {'Avenging Wrath', '!talent(7,2)||talent(7,2)&buff(Seraphim)', 'player'}
}

local AoE = {
  {'Avenger\'s Shield'},
  {'Blessed Hammer'},
  {'Judgment'},
  {'Consecration', 'target.range<7'},
  {'Hammer of the Righteous', '!talent(1,2)'},
}

local ST = {
  {'Judgment'},
  {'Blessed Hammer'},
  {'Avenger\'s Shield'},
  {'Consecration', 'target.range<7'},
  {'Blinding Light'},
  {'Hammer of the Righteous', '!talent(1,2)'},
}

local inCombat = {
  {Keybinds},
  {Survival, 'player.health<100'},
  {Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.inFront&target.range<=5'},
  {Cooldowns, 'toggle(Cooldowns)'},
  {'%taunt(Hand of Reckoning)', 'toggle(aoe)'},
  {'Shield of the Righteous', '!player.buff&{player.health<60||spell.count>1}', 'target'},
  {AoE, 'toggle(AoE)&player.area(8).enemies>2'},
	{Fel_Explosives, 'range<=5'}
  {ST, 'target.inFront&target.range<=5'}
}

local outCombat = {
  {Keybinds},
  {PreCombat}
}

NeP.CR:Add(66, {
  name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Paladin - Protection',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
