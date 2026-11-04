-- [Draw] Bloom 6 - your rose / tower spot
-- eventType: 12
-- displayPath: Role Draws
-- mechanicTime: 522.1
-- timelineIndex: 108
-- timerStartOffset: -13
-- timerEndOffset: 0.5
-- loop: True

-- [action] [Draw] Bloom 6 - your rose / tower spot
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
-- Bloom 6: roses IN/OUT on the ring of the towers the 2nd Holy Hazard hits; tower soakers wait out cleave 1,
-- then stand at the max-clearance point of their (rose-extended) tower outside cleave 2; roses dodge both cleaves
local b = Z.b6
local s = Z.slot()
if not (b and b.roseSup ~= nil and s) then return end
local F = Z.b6fn
if not F then
  F = {HALF = 60}
  local sin, cos, rad, sqrt, min, floor = math.sin, math.cos, math.rad, math.sqrt, math.min, math.floor
  F.HS, F.HC = sin(rad(F.HALF)), cos(rad(F.HALF))
  F.RIN = {2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5}
  F.ROUT = {8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5}
  F.ALL = {}
  for t = 0, 15 do F.ALL[t] = true end
  function F.tileOf(x, z)
    local k = floor((math.deg(math.atan2(x - 100, 100 - z)) % 360) / 45) % 8
    if (x - 100) ^ 2 + (z - 100) ^ 2 > 64 then return k + 8 end
    return k
  end
  function F.tc(t, rIn)
    return Z.pt(100, 100, 22.5 + 45 * (t % 8), (t < 8) and (rIn or 4) or 12)
  end
  function F.cone(deg)
    return {x = 100, z = 100, dx = sin(rad(deg)), dz = -cos(rad(deg))}
  end
  -- clearance of a point from one cone (negative = inside)
  function F.cclr(c, x, z)
    local vx, vz = x - c.x, z - c.z
    local d = sqrt(vx * vx + vz * vz)
    if d < 0.3 then return -1 end
    if d >= 24 then return d - 24 end
    local cp = (vx * c.dx + vz * c.dz) / d
    if cp >= F.HC then return -1 end
    if cp <= -F.HS then return d end
    return d * (F.HC * sqrt(1 - cp * cp) - F.HS * cp)
  end
  function F.wclr(W, x, z)
    local m = 99
    if W then
      for i = 1, #W do
        local c = F.cclr(W[i], x, z)
        if c < m then m = c end
      end
    end
    return m
  end
  -- connected red tiles from t0 (BossMod Tiles.Edges: ring +-1 and radial t+-8); t0 always included
  function F.region(t0, red)
    local seen, q, h = {[t0] = true}, {t0}, 1
    while q[h] do
      local v = q[h]
      h = h + 1
      local base, k = (v < 8) and 0 or 8, v % 8
      local n1, n2, n3 = base + (k + 7) % 8, base + (k + 1) % 8, (v < 8) and (v + 8) or (v - 8)
      if red[n1] and not seen[n1] then seen[n1] = true q[#q + 1] = n1 end
      if red[n2] and not seen[n2] then seen[n2] = true q[#q + 1] = n2 end
      if red[n3] and not seen[n3] then seen[n3] = true q[#q + 1] = n3 end
    end
    return seen
  end
  -- best grid point in tiles: >= mc outside wave W, >= 0.25 from borders of t that touch tiles NOT in ok
  -- (ok = nil: no border rule); score = min(clearance, cap) - wd * dist(ref) - pen (if on a red tile)
  function F.best(tiles, ok, W, mc, rx, rz, wd, cap, red, pen, step)
    local bs, bx, bz, bc
    local na = floor(45 / step + 0.5) - 1
    for t = 0, 15 do
      if tiles[t] then
        local k8 = t % 8
        local a0, base, inn = 45 * k8, (t < 8) and 0 or 8, t < 8
        local okP, okN, okR = true, true, true
        if ok then
          okP = ok[base + (k8 + 7) % 8]
          okN = ok[base + (k8 + 1) % 8]
          okR = ok[inn and (t + 8) or (t - 8)]
        end
        local rr = inn and F.RIN or F.ROUT
        for j = 1, na do
          local da = step * j
          local sa, ca = sin(rad(a0 + da)), cos(rad(a0 + da))
          local sP, sN = sin(rad(da)), sin(rad(45 - da))
          for k = 1, #rr do
            local r = rr[k]
            local bd = 99
            if not okP then bd = r * sP end
            if not okN then bd = min(bd, r * sN) end
            if not okR then bd = min(bd, inn and (8 - r) or (r - 8)) end
            if bd >= 0.25 then
              local x, z = 100 + r * sa, 100 - r * ca
              local cc = F.wclr(W, x, z)
              if cc >= mc then
                local cl = min(cc, bd, r - 2.3, 15.3 - r)
                if cl > 0 then
                  local sc = min(cl, cap)
                  if rx then sc = sc - wd * sqrt((x - rx) ^ 2 + (z - rz) ^ 2) end
                  if red and red[t] then sc = sc - pen end
                  if not bs or sc > bs + 1e-6 then bs, bx, bz, bc = sc, x, z, cl end
                end
              end
            end
          end
        end
      end
    end
    return bx, bz, bc
  end
  -- waves from the helper casts (wave 1 = earliest hit, wave 2 = >=1.2s later; missing wave 2 = mirror of wave 1
  -- across the E-W line), else from the boss visual with the assumed geometry (cone edges on the E-W line)
  function F.waves(b)
    local hc = b.hc
    if b.hcA and #b.hcA >= 2 and #b.hcA >= (hc and #hc or 0) then hc = b.hcA end
    if hc and #hc > 0 then
      local h0, h2
      for i = 1, #hc do
        if not h0 or hc[i].hit < h0 then h0 = hc[i].hit end
      end
      local W1, W2 = {}, {}
      for i = 1, #hc do
        local c = hc[i]
        if c.hit - h0 < 1200 then
          W1[#W1 + 1] = c
        else
          W2[#W2 + 1] = c
          if not h2 or c.hit < h2 then h2 = c.hit end
        end
      end
      if #W1 == 1 and (W1[1].x - 100) ^ 2 + (W1[1].z - 100) ^ 2 < 4 then
        W1[2] = {x = W1[1].x, z = W1[1].z, dx = -W1[1].dx, dz = -W1[1].dz}
      end
      if #W2 == 0 then
        for i = 1, #W1 do
          local c = W1[i]
          W2[i] = {x = c.x, z = 200 - c.z, dx = c.dx, dz = -c.dz}
        end
      elseif #W2 == 1 and (W2[1].x - 100) ^ 2 + (W2[1].z - 100) ^ 2 < 4 then
        W2[2] = {x = W2[1].x, z = W2[1].z, dx = -W2[1].dx, dz = -W2[1].dz}
      end
      return W1, W2, h0, h2 or (h0 + 3000)
    end
    if b.vis then
      local Y = {F.cone(30), F.cone(210)}
      local X = {F.cone(150), F.cone(330)}
      local t1 = (b.visT or Now()) + 7600
      if b.vis == 43233 then return Y, X, t1, t1 + 3000 end
      return X, Y, t1, t1 + 3000
    end
  end
  function F.ring(towers, W, wantHit)
    local i, o = 0, 0
    for k = 1, #towers do
      local t = towers[k]
      local x, z = F.tc(t)
      if (F.wclr(W, x, z) < 0) == wantHit then
        if t < 8 then i = i + 1 else o = o + 1 end
      end
    end
    if i > 0 and o == 0 then return "in" end
    if o > 0 and i == 0 then return "out" end
  end
  -- roses go on the ring of the towers hit by the 2nd cleave (= not hit by the 1st);
  -- last resort = cactbot: IN when (43233 = ENE first) == (outer ENE tile is a tower)
  function F.mode(towers, W1, W2, vis)
    if #towers == 0 then return nil end
    local m = W2 and F.ring(towers, W2, true)
    if not m and W1 then m = F.ring(towers, W1, false) end
    if not m and vis then
      local e9, e1 = false, false
      for k = 1, #towers do
        if towers[k] == 9 then e9 = true elseif towers[k] == 1 then e1 = true end
      end
      if e9 or e1 then m = ((vis == 43233) == e9) and "in" or "out" end
    end
    return m
  end
  function F.sig(b, s, now)
    local m = 0
    if Z.tilesKnown and Z.tiles then
      for t = 0, 15 do
        if Z.tiles[t] then m = m + 2 ^ t end
      end
    end
    local d = (b.markT and now >= b.markT + 6700) and 1 or 0
    local n = 0
    if b.roseIds then
      for _ in pairs(b.roseIds) do n = n + 1 end
    end
    return s .. "|" .. tostring(b.roseSup) .. "|" .. n .. "|" .. (b.tw and #b.tw or 0) .. "|" .. (b.hc and #b.hc or 0) .. "|" .. (b.hcA and #b.hcA or 0) .. "|" .. tostring(b.vis) .. "|" .. m .. "|" .. d
  end
  function F.plan(b, s, now)
    local P = {sig = F.sig(b, s, now), chk = now}
    local towers, isT = {}, {}
    local tw = b.tw
    if tw then
      for i = 1, #tw do
        local t = tw[i].t or F.tileOf(tw[i].x, tw[i].z)
        if not isT[t] then
          isT[t] = true
          towers[#towers + 1] = t
        end
      end
    end
    local W1, W2, t1, t2 = F.waves(b)
    P.W1, P.W2, P.w1T, P.w2T = W1, W2, t1, t2
    P.mode = F.mode(towers, W1, W2, b.vis)
    -- red tiles = towers + fresh active tiles (tile tracker) + predicted roses until the real rose tiles show up.
    -- dropFresh = non-tower tiles that turned red at/after the drop (Bloom 6 start pattern tiles do not count)
    local red, dropFresh = {}, 0
    for t in pairs(isT) do red[t] = true end
    if Z.tilesKnown and Z.tiles then
      local cut = (b.twT or b.markT or now) - 25000
      local dcut = (b.markT or now) + 5500
      for t = 0, 15 do
        if Z.tiles[t] and not red[t] then
          local tt = Z.tileT and Z.tileT[t]
          if not tt or tt >= cut then
            red[t] = true
            if not tt or tt >= dcut then dropFresh = dropFresh + 1 end
          end
        end
      end
    end
    local dropped = b.markT and now >= b.markT + 6700
    if P.mode and not (dropped and dropFresh > 0) then
      local o = (P.mode == "out") and 8 or 0
      red[o] = true
      red[o + 3] = true
      red[o + 4] = true
      red[o + 7] = true
    end
    P.red = red
    -- am I a rose? my own marker is authoritative; else all supports / all DPS from the first marker
    local pl = TensorCore.mGetPlayer()
    local pid, n = pl and pl.id, 0
    if b.roseIds then
      for _ in pairs(b.roseIds) do n = n + 1 end
    end
    if pid and b.roseIds and b.roseIds[pid] then
      P.amRose = true
    elseif pid and n >= 4 then
      P.amRose = false
    else
      P.amRose = (b.roseSup == Z.isSup(s))
    end
    if P.amRose then
      local q = Z.B6_ROSE and Z.B6_ROSE[s]
      if not (q and P.mode) then return P end
      P.dx, P.dz = Z.pt(100, 100, q, (P.mode == "in") and 5.5 or 12.0)
      if W1 and W2 then
        local east = q < 180
        local side, pside, plain = {}, {}, {}
        for t = 0, 15 do
          if not red[t] then plain[t] = true end
          if ((t % 8) < 4) == east then
            side[t] = true
            if not red[t] then pside[t] = true end
          end
        end
        local x2, z2 = F.best(pside, plain, W2, 1.2, P.dx, P.dz, 0.3, 2.0, nil, 0, 3)
        if not x2 then x2, z2 = F.best(plain, plain, W2, 0.8, P.dx, P.dz, 0.3, 2.0, nil, 0, 3) end
        P.r2x, P.r2z = x2, z2
        if x2 then
          local x1, z1 = F.best(side, nil, W1, 1.3, x2, z2, 0.5, 2.0, red, 1.5, 3)
          if not x1 then x1, z1 = F.best(F.ALL, nil, W1, 1.0, x2, z2, 0.5, 2.0, red, 1.5, 3) end
          P.r1x, P.r1z = x1, z1
        end
      end
      return P
    end
    -- tower soaker: group 1 (T1 H1 M1 R1) west, group 2 east; tanks + melee inner, healers + ranged outer
    local west = (s == "T1" or s == "H1" or s == "M1" or s == "R1")
    local inner = (s == "T1" or s == "T2" or s == "M1" or s == "M2")
    local my, alt
    for k = 1, #towers do
      local t = towers[k]
      if ((t % 8) >= 4) == west then
        if (t < 8) == inner then my = my or t else alt = alt or t end
      end
    end
    my = my or alt
    if not my then return P end
    P.tower = my
    local reg = F.region(my, red)
    P.reg = reg
    for k = 1, #towers do
      if towers[k] ~= my and reg[towers[k]] then P.linked = true end
    end
    local cx, cz = F.tc(my)
    P.fx, P.fz = F.tc(my, 5.5)
    if W2 then
      P.hit = F.wclr(W2, cx, cz) < 0
      local fx, fz, fc = F.best(reg, reg, W2, 0.15, cx, cz, 0.02, 99, nil, 0, 1.5)
      if fx then P.fx, P.fz, P.fclr = fx, fz, fc else P.nosafe = true end
    end
    if W1 then
      -- wait inside your own region when that is not a detour (>4y longer run than the best spot anywhere)
      local wx, wz = F.best(reg, nil, W1, 1.3, P.fx, P.fz, 1.0, 2.0, nil, 0, 1.5)
      local gx, gz = F.best(F.ALL, nil, W1, 1.3, P.fx, P.fz, 1.0, 2.0, nil, 0, 3)
      if gx and (not wx or sqrt((wx - P.fx) ^ 2 + (wz - P.fz) ^ 2) > sqrt((gx - P.fx) ^ 2 + (gz - P.fz) ^ 2) + 4) then wx, wz = gx, gz end
      P.wx, P.wz = wx, wz
    end
    P.fang = math.deg(math.atan2(P.fx - 100, 100 - P.fz)) % 360
    return P
  end
  Z.b6fn = F
end
local now = Now()
local P = b.plan
if not P or now - (P.chk or 0) >= 250 then
  if P then P.chk = now end
  local sg = F.sig(b, s, now)
  if not P or sg ~= P.sig then
    local ok, np = pcall(F.plan, b, s, now)
    if ok and np then
      P = np
      b.plan = P
    end
  end
end
if not P then return end
if not b.roseSaid and b.markT and now > b.markT + 800 then
  b.roseSaid = true
  hush(6000, P.amRose and "ROSE: your quadrant tile - follow the arrow" or "TOWER: follow the arrow", P.amRose and 0xFFFF66FF or 0xFF33FF33)
end
local pl = TensorCore.mGetPlayer()
local py = (pl and pl.pos) and pl.pos.y or 0
local w1T, w2T = P.w1T, P.w2T
if P.amRose then
  if now < (b.markT or now) + 6800 then
    if P.dx then
      Z.goTo(P.dx, P.dz, 0xFF66FF, 1.2)
    else
      local q = Z.B6_ROSE and Z.B6_ROSE[s]
      if not q then return end
      local g = TensorCore.getCachedDrawer(0x33FF66FF, 0x55FF66FF, 0x88FF66FF, 0xFFFF66FF, 2)
      local xi, zi = Z.pt(100, 100, q, 5.5)
      local xo, zo = Z.pt(100, 100, q, 12.0)
      g:addCircle(xi, py, zi, 1.2, false, Z.flags)
      g:addCircle(xo, py, zo, 1.2, false, Z.flags)
      local xm, zm = Z.pt(100, 100, q, 8.75)
      Z.goTo(xm, zm, 0xFF66FF, 0.5)
    end
  elseif w1T and now < w1T then
    if P.r1x then Z.goTo(P.r1x, P.r1z, 0xFF66FF, 1.0) end
    if P.r2x then TensorCore.getCachedDrawer(0x22FFFF00, 0x44FFFF00, 0x66FFFF00, 0xCCFFFF00, 2):addCircle(P.r2x, py, P.r2z, 0.7, false, Z.flags) end
  elseif w2T and now < w2T + 500 and P.r2x then
    Z.goTo(P.r2x, P.r2z, 0xFF66FF, 1.0)
  end
  return
end
if not P.tower then return end
if not (w1T and P.wx) then
  local x, z = F.tc(P.tower, 5.5)
  Z.goTo(x, z, 0x33FF33, 2.0)
elseif now < w1T then
  Z.goTo(P.wx, P.wz, 0x33FF33, 1.0)
  TensorCore.getCachedDrawer(0x2200FFFF, 0x4400FFFF, 0x6600FFFF, 0xCC00FFFF, 2):addCircle(P.fx, py, P.fz, P.hit and 0.6 or 1.0, false, Z.flags)
elseif not w2T or now < w2T + 500 then
  Z.goTo(P.fx, P.fz, P.hit and 0x00FFFF or 0x33FF33, P.hit and 0.6 or 1.2)
end
if P.linked and not b.linkWarn then
  b.linkWarn = true
  Z.say(5000, "TOWERS LINKED (rose on a wrong tile) - mitigate", 0xFF3333FF)
elseif P.nosafe and not b.noSafeWarn and now >= (b.markT or now) + 7000 then
  b.noSafeWarn = true
  Z.say(5000, "No cleave-safe spot in your tower - soak it with mitigation", 0xFF3333FF)
end
