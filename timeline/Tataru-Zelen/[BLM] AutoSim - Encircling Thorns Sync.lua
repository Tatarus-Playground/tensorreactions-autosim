-- [BLM] AutoSim - Encircling Thorns Sync
-- eventType: 3
-- displayPath: BLM Optimization
-- mechanicTime: 369.8
-- timelineIndex: 69
-- timerStartOffset: -8
-- timerEndOffset: 5
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Encircling Thorns Sync
-- Encircling Thorns cast start: re-time the matching caster downtime
local e = eventArgs
if not (e and e.spellID == 43203) then return end
local s = TensorZelBLM
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if not (s and t) or s.ets then return end
s.ets = true
if s.et then
  local ok, id = pcall(api.setAutoSimPhase, s.et, t + 0.75, t + 3.5)
  if ok then s.et = id end
else
  local ok, id = pcall(api.addAutoSimPhase, "CasterDowntime", t + 0.75, t + 3.5)
  if ok then s.et = id end
end
self.used = true
