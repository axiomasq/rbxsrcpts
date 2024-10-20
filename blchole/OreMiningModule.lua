local OreMiningModule = {}

function OreMiningModule.getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function OreMiningModule.tpToPos(character, posx, posy, posz)
	if character and OreMiningModule.getRoot(character) then
        OreMiningModule.getRoot(character).CFrame = CFrame.new(posx, posy, posz)
    end
end

function OreMiningModule.getCharacter()
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    return plr.Character
end

function OreMiningModule.DEBUGgetObjinfo(tbl)
    print("Тип объекта:", typeof(tbl))
    if tbl.Name then
        print("Имя объекта:", tbl.Name)
    end
    if tbl.ClassName then
        print("Класс объекта:", tbl.ClassName)
    end
    if tbl.Parent then
        print("Родительский объект:", tbl.Parent.Name)
    end
    if tbl:GetChildren() then
        for _, child in ipairs(tbl:GetChildren()) do
            print("Дочерний объект:", child.Name)
        end
    end
    if tbl:GetAttributes() then
        for key, value in pairs(tbl:GetAttributes()) do
            print("Атрибут:", key, "Значение:", value)
        end
    end
end

OreMiningModule.oresEnum = {
    BlueRock = "BlueRock",
    RedRock = "RedRock"
}

function OreMiningModule.getFirstOre(oreType)
    local ores = workspace.Outside.Cave.Ores:GetChildren()
    for i, ore in ipairs(ores) do
        if ore:GetAttribute("Health") > 0 and ore.Name == oreType then
            return ore
        end
    end
end

function OreMiningModule.fireMineEvent(target)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local function startMining(target)
        print("[Client] Отправка события майнинга на сервер для объекта", target.Name)
        ReplicatedStorage.RemoteEvents.Tools.Drill:FireServer(target)
    end

    if target then
        startMining(target)
    end
end

function OreMiningModule.getOreHealth(target)
    return target:GetAttribute("Health")
end

function OreMiningModule.mineOre(oreType)
    local char = OreMiningModule.getCharacter()
    local ore = OreMiningModule.getFirstOre(oreType)
    if ore == nil then warn("ZERO ORE FINDED") end 
    local health = OreMiningModule.getOreHealth(ore)
    local infinite_cycle_breaker = 0

    while health > 0 and infinite_cycle_breaker < 20 do
        infinite_cycle_breaker = infinite_cycle_breaker + 1
        print("[ORE_MINER]: ORE_TYPE: " .. oreType .. " ORE HEALTH - " .. health)

        local ore_pos = ore.WorldPivot
        OreMiningModule.tpToPos(char, ore_pos.x, ore_pos.y + 6, ore_pos.z)
        OreMiningModule.fireMineEvent(ore)

        health = OreMiningModule.getOreHealth(ore)

        task.wait(0.4)
    end
    print("[ORE_MINER]: Finished")
end

return OreMiningModule
