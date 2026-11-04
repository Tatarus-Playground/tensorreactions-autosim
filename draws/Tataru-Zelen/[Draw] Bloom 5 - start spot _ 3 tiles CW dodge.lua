-- [Draw] Bloom 5 - start spot / 3 tiles CW dodge
-- eventType: 12
-- displayPath: Role Draws
-- mechanicTime: 469.2
-- timelineIndex: 89
-- timerStartOffset: -11.5
-- timerEndOffset: 5.6
-- loop: True

-- [action] [Draw] Bloom 5 - start spot / 3 tiles CW dodge
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
-- Bloom 5: arrow to the start spot (clear quadrant away from the first chakram pair, IN/OUT per
-- Thunder IV), then after the first explosions: 3 tiles clockwise, other ring. Same spot for all 8.
if Z.b5fnV ~= 11 then
  Z.b5fnV = 11
  local function adiff(a, b)
    local d = (a - b) % 360
    if d > 180 then d = 360 - d end
    return d
  end
  local RIN, ROUT = {5.5, 4.5, 6.5}, {12.0, 13.5, 10.5}
  local OFFS = {10, 16, 22.5, 29, 35}
  -- best point of sector k (0..7) in the inner/outer ring; hard = cone angles that must miss,
  -- soft = cone angles to avoid if possible (score capped at cap), rects = chakram lines that must miss
  local function spot(k, inner, hard, soft, cap, rects, cw)
    local radii = inner and RIN or ROUT
    local best, bx, bz
    for ri = 1, 3 do
      local r = radii[ri]
      for oi = 1, 5 do
        local a = 45 * k + OFFS[oi]
        local x, z = Z.pt(100, 100, a, r)
        local edge = 0.5 + r * math.sin(math.rad(math.min(OFFS[oi], 45 - OFFS[oi])))
        local ring = (inner and math.min(8 - r, r - 2) or math.min(r - 8, 16 - r)) - 0.5
        local m, ok = math.min(3.0, edge, ring), true
        for i = 1, #hard do
          local d = adiff(a, hard[i]) - 30
          local dd = (d >= 90) and r or r * math.sin(math.rad(d))
          if dd < 1.0 then ok = false break end
          if dd < m then m = dd end
        end
        if ok then
          for i = 1, #rects do
            local R = rects[i]
            local hx, hz = math.sin(R.h), math.cos(R.h)
            local rx, rz = x - R.x, z - R.z
            local u = rx * hx + rz * hz
            if u > -1 and u < 41 then
              local lat = math.abs(rx * hz - rz * hx) - 4
              if lat < 1.0 then ok = false break end
              if lat < m then m = lat end
            end
          end
        end
        if ok then
          for i = 1, #soft do
            local d = adiff(a, soft[i]) - 30
            if d < 90 and r * math.sin(math.rad(d)) < 1.0 and m > cap then m = cap end
          end
          local sc = m + 0.02 * (cw and oi or (6 - oi)) - 0.01 * (ri - 1)
          if not best or sc > best then best, bx, bz = sc, x, z end
        end
      end
    end
    return best, bx, bz
  end
  Z.b5fn = function(B)
    local io1 = B.io1
    local io2 = B.io2 or (io1 == "IN" and "OUT") or (io1 == "OUT" and "IN") or nil
    -- chakram geometry: live until that chakram's own cast has started, then frozen
    for i = 1, #B.ids do
      local id = B.ids[i]
      if not B.resT[id] then
        local ent = TensorCore.mGetEntity(id)
        if ent and ent.pos and ent.pos.h then B.rect[id] = {x = ent.pos.x, z = ent.pos.z, h = ent.pos.h} end
      end
    end
    -- first pair = earliest to resolve (43210 cast) or, before the casts, earliest to appear (0x11DB)
    local T = next(B.resT) and B.resT or B.appT
    local tmin
    for _, t in pairs(T) do
      if not tmin or t < tmin then tmin = t end
    end
    local r1, r2 = {}, {}
    for i = 1, #B.ids do
      local id = B.ids[i]
      local first
      if tmin then first = (T[id] ~= nil and T[id] - tmin < 1500) else first = (i <= 2) end
      local R = B.rect[id]
      if R then
        if first then r1[#r1 + 1] = R else r2[#r2 + 1] = R end
      end
    end
    -- half of the arena swept by the first pair (0 N, 90 E, 180 S, 270 W)
    local vx, vz = 0, 0
    for i = 1, #r1 do
      local R = r1[i]
      local hx, hz = math.sin(R.h), math.cos(R.h)
      local ox, oz = R.x - 100, R.z - 100
      local al = ox * hx + oz * hz
      vx = vx + ox - hx * al
      vz = vz + oz - hz * al
    end
    if #r1 > 0 and vx * vx + vz * vz > 4 * #r1 * #r1 then
      B.hc = (math.floor(((math.deg(math.atan2(vx, -vz)) % 360) + 45) / 90) % 4) * 90
    end
    local hc = B.hc
    -- floor: only tile changes seen during this bloom count ("A" = NE/SW clear, "B" = SE/NW clear)
    local fl
    if Z.tilesKnown and Z.tiles and Z.tileT then
      local cut, cA, cB = B.t0 - 20000, 0, 0
      for t = 0, 15 do
        local tt = Z.tileT[t]
        if tt and tt >= cut and Z.tiles[t] then
          local q = math.floor((t % 8) / 2)
          if q == 0 or q == 2 then cA = cA + 1 else cB = cB + 1 end
        end
      end
      if cB > cA then fl = "A" elseif cA > cB then fl = "B" end
    end
    B.floor = fl
    -- candidates: clear quadrant q not swept first; start = its clockwise tile 2q+1, dodge = 3 tiles CW
    local cands = {}
    for q = 0, 3 do
      local okF = (not fl) or ((fl == "A") == (q == 0 or q == 2))
      local okH = (not hc) or adiff(45 + 90 * q, hc) > 90
      if okF and okH then cands[#cands + 1] = {q = q, s = 2 * q + 1, e = (2 * q + 4) % 8} end
    end
    -- cones 1-2 (the opposite pair hitting at / right after the boom) must miss the start;
    -- cones 4-6 must miss the dodge spot; cone 3 hits about when you arrive there (soft)
    local h12, h46, sE, none = {}, {}, {}, {}
    for i = 1, #B.cones do
      local a = B.cones[i].a
      if i <= 2 then h12[#h12 + 1] = a elseif i == 3 then sE[1] = a else h46[#h46 + 1] = a end
    end
    local P = {state = "none", V = {}}
    if io1 then
      local in1, in2 = (io1 == "IN"), (io2 == "IN")
      local b1, b2
      for i = 1, #cands do
        local c = cands[i]
        local s1, sx, sz = spot(c.s, in1, h12, none, 3.0, r1, true)
        local s2, ex, ez = spot(c.e, in2, h46, sE, 1.2, r2, false)
        if s1 and s2 then
          c.sc, c.sx, c.sz, c.ex, c.ez = s1 + s2, sx, sz, ex, ez
          P.V[#P.V + 1] = c
          if not b1 or c.sc > b1.sc then
            b2 = b1
            b1 = c
          elseif not b2 or c.sc > b2.sc then
            b2 = c
          end
        end
      end
      local pick
      if b1 and (not b2 or b1.sc - b2.sc >= 1.0) then pick = b1 end
      -- keep the previous answer while it is still valid and not clearly beaten (no flicker)
      if B.pick and b1 then
        local pc
        for i = 1, #P.V do
          if P.V[i].s == B.pick then pc = P.V[i] end
        end
        if pc and pc ~= pick and b1.sc - pc.sc < 1.0 then pick = pc end
      end
      if pick then
        P.state, P.c = "ok", pick
        P.conf = (#B.cones >= 5 and #P.V == 1) and "high" or "med"
        B.pick = pick.s
      end
    end
    if P.state ~= "ok" and hc then
      P.state = "side"
      P.px, P.pz = Z.pt(100, 100, (hc + 180) % 360, (io1 == "IN" and 5.5) or (io1 == "OUT" and 12.0) or 8.0)
    end
    B.plan = P
    if P.state == "ok" then
      local c = P.c
      local key = c.s * 10 + (io1 == "IN" and 1 or 2)
      B.saidIO = true
      if B.said ~= key and (B.nSaid or 0) < 3 then
        B.said = key
        B.nSaid = (B.nSaid or 0) + 1
        hush(7000, "B5: start " .. io1 .. " " .. Z.dirName(45 * c.s + 22.5) .. "  >> boom >>  3 tiles CW: "
          .. tostring(io2) .. " " .. Z.dirName(45 * c.e + 22.5), 0xFF00FFFF)
      end
    elseif io1 and not B.saidIO and Now() - (B.tIO or 0) > 1500 then
      B.saidIO = true
      hush(6000, "B5: " .. io1 .. " first. After the boom: 3 tiles CLOCKWISE, go " .. tostring(io2), 0xFF00FFFF)
    elseif P.state == "side" and not B.saidSide then
      B.saidSide = true
      hush(4000, "B5: first swipes hit the " .. Z.dirName(hc) .. " half - go " .. Z.dirName(hc + 180) .. " side", 0xFF00FFFF)
    end
  end
end
local B = Z.b5
if not (B and B.t0 and Z.b5fn) then return end
local now = Now()
if now - B.t0 > 40000 then return end
local p = TensorCore.mGetPlayer()
if not (p and p.pos) then return end
-- swap to the dodge once Thunder IV #1 has landed (its cast event + 0.15 s); fallback cast start + 7.0 s
-- (Bloom 2 logs: the hit lands 6.66-6.91 s after the cast start); latched so it never flips back
if not B.swapped then
  local c1 = B.cones and B.cones[1]
  local swap = (B.ivHit and B.ivHit + 150) or (B.tIV1 and B.tIV1 + 600) or (c1 and c1.t + 600)
  if swap and now >= swap then
    B.swapped = true
  else
    if B.dirty or not B.pT or now - B.pT > 400 then
      B.dirty = false
      B.pT = now
      pcall(Z.b5fn, B)
    end
    local P = B.plan
    if not P then return end
    if P.state == "ok" then
      local c = P.c
      Z.goTo(c.sx, c.sz, (P.conf == "high") and 0x33FF33 or 0x00FFFF, 1.2)
      TensorCore.getStaticDrawer(0x88FFFF00, 2):addCircle(c.ex, p.pos.y, c.ez, 1.0, false, Z.flags)
    else
      -- unresolved: wait on the opposite cardinal (edge of both candidate quadrants), but no arrow in the last 3 s (pick the clear tile yourself)
      if P.state == "side" and not (swap and now > swap - 3000) then Z.goTo(P.px, P.pz, 0x00FFFF, 2.0) end
      local V = P.V
      if V and #V > 0 and #V <= 3 then
        local d = TensorCore.getStaticDrawer(0x8800FFFF, 2)
        for i = 1, #V do d:addCircle(V[i].sx, p.pos.y, V[i].sz, 0.8, false, Z.flags) end
      end
    end
    return
  end
end
-- after the first explosions: dodge spot (decided once; false = nothing sensible to show)
if B.dodge == nil then
  local P = B.plan
  local V = P and P.V
  local D = false
  if P and P.state == "ok" then
    D = {P.c.ex, P.c.ez}
  else
    -- unresolved: Hector's rule from the tile you are standing in (3 tiles clockwise, other ring);
    -- if that tile is one of the candidates, use its computed dodge spot
    local dx, dz = p.pos.x - 100, p.pos.z - 100
    local r2 = dx * dx + dz * dz
    if r2 >= 6.25 then
      local k0 = math.floor((math.deg(math.atan2(dx, -dz)) % 360) / 45) % 8
      local in0 = r2 <= 64
      if V and B.io1 and in0 == (B.io1 == "IN") then
        for i = 1, #V do
          if V[i].s == k0 then D = {V[i].ex, V[i].ez} end
        end
      end
      if not D then
        local inner = not in0
        if B.io2 then inner = (B.io2 == "IN") end
        local x, z = Z.pt(100, 100, 45 * ((k0 + 3) % 8) + 15, inner and 5.5 or 12.0)
        D = {x, z}
      end
    end
  end
  B.dodge = D
end
if B.dodge then Z.goTo(B.dodge[1], B.dodge[2], 0xFFFF00, 1.2) end
