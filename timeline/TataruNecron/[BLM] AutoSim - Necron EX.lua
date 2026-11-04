-- [BLM] AutoSim - Necron EX
-- eventType: 16
-- displayPath: BLM Optimization
-- mechanicTime: 8
-- timelineIndex: 1
-- timerStartOffset: -60
-- timerEndOffset: -5
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Necron EX
local api = TensorCore.API.TensorACR
-- BLM AutoSim for Necron EX. Kill time and no-target phases match the Viper setup.
pcall(api.clearAutoSimPhases, "FullDowntime")
pcall(api.clearAutoSimPhases, "CasterDowntime")
pcall(api.clearAutoSimUncertainty)
pcall(api.setAutoSimKillTime, 480)
local function add(a, b, kind)
  local ok, id = pcall(api.addAutoSimPhase, kind or "CasterDowntime", a, b)
  if ok then return id end
end
-- Darkness of Eternity (median hit 243.2s): no target from +6 to +21.3,
-- something hittable for ~8s, then no target until Necron returns (~+60.6)
TensorNecronBLM = {
  kill = 480,
  g1 = add(249.2, 264.5, "FullDowntime"),
  g2s = 272.7,
  g2 = add(272.7, 303.9, "FullDowntime"),
  -- caster downtime (no hardcasts): local damage casters + 68 top BLM FFLogs kills; re-timed on the real casts
  cg1 = add(38.40, 42.90), -- Cold Grip 1: +4.0..+8.5
  ed1 = add(50.00, 52.50), -- Existential Dread 1: +9.0..+11.5
  ee1 = add(107.90, 110.40), -- The End's Embrace 1: +8.5..+11.0
  gc1 = add(146.80, 149.80), -- Grand Cross 1: +13.0..+16.0
  gc2 = add(170.85, 173.60), -- Grand Cross end: +0.75..+3.5
  ee2 = add(326.30, 331.80), -- The End's Embrace 2: +9.0..+14.5
  sd2a = add(401.40, 404.40), -- Specter of Death 2 (a): +5.5..+8.5
  sd2b = add(406.40, 409.40), -- Specter of Death 2 (b): +10.5..+13.5
  sr3a = add(412.10, 414.10), -- Soul Reaping 3 (a): +4.5..+6.5
  sr3b = add(416.60, 419.10), -- Soul Reaping 3 (b): +9.0..+11.5
}
pcall(api.addAutoSimUncertainty, 200, 5)
self.used = true
