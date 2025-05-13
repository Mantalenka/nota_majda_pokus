local commandInfo = {
	name = "moveCustomGroupAllArrived",
	desc = "Move a group to a position using relative formation. Success is returned only when all units have arrived.",
	author = "MajdaT_ChatGPT_PepeAmpere",
	date = "2025-05-13",
	license = "notAlicense",
}


function getInfo()
	return {
		onNoUnits = SUCCESS,
		tooltip = "Move custom group to defined position. Success only if all units arrive.",
		parameterDefs = {
			{ 
				name = "groupDefintion",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "formation",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "<relative formation>",
			},
			{ 
				name = "fight",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "false",
			}
		}
	}
end

local THRESHOLD_STEP = 25
local THRESHOLD_DEFAULT = 0

local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitPosition = Spring.GetUnitPosition

local function ClearState(self)
	self.threshold = THRESHOLD_DEFAULT
	self.lastPointmanPosition = Vec3(0,0,0)
end

function Run(self, units, parameter)
	local customGroup = parameter.groupDefintion
	local position = parameter.position
	local formation = parameter.formation
	local fight = parameter.fight

	local cmdID = CMD.MOVE
	if fight then cmdID = CMD.FIGHT end

	local minIndex = math.huge
	local pointmanID
	for unitID, posIndex in pairs(customGroup) do
		if posIndex < minIndex then
			minIndex = posIndex
			pointmanID = unitID
		end
	end
	local pointX, pointY, pointZ = SpringGetUnitPosition(pointmanID)
	local pointmanPosition = Vec3(pointX, pointY, pointZ)

	if pointmanPosition == self.lastPointmanPosition then
		self.threshold = self.threshold + THRESHOLD_STEP
	else
		self.threshold = THRESHOLD_DEFAULT
	end
	self.lastPointmanPosition = pointmanPosition

	local pointmanOffset = formation[1]
	local pointmanWantedPosition = position + pointmanOffset
	SpringGiveOrderToUnit(pointmanID, cmdID, pointmanWantedPosition:AsSpringVector(), {})

	local allArrived = true
	for unitID, posIndex in pairs(customGroup) do
		local target
		if unitID == pointmanID then
			target = pointmanWantedPosition
		else
			target = pointmanPosition - pointmanOffset + formation[posIndex]
			SpringGiveOrderToUnit(unitID, cmdID, target:AsSpringVector(), {})
		end
		local ux, uy, uz = SpringGetUnitPosition(unitID)
		local unitPos = Vec3(ux, uy, uz)
		if unitPos:Distance(target) >= self.threshold then
			allArrived = false
		end
	end

	if allArrived then
		return SUCCESS
	else
		return RUNNING
	end
end

function Reset(self)
	ClearState(self)
end
