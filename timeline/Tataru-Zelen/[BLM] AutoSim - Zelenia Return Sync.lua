-- [BLM] AutoSim - Zelenia Return Sync
-- eventType: 3
-- displayPath: BLM Optimization
-- mechanicTime: 155.9
-- timelineIndex: 23
-- timerStartOffset: -45
-- timerEndOffset: 15
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Zelenia Return Sync
-- Zelenia back from the add phase (Perfumed Quietus cast start): re-time the BLM kill time
local e = eventArgs
if not (e and e.spellID == 43191) then return end
local s = TensorZelBLM
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if s and t and t > 110 and not s.ret then
  s.ret = t
  -- our last 3 kills: Zelenia back at ~147.5 s, dead 249.1 s later on average
  s.kill = t + 249.1
  pcall(api.setAutoSimKillTime, s.kill)
  pcall(api.addAutoSimUncertainty, t, 3)
  self.used = true
end
