-- OreMiningModule.lua

local OreMiningModule = {}

-- Функция для получения корневой части персонажа
function OreMiningModule.getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

-- Функция для телепортации персонажа в указанную позицию
function OreMiningModule.tpToPos(character, posx, posy, posz)
	if character and OreMiningModule.getRoot(character) then
        OreMiningModule.getRoot(character).CFrame = CFrame.new(posx, posy, posz)
    end
end

-- Функция для получения текущего персонажа игрока
function OreMiningModule.getCharacter()
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    return plr.Character
end

-- Функция для отладки: получение информации об объекте
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

-- Перечисление типов руды
OreMiningModule.oresEnum = {
    BlueRock = "BlueRock",
    RedRock = "RedRock"
}

-- Функция для получения первого подходящего объекта руды
function OreMiningModule.getFirstOre(oreType)
    local ores = workspace.Outside.Cave.Ores:GetChildren()
    for i, ore in ipairs(ores) do
        if ore:GetAttribute("Health") > 0 and ore.Name == oreType then
            return ore
        end
    end
end

-- Функция для отправки события о майнинге на сервер
function OreMiningModule.fireMineEvent(target)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local function startMining(target)
        print("[Client] Отправка события майнинга на сервер для объекта", target.Name)
        ReplicatedStorage.RemoteEvents.Tools.Drill:FireServer(target)
    end

    local function onMiningResponse(responseMessage)
        print("[Client] Ответ от сервера:", responseMessage)
    end

    ReplicatedStorage.RemoteEvents.Tools.Mine.OnClientEvent:Connect(onMiningResponse)

    if target then
        startMining(target)
    end
end

-- Функция для получения здоровья руды
function OreMiningModule.getOreHealth(target)
    return target:GetAttribute("Health")
end

-- Функция для майнинга руды определенного типа
function OreMiningModule.mineOre(oreType)
    local char = OreMiningModule.getCharacter()
    local ore = OreMiningModule.getFirstOre(oreType)
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

-- Возвращаем таблицу с функциями, чтобы они были доступны в других файлах
return OreMiningModule
