local tbl = 
{
	
	{
		data = 
		{
			displayPath = "",
			name = "AutoSim",
			uuid = "52c73c18-440f-28d2-843f-9f703114aa0b",
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
						actionLua = "data.blm_autosim_prepull = data.blm_autosim_prepull or {}\nlocal state = data.blm_autosim_prepull\nstate.endsAt = Now() + eventArgs.time * 1000\nstate.resolved = false\nTensorCore.API.TensorACR.holdActionUntil(152, state.endsAt)\nTensorCore.API.TensorACR.holdActionUntil(7561, state.endsAt)\nself.used = true",
						conditions = 
						{
							
							{
								"18e33cf3-4f19-e95f-b175-9cd0ac29ad86",
								true,
							},
						},
						name = "Hold Fire III and Swiftcast until zero",
						uuid = "85151660-48de-bdbc-8ed9-afc12d9465d2",
						version = 2.1,
					},
					inheritedIndex = 1,
				},
				
				{
					data = 
					{
						aType = "Misc",
						conditions = 
						{
							
							{
								"18e33cf3-4f19-e95f-b175-9cd0ac29ad86",
								true,
							},
							
							{
								"c60b4bbb-80a9-cfbe-b2c8-cd7017b2634f",
								true,
							},
						},
						name = "Target boss at 5s",
						setTarget = true,
						targetType = "Enemy",
						uuid = "c11a9a27-d788-5be9-86f6-819b0ca2731c",
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
						name = "BLM",
						uuid = "18e33cf3-4f19-e95f-b175-9cd0ac29ad86",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Event",
						comparator = 2,
						eventCountdownTime = 5,
						name = "Countdown <=5s",
						uuid = "c60b4bbb-80a9-cfbe-b2c8-cd7017b2634f",
						version = 3,
					},
				},
			},
			displayPath = "AutoSim",
			eventType = 16,
			name = "[AutoSim BLM] Target at 5s, start at 0",
			timeout = 60,
			uuid = "790fc8d9-36a3-88ba-abd1-d3002030770a",
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
						actionLua = "TensorCore.API.TensorACR.holdActionUntil(152, Now())\ndata.blm_autosim_prepull = nil\nTensorCore.API.TensorACR.holdActionUntil(7561, Now())\nself.used = true",
						conditions = 
						{
							
							{
								"39805b11-0032-14ec-b4bc-83d14f8a99e6",
								true,
							},
						},
						name = "Clear Fire III and Swiftcast holds",
						resumeAllActions = true,
						uuid = "63101dd4-9975-6a90-9216-e3433a94ec1d",
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
						name = "BLM",
						uuid = "39805b11-0032-14ec-b4bc-83d14f8a99e6",
						version = 3,
					},
				},
			},
			displayPath = "AutoSim",
			eventType = 17,
			name = "[AutoSim BLM] Clear Fire III hold on countdown cancel",
			uuid = "b71a84dc-d0da-1850-8318-ae095cedf254",
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
						actionLua = "local state = data.blm_autosim_prepull\nstate.resolved = true\nself.used = true",
						conditions = 
						{
							
							{
								"28f7091c-7220-3a77-ac91-962d6871723d",
								true,
							},
							
							{
								"ca3da1e7-46da-623a-b8fe-33f79535c06e",
								true,
							},
							
							{
								"f228dedd-cd5a-7f06-831e-6209f21ec0df",
								true,
							},
						},
						name = "Keep Fire III held to zero",
						uuid = "9c31187f-e1e8-731a-ad81-0b6c19954560",
						version = 2.1,
					},
				},
				
				{
					data = 
					{
						aType = "Lua",
						actionLua = "local state = data.blm_autosim_prepull\nTensorCore.API.TensorACR.holdActionUntil(152, state.endsAt - 3286)\nstate.resolved = true\nself.used = true",
						conditions = 
						{
							
							{
								"28f7091c-7220-3a77-ac91-962d6871723d",
								true,
							},
							
							{
								"ca3da1e7-46da-623a-b8fe-33f79535c06e",
								true,
							},
							
							{
								"9a1e2fa2-94ae-ece1-84c7-3baf51f82c6d",
								true,
							},
						},
						name = "Release Fire III to land at zero",
						uuid = "1d34a273-d20e-c900-9057-309597ffe038",
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
						name = "BLM",
						uuid = "28f7091c-7220-3a77-ac91-962d6871723d",
						version = 3,
					},
				},
				
				{
					data = 
					{
						category = "Lua",
						conditionLua = "local state = data.blm_autosim_prepull\nreturn state ~= nil and state.endsAt ~= nil and not state.resolved and Now() >= state.endsAt - 6000",
						dequeueIfLuaFalse = true,
						name = "Countdown reaches 6s",
						uuid = "ca3da1e7-46da-623a-b8fe-33f79535c06e",
						version = 3,
					},
				},
				
				{
					data = 
					{
						actionCDValue = 0.01,
						actionID = 7561,
						category = "Self",
						conditionType = 4,
						name = "Swiftcast used",
						uuid = "f228dedd-cd5a-7f06-831e-6209f21ec0df",
						version = 3,
					},
				},
				
				{
					data = 
					{
						actionID = 7561,
						category = "Self",
						comparator = 2,
						conditionType = 4,
						name = "Swiftcast ready",
						uuid = "9a1e2fa2-94ae-ece1-84c7-3baf51f82c6d",
						version = 3,
					},
				},
			},
			displayPath = "AutoSim",
			name = "[AutoSim BLM] Prepull Swiftcast check at 6s",
			timeout = 1,
			uuid = "2a01cf37-bd14-151d-8f2b-257488eb8838",
			version = 2,
		},
	},
}

return tbl
