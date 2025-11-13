local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local blacklist = {
    "KoaRF37",
    "yamate0504",
    "Sasasusine",
    "tranvanhao127",
    "lagialaolr58",
    "toanlamhailua23",
}

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

local function isBlacklisted(name)
    for _, bad in ipairs(blacklist) do
        if string.lower(name) == bad then
            return true
        end
    end
    return false
end

local placeId = game.PlaceId
if placeId == 14067600077 then
    goToMatchmaking()
elseif placeId == 132879607635324 then
    local localPlayer = Players.LocalPlayer
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= localPlayer and isBlacklisted(string.lower(plr.Name)) then
            hopServer()
            break
        end
    end
end
