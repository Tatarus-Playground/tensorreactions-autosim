-- [BLM] AutoSim - Caster Downtime
-- eventType: 16
-- displayPath: BLM Optimization
-- mechanicTime: 11.4
-- timelineIndex: 1
-- timerStartOffset: -60
-- timerEndOffset: -5
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Caster Downtime
local api = TensorCore.API.TensorACR
-- BLM caster downtime (no hardcasts): local damage-caster movement + top BLM FFLogs kills; re-timed by the sync reactions
pcall(api.clearAutoSimPhases, "CasterDowntime")
pcall(api.clearAutoSimUncertainty)
-- Kill time: average of our last 3 kills (394.5 / 392.6 / 402.8 s, 2026-11-04); re-timed when Zelenia returns
pcall(api.setAutoSimKillTime, 397)
-- Add phase length depends on add kill speed
pcall(api.addAutoSimUncertainty, 94, 12)
local function add(a, b)
  local ok, id = pcall(api.addAutoSimPhase, "CasterDowntime", a, b)
  if ok then return id end
end
TensorZelBLM = {
  kill = 397,
  sp = add(40.4, 43.4),     -- Specter of the Lost 1: +2.5..+5.5
  th3 = add(186.0, 188.0),  -- Alexandrian Thunder III 1 (Bloom 2): +1.5..+3.5
  qc2 = add(217.9, 220.4),  -- Queen's Crusade 2 (Bloom 2 Thunder Slash cleave): +13.5..+16
  et = add(357.0, 359.8),   -- Encircling Thorns: move to the stack spot, +0.75..+3.5
  b3 = add(365.2, 368.0),   -- Banish III: chain break run, +0.75..+3.5
}
self.used = true
