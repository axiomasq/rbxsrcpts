local ImGui, err = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua')) if err then warn(err.."  [GUI MODULE]") return end
ImGui = ImGui()
local MiningModule, err = loadstring(game:HttpGet('https://raw.githubusercontent.com/axiomasq/rbxsrcpts/refs/heads/main/blchole/OreMiningModule.lua')) if err then warn(err.."  [MINING MODULE]") return end
MiningModule = MiningModule()
--// Window 
local Window = ImGui:CreateWindow({
	Title = "VICTORY GUI",
	Size = UDim2.new(0, 350, 0, 370),
	Position = UDim2.new(0.5, 0, 0, 70)
})
Window:Center()

local AutoActionsTab = Window:CreateTab({
	Name = "Automatic actions"
})

local MinersActionsColapH  = AutoActionsTab:CollapsingHeader({
	Title = "Mining actions"
})
local MineRow = MinersActionsColapH:Row()

MineRow:Button({
	Text = "Mine RedOre",
	Callback = function ()
		MiningModule:mineOre(MiningModule.oresEnum.RedRock)
	end
})
