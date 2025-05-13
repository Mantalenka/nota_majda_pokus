local sensorInfo = {
	name = "Safety_Formation",
	desc = "Generuje formaci ve vertikální linii (sever-jih)",
	author = "MajdaT_openAI",
	date = "2025-05-05",
	license = "MIT",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT
	}
end

return function(listOfUnits)
	local groupDefinition = {}
	local linearFormation = {}

	local spacing = 10 -- vzdálenost mezi jednotkami
	for i = 1, #listOfUnits do
		local unitID = listOfUnits[i]
		groupDefinition[unitID] = i
		linearFormation[i] = Vec3(0, 0, (i - 1) * spacing)
	end

	return {
		group = groupDefinition,
		formation = linearFormation
	}
end
