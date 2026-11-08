# Changelog

Newest changes first.

## 2026-11-08

- **M11S (`M11s Autosim.lua`):** the weapon draws are back on: the Assault Evolved 1 and 2 sword / scythe spots and the Ultimate Trophy Weapons sword / scythe spot. They follow only the AnyoneCore Party Roster, as in the [Toxic Friends M11S plan](https://raidplan.io/plan/HJAbE7fuWodELUSB) (slides 3-5 and 8):
  - Scythe: your protean spot around the weapon, clockwise from its front: MT (T1), R2, H2, M2, OT (T2), M1, H1, R1.
  - Sword: your light-party stack behind the weapon, G1 (T1 H1 M1 R1) on its left, G2 on its right.
  - Checked against 9 logged pulls: the spots match where players stood, and the weapon order was right every time.
- **M11S (`M11s Autosim.lua`):** Meteorain shows only your own spot:
  - The M1 / M2 and R1 / R2 image markers now show only your Party Roster slot's marker (M1, M2, R1 or R2), not both.
  - All Meteorain draws now follow only the AnyoneCore Party Roster. Without a roster slot they show nothing, instead of guessing your role another way.
  - Third set: the "your spot" arrow had R1 and R2 the wrong way round. R1 now goes south-west (by 4) and R2 north-east, the same as the R1 / R2 markers.
- **M11S (`M11s Autosim.lua`):** the weapon draws are turned off: the Assault Evolved 1 and 2 sword / scythe spots and the Ultimate Trophy Weapons sword / scythe spot. The tornado bait draw stays on.
- **M11S (`M11s Autosim.lua`):** Meteorain draws added back, following the [Toxic Friends M11S plan](https://raidplan.io/plan/HJAbE7fuWodELUSB) (slides 11-13):
  - Your spot for each Meteorain step (Party Roster slot), with the start of Meteorain and the tank tethers tracked.
  - Melee DPS: image markers on the M1 and M2 spots, which turn green when you stand in yours.
  - Ranged (BLM, BRD, DNC, MCH, SMN, PCT and RDM only): image markers on the R1 and R2 third-set spots.
  - The images ship in `TimelineReactions/Tataru/assets/M11S/Meteorain/` and are found through the LuaMods path, so they work on any install. For a manual install, copy that `assets` folder as well (see the README).
- **M11S (`M11s Autosim.lua`):** the Meteorain draws are removed, because they did not work.
- **M10S (`M10s autosim.lua`):** new auto-targeting:
  - When Firesnaking / Xtreme Firesnaking hits you, you target Red Hot; when Watersnaking / Xtreme Watersnaking hits you, you target Deep Blue. If you are already on that boss, nothing changes.
  - When a boss comes back into the arena (after the boss swap, Sickest Take-off, Xtreme Spectacular, Watery Grave and Arena Split), you target the boss that matches your fire or water debuff. Without a debuff you stay on your boss if it is still up, otherwise you target the one that came back.
- **M10S (`M10s autosim.lua`):** Arena Split reworked to follow the strat step by step: your puddle spot, then your spread spot, then one safe spot from the second cones, then your pair stack, the spot before the knockback and your light-party stack.
  - Safe spot after the spread: on Double-dip you step into the empty slice, on Reverse you stay unless a split cone is on you (far melees step aside). It is the nearest spot clear of every second cone, worked out from where the first cones actually went. The old spot could leave you in your own cone.
  - The Steam Burst bubbles that burst around the light-party stacks are avoided: your stack spot moves out of one if it would reach it.
  - Arena Split is now recognised by where Deep Blue stands, not by counting Alley-oops.
  - The puddle spot is only shown until the puddles drop. The arrow no longer points back to your puddle spot later in the mechanic (this happened when the draw lost track of the Alley-oop, for example when watching a replay).
  - The knockback is 10 y, so the spot before it now carries you onto your light-party stack. The draw switches to the stack when the knockback actually lands and stays up until the bubbles burst.
- **M10S (`M10s autosim.lua`):** the Insane Air 1 boss-landing arrow is removed.

## 2026-11-07

- **Zelenia EX (`Tataru-Zelen.lua`):** Bloom 2 safe side reworked. The floor pattern is now read straight from the arena floor, and the side follows the same rule as cactbot and BossMod: floor with inner WNW red goes west when in is safe first and east when out is safe first, and the other floor is the mirror. The old guess from the Bloom 1 pulse is gone (it was right in only about 6 of 10 recorded pulls). If the floor can't be read, the arrow turns white and the route arrows take the east route (ESE, then ESE in the other ring, then ENE after the second Thunder IV), which was clean on both floors in every recorded pull.

## 2026-11-06

- **Guardian Arkveld EX (`Arkveld.lua`):** the tower picker now says who each tower is for and which waymark it is next to, for example "Small tower NW - R1 (by 1)", "Small tower NE - R2 / H2 (by 2)" and "Big tower NW - MT (between D and 1)". Settings are now saved with FileSave/FileLoad in `TensorReactions\Settings\Arkveld.settings.lua`, the same folder as the Zelenia settings. A choice saved in the old `ArkveldEX_settings.lua` is still read.
- **Zelenia EX (`Tataru-Zelen.lua`):** new Bloom 2 safe side arrow. A big arrow and marker point to the one safe side (east B or west D) from the moment the first Alexandrian Thunder IV is cast until it hits. The side comes from her attack pattern (in or out first) and the floor pattern, using the same rule as cactbot. If the side isn't known for sure, no arrow is shown. The Bloom 2 route arrows now use the same side and no longer guess from where you stand.
- **Zelenia EX (`Tataru-Zelen.lua`):** new pre-pull settings window to choose where DPS go for Bloom 4 Thorns: **DPS B** (east, supports D) or **DPS D** (west, supports B). The Thorns arrow follows your choice. The window closes 3 seconds after combat starts and comes back after a wipe. Your choice is saved with FileSave/FileLoad in `TensorReactions\Settings\Tataru-Zelen.settings.lua`, so it is kept across reloads and updates.
- **M4S (`M4S autosim.lua`):** role safespot draws (Party Roster slot). You get an arrow and circle to your own spot for:
  - Bewitching Flight, Electrifying Witch Hunt (first spreads and near/far baits), Narrowing/Widening Witch Hunt (in/out and baits), Electrope Edge 1 and 2 (safe quadrant, debuff corners, spread/partners), Stampeding Thunder column and Electron Stream / cannon debuffs, and the transition cones with Conduction Point.
  - Sabertail light-party stacks, every Wicked Special, both Mustard Bombs, all three Tail Thrusts (fire/water), Twilight and Midnight Sabbath, Raining Swords towers and Chain Lightning safe swords, Sunrise Sabbath cannons/towers, and Sword Quiver partner stacks.
- **M4S (`M4S autosim.lua`, new):** universal AutoSim for any job. Kill time 712s (FFLogs median), full downtime for the phase 1 to phase 2 transition, 3 melee and 19 caster/movement windows taken from real kills and re-timed when each boss ability lands. No Stun phases, since no knockback stops the whole party.
- **M12S phase 2 (`M12s Autosim Phase 2.lua`, new):** universal AutoSim for any job. Phase-2 kill time 526s (FFLogs median), no full downtime (Lindwurm stays targetable), 5 melee and 17 caster/movement windows re-timed on the real boss casts. No Stun phases, since no knockback hits the whole party.
- **M12S phase 1 (`M12s Phase 1 Autosim phasings .lua`, new):** universal AutoSim for any job. Phase-1 kill time 418s (FFLogs median), full downtime during Grotesquerie: Act 3, 7 melee and 13 caster/movement windows re-timed on the real boss casts, a Stun for the Cruel Coil knockback, and a Stun added live whenever a Raptor Knuckles knockback happens.
- **M11S (`M11s Autosim.lua`, new):**
  - Universal AutoSim for any job: kill time 633s, 9 melee and 15 caster/movement windows re-timed on the real boss casts, and Stun phases while you are knocked into the air at Flatliner and the three platform Explosions. No full downtime (the boss is always targetable).
  - Role draws (Party Roster slot): Assault Evolved sword (light-party stack, G1 left / G2 right) and scythe (role protean spot) shown as soon as the weapons appear, the same for all 6 Ultimate Trophy Weapons plus your tornado bait spot, Dance of Domination pair stacks rotated to the open side, and every Meteorain step including the tank tether spots.
- **M10S (`M10s autosim.lua`, new):**
  - Universal AutoSim for any job: kill time 543s (FFLogs median), full downtime for the boss swaps and Xtreme Spectacular, 7 melee and 20 caster/movement windows re-timed on the real boss casts, plus a setup that also works without a countdown.
  - Black Mage: after Arena Split, while both bosses are targetable and fit in one Meteor, it turns on TensorNuke4's Auto LB and plans a Stun phase for the LB animation.
  - Role draws (Party Roster slot): Alley-oop Double-dip / Reverse clock spots, an arrow to where your boss lands in Insane Air 1 and 2, and Arena Split puddle, protean (mirrored by Deep Blue's side), pair stack and knockback / light-party stack spots.
- **M9S (`M9S autosim.lua`, new):** universal AutoSim for any job. Kill time is 549s (FFLogs median of about 3700 kills). It sets melee downtime for the three Vamp Stomps and Aetherletting, 16 caster/movement windows, and timing uncertainty around the Coffinmaker add. Every window is re-timed on the real boss casts. There is no full downtime, because the Coffinmaker can be attacked while the boss is away.
- **Repository layout:** the files moved to `TimelineReactions/Tataru/` and `GeneralReactions/Tataru/`, so AnyoneCore's Third Party feature can install and auto-update them. If you copied files from the old `timeline/` or `general/` folders, use the new paths.
- **Necron EX (`TataruNecron.lua`):** Grand Cross route for every role slot. It reads the tower set and whether you are targeted, so it shows when to soak and when to bait, and it waits out the puddle wave before moving. It replaces the route copied from my own clears.
- **Necron EX (`TataruNecron.lua`):** End's Embrace 2 spread and hand bait spots are fixed. The safe lane (north, middle or south) is read from the specter tethers. Healers and ranged now each have their own spot, and both draws stay up until their mechanic goes off.
- **Necron EX (`TataruNecron.lua`):** new Memento Mori spread markers for Smite of Gloom. You get an arrow and circle to your own role slot's spot: tanks on the dark side, everyone else on the light side. The side is read from the Memento Mori cast, so the markers flip when the dark side is east.

## 2026-11-05

- **Zelenia EX (`Tataru-Zelen.lua`):**
  - Reworked Bloom draws. Bloom 1-6 now draw per-Bloom arrows, and the replaced draws are kept as disabled "(old)" copies.
  - New draws for the Bloom 5 in/out callout and the Bloom 6 first and second cleaves.
  - A text filter that only shows SWAP, STAND STILL and GO while the timeline runs.
  - Viper Feint and Black Mage Addle / Manaward for Stock Break and Thorned Catharsis.
  - A melee gap closer after the EF2 donut drop.
- **Necron EX (`TataruNecron.lua`):**
  - Role draws for Grand Cross 1 and 2 (routes, intercards, stack middle), Fear of Death spread spots, and Mass Macabre numbered towers with tower state.
  - Blight / Season stack tethers and alerts, and End's Embrace 2 spread and hand bait.
  - Viper Feint for Grand Cross, Fear of Death, Darkness of Eternity and Twofold/Fourfold Blight.
- **Guardian Arkveld EX (`Arkveld.lua`, new):**
  - First version of the Arkveld helper: limit cut arrows, a tower picker window with puddle countdown, and role-based safety arrows. The arrows cover Chainblade, Siegeflight / Wrathful Rattle stacks, Rush, Ouroblade, tail / charge, lasers and Exa.
  - Each reaction sits on its own mechanic's timeline entry.
