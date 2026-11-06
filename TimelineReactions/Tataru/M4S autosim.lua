local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "85e38457-22cc-6d7c-b9bf-7a1a29407351",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local api = TensorCore.API.TensorACR\n-- Universal AutoSim for M4S (Wicked Thunder): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 712s = FFLogs median of the full ranking populations (Viper ~708, BLM ~715; p25 ~695, p75 ~730).\n-- Boss untargetable only at the P1 -> P2 transition. Windows come from real kills and are re-timed when each\n-- anchor ability lands. No knockback or knock-up stops the party outside the transition (FFLogs), so no Stun phases.\n-- Windows after ~660s (Sunrise Sabbath, Tail Thrust 3) are estimated from the timeline; no logged kill reached them.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 712)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM4s = {\n  kill = 712, stamp = Now(), cd = true,\n  f_tr = add(\"FullDowntime\", 388.20, 400.20), -- P1 -> P2 transition (boss untargetable)\n  m_tr = add(\"MeleeDowntime\", 386.60, 400.50), -- Cannonbolt / transition\n  m_st = add(\"MeleeDowntime\", 237.50, 245.00), -- Stampeding Thunder to teleport\n  m_az = add(\"MeleeDowntime\", 506.50, 514.00), -- Azure Thunder / Twilight Sabbath\n  c_bf = add(\"CasterDowntime\", 31.50, 41.00), -- Bewitching Flight\n  c_wh = add(\"CasterDowntime\", 49.00, 62.50), -- Electrifying Witch Hunt / Witch Hunt\n  c_nw = add(\"CasterDowntime\", 74.50, 90.50), -- Narrowing/Widening Witch Hunt + Vortex\n  c_ss1 = add(\"CasterDowntime\", 131.00, 147.00), -- Sidewise Spark 1 / Stars to Wicked Jolt\n  c_ss2 = add(\"CasterDowntime\", 193.00, 206.50), -- Sidewise Spark 2 to Wicked Bolt\n  c_ic = add(\"CasterDowntime\", 216.00, 226.00), -- Ion Cluster / boss jumps north\n  c_es1 = add(\"CasterDowntime\", 245.50, 257.00), -- Teleport + Electron Stream 1\n  c_es2 = add(\"CasterDowntime\", 262.00, 271.50), -- Electron Stream 2\n  c_ff1 = add(\"CasterDowntime\", 330.00, 341.00), -- Fulminous Field set 1\n  c_ff2 = add(\"CasterDowntime\", 352.00, 366.50), -- Fulminous Field set 2\n  c_tr = add(\"CasterDowntime\", 376.00, 407.50), -- Soulshock / Impact / Cannonbolt / transition\n  c_wb = add(\"CasterDowntime\", 426.00, 445.00), -- Wicked Blaze + Sabertail / Wicked Special\n  c_tt1 = add(\"CasterDowntime\", 481.50, 491.00), -- Tail Thrust / Switch of Tides 1\n  c_wf = add(\"CasterDowntime\", 517.00, 531.00), -- Twilight Sabbath: Wicked Fire / Wicked Special\n  c_ms = add(\"CasterDowntime\", 549.50, 558.00), -- Midnight Sabbath bursts\n  c_cl = add(\"CasterDowntime\", 613.00, 632.00), -- Chain Lightning\n  c_tt2 = add(\"CasterDowntime\", 639.50, 651.00), -- Tail Thrust / Switch of Tides 2\n  c_sr = add(\"CasterDowntime\", 699.00, 725.00), -- Sunrise Sabbath towers / cannons\n  c_tt3 = add(\"CasterDowntime\", 730.80, 740.30), -- Tail Thrust / Switch of Tides 3\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 650, 20)\nself.used = true\n",
							name = "[AutoSim] M4S - setup (any job)",
							uuid = "60a3d522-cb8c-9b35-b4a1-04a3e4ec1899",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 10.6,
				name = "[AutoSim] M4S - setup (any job)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "fcd8ae0e-280d-c103-8e58-78e14f553918",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- No countdown this pull? Set the schedule up at pull start instead (skip only if the countdown setup just ran).\nif TensorM4s and TensorM4s.cd and TensorM4s.stamp and Now() - TensorM4s.stamp < 75000 then TensorM4s.cd = nil; return end\nlocal api = TensorCore.API.TensorACR\n-- Universal AutoSim for M4S (Wicked Thunder): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 712s = FFLogs median of the full ranking populations (Viper ~708, BLM ~715; p25 ~695, p75 ~730).\n-- Boss untargetable only at the P1 -> P2 transition. Windows come from real kills and are re-timed when each\n-- anchor ability lands. No knockback or knock-up stops the party outside the transition (FFLogs), so no Stun phases.\n-- Windows after ~660s (Sunrise Sabbath, Tail Thrust 3) are estimated from the timeline; no logged kill reached them.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 712)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM4s = {\n  kill = 712, stamp = Now(),\n  f_tr = add(\"FullDowntime\", 388.20, 400.20), -- P1 -> P2 transition (boss untargetable)\n  m_tr = add(\"MeleeDowntime\", 386.60, 400.50), -- Cannonbolt / transition\n  m_st = add(\"MeleeDowntime\", 237.50, 245.00), -- Stampeding Thunder to teleport\n  m_az = add(\"MeleeDowntime\", 506.50, 514.00), -- Azure Thunder / Twilight Sabbath\n  c_bf = add(\"CasterDowntime\", 31.50, 41.00), -- Bewitching Flight\n  c_wh = add(\"CasterDowntime\", 49.00, 62.50), -- Electrifying Witch Hunt / Witch Hunt\n  c_nw = add(\"CasterDowntime\", 74.50, 90.50), -- Narrowing/Widening Witch Hunt + Vortex\n  c_ss1 = add(\"CasterDowntime\", 131.00, 147.00), -- Sidewise Spark 1 / Stars to Wicked Jolt\n  c_ss2 = add(\"CasterDowntime\", 193.00, 206.50), -- Sidewise Spark 2 to Wicked Bolt\n  c_ic = add(\"CasterDowntime\", 216.00, 226.00), -- Ion Cluster / boss jumps north\n  c_es1 = add(\"CasterDowntime\", 245.50, 257.00), -- Teleport + Electron Stream 1\n  c_es2 = add(\"CasterDowntime\", 262.00, 271.50), -- Electron Stream 2\n  c_ff1 = add(\"CasterDowntime\", 330.00, 341.00), -- Fulminous Field set 1\n  c_ff2 = add(\"CasterDowntime\", 352.00, 366.50), -- Fulminous Field set 2\n  c_tr = add(\"CasterDowntime\", 376.00, 407.50), -- Soulshock / Impact / Cannonbolt / transition\n  c_wb = add(\"CasterDowntime\", 426.00, 445.00), -- Wicked Blaze + Sabertail / Wicked Special\n  c_tt1 = add(\"CasterDowntime\", 481.50, 491.00), -- Tail Thrust / Switch of Tides 1\n  c_wf = add(\"CasterDowntime\", 517.00, 531.00), -- Twilight Sabbath: Wicked Fire / Wicked Special\n  c_ms = add(\"CasterDowntime\", 549.50, 558.00), -- Midnight Sabbath bursts\n  c_cl = add(\"CasterDowntime\", 613.00, 632.00), -- Chain Lightning\n  c_tt2 = add(\"CasterDowntime\", 639.50, 651.00), -- Tail Thrust / Switch of Tides 2\n  c_sr = add(\"CasterDowntime\", 699.00, 725.00), -- Sunrise Sabbath towers / cannons\n  c_tt3 = add(\"CasterDowntime\", 730.80, 740.30), -- Tail Thrust / Switch of Tides 3\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 650, 20)\nself.used = true\n",
							name = "[AutoSim] M4S - setup without countdown",
							uuid = "21fbcaf0-a6b2-4c58-8245-8d8740c506a9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 10.6,
				name = "[AutoSim] M4S - setup without countdown",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -9,
				timerStartOffset = -14,
				uuid = "ea20239a-75a0-d4c7-a928-6946e3423e2e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Re-time each AutoSim window when its anchor boss ability lands\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorM4s\nif not s then return end\nlocal sp = e.spellID\nif not sp then return end\nlocal AL = s.AL\nif not AL then AL = {[38381] = 38380, [38355] = 38354, [38358] = 38359}; s.AL = AL end\nsp = AL[sp] or sp\nlocal BY = s.spec\nif not BY then\n  BY = {}\n  for _, w in ipairs({\n  {20033, 1, \"f_tr\", 8.70, 20.70, \"FullDowntime\"},\n  {20033, 1, \"m_tr\", 7.10, 21.00, \"MeleeDowntime\"},\n  {38354, 1, \"m_st\", 4.40, 11.90, \"MeleeDowntime\"},\n  {38447, 1, \"m_az\", 1.10, 8.60, \"MeleeDowntime\"},\n  {38383, 1, \"c_bf\", 15.50, 25.00, \"CasterDowntime\"},\n  {38383, 1, \"c_wh\", 33.00, 46.50, \"CasterDowntime\"},\n  {38366, 1, \"c_nw\", 16.20, 32.20, \"CasterDowntime\"},\n  {38341, 1, \"c_ss1\", 19.60, 35.60, \"CasterDowntime\"},\n  {38350, 1, \"c_ss2\", 18.20, 31.70, \"CasterDowntime\"},\n  {38380, 2, \"c_ic\", 24.00, 34.00, \"CasterDowntime\"},\n  {38354, 1, \"c_es1\", 12.40, 23.90, \"CasterDowntime\"},\n  {38359, 1, \"c_es2\", 9.30, 18.80, \"CasterDowntime\"},\n  {39123, 1, \"c_ff1\", 12.60, 23.60, \"CasterDowntime\"},\n  {39123, 1, \"c_ff2\", 34.60, 49.10, \"CasterDowntime\"},\n  {39123, 1, \"c_tr\", 58.60, 90.10, \"CasterDowntime\"},\n  {38386, 1, \"c_wb\", 13.70, 32.70, \"CasterDowntime\"},\n  {38391, 1, \"c_tt1\", 51.10, 60.60, \"CasterDowntime\"},\n  {38435, 1, \"c_wf\", 5.50, 19.50, \"CasterDowntime\"},\n  {39609, 1, \"c_ms\", 8.50, 17.00, \"CasterDowntime\"},\n  {38420, 1, \"c_cl\", 24.20, 43.20, \"CasterDowntime\"},\n  {38425, 1, \"c_tt2\", 24.50, 36.00, \"CasterDowntime\"},\n  {38434, 1, \"c_sr\", 9.80, 35.80, \"CasterDowntime\"},\n  {39610, 1, \"c_tt3\", 35.50, 45.00, \"CasterDowntime\"}\n  }) do BY[w[1]] = BY[w[1]] or {}; table.insert(BY[w[1]], w) end\n  s.spec = BY\nend\nlocal ws = BY[sp]\nif not ws then return end\nlocal api = TensorCore.API.TensorACR\nlocal okT, t = pcall(api.getAutoSimTime)\nif not (okT and t) then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nif not s.lastC[sp] or t - s.lastC[sp] > 5 then s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1 end\nfor _, w in ipairs(ws) do\n  local key = w[3]\n  if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n    s.done = s.done or {}; s.done[key] = true\n    if s[key] then\n      local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5])\n      if not ok then ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]) end\n      if ok then s[key] = id end\n    else\n      local ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]); if ok then s[key] = id end\n    end\n  end\nend\n",
							name = "[AutoSim] M4S - cast sync",
							uuid = "3773c184-de5a-9f49-8200-71f8b28a4663",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 2,
				loop = true,
				mechanicTime = 10.6,
				name = "[AutoSim] M4S - cast sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 820,
				timerStartOffset = -15,
				uuid = "b4811747-7641-febd-a875-f38f7cfef073",
				version = 2,
			},
		},
	}, 
	[5] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "1bf819e0-9889-4c60-a829-a2a78f6856e0",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Bewitching Flight: Gun Battery cubes (OID 0x43AC = 17324) spawn on the west edge; each fires a horizontal\n-- Electray (range 40 width 5) ~6.8s later. Store the entity so its z can be read.\nlocal e = eventArgs\nif not (e and e.entityContentID == 17324 and e.entityID) then return end\nlocal m = data.m4_bf\nif not m or not m.t or Now() - m.t > 20000 then\n  m = {t = Now(), ver = {}, bat = {}}\n  data.m4_bf = m\nend\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nif m.bat[e.entityID] == nil then m.la = Now() end\nm.bat[e.entityID] = (ps and ps.x ~= 0 and {x = ps.x, z = ps.z}) or m.bat[e.entityID] or false\n",
							name = "[Draw] M4S - Bewitching Flight capture cubes",
							uuid = "12ec302b-3a82-ee29-bb69-ab9267fdc8ae",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 5,
				loop = true,
				mechanicTime = 38.2,
				name = "[Draw] M4S - Bewitching Flight capture cubes",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 4,
				timerStartOffset = -14,
				uuid = "c6463b32-57a0-d13c-bc2d-5f0a7d104ba6",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Bewitching Flight: 38377 = vertical beam (Helper, range 40 width 5, from the north), 38379 = Electray\n-- (Gun Battery horizontal beam; fallback if the cube spawn was missed).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38377 and sp ~= 38379 then return end\nif not e.entityID then return end\nlocal m = data.m4_bf\nif not m or not m.t or Now() - m.t > 20000 then\n  m = {t = Now(), ver = {}, bat = {}}\n  data.m4_bf = m\nend\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nlocal tb = (sp == 38377) and m.ver or m.bat\nif tb[e.entityID] == nil then m.la = Now() end\nlocal v = (ps and {x = ps.x, z = ps.z}) or false\nif sp == 38377 then m.ver[e.entityID] = v or m.ver[e.entityID] or false\nelse m.bat[e.entityID] = v or m.bat[e.entityID] or false end\n",
							name = "[Draw] M4S - Bewitching Flight capture beams",
							uuid = "d8cb77b2-9d08-b50e-aed6-daee00ba72e1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 38.2,
				name = "[Draw] M4S - Bewitching Flight capture beams",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 4,
				timerStartOffset = -14,
				uuid = "134dcfed-7440-9bb5-a786-0e6142b9f2e7",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Bewitching Flight resolved (vertical 38377 / Electray 38379 landed): stop drawing.\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38377 and sp ~= 38379 then return end\nlocal m = data.m4_bf\nif m and m.t and Now() - m.t < 20000 then m.done = m.done or Now() end\n",
							name = "[Draw] M4S - Bewitching Flight resolved",
							uuid = "4c325a24-cdbe-3a46-b419-c10793546770",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 38.2,
				name = "[Draw] M4S - Bewitching Flight resolved",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 6,
				timerStartOffset = -14,
				uuid = "403c76f2-ead8-bb46-9ff2-8ffd2c175b52",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Bewitching Flight: stand in a safe intersection. 5 vertical beams (from the boss, north) and\n-- 4-5 horizontal beams (from the west cubes; screenshot shows 4), each 5 wide. Columns: the two safe columns nearest the middle\n-- (G1 left / G2 right). Rows (north to south, the 3 safe rows nearest the boss): M+T, then R, then H.\nlocal m = data.m4_bf\nif not (m and m.t) or Now() - m.t > 15000 or m.done then return end\nif Now() - (m.la or 0) < 400 then return end\nlocal function vals(tbl, key, nlo, nhi)\n  local out = {}\n  for id, c in pairs(tbl) do\n    local ent = TensorCore.mGetEntity(id)\n    local ps = ent and ent.pos\n    if ps and not (ps.x == 0 and ps.z == 0) then\n      if c then c.x, c.z = ps.x, ps.z else c = {x = ps.x, z = ps.z}; tbl[id] = c end\n    end\n    if c then\n      local v = c[key]\n      if not v or v < 77 or v > 123 then return nil end\n      local dup = false\n      for _, o in ipairs(out) do if math.abs(o - v) < 1 then dup = true; break end end\n      if not dup then out[#out + 1] = v end\n    end\n  end\n  if #out < nlo or #out > nhi then return nil end\n  table.sort(out)\n  return out\nend\nlocal function gaps(cs)\n  local res, start = {}, 80\n  for _, c in ipairs(cs) do\n    local a = c - 2.5\n    if a - start >= 2 then res[#res + 1] = (start + a) / 2 end\n    if c + 2.5 > start then start = c + 2.5 end\n  end\n  if 120 - start >= 2 then res[#res + 1] = (start + 120) / 2 end\n  return res\nend\nlocal xs = vals(m.ver, \"x\", 5, 5)\nlocal zs = vals(m.bat, \"z\", 4, 5)\nif not (xs and zs) then return end\nlocal cg, rg = gaps(xs), gaps(zs)\nif #cg < 2 or #rg < 3 then return end\ntable.sort(cg, function(a, b) return math.abs(a - 100) < math.abs(b - 100) end)\nif #cg >= 3 and math.abs(math.abs(cg[3] - 100) - math.abs(cg[2] - 100)) < 0.5 then return end\nlocal L, R = math.min(cg[1], cg[2]), math.max(cg[1], cg[2])\nif R - L < 3 then return end\ntable.sort(rg)\nlocal ROW = {T1 = 1, M1 = 1, T2 = 1, M2 = 1, R1 = 2, R2 = 2, H1 = 3, H2 = 3}\nlocal COL = {T1 = L, M1 = L, R1 = L, H1 = L, T2 = R, M2 = R, R2 = R, H2 = R}\nlocal r, c = ROW[slot], COL[slot]\nif not (r and c) then return end\ngo(c, rg[r])\n",
							name = "[Draw] M4S - Bewitching Flight safe spot",
							uuid = "1a43f659-8c2a-abee-ae3a-695589a48f89",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 38.2,
				name = "[Draw] M4S - Bewitching Flight safe spot",
				timeRange = true,
				timelineIndex = 5,
				timerEndOffset = 3,
				timerStartOffset = -10,
				uuid = "4681995c-bfb4-1228-ad87-3b9bf8826134",
				version = 2,
			},
		},
	},
	[7] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "e4757ac1-6abc-9559-b2c7-3c0c490d2a49",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Electrifying Witch Hunt capture (cast starts). 38378 = Burst line (Helper, N-S rect 40 x 16): the 1st set goes\n-- with the 1st spreads (38373 Electrifying Witch Hunt), the 2nd set with the near/far bait (38366 Witch Hunt).\n-- 38373/38366 = boss casts: store the boss id (its Marker status 2970 says near/far).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38378 and sp ~= 38373 and sp ~= 38366 then return end\nlocal now = Now()\nlocal m = data.m4_ewh\nif not m or not m.t or now - m.t > 30000 then\n  m = {t = now, sets = {}}\n  data.m4_ewh = m\nend\nm.t = now\nif sp ~= 38378 then\n  if e.entityID then m.boss = e.entityID end\n  return\nend\nlocal ent = e.entityID and TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nif not (ps and ps.x) then return end\nlocal cur = m.sets[#m.sets]\nif not cur or now - cur.t > 3000 then\n  -- a set started after the first spreads landed is the second set\n  local n = m.hit1 and 2 or 1\n  if n == 1 and #m.sets >= 1 then m.sets = {} end\n  cur = {t = now, xs = {}}\n  m.sets[n] = cur\nend\ncur.xs[#cur.xs + 1] = ps.x\n",
							name = "[Draw] M4S - Electrifying Witch Hunt capture casts",
							uuid = "f4f8ec9d-e49e-3c73-92b7-bf8db99a6a95",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 49.6,
				name = "[Draw] M4S - Electrifying Witch Hunt capture casts",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 16,
				timerStartOffset = -16,
				uuid = "c31944c6-da08-dbe9-92ad-96303aeba83d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Electrifying Witch Hunt capture (hits). 38374 = first spreads landed (targets get Forked Lightning 587),\n-- 38367 = near/far baits landed (mechanic over).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38374 and sp ~= 38367 then return end\nlocal m = data.m4_ewh\nif not m or not m.t or Now() - m.t > 30000 then return end\nm.t = Now()\nif sp == 38374 then\n  m.hit1 = m.hit1 or {t = Now()}\nelse\n  m.done2 = m.done2 or Now()\nend\n",
							name = "[Draw] M4S - Electrifying Witch Hunt capture hits",
							uuid = "719f9a52-e5f5-29c9-ae14-2cc894017c7d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 49.6,
				name = "[Draw] M4S - Electrifying Witch Hunt capture hits",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 16,
				timerStartOffset = -16,
				uuid = "c11d68b5-b72a-a494-8bc3-2fc811c6b672",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Electrifying Witch Hunt, 1st spreads: rows R, T, M, H north to south; G1 west, G2 east, in the safe lane(s).\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Burst lines (38378) are N-S rects 16 wide. Side lines (|x-100| > 10) => center lane safe (\"in\");\n-- a center line => both side lanes safe (\"out\"). Returns the west (G1) and east (G2) x to stand on.\nlocal function lanes(set)\n  if not (set and set.xs and #set.xs > 0) then return nil end\n  local side, mid = false, false\n  local L, R = 80, 120\n  local cmin, cmax = 999, -999\n  for _, x in ipairs(set.xs) do\n    if math.abs(x - 100) > 10 then\n      side = true\n      if x < 100 then L = math.max(L, x + 8) else R = math.min(R, x - 8) end\n    else\n      mid = true\n      cmin = math.min(cmin, x); cmax = math.max(cmax, x)\n    end\n  end\n  if side and not mid then\n    if R - L < 10 then return nil end\n    return L + 2.5, R - 2.5, \"in\"\n  elseif mid and not side then\n    local wl, er = cmin - 8, cmax + 8\n    if wl - 80 < 4 or 120 - er < 4 then return nil end\n    return (80 + wl) / 2, (er + 120) / 2, \"out\"\n  end\n  return nil\nend\nlocal m = data.m4_ewh\nif not (m and m.t and Now() - m.t < 20000) then return end\nif m.hit1 then return end\nlocal set = m.sets and m.sets[1]\nif not (set and Now() - set.t < 12000) then return end\nlocal wx, ex = lanes(set)\nif not wx then return end\nlocal ROW = {R1 = 83, R2 = 83, T1 = 93, T2 = 93, M1 = 104, M2 = 104, H1 = 115, H2 = 115}\nlocal z = ROW[slot]\nif not z then return end\nlocal g1 = (slot == \"T1\" or slot == \"H1\" or slot == \"M1\" or slot == \"R1\")\ngo(g1 and wx or ex, z)\n",
							name = "[Draw] M4S - Electrifying Witch Hunt first spreads",
							uuid = "e0df94c7-b5e4-594a-add8-2009ef410de0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 49.6,
				name = "[Draw] M4S - Electrifying Witch Hunt first spreads",
				timeRange = true,
				timelineIndex = 7,
				timerEndOffset = 2,
				timerStartOffset = -8,
				uuid = "b7b6dc41-ef30-4f78-b3dd-cb7955200845",
				version = 2,
			},
		},
	},
	[8] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "4b32bf4a-70a6-bbd0-9d8c-afad1f3aaefe",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Electrifying Witch Hunt, 2nd spreads (near/far bait). Boss Marker 2970: extra 0x2F6 = near, 0x2F7 = far.\n-- Hit by the 1st spreads (Forked Lightning 587) => don't bait. Quadrants: NW T1/R1, SW H1/M1, NE T2/R2, SE H2/M2;\n-- inside the quadrant: close spot (z 94/106) or far corner spot (z 83/117), in the safe lane of the 2nd Burst set.\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Burst lines (38378) are N-S rects 16 wide. Side lines (|x-100| > 10) => center lane safe (\"in\");\n-- a center line => both side lanes safe (\"out\"). Returns the west (G1) and east (G2) x to stand on.\nlocal function lanes(set)\n  if not (set and set.xs and #set.xs > 0) then return nil end\n  local side, mid = false, false\n  local L, R = 80, 120\n  local cmin, cmax = 999, -999\n  for _, x in ipairs(set.xs) do\n    if math.abs(x - 100) > 10 then\n      side = true\n      if x < 100 then L = math.max(L, x + 8) else R = math.min(R, x - 8) end\n    else\n      mid = true\n      cmin = math.min(cmin, x); cmax = math.max(cmax, x)\n    end\n  end\n  if side and not mid then\n    if R - L < 10 then return nil end\n    return L + 2.5, R - 2.5, \"in\"\n  elseif mid and not side then\n    local wl, er = cmin - 8, cmax + 8\n    if wl - 80 < 4 or 120 - er < 4 then return nil end\n    return (80 + wl) / 2, (er + 120) / 2, \"out\"\n  end\n  return nil\nend\nlocal m = data.m4_ewh\nif not (m and m.t and Now() - m.t < 20000) then return end\nif m.done2 or not m.hit1 then return end\nlocal set = m.sets and m.sets[2]\nif not (set and Now() - set.t < 12000) then return end\nlocal wx, ex = lanes(set)\nif not wx then return end\n-- near/far marker (cached once read)\nlocal function kind(ent)\n  local b = ent and TensorCore.getBuff(ent, 2970)\n  local s = b and b.stacks\n  if not s then return nil end\n  if s == 0x2F6 or s % 256 == 0xF6 then return \"near\" end\n  if s == 0x2F7 or s % 256 == 0xF7 then return \"far\" end\n  return nil\nend\nif not m.bait then\n  if m.boss then m.bait = kind(TensorCore.mGetEntity(m.boss)) end\n  if not m.bait and (not m.scan or Now() - m.scan > 250) then\n    m.scan = Now()\n    local list = TensorCore.getEntityGroupList(\"ContentID\", 17323)\n    if type(list) == \"table\" then\n      for _, r in pairs(list) do\n        local ent = r\n        if type(r) == \"number\" then ent = TensorCore.mGetEntity(r) end\n        if type(ent) == \"table\" then\n          local k = kind(ent)\n          if k then m.bait = k; break end\n        end\n      end\n    end\n  end\nend\nif not m.bait then return end\n-- my Forked Lightning: present => hit; absent 1s after the first hits landed => not hit.\n-- Cached once known: the debuff is consumed by the Forked Lightning hit (38375), which lands with or just before the baits.\nif m.fk == nil then\n  if TensorCore.getBuff(p, 587) then m.fk = true\n  elseif Now() - m.hit1.t >= 1000 then m.fk = false\n  else return end\nend\nlocal forked = m.fk\nlocal far = (m.bait == \"near\") == forked\nlocal north = (slot == \"T1\" or slot == \"T2\" or slot == \"R1\" or slot == \"R2\")\nlocal west = (slot == \"T1\" or slot == \"H1\" or slot == \"M1\" or slot == \"R1\")\nif not (north or slot == \"H1\" or slot == \"H2\" or slot == \"M1\" or slot == \"M2\") then return end\nlocal z\nif north then z = far and 83 or 94 else z = far and 117 or 106 end\ngo(west and wx or ex, z)\n",
							name = "[Draw] M4S - Witch Hunt near/far second spreads",
							uuid = "57ce3942-a49b-4eac-9897-a31ce5bdc761",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 57.6,
				name = "[Draw] M4S - Witch Hunt near/far second spreads",
				timeRange = true,
				timelineIndex = 8,
				timerEndOffset = 2.5,
				timerStartOffset = -7,
				uuid = "a5750884-98cf-8dea-b663-1cd0fe319483",
				version = 2,
			},
		},
	},
	[9] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "4f60c19f-3b77-7346-b142-6ccb20665d15",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Narrowing/Widening Witch Hunt cast start (BossP1, 14+1s cast).\n-- 38368 Widening (95E0) = Out In Out In, 38369 Narrowing (95E1) = In Out In Out.\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38368 and sp ~= 38369 then return end\nlocal cx, cz = 100, 100\nlocal b = e.entityID and TensorCore.mGetEntity(e.entityID)\nif b and b.pos and math.abs(b.pos.x - 100) < 6 and math.abs(b.pos.z - 100) < 6 then cx, cz = b.pos.x, b.pos.z end\ndata.m4_nwh = {t = Now(), firstOut = (sp == 38368), boss = e.entityID, cx = cx, cz = cz, hits = 0, lastHit = 0}\n",
							name = "[Draw] M4S - Narrowing/Widening Witch Hunt capture cast",
							uuid = "8a21fff9-b887-b8a8-8907-622f611a8de4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 74.7,
				name = "[Draw] M4S - Narrowing/Widening Witch Hunt capture cast",
				timeRange = true,
				timelineIndex = 9,
				timerEndOffset = 6,
				timerStartOffset = -20,
				uuid = "50c0a3e4-f635-d84a-ab54-d77b86346297",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Narrowing/Widening Witch Hunt: count the 4 in/out hits.\n-- 19729 LightningVortexAOE = range 10 circle (OUT safe), 19730 ThunderingAOE = 10-60 donut (IN safe).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 19729 and sp ~= 19730 then return end\nlocal m = data.m4_nwh\nif not (m and m.t) then return end\nlocal now = Now()\nif now - m.t > 40000 or (m.hits or 0) >= 4 then return end\nif now - (m.lastHit or 0) < 1500 then return end\nm.lastHit = now\nm.hits = (m.hits or 0) + 1\n-- the hit itself tells which pattern this step was; trust it over the cast id if they ever disagree\nlocal wasOut = (sp == 19729)\nlocal oddStep = (m.hits % 2 == 1)\nif oddStep then m.firstOut = wasOut else m.firstOut = not wasOut end\n",
							name = "[Draw] M4S - Narrowing/Widening Witch Hunt capture in/out hits",
							uuid = "b7722c86-50e9-f8d7-91bf-1573dbf9e1f4",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 74.7,
				name = "[Draw] M4S - Narrowing/Widening Witch Hunt capture in/out hits",
				timeRange = true,
				timelineIndex = 9,
				timerEndOffset = 18,
				timerStartOffset = -20,
				uuid = "b7a919d2-e6b5-1747-894d-137b513fcbeb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Narrowing/Widening Witch Hunt: modified clocks, 4 steps of in/out + 2 baits each.\n-- Bait near/far comes from status 2970 (Marker) on the boss: extra 0x2F6 = near, 0x2F7 = far, then alternates per step.\n-- Steps 1-2 supports bait (near = tanks, far = healers), steps 3-4 DPS (near = melee, far = ranged).\nlocal m = data.m4_nwh\nif not (m and m.t) then return end\nlocal now = Now()\nlocal el = now - m.t\nif el < 0 or el > 40000 then return end\nlocal hits = m.hits or 0\nif hits >= 4 then return end\nif hits == 0 and el > 24000 then return end\nif hits > 0 and now - (m.lastHit or 0) > 6000 then return end\nif m.firstNear == nil then\n  if el > 6000 then return end\n  local function rd(ent)\n    if not ent then return nil end\n    local bf = TensorCore.getBuff(ent, 2970)\n    if not (bf and bf.stacks) then return nil end\n    local s = bf.stacks % 256\n    if s == 0xF6 then return true elseif s == 0xF7 then return false end\n    return nil\n  end\n  local v = m.boss and rd(TensorCore.mGetEntity(m.boss))\n  if v == nil then\n    local l = TensorCore.entityList(\"contentid=17323\")\n    if l then\n      for _, en in pairs(l) do\n        v = rd(en)\n        if v ~= nil then break end\n      end\n    end\n  end\n  if v == nil then return end\n  m.firstNear = v\nend\nlocal step = hits + 1\nlocal odd = (step % 2 == 1)\nlocal isOut = (odd and m.firstOut) or ((not odd) and not m.firstOut)\nlocal near = (odd and m.firstNear) or ((not odd) and not m.firstNear)\nlocal s = 0.7071\nlocal DIR = {T1 = {0, -1}, T2 = {0, 1}, M1 = {-1, 0}, M2 = {1, 0}, H1 = {-s, s}, H2 = {s, s}, R1 = {-s, -s}, R2 = {s, -s}}\nlocal dv = DIR[slot]\nif not dv then return end\nlocal role = slot:sub(1, 1)\nlocal baitRole\nif step <= 2 then baitRole = near and \"T\" or \"H\" else baitRole = near and \"M\" or \"R\" end\nlocal amBait = (role == baitRole)\n-- radii from the boss: In = safe inside 10, Out = safe outside 10; bait AoE is a 6y circle on the baiter\nlocal rClose, rFar\n-- In: near baiters at 4 so the two tanks/melee (opposite sides) are 8y apart, outside each other's 6y bait; far ring 9 stays inside the 10y donut hole\nif isOut then rClose, rFar = 12, 18 else rClose, rFar = 4, 9 end\nlocal r\nif near then r = amBait and rClose or rFar else r = amBait and rFar or rClose end\ngo((m.cx or 100) + dv[1] * r, (m.cz or 100) + dv[2] * r)\n",
							name = "[Draw] M4S - Narrowing/Widening Witch Hunt in/out + bait spot",
							uuid = "a9f61269-a2d2-c80c-ac89-fe33f4d6f270",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 74.7,
				name = "[Draw] M4S - Narrowing/Widening Witch Hunt in/out + bait spot",
				timeRange = true,
				timelineIndex = 9,
				timerEndOffset = 16,
				timerStartOffset = -20,
				uuid = "8f5f4fc9-b74a-03dc-960c-ce197e2af34d",
				version = 2,
			},
		},
	},
	[16] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "b42d14ac-ee27-1a63-87d3-7f7b3d0a159f",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S EE1 capture: Electromine sparks (38345 = mine hit once -> 10x10, 38346 = hit twice -> 30x30)\n-- and boss Sidewise Spark (38380 = east half cleaved, 38381 = west half cleaved)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38345 and sp ~= 38346 and sp ~= 38380 and sp ~= 38381 then return end\nlocal now = Now()\nlocal m = data.m4_ee1\nif not m or now - (m.t0 or 0) > 60000 then m = {t0 = now, mines = {}}; data.m4_ee1 = m end\nif sp == 38380 or sp == 38381 then\n  m.cleave = (sp == 38380) and 1 or -1\n  m.boss = e.entityID\n  m.tc = now\n  return\nend\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nif not ps then return end\nm.mines[e.entityID] = {x = ps.x, z = ps.z, n = (sp == 38345) and 1 or 2, spark = true}\n",
							name = "[Draw] M4S - EE1 capture (sparks + Sidewise Spark)",
							uuid = "f3445d42-ee1c-002a-b5be-8c30c94a5d33",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 109.7,
				name = "[Draw] M4S - EE1 capture (sparks + Sidewise Spark)",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 32,
				timerStartOffset = -6,
				uuid = "45398a9f-775d-7743-9dfe-2101810ff7f8",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S EE1 capture: Witchgleam rays (38343) counted per Electromine (ContentID 17325) as a backup to the\n-- spark casts; Four Star (38352) / Eight Star (38353) mark the mechanic done\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38343 and sp ~= 38352 and sp ~= 38353 then return end\nlocal now = Now()\nlocal m = data.m4_ee1\nif not m or now - (m.t0 or 0) > 60000 then\n  if sp ~= 38343 then return end\n  m = {t0 = now, mines = {}}; data.m4_ee1 = m\nend\nif sp ~= 38343 then m.done = m.done or now; return end\nlocal ht = e.hitTargets\nif type(ht) ~= \"table\" then return end\nfor _, id in ipairs(ht) do\n  local ent = TensorCore.mGetEntity(id)\n  if ent and ent.contentid == 17325 and ent.pos then\n    local mi = m.mines[id]\n    if not mi then mi = {x = ent.pos.x, z = ent.pos.z, n = 0}; m.mines[id] = mi end\n    if not mi.spark then mi.n = mi.n + 1 end\n  end\nend\n",
							name = "[Draw] M4S - EE1 capture (Witchgleam hits + stars)",
							uuid = "77cd823f-4d99-461b-b81c-a8efddb12a3e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 109.7,
				name = "[Draw] M4S - EE1 capture (Witchgleam hits + stars)",
				timeRange = true,
				timelineIndex = 16,
				timerEndOffset = 32,
				timerStartOffset = -6,
				uuid = "67337817-ef88-94bf-97c2-8296ab762a84",
				version = 2,
			},
		},
	},
	[21] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "0da5a240-341c-a411-84b1-3011dab8acea",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- [Draw] M4S Electrope Edge 1: safe quadrant = the quadrant of a once-hit Electromine that the Sidewise Spark\n-- does not cleave; 8 orbs (boss Marker 2970 extra 0x2F1) = spread, 4 orbs (extra 0x2F0) = partners.\n-- Spots are written for a SW safe quadrant and rotated (so \"left facing the boss\" stays left).\nlocal m = data.m4_ee1\nif not (m and m.cleave and m.tc and m.mines) then return end\nlocal now = Now()\nif now - m.tc > 15000 then return end\nif m.done and now - m.done > 1500 then return end\nif not m.star and m.boss then\n  local b = TensorCore.mGetEntity(m.boss)\n  local bf = b and TensorCore.getBuff(b, 2970)\n  local s = bf and bf.stacks\n  if type(s) == \"number\" then\n    s = s % 256\n    if s == 0xF0 then m.star = \"pair\" elseif s == 0xF1 then m.star = \"spread\" end\n  end\nend\nif not m.star then return end\nlocal useSpark = false\nfor _, mi in pairs(m.mines) do if mi.spark then useSpark = true end end\nlocal q, nq = nil, 0\nfor _, mi in pairs(m.mines) do\n  if mi.n == 1 and (mi.spark or not useSpark) then\n    local sx = mi.x < 100 and -1 or 1\n    local sz = mi.z < 100 and -1 or 1\n    if sx ~= m.cleave and not (q and q.sx == sx and q.sz == sz) then q = {sx = sx, sz = sz}; nq = nq + 1 end\n  end\nend\nif nq ~= 1 then return end\nlocal k = (q.sx < 0 and q.sz > 0 and 0) or (q.sx < 0 and 1) or (q.sz < 0 and 2) or 3\nlocal SPREAD = {R1 = {81.5, 101.5}, M1 = {91, 101.5}, T1 = {98.5, 101.5}, H1 = {81.5, 108.5},\n  T2 = {91, 108.5}, M2 = {98.5, 108.5}, H2 = {91.5, 118.5}, R2 = {98.5, 118.5}}\nlocal PAIR = {H1 = {83, 104.5}, R1 = {83, 104.5}, T1 = {92.5, 102.5}, M1 = {92.5, 102.5},\n  T2 = {98.5, 108}, M2 = {98.5, 108}, H2 = {95, 117}, R2 = {95, 117}}\nlocal spot = ((m.star == \"pair\") and PAIR or SPREAD)[slot]\nif not spot then return end\nlocal dx, dz = spot[1] - 100, spot[2] - 100\nfor _ = 1, k do dx, dz = -dz, dx end\ngo(100 + dx, 100 + dz)\n",
							name = "[Draw] M4S - Electrope Edge 1 safe quadrant spot",
							uuid = "46d5eae5-5d62-d03a-9fee-3dda96ad9709",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 134.4,
				name = "[Draw] M4S - Electrope Edge 1 safe quadrant spot",
				timeRange = true,
				timelineIndex = 21,
				timerEndOffset = 5,
				timerStartOffset = -12,
				uuid = "1923a65c-a1bd-daf6-a1b0-881a33f51459",
				version = 2,
			},
		},
	},
	[26] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "50609d56-2373-2db6-960e-eb8a6671547e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Electrope Edge 2 capture (abilities landing):\n-- 38790 Lightning Cage Witchgleam line (count how many hit me; also read my Electrical Condenser 3999 once:\n--   long 42s / short 22s, at the first line long has ~36s left, short ~16s);\n-- 38351 Lightning Cage cell AOE landed = that cage wave is over; 38352/38353 Four/Eight Star landed.\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38790 and sp ~= 38351 and sp ~= 38352 and sp ~= 38353 then return end\nlocal now = Now()\nlocal m = data.m4_ee2\nif not m or not m.t0 or now - m.t0 > 70000 then\n  m = {t0 = now, gleams = 0}\n  data.m4_ee2 = m\nend\nif sp == 38790 then\n  local p = TensorCore.mGetPlayer()\n  if not (p and p.id) then return end\n  if m.long == nil then\n    local b = TensorCore.getBuff(p, 3999)\n    if b and b.duration and b.duration > 0 then m.long = b.duration > 25 end\n  end\n  local hits = e.hitTargets\n  if type(hits) == \"table\" then\n    for _, id in ipairs(hits) do\n      if id == p.id then m.gleams = (m.gleams or 0) + 1; break end\n    end\n  end\nelseif sp == 38351 then\n  if m.wave and not m.wave.done then m.wave.done = now end\nelse\n  m.starDone = now\nend\n",
							name = "[Draw] M4S - Electrope Edge 2 capture hits",
							uuid = "69457762-b657-1be1-906f-764ae8cac933",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 157,
				name = "[Draw] M4S - Electrope Edge 2 capture hits",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 50,
				timerStartOffset = -5,
				uuid = "c9582437-205a-f516-a9eb-fe70da92f83d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Electrope Edge 2 capture (cast starts):\n-- 38351 Lightning Cage cell AOE (Helper, 8x8 cell): store the cell index (BossMod grid: 5x5 cells of 8y,\n--   centers 84..116, index = zRow * 8 + xCol); casts more than 4s apart start a new wave.\n-- 38380 Sidewise Spark R (east half cleave -> west safe) / 38381 L (west cleave -> east safe), caster = boss.\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38351 and sp ~= 38380 and sp ~= 38381 then return end\nlocal now = Now()\nlocal m = data.m4_ee2\nif not m or not m.t0 or now - m.t0 > 70000 then\n  m = {t0 = now, gleams = 0}\n  data.m4_ee2 = m\nend\nif sp == 38351 then\n  local ent = e.entityID and TensorCore.mGetEntity(e.entityID)\n  local ps = ent and ent.pos\n  if not ps then return end\n  local function ci(c)\n    if c < 88 then return 0 elseif c < 96 then return 1 elseif c < 104 then return 2 elseif c < 112 then return 3 end\n    return 4\n  end\n  if not m.wave or now - m.wave.t > 4000 then\n    m.nwave = (m.nwave or 0) + 1\n    m.wave = {t = now, n = m.nwave, cells = {}}\n  end\n  m.wave.cells[ci(ps.z) * 8 + ci(ps.x)] = true\nelse\n  m.side = {t = now, boss = e.entityID, westSafe = (sp == 38380)}\nend\n",
							name = "[Draw] M4S - Electrope Edge 2 capture casts",
							uuid = "2f8f6edd-2f33-6782-b760-243bf4d51f85",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 157,
				name = "[Draw] M4S - Electrope Edge 2 capture casts",
				timeRange = true,
				timelineIndex = 26,
				timerEndOffset = 50,
				timerStartOffset = -5,
				uuid = "a874c4de-c6ba-f349-ab82-ca60880b531c",
				version = 2,
			},
		},
	},
	[31] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "e69081f4-cb0b-e35f-939a-0ffbaade956b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Electrope Edge 2 - Lightning Cage spot. While a cage wave is up: if your Electrical Condenser is about to pop\n-- (< 12s left: shorts in wave 1, longs in wave 2) go to your count cell, else wait on the safe cell (\"north\").\n-- Count = Witchgleam lines that hit you (+1 if long). 2 -> BossMod \"two\" cells, 3 -> \"three\" cells.\n-- Supports take the cell on the LEFT and DPS the one on the RIGHT when facing the safe cell from the center\n-- (safe north: supports west, DPS east -> DPS 2 = NE, 3 = SE).\nlocal m = data.m4_ee2\nlocal w = m and m.wave\nlocal now = Now()\nif not (w and w.cells and not w.done and now - w.t < 9000) then return end\nlocal pat = w.pat\nif not pat then\n  -- match once per wave and cache on the wave (no per-frame table building after the match)\n  local P = {\n    {cells = {0, 1, 3, 4, 10, 18, 24, 26, 28, 33, 34, 35}, safe = 2, two = {8, 12}, three = {32, 36}},\n    {cells = {1, 4, 8, 12, 16, 17, 18, 19, 24, 28, 33, 36}, safe = 20, two = {3, 35}, three = {0, 32}},\n    {cells = {1, 2, 3, 8, 10, 12, 18, 26, 32, 33, 35, 36}, safe = 34, two = {24, 28}, three = {0, 4}},\n    {cells = {0, 3, 8, 12, 17, 18, 19, 20, 24, 28, 32, 35}, safe = 16, two = {1, 33}, three = {4, 36}},\n  }\n  for _, q in ipairs(P) do\n    local set = {}\n    for _, c in ipairs(q.cells) do set[c] = true end\n    local ok, n = true, 0\n    for c in pairs(w.cells) do\n      n = n + 1\n      if not set[c] then ok = false; break end\n    end\n    if ok and n >= 6 then\n      if pat then return end -- ambiguous\n      pat = q\n    end\n  end\n  if pat then w.pat = pat end\nend\nif not pat then return end\nlocal function cc(i) return 84 + 8 * (i % 8), 84 + 8 * math.floor(i / 8) end\nlocal sx, sz = cc(pat.safe)\nlocal b = TensorCore.getBuff(p, 3999)\nlocal mine = b and b.duration and b.duration > 0 and b.duration < 12\nif not mine then go(sx, sz); return end\nlocal long = m.long\nif long == nil then return end\nlocal cnt = (m.gleams or 0) + (long and 1 or 0)\nlocal pair = (cnt == 2 and pat.two) or (cnt == 3 and pat.three)\nif not pair then return end\nlocal sup = slot == \"T1\" or slot == \"T2\" or slot == \"H1\" or slot == \"H2\"\nlocal dps = slot == \"M1\" or slot == \"M2\" or slot == \"R1\" or slot == \"R2\"\nif not (sup or dps) then return end\nlocal fx, fz = sx - 100, sz - 100\nfor _, i in ipairs(pair) do\n  local x, z = cc(i)\n  local left = (x - 100) * fz - (z - 100) * fx > 0\n  if left == sup then go(x, z); return end\nend\n",
							name = "[Draw] M4S - Electrope Edge 2 Lightning Cage spot",
							uuid = "619156a8-c3f3-55ba-a813-db001ce2c929",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 172.1,
				name = "[Draw] M4S - Electrope Edge 2 Lightning Cage spot",
				timeRange = true,
				timelineIndex = 31,
				timerEndOffset = 32,
				timerStartOffset = -4,
				uuid = "389d61ca-3999-e613-8dab-f6dab07d91c7",
				version = 2,
			},
		},
	},
	[33] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "f0592378-5d5f-1dff-a818-7fbe8dc0db2d",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Electrope Edge 2 - Sidewise Spark 2 + Four/Eight Star spot (half-room cleave from the boss at center).\n-- Boss Marker status 2970: param 0x2F0 = partners (Four Star), 0x2F1 = spread (Eight Star).\n-- Spread (west safe; east safe = rotated 180): R1 left-far facing the unsafe half (92,83), H1 (85,90), MT (96,91),\n--   M1 (96,100), M2 (88,100), OT (96,109), H2 (85,110), R2 (92,117).\n-- Partners (one short + one long per pair, same count): supports 3 north / 2 south of the boss, DPS 2 under the\n--   boss, DPS 3 at the side (max melee) - all in the safe half.\nlocal m = data.m4_ee2\nlocal s = m and m.side\nlocal now = Now()\nif not (s and s.boss and now - s.t < 8500) then return end\nif m.starDone and m.starDone >= s.t then return end\nlocal boss = TensorCore.mGetEntity(s.boss)\nif not boss then return end\nlocal mech = s.mech\nif not mech then\n  local bf = TensorCore.getBuff(boss, 2970)\n  if bf and type(bf.stacks) == \"number\" then\n    local v = bf.stacks % 256\n    if v == 0xF0 then mech = \"pairs\" elseif v == 0xF1 then mech = \"spread\" end\n  end\n  if not mech then return end\n  s.mech = mech\nend\nlocal x, z\nif mech == \"spread\" then\n  local S = {R1 = {92, 83}, H1 = {85, 90}, T1 = {96, 91}, M1 = {96, 100}, M2 = {88, 100}, T2 = {96, 109}, H2 = {85, 110}, R2 = {92, 117}}\n  local q = S[slot]\n  if not q then return end\n  x, z = q[1], q[2]\n  if not s.westSafe then x, z = 200 - x, 200 - z end\nelse\n  local long = m.long\n  if long == nil then return end\n  -- sanity: longs still hold the debuff here, shorts already popped\n  local b = TensorCore.getBuff(p, 3999)\n  if (b ~= nil) ~= long then return end\n  local cnt = (m.gleams or 0) + (long and 1 or 0)\n  if cnt ~= 2 and cnt ~= 3 then return end\n  local sup = slot == \"T1\" or slot == \"T2\" or slot == \"H1\" or slot == \"H2\"\n  local dps = slot == \"M1\" or slot == \"M2\" or slot == \"R1\" or slot == \"R2\"\n  if sup then x, z = 98, (cnt == 3 and 91 or 109)\n  elseif dps then x, z = (cnt == 2 and 98 or 90), 100\n  else return end\n  if not s.westSafe then x = 200 - x end\nend\ngo(x, z)\n",
							name = "[Draw] M4S - Electrope Edge 2 spread/partners spot",
							uuid = "2da556d7-2899-ca59-8be5-6c22c14a6862",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 189.2,
				name = "[Draw] M4S - Electrope Edge 2 spread/partners spot",
				timeRange = true,
				timelineIndex = 33,
				timerEndOffset = 3,
				timerStartOffset = -10,
				uuid = "2361c54b-ed79-6e2b-ab10-58d5b648c97d",
				version = 2,
			},
		},
	},
	[38] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "db5ef62c-352b-2ae7-a0ca-15e2c9ea5c55",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- 38354 IonClusterVisualR (Right Roll, 95D2) -> east column x110-120 survives\n-- 38355 IonClusterVisualL (Left Roll, 95D3)  -> west column x80-90 survives\n-- 36399 Stampeding Thunder finish (helper on the destroyed 30-wide area): fallback\nlocal e = eventArgs\nlocal sp = e and e.spellID\nif sp ~= 38354 and sp ~= 38355 and sp ~= 36399 then return end\ndata.m4_ion = data.m4_ion or {}\nlocal m = data.m4_ion\nlocal now = Now()\nif sp == 38354 then\n  m.roll = {t = now, x = 115, side = \"R\"}\nelseif sp == 38355 then\n  m.roll = {t = now, x = 85, side = \"L\"}\nelse\n  if m.roll and now - m.roll.t < 30000 then return end\n  local c = TensorCore.mGetEntity(e.entityID)\n  if c and c.pos then\n    if c.pos.x < 100 then m.roll = {t = now, x = 115, side = \"R\", fb = true}\n    else m.roll = {t = now, x = 85, side = \"L\", fb = true} end\n  end\nend\n",
							name = "[Capture] M4S - Ion Cluster column (roll)",
							uuid = "3fd10ba5-e267-9894-96c1-1df7958a6588",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 230,
				name = "[Capture] M4S - Ion Cluster column (roll)",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 15,
				timerStartOffset = -10,
				uuid = "86d9b194-e07d-cb72-b501-f7025e155381",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal m = data.m4_ion\nlocal r = m and m.roll\nlocal now = Now()\nif not r or now - r.t > 25000 or now < r.t then return end\nif m.es and now >= m.es.t and now - m.es.t < 20000 then return end\ngo(r.x, 100)\n",
							name = "[Draw] M4S - Stampeding Thunder safe column",
							uuid = "78bb983f-497c-66ee-8b1c-2670bad4654d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 230,
				name = "[Draw] M4S - Stampeding Thunder safe column",
				timeRange = true,
				timelineIndex = 38,
				timerEndOffset = 17,
				timerStartOffset = -1,
				uuid = "7cc809a8-b8f3-1bee-b866-fd483cf896eb",
				version = 2,
			},
		},
	},
	[42] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "d615b7ac-78eb-6220-b636-24e6b8d7566e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Electron Stream boss casts: 38358 (95D6) yellow/positron N, blue/negatron S\n--                             38359 (95D7) yellow S, blue N\n-- Positron 4000 = yellow debuff -> stand in blue; Negatron 4001 = blue -> stand in yellow\nlocal e = eventArgs\nlocal sp = e and e.spellID\nif sp ~= 38358 and sp ~= 38359 then return end\ndata.m4_ion = data.m4_ion or {}\nlocal m = data.m4_ion\nlocal side = nil\nlocal p = TensorCore.mGetPlayer()\nif p then\n  if TensorCore.hasBuff(p, 4000) then side = (sp == 38358) and 1 or -1\n  elseif TensorCore.hasBuff(p, 4001) then side = (sp == 38358) and -1 or 1 end\nend\nm.es = {t = Now(), sp = sp, boss = e.entityID, side = side}\n",
							name = "[Capture] M4S - Electron Stream casts",
							uuid = "5e6feb3d-f22a-0c7e-8c5d-4ded58265358",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 249.2,
				name = "[Capture] M4S - Electron Stream casts",
				timeRange = true,
				timelineIndex = 42,
				timerEndOffset = 40,
				timerStartOffset = -12,
				uuid = "105bfd18-f68d-8c62-a02f-b024e7ec4324",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal m = data.m4_ion\nlocal es = m and m.es\nif not es then return end\nlocal el = Now() - es.t\nif el < 0 or el > 13000 then return end\nlocal b = es.boss and TensorCore.mGetEntity(es.boss)\nif not (b and b.pos) then return end\nlocal bx, bz = b.pos.x, b.pos.z\nlocal tank = (slot == \"T1\" or slot == \"T2\")\nlocal sup = tank or slot == \"H1\" or slot == \"H2\"\nif el < 6300 then\n  -- stream cast: stand in the opposite colour; tank in front, others behind the tank\n  local side = nil\n  if TensorCore.hasBuff(p, 4000) then side = (es.sp == 38358) and 1 or -1\n  elseif TensorCore.hasBuff(p, 4001) then side = (es.sp == 38358) and -1 or 1 end\n  if side then es.side = side else side = es.side end\n  if not side then return end\n  if tank then go(bx, bz + side * 2.5) else go(bx, bz + side * 5) end\n  return\nend\n-- after the stream: conductor/current debuffs (DN strat) on the side we stood on\nlocal s = es.side\nif not s then s = (p.pos.z >= bz) and 1 or -1 end\nif TensorCore.hasBuff(p, 4002) or TensorCore.hasBuff(p, 4003) then\n  go(bx, bz + s * 3)\nelseif TensorCore.hasBuff(p, 4004) or TensorCore.hasBuff(p, 4005) then\n  if sup then go(bx - s * 2.9, bz + s * 2.1) else go(bx + s * 2.9, bz + s * 2.1) end\nelseif TensorCore.hasBuff(p, 4006) then\n  go(bx, bz + s * 5)\nend\n",
							name = "[Draw] M4S - Electron Stream 1 + debuff spot",
							uuid = "d5e55e49-0bf8-3a95-857c-ef20c99510dd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 249.2,
				name = "[Draw] M4S - Electron Stream 1 + debuff spot",
				timeRange = true,
				timelineIndex = 42,
				timerEndOffset = 6.5,
				timerStartOffset = -9,
				uuid = "b38e9f3d-dd14-ff18-acd6-ab435e8ed98c",
				version = 2,
			},
		},
	},
	[44] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "8dd5437c-6706-89bb-882a-48fa15b38b7a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal m = data.m4_ion\nlocal es = m and m.es\nif not es then return end\nlocal el = Now() - es.t\nif el < 0 or el > 13000 then return end\nlocal b = es.boss and TensorCore.mGetEntity(es.boss)\nif not (b and b.pos) then return end\nlocal bx, bz = b.pos.x, b.pos.z\nlocal tank = (slot == \"T1\" or slot == \"T2\")\nlocal sup = tank or slot == \"H1\" or slot == \"H2\"\nif el < 6300 then\n  -- stream cast: stand in the opposite colour; tank in front, others behind the tank\n  local side = nil\n  if TensorCore.hasBuff(p, 4000) then side = (es.sp == 38358) and 1 or -1\n  elseif TensorCore.hasBuff(p, 4001) then side = (es.sp == 38358) and -1 or 1 end\n  if side then es.side = side else side = es.side end\n  if not side then return end\n  if tank then go(bx, bz + side * 2.5) else go(bx, bz + side * 5) end\n  return\nend\n-- after the stream: conductor/current debuffs (DN strat) on the side we stood on\nlocal s = es.side\nif not s then s = (p.pos.z >= bz) and 1 or -1 end\nif TensorCore.hasBuff(p, 4002) or TensorCore.hasBuff(p, 4003) then\n  go(bx, bz + s * 3)\nelseif TensorCore.hasBuff(p, 4004) or TensorCore.hasBuff(p, 4005) then\n  if sup then go(bx - s * 2.9, bz + s * 2.1) else go(bx + s * 2.9, bz + s * 2.1) end\nelseif TensorCore.hasBuff(p, 4006) then\n  go(bx, bz + s * 5)\nend\n",
							name = "[Draw] M4S - Electron Stream 2 + debuff spot",
							uuid = "a12d80c7-008d-2240-9c1d-922de69f62d1",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 262.3,
				name = "[Draw] M4S - Electron Stream 2 + debuff spot",
				timeRange = true,
				timelineIndex = 44,
				timerEndOffset = 6.5,
				timerStartOffset = -6.5,
				uuid = "f3e8412c-599d-2db9-aa9d-a073978d8e8b",
				version = 2,
			},
		},
	},
	[46] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "bdc38cc8-eb36-4b5b-8289-a4b06c246c0a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal m = data.m4_ion\nlocal es = m and m.es\nif not es then return end\nlocal el = Now() - es.t\nif el < 0 or el > 13000 then return end\nlocal b = es.boss and TensorCore.mGetEntity(es.boss)\nif not (b and b.pos) then return end\nlocal bx, bz = b.pos.x, b.pos.z\nlocal tank = (slot == \"T1\" or slot == \"T2\")\nlocal sup = tank or slot == \"H1\" or slot == \"H2\"\nif el < 6300 then\n  -- stream cast: stand in the opposite colour; tank in front, others behind the tank\n  local side = nil\n  if TensorCore.hasBuff(p, 4000) then side = (es.sp == 38358) and 1 or -1\n  elseif TensorCore.hasBuff(p, 4001) then side = (es.sp == 38358) and -1 or 1 end\n  if side then es.side = side else side = es.side end\n  if not side then return end\n  if tank then go(bx, bz + side * 2.5) else go(bx, bz + side * 5) end\n  return\nend\n-- after the stream: conductor/current debuffs (DN strat) on the side we stood on\nlocal s = es.side\nif not s then s = (p.pos.z >= bz) and 1 or -1 end\nif TensorCore.hasBuff(p, 4002) or TensorCore.hasBuff(p, 4003) then\n  go(bx, bz + s * 3)\nelseif TensorCore.hasBuff(p, 4004) or TensorCore.hasBuff(p, 4005) then\n  if sup then go(bx - s * 2.9, bz + s * 2.1) else go(bx + s * 2.9, bz + s * 2.1) end\nelseif TensorCore.hasBuff(p, 4006) then\n  go(bx, bz + s * 5)\nend\n",
							name = "[Draw] M4S - Electron Stream 3 + debuff spot",
							uuid = "25851e57-b1a9-3666-991c-c14aba042346",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 275.3,
				name = "[Draw] M4S - Electron Stream 3 + debuff spot",
				timeRange = true,
				timelineIndex = 46,
				timerEndOffset = 8,
				timerStartOffset = -6.5,
				uuid = "24a16517-8de7-0ee6-aa9d-f0c1cb98344c",
				version = 2,
			},
		},
	},
	[52] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "5df1891a-80cc-ede9-8d79-7ab2038741e2",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S transition: Fulminous Field cone cast start (37118). The 8 cones sit at heading h + k*45deg;\n-- every 3s the next set is rotated 22.5deg. Resets this iteration's state.\nlocal e = eventArgs\nif not (e and e.spellID == 37118) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal h = ent and ent.pos and ent.pos.h\nif not h then return end\nlocal m = data.m4_tr\nif m and m.sets == 0 and Now() - m.t < 2000 then return end\ndata.m4_tr = {dir = h, t = Now(), sets = 0, lastHit = 0, cp = {}, known = true}\n",
							name = "[Draw] M4S - Transition cones capture (cast start)",
							uuid = "51df016f-7d89-3d62-b44f-f448f4428ddc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 323.9,
				name = "[Draw] M4S - Transition cones capture (cast start)",
				timeRange = true,
				timelineIndex = 52,
				timerEndOffset = 50,
				timerStartOffset = -12,
				uuid = "e1afb75c-6604-efe9-a418-a4eec36460c5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S transition: Fulminous Field hits (37118 first / 39117 rest) rotate the next cones by 22.5deg;\n-- Conduction Point (39118) marks the 4 players hit; Forked Fissures (39119) = wild charges resolved.\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 37118 and sp ~= 39117 and sp ~= 39118 and sp ~= 39119 then return end\nlocal now = Now()\nlocal m = data.m4_tr\nif sp == 37118 or sp == 39117 then\n  if not m or now - m.t > 5000 then\n    m = {dir = 0, t = now, sets = 0, lastHit = 0, cp = {}}\n    data.m4_tr = m\n  end\n  local h = e.heading\n  if type(h) ~= \"number\" then\n    local ent = TensorCore.mGetEntity(e.entityID)\n    h = ent and ent.pos and ent.pos.h\n  end\n  if now - (m.lastHit or 0) > 1000 then\n    m.sets = (m.sets or 0) + 1\n    m.lastHit = now\n    if h then m.dir = h + math.pi / 8 else m.dir = (m.dir or 0) + math.pi / 8 end\n    m.known = (h ~= nil) or m.known\n  elseif h then\n    m.dir = h + math.pi / 8\n  end\n  m.t = now\n  return\nend\nif not m or now - m.t > 8000 then return end\nif sp == 39118 then\n  if not m.cpT or now - m.cpT > 2000 then m.cp = {} end\n  m.cpT = now\n  local hits = e.hitTargets\n  if type(hits) == \"table\" and #hits > 0 then\n    for _, id in ipairs(hits) do m.cp[id] = true end\n  elseif e.targetID then\n    m.cp[e.targetID] = true\n  end\nelse\n  m.fissT = now\nend\n",
							name = "[Draw] M4S - Transition cones + Conduction Point capture",
							uuid = "c70b8835-1640-80fa-8585-07a63954e0fd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 323.9,
				name = "[Draw] M4S - Transition cones + Conduction Point capture",
				timeRange = true,
				timelineIndex = 52,
				timerEndOffset = 50,
				timerStartOffset = -12,
				uuid = "90de7c43-fc11-bec3-b146-89f3def662ad",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Transition (Electrope Transplant): pairs dodge the 8 rotating cones at their intercard, alternating with the\n-- gap 22.5deg to the left (facing the boss). H+M north (H1/M1 NE, H2/M2 NW), T+R south (MT/R1 SE, OT/R2 SW);\n-- tanks + melee near, healers + ranged far. Conduction Point: the 4 hit players go far, their partners near\n-- (take the Forked Fissures wild charge in front). Spot = the cone gap of the NEXT set next to your intercard.\nlocal m = data.m4_tr\nif not (m and m.dir) then return end\nlocal now = Now()\nif now - m.t > 4500 or (m.sets or 0) >= 7 then return end\nif not m.known then return end\nlocal BASE = {H1 = 3, M1 = 3, H2 = -3, M2 = -3, T1 = 1, R1 = 1, T2 = -1, R2 = -1}\nlocal b = BASE[slot]\nif not b then return end\nlocal base = b * math.pi / 4\nlocal NEAR, FAR = 9, 17\nlocal far = (slot:sub(1, 1) == \"H\" or slot:sub(1, 1) == \"R\")\nif m.cpT and now - m.cpT < 5000 and not (m.fissT and m.fissT > m.cpT) then\n  far = m.cp and m.cp[p.id] and true or false\nend\n-- gaps of the next cones sit at dir + 22.5 + k*45; take the one nearest base - 11.25 (base or 22.5 clockwise)\nlocal step = math.pi / 4\nlocal first = m.dir + math.pi / 8\nlocal mid = base - math.pi / 16\nlocal k = math.floor((mid - first) / step + 0.5)\nlocal g = first + k * step\nlocal r = far and FAR or NEAR\ngo(100 + r * math.sin(g), 100 + r * math.cos(g))\n",
							name = "[Draw] M4S - Transition cones + wild charge spot (1)",
							uuid = "7729b8b7-2a8d-e2f5-bdbe-44b829c1cb99",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 323.9,
				name = "[Draw] M4S - Transition cones + wild charge spot (1)",
				timeRange = true,
				timelineIndex = 52,
				timerEndOffset = 19,
				timerStartOffset = -9,
				uuid = "59c3a86f-b18a-7896-bfdf-0676fe5bb2a1",
				version = 2,
			},
		},
	},
	[61] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "1c18f806-8000-73d4-9f83-39ccd79d313a",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Transition (Electrope Transplant): pairs dodge the 8 rotating cones at their intercard, alternating with the\n-- gap 22.5deg to the left (facing the boss). H+M north (H1/M1 NE, H2/M2 NW), T+R south (MT/R1 SE, OT/R2 SW);\n-- tanks + melee near, healers + ranged far. Conduction Point: the 4 hit players go far, their partners near\n-- (take the Forked Fissures wild charge in front). Spot = the cone gap of the NEXT set next to your intercard.\nlocal m = data.m4_tr\nif not (m and m.dir) then return end\nlocal now = Now()\nif now - m.t > 4500 or (m.sets or 0) >= 7 then return end\nif not m.known then return end\nlocal BASE = {H1 = 3, M1 = 3, H2 = -3, M2 = -3, T1 = 1, R1 = 1, T2 = -1, R2 = -1}\nlocal b = BASE[slot]\nif not b then return end\nlocal base = b * math.pi / 4\nlocal NEAR, FAR = 9, 17\nlocal far = (slot:sub(1, 1) == \"H\" or slot:sub(1, 1) == \"R\")\nif m.cpT and now - m.cpT < 5000 and not (m.fissT and m.fissT > m.cpT) then\n  far = m.cp and m.cp[p.id] and true or false\nend\n-- gaps of the next cones sit at dir + 22.5 + k*45; take the one nearest base - 11.25 (base or 22.5 clockwise)\nlocal step = math.pi / 4\nlocal first = m.dir + math.pi / 8\nlocal mid = base - math.pi / 16\nlocal k = math.floor((mid - first) / step + 0.5)\nlocal g = first + k * step\nlocal r = far and FAR or NEAR\ngo(100 + r * math.sin(g), 100 + r * math.cos(g))\n",
							name = "[Draw] M4S - Transition cones + wild charge spot (2)",
							uuid = "ea80a943-5eb6-d309-98d4-2bf55d3457ed",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 349.9,
				name = "[Draw] M4S - Transition cones + wild charge spot (2)",
				timeRange = true,
				timelineIndex = 61,
				timerEndOffset = 19,
				timerStartOffset = -9,
				uuid = "ec9b2fb5-33cf-ec5c-94a7-172b5995f17a",
				version = 2,
			},
		},
	},
	[78] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "3545d76c-e95c-85c4-a9cb-32e179c5dce7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S p2a capture: Sabertail exaflare starts (38389, helpers, 8s cast, r6, step 6.5 every 0.7s),\n-- Wicked Special boss cast (38416 = center AOE -> sides safe, 38418 = sides AOE -> middle safe)\n-- and its helper rects (38417 width 20 / 38419 width 15, length 40). Dedupes (windows of entries can overlap).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38389 and sp ~= 38416 and sp ~= 38418 and sp ~= 38417 and sp ~= 38419 then return end\ndata.m4_p2a = data.m4_p2a or {}\nlocal m = data.m4_p2a\nlocal now = Now()\nlocal ct = tonumber(e.channelTimeMax) or 0\nif sp == 38416 or sp == 38418 then\n  if m.ws and now - m.ws.t < 3000 then return end\n  m.ws = {t = now, te = now + ((ct > 0) and ct or 5) * 1000 + 1000, sides = (sp == 38416)}\n  return\nend\nlocal id = e.entityID\nlocal ent = id and TensorCore.mGetEntity(id)\nlocal ps = ent and ent.pos\nif not ps then return end\nif sp == 38389 then\n  if not m.sab or now - m.sab.t > 20000 then m.sab = {t = now, lines = {}, seen = {}} end\n  local sb = m.sab\n  if sb.seen[id] then return end\n  sb.seen[id] = true\n  sb.last = now\n  sb.ex = nil; sb.spot = nil\n  sb.lines[#sb.lines + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, t0 = now + ((ct > 0) and ct or 8) * 1000}\n  return\nend\nif not m.wr or now - m.wr.t > 3000 then m.wr = {t = now, list = {}, seen = {}} end\nif m.wr.seen[id] then return end\nm.wr.seen[id] = true\nm.wr.list[#m.wr.list + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, hw = (sp == 38417) and 10 or 7.5}\n",
							name = "[Draw] M4S - Sabertail/Special capture",
							uuid = "0be61d52-67a5-5e86-8711-3eb1eec8fc96",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 426,
				name = "[Draw] M4S - Sabertail/Special capture",
				timeRange = true,
				timelineIndex = 78,
				timerEndOffset = 10,
				timerStartOffset = -16,
				uuid = "af90cfd5-8b60-1fb1-8aec-e625c0c506fb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal G1 = {T1 = true, H1 = true, M1 = true, R1 = true}\nlocal G2 = {T2 = true, H2 = true, M2 = true, R2 = true}\n-- M4S p2a: Sabertail exaflares + Wicked Blaze LP stacks. G1 stacks at the west edge, G2 at the east edge,\n-- in the gap the exaflares leave on that edge until the 4 stack hits are done (first explosion + 5s).\nlocal m = data.m4_p2a\nlocal sb = m and m.sab\nif not (sb and #sb.lines >= 8) then return end\nlocal now = Now()\nif now - sb.t > 16000 or now - (sb.last or sb.t) < 300 then return end\nlocal side = G1[slot] and -1 or (G2[slot] and 1) or nil\nif not side then return end\nlocal T0 = sb.lines[1].t0\nif now > T0 + 5000 then return end\nlocal E = sb.ex\nif not E then\n  E = {}\n  local q90 = math.pi / 2\n  for _, l in ipairs(sb.lines) do\n    local h = l.h\n    local q = math.floor(h / q90 + 0.5) * q90\n    if math.abs(h - q) < 0.2 then h = q end\n    local dx, dz = math.sin(h), math.cos(h)\n    local x, z = l.x, l.z\n    for k = 0, 9 do\n      if x < 79.5 or x > 120.5 or z < 149.5 or z > 180.5 then break end\n      E[#E + 1] = {x = x, z = z, t = l.t0 + k * 700}\n      x = x + dx * 6.5; z = z + dz * 6.5\n    end\n  end\n  sb.ex = E\nend\nsb.spot = sb.spot or {}\nlocal s = sb.spot[side]\nif s == nil then\n  local edge = 100 + side * 20\n  local best, bx, bz = 0.05, nil, nil\n  for i = 0, 7 do\n    local x = edge - side * (0.3 + i * 0.5)\n    for j = 0, 58 do\n      local z = 150.5 + j * 0.5\n      local mn = 99\n      for _, ex in ipairs(E) do\n        if ex.t <= T0 + 5000 then\n          local d = math.sqrt((x - ex.x) ^ 2 + (z - ex.z) ^ 2) - 6\n          if d < mn then mn = d; if mn - 0.02 * i <= best then break end end\n        end\n      end\n      local sc = mn - 0.02 * i\n      if mn > 0.05 and sc > best then best, bx, bz = sc, x, z end\n    end\n  end\n  s = bx and {x = bx, z = bz} or false\n  sb.spot[side] = s\nend\nif s then go(s.x, s.z) end\n",
							name = "[Draw] M4S - Sabertail LP stack spot",
							uuid = "6f1ab267-048d-8d8b-8074-bd1932b1a660",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 426,
				name = "[Draw] M4S - Sabertail LP stack spot",
				timeRange = true,
				timelineIndex = 78,
				timerEndOffset = 8,
				timerStartOffset = -14,
				uuid = "f35f8043-7cdd-9666-981b-9fff2e0eb5b5",
				version = 2,
			},
		},
	},
	[82] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "b07736e9-b0f5-ff20-815c-7f5ab904a3e1",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S p2a capture: Sabertail exaflare starts (38389, helpers, 8s cast, r6, step 6.5 every 0.7s),\n-- Wicked Special boss cast (38416 = center AOE -> sides safe, 38418 = sides AOE -> middle safe)\n-- and its helper rects (38417 width 20 / 38419 width 15, length 40). Dedupes (windows of entries can overlap).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38389 and sp ~= 38416 and sp ~= 38418 and sp ~= 38417 and sp ~= 38419 then return end\ndata.m4_p2a = data.m4_p2a or {}\nlocal m = data.m4_p2a\nlocal now = Now()\nlocal ct = tonumber(e.channelTimeMax) or 0\nif sp == 38416 or sp == 38418 then\n  if m.ws and now - m.ws.t < 3000 then return end\n  m.ws = {t = now, te = now + ((ct > 0) and ct or 5) * 1000 + 1000, sides = (sp == 38416)}\n  return\nend\nlocal id = e.entityID\nlocal ent = id and TensorCore.mGetEntity(id)\nlocal ps = ent and ent.pos\nif not ps then return end\nif sp == 38389 then\n  if not m.sab or now - m.sab.t > 20000 then m.sab = {t = now, lines = {}, seen = {}} end\n  local sb = m.sab\n  if sb.seen[id] then return end\n  sb.seen[id] = true\n  sb.last = now\n  sb.ex = nil; sb.spot = nil\n  sb.lines[#sb.lines + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, t0 = now + ((ct > 0) and ct or 8) * 1000}\n  return\nend\nif not m.wr or now - m.wr.t > 3000 then m.wr = {t = now, list = {}, seen = {}} end\nif m.wr.seen[id] then return end\nm.wr.seen[id] = true\nm.wr.list[#m.wr.list + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, hw = (sp == 38417) and 10 or 7.5}\n",
							name = "[Draw] M4S - Wicked Special capture (after exaflares)",
							uuid = "0fd15a4c-dbc7-a51d-8112-0c144a904a49",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 437.2,
				name = "[Draw] M4S - Wicked Special capture (after exaflares)",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "dceabb60-1b6f-58d1-acb3-eb404b7117ee",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal G1 = {T1 = true, H1 = true, M1 = true, R1 = true}\nlocal G2 = {T2 = true, H2 = true, M2 = true, R2 = true}\n-- M4S p2a: Wicked Special (after exaflares). 38416 flame sword = center unsafe -> sides (x 87.5 / 112.5);\n-- 38418 lightning = sides unsafe -> middle (x 97.5 / 102.5). Stay on your current half (group side if near x 100),\n-- keep your z. Checked against the helper rects when they were captured.\nlocal CIRCLE, DELAY = false, 0\nlocal m = data.m4_p2a\nlocal ws = m and m.ws\nif not ws then return end\nlocal now = Now()\nif now - ws.t > 12000 or now > ws.te + 500 or now - ws.t < DELAY then return end\nlocal side\nif math.abs(p.pos.x - 100) > 2 then side = (p.pos.x < 100) and -1 or 1\nelseif G1[slot] then side = -1 elseif G2[slot] then side = 1 else return end\nlocal rects = (m.wr and math.abs(m.wr.t - ws.t) < 3000 and #m.wr.list > 0) and m.wr.list or nil\nlocal function zfor(x, z)\n  if CIRCLE then\n    local dx, dz = x - 100, z - 165\n    if dx * dx + dz * dz > 13.5 * 13.5 then\n      local lim = 13.5 * 13.5 - dx * dx\n      if lim < 0 then return nil end\n      local zz = math.sqrt(lim)\n      z = 165 + ((dz < 0) and -zz or zz)\n    end\n    return z\n  end\n  return math.max(151, math.min(179, z))\nend\nlocal function safe(x, z)\n  if not rects then return true end\n  for _, r in ipairs(rects) do\n    local fx, fz = math.sin(r.h), math.cos(r.h)\n    local ddx, ddz = x - r.x, z - r.z\n    local al = ddx * fx + ddz * fz\n    local lat = math.abs(-ddx * fz + ddz * fx)\n    if al > -0.5 and al < 40.5 and lat < r.hw + 0.75 then return false end\n  end\n  return true\nend\nlocal px = 100 + side * (ws.sides and 12.5 or 2.5)\nlocal maxo = CIRCLE and 13 or 19.25\nfor k = 0, 30 do\n  local off = (k % 2 == 0) and (k / 2) * 0.5 or -((k + 1) / 2) * 0.5\n  local x = px + off\n  local o = side * (x - 100)\n  if o >= 0.75 and o <= maxo then\n    local z = zfor(x, p.pos.z)\n    if z and safe(x, z) then go(x, z); return end\n  end\nend\n",
							name = "[Draw] M4S - Wicked Special spot (after exaflares)",
							uuid = "d5846919-107a-1908-ab6e-4512384c417c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 437.2,
				name = "[Draw] M4S - Wicked Special spot (after exaflares)",
				timeRange = true,
				timelineIndex = 82,
				timerEndOffset = 4,
				timerStartOffset = -9,
				uuid = "6a1891a3-e1fe-2fd3-ab7c-8b7bac396bbe",
				version = 2,
			},
		},
	},
	[84] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "c12e267c-aad4-b765-a0cf-fa64c70a5008",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Mustard Bomb: boss cast 38430 (8+1s) starts the mechanic\nlocal e = eventArgs\nif not (e and e.spellID == 38430) then return end\ndata.m4_mb = data.m4_mb or {}\nlocal s = data.m4_mb.mb\n-- keep tethers captured just before the cast event (same mechanic), else start fresh\nif s and not s.first and not s.done and Now() - s.t < 3000 then s.cast = Now(); return end\ndata.m4_mb.mb = {t = Now(), cast = Now(), teth = {}, hit = {}}\n",
							name = "[Draw] M4S - Mustard Bomb 1 capture cast",
							uuid = "add3aab6-78f1-7493-bf05-27e1bee04f6a",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 453.1,
				name = "[Draw] M4S - Mustard Bomb 1 capture cast",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = 2,
				timerStartOffset = -14,
				uuid = "ba71e8c9-ed50-135c-842f-25605186927c",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Mustard Bomb: tether 283 (player <-> boss). Track who holds a tether until the first hit.\nlocal e = eventArgs\nif not e then return end\nif e.newTetherID ~= 283 and e.oldTetherID ~= 283 then return end\ndata.m4_mb = data.m4_mb or {}\nlocal s = data.m4_mb.mb\nif not s or s.done or Now() - s.t > 25000 then\n  s = {t = Now(), teth = {}, hit = {}}\n  data.m4_mb.mb = s\nend\nif s.first then return end\nlocal party = {}\nlocal L = TensorCore.getEntityGroupList(\"Party\")\nif type(L) == \"table\" then\n  for _, v in pairs(L) do\n    local id = (type(v) == \"table\") and v.id or v\n    if id then party[id] = true end\n  end\nend\nlocal src = e.sourceEntityID\nif e.newTetherID == 283 then\n  local h = (party[src] and src) or (party[e.newTargetID] and e.newTargetID)\n  if e.oldTetherID == 283 and party[e.oldTargetID] and e.oldTargetID ~= e.newTargetID then s.teth[e.oldTargetID] = nil end\n  if h then s.teth[h] = true end\nelse\n  local h = (party[src] and src) or (party[e.oldTargetID] and e.oldTargetID)\n  if h then s.teth[h] = nil end\nend\n",
							name = "[Draw] M4S - Mustard Bomb 1 capture tethers",
							uuid = "33d00ed3-99cd-66d2-b8dc-3b790ab48ba0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 453.1,
				name = "[Draw] M4S - Mustard Bomb 1 capture tethers",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = 2,
				timerStartOffset = -14,
				uuid = "ea38fc36-98b9-5136-82ac-50d0334e46e3",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Mustard Bomb: 38431 tether hit (tanks get the Mustard Bomb debuff 4007), 38432 Kindling Cauldron spreads,\n-- 38433 second explosion (mechanic done). Anyone hit by 38431/38432 cannot take the debuff.\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38431 and sp ~= 38432 and sp ~= 38433 then return end\nlocal s = data.m4_mb and data.m4_mb.mb\nif not s or Now() - s.t > 25000 then return end\nif sp == 38433 then s.done = Now(); return end\ns.first = s.first or Now()\ns.teth = {}\nlocal ht = e.hitTargets or {}\nfor _, id in ipairs(ht) do s.hit[id] = true end\nif #ht == 0 and e.targetID and e.targetID > 0 then s.hit[e.targetID] = true end\n",
							name = "[Draw] M4S - Mustard Bomb 1 capture hits",
							uuid = "7fb20ff9-36e7-ba3e-b7a7-723a16ecad45",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 453.1,
				name = "[Draw] M4S - Mustard Bomb 1 capture hits",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = 15,
				timerStartOffset = -3,
				uuid = "c55bfea1-6fe1-6c2c-9ea5-59774e5cb09d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Mustard Bomb (strategy 45.png): row 1 (z155) M1 85 / MT 95 / OT 105 / M2 115, row 2 (z165) R1 85 / H1 95 /\n-- H2 105 / R2 115. Tethers: non-tanks holding one wait near the middle, tanks run to grab them. After the first hit the\n-- tanks (debuff 4007) pass it: MT to the leftmost safe (unhit) player, OT to the rightmost, then return to their spot.\nlocal s = data.m4_mb and data.m4_mb.mb\nif not s or s.done or Now() - s.t > 25000 then return end\nlocal SP = {M1 = {85, 155}, T1 = {95, 155}, T2 = {105, 155}, M2 = {115, 155},\n            R1 = {85, 165}, H1 = {95, 165}, H2 = {105, 165}, R2 = {115, 165}}\nlocal my = SP[slot]\nif not my then return end\nlocal tank = (slot == \"T1\" or slot == \"T2\")\nlocal TANKJOB = {[1] = true, [3] = true, [19] = true, [21] = true, [32] = true, [37] = true}\nif not s.first then\n  if s.cast and Now() - s.cast < 6500 then\n    if not tank and s.teth[p.id] then go(100, 160); return end\n    if tank and not s.teth[p.id] then\n      local best\n      for id in pairs(s.teth) do\n        local en = TensorCore.mGetEntity(id)\n        if en and en.pos and not TANKJOB[en.job or 0] then\n          if not best or (slot == \"T1\" and en.pos.x < best.pos.x) or (slot == \"T2\" and en.pos.x > best.pos.x) then best = en end\n        end\n      end\n      if best then go(best.pos.x, best.pos.z); return end\n    end\n  end\n  go(my[1], my[2])\n  return\nend\nif tank and TensorCore.hasBuff(p, 4007) then\n  local n = 0\n  for _ in pairs(s.hit) do n = n + 1 end\n  if n >= 6 then\n    local L = TensorCore.getEntityGroupList(\"Party\")\n    local best\n    if type(L) == \"table\" then\n      for _, v in pairs(L) do\n        local en = (type(v) == \"table\") and v or TensorCore.mGetEntity(v)\n        if en and en.id and en.id ~= p.id and en.pos and not s.hit[en.id] and not TensorCore.hasBuff(en, 4007) then\n          if not best or (slot == \"T1\" and en.pos.x < best.pos.x) or (slot == \"T2\" and en.pos.x > best.pos.x) then best = en end\n        end\n      end\n    end\n    if best then go(best.pos.x, best.pos.z); return end\n  end\nend\ngo(my[1], my[2])\n",
							name = "[Draw] M4S - Mustard Bomb 1 spots",
							uuid = "738ae440-1b39-b66d-adc3-96f58135112d",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 453.1,
				name = "[Draw] M4S - Mustard Bomb 1 spots",
				timeRange = true,
				timelineIndex = 84,
				timerEndOffset = 13,
				timerStartOffset = -11,
				uuid = "42c20a8c-7d9e-74a7-808a-45135935efc1",
				version = 2,
			},
		},
	},
	[87] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "68362b22-b4c2-885e-8475-b2a7bab95db0",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Aetherial Conversion (stored, 38402 fire L->R / 38403 water L->R / 38404 fire R->L / 38405 water R->L) and the\n-- Tail Thrust cast that executes it (38406 fire L / 38407 water L / 38408 fire R / 38409 water R, 5+1s)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nlocal CONV = {[38402] = {\"fire\", -1}, [38403] = {\"water\", -1}, [38404] = {\"fire\", 1}, [38405] = {\"water\", 1}}\nlocal TT = {[38406] = {\"fire\", -1}, [38407] = {\"water\", -1}, [38408] = {\"fire\", 1}, [38409] = {\"water\", 1}}\nlocal c, t = CONV[sp], TT[sp]\nif not (c or t) then return end\ndata.m4_mb = data.m4_mb or {}\nlocal M = data.m4_mb\nif c then M.conv = {t = Now(), k = c[1], s = c[2]}; return end\nif M.ac and Now() - M.ac.t < 3000 then return end\nlocal a = {t = Now(), k = t[1], s = t[2], n = 0}\nlocal cv = M.conv\nif cv and Now() - cv.t < 120000 and (cv.k ~= a.k or cv.s ~= a.s) then a.bad = true end\nM.conv = nil\nM.ac = a\n",
							name = "[Draw] M4S - Tail Thrust 1 capture casts",
							uuid = "ec166c7a-28d3-25c4-9d9c-45f972c6c754",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 479.8,
				name = "[Draw] M4S - Tail Thrust 1 capture casts",
				timeRange = true,
				timelineIndex = 87,
				timerEndOffset = 2,
				timerStartOffset = -20,
				uuid = "0b655202-9f3b-c551-b86e-c2b45dfbe7eb",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Tail Thrust hits: 38414 Tail Thrust (fire circle r18) / 38415 Switch of Tides (water knockback 25)\nlocal e = eventArgs\nif not e then return end\nif e.spellID ~= 38414 and e.spellID ~= 38415 then return end\nlocal a = data.m4_mb and data.m4_mb.ac\nif not a or Now() - a.t > 20000 then return end\nif a.last and Now() - a.last < 1500 then return end\na.last = Now()\na.n = (a.n or 0) + 1\n",
							name = "[Draw] M4S - Tail Thrust 1 capture hits",
							uuid = "7a6d8c91-e420-6ee9-b8f1-70c50bed5f33",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 479.8,
				name = "[Draw] M4S - Tail Thrust 1 capture hits",
				timeRange = true,
				timelineIndex = 87,
				timerEndOffset = 9,
				timerStartOffset = -3,
				uuid = "bf3399a8-86ad-5e13-b36f-7563e0fc3e83",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Aetherial Conversion / Tail Thrust: two hits at (100 -/+ 10, 165), first on the side the conversion names.\n-- Fire = r18 circle: dodge along the north edge (start opposite the first circle, then cross). Water = knockback 25\n-- from the red dot: stand just inside the first dot (pushed across), then just inside the second dot.\nlocal a = data.m4_mb and data.m4_mb.ac\nif not a or a.bad or Now() - a.t > 16000 or (a.n or 0) >= 2 then return end\nlocal s = a.s\nif s ~= 1 and s ~= -1 then return end\nif a.k == \"fire\" then\n  if a.n == 0 then go(100 - 6 * s, 151) else go(100 + 6 * s, 151) end\nelseif a.k == \"water\" then\n  if a.n == 0 then go(100 + 9 * s, 165) else go(100 - 9 * s, 165) end\nend\n",
							name = "[Draw] M4S - Tail Thrust 1 fire/water spot",
							uuid = "3e19a925-c86f-2d6e-a5d3-4bd9321307fa",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 479.8,
				name = "[Draw] M4S - Tail Thrust 1 fire/water spot",
				timeRange = true,
				timelineIndex = 87,
				timerEndOffset = 8,
				timerStartOffset = -10,
				uuid = "e006544c-5f2d-2c51-8063-7625c305de10",
				version = 2,
			},
		},
	},
	[90] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "37995cde-bb61-10ca-8cf0-8102117245c0",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Twilight Sabbath: replica cleave animations (PlayActionTimeline 0x11D6 1st right / 0x11D7 2nd right /\n-- 0x11D8 1st left / 0x11D9 2nd left). Stores each replica's 180-degree cleave half-plane.\nlocal e = eventArgs\nif not e then return end\nlocal a = e.newAnimID\nif not (a == 4566 or a == 4567 or a == 4568 or a == 4569) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nif not ps then return end\ndata.m4_sab = data.m4_sab or {}\nlocal S = data.m4_sab\nlocal now = Now()\nif not S.tw or now - S.tw.t > 25000 then S.tw = {t = now, sets = {{}, {}}, casts = 0, last = {}} end\nlocal set = (a == 4566 or a == 4568) and 1 or 2\nlocal off = (a == 4566 or a == 4567) and -math.pi / 2 or math.pi / 2\nlocal L = S.tw.sets[set]\nfor _, c in ipairs(L) do if c.id == e.entityID then return end end\nL[#L + 1] = {id = e.entityID, x = ps.x, z = ps.z, h = (ps.h or 0) + off}\n",
							name = "[Draw] M4S - Twilight Sabbath capture (replica cleaves)",
							uuid = "c842b25a-9a78-8ea5-b33c-1d6cc97057da",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 23,
				loop = true,
				mechanicTime = 507,
				name = "[Draw] M4S - Twilight Sabbath capture (replica cleaves)",
				timeRange = true,
				timelineIndex = 90,
				timerEndOffset = 12,
				timerStartOffset = -5,
				uuid = "9b03f37d-8f24-436d-91b6-4cd097d450bf",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Twilight Sabbath: puddles center -> 1st safe quadrant -> 2nd safe quadrant (+ Wicked Special sides/middle)\nlocal S = data.m4_sab\nlocal T = S and S.tw\nif not T then return end\nlocal now = Now()\nlocal age = now - T.t\nif age < 0 or age > 18500 then return end\nlocal casts = T.casts or 0\nif casts >= 4 then return end\nlocal CX, CZ = 100, 165\nS.Q = S.Q or {{-1, -1}, {1, -1}, {-1, 1}, {1, 1}}\nlocal Q = S.Q\nlocal function hit(set, x, z, margin)\n  for _, c in ipairs(set) do\n    if (x - c.x) * math.sin(c.h) + (z - c.z) * math.cos(c.h) > -margin then return true end\n  end\n  return false\nend\nlocal function safeQ(set)\n  if not set or #set < 2 then return nil end\n  local found\n  for _, q in ipairs(Q) do\n    if not hit(set, CX + q[1] * 9.5, CZ + q[2] * 9, 0.5) then\n      if found then return nil end\n      found = q\n    end\n  end\n  return found\nend\n-- 1) drop puddles in the center\nif not (T.bait or age > 6500) then go(CX, CZ) return end\n-- 2) first safe quadrant (outside the r10 puddles) until cleave 1 and the puddles are done\nlocal c1 = casts >= 2 or age > 8800\nlocal fireDone = T.fire or age > 10000\nif not (c1 and fireDone) then\n  local q = safeQ(T.sets[1])\n  if q then go(CX + q[1] * 9.5, CZ + q[2] * 9) end\n  return\nend\n-- 3) second safe quadrant, refined by Wicked Special (center cleaved -> sides, sides cleaved -> middle)\nlocal q = safeQ(T.sets[2])\nif not q then return end\nlocal x, z = CX + q[1] * 9.5, CZ + q[2] * 9\nlocal W = S.ws\nif W and now - W.t < 10000 then\n  if W.sides then x, z = CX + q[1] * 12, CZ + q[2] * 7 else x, z = CX + q[1] * 3, CZ + q[2] * 11 end\n  if hit(T.sets[2], x, z, 1) then return end\nend\ngo(x, z)\n",
							name = "[Draw] M4S - Twilight Sabbath - your spot",
							uuid = "a4cb3294-af77-a8ed-848e-0cb5b70bd44e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 507,
				name = "[Draw] M4S - Twilight Sabbath - your spot",
				timeRange = true,
				timelineIndex = 90,
				timerEndOffset = 21,
				timerStartOffset = 1,
				uuid = "7ee053d0-08d0-a084-bd25-e9e52d14cb9a",
				version = 2,
			},
		},
	},
	[92] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "fca5fe50-35d6-78a8-a43e-4a4df5461135",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Twilight Sabbath: Wicked Fire bait (38448), puddles resolve (38449), replica Sidewise Spark (38441/38442)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif not (sp == 38448 or sp == 38449 or sp == 38441 or sp == 38442) then return end\nlocal S = data.m4_sab\nlocal T = S and S.tw\nlocal now = Now()\nif not T or now - T.t > 25000 then return end\nif sp == 38448 then T.bait = T.bait or now; return end\nif sp == 38449 then T.fire = T.fire or now; return end\nT.last = T.last or {}\nlocal id = e.entityID or 0\nif T.last[id] and now - T.last[id] < 3000 then return end\nT.last[id] = now\nT.casts = (T.casts or 0) + 1\n",
							name = "[Draw] M4S - Twilight Sabbath capture (bait / puddles / sparks)",
							uuid = "0e81da7f-dd28-7d6c-9db4-2f2ffdd7cd15",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 518.1,
				name = "[Draw] M4S - Twilight Sabbath capture (bait / puddles / sparks)",
				timeRange = true,
				timelineIndex = 92,
				timerEndOffset = 11,
				timerStartOffset = -6,
				uuid = "f97b3f9f-e375-0a40-8039-7130aec4cbf2",
				version = 2,
			},
		},
	},
	[93] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "0dc7581a-af6b-14b8-b811-a12e0b36ee71",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S p2a capture: Sabertail exaflare starts (38389, helpers, 8s cast, r6, step 6.5 every 0.7s),\n-- Wicked Special boss cast (38416 = center AOE -> sides safe, 38418 = sides AOE -> middle safe)\n-- and its helper rects (38417 width 20 / 38419 width 15, length 40). Dedupes (windows of entries can overlap).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38389 and sp ~= 38416 and sp ~= 38418 and sp ~= 38417 and sp ~= 38419 then return end\ndata.m4_p2a = data.m4_p2a or {}\nlocal m = data.m4_p2a\nlocal now = Now()\nlocal ct = tonumber(e.channelTimeMax) or 0\nif sp == 38416 or sp == 38418 then\n  if m.ws and now - m.ws.t < 3000 then return end\n  m.ws = {t = now, te = now + ((ct > 0) and ct or 5) * 1000 + 1000, sides = (sp == 38416)}\n  return\nend\nlocal id = e.entityID\nlocal ent = id and TensorCore.mGetEntity(id)\nlocal ps = ent and ent.pos\nif not ps then return end\nif sp == 38389 then\n  if not m.sab or now - m.sab.t > 20000 then m.sab = {t = now, lines = {}, seen = {}} end\n  local sb = m.sab\n  if sb.seen[id] then return end\n  sb.seen[id] = true\n  sb.last = now\n  sb.ex = nil; sb.spot = nil\n  sb.lines[#sb.lines + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, t0 = now + ((ct > 0) and ct or 8) * 1000}\n  return\nend\nif not m.wr or now - m.wr.t > 3000 then m.wr = {t = now, list = {}, seen = {}} end\nif m.wr.seen[id] then return end\nm.wr.seen[id] = true\nm.wr.list[#m.wr.list + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, hw = (sp == 38417) and 10 or 7.5}\n",
							name = "[Draw] M4S - Wicked Special capture (Twilight Sabbath)",
							uuid = "6647f9ac-2be2-58ea-b470-7ad73b1aae38",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 3,
				loop = true,
				mechanicTime = 526.2,
				name = "[Draw] M4S - Wicked Special capture (Twilight Sabbath)",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "6d121feb-b887-6af6-a2ad-0a575d2d37a2",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal G1 = {T1 = true, H1 = true, M1 = true, R1 = true}\nlocal G2 = {T2 = true, H2 = true, M2 = true, R2 = true}\n-- M4S p2a: Wicked Special (Twilight Sabbath). 38416 flame sword = center unsafe -> sides (x 87.5 / 112.5);\n-- 38418 lightning = sides unsafe -> middle (x 97.5 / 102.5). Stay on your current half (group side if near x 100),\n-- keep your z. Checked against the helper rects when they were captured.\nlocal CIRCLE, DELAY = true, 0\nlocal m = data.m4_p2a\nlocal ws = m and m.ws\nif not ws then return end\nlocal now = Now()\nif now - ws.t > 12000 or now > ws.te + 500 or now - ws.t < DELAY then return end\n-- Twilight: item 12 (data.m4_sab, sab_tw_draw) already draws quadrant 2 + this Wicked Special;\n-- defer to it whenever its Twilight state exists so two different arrows never show at once.\nlocal TW = data.m4_sab and data.m4_sab.tw\nif TW and now - TW.t < 25000 then return end\nlocal side\nif math.abs(p.pos.x - 100) > 2 then side = (p.pos.x < 100) and -1 or 1\nelseif G1[slot] then side = -1 elseif G2[slot] then side = 1 else return end\nlocal rects = (m.wr and math.abs(m.wr.t - ws.t) < 3000 and #m.wr.list > 0) and m.wr.list or nil\nlocal function zfor(x, z)\n  if CIRCLE then\n    local dx, dz = x - 100, z - 165\n    if dx * dx + dz * dz > 13.5 * 13.5 then\n      local lim = 13.5 * 13.5 - dx * dx\n      if lim < 0 then return nil end\n      local zz = math.sqrt(lim)\n      z = 165 + ((dz < 0) and -zz or zz)\n    end\n    return z\n  end\n  return math.max(151, math.min(179, z))\nend\nlocal function safe(x, z)\n  if not rects then return true end\n  for _, r in ipairs(rects) do\n    local fx, fz = math.sin(r.h), math.cos(r.h)\n    local ddx, ddz = x - r.x, z - r.z\n    local al = ddx * fx + ddz * fz\n    local lat = math.abs(-ddx * fz + ddz * fx)\n    if al > -0.5 and al < 40.5 and lat < r.hw + 0.75 then return false end\n  end\n  return true\nend\nlocal px = 100 + side * (ws.sides and 12.5 or 2.5)\nlocal maxo = CIRCLE and 13 or 19.25\nfor k = 0, 30 do\n  local off = (k % 2 == 0) and (k / 2) * 0.5 or -((k + 1) / 2) * 0.5\n  local x = px + off\n  local o = side * (x - 100)\n  if o >= 0.75 and o <= maxo then\n    local z = zfor(x, p.pos.z)\n    if z and safe(x, z) then go(x, z); return end\n  end\nend\n",
							name = "[Draw] M4S - Wicked Special spot (Twilight Sabbath)",
							uuid = "441c59c9-5183-3f93-b2e1-95d5f662dd52",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				enabled = false,
				eventType = 12,
				loop = true,
				mechanicTime = 526.2,
				name = "[Draw] M4S - Wicked Special spot (Twilight Sabbath)",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 4,
				timerStartOffset = -9,
				uuid = "15c7a74e-be6f-3dc6-856d-aa6821e81701",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Twilight Sabbath: Wicked Special cast start. 38416 = center cleaved (go sides), 38418 = sides cleaved (go middle)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38416 and sp ~= 38418 then return end\ndata.m4_sab = data.m4_sab or {}\ndata.m4_sab.ws = {t = Now(), sides = (sp == 38416)}\n",
							name = "[Draw] M4S - Twilight Sabbath capture (Wicked Special)",
							uuid = "a89b7f63-aa04-3780-849e-c138e55f6e34",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 526.2,
				name = "[Draw] M4S - Twilight Sabbath capture (Wicked Special)",
				timeRange = true,
				timelineIndex = 93,
				timerEndOffset = 1,
				timerStartOffset = -10,
				uuid = "5ec8a35d-19a1-6eb9-a2d0-ddd3438ac97d",
				version = 2,
			},
		},
	},
	[94] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "f727731c-3fe2-5022-9b2f-a53f1defffd7",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Midnight Sabbath: replica animations (PlayActionTimeline 0x11D1 gun 1st / 0x11D2 gun 2nd /\n-- 0x11D3 wings 1st / 0x11D4 wings 2nd)\nlocal e = eventArgs\nif not e then return end\nlocal a = e.newAnimID\nif not (a == 4561 or a == 4562 or a == 4563 or a == 4564) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nlocal ps = ent and ent.pos\nif not ps then return end\ndata.m4_sab = data.m4_sab or {}\nlocal S = data.m4_sab\nlocal now = Now()\nif not S.mn or now - S.mn.t > 25000 then S.mn = {t = now, adds = {}, casts = 0, last = {}} end\nS.mn.adds[e.entityID] = {x = ps.x, z = ps.z, set = (a == 4561 or a == 4563) and 1 or 2, wings = (a == 4563 or a == 4564)}\n",
							name = "[Draw] M4S - Midnight Sabbath capture (gun / wings adds)",
							uuid = "8f224dd9-15bb-d7bc-b159-9caba2a336c8",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 23,
				loop = true,
				mechanicTime = 536.4,
				name = "[Draw] M4S - Midnight Sabbath capture (gun / wings adds)",
				timeRange = true,
				timelineIndex = 94,
				timerEndOffset = 9,
				timerStartOffset = -3,
				uuid = "166ac85c-f275-1a4f-869f-3262edcde017",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Midnight Sabbath: 38443 Concentrated Burst (pairs -> spread) / 38444 Scattered Burst (spread -> pairs)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38443 and sp ~= 38444 then return end\ndata.m4_sab = data.m4_sab or {}\nlocal S = data.m4_sab\nlocal now = Now()\nif not S.mn or now - S.mn.t > 25000 then S.mn = {t = now, adds = {}, casts = 0, last = {}} end\nS.mn.burst = {t = now, conc = (sp == 38443)}\n",
							name = "[Draw] M4S - Midnight Sabbath capture (Concentrated / Scattered Burst)",
							uuid = "84a12332-0ee2-164d-9d41-b04a4dca9d40",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 536.4,
				name = "[Draw] M4S - Midnight Sabbath capture (Concentrated / Scattered Burst)",
				timeRange = true,
				timelineIndex = 94,
				timerEndOffset = 9,
				timerStartOffset = -2,
				uuid = "ad579410-d46d-5f69-adbf-759a4beefa90",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Midnight Sabbath: wings = stand under that add, gun = go to the other adds. Pairs at intercards\n-- (T1+M1 NW, T2+M2 NE, H1+R1 SW, H2+R2 SE), rotated CCW to the cardinals (W, N, S, E) when cardinals are safe.\n-- Spread: supports left, DPS right while facing center.\nlocal S = data.m4_sab\nlocal M = S and S.mn\nif not (M and M.burst and M.adds) then return end\nlocal now = Now()\nlocal bt = now - M.burst.t\nlocal casts = M.casts or 0\nif bt < 0 or bt > 12500 or casts >= 8 then return end\nlocal phase = (casts >= 4 or bt > 7800) and 2 or 1\nlocal CX, CZ = 100, 165\nlocal function isCard(x, z)\n  local ax, az = math.abs(x - CX), math.abs(z - CZ)\n  return math.min(ax, az) < 0.414 * math.max(ax, az)\nend\n-- group (cardinal/intercard) of the set-1 adds and the gun/wings type of this phase's adds\nlocal g1, w, n1, nk = nil, nil, 0, 0\nfor _, a in pairs(M.adds) do\n  if a.set == 1 then\n    local c = isCard(a.x, a.z)\n    if g1 == nil then g1 = c elseif g1 ~= c then return end\n    n1 = n1 + 1\n  end\n  if a.set == phase then\n    if w == nil then w = a.wings elseif w ~= a.wings then return end\n    nk = nk + 1\n  end\nend\nif g1 == nil or w == nil or n1 < 2 or nk < 2 then return end\nlocal grp = g1\nif phase == 2 then grp = not g1 end\nlocal safeCard = grp\nif not w then safeCard = not grp end\nS.IC = S.IC or {T1 = {-1, -1}, M1 = {-1, -1}, T2 = {1, -1}, M2 = {1, -1}, H1 = {-1, 1}, R1 = {-1, 1}, H2 = {1, 1}, R2 = {1, 1}}\nS.CA = S.CA or {T1 = {-1, 0}, M1 = {-1, 0}, T2 = {0, -1}, M2 = {0, -1}, H1 = {0, 1}, R1 = {0, 1}, H2 = {1, 0}, R2 = {1, 0}}\nlocal IC, CA = S.IC, S.CA\nlocal d = (safeCard and CA or IC)[slot]\nif not d then return end\nlocal len = math.sqrt(d[1] * d[1] + d[2] * d[2])\nlocal ux, uz = d[1] / len, d[2] / len\n-- radius from the add in that direction (stay ~2y inside it, max 13.5)\nlocal r = 13\nfor _, a in pairs(M.adds) do\n  local dx, dz = a.x - CX, a.z - CZ\n  local R = math.sqrt(dx * dx + dz * dz)\n  if R > 1 and (dx * ux + dz * uz) / R > 0.95 then r = math.max(8, math.min(R - 2, 13.5)) end\nend\nlocal spread = (M.burst.conc and phase == 2) or ((not M.burst.conc) and phase == 1)\nlocal x, z = CX + ux * r, CZ + uz * r\nif spread then\n  local sup = (slot == \"T1\" or slot == \"T2\" or slot == \"H1\" or slot == \"H2\")\n  local off = sup and 3 or -3\n  x, z = x - uz * off, z + ux * off\nend\ngo(x, z)\n",
							name = "[Draw] M4S - Midnight Sabbath - your spot",
							uuid = "77ac4f6a-1ab0-2fa4-9821-7d688fc625b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 536.4,
				name = "[Draw] M4S - Midnight Sabbath - your spot",
				timeRange = true,
				timelineIndex = 94,
				timerEndOffset = 20,
				timerStartOffset = 3,
				uuid = "d67dec15-7b73-5360-9a6a-b9a559d93728",
				version = 2,
			},
		},
	},
	[95] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "8ef54ca6-ef38-630f-82da-4cfa3fa0ddd8",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Midnight Sabbath: replica resolves (38436 Wicked Cannon / 38439 Thundering), 4 per set\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38436 and sp ~= 38439 then return end\nlocal S = data.m4_sab\nlocal M = S and S.mn\nlocal now = Now()\nif not M or now - M.t > 25000 then return end\nM.last = M.last or {}\nlocal id = e.entityID or 0\nif M.last[id] and now - M.last[id] < 2500 then return end\nM.last[id] = now\nM.casts = (M.casts or 0) + 1\n",
							name = "[Draw] M4S - Midnight Sabbath capture (add resolves)",
							uuid = "ce86d150-648c-5926-8167-f4d73fdeb81f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 547.5,
				name = "[Draw] M4S - Midnight Sabbath capture (add resolves)",
				timeRange = true,
				timelineIndex = 95,
				timerEndOffset = 8,
				timerStartOffset = -4,
				uuid = "1c68a305-79a0-a7d9-9f3e-12d4fac8c8d2",
				version = 2,
			},
		},
	},
	[97] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "8d8065b9-3a29-d74c-9c45-cd664cb2f8e8",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S p2a capture: Sabertail exaflare starts (38389, helpers, 8s cast, r6, step 6.5 every 0.7s),\n-- Wicked Special boss cast (38416 = center AOE -> sides safe, 38418 = sides AOE -> middle safe)\n-- and its helper rects (38417 width 20 / 38419 width 15, length 40). Dedupes (windows of entries can overlap).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38389 and sp ~= 38416 and sp ~= 38418 and sp ~= 38417 and sp ~= 38419 then return end\ndata.m4_p2a = data.m4_p2a or {}\nlocal m = data.m4_p2a\nlocal now = Now()\nlocal ct = tonumber(e.channelTimeMax) or 0\nif sp == 38416 or sp == 38418 then\n  if m.ws and now - m.ws.t < 3000 then return end\n  m.ws = {t = now, te = now + ((ct > 0) and ct or 5) * 1000 + 1000, sides = (sp == 38416)}\n  return\nend\nlocal id = e.entityID\nlocal ent = id and TensorCore.mGetEntity(id)\nlocal ps = ent and ent.pos\nif not ps then return end\nif sp == 38389 then\n  if not m.sab or now - m.sab.t > 20000 then m.sab = {t = now, lines = {}, seen = {}} end\n  local sb = m.sab\n  if sb.seen[id] then return end\n  sb.seen[id] = true\n  sb.last = now\n  sb.ex = nil; sb.spot = nil\n  sb.lines[#sb.lines + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, t0 = now + ((ct > 0) and ct or 8) * 1000}\n  return\nend\nif not m.wr or now - m.wr.t > 3000 then m.wr = {t = now, list = {}, seen = {}} end\nif m.wr.seen[id] then return end\nm.wr.seen[id] = true\nm.wr.list[#m.wr.list + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, hw = (sp == 38417) and 10 or 7.5}\n",
							name = "[Draw] M4S - Wicked Special capture (Midnight Sabbath)",
							uuid = "3e1aa629-286e-621d-b19f-92423fb569cd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 556.5,
				name = "[Draw] M4S - Wicked Special capture (Midnight Sabbath)",
				timeRange = true,
				timelineIndex = 97,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "d1444c21-2e16-3b8e-9bf6-7d6ed9d10942",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal G1 = {T1 = true, H1 = true, M1 = true, R1 = true}\nlocal G2 = {T2 = true, H2 = true, M2 = true, R2 = true}\n-- M4S p2a: Wicked Special (Midnight Sabbath). 38416 flame sword = center unsafe -> sides (x 87.5 / 112.5);\n-- 38418 lightning = sides unsafe -> middle (x 97.5 / 102.5). Stay on your current half (group side if near x 100),\n-- keep your z. Checked against the helper rects when they were captured.\nlocal CIRCLE, DELAY = true, 1500\nlocal m = data.m4_p2a\nlocal ws = m and m.ws\nif not ws then return end\nlocal now = Now()\nif now - ws.t > 12000 or now > ws.te + 500 or now - ws.t < DELAY then return end\nlocal side\nif math.abs(p.pos.x - 100) > 2 then side = (p.pos.x < 100) and -1 or 1\nelseif G1[slot] then side = -1 elseif G2[slot] then side = 1 else return end\nlocal rects = (m.wr and math.abs(m.wr.t - ws.t) < 3000 and #m.wr.list > 0) and m.wr.list or nil\nlocal function zfor(x, z)\n  if CIRCLE then\n    local dx, dz = x - 100, z - 165\n    if dx * dx + dz * dz > 13.5 * 13.5 then\n      local lim = 13.5 * 13.5 - dx * dx\n      if lim < 0 then return nil end\n      local zz = math.sqrt(lim)\n      z = 165 + ((dz < 0) and -zz or zz)\n    end\n    return z\n  end\n  return math.max(151, math.min(179, z))\nend\nlocal function safe(x, z)\n  if not rects then return true end\n  for _, r in ipairs(rects) do\n    local fx, fz = math.sin(r.h), math.cos(r.h)\n    local ddx, ddz = x - r.x, z - r.z\n    local al = ddx * fx + ddz * fz\n    local lat = math.abs(-ddx * fz + ddz * fx)\n    if al > -0.5 and al < 40.5 and lat < r.hw + 0.75 then return false end\n  end\n  return true\nend\nlocal px = 100 + side * (ws.sides and 12.5 or 2.5)\nlocal maxo = CIRCLE and 13 or 19.25\nfor k = 0, 30 do\n  local off = (k % 2 == 0) and (k / 2) * 0.5 or -((k + 1) / 2) * 0.5\n  local x = px + off\n  local o = side * (x - 100)\n  if o >= 0.75 and o <= maxo then\n    local z = zfor(x, p.pos.z)\n    if z and safe(x, z) then go(x, z); return end\n  end\nend\n",
							name = "[Draw] M4S - Wicked Special spot (Midnight Sabbath)",
							uuid = "a0677b10-d84b-0c4e-a0ab-1fc7b56eca8b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 556.5,
				name = "[Draw] M4S - Wicked Special spot (Midnight Sabbath)",
				timeRange = true,
				timelineIndex = 97,
				timerEndOffset = 4,
				timerStartOffset = -9,
				uuid = "b65f4513-7f55-23fa-a513-37a27247e749",
				version = 2,
			},
		},
	},
	[99] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "6234ae28-2428-3d59-b0bc-45364c583ef9",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Raining Swords: SerpentsTongue swords (contentid 17327 = 0x43AF) spawn\nlocal e = eventArgs\nif not (e and e.entityContentID == 17327) then return end\nlocal function M()\n  local m = data.m4_cl\n  if not m or not m.t or Now() - m.t > 90000 then\n    m = {t = Now(), sw = {}, tc = {L = 0, R = 0}, sets = {L = {}, R = {}}, ex = {L = 0, R = 0}, lastT = {}}\n    data.m4_cl = m\n  end\n  return m\nend\nlocal m = M()\nm.sw[e.entityID] = true\n",
							name = "[Draw] M4S - Raining Swords capture (sword spawn)",
							uuid = "ca84602b-b369-0adc-a2a7-93f427447872",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 5,
				loop = true,
				mechanicTime = 583.9,
				name = "[Draw] M4S - Raining Swords capture (sword spawn)",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 55,
				timerStartOffset = -20,
				uuid = "108d297b-c9dc-9d4f-bce4-dacbb2d2c805",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Raining Swords: tower casts (38423, cast by each of the 8 swords)\nlocal e = eventArgs\nif not (e and e.spellID == 38423) then return end\nlocal function M()\n  local m = data.m4_cl\n  if not m or not m.t or Now() - m.t > 90000 then\n    m = {t = Now(), sw = {}, tc = {L = 0, R = 0}, sets = {L = {}, R = {}}, ex = {L = 0, R = 0}, lastT = {}}\n    data.m4_cl = m\n  end\n  return m\nend\nlocal m = M()\nm.sw[e.entityID] = true\n",
							name = "[Draw] M4S - Raining Swords capture (tower casts)",
							uuid = "bc03788f-0d07-63f9-a460-10dd566b77cd",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 583.9,
				name = "[Draw] M4S - Raining Swords capture (tower casts)",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 55,
				timerStartOffset = -20,
				uuid = "9d3e3ad5-1868-b3b5-91fa-1cd279cd8963",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Raining Swords / Chain Lightning: towers resolve (38423), lightning explosions (38426 first / 38427 rest)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38423 and sp ~= 38426 and sp ~= 38427 then return end\nlocal function M()\n  local m = data.m4_cl\n  if not m or not m.t or Now() - m.t > 90000 then\n    m = {t = Now(), sw = {}, tc = {L = 0, R = 0}, sets = {L = {}, R = {}}, ex = {L = 0, R = 0}, lastT = {}}\n    data.m4_cl = m\n  end\n  return m\nend\nlocal m = M()\nif sp == 38423 then\n  m.sw[e.entityID] = true\n  m.towDone = Now()\n  return\nend\nlocal x = e.castPosX\nif not x or x == 0 then\n  local en = TensorCore.mGetEntity(e.entityID)\n  x = en and en.pos and en.pos.x\nend\nif not x or math.abs(x - 100) < 1 then m.exUnk = (m.exUnk or 0) + 1; return end\nlocal side = x < 100 and \"L\" or \"R\"\nm.ex[side] = m.ex[side] + 1\n",
							name = "[Draw] M4S - Raining Swords/Chain Lightning capture (towers + explosions)",
							uuid = "bb53a502-daff-b698-abf4-65448154b394",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 583.9,
				name = "[Draw] M4S - Raining Swords/Chain Lightning capture (towers + explosions)",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 55,
				timerStartOffset = -20,
				uuid = "0651c32e-d013-2051-92f4-30b5a8c6d83a",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Chain Lightning: sword tethers 279 (sword->boss) / 280 (sword->sword); the source sword explodes.\n-- Per side: tethers come in sets of 3 (one set per safe step); the untethered sword of a set is safe.\nlocal e = eventArgs\nif not e then return end\nlocal tid = e.newTetherID\nif tid ~= 279 and tid ~= 280 then return end\nif e.oldTetherID == tid and e.oldTargetID == e.newTargetID then return end\nlocal src = e.sourceEntityID\nlocal en = TensorCore.mGetEntity(src)\nlocal ps = en and en.pos\nif not ps then return end\nlocal function M()\n  local m = data.m4_cl\n  if not m or not m.t or Now() - m.t > 90000 then\n    m = {t = Now(), sw = {}, tc = {L = 0, R = 0}, sets = {L = {}, R = {}}, ex = {L = 0, R = 0}, lastT = {}}\n    data.m4_cl = m\n  end\n  return m\nend\nlocal m = M()\nm.sw[src] = true\nlocal key = tostring(src) .. \"_\" .. tostring(tid) .. \"_\" .. tostring(e.newTargetID)\nif m.lastT[key] and Now() - m.lastT[key] < 500 then return end\nm.lastT[key] = Now()\nlocal side = ps.x < 100 and \"L\" or \"R\"\nm.tc[side] = m.tc[side] + 1\nlocal k = math.floor((m.tc[side] - 1) / 3) + 1\nm.sets[side][k] = m.sets[side][k] or {}\nm.sets[side][k][src] = true\n",
							name = "[Draw] M4S - Chain Lightning capture (sword tethers)",
							uuid = "c6016c25-8cd0-9f77-9386-67c4ded51e30",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 583.9,
				name = "[Draw] M4S - Chain Lightning capture (sword tethers)",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = 55,
				timerStartOffset = -20,
				uuid = "baedddc1-d272-517f-8ea1-7e8367f9593b",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Aetherial Conversion (stored, 38402 fire L->R / 38403 water L->R / 38404 fire R->L / 38405 water R->L) and the\n-- Tail Thrust cast that executes it (38406 fire L / 38407 water L / 38408 fire R / 38409 water R, 5+1s)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nlocal CONV = {[38402] = {\"fire\", -1}, [38403] = {\"water\", -1}, [38404] = {\"fire\", 1}, [38405] = {\"water\", 1}}\nlocal TT = {[38406] = {\"fire\", -1}, [38407] = {\"water\", -1}, [38408] = {\"fire\", 1}, [38409] = {\"water\", 1}}\nlocal c, t = CONV[sp], TT[sp]\nif not (c or t) then return end\ndata.m4_mb = data.m4_mb or {}\nlocal M = data.m4_mb\nif c then M.conv = {t = Now(), k = c[1], s = c[2]}; return end\nif M.ac and Now() - M.ac.t < 3000 then return end\nlocal a = {t = Now(), k = t[1], s = t[2], n = 0}\nlocal cv = M.conv\nif cv and Now() - cv.t < 120000 and (cv.k ~= a.k or cv.s ~= a.s) then a.bad = true end\nM.conv = nil\nM.ac = a\n",
							name = "[Draw] M4S - Aetherial Conversion 2 capture",
							uuid = "fee99c21-ce38-43c9-9632-3aa5545d0520",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 583.9,
				name = "[Draw] M4S - Aetherial Conversion 2 capture",
				timeRange = true,
				timelineIndex = 99,
				timerEndOffset = -4,
				timerStartOffset = -26,
				uuid = "5285f4c6-ef48-a640-a8d8-35c1c4e7aace",
				version = 2,
			},
		},
	},
	[100] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "de788a5a-5fc8-a0f4-98e6-250aaffed80e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Raining Swords towers: G1 west column, G2 east; T, M, H, R north to south\nlocal m = data.m4_cl\nif not m or not m.t or Now() - m.t > 90000 then\n  m = {t = Now(), sw = {}, tc = {L = 0, R = 0}, sets = {L = {}, R = {}}, ex = {L = 0, R = 0}, lastT = {}}\n  data.m4_cl = m\nend\n-- fallback: swords may have spawned before the capture window; scan for them (throttled, stops at 8)\nif (m.nsw or 0) < 8 and Now() - (m.scanT or 0) > 1000 then\n  m.scanT = Now()\n  local el = TensorCore.entityList(\"contentid=17327\")\n  if el then\n    for id, en in pairs(el) do\n      local eid = (type(en) == \"table\" and en.id) or id\n      if type(eid) == \"number\" then m.sw[eid] = true end\n    end\n  end\n  local n = 0\n  for _ in pairs(m.sw) do n = n + 1 end\n  m.nsw = n\nend\nif m.towDone and Now() - m.towDone < 60000 then return end\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal function sideList(m, left)\n  local L = {}\n  for id in pairs(m.sw) do\n    local en = TensorCore.mGetEntity(id)\n    local ps = en and en.pos\n    if ps and ((ps.x < 100) == left) then L[#L + 1] = {id = id, x = ps.x, z = ps.z} end\n  end\n  table.sort(L, function(a, b) return a.z < b.z end)\n  return L\nend\nlocal rank = ({T = 1, M = 2, H = 3, R = 4})[slot:sub(1, 1)]\nlocal grp = slot:sub(2, 2)\nif not rank or (grp ~= \"1\" and grp ~= \"2\") then return end\nlocal L = sideList(m, grp == \"1\")\nif #L ~= 4 then return end\ngo(L[rank].x, L[rank].z)\n",
							name = "[Draw] M4S - Raining Swords tower spot",
							uuid = "276bafa0-b3de-dfd4-ab7f-d2579b2124ab",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 589,
				name = "[Draw] M4S - Raining Swords tower spot",
				timeRange = true,
				timelineIndex = 100,
				timerEndOffset = 6,
				timerStartOffset = -8,
				uuid = "70458bb2-7914-dbb2-b717-4107cc62c422",
				version = 2,
			},
		},
	},
	[101] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "0334e43d-cc29-3f3c-8790-a18eac975acd",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Chain Lightning: stand on the current safe (untethered) sword of your column\nlocal m = data.m4_cl\nif not (m and m.t and Now() - m.t < 90000 and m.towDone) then return end\nlocal Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal function sideList(m, left)\n  local L = {}\n  for id in pairs(m.sw) do\n    local en = TensorCore.mGetEntity(id)\n    local ps = en and en.pos\n    if ps and ((ps.x < 100) == left) then L[#L + 1] = {id = id, x = ps.x, z = ps.z} end\n  end\n  table.sort(L, function(a, b) return a.z < b.z end)\n  return L\nend\nif math.abs(p.pos.x - 100) < 4 then return end\nlocal left = p.pos.x < 100\nlocal side = left and \"L\" or \"R\"\nlocal L = sideList(m, left)\nif #L ~= 4 then return end\nlocal function safeOf(k)\n  local set = m.sets[side][k]\n  if not set then return nil end\n  local n = 0\n  for _ in pairs(set) do n = n + 1 end\n  if n ~= 3 then return nil end\n  local s\n  for i = 1, 4 do\n    if not set[L[i].id] then\n      if s then return nil end\n      s = i\n    end\n  end\n  return s\nend\nlocal step = math.floor(m.ex[side] / 3) + 1\nif step > 4 then return end\nlocal s = safeOf(step)\nif not s and step == 4 then\n  local a, b, c = safeOf(1), safeOf(2), safeOf(3)\n  if a and b and c and a ~= b and b ~= c and a ~= c then\n    for i = 1, 4 do if i ~= a and i ~= b and i ~= c then s = i end end\n  end\nend\nif not s then return end\ngo(L[s].x, L[s].z)\n",
							name = "[Draw] M4S - Chain Lightning safe sword",
							uuid = "dad3d4bf-5368-7156-9691-49f0055ac2ff",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 610.1,
				name = "[Draw] M4S - Chain Lightning safe sword",
				timeRange = true,
				timelineIndex = 101,
				timerEndOffset = 26,
				timerStartOffset = -19,
				uuid = "22c8dbbe-253b-5290-825b-1a0dd71bb811",
				version = 2,
			},
		},
	},
	[102] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "526770dd-b52f-c2c6-923c-814ade43d13b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Aetherial Conversion (stored, 38402 fire L->R / 38403 water L->R / 38404 fire R->L / 38405 water R->L) and the\n-- Tail Thrust cast that executes it (38406 fire L / 38407 water L / 38408 fire R / 38409 water R, 5+1s)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nlocal CONV = {[38402] = {\"fire\", -1}, [38403] = {\"water\", -1}, [38404] = {\"fire\", 1}, [38405] = {\"water\", 1}}\nlocal TT = {[38406] = {\"fire\", -1}, [38407] = {\"water\", -1}, [38408] = {\"fire\", 1}, [38409] = {\"water\", 1}}\nlocal c, t = CONV[sp], TT[sp]\nif not (c or t) then return end\ndata.m4_mb = data.m4_mb or {}\nlocal M = data.m4_mb\nif c then M.conv = {t = Now(), k = c[1], s = c[2]}; return end\nif M.ac and Now() - M.ac.t < 3000 then return end\nlocal a = {t = Now(), k = t[1], s = t[2], n = 0}\nlocal cv = M.conv\nif cv and Now() - cv.t < 120000 and (cv.k ~= a.k or cv.s ~= a.s) then a.bad = true end\nM.conv = nil\nM.ac = a\n",
							name = "[Draw] M4S - Tail Thrust 2 capture casts",
							uuid = "4a9a4aad-32a5-0120-a8ba-05f4d798fae5",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 637.2,
				name = "[Draw] M4S - Tail Thrust 2 capture casts",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 2,
				timerStartOffset = -13,
				uuid = "4d4cf81f-8494-cab2-b38e-4be603d0c997",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Tail Thrust hits: 38414 Tail Thrust (fire circle r18) / 38415 Switch of Tides (water knockback 25)\nlocal e = eventArgs\nif not e then return end\nif e.spellID ~= 38414 and e.spellID ~= 38415 then return end\nlocal a = data.m4_mb and data.m4_mb.ac\nif not a or Now() - a.t > 20000 then return end\nif a.last and Now() - a.last < 1500 then return end\na.last = Now()\na.n = (a.n or 0) + 1\n",
							name = "[Draw] M4S - Tail Thrust 2 capture hits",
							uuid = "8064164e-96ad-74b4-8d36-0de7ac38688f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 637.2,
				name = "[Draw] M4S - Tail Thrust 2 capture hits",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 9,
				timerStartOffset = -3,
				uuid = "c629f39e-6a01-2104-a702-c11632319225",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Aetherial Conversion / Tail Thrust: two hits at (100 -/+ 10, 165), first on the side the conversion names.\n-- Fire = r18 circle: dodge along the north edge (start opposite the first circle, then cross). Water = knockback 25\n-- from the red dot: stand just inside the first dot (pushed across), then just inside the second dot.\nlocal a = data.m4_mb and data.m4_mb.ac\nif not a or a.bad or Now() - a.t > 16000 or (a.n or 0) >= 2 then return end\nlocal s = a.s\nif s ~= 1 and s ~= -1 then return end\nif a.k == \"fire\" then\n  if a.n == 0 then go(100 - 6 * s, 151) else go(100 + 6 * s, 151) end\nelseif a.k == \"water\" then\n  if a.n == 0 then go(100 + 9 * s, 165) else go(100 - 9 * s, 165) end\nend\n",
							name = "[Draw] M4S - Tail Thrust 2 fire/water spot",
							uuid = "60045236-8217-03b2-bb41-4a9068c543a9",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 637.2,
				name = "[Draw] M4S - Tail Thrust 2 fire/water spot",
				timeRange = true,
				timelineIndex = 102,
				timerEndOffset = 8,
				timerStartOffset = -10,
				uuid = "6c298eb6-a5dd-c45b-8d8d-9a2bdb321e84",
				version = 2,
			},
		},
	},
	[104] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "707b48da-5708-f85e-8803-4137a9782523",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Mustard Bomb: boss cast 38430 (8+1s) starts the mechanic\nlocal e = eventArgs\nif not (e and e.spellID == 38430) then return end\ndata.m4_mb = data.m4_mb or {}\nlocal s = data.m4_mb.mb\n-- keep tethers captured just before the cast event (same mechanic), else start fresh\nif s and not s.first and not s.done and Now() - s.t < 3000 then s.cast = Now(); return end\ndata.m4_mb.mb = {t = Now(), cast = Now(), teth = {}, hit = {}}\n",
							name = "[Draw] M4S - Mustard Bomb 2 capture cast",
							uuid = "0649afb1-809f-2f5f-b8f3-79579c753a41",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 653.1,
				name = "[Draw] M4S - Mustard Bomb 2 capture cast",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 2,
				timerStartOffset = -14,
				uuid = "2442a2f6-6db4-60a7-94a7-0f29bf514115",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Mustard Bomb: tether 283 (player <-> boss). Track who holds a tether until the first hit.\nlocal e = eventArgs\nif not e then return end\nif e.newTetherID ~= 283 and e.oldTetherID ~= 283 then return end\ndata.m4_mb = data.m4_mb or {}\nlocal s = data.m4_mb.mb\nif not s or s.done or Now() - s.t > 25000 then\n  s = {t = Now(), teth = {}, hit = {}}\n  data.m4_mb.mb = s\nend\nif s.first then return end\nlocal party = {}\nlocal L = TensorCore.getEntityGroupList(\"Party\")\nif type(L) == \"table\" then\n  for _, v in pairs(L) do\n    local id = (type(v) == \"table\") and v.id or v\n    if id then party[id] = true end\n  end\nend\nlocal src = e.sourceEntityID\nif e.newTetherID == 283 then\n  local h = (party[src] and src) or (party[e.newTargetID] and e.newTargetID)\n  if e.oldTetherID == 283 and party[e.oldTargetID] and e.oldTargetID ~= e.newTargetID then s.teth[e.oldTargetID] = nil end\n  if h then s.teth[h] = true end\nelse\n  local h = (party[src] and src) or (party[e.oldTargetID] and e.oldTargetID)\n  if h then s.teth[h] = nil end\nend\n",
							name = "[Draw] M4S - Mustard Bomb 2 capture tethers",
							uuid = "ab9419b3-828d-9885-8529-9899251d6ea3",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 15,
				loop = true,
				mechanicTime = 653.1,
				name = "[Draw] M4S - Mustard Bomb 2 capture tethers",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 2,
				timerStartOffset = -14,
				uuid = "5be42a7b-a4d5-3351-b776-9da8447a20c5",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Mustard Bomb: 38431 tether hit (tanks get the Mustard Bomb debuff 4007), 38432 Kindling Cauldron spreads,\n-- 38433 second explosion (mechanic done). Anyone hit by 38431/38432 cannot take the debuff.\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38431 and sp ~= 38432 and sp ~= 38433 then return end\nlocal s = data.m4_mb and data.m4_mb.mb\nif not s or Now() - s.t > 25000 then return end\nif sp == 38433 then s.done = Now(); return end\ns.first = s.first or Now()\ns.teth = {}\nlocal ht = e.hitTargets or {}\nfor _, id in ipairs(ht) do s.hit[id] = true end\nif #ht == 0 and e.targetID and e.targetID > 0 then s.hit[e.targetID] = true end\n",
							name = "[Draw] M4S - Mustard Bomb 2 capture hits",
							uuid = "8aa3ce9c-8b30-4c23-9920-8eba52310a37",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 653.1,
				name = "[Draw] M4S - Mustard Bomb 2 capture hits",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 15,
				timerStartOffset = -3,
				uuid = "c0ebc250-00ca-f1bd-b33d-25e84c5593b0",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Mustard Bomb (strategy 45.png): row 1 (z155) M1 85 / MT 95 / OT 105 / M2 115, row 2 (z165) R1 85 / H1 95 /\n-- H2 105 / R2 115. Tethers: non-tanks holding one wait near the middle, tanks run to grab them. After the first hit the\n-- tanks (debuff 4007) pass it: MT to the leftmost safe (unhit) player, OT to the rightmost, then return to their spot.\nlocal s = data.m4_mb and data.m4_mb.mb\nif not s or s.done or Now() - s.t > 25000 then return end\nlocal SP = {M1 = {85, 155}, T1 = {95, 155}, T2 = {105, 155}, M2 = {115, 155},\n            R1 = {85, 165}, H1 = {95, 165}, H2 = {105, 165}, R2 = {115, 165}}\nlocal my = SP[slot]\nif not my then return end\nlocal tank = (slot == \"T1\" or slot == \"T2\")\nlocal TANKJOB = {[1] = true, [3] = true, [19] = true, [21] = true, [32] = true, [37] = true}\nif not s.first then\n  if s.cast and Now() - s.cast < 6500 then\n    if not tank and s.teth[p.id] then go(100, 160); return end\n    if tank and not s.teth[p.id] then\n      local best\n      for id in pairs(s.teth) do\n        local en = TensorCore.mGetEntity(id)\n        if en and en.pos and not TANKJOB[en.job or 0] then\n          if not best or (slot == \"T1\" and en.pos.x < best.pos.x) or (slot == \"T2\" and en.pos.x > best.pos.x) then best = en end\n        end\n      end\n      if best then go(best.pos.x, best.pos.z); return end\n    end\n  end\n  go(my[1], my[2])\n  return\nend\nif tank and TensorCore.hasBuff(p, 4007) then\n  local n = 0\n  for _ in pairs(s.hit) do n = n + 1 end\n  if n >= 6 then\n    local L = TensorCore.getEntityGroupList(\"Party\")\n    local best\n    if type(L) == \"table\" then\n      for _, v in pairs(L) do\n        local en = (type(v) == \"table\") and v or TensorCore.mGetEntity(v)\n        if en and en.id and en.id ~= p.id and en.pos and not s.hit[en.id] and not TensorCore.hasBuff(en, 4007) then\n          if not best or (slot == \"T1\" and en.pos.x < best.pos.x) or (slot == \"T2\" and en.pos.x > best.pos.x) then best = en end\n        end\n      end\n    end\n    if best then go(best.pos.x, best.pos.z); return end\n  end\nend\ngo(my[1], my[2])\n",
							name = "[Draw] M4S - Mustard Bomb 2 spots",
							uuid = "deb94635-54fc-d82f-9a9d-68d181781b8e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 653.1,
				name = "[Draw] M4S - Mustard Bomb 2 spots",
				timeRange = true,
				timelineIndex = 104,
				timerEndOffset = 13,
				timerStartOffset = -11,
				uuid = "d5844032-affe-a140-9484-e839842a5178",
				version = 2,
			},
		},
	},
	[106] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "3b88fc11-0724-2512-8ad3-ffd02728b12b",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Aetherial Conversion (stored, 38402 fire L->R / 38403 water L->R / 38404 fire R->L / 38405 water R->L) and the\n-- Tail Thrust cast that executes it (38406 fire L / 38407 water L / 38408 fire R / 38409 water R, 5+1s)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nlocal CONV = {[38402] = {\"fire\", -1}, [38403] = {\"water\", -1}, [38404] = {\"fire\", 1}, [38405] = {\"water\", 1}}\nlocal TT = {[38406] = {\"fire\", -1}, [38407] = {\"water\", -1}, [38408] = {\"fire\", 1}, [38409] = {\"water\", 1}}\nlocal c, t = CONV[sp], TT[sp]\nif not (c or t) then return end\ndata.m4_mb = data.m4_mb or {}\nlocal M = data.m4_mb\nif c then M.conv = {t = Now(), k = c[1], s = c[2]}; return end\nif M.ac and Now() - M.ac.t < 3000 then return end\nlocal a = {t = Now(), k = t[1], s = t[2], n = 0}\nlocal cv = M.conv\nif cv and Now() - cv.t < 120000 and (cv.k ~= a.k or cv.s ~= a.s) then a.bad = true end\nM.conv = nil\nM.ac = a\n",
							name = "[Draw] M4S - Aetherial Conversion 3 capture",
							uuid = "5e2f8427-4e5c-ac12-9970-64816aad984b",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 678.6,
				name = "[Draw] M4S - Aetherial Conversion 3 capture",
				timeRange = true,
				timelineIndex = 106,
				timerEndOffset = -3,
				timerStartOffset = -22,
				uuid = "79efca7e-f4cd-f64c-a213-3cfed604fe83",
				version = 2,
			},
		},
	},
	[108] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "9ac9fc2e-3a0e-a0fa-b1be-36f4226079e2",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Sunrise Sabbath: at the Sunrise Sabbath cast start (39610 / 0x9ABA) read my Positron (4000, yellow) /\n-- Negatron (4001, blue) debuff: short (23s) = cannon first, tower second; long (38s) = tower first, cannon second.\n-- Short/long is decided against the party (longs are +15s); fallback: more than 28s left = long.\nlocal e = eventArgs\nif not (e and e.spellID == 39610) then return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal function deb(ent)\n  local b = TensorCore.getBuff(ent, 4000)\n  if b then return true, b.duration end\n  b = TensorCore.getBuff(ent, 4001)\n  if b then return false, b.duration end\nend\ndata.m4_sun = {t0 = Now(), set = 1, tw = {}, cn = {}}\nlocal m = data.m4_sun\nlocal pos, dur = deb(p)\nif pos == nil or not dur then return end\nlocal mn, mx\nfor _, ent in pairs(TensorCore.getEntityGroupList(\"Party\") or {}) do\n  local _, d = deb(ent)\n  if d then\n    if not mn or d < mn then mn = d end\n    if not mx or d > mx then mx = d end\n  end\nend\nlocal long\nif mn and mx and mx - mn > 7.5 then long = dur > (mn + mx) / 2 else long = dur > 28 end\nm.pos = pos\nm.long = long\n",
							name = "[Capture] M4S - Sunrise Sabbath debuff (short/long, colour)",
							uuid = "00a48ed8-225b-3cf0-81da-9c955c6f3ea2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 690.8,
				name = "[Capture] M4S - Sunrise Sabbath debuff (short/long, colour)",
				timeRange = true,
				timelineIndex = 108,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "1184d644-8d65-2b8a-b342-fb9d558ee604",
				version = 2,
			},
		},
	},
	[109] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "a6f2dfe4-5aa7-c103-a99a-ffd09e4a04b5",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Sunrise Sabbath: Wicked Special AOE (38417 / 38419) starts set 2; Soaring Soulpress towers (38440 / 39259)\n-- and Positron/Negatron Stream cannons (38437 / 38438 / 39257 / 39258) mark the current set's part as done.\nlocal e = eventArgs\nlocal sp = e and e.spellID\nif not sp then return end\nlocal W = (sp == 38417 or sp == 38419)\nlocal T = (sp == 38440 or sp == 39259)\nlocal C = (sp == 38437 or sp == 38438 or sp == 39257 or sp == 39258)\nif not (W or T or C) then return end\nlocal m = data.m4_sun\nif not (m and m.t0 and Now() - m.t0 < 45000) then return end\nif W then\n  if m.set == 1 then m.set = 2; m.t2 = Now() end\n  return\nend\nif T and not m.tw[m.set] then m.tw[m.set] = Now() end\nif C and not m.cn[m.set] then m.cn[m.set] = Now() end\n",
							name = "[Capture] M4S - Sunrise Sabbath set / resolves",
							uuid = "9b5a5a11-5fa5-eb1c-ba29-a8e003d959d0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 704,
				name = "[Capture] M4S - Sunrise Sabbath set / resolves",
				timeRange = true,
				timelineIndex = 109,
				timerEndOffset = 21,
				timerStartOffset = -12,
				uuid = "b6322e65-9351-f0c4-bac1-7ba4139fd47d",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Sunrise Sabbath set 1 (towers + cannons ~704)\n-- Short debuff = cannon in set 1, tower in set 2; long = tower in set 1, cannon in set 2.\n-- Towers (2 per set) come from the \"birds\" (Wicked Replica 0x43AB on a cardinal): tower = bird + facing * 30\n-- (facing a cardinal) or * 21.21 (facing an intercard) -> the towers are N+S or E+W on the 15y circle edge.\n-- Towers: supports W/S, DPS N/E. Cannons (replicas on intercards with status 2970, extra 0x2F4 yellow /\n-- 0x2F5 blue): bait the OPPOSITE colour of your debuff (Positron/yellow -> blue). Snake prio: supports take the\n-- first of that colour from NW counter-clockwise (NW, SW, SE, NE), DPS the other one. Stand just beside the\n-- cannon on the edge, toward the cardinal WITHOUT a tower, so the beam goes into the death wall away from it.\nlocal SET = 1\nlocal m = data.m4_sun\nif not (m and m.t0 and Now() - m.t0 < 45000 and m.set == SET and m.long ~= nil and m.pos ~= nil) then return end\nlocal cannonTask = (SET == 1) ~= m.long\nif cannonTask and m.cn[SET] then return end\nif not cannonTask and m.tw[SET] then return end\nif cannonTask and SET == 2 and (not m.t2 or Now() - m.t2 < 2500) then return end -- set-2 markers land ~1.7s after the Wicked Special AOE (BossMod states)\nlocal sup = (slot == \"T1\" or slot == \"T2\" or slot == \"H1\" or slot == \"H2\")\nlocal dps = (slot == \"M1\" or slot == \"M2\" or slot == \"R1\" or slot == \"R2\")\nif not (sup or dps) then return end\nlocal CX, CZ = 100, 165\nlocal list = TensorCore.entityList(\"contentid=17323\")\nif not list then return end\nlocal axis, bad = nil, false\nlocal cans, ncan = {}, 0\nfor _, r in pairs(list) do\n  local ps = r.pos\n  if ps then\n    local dx, dz = ps.x - CX, ps.z - CZ\n    local ax, az = math.abs(dx), math.abs(dz)\n    local rr = math.sqrt(dx * dx + dz * dz)\n    if rr > 9 and rr < 22 then\n      local card = math.min(ax, az) < 0.414 * math.max(ax, az)\n      local mk = TensorCore.getBuff(r, 2970)\n      local st = mk and mk.stacks and (mk.stacks % 256)\n      if st == 0xF4 or st == 0xF5 then\n        if not card then\n          ncan = ncan + 1\n          local q = (dz < 0 and \"N\" or \"S\") .. (dx < 0 and \"W\" or \"E\")\n          if cans[q] then bad = true end\n          cans[q] = {x = ps.x, z = ps.z, blue = (st == 0xF5)}\n        end\n      elseif card then\n        local h = ps.h or 0\n        local k = math.floor(h / (math.pi / 4) + 0.5)\n        local L = ((k % 2) ~= 0) and 21.2132 or 30\n        local tdx, tdz = ps.x + math.sin(h) * L - CX, ps.z + math.cos(h) * L - CZ\n        local tr = math.sqrt(tdx * tdx + tdz * tdz)\n        if math.abs(tr - 15) < 4 and math.min(math.abs(tdx), math.abs(tdz)) < 4 then\n          local a = (math.abs(tdz) > math.abs(tdx)) and \"NS\" or \"EW\"\n          if axis and axis ~= a then bad = true end\n          axis = a\n        end\n      end\n    end\n  end\nend\nif bad or not axis then return end\nif not cannonTask then\n  if axis == \"NS\" then\n    if sup then go(100, 178) else go(100, 152) end\n  else\n    if sup then go(87, 165) else go(113, 165) end\n  end\n  return\nend\nif ncan ~= 4 then return end\nlocal mine, n = {}, 0\nfor q, c in pairs(cans) do if c.blue == m.pos then mine[q] = c; n = n + 1 end end\nif n ~= 2 then return end\nlocal first\nfor _, q in ipairs({\"NW\", \"SW\", \"SE\", \"NE\"}) do if mine[q] then first = q; break end end\nlocal pick\nif sup then pick = mine[first] else for q, c in pairs(mine) do if q ~= first then pick = c end end end\nif not pick then return end\nlocal cx, cz = pick.x, pick.z\nlocal dx, dz = cx - CX, cz - CZ\nlocal r = math.sqrt(dx * dx + dz * dz)\nif r < 1 then return end\nlocal ix, iz = -dx / r, -dz / r\nlocal qx, qz\nif axis == \"NS\" then qx, qz = (dx < 0) and 85 or 115, 165 else qx, qz = 100, (dz < 0) and 150 or 180 end\nlocal tx, tz = -iz, ix\nif tx * (qx - cx) + tz * (qz - cz) < 0 then tx, tz = -tx, -tz end\nlocal ux, uz = 0.985 * tx + 0.174 * ix, 0.985 * tz + 0.174 * iz\nlocal sx, sz = cx + 2.5 * ux, cz + 2.5 * uz\nlocal sdx, sdz = sx - CX, sz - CZ\nlocal sr = math.sqrt(sdx * sdx + sdz * sdz)\nif sr > 14.4 then sx, sz = CX + sdx * 14.4 / sr, CZ + sdz * 14.4 / sr end\ngo(sx, sz)\n",
							name = "[Draw] M4S - Sunrise Sabbath set 1 (cannon/tower)",
							uuid = "0ad8a467-a8d5-6864-a064-4271b52c1e32",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 704,
				name = "[Draw] M4S - Sunrise Sabbath set 1 (cannon/tower)",
				timeRange = true,
				timelineIndex = 109,
				timerEndOffset = 2.5,
				timerStartOffset = -10,
				uuid = "b5e6f28f-2c66-857c-b5bd-a04edb70ee82",
				version = 2,
			},
		},
	},
	[110] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "878b08bd-6ade-68ad-bef1-c7f0405a6a93",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S p2a capture: Sabertail exaflare starts (38389, helpers, 8s cast, r6, step 6.5 every 0.7s),\n-- Wicked Special boss cast (38416 = center AOE -> sides safe, 38418 = sides AOE -> middle safe)\n-- and its helper rects (38417 width 20 / 38419 width 15, length 40). Dedupes (windows of entries can overlap).\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 38389 and sp ~= 38416 and sp ~= 38418 and sp ~= 38417 and sp ~= 38419 then return end\ndata.m4_p2a = data.m4_p2a or {}\nlocal m = data.m4_p2a\nlocal now = Now()\nlocal ct = tonumber(e.channelTimeMax) or 0\nif sp == 38416 or sp == 38418 then\n  if m.ws and now - m.ws.t < 3000 then return end\n  m.ws = {t = now, te = now + ((ct > 0) and ct or 5) * 1000 + 1000, sides = (sp == 38416)}\n  return\nend\nlocal id = e.entityID\nlocal ent = id and TensorCore.mGetEntity(id)\nlocal ps = ent and ent.pos\nif not ps then return end\nif sp == 38389 then\n  if not m.sab or now - m.sab.t > 20000 then m.sab = {t = now, lines = {}, seen = {}} end\n  local sb = m.sab\n  if sb.seen[id] then return end\n  sb.seen[id] = true\n  sb.last = now\n  sb.ex = nil; sb.spot = nil\n  sb.lines[#sb.lines + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, t0 = now + ((ct > 0) and ct or 8) * 1000}\n  return\nend\nif not m.wr or now - m.wr.t > 3000 then m.wr = {t = now, list = {}, seen = {}} end\nif m.wr.seen[id] then return end\nm.wr.seen[id] = true\nm.wr.list[#m.wr.list + 1] = {x = ps.x, z = ps.z, h = ps.h or 0, hw = (sp == 38417) and 10 or 7.5}\n",
							name = "[Draw] M4S - Wicked Special capture (Sunrise Sabbath)",
							uuid = "ff9e091f-8790-bfe4-86ec-32cdf1490b52",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 711.8,
				name = "[Draw] M4S - Wicked Special capture (Sunrise Sabbath)",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = 5,
				timerStartOffset = -10,
				uuid = "b7bd4b0d-e845-4553-aae8-dbae0c6206cc",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\nlocal G1 = {T1 = true, H1 = true, M1 = true, R1 = true}\nlocal G2 = {T2 = true, H2 = true, M2 = true, R2 = true}\n-- M4S p2a: Wicked Special (Sunrise Sabbath). 38416 flame sword = center unsafe -> sides (x 87.5 / 112.5);\n-- 38418 lightning = sides unsafe -> middle (x 97.5 / 102.5). Stay on your current half (group side if near x 100),\n-- keep your z. Checked against the helper rects when they were captured.\nlocal CIRCLE, DELAY = true, 0\nlocal m = data.m4_p2a\nlocal ws = m and m.ws\nif not ws then return end\nlocal now = Now()\nif now - ws.t > 12000 or now > ws.te + 500 or now - ws.t < DELAY then return end\nlocal side\nif math.abs(p.pos.x - 100) > 2 then side = (p.pos.x < 100) and -1 or 1\nelseif G1[slot] then side = -1 elseif G2[slot] then side = 1 else return end\nlocal rects = (m.wr and math.abs(m.wr.t - ws.t) < 3000 and #m.wr.list > 0) and m.wr.list or nil\nlocal function zfor(x, z)\n  if CIRCLE then\n    local dx, dz = x - 100, z - 165\n    if dx * dx + dz * dz > 13.5 * 13.5 then\n      local lim = 13.5 * 13.5 - dx * dx\n      if lim < 0 then return nil end\n      local zz = math.sqrt(lim)\n      z = 165 + ((dz < 0) and -zz or zz)\n    end\n    return z\n  end\n  return math.max(151, math.min(179, z))\nend\nlocal function safe(x, z)\n  if not rects then return true end\n  for _, r in ipairs(rects) do\n    local fx, fz = math.sin(r.h), math.cos(r.h)\n    local ddx, ddz = x - r.x, z - r.z\n    local al = ddx * fx + ddz * fz\n    local lat = math.abs(-ddx * fz + ddz * fx)\n    if al > -0.5 and al < 40.5 and lat < r.hw + 0.75 then return false end\n  end\n  return true\nend\nlocal px = 100 + side * (ws.sides and 12.5 or 2.5)\nlocal maxo = CIRCLE and 13 or 19.25\nfor k = 0, 30 do\n  local off = (k % 2 == 0) and (k / 2) * 0.5 or -((k + 1) / 2) * 0.5\n  local x = px + off\n  local o = side * (x - 100)\n  if o >= 0.75 and o <= maxo then\n    local z = zfor(x, p.pos.z)\n    if z and safe(x, z) then go(x, z); return end\n  end\nend\n",
							name = "[Draw] M4S - Wicked Special spot (Sunrise Sabbath)",
							uuid = "fe4d25be-0740-1f08-a1f8-57accc0119ea",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 711.8,
				name = "[Draw] M4S - Wicked Special spot (Sunrise Sabbath)",
				timeRange = true,
				timelineIndex = 110,
				timerEndOffset = 4,
				timerStartOffset = -9,
				uuid = "f2231974-7f86-6c88-8610-bda74221763d",
				version = 2,
			},
		},
	},
	[111] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "e4f576e1-7768-55e9-9c43-18389f46b847",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Sunrise Sabbath set 2 (after Wicked Special, ~720.6)\n-- Short debuff = cannon in set 1, tower in set 2; long = tower in set 1, cannon in set 2.\n-- Towers (2 per set) come from the \"birds\" (Wicked Replica 0x43AB on a cardinal): tower = bird + facing * 30\n-- (facing a cardinal) or * 21.21 (facing an intercard) -> the towers are N+S or E+W on the 15y circle edge.\n-- Towers: supports W/S, DPS N/E. Cannons (replicas on intercards with status 2970, extra 0x2F4 yellow /\n-- 0x2F5 blue): bait the OPPOSITE colour of your debuff (Positron/yellow -> blue). Snake prio: supports take the\n-- first of that colour from NW counter-clockwise (NW, SW, SE, NE), DPS the other one. Stand just beside the\n-- cannon on the edge, toward the cardinal WITHOUT a tower, so the beam goes into the death wall away from it.\nlocal SET = 2\nlocal m = data.m4_sun\nif not (m and m.t0 and Now() - m.t0 < 45000 and m.set == SET and m.long ~= nil and m.pos ~= nil) then return end\nlocal cannonTask = (SET == 1) ~= m.long\nif cannonTask and m.cn[SET] then return end\nif not cannonTask and m.tw[SET] then return end\nif cannonTask and SET == 2 and (not m.t2 or Now() - m.t2 < 2500) then return end -- set-2 markers land ~1.7s after the Wicked Special AOE (BossMod states)\nlocal sup = (slot == \"T1\" or slot == \"T2\" or slot == \"H1\" or slot == \"H2\")\nlocal dps = (slot == \"M1\" or slot == \"M2\" or slot == \"R1\" or slot == \"R2\")\nif not (sup or dps) then return end\nlocal CX, CZ = 100, 165\nlocal list = TensorCore.entityList(\"contentid=17323\")\nif not list then return end\nlocal axis, bad = nil, false\nlocal cans, ncan = {}, 0\nfor _, r in pairs(list) do\n  local ps = r.pos\n  if ps then\n    local dx, dz = ps.x - CX, ps.z - CZ\n    local ax, az = math.abs(dx), math.abs(dz)\n    local rr = math.sqrt(dx * dx + dz * dz)\n    if rr > 9 and rr < 22 then\n      local card = math.min(ax, az) < 0.414 * math.max(ax, az)\n      local mk = TensorCore.getBuff(r, 2970)\n      local st = mk and mk.stacks and (mk.stacks % 256)\n      if st == 0xF4 or st == 0xF5 then\n        if not card then\n          ncan = ncan + 1\n          local q = (dz < 0 and \"N\" or \"S\") .. (dx < 0 and \"W\" or \"E\")\n          if cans[q] then bad = true end\n          cans[q] = {x = ps.x, z = ps.z, blue = (st == 0xF5)}\n        end\n      elseif card then\n        local h = ps.h or 0\n        local k = math.floor(h / (math.pi / 4) + 0.5)\n        local L = ((k % 2) ~= 0) and 21.2132 or 30\n        local tdx, tdz = ps.x + math.sin(h) * L - CX, ps.z + math.cos(h) * L - CZ\n        local tr = math.sqrt(tdx * tdx + tdz * tdz)\n        if math.abs(tr - 15) < 4 and math.min(math.abs(tdx), math.abs(tdz)) < 4 then\n          local a = (math.abs(tdz) > math.abs(tdx)) and \"NS\" or \"EW\"\n          if axis and axis ~= a then bad = true end\n          axis = a\n        end\n      end\n    end\n  end\nend\nif bad or not axis then return end\nif not cannonTask then\n  if axis == \"NS\" then\n    if sup then go(100, 178) else go(100, 152) end\n  else\n    if sup then go(87, 165) else go(113, 165) end\n  end\n  return\nend\nif ncan ~= 4 then return end\nlocal mine, n = {}, 0\nfor q, c in pairs(cans) do if c.blue == m.pos then mine[q] = c; n = n + 1 end end\nif n ~= 2 then return end\nlocal first\nfor _, q in ipairs({\"NW\", \"SW\", \"SE\", \"NE\"}) do if mine[q] then first = q; break end end\nlocal pick\nif sup then pick = mine[first] else for q, c in pairs(mine) do if q ~= first then pick = c end end end\nif not pick then return end\nlocal cx, cz = pick.x, pick.z\nlocal dx, dz = cx - CX, cz - CZ\nlocal r = math.sqrt(dx * dx + dz * dz)\nif r < 1 then return end\nlocal ix, iz = -dx / r, -dz / r\nlocal qx, qz\nif axis == \"NS\" then qx, qz = (dx < 0) and 85 or 115, 165 else qx, qz = 100, (dz < 0) and 150 or 180 end\nlocal tx, tz = -iz, ix\nif tx * (qx - cx) + tz * (qz - cz) < 0 then tx, tz = -tx, -tz end\nlocal ux, uz = 0.985 * tx + 0.174 * ix, 0.985 * tz + 0.174 * iz\nlocal sx, sz = cx + 2.5 * ux, cz + 2.5 * uz\nlocal sdx, sdz = sx - CX, sz - CZ\nlocal sr = math.sqrt(sdx * sdx + sdz * sdz)\nif sr > 14.4 then sx, sz = CX + sdx * 14.4 / sr, CZ + sdz * 14.4 / sr end\ngo(sx, sz)\n",
							name = "[Draw] M4S - Sunrise Sabbath set 2 (cannon/tower)",
							uuid = "921e0284-a39a-b1a3-829a-d6457bec9f24",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 720.6,
				name = "[Draw] M4S - Sunrise Sabbath set 2 (cannon/tower)",
				timeRange = true,
				timelineIndex = 111,
				timerEndOffset = 2.5,
				timerStartOffset = -10,
				uuid = "48950027-558b-ffc5-a7a5-6eba83c0e60d",
				version = 2,
			},
		},
	},
	[112] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "01d8d3a4-eef8-aea3-8011-d329306af1e6",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Aetherial Conversion (stored, 38402 fire L->R / 38403 water L->R / 38404 fire R->L / 38405 water R->L) and the\n-- Tail Thrust cast that executes it (38406 fire L / 38407 water L / 38408 fire R / 38409 water R, 5+1s)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nlocal CONV = {[38402] = {\"fire\", -1}, [38403] = {\"water\", -1}, [38404] = {\"fire\", 1}, [38405] = {\"water\", 1}}\nlocal TT = {[38406] = {\"fire\", -1}, [38407] = {\"water\", -1}, [38408] = {\"fire\", 1}, [38409] = {\"water\", 1}}\nlocal c, t = CONV[sp], TT[sp]\nif not (c or t) then return end\ndata.m4_mb = data.m4_mb or {}\nlocal M = data.m4_mb\nif c then M.conv = {t = Now(), k = c[1], s = c[2]}; return end\nif M.ac and Now() - M.ac.t < 3000 then return end\nlocal a = {t = Now(), k = t[1], s = t[2], n = 0}\nlocal cv = M.conv\nif cv and Now() - cv.t < 120000 and (cv.k ~= a.k or cv.s ~= a.s) then a.bad = true end\nM.conv = nil\nM.ac = a\n",
							name = "[Draw] M4S - Tail Thrust 3 capture casts",
							uuid = "932aae7b-1608-1236-a05d-40cc141c15ca",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 727.9,
				name = "[Draw] M4S - Tail Thrust 3 capture casts",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = 2,
				timerStartOffset = -13,
				uuid = "a79d7765-765f-1ca9-9e53-81ae642d43f8",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- M4S Tail Thrust hits: 38414 Tail Thrust (fire circle r18) / 38415 Switch of Tides (water knockback 25)\nlocal e = eventArgs\nif not e then return end\nif e.spellID ~= 38414 and e.spellID ~= 38415 then return end\nlocal a = data.m4_mb and data.m4_mb.ac\nif not a or Now() - a.t > 20000 then return end\nif a.last and Now() - a.last < 1500 then return end\na.last = Now()\na.n = (a.n or 0) + 1\n",
							name = "[Draw] M4S - Tail Thrust 3 capture hits",
							uuid = "b47bc103-582f-e3b1-a733-cb7f38dbb34f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 727.9,
				name = "[Draw] M4S - Tail Thrust 3 capture hits",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = 9,
				timerStartOffset = -3,
				uuid = "7f520f91-1d93-b740-8439-8b45fd343132",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- M4S Aetherial Conversion / Tail Thrust: two hits at (100 -/+ 10, 165), first on the side the conversion names.\n-- Fire = r18 circle: dodge along the north edge (start opposite the first circle, then cross). Water = knockback 25\n-- from the red dot: stand just inside the first dot (pushed across), then just inside the second dot.\nlocal a = data.m4_mb and data.m4_mb.ac\nif not a or a.bad or Now() - a.t > 16000 or (a.n or 0) >= 2 then return end\nlocal s = a.s\nif s ~= 1 and s ~= -1 then return end\nif a.k == \"fire\" then\n  if a.n == 0 then go(100 - 6 * s, 151) else go(100 + 6 * s, 151) end\nelseif a.k == \"water\" then\n  if a.n == 0 then go(100 + 9 * s, 165) else go(100 - 9 * s, 165) end\nend\n",
							name = "[Draw] M4S - Tail Thrust 3 fire/water spot",
							uuid = "20a2e826-c789-6ea1-8fca-a7e2abf0e7ca",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 727.9,
				name = "[Draw] M4S - Tail Thrust 3 fire/water spot",
				timeRange = true,
				timelineIndex = 112,
				timerEndOffset = 8,
				timerStartOffset = -10,
				uuid = "26967336-9596-4c2d-8362-1aa6699ea163",
				version = 2,
			},
		},
	},
	[114] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "f911a179-b46f-3252-8e6b-2f2aa0c2752e",
			},
			objectType = "folder",
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Sword Quiver: BossP2 (0x43AE) cast 38393 (95F9, horizontal line N) / 38394 (95FA, C) / 38395 (95FB, S); 5.0+1.3s cast\nlocal e = eventArgs\nif not e then return end\nlocal V = {[38393] = \"N\", [38394] = \"C\", [38395] = \"S\"}\nlocal v = V[e.spellID]\nif not v then return end\ndata.m4_sq = {t = Now(), v = v}\n",
							name = "[Draw] M4S - Sword Quiver capture (cast start)",
							uuid = "a8e93c0c-398b-cd60-a9a0-ae843c4515be",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 3,
				loop = true,
				mechanicTime = 743.1,
				name = "[Draw] M4S - Sword Quiver capture (cast start)",
				timeRange = true,
				timelineIndex = 114,
				timerEndOffset = 48,
				timerStartOffset = -12,
				uuid = "a296dcaf-e926-e34e-894f-42ac2920ba42",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "-- Sword Quiver fallback: the 95F9/95FA/95FB ability lands ~5.0-5.2s after its cast starts, at cast end (cactbot timeline: ability 743.1 -> Burst 751.8 = 8.7s; BossMod: Burst = cast end + 8.9s)\nlocal e = eventArgs\nif not e then return end\nlocal V = {[38393] = \"N\", [38394] = \"C\", [38395] = \"S\"}\nlocal v = V[e.spellID]\nif not v then return end\nlocal s = data.m4_sq\nif s and s.v == v and Now() - s.t < 10000 then return end\ndata.m4_sq = {t = Now() - 5000, v = v}\n",
							name = "[Draw] M4S - Sword Quiver capture (ability fallback)",
							uuid = "2ad526d4-9189-3309-ac52-4846d8defb61",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 2,
				loop = true,
				mechanicTime = 743.1,
				name = "[Draw] M4S - Sword Quiver capture (ability fallback)",
				timeRange = true,
				timelineIndex = 114,
				timerEndOffset = 48,
				timerStartOffset = -12,
				uuid = "4054574e-d4b0-2650-97f8-68d421c47e14",
				version = 2,
			},
		},
		
		{
			data = 
			{
				actions = 
				{
					
					{
						data = 
						{
							aType = "Lua",
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Sword Quiver x3: partner stacks. 3 fixed 12-wide lines through (100,165) at 0 / +-118 deg, the 4th line\n-- is horizontal at z 155 (N), 165 (C) or 175 (S). Melee pairs take the northern safe set, ranged pairs the southern:\n-- N -> melee sides, ranged back; C -> melee front, ranged back; S -> melee front, ranged sides.\n-- G1 (T1 M1 / H1 R1) west, G2 east.\nlocal s = data.m4_sq\nif not (s and s.t and s.v) then return end\nlocal el = Now() - s.t\nif el < 0 or el > 16000 then return end\nlocal melee = (slot == \"T1\" or slot == \"M1\" or slot == \"T2\" or slot == \"M2\")\nlocal ranged = (slot == \"H1\" or slot == \"R1\" or slot == \"H2\" or slot == \"R2\")\nif not (melee or ranged) then return end\nlocal west = (slot == \"T1\" or slot == \"M1\" or slot == \"H1\" or slot == \"R1\")\nlocal zone\nif s.v == \"N\" then zone = melee and \"side\" or \"back\"\nelseif s.v == \"C\" then zone = melee and \"front\" or \"back\"\nelseif s.v == \"S\" then zone = melee and \"front\" or \"side\"\nelse return end\nlocal x, z\nif zone == \"side\" then x, z = 81, 165\nelseif zone == \"front\" then x, z = 91.3, 151\nelse x, z = 91.3, 179 end\nif not west then x = 200 - x end\ngo(x, z)\n",
							name = "[Draw] M4S - Sword Quiver x3 partner spot",
							uuid = "2f4dcf5b-d06d-14af-ac0c-454c5cfcbc89",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 12,
				loop = true,
				mechanicTime = 743.1,
				name = "[Draw] M4S - Sword Quiver x3 partner spot",
				timeRange = true,
				timelineIndex = 114,
				timerEndOffset = 48,
				timerStartOffset = -10,
				uuid = "e794a01a-ded7-b052-806b-392c007520e0",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "r4s",
	version = "1.0.2",
}



return tbl