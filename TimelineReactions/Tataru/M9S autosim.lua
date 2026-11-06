local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "4a9c35ac-eda1-2cce-aaa7-0f8e4a93648f",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Universal AutoSim for M9S (Vamp Fatale): works for any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 549s = FFLogs median of ~3700 kills (p25 521, p75 574). No full downtime: during the Coffinmaker add\n-- (67.7 to ~113) there is always a target. Windows are re-timed on the real boss casts by the sync reaction.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 549)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM9S = {\n  kill = 549,\n  m_vs1 = add(\"MeleeDowntime\", 30.0, 37.5), -- Vamp Stomp 1 / bats\n  m_ae = add(\"MeleeDowntime\", 192.0, 199.0), -- Aetherletting puddles\n  m_vs2 = add(\"MeleeDowntime\", 229.8, 237.3), -- Vamp Stomp 2 / bats\n  m_vs3 = add(\"MeleeDowntime\", 509.8, 517.3), -- Vamp Stomp 3 / bats\n  c_vs1a = add(\"CasterDowntime\", 26.5, 30.0), -- Vamp Stomp 1 dodge\n  c_vs1b = add(\"CasterDowntime\", 38.0, 42.5), -- Blast Beat 1 into Brutal Rain\n  c_cof = add(\"CasterDowntime\", 67.0, 70.5), -- Coffinmaker spawn\n  c_ae = add(\"CasterDowntime\", 192.0, 200.0), -- Aetherletting drops\n  c_vs2a = add(\"CasterDowntime\", 226.3, 229.8), -- Vamp Stomp 2 dodge\n  c_vs2b = add(\"CasterDowntime\", 237.8, 242.3), -- Blast Beat 2\n  c_hm2 = add(\"CasterDowntime\", 246.3, 249.3), -- Half Moon 2 side swap\n  c_pl1 = add(\"CasterDowntime\", 297.2, 301.2), -- Plummet 1 / chains\n  c_hc1 = add(\"CasterDowntime\", 397.0, 399.5), -- Hell in a Cell 1 positioning\n  c_hc2 = add(\"CasterDowntime\", 418.0, 421.5), -- Hell in a Cell 2 positioning\n  c_ud = add(\"CasterDowntime\", 447.5, 451.5), -- Undead Deathmatch positioning\n  c_sg1 = add(\"CasterDowntime\", 460.0, 470.6), -- Sanguine Scratch 1 dodges\n  c_sg2 = add(\"CasterDowntime\", 478.0, 489.0), -- Sanguine Scratch 2 dodges\n  c_vs3a = add(\"CasterDowntime\", 506.3, 509.8), -- Vamp Stomp 3 dodge\n  c_vs3b = add(\"CasterDowntime\", 517.8, 522.3), -- Blast Beat 3\n  c_hm3 = add(\"CasterDowntime\", 526.3, 529.3), -- Half Moon 3 side swap\n}\n-- timing: fixed boss timeline, +-5s while the Coffinmaker add is up, kill-time spread at the end\npcall(api.addAutoSimUncertainty, 0, 0.5)\nTensorM9S.u_cof = select(2, pcall(api.addAutoSimUncertainty, 100, 5))\npcall(api.addAutoSimUncertainty, 125, 0.5)\npcall(api.addAutoSimUncertainty, 480, 15)\nself.used = true\n",
							name = "[AutoSim] M9S - setup (any job)",
							uuid = "b4c8165d-e5e4-1807-a69c-00b1542b71da",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 10.172,
				name = "[AutoSim] M9S - setup (any job)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "71fabac0-92ab-0854-a107-d9d6acdf1239",
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
							actionLua = "-- Re-time each AutoSim window on the real boss cast start (universal, any job)\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorM9S\nif not s then return end\nlocal SPEC = {\n  {45940, 1, \"m_vs1\", 4.5, 12.0, \"MeleeDowntime\"},\n  {45967, 1, \"m_ae\", 14.2, 21.2, \"MeleeDowntime\"},\n  {45940, 2, \"m_vs2\", 4.5, 12.0, \"MeleeDowntime\"},\n  {45940, 3, \"m_vs3\", 4.5, 12.0, \"MeleeDowntime\"},\n  {45940, 1, \"c_vs1a\", 1.0, 4.5, \"CasterDowntime\"},\n  {45940, 1, \"c_vs1b\", 12.5, 17.0, \"CasterDowntime\"},\n  {45875, 1, \"c_cof\", 12.0, 15.5, \"CasterDowntime\"},\n  {45967, 1, \"c_ae\", 14.2, 22.2, \"CasterDowntime\"},\n  {45940, 2, \"c_vs2a\", 1.0, 4.5, \"CasterDowntime\"},\n  {45940, 2, \"c_vs2b\", 12.5, 17.0, \"CasterDowntime\"},\n  {45940, 2, \"c_hm2\", 21.0, 24.0, \"CasterDowntime\"},\n  {45963, 1, \"c_pl1\", 8.0, 12.0, \"CasterDowntime\"},\n  {45973, 1, \"c_hc1\", 1.2, 3.7, \"CasterDowntime\"},\n  {45973, 2, \"c_hc2\", 0.2, 3.7, \"CasterDowntime\"},\n  {45984, 1, \"c_ud\", 0.0, 4.0, \"CasterDowntime\"},\n  {45989, 1, \"c_sg1\", 3.4, 14.0, \"CasterDowntime\"},\n  {45989, 2, \"c_sg2\", 3.2, 14.2, \"CasterDowntime\"},\n  {45940, 3, \"c_vs3a\", 1.0, 4.5, \"CasterDowntime\"},\n  {45940, 3, \"c_vs3b\", 12.5, 17.0, \"CasterDowntime\"},\n  {45940, 3, \"c_hm3\", 21.0, 24.0, \"CasterDowntime\"}\n}\nlocal sp = e.spellID\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif not t then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nlocal counted = false\nfor _, w in ipairs(SPEC) do\n  if w[1] == sp then\n    if not counted then\n      if not s.lastC[sp] or t - s.lastC[sp] > 5 then\n        s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1\n      end\n      counted = true\n    end\n    local key = w[3]\n    if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n      s.done = s.done or {}; s.done[key] = true\n      if s[key] then\n        local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5]); if ok then s[key] = id end\n      else\n        local ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]); if ok then s[key] = id end\n      end\n    end\n  end\nend\n",
							name = "[AutoSim] M9S - cast sync",
							uuid = "04656872-74df-a278-a37c-9c253d139139",
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
				mechanicTime = 10.172,
				name = "[AutoSim] M9S - cast sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 600,
				timerStartOffset = -8,
				uuid = "077f14d5-eef0-374d-b8ed-dc4dad0679e9",
				version = 2,
			},
		},
	}, 
	[14] = 
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "e0526525-3e91-a0a5-954f-296fa9f6f823",
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
							actionLua = "-- Vamp Fatale targetable again after the Coffinmaker add: drop the +-5s uncertainty\nlocal e = eventArgs\nif not (e and e.isTargetable) then return end\nlocal ent = TensorCore.mGetEntity(e.entityID)\nif not (ent and ent.name == \"Vamp Fatale\") then return end\nlocal s = TensorM9S\nlocal api = TensorCore.API.TensorACR\nlocal t = api.getAutoSimTime()\nif s and t and t > 90 and not s.ret then\n  s.ret = t\n  if s.u_cof then pcall(api.setAutoSimUncertainty, s.u_cof, t, 0.5) end\n  self.used = true\nend\n",
							name = "[AutoSim] M9S - Vamp Fatale return",
							uuid = "68dc5bb4-c7b9-ab2e-9f56-d76351027a19",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 26,
				mechanicTime = 67.704,
				name = "[AutoSim] M9S - Vamp Fatale return",
				timeRange = true,
				timelineIndex = 14,
				timerEndOffset = 60,
				timerStartOffset = 30,
				uuid = "1a11e1ca-fff0-bfd1-a817-6c3c36cf67ce",
				version = 2,
			},
		},
	},
	inheritedProfiles = 
	{
	},
	timelineName = "r9s",
	version = "1.5.0",
}



return tbl