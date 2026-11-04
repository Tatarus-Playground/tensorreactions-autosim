-- [Draw] Bloom 2 - Thunder route arrows
-- eventType: 12
-- displayPath: Role Draws
-- mechanicTime: 227.2
-- timelineIndex: 35
-- timerStartOffset: -6.9
-- timerEndOffset: 5.8
-- loop: True

-- [action] [Draw] Bloom 2 - Thunder route arrows
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
-- ===== Bloom 2 (Roseblood: 2nd Bloom): Thunder Slash cones + Alexandrian Thunder IV route =====
if Z.b2V ~= 2 then
  Z.b2V = 2
  -- Thunder Slash hit order, deg clockwise from N (same in all 9 logged pulls; one cone per second)
  Z.B2_CONES = {0, 180, 60, 240, 120, 300}
  -- seconds after the 1st Thunder IV channel start until hit k resolves (T4 #1 = hit 1, T4 #2 = hit 4)
  Z.B2_HIT = {6.72, 7.64, 8.63, 9.63, 10.64, 11.60}
  -- side sectors k (inner tile k, outer tile k+8): E = 1 ENE / 2 ESE, W = 5 WSW / 6 WNW
  Z.B2_SIDE = {E = {1, 2}, W = {5, 6}}
  Z.B2_NAME = {[1] = "ENE", [2] = "ESE", [5] = "WSW", [6] = "WNW"}
  -- standing spot of sector k: "IN" = tile centre angle, r 6; "OUT" = 13 deg off the E/W line, r 10
  function Z.b2Spot(k, ring)
    local c = 22.5 + 45 * k
    if ring == "OUT" then
      if k == 1 or k == 2 then return (c > 90) and 103 or 77, 10.0 end
      if k == 5 or k == 6 then return (c > 270) and 283 or 257, 10.0 end
      return c, 12.0
    end
    return c, 6.0
  end
  -- index (1..6) of the cone whose direction is within 30 deg of angle a
  function Z.b2ConeIdx(cs, a)
    local best, bd = nil, 31
    for i = 1, #cs do
      local d = math.abs((a - cs[i] + 180) % 360 - 180)
      if d < bd then best, bd = i, d end
    end
    return best
  end
  -- per-pull state (t0 = first Thunder IV / cone channel seen)
  function Z.b2New()
    local now = Now()
    local b = Z.b2
    if not (b and b.t0) or now - b.t0 > 20000 then
      b = {t0 = now, cones = {}, cid = {}, nc = 0, n4 = 0, hc = {}, h4 = {}}
      Z.b2 = b
    end
    return b
  end
  -- has hit k resolved? counted cast events (never earlier than 0.6 s before the expected time), else time fallback
  function Z.b2Res(b, k, el)
    local H = Z.B2_HIT[k]
    if not H then return true end
    local n = b.nc or 0
    local n4 = b.n4 or 0
    if (k == 1 and n4 >= 1) or (k == 4 and n4 >= 2) then n = math.max(n, k) end
    return (n >= k and el > H - 0.6) or el > H + 0.4
  end
  -- route from the floor + first safe ring. force = "E"/"W" builds the route for that side without the floor.
  -- returns {side, r1, r2, p1k, late, early, iE, iL, known} or nil
  function Z.b2Route(b, force)
    if not (b and b.first) then return nil end
    local r1 = b.first
    local r2 = (r1 == "OUT") and "IN" or "OUT"
    local o1 = (r1 == "OUT") and 8 or 0
    local o2 = 8 - o1
    local side, p1k
    if force then
      side = force
      p1k = (force == "E") and 2 or 5
    else
      local T = Z.tiles
      local other
      if not (Z.tilesKnown and T) then return nil end
      -- Hector: OUT first -> side with 2 INNER safe (1 outer safe); IN first -> side with 2 OUTER safe (1 inner safe)
      for s, ks in pairs(Z.B2_SIDE) do
        local n1, n2, k1 = 0, 0, nil
        for i = 1, 2 do
          local k = ks[i]
          if not T[o1 + k] then n1 = n1 + 1; k1 = k end
          if not T[o2 + k] then n2 = n2 + 1 end
        end
        if n1 == 1 and n2 == 2 then
          if side then return nil end
          side, p1k = s, k1
        elseif n1 == 2 and n2 == 1 then
          -- the other side: 2 safe in the 1st ring, 1 safe in the 2nd ring (Hector: 3 safe tiles per side)
          other = (other or 0) + 1
        end
      end
      -- both sides must match the pattern, else the floor reading is stale/incomplete -> fallback
      if not side or other ~= 1 then return nil end
    end
    local ks = Z.B2_SIDE[side]
    if not (ks and p1k) then return nil end
    local cs = (b.cones and #b.cones == 6) and b.cones or Z.B2_CONES
    local iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])
    if not (iA and iB) or iA == iB then
      cs = Z.B2_CONES
      iA, iB = Z.b2ConeIdx(cs, 22.5 + 45 * ks[1]), Z.b2ConeIdx(cs, 22.5 + 45 * ks[2])
    end
    if not (iA and iB) or Z.b2ConeIdx(cs, 22.5 + 45 * p1k) == 1 then return nil end
    local R = {side = side, r1 = r1, r2 = r2, p1k = p1k, known = not force}
    if iA < iB then
      R.early, R.late, R.iE, R.iL = ks[1], ks[2], iA, iB
    else
      R.early, R.late, R.iE, R.iL = ks[2], ks[1], iB, iA
    end
    return R
  end
  function Z.b2Text(R)
    local N = Z.B2_NAME
    return string.format("%s first > %s: %s %s, then %s %s, then %s %s", R.r1, (R.side == "E") and "EAST" or "WEST",
      R.r1, N[R.p1k] or "?", R.r2, N[R.late] or "?", R.r2, N[R.early] or "?")
  end
end
-- [Draw] Bloom 2 - Thunder route arrows | timeline_index 35 | OnFrame | window -6.9..5.8
-- whole party: 1st spot (ring safe from the 1st Thunder IV) -> after hit 1 change ring (late-cone half)
-- -> after the early cone of your side, slide to the other half. Green = IN spot, orange = OUT spot.
local b = Z.b2
if not (b and b.first and b.t0 and Z.b2Route and Z.b2Spot and Z.b2Res) then return end
local p = TensorCore.mGetPlayer()
if not (p and p.pos) then return end
local now = Now()
local el = (now - b.t0) / 1000
if el < 0 or el > 13 then return end
local px, py, pz = p.pos.x, p.pos.y, p.pos.z
local dx, dz = px - 100, pz - 100
local h1 = Z.b2Res(b, 1, el)
local R = b.lock
if not R then
  if not b.rT or now - b.rT > 250 then
    b.route = Z.b2Route(b)
    b.rT, b.fr = now, nil
  end
  R = b.route
  if R and not h1 and b.said ~= R.side and Z.b2Text then
    b.said = R.side
    hush(5000, Z.b2Text(R), 0xFF00FFFF)
  end
  if not R and math.abs(dx) >= 2.5 then
    -- floor not read: build the route for the side you are standing on
    local s = (dx > 0) and "E" or "W"
    b.fr = b.fr or {}
    R = b.fr[s] or Z.b2Route(b, s)
    b.fr[s] = R
  end
  if h1 and R then b.lock = R end
end
if not R then
  -- floor not read and you are in the middle: show both possible first spots
  if h1 then return end
  local g = TensorCore.getStaticDrawer(0xFF00FFFF, 2)
  local a, r = Z.b2Spot(2, b.first)
  local x, z = Z.pt(100, 100, a, r)
  g:addCircle(x, py, z, 1.0, false, Z.flags)
  a, r = Z.b2Spot(5, b.first)
  x, z = Z.pt(100, 100, a, r)
  g:addCircle(x, py, z, 1.0, false, Z.flags)
  return
end
local tk, tr, nk, nr, wp
if not h1 then
  tk, tr, nk, nr = R.p1k, R.r1, R.late, R.r2
elseif not Z.b2Res(b, R.iE, el) then
  -- no preview of the next half here: in the logs people stepped into it before its cone went off
  tk, tr = R.late, R.r2
  wp = (R.p1k ~= R.late)
elseif not Z.b2Res(b, R.iL, el) then
  tk, tr = R.early, R.r2
else
  return
end
local a, r = Z.b2Spot(tk, tr)
local tx, tz = Z.pt(100, 100, a, r)
local gx, gz = tx, tz
local pr = math.sqrt(dx * dx + dz * dz)
local pa = math.deg(math.atan2(dx, -dz)) % 360
if wp then
  -- still in the first ring: go straight in/out inside your half first (the other half of that ring is red)
  local inR2 = (R.r2 == "IN" and pr <= 7.0) or (R.r2 == "OUT" and pr >= 9.0)
  if not inR2 then
    local lo, hi = 45 * R.p1k + 8, 45 * R.p1k + 37
    local wa = pa
    if wa < lo then wa = lo elseif wa > hi then wa = hi end
    local _, wr = Z.b2Spot(R.p1k, R.r2)
    gx, gz = Z.pt(100, 100, wa, wr)
  end
elseif not h1 and pr > 3.5 then
  -- going to the first spot: do not cut through the middle
  local ex, ez = tx - px, tz - pz
  local L2 = ex * ex + ez * ez
  if L2 > 1 then
    local t = -(dx * ex + dz * ez) / L2
    if t > 0 and t < 1 then
      local cx, cz = dx + t * ex, dz + t * ez
      if cx * cx + cz * cz < 9 then
        local d = (a - pa + 180) % 360 - 180
        gx, gz = Z.pt(100, 100, pa + d / 2, 6)
      end
    end
  end
end
Z.goTo(gx, gz, (tr == "IN") and 0x33FF33 or 0x0099FF, 0.9)
if gx ~= tx or gz ~= tz then
  TensorCore.getStaticDrawer(0xCCFFFFFF, 2):addCircle(tx, py, tz, 0.9, false, Z.flags)
elseif nk then
  local na, nr2 = Z.b2Spot(nk, nr)
  local qx, qz = Z.pt(100, 100, na, nr2)
  TensorCore.getStaticDrawer(0x88FFFFFF, 2):addCircle(qx, py, qz, 0.6, false, Z.flags)
end
if not R.known then
  -- floor not read: route for the side you are on - check the red tiles yourself
  local yd = TensorCore.getStaticDrawer(0xFF00FFFF, 2)
  yd:addCircle(tx, py, tz, 1.6, false, Z.flags)
  if not h1 then
    local oa, orr = Z.b2Spot((R.side == "E") and 5 or 2, R.r1)
    local ox, oz = Z.pt(100, 100, oa, orr)
    yd:addCircle(ox, py, oz, 1.0, false, Z.flags)
  end
end
