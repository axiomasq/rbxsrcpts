-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-10-20 12:28:29
-- Luau version 6, Types version 3
-- Time taken: 0.003098 seconds

local UserInputService = game:GetService("UserInputService")
local module_upvr = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Core"))
local Parent_upvr = script.Parent
local LocalPlayer = game.Players.LocalPlayer
while LocalPlayer.Character == nil do
    wait()
end
local RaycastParams_new_result1 = RaycastParams.new()
RaycastParams_new_result1.FilterDescendantsInstances = module_upvr.getRayCastIgnoreList()
table.insert(RaycastParams_new_result1.FilterDescendantsInstances, game.Workspace.Robots)
RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
Parent_upvr.Equipped:Connect(function() -- Line 32
    equipped = true -- Setting global
end)
Parent_upvr.Unequipped:Connect(function() -- Line 36
    equipped = false -- Setting global
end)
local var8_upvw = false
Parent_upvr.Deactivated:Connect(function() -- Line 46
    --[[ Upvalues[1]:
        [1]: var8_upvw (read and write)
    ]]
    var8_upvw = false
end)
Parent_upvr.Activated:Connect(function() -- Line 50
    --[[ Upvalues[1]:
        [1]: var8_upvw (read and write)
    ]]
    var8_upvw = true
end)
UserInputService.TouchStarted:Connect(function() -- Line 55
    --[[ Upvalues[1]:
        [1]: var8_upvw (read and write)
    ]]
    if equipped then
        var8_upvw = true
    end
end)
UserInputService.TouchEnded:Connect(function() -- Line 61
    --[[ Upvalues[1]:
        [1]: var8_upvw (read and write)
    ]]
    var8_upvw = false
end)
local var14_upvw = true
local mouse_upvr = LocalPlayer:GetMouse()
game:GetService("RunService").RenderStepped:Connect(function() -- Line 64
    --[[ Upvalues[5]:
        [1]: var8_upvw (read and write)
        [2]: var14_upvw (read and write)
        [3]: module_upvr (readonly)
        [4]: mouse_upvr (readonly)
        [5]: Parent_upvr (readonly)
    ]]
    local var16
    if var8_upvw then
        if var14_upvw == false then return end
        var16 = game.Players
        if var16.LocalPlayer:WaitForChild("TempStats").InCamera.Value == true then return end
        var16 = game.Players.LocalPlayer
        if var16.TempStats.IsZombie.Value == true then return end
        var14_upvw = false
        local any_RaycastRayWithIgnore_result1 = module_upvr.RaycastRayWithIgnore()
        var16 = mouse_upvr.Hit.Position
        var16 = game.Workspace.CurrentCamera.CFrame.Position
        local var18 = var16 + (var16 - game.Workspace.CurrentCamera.CFrame.Position).Unit * 300
        var16 = nil
        if any_RaycastRayWithIgnore_result1 then
            var16 = any_RaycastRayWithIgnore_result1.Instance
            var18 = any_RaycastRayWithIgnore_result1.Position
        end
        local var19
        if var16 then
            var19 = var16:FindFirstAncestorWhichIsA("Model")
        end
        Parent_upvr.Shoot:FireServer(var18, var19)
        wait(0.3)
        var14_upvw = true
    end
end)
local var20_upvw
local function _() -- Line 102, Named "UpdateIcon"
    --[[ Upvalues[2]:
        [1]: var20_upvw (read and write)
        [2]: Parent_upvr (readonly)
    ]]
    if equipped == false then
    else
        local var21
        if var20_upvw then
            if Parent_upvr.Enabled then
                var21 = "rbxasset://textures/GunCursor.png"
            else
                var21 = "rbxasset://textures/GunWaitCursor.png"
            end
            var20_upvw.Icon = var21
        end
    end
end
local var22_upvw
Parent_upvr.Equipped:connect(function(arg1) -- Line 112, Named "OnEquipped"
    --[[ Upvalues[4]:
        [1]: Parent_upvr (readonly)
        [2]: var22_upvw (read and write)
        [3]: var8_upvw (read and write)
        [4]: var20_upvw (read and write)
    ]]
    local Parent = Parent_upvr.Parent
    if Parent.Parent.Parent == game.Players then
    else
        local Animation_upvr = Instance.new("Animation")
        Animation_upvr.AnimationId = "rbxassetid://18656278337"
        local Animator_upvr = Parent.Humanoid:WaitForChild("Animator")
        coroutine.wrap(function() -- Line 124
            --[[ Upvalues[3]:
                [1]: Animator_upvr (readonly)
                [2]: Animation_upvr (readonly)
                [3]: var22_upvw (copied, read and write)
            ]]
            local any_LoadAnimation_result1 = Animator_upvr:LoadAnimation(Animation_upvr)
            any_LoadAnimation_result1.Looped = true
            any_LoadAnimation_result1.Priority = Enum.AnimationPriority.Action
            any_LoadAnimation_result1:Play()
            var22_upvw = any_LoadAnimation_result1
        end)()
        var8_upvw = false
        var20_upvw = arg1
        equipped = true -- Setting global
        if equipped == false then return end
        local var28
        if var20_upvw then
            if Parent_upvr.Enabled then
                var28 = "rbxasset://textures/GunCursor.png"
            else
                var28 = "rbxasset://textures/GunWaitCursor.png"
            end
            var20_upvw.Icon = var28
        end
    end
end)
Parent_upvr.Unequipped:Connect(function() -- Line 140, Named "unEquip"
    --[[ Upvalues[2]:
        [1]: var8_upvw (read and write)
        [2]: var22_upvw (read and write)
    ]]
    var8_upvw = false
    equipped = false -- Setting global
    if var22_upvw then
        var22_upvw:Stop()
        var22_upvw = nil
    end
end)
Parent_upvr.Changed:connect(function(arg1) -- Line 150, Named "OnChanged"
    --[[ Upvalues[2]:
        [1]: var20_upvw (read and write)
        [2]: Parent_upvr (readonly)
    ]]
    if arg1 == "Enabled" then
        if equipped == false then return end
        local var29
        if var20_upvw then
            if Parent_upvr.Enabled then
                var29 = "rbxasset://textures/GunCursor.png"
            else
                var29 = "rbxasset://textures/GunWaitCursor.png"
            end
            var20_upvw.Icon = var29
        end
    end
end)
Parent_upvr.AncestryChanged:Connect(function() -- Line 160
    --[[ Upvalues[3]:
        [1]: Parent_upvr (readonly)
        [2]: var8_upvw (read and write)
        [3]: var22_upvw (read and write)
    ]]
    if Parent_upvr.Parent.Parent ~= game.Workspace then
        var8_upvw = false
        equipped = false -- Setting global
        if var22_upvw then
            var22_upvw:Stop()
            var22_upvw = nil
        end
    end
end)
