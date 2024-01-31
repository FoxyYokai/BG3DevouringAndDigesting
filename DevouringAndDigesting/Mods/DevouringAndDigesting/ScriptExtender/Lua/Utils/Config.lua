ConfigVars = {}

local vrs = {
	VoreDifficulty = {
		description = "Determines how hard it is to swallow non-consenting characters. Possible values: \"default\" = checks rolled normally, \"easy\" = you make checks with advantage, \"debug\" = you always succeed",
		value = "default"
	},
	SlowDigestion = {
		description = "If true, you will not lose weight until you rest. If false, you lose it immediately upon finishing digestion and you will be immidiately able to absorb / dispose of prey",
		value = true
	},
	DigestionRateShort = {
		description = "Determines by how much the weight of a prey who is being digested is reduced after each short rest",
		value = 20
	},
	DigestionRateLong = {
		description = "Determines by how much the weight of a prey who is being digested is reduced after a long rest",
		value = 60
	},
	TeleportPrey = {
		description = "Determines if a living prey is teleported to their predator at the end of each turn (or every 6 seconds outside of turn-based mode). By default is on, should be only turned off in case of performance issues",
		value = true
	},
	RegurgDist = {
		description = "Determines how far prey spawn when regurgitated. Default is 2",
		value = 2
	},
	WeightGain = {
		description = "TEST. Stores and adds \"fat\" value to belly size. Fat is increased during digestion of dead prey and reduced upon resting.",
		value = true
	},
	WeightLossShort = {
		description = "TEST. How much fat a character looses on short resting.",
		value = 3
	},
	WeightLossLong = {
		description = "TEST. How much fat a character looses on long resting.",
		value = 11
	},
	WeightGainRate = {
		description = "TEST. By how much DigestionRate is divided for fat gain rate. DO NOT SET THIS TO 0",
		value = 4
	},
	LockStomach = {
		description = "Whether to lock the stomach object used for storing items during item vore or not. Please do not remove or add items inside the stomach manually.",
		value = true
	},
	SwitchEndoLethal = {
		description = "When you start digesting prey, you will start digesting endo prey as well.",
		value = true
	},
	DigestItems = {
		description = "When you start digesting prey, the items in your stomach might be digested. WARNING: THIS WILL DELETE STORY ITEMS IN YOUR STOMACH",
		value = true
	},
	RegurgitationCooldown = {
		description = "Preds are unable to swallow prey for a number of turn after regurgitation. Set to 0 to disable",
		value = 2
	},
	SwallowDown = {
		description = "Preds will need to use a 'Contine Swallowing' spell to fully swallow a prey.",
		value = true
	},
	Hunger = {
		description = "Enables hunger system for party member preds. If a pred does not digest prey for a long time, they will recieve debuffs. Setting this to false disables hunger completely.",
		value = true
	},
	LethalRandomSwitch = {
		description = "If set to true, as you gain Hunger, it will become increasingly likely that you'll accidently start digesting your non-lethally swallowed prey. Works independently from SwitchEndoLethal.",
		value = true
	},
	HungerShort = {
		description = "Hunger stacks gained on short rest.",
		value = 1
	},
	HungerLong = {
		description = "Hunger stacks gained on long rest.",
		value = 4
	},
	HungerSatiation = {
		description = "Satiation stacks needed to remove one hunger stack.",
		value = 3
	},
	HungerSatiationRate = {
		description = "By how much digestion rate is divided for satiation gain. DO NOT SET THIS TO 0",
		value = 4
	},
	HungerBreakpoint1 = {
		description = "Stacks of hunger at which a debuff is appled",
		value = 8
	},
	HungerBreakpoint2 = {
		description = "Stacks of hunger at which a debuff is appled",
		value = 12
	},
	HungerBreakpoint3 = {
		description = "Stacks of hunger at which a debuff is appled",
		value = 16
	},
	BoilingInsidesFast = {
		description = "Dead prey are digested twice as fast if you have 'Boiling insides' feat.",
		value = false
	},
	StatusBonusStomach = {
		description = "Only prey who are in your stomach (oral vore) recieve benefits from feats.",
		value = true
	}
}

--Resets config to defaults.
function SP_ResetConfig()
    ConfigFailed = 0
    
	local json = Ext.Json.Stringify(vrs)
    Ext.IO.SaveFile("DevouringAndDigesting/VoreConfig.json", json)
    SP_GetConfigFromFile()
end

function SP_GetConfigFromFile()
    local jsonFile = Ext.IO.LoadFile("DevouringAndDigesting/VoreConfig.json")
    if (jsonFile == nil) then
        print("Devouring and Digesting - Configuration file not found. Creating one.")
        SP_ResetConfig()
		return
    end
    ConfigVars = Ext.Json.Parse(jsonFile)

	local configDesync = false
	for k, v in pairs(ConfigVars) do
		if vrs[k] == nil then
			ConfigVars[k] = nil
			configDesync = true
		end
	end
	for k, v in pairs(vrs) do
		if ConfigVars[k] == nil then
			ConfigVars[k] = v
			configDesync = true
		end
	end
	if configDesync then
		_P("Config Desync, re-saving")
		local json = Ext.Json.Stringify(ConfigVars)
   		Ext.IO.SaveFile("DevouringAndDigesting/VoreConfig.json", json)
	end
end
