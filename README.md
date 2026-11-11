# TensorReactions AutoSim reactions

My own TensorReactions reactions that drive TensorACR's AutoSim: kill times, full/melee/caster downtime windows, timing uncertainty, the syncs that move those windows to the real boss casts, and the Burn on/off helpers that go with them. It also has my role draws for Zelenia EX and Necron EX, an Arkveld EX helper, and universal AutoSims for M4S, M9S, M10S, M11S and M12S (both phases) that work for any job (M4S, M9S, M10S and M11S also have role draws).

The draws follow whichever strat is currently popular in EU for each fight, such as Hector or LPDU.

Store modules and other authors' profiles are not included.

> **Disclaimer:** these draws use Anyone's Party Roster function (AnyoneCore), so AnyoneCore with a filled-in Party Roster is needed for them to work.

## Files

Each timeline file is my live profile in TensorReactions' own save format, built by `tools/strip_inherited.py`. It holds only my own reactions and no store code.

| File | Fight / timeline | Contents |
|---|---|---|
| `TimelineReactions/Tataru/Tataru-Zelen.lua` | Zelenia EX | Universal AutoSim (14 reactions) and role draws for any job (110 reactions), including a pre-pull settings window for the Bloom 4 Thorns DPS side, plus a Bloom 2 safe-route guide (8 reactions) |
| `TimelineReactions/Tataru/TataruNecron.lua` | Necron EX | Universal AutoSim (13 reactions) and role draws for any job (35 reactions) |
| `TimelineReactions/Tataru/Arkveld.lua` | Guardian Arkveld EX | Arkveld helper for any job (92 reactions): limit cut arrows, tower picker and puddle countdown, role-based safety arrows |
| `TimelineReactions/Tataru/M4S autosim.lua` | M4S (Wicked Thunder) | Universal AutoSim for any job (3 reactions): kill time, phase-transition full downtime, melee and caster/movement windows re-timed on the real boss abilities. Role safespot draws for any job (78 reactions): an arrow and circle to your Party Roster slot's spot for every mechanic from Bewitching Flight to Sword Quiver |
| `TimelineReactions/Tataru/M9S autosim.lua` | M9S (Vamp Fatale) | Universal AutoSim for any job (3 reactions): kill time, melee and caster/movement downtime, timing uncertainty, cast and boss-return syncs. Role draws for any job (11 reactions): Hell in a Cell tower tether, Ultrasonic Spread / Amp spot, Undead Deathmatch group tower |
| `TimelineReactions/Tataru/M10s autosim.lua` | M10S (Red Hot and Deep Blue) | Universal AutoSim for any job (3 reactions), Black Mage Auto LB with a Stun phase after Arena Split (3 reactions), role draws for any job (8 reactions): Alley-oop clock spots, Insane Air 2 boss-landing arrow, Arena Split spots, and auto-targeting for any job (3 reactions): the right boss after Firesnaking / Watersnaking and when a boss comes back |
| `TimelineReactions/Tataru/M11s Autosim.lua` | M11S (The Tyrant) | Universal AutoSim for any job (3 reactions) incl. Stun phases for the knock-ups, and role draws for any job (14 reactions): Assault Evolved sword / scythe spots, Ultimate Trophy Weapons + tornado baits, Dance of Domination pair stacks, Meteorain (your spot for each step, image markers for the melee M1 / M2 spots and the ranged R1 / R2 third-set spots) |
| `TimelineReactions/Tataru/M12s Phase 1 Autosim phasings .lua` | M12S phase 1 (Lindwurm) | Universal AutoSim for any job (3 reactions): phase-1 kill time, Act 3 full downtime, melee and caster/movement windows, Stun for the Cruel Coil and Raptor Knuckles knockbacks |
| `TimelineReactions/Tataru/M12s Autosim Phase 2.lua` | M12S phase 2 (Lindwurm II) | Universal AutoSim for any job (3 reactions): phase-2 kill time, melee and caster/movement windows |
| `GeneralReactions/Tataru/blm.lua` | Any fight | Pre-pull stuff, set up at 2.34 GCD speed (it reads your own cast time, so other speeds work too) |

`GeneralReactions/Tataru/blm.lua` is built from the live profile by `tools/export_autosim.py`.

## Arkveld Tower names

The tower picker in the Arkveld EX helper names each tower by who takes it and the closest waymark (A north, B east, C south, D west, 1 NW, 2 NE, 3 SE, 4 SW).

| Tower | For | Waymark |
|---|---|---|
| Big tower NW | MT | between D and 1 |
| Big tower SE | OT | between B and 3 |
| Small tower NW | R1 | by 1 |
| Small tower NE | R2 / H2 | by 2 |
| Small tower SE | M2 | by 3 |
| Small tower SW | M1 / H1 | by 4 |

## Using the reactions

### Auto-updates with AnyoneCore (recommended)

AnyoneCore's Third Party feature can install this repository and keep it up to date for you.

1. In game, open AnyoneCore and go to the **Third Party** screen.
2. Add this repository as a source: `https://github.com/Tatarus-Playground/tensorreactions-autosim` (branch `main`).
3. AnyoneCore downloads the repository and copies the `TimelineReactions/Tataru` and `GeneralReactions/Tataru` folders into your TensorReactions folder. It checks GitHub for new commits by itself and installs them when they appear.
4. In TensorReactions, select the profile for your fight, for example `Tataru\TataruNecron` for Necron EX, or `Tataru\blm` as a general profile.

Updates replace the files in the `Tataru` folders. Don't edit those profiles directly, or your changes will be overwritten on the next update. To customise a profile, copy it outside the `Tataru` folder and edit the copy.

### Manual install

Copy a file from `TimelineReactions/Tataru` into `TensorReactions/TimelineReactions` (or the general file into `TensorReactions/GeneralReactions`) and select it as the profile for that fight or job. For the M11S Meteorain image markers, also copy the `TimelineReactions/Tataru/assets` folder to `TensorReactions/TimelineReactions/Tataru/assets` (that exact path, even if the profile itself sits elsewhere). To add the reactions to a profile you already have, merge the entries into that profile file instead. Close the game or reload TensorReactions first, and keep a backup of the profile. Manual copies don't update by themselves.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for what changed in each update.

## Thanks

Thank you for the help, Matthew and Anon.
