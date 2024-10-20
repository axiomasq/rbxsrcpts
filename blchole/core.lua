-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-10-20 12:32:01
-- Luau version 6, Types version 3
-- Time taken: 0.005520 seconds

local module_upvr_2 = {}
local module_upvr = require(game.ReplicatedStorage.Modules:WaitForChild("GlobalFunctions"))
local RunService_upvr = game:GetService("RunService")
local CollectionService_upvr = game:GetService("CollectionService")
local var5_upvw
if RunService_upvr:IsClient() then
    var5_upvw = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("BackpackMod"))
end
local var6_upvw
if RunService_upvr:IsServer() then
    var6_upvw = require(game.ServerStorage.Modules.Analytics)
end
function module_upvr_2.isFeatureFlagEnabled(arg1) -- Line 19
    -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [36] 25. Error Block 5 start (CF ANALYSIS FAILED)
    warn("Feature flag", arg1, "not found!")
    do
        return false
    end
    -- KONSTANTERROR: [36] 25. Error Block 5 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [43] 31. Error Block 6 start (CF ANALYSIS FAILED)
    warn("Feature flags folder not found in Replicated Storage")
    -- KONSTANTERROR: [43] 31. Error Block 6 end (CF ANALYSIS FAILED)
end
function module_upvr_2.getLevelAndRemainderFromXP(arg1) -- Line 37
    local Levels = game.ReplicatedStorage.Levels
    for i = 1, #Levels:GetChildren() do
        if arg1 < Levels[tostring(i)].Value then
            return i - 1, arg1 - Levels[tostring(i - 1)].Value
        end
    end
    return #Levels:GetChildren(), 0
end
function module_upvr_2.getPlayerMult(arg1) -- Line 52
    --[[ Upvalues[1]:
        [1]: CollectionService_upvr (readonly)
    ]]
    local var19
    if arg1.Team then
        if arg1.Team.Name == "Sponsor" then
            var19 += 0.2
        end
        if arg1.Team.Name == "Manager" then
            var19 += 0.6
        end
        if arg1.Team.Name == "Board Member" then
            var19 += 0.6
        end
        if arg1.Team.Name == "Site Director" then
            var19 += 0
        end
    end
    local any_GetTagged_result1_2 = CollectionService_upvr:GetTagged("Robot")
    for i_2 = 1, #any_GetTagged_result1_2 do
        local RobotManager = any_GetTagged_result1_2[i_2]:FindFirstChild("RobotManager")
        if RobotManager then
            local var21_2 = require(RobotManager)
            if var21_2.getBattery() > 0 and var21_2.FollowedPlayer == arg1 then
                var19 += 0.1 * var21_2.RewardBoostDec
            end
        end
    end
    return var19
end
function module_upvr_2.awardPlayerXP(arg1, arg2, arg3) -- Line 94
    --[[ Upvalues[2]:
        [1]: module_upvr_2 (readonly)
        [2]: module_upvr (readonly)
    ]]
    coroutine.wrap(function() -- Line 96
        --[[ Upvalues[5]:
            [1]: arg2 (readonly)
            [2]: module_upvr_2 (copied, readonly)
            [3]: arg1 (readonly)
            [4]: module_upvr (copied, readonly)
            [5]: arg3 (readonly)
        ]]
        pcall(function() -- Line 98
            --[[ Upvalues[5]:
                [1]: arg2 (copied, readonly)
                [2]: module_upvr_2 (copied, readonly)
                [3]: arg1 (copied, readonly)
                [4]: module_upvr (copied, readonly)
                [5]: arg3 (copied, readonly)
            ]]
            local tonumber_result1 = tonumber(module_upvr.round(tonumber(arg2) * module_upvr_2.getPlayerMult(arg1), 1))
            local XP = arg1.Stats.XP
            XP.Value += tonumber_result1
            game.ReplicatedStorage.RemoteEvents.GUI.XP:FireClient(arg1, "You gained "..tostring(tonumber_result1).." XP "..arg3)
        end)
    end)()
end
function module_upvr_2.awardPlayerCredits(arg1, arg2, arg3) -- Line 113
    --[[ Upvalues[3]:
        [1]: module_upvr_2 (readonly)
        [2]: module_upvr (readonly)
        [3]: var6_upvw (read and write)
    ]]
    coroutine.wrap(function() -- Line 115
        --[[ Upvalues[6]:
            [1]: arg2 (readonly)
            [2]: module_upvr_2 (copied, readonly)
            [3]: arg1 (readonly)
            [4]: module_upvr (copied, readonly)
            [5]: arg3 (readonly)
            [6]: var6_upvw (copied, read and write)
        ]]
        local tonumber_result1_2 = tonumber(module_upvr.round(tonumber(arg2) * module_upvr_2.getPlayerMult(arg1), 1))
        local Credits = arg1.Stats.Credits
        Credits.Value += tonumber_result1_2
        game.ReplicatedStorage.RemoteEvents.GUI.Credits:FireClient(arg1, "You earned "..tostring(tonumber_result1_2).." credits "..arg3)
        var6_upvw.getCreditsGameplay(arg1, tonumber_result1_2, arg3)
    end)()
end
function module_upvr_2.powerToTemp(arg1) -- Line 131
    return arg1 * 0.00006
end
function module_upvr_2.tempToPower(arg1) -- Line 135
    return arg1 * 16666.666666666668
end
function module_upvr_2.awardPlayerCreditsAndXP(arg1, arg2, arg3, arg4, arg5) -- Line 140
    --[[ Upvalues[2]:
        [1]: module_upvr_2 (readonly)
        [2]: var6_upvw (read and write)
    ]]
    local var36_upvw = arg5 or "Reward Earned"
    coroutine.wrap(function() -- Line 143
        --[[ Upvalues[7]:
            [1]: module_upvr_2 (copied, readonly)
            [2]: arg1 (readonly)
            [3]: arg2 (read and write)
            [4]: arg3 (read and write)
            [5]: arg4 (readonly)
            [6]: var36_upvw (read and write)
            [7]: var6_upvw (copied, read and write)
        ]]
        local any_getPlayerMult_result1 = module_upvr_2.getPlayerMult(arg1)
        arg2 *= any_getPlayerMult_result1
        arg3 *= any_getPlayerMult_result1
        arg2 = math.round(arg2)
        arg3 = math.round(arg3)
        local Credits_2 = arg1.Stats.Credits
        Credits_2.Value += arg2
        local XP_2 = arg1.Stats.XP
        XP_2.Value += arg3
        game.ReplicatedStorage.RemoteEvents.GUI.Credits:FireClient(arg1, "You earned "..tostring(arg2).." credits and "..tostring(arg3).." XP "..arg4, var36_upvw)
        var6_upvw.getCreditsGameplay(arg1, arg2, arg4)
    end)()
end
local BadgeService_upvr = game:GetService("BadgeService")
function module_upvr_2.awardPlayerBadge(arg1, arg2) -- Line 163
    --[[ Upvalues[1]:
        [1]: BadgeService_upvr (readonly)
    ]]
    coroutine.wrap(function() -- Line 164
        --[[ Upvalues[3]:
            [1]: BadgeService_upvr (copied, readonly)
            [2]: arg1 (readonly)
            [3]: arg2 (readonly)
        ]]
        local pcall_result1, pcall_result2 = pcall(function() -- Line 165
            --[[ Upvalues[3]:
                [1]: BadgeService_upvr (copied, readonly)
                [2]: arg1 (copied, readonly)
                [3]: arg2 (copied, readonly)
            ]]
            if not BadgeService_upvr:UserHasBadgeAsync(arg1.UserId, arg2) then
                BadgeService_upvr:AwardBadge(arg1.UserId, arg2)
            end
        end)
        if not pcall_result1 then
            warn(pcall_result2)
        end
    end)()
end
function module_upvr_2.disableGui() -- Line 178
    --[[ Upvalues[1]:
        [1]: var5_upvw (read and write)
    ]]
    local LocalPlayer = game.Players.LocalPlayer
    game.ReplicatedStorage.BindableEvents.CloseCamera:Fire()
    if LocalPlayer:FindFirstChild("TempStats") then
        LocalPlayer.TempStats.InCamera.Value = true
    end
    var5_upvw.setBackpackEnabled(false)
    LocalPlayer.PlayerGui:WaitForChild("XP").Enabled = false
    LocalPlayer.PlayerGui:WaitForChild("Shop").Enabled = false
    LocalPlayer.PlayerGui:WaitForChild("SideButtons").Enabled = false
end
function module_upvr_2.enableGui() -- Line 192
    --[[ Upvalues[1]:
        [1]: var5_upvw (read and write)
    ]]
    local LocalPlayer_2 = game.Players.LocalPlayer
    LocalPlayer_2:WaitForChild("TempStats").InCamera.Value = false
    var5_upvw.setBackpackEnabled(true)
    LocalPlayer_2.PlayerGui:WaitForChild("XP").Enabled = true
    LocalPlayer_2.PlayerGui:WaitForChild("Shop").Enabled = true
    LocalPlayer_2.PlayerGui:WaitForChild("SideButtons").Enabled = true
end
function module_upvr_2.getRayCastIgnoreList() -- Line 205
    --[[ Upvalues[2]:
        [1]: RunService_upvr (readonly)
        [2]: CollectionService_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local module = {game.Workspace:FindFirstChild("MeltdownFires"), game.Workspace:FindFirstChild("Zones")}
    if RunService_upvr:IsClient() then
        table.insert(module, game.Players.LocalPlayer.Character)
    end
    local any_GetTagged_result1 = CollectionService_upvr:GetTagged("ShootThrough")
    for i_3 = 1, #any_GetTagged_result1 do
        table.insert(module, any_GetTagged_result1[i_3])
        local _
    end
    return module
end
function module_upvr_2.RaycastRayWithIgnore(arg1) -- Line 226
    --[[ Upvalues[1]:
        [1]: module_upvr_2 (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    if not game:GetService("RunService"):IsClient() then
        error("Raycast called on server!")
        return
    end
    local mouse = game.Players.LocalPlayer:GetMouse()
    mouse.TargetFilter = nil
    local RaycastParams_new_result1 = RaycastParams.new()
    if arg1 then
        for i_4 = 1, #arg1 do
            table.insert(module_upvr_2.getRayCastIgnoreList(), arg1[i_4])
            local var65
        end
    end
    RaycastParams_new_result1.FilterDescendantsInstances = var65
    RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
    mouse.TargetFilter = mouse.TargetFilter
    return game.Workspace:Raycast(game.Workspace.CurrentCamera.CFrame.Position, (mouse.Hit.Position - game.Workspace.CurrentCamera.CFrame.Position).Unit * 500, RaycastParams_new_result1)
end
return module_upvr_2
