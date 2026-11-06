# TensorReactions AutoSim reactions

My own TensorReactions reactions that drive TensorACR's AutoSim: kill times, full/melee/caster downtime windows, timing uncertainty, the syncs that move those windows to the real boss casts, and the Burn on/off helpers that go with them. It also has my role draws for Zelenia EX and Necron EX, an Arkveld EX helper, and universal AutoSims for M4S, M9S, M10S, M11S and M12S (both phases) that work for any job (M4S, M10S and M11S also have role draws).

Store modules and other authors' profiles are not included.

> **Disclaimer:** these draws use Anyone's Party Roster function (AnyoneCore), so AnyoneCore with a filled-in Party Roster is needed for them to work.

## Files

Each timeline file is my live profile in TensorReactions' own save format, built by `tools/strip_inherited.py`. It holds only my own reactions and no store code.

| File | Fight / timeline | Contents |
|---|---|---|
| `TimelineReactions/Tataru/Tataru-Zelen.lua` | Zelenia EX | AutoSim for Viper and Black Mage (10 reactions) and role draws for any job (98 reactions) |
| `TimelineReactions/Tataru/TataruNecron.lua` | Necron EX | AutoSim for Viper and Black Mage (9 reactions) and role draws for any job (35 reactions) |
| `TimelineReactions/Tataru/Arkveld.lua` | Guardian Arkveld EX | Arkveld helper for any job (92 reactions): limit cut arrows, tower picker and puddle countdown, role-based safety arrows |
| `TimelineReactions/Tataru/M4S autosim.lua` | M4S (Wicked Thunder) | Universal AutoSim for any job (3 reactions): kill time, phase-transition full downtime, melee and caster/movement windows re-timed on the real boss abilities. Role safespot draws for any job (78 reactions): an arrow and circle to your Party Roster slot's spot for every mechanic from Bewitching Flight to Sword Quiver |
| `TimelineReactions/Tataru/M9S autosim.lua` | M9S (Vamp Fatale) | Universal AutoSim for any job (3 reactions): kill time, melee and caster/movement downtime, timing uncertainty, cast and boss-return syncs |
| `TimelineReactions/Tataru/M10s autosim.lua` | M10S (Red Hot and Deep Blue) | Universal AutoSim for any job (3 reactions), Black Mage Auto LB with a Stun phase after Arena Split (3 reactions), and role draws for any job (9 reactions): Alley-oop clock spots, Insane Air boss-landing arrows, Arena Split spots |
| `TimelineReactions/Tataru/M11s Autosim.lua` | M11S (The Tyrant) | Universal AutoSim for any job (3 reactions) incl. Stun phases for the knock-ups, and role draws for any job (11 reactions): Assault Evolved sword / scythe spots, Ultimate Trophy Weapons + tornado baits, Dance of Domination pair stacks, Meteorain |
| `TimelineReactions/Tataru/M12s Phase 1 Autosim phasings .lua` | M12S phase 1 (Lindwurm) | Universal AutoSim for any job (3 reactions): phase-1 kill time, Act 3 full downtime, melee and caster/movement windows, Stun for the Cruel Coil and Raptor Knuckles knockbacks |
| `TimelineReactions/Tataru/M12s Autosim Phase 2.lua` | M12S phase 2 (Lindwurm II) | Universal AutoSim for any job (3 reactions): phase-2 kill time, melee and caster/movement windows |
| `GeneralReactions/Tataru/blm.lua` | Any fight | Black Mage countdown / pre-pull helpers (3 reactions) |

`GeneralReactions/Tataru/blm.lua` is built from the live profile by `tools/export_autosim.py`.

## Using the reactions

### Auto-updates with AnyoneCore (recommended)

AnyoneCore's Third Party feature can install this repository and keep it up to date for you.

1. In game, open AnyoneCore and go to the **Third Party** screen.
2. Add this repository as a source: `https://github.com/Tatarus-Playground/tensorreactions-autosim` (branch `main`).
3. AnyoneCore downloads the repository and copies the `TimelineReactions/Tataru` and `GeneralReactions/Tataru` folders into your TensorReactions folder. It checks GitHub for new commits by itself and installs them when they appear.
4. In TensorReactions, select the profile for your fight, for example `Tataru\TataruNecron` for Necron EX, or `Tataru\blm` as a general profile.

Updates replace the files in the `Tataru` folders. Don't edit those profiles directly, or your changes will be overwritten on the next update. To customise a profile, copy it outside the `Tataru` folder and edit the copy.

### Manual install

Copy a file from `TimelineReactions/Tataru` into `TensorReactions/TimelineReactions` (or the general file into `TensorReactions/GeneralReactions`) and select it as the profile for that fight or job. To add the reactions to a profile you already have, merge the entries into that profile file instead. Close the game or reload TensorReactions first, and keep a backup of the profile. Manual copies don't update by themselves.

## Changelog

### 2026-11-06

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

### 2026-11-05

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
