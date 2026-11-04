-- [BLM] AutoSim - Caster Downtime Sync
-- eventType: 3
-- displayPath: BLM Optimization
-- mechanicTime: 8
-- timelineIndex: 1
-- timerStartOffset: -8
-- timerEndOffset: 600
-- loop: True
-- condition: category=Self, conditionType=13, jobValue=BLACKMAGE, name=Black Mage

-- [action] [BLM] AutoSim - Caster Downtime Sync
-- Re-time each BLM caster downtime window on the real boss cast start
local e = eventArgs
if not e then return end
local s = TensorNecronBLM
if not s then return end
local SPEC = {
  {44612, 1, "cg1", 4.0, 8.5},
  {44555, 1, "ed1", 9.0, 11.5},
  {44597, 1, "ee1", 8.5, 11.0},
  {44568, 1, "gc1", 13.0, 16.0},
  {44571, 2, "gc2", 0.75, 3.5},
  {44597, 2, "ee2", 9.0, 14.5},
  {44606, 2, "sd2a", 5.5, 8.5},
  {44606, 2, "sd2b", 10.5, 13.5},
  {44556, 3, "sr3a", 4.5, 6.5},
  {44556, 3, "sr3b", 9.0, 11.5}
}
local sp = e.spellID
local api = TensorCore.API.TensorACR
local t = api.getAutoSimTime()
if not t then return end
s.cnt = s.cnt or {}; s.lastC = s.lastC or {}
local counted = false
for _, w in ipairs(SPEC) do
  if w[1] == sp then
    if not counted then
      if not s.lastC[sp] or t - s.lastC[sp] > 5 then
        s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1
      end
      counted = true
    end
    local key = w[3]
    if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then
      s.done = s.done or {}; s.done[key] = true
      if s[key] then
        local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5]); if ok then s[key] = id end
      else
        local ok, id = pcall(api.addAutoSimPhase, "CasterDowntime", t + w[4], t + w[5]); if ok then s[key] = id end
      end
    end
  end
end
