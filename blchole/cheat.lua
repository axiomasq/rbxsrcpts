local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()
local MiningModule = loadstring(game:HttpGet(''))()
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

	end
})
