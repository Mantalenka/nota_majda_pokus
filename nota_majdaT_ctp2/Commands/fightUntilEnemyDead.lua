local commandInfo = {
	name = "fightUntilEnemyDead",
	desc = "Move formation to a position and return success only after enemy is destroyed.",
	author = "MajdaT_ChatGPT_PepeAmpere",
	date = "2025-05-13",
	license = "notAlicense",
}

function getInfo()
	return {
		onNoUnits = SUCCESS,
		title = "Move and fight until victory",
		tooltip = "Fight until enemy unit is eliminated.",
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
		}
	}
end

local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringValidUnitID = Spring.ValidUnitID
local SpringGetTeamUnits = Spring.GetTeamUnits

local enemyPreviouslySeen = false

function Run(self, units, parameter)
	local customGroup = parameter.groupDefintion
	local position = parameter.position
	local formation = parameter.formation
	
	-- enemy detection
	local enemyUnits = SpringGetTeamUnits(1)
	local targetPos = nil

	if #enemyUnits > 0 then
		enemyPreviouslySeen = true
		local tx, ty, tz = SpringGetUnitPosition(enemyUnits[1])
		if tx then
			targetPos = Vec3(tx, ty, tz)
		end
	end

	if enemyPreviouslySeen and #enemyUnits == 0 then
		return SUCCESS
	end

	-- select new pointman = jednotka s nejvyšší pozicí v ose X
	local pointmanID = nil
	local maxX = -math.huge
	for unitID in pairs(customGroup) do
		if SpringValidUnitID(unitID) then
			local ux = select(1, SpringGetUnitPosition(unitID))
			if ux and ux > maxX then
				maxX = ux
				pointmanID = unitID
			end
		end
	end
	if not pointmanID then return FAILURE end

	local pointX, pointY, pointZ = SpringGetUnitPosition(pointmanID)
	local pointmanPosition = Vec3(pointX, pointY, pointZ)

	-- default fallback
	local cmdID = CMD.FIGHT
	local pointmanOffset = formation[1]
	local pointmanTarget = (targetPos or position) + pointmanOffset

	SpringGiveOrderToUnit(pointmanID, cmdID, pointmanTarget:AsSpringVector(), {})

	for unitID, posIndex in pairs(customGroup) do
		if unitID ~= pointmanID and SpringValidUnitID(unitID) then
			local thisTarget = pointmanPosition - pointmanOffset + formation[posIndex]
			SpringGiveOrderToUnit(unitID, cmdID, thisTarget:AsSpringVector(), {})
		end
	end

	return RUNNING
end
