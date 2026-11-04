-- [VPR] AutoSim - Encircling Thorns Sync
-- eventType: 3
-- displayPath: VPR Optimization
-- mechanicTime: 377.9
-- timelineIndex: 70
-- timerStartOffset: -15
-- timerEndOffset: 5
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] AutoSim - Encircling Thorns Sync
-- Alexandrian Banish III cast start: exact out-of-melee window for Encircling Thorns
local e = eventArgs
if not (e and e.spellID == 43240) then return end
local s = TensorZelVPR
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if s and t and not s.bsync then
  s.bsync = true
  local hit = t + (e.channelTimeMax or 4.0)
  if s.bn then local ok, id = pcall(api.setAutoSimPhase, s.bn, hit - 2.1, hit + 2.9); if ok then s.bn = id end
  else pcall(api.addAutoSimPhase, "MeleeDowntime", hit - 2.1, hit + 2.9) end
  self.used = true
end
