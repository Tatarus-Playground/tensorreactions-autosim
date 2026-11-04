-- [VPR] AutoSim - Necron Return Sync
-- eventType: 26
-- displayPath: VPR Optimization
-- mechanicTime: 250.8
-- timelineIndex: 50
-- timerStartOffset: 20
-- timerEndOffset: 75
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] AutoSim - Necron Return Sync
-- Necron targetable again after the intermission: end downtime, re-time kill
local e = eventArgs
if not (e and e.isTargetable) then return end
local ent = TensorCore.mGetEntity(e.entityID)
if not (ent and ent.name == "Necron") then return end
local s = TensorNecronVPR
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if s and t and t > 260 and not s.ret then
  s.ret = t
  if s.g2 and s.g2s and t > s.g2s + 1 then
    local ok, id = pcall(api.setAutoSimPhase, s.g2, s.g2s, t); if ok then s.g2 = id end
  end
  -- Mass Macabre comes ~135.6s after the boss returns
  if s.mm then local ok, id = pcall(api.setAutoSimPhase, s.mm, t + 138.1, t + 146.1); if ok then s.mm = id end end
  s.kill = 480 + (t - 303.9)
  pcall(api.setAutoSimKillTime, s.kill)
  pcall(api.addAutoSimUncertainty, t, 3)
  self.used = true
end
