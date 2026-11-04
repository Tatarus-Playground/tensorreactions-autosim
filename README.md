# TensorReactions AutoSim reactions

My own TensorReactions reactions that drive TensorACR's AutoSim: kill times, full/melee/caster downtime windows, timing uncertainty, the syncs that move those windows to the real boss casts, and the Burn on/off helpers that go with them. It also has my Zelenia EX role draws.

Store modules and other authors' profiles are not included.

> **Disclaimer:** these draws use Anyone's Party Roster function (AnyoneCore), so AnyoneCore with a filled-in Party Roster is needed for them to work.

## Layout

```
timeline/<profile>/   AutoSim reactions from a timeline profile (one folder per fight profile)
general/<profile>/    AutoSim reactions from a general (per-job) profile
draws/<profile>/      role draws (arrows, circles, callouts) from a timeline profile
tools/                export script
```

Each profile folder holds:

- one `.lua` file per reaction: a short header (event, timeline mechanic, offsets, conditions) followed by the reaction's Lua
- `_profile_subset.lua`: the same reactions in TensorReactions' own save format, including their folders

| Folder | Fight / timeline | Job |
|---|---|---|
| `timeline/Tataru-Zelen` | Zelenia EX | Viper, Black Mage |
| `timeline/TataruNecron` | Necron EX | Viper, Black Mage |
| `general/blm` | Countdown / pre-pull helpers | Black Mage |
| `draws/Tataru-Zelen` | Zelenia EX role draws (90 reactions) | Any job |

## Using a reaction

Open the reaction's `.lua` file, then create a reaction in TensorReactions with the event, timeline mechanic, offsets and conditions from the header and paste in the Lua.

To bring in a whole set at once, merge the entries from `_profile_subset.lua` into the matching profile file in `TensorReactions/TimelineReactions` or `TensorReactions/GeneralReactions`. Close the game or reload TensorReactions first, and keep a backup of the profile.