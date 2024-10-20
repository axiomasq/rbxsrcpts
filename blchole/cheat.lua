local ImGui, err = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua')) if err then warn(err.."  [GUI MODULE]") return end
ImGui = ImGui()
local MiningModule, err = loadstring(game:HttpGet('https://github.com/axiomasq/rbxsrcpts/raw/main/blchole/OreMiningModule.lua')) if err then warn(err.."  [MINING MODULE]") return end
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
	Text = "Mine Red Ore",
	Callback = function ()
		MiningModule.mineOre(MiningModule.oresEnum.RedRock)
	end
})
MineRow:Button({
	Text = "Mine Blue Ore",
	Callback = function ()
		MiningModule.mineOre(MiningModule.oresEnum.BlueRock)
	end
})
local Keybinds = AutoActionsTab:CollapsingHeader({
	Title = "Keybinds"
})
Keybinds:Keybind({
	Label = "Toggle UI",
	Value = Enum.KeyCode.E,
	Callback = function()
		Window:SetVisible(not Window.Visible)
	end,
})
local ghostfarm_is_active = false
local function startGhostFarm()
    local ghostfarm = coroutine.wrap(function()
        while true do
            local success, err = pcall(function()
                if not ghostfarm_is_active then
                    task.wait(2)
                    return -- Используем return вместо continue для выхода из текущего цикла
                end
                local ghosts = workspace.Ghosts:GetChildren()
                if #ghosts == 0 then
                    print("No ghosts")
                    task.wait(2)
                    return
                end

                local LocalPlayer = game.Players.LocalPlayer
                local weapon = LocalPlayer.Backpack:FindFirstChild("Ghoster") or LocalPlayer.Character:FindFirstChild("Ghoster")

                if not weapon then
                    print("Weapon not found")
                    task.wait(2)
                    return
                end

                for i = 1, #ghosts do
                    local ghost = ghosts[i]
                    print(ghost.WorldPivot.Position, " is child number " .. i .. " ClassName:" .. ghost.ClassName)

                    local loopbreaker = 0
                    local health = ghost:GetAttribute("Health")

                    while health > 0 and loopbreaker < 10 do
                        loopbreaker = loopbreaker + 1
                        print("before shooting to ghost. Current health: " .. health)
                        wait(0.2)
                        weapon.Shoot:FireServer(ghost.WorldPivot.Position, ghost)
                        health = ghost:GetAttribute("Health")
                        print("shooting to ghost. Current health: " .. health)
                    end
                end
            end)

            if not success then
                -- Ошибка произошла, выводим её и перезапускаем через 5 секунд
                print("Error in ghost farm: " .. err)
                task.wait(5)
            end
        end
    end)
    ghostfarm()
end

startGhostFarm()

AutoActionsTab:Checkbox({
    Label = "Auto ghost killing",
    Value = false,
    Callback = function(self, checked)
        if checked then
            ghostfarm_is_active = true
        else
            ghostfarm_is_active = false
        end
    end
})

local LocationsTpTab = Window:CreateTab({
	Name = "TP locs"
})

local function resetBlackHoleForce()
	local Players = game:GetService("Players")
	local plr = Players.LocalPlayer
	local char = plr.Character
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	local workspace_plr = rootPart.Parent
	local linefore = workspace_plr.LineForce
	linefore.Magnitude = 0
	linefore.Enabled = false
end

LocationsTpTab:Combo({
	Placeholder = "Select destination",
	Label = "Outside",
	Items = {
		Helicopter= Vector3.new(357, 215, 372),
		Cave = 		Vector3.new(240, 179, 95),
		Bunker_Outside = Vector3.new(338, 244, 682),
		Facility_Enerance= Vector3.new(87, 181, 360)
	},
	Callback = function(self, vector, some)
		local char = MiningModule.getCharacter()
		MiningModule.tpToPos(char, vector.x, vector.y, vector.z)
		resetBlackHoleForce()
	end
})

LocationsTpTab:Combo({
	Placeholder = "Select destination",
	Label = "Inside",
	Items = {
		Control_Room = Vector3.new(4, 178, 205),
		Maitenance_Room = Vector3.new(33, 178, 403),
		Rocket_Silos = Vector3.new(23, 178, 520),
		Coolant_Room = Vector3.new(-217, 178, 471),
		Zombie_Lab = Vector3.new(-156, 178, 553),
		Server = Vector3.new(-29, 178, 304),
		Egens_Room = Vector3.new(-212, 146, 332),
		Egens_Control = Vector3.new(-163, 178, 314),
		Core_Door = Vector3.new(-121, 81, 91),
		Core_Opposite = Vector3.new(106, 81, -161),
	},
	Callback = function(self, vector, some)
		local char = MiningModule.getCharacter()
		MiningModule.tpToPos(char, vector.x, vector.y, vector.z)
		resetBlackHoleForce(char)
	end
})

