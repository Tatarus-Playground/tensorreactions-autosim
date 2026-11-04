-- [BLM] AutoSim - Darkness of Eternity Sync
-- eventType: 2
-- displayPath: BLM Optimization
-- mechanicTime: 250.8
-- timelineIndex: 50
-- timerStartOffset: -20
-- timerEndOffset: 8
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Darkness of Eternity Sync
-- Darkness of Eternity landed: re-time both intermission downtimes (same as Viper)
local e = eventArgs
if not (e and e.spellID == 44580) then return end
local s = TensorNecronBLM
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if s and t and t > 150 and not s.doe then
  s.doe = t
  if s.g1 then local ok, id = pcall(api.setAutoSimPhase, s.g1, t + 6.0, t + 21.3); if ok then s.g1 = id end end
  if s.g2 then local ok, id = pcall(api.setAutoSimPhase, s.g2, t + 29.5, t + 60.6); if ok then s.g2 = id; s.g2s = t + 29.5 end end
  self.used = true
end
