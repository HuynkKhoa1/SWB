if getgenv()._hop_checked then
    warn("[DEBUG] Script already executed once, skipping...")
    return
end
getgenv()._hop_checked = true

print("[DEBUG] Script started once only")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local blacklist = {
    "KoaRF37",
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
    print("[DEBUG] In place 14067600077 → teleporting to Matchmaking (EU)...")
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local ChooseSlot = Remotes:WaitForChild("ChooseSlot")
    local Teleport = Remotes:WaitForChild("Teleport")
    pcall(function()
        print("[DEBUG] Invoking ChooseSlot...")
        ChooseSlot:InvokeServer("A", "Matchmaking")
        task.wait(0.5)
        print("[DEBUG] Invoking Teleport (EU)...")
        Teleport:InvokeServer({ teleportTo = "Matchmaking (EU)" })
    end)
end

local function hopServer()
    print("[DEBUG] Hopping to new server (PlaceId 132879607635324)...")
    TeleportService:Teleport(132879607635324)
end

local function isBlacklisted(name)
    for _, bad in ipairs(blacklist) do
        if string.lower(name) == bad then
            print("[DEBUG] Found blacklisted user:", name)
            return true
        end
    end
    return false
end

local placeId = game.PlaceId
print("[DEBUG] Current PlaceId:", placeId)

if placeId == 14067600077 then
    goToMatchmaking()
elseif placeId == 132879607635324 then
    local localPlayer = Players.LocalPlayer
    print("[DEBUG] Checking all players in current server:")
    for _, plr in ipairs(Players:GetPlayers()) do
        print(" -", plr.Name)
        if plr ~= localPlayer and isBlacklisted(string.lower(plr.Name)) then
            print("[DEBUG] Match found → hopping immediately")
            hopServer()
            return
        end
    end
    print("[DEBUG] No blacklisted users found, staying in current server.")
else
    print("[DEBUG] Place not in watchlist, doing nothing.")
end
