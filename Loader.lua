local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local block_user = "ExampleNameHere"

local function goToMatchmaking()
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local ChooseSlot = Remotes:WaitForChild("ChooseSlot")
    local Teleport = Remotes:WaitForChild("Teleport")
    pcall(function()
        ChooseSlot:InvokeServer(unpack({
            [1] = "A",
            [2] = "Matchmaking"
        }))
        task.wait(0.5)
        Teleport:InvokeServer(unpack({
            [1] = { teleportTo = "Matchmaking (EU)" }
        }))
    end)
end

local function hopServer()
    TeleportService:Teleport(132879607635324)
end

local placeId = game.PlaceId
if placeId == 14067600077 then
    goToMatchmaking()
elseif placeId == 132879607635324 then
    for _, plr in ipairs(Players:GetPlayers()) do
        if string.lower(plr.Name) == string.lower(block_user) then
            hopServer()
            break
        end
    end
end
