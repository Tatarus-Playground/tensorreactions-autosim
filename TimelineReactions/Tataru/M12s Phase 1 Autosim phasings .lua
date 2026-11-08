local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "ef1ccab1-4d1f-5130-ba55-57324536aeb6",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Universal AutoSim for M12S phase 1 (Lindwurm): any job; phase types a job's ACR doesn't use are ignored.\n-- Phase-1 kill 418s = FFLogs median of 300 parses (p25 409, p75 427; enrage ~432.7). Timeline is fixed.\n-- Full downtime only at Act 3. Windows are re-timed on the real casts; Raptor Knuckles knockbacks add a short\n-- Stun when they actually happen (each slot is randomly Raptor Knuckles or Serpentine Scourge).\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 418)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM12a = {\n  kill = 418, stamp = Now(), cd = true,\n  f_act3 = add(\"FullDowntime\", 208.90, 221.21), -- Grotesquerie: Act 3 jump (boss untargetable)\n  m_ms = add(\"MeleeDowntime\", 22.00, 29.00), -- Before Mortal Slayer (melee spread out)\n  m_b1 = add(\"MeleeDowntime\", 95.16, 98.76), -- Burst 1 / Fourth-wall Fusion\n  m_cc = add(\"MeleeDowntime\", 133.03, 137.13), -- Cruel Coil\n  m_act3 = add(\"MeleeDowntime\", 208.91, 222.51), -- Act 3 jump + walk back in\n  m_fx3 = add(\"MeleeDowntime\", 242.50, 246.50), -- After The Fixer 3, before Curtain Call\n  m_cc2 = add(\"MeleeDowntime\", 253.50, 257.50), -- Curtain Call spotlights\n  m_b4 = add(\"MeleeDowntime\", 374.40, 378.80), -- Slaughtershed 2 / Burst 4 cycle\n  c_ms = add(\"CasterDowntime\", 40.79, 49.42), -- Mortal Slayer hits\n  c_ms2 = add(\"CasterDowntime\", 50.33, 54.25), -- After Mortal Slayer reposition\n  c_rr = add(\"CasterDowntime\", 76.69, 85.99), -- Act 1 Ravenous Reach / Phagocyte Spotlights\n  c_dl = add(\"CasterDowntime\", 89.25, 94.90), -- Act 1 Dramatic Lysis / Hemorrhagic Projection\n  c_b1 = add(\"CasterDowntime\", 98.22, 103.81), -- After Burst 1 / Fourth-wall Fusion\n  c_meta = add(\"CasterDowntime\", 221.09, 225.14), -- Metamitosis / Split Scourge\n  c_venom = add(\"CasterDowntime\", 232.21, 235.89), -- Venomous Scourge follow-up\n  c_cc1 = add(\"CasterDowntime\", 254.19, 265.60), -- Curtain Call spotlights / Ravenous Reach\n  c_cc2 = add(\"CasterDowntime\", 267.75, 279.85), -- Cell Shedding to Burst 2\n  c_ms3 = add(\"CasterDowntime\", 315.76, 320.98), -- Mortal Slayer 2 hits\n  c_s1a = add(\"CasterDowntime\", 344.08, 350.18), -- Slaughtershed 1 resolve to Burst 3\n  c_s1b = add(\"CasterDowntime\", 351.52, 360.40), -- Burst 3 into Raptor Knuckles / Serpentine Scourge\n  c_s2 = add(\"CasterDowntime\", 373.10, 383.90), -- Slaughtershed 2 to after Burst 4\n  s_cc = add(\"Stun\", 135.90, 136.79), -- Cruel Coil knockback (everyone)\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 380, 12)\nself.used = true\n",
							name = "[AutoSim] M12S P1 - setup (any job)",
							uuid = "db51c930-bcd3-183d-a9c7-621f43d3b52f",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 15.187,
				name = "[AutoSim] M12S P1 - setup (any job)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "192d24fa-dc04-87f9-a9c5-0f5ab0c14033",
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
							actionLua = "-- No countdown this pull? Set the schedule up at pull start instead (skip only if the countdown setup just ran).\nif TensorM12a and TensorM12a.cd and TensorM12a.stamp and Now() - TensorM12a.stamp < 75000 then TensorM12a.cd = nil; return end\nlocal api = TensorCore.API.TensorACR\n-- Universal AutoSim for M12S phase 1 (Lindwurm): any job; phase types a job's ACR doesn't use are ignored.\n-- Phase-1 kill 418s = FFLogs median of 300 parses (p25 409, p75 427; enrage ~432.7). Timeline is fixed.\n-- Full downtime only at Act 3. Windows are re-timed on the real casts; Raptor Knuckles knockbacks add a short\n-- Stun when they actually happen (each slot is randomly Raptor Knuckles or Serpentine Scourge).\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 418)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM12a = {\n  kill = 418, stamp = Now(),\n  f_act3 = add(\"FullDowntime\", 208.90, 221.21), -- Grotesquerie: Act 3 jump (boss untargetable)\n  m_ms = add(\"MeleeDowntime\", 22.00, 29.00), -- Before Mortal Slayer (melee spread out)\n  m_b1 = add(\"MeleeDowntime\", 95.16, 98.76), -- Burst 1 / Fourth-wall Fusion\n  m_cc = add(\"MeleeDowntime\", 133.03, 137.13), -- Cruel Coil\n  m_act3 = add(\"MeleeDowntime\", 208.91, 222.51), -- Act 3 jump + walk back in\n  m_fx3 = add(\"MeleeDowntime\", 242.50, 246.50), -- After The Fixer 3, before Curtain Call\n  m_cc2 = add(\"MeleeDowntime\", 253.50, 257.50), -- Curtain Call spotlights\n  m_b4 = add(\"MeleeDowntime\", 374.40, 378.80), -- Slaughtershed 2 / Burst 4 cycle\n  c_ms = add(\"CasterDowntime\", 40.79, 49.42), -- Mortal Slayer hits\n  c_ms2 = add(\"CasterDowntime\", 50.33, 54.25), -- After Mortal Slayer reposition\n  c_rr = add(\"CasterDowntime\", 76.69, 85.99), -- Act 1 Ravenous Reach / Phagocyte Spotlights\n  c_dl = add(\"CasterDowntime\", 89.25, 94.90), -- Act 1 Dramatic Lysis / Hemorrhagic Projection\n  c_b1 = add(\"CasterDowntime\", 98.22, 103.81), -- After Burst 1 / Fourth-wall Fusion\n  c_meta = add(\"CasterDowntime\", 221.09, 225.14), -- Metamitosis / Split Scourge\n  c_venom = add(\"CasterDowntime\", 232.21, 235.89), -- Venomous Scourge follow-up\n  c_cc1 = add(\"CasterDowntime\", 254.19, 265.60), -- Curtain Call spotlights / Ravenous Reach\n  c_cc2 = add(\"CasterDowntime\", 267.75, 279.85), -- Cell Shedding to Burst 2\n  c_ms3 = add(\"CasterDowntime\", 315.76, 320.98), -- Mortal Slayer 2 hits\n  c_s1a = add(\"CasterDowntime\", 344.08, 350.18), -- Slaughtershed 1 resolve to Burst 3\n  c_s1b = add(\"CasterDowntime\", 351.52, 360.40), -- Burst 3 into Raptor Knuckles / Serpentine Scourge\n  c_s2 = add(\"CasterDowntime\", 373.10, 383.90), -- Slaughtershed 2 to after Burst 4\n  s_cc = add(\"Stun\", 135.90, 136.79), -- Cruel Coil knockback (everyone)\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 380, 12)\nself.used = true\n",
							name = "[AutoSim] M12S P1 - setup without countdown",
							uuid = "9f644157-963f-ca86-922c-08af7b87dbd2",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 15.187,
				name = "[AutoSim] M12S P1 - setup without countdown",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -9,
				timerStartOffset = -14,
				uuid = "b6d38f43-0240-721a-b6bd-5bd1020fb9f8",
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
							actionLua = "-- Re-time each AutoSim window on the real boss cast start; add a Stun for each Raptor Knuckles knockback\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorM12a\nif not s then return end\nlocal sp = e.spellID\nlocal api = TensorCore.API.TensorACR\nif sp == 47559 then\n  -- Raptor Knuckles (random per slot): knockback ~1.2s after the helper starts, ~0.7s you can't act\n  local okT, t = pcall(api.getAutoSimTime)\n  if not (okT and t) then return end\n  if s.lastRK and t - s.lastRK < 3 then return end\n  s.lastRK = t\n  pcall(api.addAutoSimPhase, \"Stun\", t + 1.16, t + 1.85)\n  return\nend\nlocal BY = s.spec\nif not BY then\n  BY = {}\n  for _, w in ipairs({\n  {48831, 1, \"f_act3\", 6.12, 18.43, \"FullDowntime\"},\n  {46295, 1, \"m_ms\", 11.8, 18.8, \"MeleeDowntime\"},\n  {46239, 1, \"m_b1\", 1.0, 4.6, \"MeleeDowntime\"},\n  {46262, 4, \"m_cc\", 1.4, 5.5, \"MeleeDowntime\"},\n  {48649, 1, \"m_act3\", -0.1, 13.5, \"MeleeDowntime\"},\n  {46295, 3, \"m_fx3\", 6.8, 10.8, \"MeleeDowntime\"},\n  {48832, 1, \"m_cc2\", 3.6, 7.6, \"MeleeDowntime\"},\n  {46239, 4, \"m_b4\", -2.9, 1.5, \"MeleeDowntime\"},\n  {46229, 1, \"c_ms\", 12.24, 20.87, \"CasterDowntime\"},\n  {46229, 1, \"c_ms2\", 21.78, 25.7, \"CasterDowntime\"},\n  {46238, 1, \"c_rr\", 0.7, 10.0, \"CasterDowntime\"},\n  {46238, 4, \"c_dl\", 7.3, 12.95, \"CasterDowntime\"},\n  {46239, 1, \"c_b1\", 4.06, 9.65, \"CasterDowntime\"},\n  {46257, 1, \"c_meta\", 4.1, 8.15, \"CasterDowntime\"},\n  {46257, 1, \"c_venom\", 15.22, 18.9, \"CasterDowntime\"},\n  {46238, 5, \"c_cc1\", 0.64, 12.05, \"CasterDowntime\"},\n  {46238, 5, \"c_cc2\", 14.2, 26.3, \"CasterDowntime\"},\n  {46229, 2, \"c_ms3\", 12.77, 17.99, \"CasterDowntime\"},\n  {46239, 3, \"c_s1a\", -4.2, 1.9, \"CasterDowntime\"},\n  {46239, 3, \"c_s1b\", 3.24, 12.12, \"CasterDowntime\"},\n  {46239, 4, \"c_s2\", -4.2, 6.6, \"CasterDowntime\"},\n  {46262, 4, \"s_cc\", 4.27, 5.16, \"Stun\"}\n  }) do BY[w[1]] = BY[w[1]] or {}; table.insert(BY[w[1]], w) end\n  s.spec = BY\nend\nlocal ws = BY[sp]\nif not ws then return end\nlocal okT, t = pcall(api.getAutoSimTime)\nif not (okT and t) then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nif not s.lastC[sp] or t - s.lastC[sp] > 5 then s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1 end\nfor _, w in ipairs(ws) do\n  local key = w[3]\n  if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n    s.done = s.done or {}; s.done[key] = true\n    if s[key] then\n      local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5])\n      if not ok then ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]) end\n      if ok then s[key] = id end\n    else\n      local ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]); if ok then s[key] = id end\n    end\n  end\nend\n",
							name = "[AutoSim] M12S P1 - cast sync",
							uuid = "2433ec41-31c0-91ba-96c6-8b3d947d779e",
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
				mechanicTime = 15.187,
				name = "[AutoSim] M12S P1 - cast sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 440,
				timerStartOffset = -15,
				uuid = "88328ac5-b7d1-dce4-85b0-f6067e1c89cf",
				version = 2,
			},
		},
	}, 
	inheritedProfiles = 
	{
	},
	timelineName = "r12s1",
	version = "1.5.1",
}



return tbl