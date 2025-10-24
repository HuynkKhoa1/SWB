if getgenv()._hop_checked then return end
getgenv()._hop_checked = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local blacklist = {
    "baoloflotahoa2",
    "toanlamhailua23",
    "ungthucu124",
    "ungthuvu334",
    "ungthudai331",
    "thaophupro331",
    "quechantungcuoc07",
    "leesinqechan24"
}

local function goToMatchmaking()
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local ChooseSlot = Remotes:WaitForChild("ChooseSlot")
    local Teleport = Remotes:WaitForChild("Teleport")
    pcall(function()
        ChooseSlot:InvokeServer("A", "Matchmaking")
        task.wait(0.5)
        Teleport:InvokeServer({ teleportTo = "Matchmaking (EU)" })
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
            return
        end
    end
end
