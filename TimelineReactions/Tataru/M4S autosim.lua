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
	inheritedProfiles = 
	{
	},
	timelineName = "r4s",
	version = "1.0.2",
}



return tbl