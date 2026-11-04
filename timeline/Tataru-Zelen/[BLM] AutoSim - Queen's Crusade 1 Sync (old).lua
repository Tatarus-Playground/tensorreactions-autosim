-- [BLM] AutoSim - Queen's Crusade 1 Sync (old)
-- eventType: 3
-- displayPath: BLM Optimization
-- mechanicTime: 171.7
-- timelineIndex: 26
-- timerStartOffset: -12
-- timerEndOffset: 4
-- enabled: False
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Queen's Crusade 1 Sync
-- Queen's Crusade 1 cast start: re-time the matching caster downtime
local e = eventArgs
if not (e and e.spellID == 43194) then return end
local s = TensorZelBLM
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if not (s and t) or s.qcs then return end
s.qcs = true
if s.qc then
  local ok, id = pcall(api.setAutoSimPhase, s.qc, t + 5.75, t + 8.5)
  if ok then s.qc = id end
else
  local ok, id = pcall(api.addAutoSimPhase, "CasterDowntime", t + 5.75, t + 8.5)
  if ok then s.qc = id end
end
self.used = true
