-- [VPR] Keep CD on (adds)
-- displayPath: VPR Optimization
-- mechanicTime: 105.7
-- timelineIndex: 17
-- timerStartOffset: -2
-- timerEndOffset: 60
-- loop: True
-- condition: category=Self, conditionType=13, dequeueIfLuaFalse=True, jobValue=VIPER, name=Viper

-- [action] [VPR] Keep CD on (adds)
-- [Opti] Disable CDs (store, no job check) turns CDs off during the adds.
-- AutoSim handles burst timing for Viper, so undo it.
if ACR_TensorViper4_CD == false then ACR_TensorViper4_CD = true end
self.used = true
