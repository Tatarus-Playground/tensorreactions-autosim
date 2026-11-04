-- [Draw] Bloom 1 - Thunder II follow the rotation
-- eventType: 12
-- displayPath: Role Draws
-- mechanicTime: 179.1
-- timelineIndex: 27
-- timerStartOffset: -5.3
-- timerEndOffset: 15.5
-- loop: True

-- [action] [Draw] Bloom 1 - Thunder II follow the rotation
local function hush() end -- removed text callouts (draws cover them)
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
-- Bloom 1 Thunder II: arrow to the start spot just behind a cone, then follow the rotation on plain tiles
-- (plan = 15 snapshot phases x 16 tiles, solved once; afterwards each frame only looks up the phase)
local b = Z.b1
local now = Now()
if not (b and b.t0 and now - b.t0 < 40000) then return end
if not b.plan and not b.planFail then
  local cones = {}
  if b.cones then for _, c in pairs(b.cones) do cones[#cones + 1] = c end end
  if #cones < 3 then
    if b.chanT and now - b.chanT < 400 then return end
    if not b.chanT and now - b.t0 < 1000 then return end
  end
  local dir = b.dir
  if not dir and #cones == 3 then
    -- every log: CW starts {22.5,142.5,262.5}, CCW starts {67.5,187.5,307.5}
    local m = cones[1] % 120
    if math.abs(m - 22.5) < 4 then dir = 1 elseif math.abs(m - 67.5) < 4 then dir = -1 end
  end
  if not dir then
    if not b.said0 and b.chanT and now - b.chanT > 1500 then
      b.said0 = true
      hush(6000, "THUNDER II: 3 inner safe tiles, stay BEHIND the rotation", 0xFF00FFFF)
    end
    return
  end
  if #cones ~= 3 then cones = (dir > 0) and {22.5, 142.5, 262.5} or {67.5, 187.5, 307.5} end
  -- floor: live tile tracker when fresh and plausible, else the floor seen in every log for this rotation
  local red, useT, newest = {}, false, 0
  if Z.tilesKnown and type(Z.tiles) == "table" then
    local nr = 0
    for t = 0, 15 do
      if Z.tiles[t] then nr = nr + 1 end
      local tt = type(Z.tileT) == "table" and Z.tileT[t]
      if tt and tt > newest then newest = tt end
    end
    useT = (nr >= 4 and nr <= 13 and now - newest < 25000)
    -- floor still changing: wait for it to settle (max 2.5s after the rotation marker)
    if useT and now - newest < 400 and now - b.t0 < 2500 then return end
  end
  b.planNewest = newest
  if useT then
    for t = 0, 15 do red[t] = Z.tiles[t] and true or false end
  else
    local plain = (dir > 0) and {[2] = 1, [3] = 1, [4] = 1, [9] = 1, [10] = 1, [12] = 1}
      or {[0] = 1, [3] = 1, [6] = 1, [7] = 1, [13] = 1, [14] = 1}
    for t = 0, 15 do red[t] = not plain[t] end
  end
  -- node(n, u): safe arc of tile u for snapshot n (outside the cones at n-1 and n), target = its forward end
  local function node(n, u)
    local inner = u < 8
    local k = u % 8
    local s = 45 * k
    -- start spot (before the 1st hit, held ~5 s): wider margin; afterwards 8 deg behind the cone that just fired
    local mg = (n == 0) and (inner and 15 or 9) or (inner and 8 or 5)
    local em = inner and 9 or 5.5
    local base = inner and 0 or 8
    local a, bb = s, s + 45
    if red[base + (k + 7) % 8] then a = a + em end
    if red[base + (k + 1) % 8] then bb = bb - em end
    local arcs = {}
    for i = 1, 3 do
      local p2 = cones[i] + 10 * dir * n
      local p1 = (n > 0) and (cones[i] + 10 * dir * (n - 1)) or p2
      local x0 = math.min(p1, p2) - 22.5 - mg
      local x1 = math.max(p1, p2) + 22.5 + mg
      arcs[i] = {x0, x1}
      local w = x1 - x0
      local p = (x0 - s) % 360
      if p < 45 then
        if s + p <= a then a = math.max(a, s + p + w) else bb = math.min(bb, s + p) end
      end
      if p + w > 360 then a = math.max(a, s + p + w - 360) end
    end
    if bb - a < (inner and 2 or 1.5) then return nil end
    local t = (dir > 0) and bb or a
    local lag = 999
    for i = 1, 3 do
      local g = (dir > 0) and ((arcs[i][1] - t) % 360) or ((t - arcs[i][2]) % 360)
      if g < lag then lag = g end
    end
    if lag > 180 then lag = 0 end
    local x, z = Z.pt(100, 100, t, inner and 5.5 or 10)
    return {u = u, ang = t, inner = inner, lag = lag, x = x, z = z}
  end
  local N, INF = 15, 1e9
  local nodes, best, nxt = {}, {}, {}
  for n = 0, N - 1 do
    nodes[n], best[n], nxt[n] = {}, {}, {}
    for u = 0, 15 do nodes[n][u] = node(n, u) end
  end
  local function ncost(q)
    local c = q.lag / 10 + (q.inner and 0 or 0.3)
    if red[q.u] then c = c + 25 end
    return c
  end
  for u = 0, 15 do
    local q = nodes[N - 1][u]
    best[N - 1][u] = q and ncost(q) or INF
  end
  for n = N - 2, 0, -1 do
    for u = 0, 15 do
      local q = nodes[n][u]
      local bc, bv = INF, nil
      if q then
        local k = u % 8
        local base = (u < 8) and 0 or 8
        local cand = {u, base + (k + 7) % 8, base + (k + 1) % 8, (u < 8) and (u + 8) or (u - 8)}
        for j = 1, 4 do
          local v = cand[j]
          local w = nodes[n + 1][v]
          if w and best[n + 1][v] < INF then
            local dx, dz = q.x - w.x, q.z - w.z
            local dist = math.sqrt(dx * dx + dz * dz)
            local okm = dist <= 6.5
            local tc = 0
            if v ~= u then
              tc = (v % 8 == k) and 1.5 or 0.5
              if math.abs((q.ang - w.ang + 540) % 360 - 180) > 30 then okm = false end
            end
            if dist > 4 then tc = tc + dist - 4 end
            if okm and tc + best[n + 1][v] < bc then bc, bv = tc + best[n + 1][v], v end
          end
        end
      end
      if bv then
        best[n][u] = ncost(q) + bc
        nxt[n][u] = bv
      else
        best[n][u] = INF
      end
    end
  end
  local u0, c0 = nil, INF
  for u = 0, 15 do
    local c = best[0][u] + ((u < 8) and 0 or 0.5)
    if c < c0 then u0, c0 = u, c end
  end
  if not u0 then
    b.planFail = true
    return
  end
  local plan = {dir = dir, cones = cones, useT = useT, red = red}
  local u = u0
  for n = 0, N - 1 do
    local q = u and nodes[n][u]
    if not q then break end
    plan[n] = q
    u = nxt[n][u]
  end
  b.plan = plan
  local q0 = plan[0]
  if q0 and b.saidU ~= q0.u then
    b.saidU = q0.u
    hush(7000, "THUNDER II: rotates " .. ((dir > 0) and "CLOCKWISE" or "COUNTER-CLOCKWISE") .. " - start " ..
      Z.dirName(q0.ang) .. (q0.inner and " inner" or " outer") .. ", follow the arrow", 0xFF00FFFF)
  end
end
local plan = b.plan
if not plan then return end
-- phase = next snapshot index: counted casts, or time since the first hit when a cast event was missed
local n = b.k or 0
local T0 = b.T0 or (b.chanT and (b.chanT + 5540))
if T0 and now > T0 + 300 then
  local nt = math.floor((now - T0 - 300) / 1007) + 1
  if nt > n then n = nt end
end
if n > 14 then return end
-- before the first hit: if the floor changed after planning, plan again next frame
if n == 0 and Z.tilesKnown and type(Z.tileT) == "table" then
  local nw = 0
  for t = 0, 15 do
    local tt = Z.tileT[t]
    if tt and tt > nw then nw = tt end
  end
  if nw > (b.planNewest or 0) + 50 then
    b.plan = nil
    return
  end
end
local q = plan[n]
if not q then return end
Z.goTo(q.x, q.z, 0x33FF33, 0.7)
local p = TensorCore.mGetPlayer()
local y = (p and p.pos) and p.pos.y or 0
local q2 = plan[n + 1]
if q2 then
  TensorCore.getCachedDrawer(0x4400FFFF, 0x6600FFFF, 0x9900FFFF, 0xFF00FFFF, 1.5):addCircle(q2.x, y, q2.z, 0.45, false, Z.flags)
end
-- edges of the three cones that hit next
local dl = TensorCore.getStaticDrawer(0xCC3333FF, 2)
local cs = plan.cones
for i = 1, 3 do
  local c = cs[i] + 10 * plan.dir * n
  local xa, za = Z.pt(100, 100, c - 22.5, 2.5)
  local xb, zb = Z.pt(100, 100, c - 22.5, 16)
  dl:addLine(xa, y, za, xb, y, zb, 2)
  xa, za = Z.pt(100, 100, c + 22.5, 2.5)
  xb, zb = Z.pt(100, 100, c + 22.5, 16)
  dl:addLine(xa, y, za, xb, y, zb, 2)
end
