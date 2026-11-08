local tbl = 
{
	
	{
		
		{
			data = 
			{
				displayPath = "",
				name = "AutoSim",
				uuid = "78fb1c3d-319b-1d9a-a004-2716bf23b6ab",
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
							actionLua = "local api = TensorCore.API.TensorACR\n-- Universal AutoSim for M12S phase 2 (Lindwurm II): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 526s = FFLogs median of 30 clears (p25 519, p75 534; raalm top-200 518; real enrage ~553, Arcadian Hell\n-- at 515/531 is not the enrage). The boss is always targetable and the timeline is fixed. Windows are re-timed on the\n-- real casts. No knockback/knock-up hits everyone here, so there are no Stun phases.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 526)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM12b = {\n  kill = 526, stamp = Now(), cd = true,\n  m_ffs = add(\"MeleeDowntime\", 124.80, 129.50), -- Firefall Splash\n  m_el = add(\"MeleeDowntime\", 221.80, 225.00), -- Blood Wakening element pair\n  m_met = add(\"MeleeDowntime\", 336.95, 341.45), -- Power Gusher / Snaking Kick + Lindwurm's Meteor\n  m_re2 = add(\"MeleeDowntime\", 437.00, 441.60), -- Reenactment 2: Heavy Slam / Mana Burst\n  m_tv8 = add(\"MeleeDowntime\", 458.20, 462.20), -- After Twisted Vision 8: Heavy Slam / Mana Burst\n  c_ws2 = add(\"CasterDowntime\", 55.47, 58.85), -- Before Winged Scourge 2\n  c_ds1 = add(\"CasterDowntime\", 63.63, 66.88), -- Double Sobat 1\n  c_ef1 = add(\"CasterDowntime\", 71.75, 74.75), -- Esoteric Finisher 1\n  c_st1 = add(\"CasterDowntime\", 100.02, 102.65), -- After Staging 1\n  c_rep2 = add(\"CasterDowntime\", 109.50, 118.00), -- Replication 2\n  c_ffs = add(\"CasterDowntime\", 123.00, 126.80), -- Firefall Splash\n  c_mb = add(\"CasterDowntime\", 131.30, 134.80), -- Mana Burst / Grotesquerie\n  c_re1a = add(\"CasterDowntime\", 164.00, 168.25), -- Reenactment 1 replay A\n  c_re1b = add(\"CasterDowntime\", 169.50, 173.50), -- Reenactment 1 replay B\n  c_bw = add(\"CasterDowntime\", 219.25, 223.25), -- Blood Wakening / Netherworld\n  c_met1 = add(\"CasterDowntime\", 335.40, 338.40), -- Before Lindwurm's Meteor\n  c_met2 = add(\"CasterDowntime\", 340.00, 343.50), -- Lindwurm's Meteor\n  c_tv4 = add(\"CasterDowntime\", 365.90, 370.30), -- Twisted Vision 4: Heavy Slam / Mana Burst\n  c_arc = add(\"CasterDowntime\", 372.00, 384.00), -- Arcanum towers: Heavy Slam / Mana Burst chain\n  c_ck = add(\"CasterDowntime\", 400.00, 405.50), -- Cosmic Kiss / Dark II / Stone III\n  c_tv8 = add(\"CasterDowntime\", 455.50, 459.80), -- Twisted Vision 8: Heavy Slam / Mana Burst\n  c_ef3 = add(\"CasterDowntime\", 490.00, 499.00), -- Esoteric Finisher 3 to Replication\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 480, 12)\nself.used = true\n",
							name = "[AutoSim] M12S P2 - setup (any job)",
							uuid = "cc8a875f-5b6b-1883-9984-cc978e6bf613",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				eventType = 16,
				mechanicTime = 15.125,
				name = "[AutoSim] M12S P2 - setup (any job)",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -5,
				timerStartOffset = -60,
				uuid = "fea7ce3e-e8cb-97bc-8a12-e62fb13fdb79",
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
							actionLua = "-- No countdown this pull? Set the schedule up at pull start instead (skip only if the countdown setup just ran).\nif TensorM12b and TensorM12b.cd and TensorM12b.stamp and Now() - TensorM12b.stamp < 75000 then TensorM12b.cd = nil; return end\nlocal api = TensorCore.API.TensorACR\n-- Universal AutoSim for M12S phase 2 (Lindwurm II): any job; phase types a job's ACR doesn't use are ignored.\n-- Kill 526s = FFLogs median of 30 clears (p25 519, p75 534; raalm top-200 518; real enrage ~553, Arcadian Hell\n-- at 515/531 is not the enrage). The boss is always targetable and the timeline is fixed. Windows are re-timed on the\n-- real casts. No knockback/knock-up hits everyone here, so there are no Stun phases.\npcall(api.clearAutoSimPhases, \"FullDowntime\")\npcall(api.clearAutoSimPhases, \"MeleeDowntime\")\npcall(api.clearAutoSimPhases, \"CasterDowntime\")\npcall(api.clearAutoSimPhases, \"Stun\")\npcall(api.clearAutoSimUncertainty)\npcall(api.setAutoSimKillTime, 526)\nlocal function add(kind, a, b)\n  local ok, id = pcall(api.addAutoSimPhase, kind, a, b)\n  if ok then return id end\nend\nTensorM12b = {\n  kill = 526, stamp = Now(),\n  m_ffs = add(\"MeleeDowntime\", 124.80, 129.50), -- Firefall Splash\n  m_el = add(\"MeleeDowntime\", 221.80, 225.00), -- Blood Wakening element pair\n  m_met = add(\"MeleeDowntime\", 336.95, 341.45), -- Power Gusher / Snaking Kick + Lindwurm's Meteor\n  m_re2 = add(\"MeleeDowntime\", 437.00, 441.60), -- Reenactment 2: Heavy Slam / Mana Burst\n  m_tv8 = add(\"MeleeDowntime\", 458.20, 462.20), -- After Twisted Vision 8: Heavy Slam / Mana Burst\n  c_ws2 = add(\"CasterDowntime\", 55.47, 58.85), -- Before Winged Scourge 2\n  c_ds1 = add(\"CasterDowntime\", 63.63, 66.88), -- Double Sobat 1\n  c_ef1 = add(\"CasterDowntime\", 71.75, 74.75), -- Esoteric Finisher 1\n  c_st1 = add(\"CasterDowntime\", 100.02, 102.65), -- After Staging 1\n  c_rep2 = add(\"CasterDowntime\", 109.50, 118.00), -- Replication 2\n  c_ffs = add(\"CasterDowntime\", 123.00, 126.80), -- Firefall Splash\n  c_mb = add(\"CasterDowntime\", 131.30, 134.80), -- Mana Burst / Grotesquerie\n  c_re1a = add(\"CasterDowntime\", 164.00, 168.25), -- Reenactment 1 replay A\n  c_re1b = add(\"CasterDowntime\", 169.50, 173.50), -- Reenactment 1 replay B\n  c_bw = add(\"CasterDowntime\", 219.25, 223.25), -- Blood Wakening / Netherworld\n  c_met1 = add(\"CasterDowntime\", 335.40, 338.40), -- Before Lindwurm's Meteor\n  c_met2 = add(\"CasterDowntime\", 340.00, 343.50), -- Lindwurm's Meteor\n  c_tv4 = add(\"CasterDowntime\", 365.90, 370.30), -- Twisted Vision 4: Heavy Slam / Mana Burst\n  c_arc = add(\"CasterDowntime\", 372.00, 384.00), -- Arcanum towers: Heavy Slam / Mana Burst chain\n  c_ck = add(\"CasterDowntime\", 400.00, 405.50), -- Cosmic Kiss / Dark II / Stone III\n  c_tv8 = add(\"CasterDowntime\", 455.50, 459.80), -- Twisted Vision 8: Heavy Slam / Mana Burst\n  c_ef3 = add(\"CasterDowntime\", 490.00, 499.00), -- Esoteric Finisher 3 to Replication\n}\npcall(api.addAutoSimUncertainty, 0, 0.5)\npcall(api.addAutoSimUncertainty, 480, 12)\nself.used = true\n",
							name = "[AutoSim] M12S P2 - setup without countdown",
							uuid = "439d939d-077a-6fec-9fe0-4eabf668b068",
							version = 2.1,
						},
					},
				},
				conditions = 
				{
				},
				displayPath = "AutoSim",
				loop = true,
				mechanicTime = 15.125,
				name = "[AutoSim] M12S P2 - setup without countdown",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = -9,
				timerStartOffset = -14,
				uuid = "3da5c89c-bb97-0dff-81cb-8cd1b161c946",
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
							actionLua = "-- Re-time each AutoSim window on the real boss cast start\nself.used = true -- one run per queued event (without this TensorReactions re-runs it every tick)\nlocal e = eventArgs\nif not e then return end\nlocal s = TensorM12b\nif not s then return end\nlocal sp = e.spellID\nlocal BY = s.spec\nif not BY then\n  BY = {}\n  for _, w in ipairs({\n  {46307, 1, \"m_ffs\", 2.9, 7.6, \"MeleeDowntime\"},\n  {46336, 1, \"m_el\", 7.75, 10.95, \"MeleeDowntime\"},\n  {48098, 3, \"m_met\", 6.0, 10.5, \"MeleeDowntime\"},\n  {46316, 2, \"m_re2\", 3.4, 8.0, \"MeleeDowntime\"},\n  {48098, 8, \"m_tv8\", 8.9, 12.9, \"MeleeDowntime\"},\n  {46375, 1, \"c_ws2\", 15.47, 18.85, \"CasterDowntime\"},\n  {46375, 1, \"c_ds1\", 23.63, 26.88, \"CasterDowntime\"},\n  {46368, 1, \"c_ef1\", 7.55, 10.55, \"CasterDowntime\"},\n  {46305, 1, \"c_st1\", 11.87, 14.5, \"CasterDowntime\"},\n  {46296, 2, \"c_rep2\", 7.2, 15.7, \"CasterDowntime\"},\n  {46307, 1, \"c_ffs\", 1.1, 4.9, \"CasterDowntime\"},\n  {46307, 1, \"c_mb\", 9.4, 12.9, \"CasterDowntime\"},\n  {46316, 1, \"c_re1a\", 15.85, 20.1, \"CasterDowntime\"},\n  {46316, 1, \"c_re1b\", 21.35, 25.35, \"CasterDowntime\"},\n  {46336, 1, \"c_bw\", 5.2, 9.2, \"CasterDowntime\"},\n  {48098, 3, \"c_met1\", 4.45, 7.45, \"CasterDowntime\"},\n  {46322, 1, \"c_met2\", 1.5, 5.0, \"CasterDowntime\"},\n  {48098, 4, \"c_tv4\", 6.1, 10.5, \"CasterDowntime\"},\n  {46377, 1, \"c_arc\", 19.2, 31.2, \"CasterDowntime\"},\n  {48098, 5, \"c_ck\", 9.6, 15.1, \"CasterDowntime\"},\n  {48098, 8, \"c_tv8\", 6.2, 10.5, \"CasterDowntime\"},\n  {46374, 3, \"c_ef3\", 2.0, 11.0, \"CasterDowntime\"}\n  }) do BY[w[1]] = BY[w[1]] or {}; table.insert(BY[w[1]], w) end\n  s.spec = BY\nend\nlocal ws = BY[sp]\nif not ws then return end\nlocal api = TensorCore.API.TensorACR\nlocal okT, t = pcall(api.getAutoSimTime)\nif not (okT and t) then return end\ns.cnt = s.cnt or {}; s.lastC = s.lastC or {}\nif not s.lastC[sp] or t - s.lastC[sp] > 5 then s.lastC[sp] = t; s.cnt[sp] = (s.cnt[sp] or 0) + 1 end\nfor _, w in ipairs(ws) do\n  local key = w[3]\n  if s.cnt[sp] == w[2] and not (s.done and s.done[key]) then\n    s.done = s.done or {}; s.done[key] = true\n    if s[key] then\n      local ok, id = pcall(api.setAutoSimPhase, s[key], t + w[4], t + w[5])\n      if not ok then ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]) end\n      if ok then s[key] = id end\n    else\n      local ok, id = pcall(api.addAutoSimPhase, w[6], t + w[4], t + w[5]); if ok then s[key] = id end\n    end\n  end\nend\n",
							name = "[AutoSim] M12S P2 - cast sync",
							uuid = "412deeae-d49c-3e1c-b593-728d665d9f0b",
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
				mechanicTime = 15.125,
				name = "[AutoSim] M12S P2 - cast sync",
				timeRange = true,
				timelineIndex = 1,
				timerEndOffset = 545,
				timerStartOffset = -15,
				uuid = "0527ae22-f355-982e-ae69-aa84c34c2077",
				version = 2,
			},
		},
	}, 
	inheritedProfiles = 
	{
	},
	timelineName = "r12s2",
	version = "1.5.0",
}



return tbl