-- [BLM] AutoSim - Banish III Sync
-- eventType: 3
-- displayPath: BLM Optimization
-- mechanicTime: 377.9
-- timelineIndex: 70
-- timerStartOffset: -8
-- timerEndOffset: 5
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Banish III Sync
-- Alexandrian Banish III cast start: re-time the matching caster downtime
local e = eventArgs
if not (e and e.spellID == 43240) then return end
local s = TensorZelBLM
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if not (s and t) or s.b3s then return end
s.b3s = true
if s.b3 then
  local ok, id = pcall(api.setAutoSimPhase, s.b3, t + 0.75, t + 3.5)
  if ok then s.b3 = id end
else
  local ok, id = pcall(api.addAutoSimPhase, "CasterDowntime", t + 0.75, t + 3.5)
  if ok then s.b3 = id end
end
self.used = true
