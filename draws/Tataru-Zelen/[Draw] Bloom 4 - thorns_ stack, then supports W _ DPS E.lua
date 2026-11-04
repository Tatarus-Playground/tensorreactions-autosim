-- [Draw] Bloom 4 - thorns: stack, then supports W / DPS E
-- eventType: 12
-- displayPath: Role Draws
-- mechanicTime: 369.8
-- timelineIndex: 69
-- timerStartOffset: -3.6
-- timerEndOffset: 9.4
-- loop: True

-- [action] [Draw] Bloom 4 - thorns: stack, then supports W / DPS E
data.zel = data.zel or {}
local Z = data.zel
if not Z.initV then
  Z.initV = true
  Z.flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY
  Z.SUPJOB = {[1]=true,[3]=true,[6]=true,[19]=true,[21]=true,[24]=true,[28]=true,[32]=true,[33]=true,[37]=true,[40]=true}
  Z.TANKJOB = {[1]=true,[3]=true,[19]=true,[21]=true,[32]=true,[37]=true}
  Z.SHOCK_TOWER = {T1={92,95},R1={92,95},H2={108,95},R2={108,95},T2={108,105},M2={108,105},H1={92,105},M1={92,105}}
  Z.SHOCK_CARD = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}
  Z.EF_HIT = {13.8, 16.9, 20.0, 23.1}
  Z.EF_CLOCK = {T1=0,R2=45,H2=90,M2=135,T2=180,M1=225,H1=270,R1=315}
  Z.EF_FAN = {R1=22.5,R2=67.5,M1=112.5,M2=157.5,T2=202.5,H2=247.5,H1=292.5,T1=337.5}
  Z.B3_ROSE = {T1=0,R1=0,T2=180,M2=180,H1=225,M1=225,H2=135,R2=135}
  Z.B3_TOWER = {T1=0,R1=0,H2=90,R2=90,T2=180,M2=180,H1=270,M1=270}
  Z.B4_ROSE = {T1={205,4.5},M1={205,4.5},T2={160,6},M2={160,6},H1={212,10.5},R1={212,10.5},H2={150,11.5},R2={150,11.5}}
  Z.B4_SPREAD = {T1={-10,7.5},M1={-10,7.5},T2={21,9.5},M2={21,9.5},H1={-55,13.5},R1={-55,13.5},H2={55,13.5},R2={55,13.5}}
  Z.B6_ROSE = {T1=337.5,R1=337.5,H2=22.5,R2=22.5,H1=202.5,M1=202.5,T2=157.5,M2=157.5}
  function Z.slot()
    local R = AnyoneCore and AnyoneCore.Roster
    local s = R and R.mySlot and R.mySlot()
    if not s and GetCurrentRole then
      local r = GetCurrentRole()
      s = (r == "MT" and "T1") or (r == "OT" and "T2") or r
    end
    return s
  end
  function Z.slotOf(id)
    local R = AnyoneCore and AnyoneCore.Roster
    return R and R.slotOf and R.slotOf(id)
  end
  function Z.isSup(s) return s == "T1" or s == "T2" or s == "H1" or s == "H2" end
  function Z.supOf(id)
    local s = Z.slotOf(id)
    if s then return Z.isSup(s) end
    local e = TensorCore.mGetEntity(id)
    return (e and Z.SUPJOB[e.job]) and true or false
  end
  function Z.tankOf(id)
    local s = Z.slotOf(id)
    if s then return s == "T1" or s == "T2" end
    local e = TensorCore.mGetEntity(id)
    return (e and Z.TANKJOB[e.job]) and true or false
  end
  function Z.pt(cx, cz, deg, r)
    local a = math.rad(deg)
    return cx + r * math.sin(a), cz - r * math.cos(a)
  end
  function Z.goTo(x, z, col, rad)
    local p = TensorCore.mGetPlayer()
    if not (p and p.pos) then return end
    local g = TensorCore.getCachedDrawer(0x55000000 + col, 0x88000000 + col, 0xFF000000 + col, 0xFF000000, 2)
    local px, py, pz = p.pos.x, p.pos.y, p.pos.z
    local d = TensorCore.getDistance2d2(px, py, pz, x, py, z)
    if d > 0.8 then
      -- tether from you to your spot
      TensorCore.getStaticDrawer(0xFF000000 + col, 3):addLine(px, py, pz, x, py, z, 3)
      local tip = math.min(1.5, d * 0.35)
      g:addArrow(px, py, pz, TensorCore.getHeadingToTarget2(px, py, pz, x, py, z), math.max(0.1, d - tip), 0.65, tip, 1.3, false, Z.flags)
    end
    g:addCircle(x, py, z, rad or 1.0, false, Z.flags)
  end
  function Z.say(ms, txt, col)
    local p = TensorCore.mGetPlayer()
    if p and AnyoneCore and AnyoneCore.addTimedWorldTextOnEnt then
      pcall(AnyoneCore.addTimedWorldTextOnEnt, ms, txt, p.id, col or 0xFFFFFFFF, true, 2.0, 2.8)
    end
  end
  function Z.dirName(deg)
    local N = {"N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"}
    return N[math.floor(((deg % 360) + 11.25) / 22.5) % 16 + 1]
  end
  -- Escelons' Fall: IN or OUT for hit k (supports and DPS alternate taking the hits)
  function Z.efState(k)
    local ef = Z.ef
    if not ef then return nil end
    local sym = ef.sym
    if not sym[k] then return nil end
    local mySup = Z.isSup(Z.slot())
    local supFirst
    if ef.mode == 2 and Z.donutSup ~= nil then
      -- old fan-spread EF2 only; Braindead EF2 never sets donutSup and is solved like EF1/EF3
      supFirst = not Z.donutSup
    else
      if not sym[1] then return nil end
      supFirst = (sym[1] == "F")
    end
    local iTake = ((k % 2 == 1) == (supFirst == mySup))
    if iTake then return (sym[k] == "N") and "IN" or "OUT" end
    return (sym[k] == "N") and "OUT" or "IN"
  end
end
if not Z.tileHV1 then
  Z.tileHV1 = true
  -- floor tiles (BossMod Ex4Zelenia numbering): 0-7 inner ring (r <= 8), 8-15 outer ring (8 < r <= 16);
  -- tile t%8 = k spans [45k, 45k+45) degrees clockwise from north (centre 22.5 + 45k). Z.tiles[t] = true while red.
  Z.tiles = Z.tiles or {}
  Z.tileT = Z.tileT or {}
  function Z.tileAngle(t) return 22.5 + 45 * (t % 8) end
  function Z.tileCenter(t) return Z.pt(100, 100, Z.tileAngle(t), (t < 8) and 4 or 12) end
  function Z.tilePoint(t, frac)
    local r0 = (t < 8) and 0 or 8
    return Z.pt(100, 100, Z.tileAngle(t), r0 + 8 * (frac or 0.5))
  end
  function Z.tileOf(x, z)
    local dx, dz = x - 100, z - 100
    local k = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8
    if dx * dx + dz * dz <= 64 then return k end
    return k + 8
  end
  function Z.tileEdges(t)
    if t == 0 then return {7, 1, 8} elseif t == 7 then return {6, 0, 15}
    elseif t == 8 then return {15, 9, 0} elseif t == 15 then return {14, 8, 7} end
    return {t - 1, t + 1, (t > 8) and (t - 8) or (t + 8)}
  end
  function Z.connected(t)
    local set = {}
    if not (t and Z.tiles[t]) then return set end
    local q, h = {t}, 1
    set[t] = true
    while q[h] do
      local v = q[h]; h = h + 1
      for _, w in ipairs(Z.tileEdges(v)) do
        if Z.tiles[w] and not set[w] then set[w] = true; q[#q + 1] = w end
      end
    end
    return set
  end
end
-- Bloom 4 Encircling Thorns / Banish III: HOLD a tight stack on the ground-AoE side until the chains appear,
-- THEN supports W / DPS E into the always-red outer tile on the ROSE side of due W/E (it is connected to the
-- rose tiles, so the healer's 8-person stack reaches the DPS through it). Pre-running makes the chain unbreakable.
local s = Z.slot()
if not s then return end
local b = Z.b4
if not b then
  b = {}
  Z.b4 = b
end
local now = Now()
local p = TensorCore.mGetPlayer()
if not (p and p.pos) then return end
local py = p.pos.y
-- G = ground-AoE side (0 = north, 180 = south); the roses and the red pathway are on the other side
local G = nil
if b.gT and b.gz and b.gz ~= 0 then G = (b.gz > 0) and 180 or 0 end
if not G and Z.tilesKnown and Z.tiles and Z.tileT then
  local nN, nS = 0, 0
  for t = 0, 15 do
    local tt = Z.tileT[t]
    if Z.tiles[t] and tt and now - tt < 20000 then
      local k = t % 8
      if k == 0 or k == 7 then nN = nN + 1 elseif k == 3 or k == 4 then nS = nS + 1 end
    end
  end
  if nN > nS then G = 180 elseif nS > nN then G = 0 end
end
if not b.f0 or now - b.f0 > 20000 then b.f0 = now end
-- party list, refreshed at most every 300 ms (used for the stack centroid and the last-resort G guess)
if not b.cT or now - b.cT > 300 then
  b.cT = now
  b.cx, b.cz, b.gG = nil, nil, nil
  local L = TensorCore.getEntityGroupList("Party")
  if type(L) == "table" then
    local sx, sz
    if G then sx, sz = Z.pt(100, 100, G, 3.5) end
    local n, ax, az, m, mz = 0, 0, 0, 0, 0
    for _, v in pairs(L) do
      local e = v
      if type(v) == "number" then e = TensorCore.mGetEntity(v) end
      if type(e) == "table" and e.pos and e.id ~= p.id and not (e.hp and e.hp.percent == 0) then
        m = m + 1
        mz = mz + e.pos.z
        if sx then
          local dx, dz = e.pos.x - sx, e.pos.z - sz
          if dx * dx + dz * dz < 36 then
            n = n + 1
            ax = ax + e.pos.x
            az = az + e.pos.z
          end
        end
      end
    end
    if n >= 3 then
      local cx, cz = ax / n, az / n
      if (cx - 100) * (cx - 100) + (cz - 100) * (cz - 100) > 7.84 then b.cx, b.cz = cx, cz end
    end
    -- PF groups stack on the ground-AoE side: mean z of the party as a last-resort G
    if m >= 3 then
      mz = mz / m
      if mz > 101 then b.gG = 180 elseif mz < 99 then b.gG = 0 end
    end
  end
end
-- chains appear ~15.5 s after the ground AoEs (~373.7); tracker first, time as fallback
local chained = (b.tT ~= nil)
if not chained then
  if b.gT then chained = (now - b.gT > 15900) else chained = (now - b.f0 > 7900) end
end
if not chained then
  if not G then return end
  local sx, sz = Z.pt(100, 100, G, 3.5)
  -- join the group if it is already stacked near the spot (short chain = it breaks at ~initial + 20 y)
  if b.cx then sx, sz = b.cx, b.cz end
  -- coming from the rose side: walk around the centre void zone (r2) instead of through it
  local px, pz = p.pos.x, p.pos.z
  local dx, dz = sx - px, sz - pz
  local L2 = dx * dx + dz * dz
  if L2 > 1 then
    local t = ((100 - px) * dx + (100 - pz) * dz) / L2
    if t > 0 and t < 1 then
      local qx, qz = px + t * dx - 100, pz + t * dz - 100
      if qx * qx + qz * qz < 7.84 then
        local g = math.rad(G)
        local lat = (px - 100) * math.cos(g) + (pz - 100) * math.sin(g)
        sx, sz = Z.pt(100, 100, G + ((lat >= 0) and 90 or -90), 5.5)
      end
    end
  end
  Z.goTo(sx, sz, 0x00FFFF, 1.2)
  return
end
if not G then G = b.gG end
local sup = Z.isSup(s)
local east = not sup
if b.mySame and b.myP and not b.myBroke then
  -- chained to your own role (deaths): the tether TARGET takes the other role's side, the source keeps its own;
  -- once the partner commits to a side, go to the other one
  if not b.mySrc then east = not east end
  local pe = TensorCore.mGetEntity(b.myP)
  if pe and pe.pos then
    if pe.pos.x < 97 then east = true elseif pe.pos.x > 103 then east = false end
  end
end
local a
if G == 180 then
  a = east and 75 or 285
elseif G == 0 then
  a = east and 105 or 255
else
  a = east and 90 or 270
end
local x, z = Z.pt(100, 100, a, 14)
local col = b.myBroke and 0x33FF33 or (sup and 0xFFFF00 or 0x0099FF)
Z.goTo(x, z, col, 1.5)
if G then
  -- outline the red outer tile you must stand IN
  local d = TensorCore.getStaticDrawer(0xFF000000 + col, 2)
  local a0 = 45 * math.floor(a / 45)
  local pix, piz, pox, poz
  for i = 0, 3 do
    local aa = a0 + 15 * i
    local ix, iz = Z.pt(100, 100, aa, 8)
    local ox, oz = Z.pt(100, 100, aa, 15.8)
    if i == 0 or i == 3 then d:addLine(ix, py, iz, ox, py, oz, 2) end
    if pix then
      d:addLine(pix, py, piz, ix, py, iz, 2)
      d:addLine(pox, py, poz, ox, py, oz, 2)
    end
    pix, piz, pox, poz = ix, iz, ox, oz
  end
end
