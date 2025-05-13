local commandInfo = {
  name = "goToHills",
  desc = "Assign up to 4 living units (preferably Peewee) to predefined hills with descending score values.",
  author = "MajdaT + CodeCopilot",
  date = "2025-05-13",
  license = "MIT",
}

function getInfo()
  return {
    tooltip = "Send best units to score hills",
    parameterDefs = {
      {
        name = "units",
        variableType = "expression",
        componentType = "editBox",
        defaultValue = "units",
      }
    }
  }
end

local SpringGetUnitDefID = Spring.GetUnitDefID
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringValidUnitID = Spring.ValidUnitID
local CMD_MOVE = CMD.MOVE
local UnitDefs = UnitDefs

local hills = {
  { score = 40, position = { 3714.28442, 192, 174.843338 } },
  { score = 30, position = { 2577.98853, 192, 358.835785 } },
  { score = 20, position = { 1932.06482, 192, 812.079956 } },
  { score = 10, position = { 1354.45056, 192, 263.059143 } },
}

local assignedUnits = {}

function Run(self, units, parameter)
  if #assignedUnits == 0 then
    local livingUnits = {}

    for _, unitID in ipairs(parameter.units) do
      if SpringValidUnitID(unitID) then
        local defID = SpringGetUnitDefID(unitID)
        local defName = UnitDefs[defID].name
        table.insert(livingUnits, { id = unitID, name = defName })
      end
    end

    -- prefer Peewees (armpw)
    table.sort(livingUnits, function(a, b)
      local aScore = (a.name == "armpw") and 1 or 0
      local bScore = (b.name == "armpw") and 1 or 0
      return aScore > bScore
    end)

    local assigned = math.min(#livingUnits, #hills)
    for i = 1, assigned do
      local unit = livingUnits[i]
      local hill = hills[i]
      SpringGiveOrderToUnit(unit.id, CMD_MOVE, {hill.position[1], hill.position[2], hill.position[3]}, {})
      table.insert(assignedUnits, { id = unit.id, target = hill.position })
    end
  end

  local completed = 0
  for _, data in ipairs(assignedUnits) do
    if SpringValidUnitID(data.id) then
      local ux, uy, uz = SpringGetUnitPosition(data.id)
      local dx = ux - data.target[1]
      local dz = uz - data.target[3]
      local distSq = dx * dx + dz * dz
      if distSq < 400 then -- 20 units threshold
        completed = completed + 1
      end
    end
  end

  if completed == #assignedUnits then
    Spring.Echo("goToHills: Success — jednotky obsadily kopce.")
    return SUCCESS
  else
    return RUNNING
  end
end
