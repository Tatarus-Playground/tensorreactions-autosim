local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "a3f98874-1961-f41e-93d6-2ea288e233ca",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Universal AutoSim for M10S (Red Hot and Deep Blue): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 543s = FFLogs median (~4750 kills, p25 534, p75 570). Boss timeline is fixed (no HP pushes).\n-- Watery Grave (338.9-390.6) is a target, so it is not full downtime. Windows are re-timed on the real casts.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 543)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM10 = {\n  kill = 543, ids = {}, stamp = Now(),\n  f_swap = add(\"FullDowntime\", 88.46, 90.36), -- Red Hot leaves, Deep Blue arrives\n  f_st1 = add(\"FullDowntime\", 105.99, 116.99), -- Sickest Take-off 1\n  f_xs = add(\"FullDowntime\", 161.87, 177.57), -- Xtreme Spectacular\n  f_wg = add(\"FullDowntime\", 390.60, 391.90), -- Watery Grave gone, bosses return\n  m_ff = add(\"MeleeDowntime\", 33.01, 39.01), -- Flame Floater dashes\n  m_db = add(\"MeleeDowntime\", 116.99, 119.19), -- Deep Blue returns away from party\n  m_dv = add(\"MeleeDowntime\", 275.01, 280.01), -- Deep Varial / Alley-oop Inferno 3\n  m_st2 = add(\"MeleeDowntime\", 292.50, 301.00), -- Sickest Take-off 2\n  m_as1 = add(\"MeleeDowntime\", 422.02, 427.52), -- Arena Split: Deep Blue jump\n  m_as2 = add(\"MeleeDowntime\", 434.50, 441.00), -- Arena Split: Freaky Pyrotation / Sickest Take-off 3\n  m_ao5 = add(\"MeleeDowntime\", 543.47, 547.47), -- Alley-oop Inferno 5\n  c_ai1 = add(\"CasterDowntime\", 53.49, 57.49), -- Alley-oop Inferno 1\n  c_pyr = add(\"CasterDowntime\", 69.77, 75.27), -- Pyrotation\n  c_slab1 = add(\"CasterDowntime\", 118.49, 121.79), -- Awesome Slab/Splash + Alley-oop 1\n  c_ia1a = add(\"CasterDowntime\", 187.48, 192.78), -- Insane Air 1 set 1\n  c_ia1b = add(\"CasterDowntime\", 198.76, 201.76), -- Insane Air 1 set 2\n  c_ia1c = add(\"CasterDowntime\", 206.02, 209.02), -- Insane Air 1 set 3\n  c_ia1d = add(\"CasterDowntime\", 213.51, 216.76), -- Insane Air 1 set 4\n  c_snk = add(\"CasterDowntime\", 248.02, 254.22), -- Fire/Watersnaking into Alley-oop 2\n  c_dv = add(\"CasterDowntime\", 271.76, 276.21), -- Deep Varial\n  c_ai3 = add(\"CasterDowntime\", 281.00, 284.80), -- Alley-oop 3 / Awesome 2\n  c_st2 = add(\"CasterDowntime\", 292.60, 304.00), -- Sickest Take-off 2\n  c_wg = add(\"CasterDowntime\", 336.56, 347.96), -- Watery Grave start\n  c_as = add(\"CasterDowntime\", 425.82, 429.02), -- Arena Split spread\n  c_fp = add(\"CasterDowntime\", 432.00, 437.00), -- Freaky Pyrotation / Sickest Take-off 3\n  c_st3 = add(\"CasterDowntime\", 438.80, 441.80), -- Sickest Take-off 3 surf\n  c_kb = add(\"CasterDowntime\", 444.99, 450.79), -- Arena Split knockback + LP stacks\n  c_ia2a = add(\"CasterDowntime\", 475.50, 480.50), -- Insane Air 2 set 1\n  c_ia2b = add(\"CasterDowntime\", 488.19, 491.49), -- Insane Air 2 set 2\n  c_ia2c = add(\"CasterDowntime\", 498.78, 502.23), -- Insane Air 2 set 3\n  c_ia2d = add(\"CasterDowntime\", 508.52, 512.22), -- Insane Air 2 set 4\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 480, 15)\nself.used = true\n",
							name = "[AutoSim] M10S - setup (any job)",
							uuid = "9fef74bb-9d0e-22b2-ba7f-fb442e08f33c",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 14.125,
				name = "[AutoSim] M10S - setup (any job)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "bfa53b4d-73a6-64fb-88a6-ec039bc2f6e5",
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
							actionLua = "-- No countdown this pull? Set the schedule up at pull start instead (the countdown setup stamps TensorM10).\nif TensorM10 and TensorM10.stamp and Now() - TensorM10.stamp < 75000 then return end\nlocal api = TensorCore.API.TensorACR\n-- Universal AutoSim for M10S (Red Hot and Deep Blue): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 543s = FFLogs median (~4750 kills, p25 534, p75 570). Boss timeline is fixed (no HP pushes).\n-- Watery Grave (338.9-390.6) is a target, so it is not full downtime. Windows are re-timed on the real casts.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 543)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM10 = {\n  kill = 543, ids = {}, stamp = Now(),\n  f_swap = add(\"FullDowntime\", 88.46, 90.36), -- Red Hot leaves, Deep Blue arrives\n  f_st1 = add(\"FullDowntime\", 105.99, 116.99), -- Sickest Take-off 1\n  f_xs = add(\"FullDowntime\", 161.87, 177.57), -- Xtreme Spectacular\n  f_wg = add(\"FullDowntime\", 390.60, 391.90), -- Watery Grave gone, bosses return\n  m_ff = add(\"MeleeDowntime\", 33.01, 39.01), -- Flame Floater dashes\n  m_db = add(\"MeleeDowntime\", 116.99, 119.19), -- Deep Blue returns away from party\n  m_dv = add(\"MeleeDowntime\", 275.01, 280.01), -- Deep Varial / Alley-oop Inferno 3\n  m_st2 = add(\"MeleeDowntime\", 292.50, 301.00), -- Sickest Take-off 2\n  m_as1 = add(\"MeleeDowntime\", 422.02, 427.52), -- Arena Split: Deep Blue jump\n  m_as2 = add(\"MeleeDowntime\", 434.50, 441.00), -- Arena Split: Freaky Pyrotation / Sickest Take-off 3\n  m_ao5 = add(\"MeleeDowntime\", 543.47, 547.47), -- Alley-oop Inferno 5\n  c_ai1 = add(\"CasterDowntime\", 53.49, 57.49), -- Alley-oop Inferno 1\n  c_pyr = add(\"CasterDowntime\", 69.77, 75.27), -- Pyrotation\n  c_slab1 = add(\"CasterDowntime\", 118.49, 121.79), -- Awesome Slab/Splash + Alley-oop 1\n  c_ia1a = add(\"CasterDowntime\", 187.48, 192.78), -- Insane Air 1 set 1\n  c_ia1b = add(\"CasterDowntime\", 198.76, 201.76), -- Insane Air 1 set 2\n  c_ia1c = add(\"CasterDowntime\", 206.02, 209.02), -- Insane Air 1 set 3\n  c_ia1d = add(\"CasterDowntime\", 213.51, 216.76), -- Insane Air 1 set 4\n  c_snk = add(\"CasterDowntime\", 248.02, 254.22), -- Fire/Watersnaking into Alley-oop 2\n  c_dv = add(\"CasterDowntime\", 271.76, 276.21), -- Deep Varial\n  c_ai3 = add(\"CasterDowntime\", 281.00, 284.80), -- Alley-oop 3 / Awesome 2\n  c_st2 = add(\"CasterDowntime\", 292.60, 304.00), -- Sickest Take-off 2\n  c_wg = add(\"CasterDowntime\", 336.56, 347.96), -- Watery Grave start\n  c_as = add(\"CasterDowntime\", 425.82, 429.02), -- Arena Split spread\n  c_fp = add(\"CasterDowntime\", 432.00, 437.00), -- Freaky Pyrotation / Sickest Take-off 3\n  c_st3 = add(\"CasterDowntime\", 438.80, 441.80), -- Sickest Take-off 3 surf\n  c_kb = add(\"CasterDowntime\", 444.99, 450.79), -- Arena Split knockback + LP stacks\n  c_ia2a = add(\"CasterDowntime\", 475.50, 480.50), -- Insane Air 2 set 1\n  c_ia2b = add(\"CasterDowntime\", 488.19, 491.49), -- Insane Air 2 set 2\n  c_ia2c = add(\"CasterDowntime\", 498.78, 502.23), -- Insane Air 2 set 3\n  c_ia2d = add(\"CasterDowntime\", 508.52, 512.22), -- Insane Air 2 set 4\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 480, 15)\nself.used = true\n",
							name = "[AutoSim] M10S - setup without countdown",
							uuid = "b5dd29f3-8595-bae8-920b-6e5c9461f988",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 14.125,
				name = "[AutoSim] M10S - setup without countdown",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -7,
				timerStartOffset = -12,
				uuid = "217ac1b7-6a65-7545-9de6-c24d492d5986",
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
							actionLua = "-- Re-time each AutoSim window on the real boss cast start; also remember the two bosses' entity IDs\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorM10\nif not s then return end\nif e.entityContentID == 14370 or e.entityContentID == 14369 then\n  local en = TensorCore.mGetEntity(e.entityID)\n  if en and en.targetable then s.ids[e.entityContentID] = e.entityID end\nend\nlocal BY = s.spec\nif not BY then\n  BY = {}\n  for _, w in ipairs({\n  {46520, 1, \"f_swap\", 11.3, 13.2, \"FullDowntime\"},\n  {46541, 1, \"f_st1\", 4.05, 15.05, \"FullDowntime\"},\n  {46553, 1, \"f_xs\", 4.7, 20.4, \"FullDowntime\"},\n  {46535, 5, \"f_wg\", 5.95, 7.25, \"FullDowntime\"},\n  {46522, 1, \"m_ff\", 10.4, 16.4, \"MeleeDowntime\"},\n  {46542, 1, \"m_db\", 8.9, 11.1, \"MeleeDowntime\"},\n  {47249, 1, \"m_dv\", 4.9, 9.9, \"MeleeDowntime\"},\n  {46541, 2, \"m_st2\", 3.9, 12.4, \"MeleeDowntime\"},\n  {46528, 4, \"m_as1\", 2.1, 7.6, \"MeleeDowntime\"},\n  {46541, 3, \"m_as2\", 1.55, 8.05, \"MeleeDowntime\"},\n  {46528, 5, \"m_ao5\", 2.5, 6.5, \"MeleeDowntime\"},\n  {46528, 1, \"c_ai1\", 5.65, 9.65, \"CasterDowntime\"},\n  {46530, 1, \"c_pyr\", 6.1, 11.6, \"CasterDowntime\"},\n  {46542, 1, \"c_slab1\", 10.4, 13.7, \"CasterDowntime\"},\n  {47255, 1, \"c_ia1a\", -1.3, 4.0, \"CasterDowntime\"},\n  {47257, 1, \"c_ia1b\", 0.6, 3.6, \"CasterDowntime\"},\n  {47257, 2, \"c_ia1c\", 0.55, 3.55, \"CasterDowntime\"},\n  {47257, 3, \"c_ia1d\", 0.7, 3.95, \"CasterDowntime\"},\n  {45953, 1, \"c_snk\", 8.0, 14.2, \"CasterDowntime\"},\n  {47249, 1, \"c_dv\", 1.65, 6.1, \"CasterDowntime\"},\n  {46528, 3, \"c_ai3\", 5.85, 9.65, \"CasterDowntime\"},\n  {46541, 2, \"c_st2\", 4.0, 15.4, \"CasterDowntime\"},\n  {46563, 1, \"c_wg\", 7.0, 18.4, \"CasterDowntime\"},\n  {46528, 4, \"c_as\", 5.9, 9.1, \"CasterDowntime\"},\n  {46541, 3, \"c_fp\", -0.95, 4.05, \"CasterDowntime\"},\n  {46541, 3, \"c_st3\", 5.85, 8.85, \"CasterDowntime\"},\n  {46540, 3, \"c_kb\", 5.9, 11.7, \"CasterDowntime\"},\n  {46566, 1, \"c_ia2a\", -1.65, 3.35, \"CasterDowntime\"},\n  {46568, 1, \"c_ia2b\", 0.8, 4.1, \"CasterDowntime\"},\n  {46568, 2, \"c_ia2c\", 1.05, 4.5, \"CasterDowntime\"},\n  {46568, 3, \"c_ia2d\", 0.45, 4.15, \"CasterDowntime\"}\n  }) do BY[w[1]] = BY[w[1]] or {}; table.insert(BY[w[1]], w) end\n  s.spec = BY\nend\nlocal sp = e.spellID\nlocal ws = BY[sp]\nif not ws then return end\nlocal api = TensorCore.API.TensorACR\nlocal okT, t = pcall(api.getAutoSimTime)\nif not (okT and t) then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nlocal counted = false\nfor _, w in ipairs(ws) do\n  if w[1] == sp then\n    if not counted then\n      if not s.lastC[sp] or t - s.lastC[sp] > 5 then\n        s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1\n      end\n      counted = true\n    end\n    local key = w[3]\n    if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n      s.done = s.done or {}; s.done[key] = true\n      if s[key] then\n        local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5]); if ok then s[key] = id end\n      else\n        local ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]); if ok then s[key] = id end\n      end\n    end\n  end\nend\n",
							name = "[AutoSim] M10S - cast sync",
							uuid = "471c7950-f99b-be4a-85c3-d881fab121cc",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 3,
				loop = true,
				mechanicTime = 14.125,
				name = "[AutoSim] M10S - cast sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 620,
				timerStartOffset = -8,
				uuid = "70a80327-c23d-a8b3-8372-3c1ffd6f7628",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "ffcac60c-9a25-d847-8b27-a0f674789c1c",
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
							actionLua = "-- M10S draws: remember Alley-oop variant, Sickest Take-off knockback line and pair stacks (channel starts)\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nif sp ~= 46557 and sp ~= 46560 and sp ~= 46542 then return end\ndata.m10 = data.m10 or {}\nlocal m = data.m10\nlocal ent = TensorCore.mGetEntity(e.entityID)\nif sp == 46557 or sp == 46560 then\n  if m.ao and Now() - m.ao.t < 5000 then return end\n  local n = (m.ao and m.ao.n or 0) + 1\n  local ps = ent and ent.pos\n  -- facing is frozen at channel start: Deep Blue turns ~20 deg just before hit 2\n  m.ao = {kind = (sp == 46557) and \"DD\" or \"REV\", t = Now(), boss = e.entityID, n = n,\n          x = ps and ps.x, z = ps and ps.z, h = ps and ps.h}\nelseif sp == 46542 then\n  if ent and ent.pos then\n    -- knockback direction = surf heading (+pi/2 east, -pi/2 west); unknown if the heading can't be read\n    local h = ent.pos.h\n    local east\n    if h and math.abs(h) > 0.5 then east = h > 0 end\n    m.kb = {t = Now(), z = ent.pos.z, east = east}\n  end\nend\n",
							name = "[Draw] M10S - capture casts (channels)",
							uuid = "b7627d78-158f-ce1b-8db7-75cb1932aade",
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
				mechanicTime = 14.125,
				name = "[Draw] M10S - capture casts (channels)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 620,
				timerStartOffset = -8,
				uuid = "ef34b19e-2d0d-7550-859c-986ab51673de",
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
							actionLua = "-- M10S draws: Insane Air landings (pop the queue), Alley-oop puddles / hit-1 cones / hit 2 / Steam Burst wave 1,\n-- pair-stack spots, Sick Swell knockback, Xtreme Firesnaking/Watersnaking light-party split\nlocal e = eventArgs\nif not e then return end\nlocal sp = e.spellID\nlocal RED = {[46575] = true, [46579] = true, [46583] = true}\nlocal BLUE = {[46576] = true, [46580] = true, [46584] = true}\ndata.m10 = data.m10 or {}\nlocal m = data.m10\nif RED[sp] or BLUE[sp] then\n  local key = RED[sp] and \"red\" or \"blue\"\n  local ia = m.ia\n  if not ia then return end\n  -- mark the revealed spot where the boss actually landed (and any older ones) as done\n  local ent = TensorCore.mGetEntity(e.entityID)\n  local hit\n  for i, set in ipairs(ia.sets) do\n    local sp2 = set[key]\n    if sp2 and not sp2.landed and ent and ent.pos and math.abs(ent.pos.x - sp2.x) < 2.5 and math.abs(ent.pos.z - sp2.z) < 2.5 then hit = i end\n  end\n  for i, set in ipairs(ia.sets) do\n    local sp2 = set[key]\n    if sp2 and not sp2.landed and (not hit or i <= hit) then sp2.landed = true; if not hit then break end end\n  end\nelseif sp == 46529 then\n  -- Alley-oop Inferno: a lava puddle drops where each target stands ~0.45 s later (as.lua keeps following them)\n  local pd = m.pud\n  if not pd or Now() - pd.t > 3000 then pd = {t = Now(), l = {}}; m.pud = pd end\n  local q = {id = e.targetID}\n  local ent = e.targetID and TensorCore.mGetEntity(e.targetID)\n  if ent and ent.pos then q.x, q.z = ent.pos.x, ent.pos.z end\n  pd.l[#pd.l + 1] = q\nelseif sp == 46558 or sp == 46561 then\n  -- Alley-oop hit 1: one cone per player from Deep Blue; keep their headings for the hit-2 dodge\n  local ent = TensorCore.mGetEntity(e.entityID)\n  if not (ent and ent.pos) then return end\n  local c = m.aoc\n  if not c or Now() - c.t > 2000 then\n    local p = TensorCore.mGetPlayer()\n    c = {t = Now(), hs = {}, bx = ent.pos.x, bz = ent.pos.z, px = p and p.pos and p.pos.x, pz = p and p.pos and p.pos.z}\n    m.aoc = c\n  end\n  c.hs[#c.hs + 1] = e.heading or ent.pos.h\nelseif sp == 46559 or sp == 46562 then\n  -- Alley-oop hit 2 went off\n  local c = m.aoc\n  if c and not c.h2 and Now() - c.t < 5000 then c.h2 = Now() end\nelseif sp == 46587 then\n  -- Steam Burst: the first one after hit 2 is wave 1 landing\n  local c = m.aoc\n  if c and c.h2 and not c.w1 and Now() - c.t < 8000 then c.w1 = Now() end\nelseif sp == 46487 then\n  -- Freaky Pyrotation pair stack: its spot bursts again with the ~450 Steam Bursts\n  local pr = m.prs\n  if not pr or Now() - pr.t > 3000 then pr = {t = Now(), l = {}}; m.prs = pr end\n  local ent = e.targetID and TensorCore.mGetEntity(e.targetID)\n  if ent and ent.pos then pr.l[#pr.l + 1] = {ent.pos.x, ent.pos.z} end\nelseif sp == 46540 then\n  -- Sick Swell: the Sickest Take-off knockback landed\n  if m.kb and not m.kb.hit then m.kb.hit = Now() end\nelseif sp == 46510 or sp == 46511 then\n  m.snakeT = m.snakeT or Now()\n  local p = TensorCore.mGetPlayer()\n  if not (p and e.hitTargets) then return end\n  for _, id in ipairs(e.hitTargets) do\n    if id == p.id then m.fire = (sp == 46510); m.fireT = Now() end\n  end\nend\n",
							name = "[Draw] M10S - capture casts (landings, snaking)",
							uuid = "04dad8da-5d38-58c0-a540-2efe0508ba35",
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
				mechanicTime = 14.125,
				name = "[Draw] M10S - capture casts (landings, snaking)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 620,
				timerStartOffset = -8,
				uuid = "cf2c68de-22de-058a-a46d-82ca8b37a0a9",
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
							actionLua = "-- M10S draws: Insane Air landing reveal (map effects 14-22 = 3x3 grid, 13y step from 87,87)\nlocal e = eventArgs\nif not e then return end\nlocal idx = e.a1\nif not idx or idx < 14 or idx > 22 then return end\nlocal st = (e.a2 or 0) % 65536\nlocal RED = {[0x100] = \"snap\", [0x400] = \"stack\", [0x1000] = \"vertical\"}\nlocal BLUE = {[0x1] = \"snap\", [0x10] = \"stack\", [0x40] = \"vertical\"}\nlocal key = (RED[st] and \"red\") or (BLUE[st] and \"blue\")\nif not key then return end\ndata.m10 = data.m10 or {}\nlocal m = data.m10\nlocal now = Now()\nif not m.ia or now - m.ia.last > 40000 then m.ia = {sets = {}, last = now, swapped = {}, nextSwap = 1, phase2 = m.snakeT ~= nil} end\nlocal ia = m.ia\nlocal set = ia.sets[#ia.sets]\nif not set or now - set.t > 1500 then\n  set = {t = now}\n  ia.sets[#ia.sets + 1] = set\nend\nia.last = now\nlocal i = idx - 14\nset[key] = {x = 87 + 13 * (i % 3), z = 87 + 13 * math.floor(i / 3), type = (RED[st] or BLUE[st])}\n-- Insane Air 2: one role pair swaps boss each set (Vertical = tanks, else healers, melee, ranged in turn)\nif ia.phase2 and not set.swapDone then\n  set.swapDone = true\n  if (RED[st] or BLUE[st]) == \"vertical\" then ia.swapped.T = true\n  else\n    local order = {\"H\", \"M\", \"R\"}\n    local r = order[ia.nextSwap]\n    if r then ia.swapped[r] = true; ia.nextSwap = ia.nextSwap + 1 end\n  end\n  set.swapped = {T = ia.swapped.T, H = ia.swapped.H, M = ia.swapped.M, R = ia.swapped.R}\nend\n",
							name = "[Draw] M10S - capture Insane Air reveals",
							uuid = "3feb2dd5-9567-1c70-b72a-abe235600613",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Role Draws",
				eventType = 14,
				loop = true,
				mechanicTime = 14.125,
				name = "[Draw] M10S - capture Insane Air reveals",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 620,
				timerStartOffset = -8,
				uuid = "55dd0f58-fc7a-2d5d-8f03-3414eb1df064",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Targeting",
				uuid = "8475f7d0-bc49-60bd-ba34-116d4c3261ad",
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
							actionLua = "-- M10S: a boss became targetable again (boss swaps, Sickest Take-off, Xtreme Spectacular, Watery Grave, Arena Split).\n-- Fire debuff -> Red Hot, water debuff -> Deep Blue. No debuff: keep your boss if it is still up, else take the one that came back.\nlocal e = eventArgs\nif not (e and e.isTargetable) then return end\nlocal RED, BLUE = 14370, 14369\nlocal cid = e.entityContentID\nif cid ~= RED and cid ~= BLUE then return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal m = data.m10\nlocal want\nif TensorCore.hasAnyBuff(p, 4974, 4827) then want = RED\nelseif TensorCore.hasAnyBuff(p, 4975, 4828) then want = BLUE\nelseif m and m.elem and Now() - m.elem.t < 75000 then want = m.elem.cid end\nlocal t = TensorCore.mGetTarget()\nlocal onBoss = t and t.targetable and (t.contentid == RED or t.contentid == BLUE)\nif want then\n  if onBoss and t.contentid == want then return end\n  local l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\n  if not l then return end\n  for _, en in pairs(l) do\n    if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n    if type(en) == \"table\" and en.contentid == want and en.targetable then\n      Player:SetTarget(en.id)\n      return\n    end\n  end\n  return\nend\nif onBoss then return end\nPlayer:SetTarget(e.entityID)\n",
							name = "[Target] M10S - boss returns: retarget",
							uuid = "c98bee44-ecd9-1a74-8323-3d365d4eb153",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Targeting",
				eventType = 26,
				loop = true,
				mechanicTime = 14.125,
				name = "[Target] M10S - boss returns: retarget",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 620,
				uuid = "37c53b25-8116-6cbd-aae2-a2d009b4b1df",
				version = 2,
			},
		},
	}, 
	[24] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "351f3de5-3a7d-16a0-941b-2f4de4ce3d88",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Alley-oop 1: boss-relative clock spot (angle clockwise from Deep Blue's facing). Double-dip: after hit 1\n-- rotate 22.5 deg clockwise into the empty slice. Reverse: stay. From 98 logged Alley-oops.\nlocal m = data.m10\nlocal ao = m and m.ao\nif not ao or ao.n ~= 1 then return end\nlocal el = (Now() - ao.t) / 1000\nif el > 8.4 then return end\nlocal SP = {T1={0,5}, R2={45,5}, H2={90,5}, M2={135,5}, T2={180,5}, M1={225,5}, H1={270,5}, R1={315,5}}\nlocal o = SP[slot]\nif not o then return end\nlocal b = TensorCore.mGetEntity(ao.boss)\nif not (b and b.pos) then return end\nlocal h = ao.h or b.pos.h or 0\nlocal a = math.rad(o[1] + ((el > 5.7 and ao.kind == \"DD\") and 22.5 or 0))\ngo(b.pos.x + o[2] * math.sin(h - a), b.pos.z + o[2] * math.cos(h - a))\n",
							name = "[Draw] Alley-oop 1 - boss-relative spot",
							uuid = "1bf94d32-f95c-35bb-829e-e8c1bc9768f7",
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
				mechanicTime = 125.234,
				name = "[Draw] Alley-oop 1 - boss-relative spot",
				timeRange = true,
				timelineIndex = 24,
				timerEndOffset = 4.5,
				timerStartOffset = -6,
				uuid = "a170f44d-9de8-d1e0-93d8-9eae6c8f6c60",
				version = 2,
			},
		},
	},
	[43] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "7d239372-c21d-7c33-98a2-7ba27faed8de",
			},
			objectType = "folder",
		},
	},
	[57] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Targeting",
				uuid = "1db4aac5-e89f-cdbf-bae2-8c99fd53adb9",
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
							actionLua = "-- M10S: hit by Firesnaking (Red Hot) or Watersnaking (Deep Blue) -> target that boss once.\n-- Already on that boss: nothing. On the other boss (or no boss): switch.\nlocal e = eventArgs\nif not (e and e.hitTargets) then return end\nlocal sp = e.spellID\nlocal want\nif sp == 45953 or sp == 46510 then want = 14370      -- fire -> Red Hot\nelseif sp == 45954 or sp == 46511 then want = 14369  -- water -> Deep Blue\nelse return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal me = false\nfor _, id in ipairs(e.hitTargets) do if id == p.id then me = true break end end\nif not me then return end\ndata.m10 = data.m10 or {}\ndata.m10.elem = {cid = want, t = Now()}\nlocal t = TensorCore.mGetTarget()\nif t and t.contentid == want then return end\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif not l then return end\nfor _, en in pairs(l) do\n  if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n  if type(en) == \"table\" and en.contentid == want and en.targetable then\n    Player:SetTarget(en.id)\n    return\n  end\nend\n",
							name = "[Target] M10S - fire/water hit: retarget once",
							uuid = "9e05c69a-2d75-ceb2-9271-9a91ac1acfcf",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Targeting",
				eventType = 2,
				loop = true,
				mechanicTime = 245.046,
				name = "[Target] M10S - fire/water hit: retarget once",
				timeRange = true,
				timelineIndex = 57,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "de0123c6-007f-d0b5-bef8-e3523901c9be",
				version = 2,
			},
		},
	},
	[59] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "86405f4b-4940-577b-bdf4-4a00f311053b",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Alley-oop 2 (Snaking): only the light party next to Deep Blue is baited (4 cones, by role).\n-- Hit 1: spot by role, mirrored by Deep Blue's side; hit 2 (both variants): group up in front of Deep Blue.\nlocal m = data.m10\nlocal ao = m and m.ao\nif not ao or ao.n ~= 2 or not ao.x then return end\nlocal el = (Now() - ao.t) / 1000\nif el > 8.4 then return end\nif TensorCore.getDistance2d(p.pos, {x = ao.x, y = p.pos.y, z = ao.z}) > 16 then return end\nlocal role = slot:sub(1, 1)\nlocal NORTH = {T = {82, 4.7}, H = {52, 5.3}, M = {280, 4.9}, R = {308, 5.4}}\nlocal SOUTH = {T = {280, 4.4}, H = {306, 5.0}, M = {81, 4.7}, R = {50, 6.2}}\nlocal o = ((ao.z < 100) and NORTH or SOUTH)[role]\nif not o then return end\nif el > 5.7 then o = {0, 5} end\nlocal h = math.pi / 2\nlocal a = math.rad(o[1])\ngo(ao.x + o[2] * math.sin(h - a), ao.z + o[2] * math.cos(h - a))\n",
							name = "[Draw] Alley-oop 2 - Snaking spot",
							uuid = "0a63d4da-0549-3be6-ac32-62d1da010120",
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
				mechanicTime = 257.452,
				name = "[Draw] Alley-oop 2 - Snaking spot",
				timeRange = true,
				timelineIndex = 59,
				timerEndOffset = 4.5,
				timerStartOffset = -6,
				uuid = "5ec55fcf-6130-f3f4-b100-de124a2f856c",
				version = 2,
			},
		},
	},
	[118] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "e68743c0-2cd7-88af-9b43-c63e9c246e9c",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function clamp(v) return math.max(80.5, math.min(119.5, v)) end\nlocal function go(x, z)\n  local dest = {x = clamp(x), y = p.pos.y, z = clamp(z)}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Arena Split: puddles -> proteans (mirrored by Deep Blue's side) -> pair stacks -> knockback -> LP stacks.\n-- G1 (T1 H1 M1 R1) is always west, G2 east. Checked against 21 logged pulls.\n-- Shown in order: puddle spot -> spread (bait) spot -> one safe spot from the second cones -> pair stack ->\n-- spot before the knockback -> LP stack. At ~450 every puddle, every pair-stack spot, the centre and the surf\n-- line burst (Steam Burst r ~9): the LP stack spot moves out of those if one would reach it.\ndata.m10 = data.m10 or {}\nlocal m = data.m10\n-- own clock: when this draw's window opened (puddles drop ~10 s later); old data from before it is ignored\nif not m.asW or Now() - m.asW > 40000 then m.asW = Now() end\nlocal wel = (Now() - m.asW) / 1000\n-- puddles land where their targets stand ~0.45 s after the Alley-oop Inferno cast: follow them until then\nlocal pud = m.pud\nif pud and Now() - pud.t <= 450 then\n  for _, q in ipairs(pud.l) do\n    local en = q.id and TensorCore.mGetEntity(q.id)\n    if en and en.pos then q.x, q.z = en.pos.x, en.pos.z end\n  end\nend\nlocal ao = m.ao\nif ao and ao.t < m.asW then ao = nil end\n-- Arena Split's Alley-oop is the one where Deep Blue stands at x 88 or 112 on the centre line\nif ao then\n  local here = ao.x and ao.z and math.abs(math.abs(ao.x - 100) - 12) < 1.5 and math.abs(ao.z - 100) < 1.5\n  if not (here or (ao.x == nil and ao.n == 3)) then ao = nil end\nend\nlocal g1 = (slot == \"T1\" or slot == \"H1\" or slot == \"M1\" or slot == \"R1\")\nlocal PUD = {R1 = {81, 81}, T1 = {81, 87.3}, M1 = {81, 112.3}, H1 = {81, 119},\n             R2 = {119, 81}, T2 = {118.3, 88.6}, M2 = {118.7, 112.2}, H2 = {119, 119}}\nif not ao then\n  -- puddle spot only until the puddles drop; never send you back there later\n  if wel < 10.5 then local o = PUD[slot]; if o then go(o[1], o[2]) end end\n  return\nend\nlocal el = (Now() - ao.t) / 1000\nlocal west = (ao.x or 100) < 100\nlocal PAIR = {T1 = {90, 85.5}, R1 = {90, 85.5}, H1 = {90, 112.6}, M1 = {90, 112.6},\n              T2 = {110, 87}, R2 = {110, 87}, H2 = {110, 111.5}, M2 = {110, 111.5}}\nlocal pi = math.pi\nlocal sqrt, abs = math.sqrt, math.abs\nlocal function dist(ax, az, bx, bz) return sqrt((ax - bx) ^ 2 + (az - bz) ^ 2) end\nlocal function clear(x, z, ds)\n  local mn = math.huge\n  for _, q in ipairs(ds) do\n    local v = dist(x, z, q[1], q[2]) - q[3]\n    if v < mn then mn = v end\n  end\n  return mn\nend\n-- hit 1: near group huddles by Deep Blue, far group on its own side (spots for Deep Blue WEST, mirrored for EAST)\nlocal NEAR = {T = {83.3, 97.5}, M = {84.6, 102.5}, H = {86.5, 107}, R = {87, 93.5}}\nlocal FAR = {T = {105.5, 96.5}, M = {105.5, 104.5}, H = {105, 119.2}, R = {105, 81.1}}\nlocal c = m.aoc\nif c and c.t < ao.t then c = nil end\nif c and Now() - c.t > 200 and #c.hs > 0 and c.px then -- all 8 hit-1 cones are in by then\n  -- hit 2: Double-dip fires the same cones again (dodge into the empty slice), Reverse splits each cone into\n  -- two at +-22.5 deg (stay unless a split cone is on you). One safe spot, at least 18 deg (Double-dip, widest logged hit 16.7) /\n  -- 12 deg (Reverse, widest logged hit 11 deg) clear of every cone.\n  if not c.safe then\n    local danger = {}\n    for _, h in ipairs(c.hs) do\n      if ao.kind == \"REV\" then\n        danger[#danger + 1] = h + pi / 8; danger[#danger + 1] = h - pi / 8\n      else danger[#danger + 1] = h end\n    end\n    local need = math.rad((ao.kind == \"REV\") and 12 or 18)\n    local function gap(a)\n      local mn = math.huge\n      for _, d in ipairs(danger) do\n        local v = (a - d) % (2 * pi)\n        if v > pi then v = 2 * pi - v end\n        if v < mn then mn = v end\n      end\n      return mn\n    end\n    -- nearest spot (0.5 y grid, within 12 y, inside the arena) with that much room; Double-dip also needs\n    -- 1 y outside the cone's 15 deg edge. If none, the spot within 12 y with the most room.\n    local half = math.rad(15)\n    local bx, bz = c.bx, c.bz\n    local bestd, bx2, bz2, bv, fx, fz\n    for i = -24, 24 do\n      for j = -24, 24 do\n        local x, z = c.px + i * 0.5, c.pz + j * 0.5\n        local d = dist(x, z, c.px, c.pz)\n        if d <= 12 and x >= 81 and x <= 119 and z >= 81 and z <= 119 then\n          local g = gap(math.atan2(x - bx, z - bz))\n          local ok = g >= need\n          if ok and ao.kind ~= \"REV\" then ok = dist(x, z, bx, bz) * math.sin(math.min(pi / 2, g - half)) >= 1 end\n          if ok and (not bestd or d < bestd) then bestd, bx2, bz2 = d, x, z end\n          if not bv or g > bv then bv, fx, fz = g, x, z end\n        end\n      end\n    end\n    c.safe = bestd and {bx2, bz2} or {fx, fz}\n  end\n  -- safe spot until hit 2 goes off, then the pair stack\n  if not c.h2 and Now() - c.t < 2900 then go(c.safe[1], c.safe[2]) return end\nelseif el < 8.45 then\n  -- your spread (bait) spot until hit 1 goes off\n  local o = ((g1 == west) and NEAR or FAR)[slot:sub(1, 1)]\n  if not o then return end\n  go(west and o[1] or (200 - o[1]), o[2])\n  return\nend\nlocal kb = m.kb\nif kb and kb.t < ao.t then kb = nil end\nif not kb then\n  local o = PAIR[slot]\n  if o then go(o[1], o[2]) end\n  return\nend\nif kb.hit and Now() - kb.hit > 4500 then return end -- LP stacks and Steam Burst bubbles done\n-- LP spot: 11 y from the centre bubble; moved (<= 6 y, least move) when another bubble of the ~450 Steam Burst\n-- would reach it: every puddle, every pair-stack spot, the centre and the surf line's middle burst (r ~9.8)\nif not kb.lp then\n  local z0 = (abs((kb.z or 85) - 100) < 5) and 103 or 100\n  local x0 = g1 and 89 or 111\n  local bubs = {{100, 100, 11}, {100, kb.z or 100, 11}}\n  if pud and pud.t > ao.t - 3000 then\n    for _, q in ipairs(pud.l) do if q.x then bubs[#bubs + 1] = {q.x, q.z, 11} end end\n  end\n  local prs = m.prs\n  if prs and prs.t > ao.t then\n    for _, q in ipairs(prs.l) do bubs[#bubs + 1] = {q[1], q[2], 11} end\n  end\n  local lx, lz = x0, z0\n  if clear(x0, z0, bubs) < 0 then\n    local bk1, bk2\n    for i = -12, 12 do\n      for j = -12, 12 do\n        local x, z = x0 + i * 0.5, z0 + j * 0.5\n        local off = sqrt((i * 0.5) ^ 2 + (j * 0.5) ^ 2)\n        -- the pre-knockback spot (x -+ 10) has to stay inside the arena\n        if off <= 6 and not ((kb.east == true and x < 89) or (kb.east == false and x > 111)) then\n          local v = clear(x, z, bubs)\n          local k1, k2 = 1, -v\n          if v >= 0 then k1, k2 = 0, off end\n          if not bk1 or k1 < bk1 or (k1 == bk1 and k2 < bk2) then bk1, bk2, lx, lz = k1, k2, x, z end\n        end\n      end\n    end\n  end\n  kb.lp = {lx, lz}\nend\nlocal lpx, z = kb.lp[1], kb.lp[2]\n-- after the knockback (Sick Swell lands ~7 s after the surf starts): LP stack, then wait out the bubbles there\nif kb.hit or (Now() - kb.t) > 7100 or kb.east == nil then go(lpx, z) return end\n-- before it: stand 10 y up-wind of your LP stack, the push carries you onto it\ngo(kb.east and (lpx - 10) or (lpx + 10), z)\n",
							name = "[Draw] Arena Split - your spot",
							uuid = "19a2732d-52c1-e400-a6c0-e015beedb94d",
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
				mechanicTime = 429.747,
				name = "[Draw] Arena Split - your spot",
				timeRange = true,
				timelineIndex = 118,
				timerEndOffset = 22,
				timerStartOffset = -14,
				uuid = "e7286e64-f08c-385f-b901-13861cf2a284",
				version = 2,
			},
		},
	},
	[126] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "1d4d0826-05f5-9b2f-b59d-c841ac4dc6a2",
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
							actionLua = "-- BLM: plan an 8.2s Stun for the LB animation while Auto LB is requested (next action).\n-- If no LB is cast within 3s (bar not full), drop the planned Stun; the request itself stays on.\nlocal s = TensorM10\nif not s or s.lbDone then return end\nlocal api = TensorCore.API.TensorACR\nlocal okT, t = pcall(api.getAutoSimTime)\nif not s.lbReqT then\n  s.lbReqT = Now()\n  if okT and t then local ok, id = pcall(api.addAutoSimPhase, \"Stun\", t + 0.3, t + 8.5); if ok then s.lbStun = id end end\nelseif not s.lbCast and s.lbStun and Now() - s.lbReqT > 3000 then\n  pcall(api.removeAutoSimPhase, s.lbStun); s.lbStun = nil\nend\n",
							conditions = 
							{
								
								{
									"62837448-82ee-cd72-883d-93dc27eaca11",
									true,
								},
								
								{
									"8b86191c-bd89-4d9f-9773-12eb66809cc9",
									true,
								},
							},
							name = "Plan LB Stun",
							uuid = "10aa8baa-0188-c8eb-ad4e-adae09ac8da2",
							version = 2.1,
						},
					},
					
					{
						data = 
						{
							aType = "ACR",
							conditions = 
							{
								
								{
									"62837448-82ee-cd72-883d-93dc27eaca11",
									true,
								},
								
								{
									"8b86191c-bd89-4d9f-9773-12eb66809cc9",
									true,
								},
							},
							gVar = "ACR_TensorNuke4_Hotbar_LimitBreakAuto",
							name = "Auto LB",
							uuid = "16fda5f7-2b2e-1f37-9ea6-d93c16ed264b",
							variableTogglesType = 2,
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "62837448-82ee-cd72-883d-93dc27eaca11",
							version = 3,
						},
					},
					
					{
						data = 
						{
							category = "Lua",
							conditionLua = "-- Both bosses targetable and inside one Meteor (radius 15, centred on the target) - LB not used yet\nlocal s = TensorM10\nif not s or s.lbDone or not s.ids then return false end\nlocal ri, bi = s.ids[14370], s.ids[14369]\nlocal r = ri and TensorCore.mGetEntity(ri)\nlocal b = bi and TensorCore.mGetEntity(bi)\nif not (r and b and r.pos and b.pos and r.targetable and b.targetable) then return false end\nreturn TensorCore.getDistance2d(r.pos, b.pos) <= 15 + math.min(r.hitradius or 0, b.hitradius or 0)\n",
							name = "Both bosses in one Meteor",
							uuid = "8b86191c-bd89-4d9f-9773-12eb66809cc9",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				loop = true,
				mechanicTime = 448.559,
				name = "[BLM] M10S - Auto LB after Arena Split (both bosses)",
				timeRange = true,
				timelineIndex = 126,
				timerEndOffset = 25.5,
				timerStartOffset = 0.2,
				uuid = "0fe24abb-0064-5dd2-9096-7ac22631d38b",
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
							actionLua = "-- BLM: your Limit Break cast started: re-time the Stun to the real lockout and turn the request off\nlocal e = eventArgs\nlocal p = TensorCore.mGetPlayer()\nif not (e and p and e.entityID == p.id) then return end\nlocal LOCK = {[203] = 5.1, [204] = 6.1, [205] = 8.2}\nlocal lock = LOCK[e.spellID]\nif not lock then return end\nlocal s = TensorM10\nlocal api = TensorCore.API.TensorACR\nlocal okT, t = pcall(api.getAutoSimTime)\nif s and okT and t then\n  s.lbCast = true; s.lbDone = true\n  if s.lbStun then\n    local ok, id = pcall(api.setAutoSimPhase, s.lbStun, t, t + lock); if ok then s.lbStun = id end\n  else\n    local ok, id = pcall(api.addAutoSimPhase, \"Stun\", t, t + lock); if ok then s.lbStun = id end\n  end\nend\nself.used = true\n",
							conditions = 
							{
								
								{
									"a1f99a0d-43f8-1fd7-b9ea-97f7e89b6b10",
									true,
								},
							},
							name = "[BLM] M10S - LB stun re-time",
							uuid = "1afa4183-e404-c7c7-b7b0-80a5d6d29c63",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "a1f99a0d-43f8-1fd7-b9ea-97f7e89b6b10",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				eventType = 3,
				loop = true,
				mechanicTime = 448.559,
				name = "[BLM] M10S - LB stun re-time",
				timeRange = true,
				timelineIndex = 126,
				timerEndOffset = 27,
				uuid = "84f60369-c42a-a129-8140-5c3424bd880d",
				version = 2,
			},
		},
	},
	[129] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Targeting",
				uuid = "7aa3aec6-8009-5d53-94fa-70e38f8f9a0f",
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
							actionLua = "-- M10S: hit by Firesnaking (Red Hot) or Watersnaking (Deep Blue) -> target that boss once.\n-- Already on that boss: nothing. On the other boss (or no boss): switch.\nlocal e = eventArgs\nif not (e and e.hitTargets) then return end\nlocal sp = e.spellID\nlocal want\nif sp == 45953 or sp == 46510 then want = 14370      -- fire -> Red Hot\nelseif sp == 45954 or sp == 46511 then want = 14369  -- water -> Deep Blue\nelse return end\nlocal p = TensorCore.mGetPlayer()\nif not p then return end\nlocal me = false\nfor _, id in ipairs(e.hitTargets) do if id == p.id then me = true break end end\nif not me then return end\ndata.m10 = data.m10 or {}\ndata.m10.elem = {cid = want, t = Now()}\nlocal t = TensorCore.mGetTarget()\nif t and t.contentid == want then return end\nlocal l = TensorCore.getEntityGroupList(\"ContentID\", {contentid = want})\nif not l then return end\nfor _, en in pairs(l) do\n  if type(en) == \"number\" then en = TensorCore.mGetEntity(en) end\n  if type(en) == \"table\" and en.contentid == want and en.targetable then\n    Player:SetTarget(en.id)\n    return\n  end\nend\n",
							name = "[Target] M10S - fire/water hit: retarget once",
							uuid = "a5f22003-47c5-f941-be77-ddc900b3662e",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "Targeting",
				eventType = 2,
				loop = true,
				mechanicTime = 469.153,
				name = "[Target] M10S - fire/water hit: retarget once",
				timeRange = true,
				timelineIndex = 129,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "ee071106-4124-634c-8452-2f5e1eaff5bc",
				version = 2,
			},
		},
	},
	[130] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "BLM Optimization",
				uuid = "828e6c5a-5f2a-8d64-9d2b-1fc38c7427c5",
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
							actionLua = "-- BLM: Insane Air 2 is starting: no LB was cast, so drop the planned Stun and stop the request\nlocal s = TensorM10\nif s and s.lbStun and not s.lbCast then pcall(TensorCore.API.TensorACR.removeAutoSimPhase, s.lbStun); s.lbStun = nil end\nif s then s.lbDone = true end\nself.used = true\n",
							conditions = 
							{
								
								{
									"613dd4dd-a955-1cee-ba96-f2148904e229",
									true,
								},
							},
							name = "[BLM] M10S - LB request off (Insane Air 2)",
							uuid = "259df6a4-dbc2-7447-8110-167003c824b0",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
					
					{
						data = 
						{
							category = "Self",
							conditionType = 13,
							jobValue = "BLACKMAGE",
							name = "Black Mage",
							uuid = "613dd4dd-a955-1cee-ba96-f2148904e229",
							version = 3,
						},
					},
				},
				displayPath = "BLM Optimization",
				mechanicTime = 483.918,
				name = "[BLM] M10S - LB request off (Insane Air 2)",
				timeRange = true,
				timelineIndex = 130,
				timerEndOffset = -7.5,
				timerStartOffset = -9.5,
				uuid = "4f74e631-4c37-dea2-9ec9-365c8812193e",
				version = 2,
			},
		},
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "a92334fa-f594-b17c-8a8f-557a9b444195",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\n-- Insane Air: arrow to where YOUR boss lands next; gone once it lands.\n-- Insane Air 1: G1 (T1 H1 M1 R1) = Deep Blue, G2 = Red Hot. Insane Air 2: fire party (Xtreme Firesnaking) = Red Hot,\n-- and each set one role pair swaps (Vertical = tanks, else healers, melee, ranged in turn). From 42 / 13 logged pulls.\nlocal m = data.m10\nlocal ia = m and m.ia\nif not ia then return end\nlocal g1 = (slot == \"T1\" or slot == \"H1\" or slot == \"M1\" or slot == \"R1\")\nlocal role = slot:sub(1, 1)\nfor _, set in ipairs(ia.sets) do\n  local mine\n  if ia.phase2 then\n    if m.fire == nil then return end\n    local sw = set.swapped and set.swapped[role]\n    mine = ((m.fire and not sw) or (not m.fire and sw)) and \"red\" or \"blue\"\n  else\n    mine = g1 and \"blue\" or \"red\"\n  end\n  local spot = set[mine]\n  if spot and not spot.landed then\n    local col = (mine == \"red\") and 0xFF3355FF or 0xFFFF9933\n    local dest = {x = spot.x, y = p.pos.y, z = spot.z}\n    local g = TensorCore.getCachedDrawer(0x55000000 + col % 0x1000000, 0x88000000 + col % 0x1000000, col, 0xFF000000, 2)\n    local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n    local d = TensorCore.getDistance2d(p.pos, dest)\n    if d > 1.0 then\n      local tip = math.min(2.0, d * 0.3)\n      g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.8, tip, 1.6, false, flags)\n    end\n    g:addCircle(dest.x, dest.y, dest.z, 1.2, false, flags)\n    return\n  end\nend\n",
							name = "[Draw] Insane Air 2 - your boss landing",
							uuid = "53cbdc8e-e4b2-1cfb-83fe-d6aa1f1b29e1",
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
				mechanicTime = 483.918,
				name = "[Draw] Insane Air 2 - your boss landing",
				timeRange = true,
				timelineIndex = 130,
				timerEndOffset = 38,
				timerStartOffset = -8,
				uuid = "4c834dd7-1dce-38f2-8243-e87c74860364",
				version = 2,
			},
		},
	},
	[148] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "Role Draws",
				uuid = "b1190e11-2118-ece7-8fa0-3c3abd277850",
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
							actionLua = "local Ro = AnyoneCore and AnyoneCore.Roster\nlocal slot = Ro and Ro.mySlot and Ro.mySlot()\nif not slot and GetCurrentRole then local r = GetCurrentRole(); slot = (r == \"MT\" and \"T1\") or (r == \"OT\" and \"T2\") or r end\nif not slot then return end\nlocal p = TensorCore.mGetPlayer()\nif not (p and p.pos) then return end\nlocal function go(x, z)\n  local dest = {x = x, y = p.pos.y, z = z}\n  local g = TensorCore.getCachedDrawer(0x7733FF33, 0xAA33FF33, 0xFF33FF33, 0xFF000000, 2)\n  local flags = Argus2.RenderFlags.FLAG_RENDER_OVERLAY\n  local d = TensorCore.getDistance2d(p.pos, dest)\n  if d > 0.8 then\n    local tip = math.min(1.5, d * 0.35)\n    g:addArrow(p.pos.x, p.pos.y, p.pos.z, TensorCore.getHeadingToTarget(p.pos, dest), math.max(0.1, d - tip), 0.65, tip, 1.3, false, flags)\n  end\n  g:addCircle(dest.x, dest.y, dest.z, 0.65, false, flags)\nend\n-- Alley-oop 4: boss-relative clock spot (angle clockwise from Deep Blue's facing). Double-dip: after hit 1\n-- rotate 22.5 deg clockwise into the empty slice. Reverse: stay. From 98 logged Alley-oops.\nlocal m = data.m10\nlocal ao = m and m.ao\nif not ao or ao.n ~= 4 then return end\nlocal el = (Now() - ao.t) / 1000\nif el > 8.4 then return end\nlocal SP = {T1={0,18}, R2={45,23}, H2={90,18.5}, M2={135,15}, T2={180,12}, M1={225,16}, H1={270,15.6}, R1={315,23}}\nlocal o = SP[slot]\nif not o then return end\nlocal b = TensorCore.mGetEntity(ao.boss)\nif not (b and b.pos) then return end\nlocal h = math.pi\nlocal a = math.rad(o[1] + ((el > 5.7 and ao.kind == \"DD\") and 22.5 or 0))\ngo(b.pos.x + o[2] * math.sin(h - a), b.pos.z + o[2] * math.cos(h - a))\n",
							name = "[Draw] Alley-oop 4 - boss-relative spot",
							uuid = "31658b92-7263-a5a5-a1a0-d72c8b73a2e9",
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
				mechanicTime = 543.199,
				name = "[Draw] Alley-oop 4 - boss-relative spot",
				timeRange = true,
				timelineIndex = 148,
				timerEndOffset = 6,
				timerStartOffset = -6,
				uuid = "e0969a31-27b9-e180-b2f3-dede1c942250",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "r10s",
	version = "1.5.0",
}



return tbl