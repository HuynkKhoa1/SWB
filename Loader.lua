-- Raise a Zoo UI 

-- LocalScript

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local playerData = ReplicatedStorage:WaitForChild("Player_Data"):WaitForChild("sP1I6HtptK")
local onStocks = playerData:WaitForChild("OnStocks")
local shopResetTime = ReplicatedStorage:WaitForChild("Values"):WaitForChild("ShopResetTime")

-- Animal data with icons and rarity
local animalData = {
	Snake = {icon = "rbxassetid://123882494450027", rarity = "Basic", order = 1},
	Buffalo = {icon = "rbxassetid://117771605461445", rarity = "Basic", order = 1},
	Ostrich = {icon = "rbxassetid://85321926244418", rarity = "Basic", order = 1},
	Zebra = {icon = "rbxassetid://81635855574346", rarity = "Basic", order = 1},
	
	Moose = {icon = "rbxassetid://116883483561692", rarity = "Rare", order = 2},
	Yak = {icon = "rbxassetid://128956984397633", rarity = "Rare", order = 2},
	Toucan = {icon = "rbxassetid://74937156254549", rarity = "Rare", order = 2},
	
	Tiger = {icon = "rbxassetid://128373766943533", rarity = "Epic", order = 3},
	Penguin = {icon = "rbxassetid://111237163147765", rarity = "Epic", order = 3},
	Elephant = {icon = "rbxassetid://79248934960825", rarity = "Epic", order = 3},
	Giraffe = {icon = "rbxassetid://78714174435705", rarity = "Epic", order = 3},
	Walrus = {icon = "rbxassetid://94122228707356", rarity = "Epic", order = 3},
	
	Gorilla = {icon = "rbxassetid://120516754148885", rarity = "Legendary", order = 4},
	["Polar Bear"] = {icon = "rbxassetid://139351686522199", rarity = "Legendary", order = 4},
	Crocodile = {icon = "rbxassetid://111699684022475", rarity = "Legendary", order = 4},
	
	Lion = {icon = "rbxassetid://120314985627016", rarity = "Rainbow", order = 5},
	Narwhal = {icon = "rbxassetid://115752492784347", rarity = "Rainbow", order = 5},
}

local rarityColors = {
	Basic = Color3.fromRGB(150, 150, 150),
	Rare = Color3.fromRGB(100, 150, 255),
	Epic = Color3.fromRGB(160, 80, 255),
	Legendary = Color3.fromRGB(255, 170, 0),
	Rainbow = Color3.fromRGB(255, 50, 255)
}

-- UI setup
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = Player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 480)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(80, 80, 100)
uiStroke.Thickness = 2
uiStroke.Transparency = 0.5
uiStroke.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Animal Stocks"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Minimize button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -80, 0.5, -17.5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minimizeBtn.BackgroundTransparency = 0.3
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextSize = 24
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeBtn

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- ScrollingFrame for stock items
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -115)
scrollFrame.Position = UDim2.new(0, 10, 0, 55)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ClipsDescendants = true
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

-- Timer label
local timerFrame = Instance.new("Frame")
timerFrame.Size = UDim2.new(1, -20, 0, 50)
timerFrame.Position = UDim2.new(0, 10, 1, -60)
timerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
timerFrame.BackgroundTransparency = 0.3
timerFrame.BorderSizePixel = 0
timerFrame.Parent = mainFrame

local timerCorner = Instance.new("UICorner")
timerCorner.CornerRadius = UDim.new(0, 10)
timerCorner.Parent = timerFrame

local nextStockLabel = Instance.new("TextLabel")
nextStockLabel.Size = UDim2.new(1, 0, 1, 0)
nextStockLabel.Position = UDim2.new(0, 0, 0, 0)
nextStockLabel.BackgroundTransparency = 1
nextStockLabel.Text = "⏰ Next Stock: ..."
nextStockLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
nextStockLabel.TextSize = 16
nextStockLabel.Font = Enum.Font.GothamBold
nextStockLabel.TextXAlignment = Enum.TextXAlignment.Center
nextStockLabel.Parent = timerFrame

-- Create stock item function
local function createStockItem(animalName, amount, data)
	local item = Instance.new("Frame")
	item.Size = UDim2.new(1, -10, 0, 50)
	item.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
	item.BackgroundTransparency = 0.4
	item.BorderSizePixel = 0
	item.Parent = scrollFrame
	
	local itemCorner = Instance.new("UICorner")
	itemCorner.CornerRadius = UDim.new(0, 8)
	itemCorner.Parent = item
	
	local itemStroke = Instance.new("UIStroke")
	itemStroke.Color = rarityColors[data.rarity] or Color3.fromRGB(100, 100, 100)
	itemStroke.Thickness = 2
	itemStroke.Transparency = 0.6
	itemStroke.Parent = item
	
	-- Icon
	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.new(0, 40, 0, 40)
	icon.Position = UDim2.new(0, 5, 0.5, -20)
	icon.BackgroundTransparency = 1
	icon.Image = data.icon
	icon.Parent = item
	
	-- Name
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(0, 150, 0, 20)
	nameLabel.Position = UDim2.new(0, 50, 0, 5)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = animalName
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextSize = 15
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = item
	
	-- Rarity
	local rarityLabel = Instance.new("TextLabel")
	rarityLabel.Size = UDim2.new(0, 150, 0, 18)
	rarityLabel.Position = UDim2.new(0, 50, 0, 27)
	rarityLabel.BackgroundTransparency = 1
	rarityLabel.Text = data.rarity
	rarityLabel.TextColor3 = rarityColors[data.rarity] or Color3.fromRGB(150, 150, 150)
	rarityLabel.TextSize = 12
	rarityLabel.Font = Enum.Font.Gotham
	rarityLabel.TextXAlignment = Enum.TextXAlignment.Left
	rarityLabel.Parent = item
	
	-- Amount
	local amountLabel = Instance.new("TextLabel")
	amountLabel.Size = UDim2.new(0, 80, 1, 0)
	amountLabel.Position = UDim2.new(1, -85, 0, 0)
	amountLabel.BackgroundTransparency = 1
	amountLabel.Text = "x" .. amount
	amountLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
	amountLabel.TextSize = 20
	amountLabel.Font = Enum.Font.GothamBold
	amountLabel.TextXAlignment = Enum.TextXAlignment.Right
	amountLabel.Parent = item
	
	return item
end

-- Update stock display
local currentItems = {}

local function updateStock(animalFolder)
	-- Clear existing items
	for _, item in pairs(currentItems) do
		item:Destroy()
	end
	currentItems = {}
	
	-- Collect animals with stock
	local animals = {}
	for _, animal in pairs(animalFolder:GetChildren()) do
		local amount = animal:FindFirstChild("Amount")
		if amount and amount.Value > 0 then
			local data = animalData[animal.Name]
			if data then
				table.insert(animals, {
					name = animal.Name,
					amount = amount.Value,
					data = data
				})
			end
		end
	end
	
	-- Sort by order (rarity) then name
	table.sort(animals, function(a, b)
		if a.data.order ~= b.data.order then
			return a.data.order < b.data.order
		end
		return a.name < b.name
	end)
	
	-- Create items
	for _, animalInfo in ipairs(animals) do
		local item = createStockItem(animalInfo.name, animalInfo.amount, animalInfo.data)
		item.LayoutOrder = animalInfo.data.order * 100
		table.insert(currentItems, item)
	end
	
	-- Update canvas size
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end

-- Bind animal folder
local function bindAnimalFolder(animalFolder)
	animalFolder.ChildAdded:Connect(function(animal)
		local amount = animal:FindFirstChild("Amount")
		if amount then
			amount.Changed:Connect(function()
				updateStock(animalFolder)
			end)
		end
		updateStock(animalFolder)
	end)
	
	animalFolder.ChildRemoved:Connect(function()
		updateStock(animalFolder)
	end)
	
	for _, animal in pairs(animalFolder:GetChildren()) do
		local amount = animal:FindFirstChild("Amount")
		if amount then
			amount.Changed:Connect(function()
				updateStock(animalFolder)
			end)
		end
	end
	
	updateStock(animalFolder)
end

-- Listen for Animal folder changes
onStocks.ChildAdded:Connect(function(child)
	if child.Name == "Animal" then
		bindAnimalFolder(child)
	end
end)

if onStocks:FindFirstChild("Animal") then
	bindAnimalFolder(onStocks.Animal)
end

-- Shop reset timer
shopResetTime.Changed:Connect(function()
	nextStockLabel.Text = "⏰ Next Stock: " .. tostring(shopResetTime.Value)
end)
nextStockLabel.Text = "⏰ Next Stock: " .. tostring(shopResetTime.Value)

-- Button animations and functions
local isMinimized = false

minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	
	if isMinimized then
		-- When minimizing
		scrollFrame.Visible = false
		timerFrame.Visible = false
		local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 380, 0, 45)})
		tween:Play()
		-- Change corner radius for minimized state
		local cornerTween = TweenService:Create(uiCorner, TweenInfo.new(0.3), {CornerRadius = UDim.new(0, 12)})
		cornerTween:Play()
	else
		-- When expanding
		local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 380, 0, 480)})
		tween:Play()
		tween.Completed:Connect(function()
			scrollFrame.Visible = true
			timerFrame.Visible = true
		end)
		-- Restore corner radius
		local cornerTween = TweenService:Create(uiCorner, TweenInfo.new(0.3), {CornerRadius = UDim.new(0, 12)})
		cornerTween:Play()
	end
	
	minimizeBtn.Text = isMinimized and "+" or "−"
end)

closeBtn.MouseButton1Click:Connect(function()
	local tween = TweenService:Create(mainFrame, TweenInfo.new(0.2), {
		Size = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1
	})
	tween:Play()
	tween.Completed:Connect(function()
		screenGui:Destroy()
	end)
end)

-- Hover effects
local function addHoverEffect(button, normalColor, hoverColor)
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
	end)
end

addHoverEffect(minimizeBtn, Color3.fromRGB(50, 50, 60), Color3.fromRGB(70, 70, 80))
addHoverEffect(closeBtn, Color3.fromRGB(200, 50, 50), Color3.fromRGB(255, 70, 70))
