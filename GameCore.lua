local player = game.Players.LocalPlayer

-- واجهة
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PlayerControlUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 260)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

-- زر اختيار لاعب
local dropdown = Instance.new("TextButton", frame)
dropdown.Size = UDim2.new(1, -20, 0, 40)
dropdown.Position = UDim2.new(0, 10, 0, 10)
dropdown.Text = "اختر لاعب"
dropdown.TextScaled = true
dropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
dropdown.TextColor3 = Color3.new(1, 1, 1)

-- قائمة الأسماء (ScrollingFrame)
local playerList = Instance.new("ScrollingFrame", frame)
playerList.Size = UDim2.new(1, -20, 0, 100)
playerList.Position = UDim2.new(0, 10, 0, 50)
playerList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playerList.Visible = false
playerList.ScrollBarThickness = 6
playerList.AutomaticCanvasSize = Enum.AutomaticSize.Y
playerList.ScrollingDirection = Enum.ScrollingDirection.Y
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ClipsDescendants = true

-- زر قتل
local killBtn = Instance.new("TextButton", frame)
killBtn.Size = UDim2.new(1, -20, 0, 40)
killBtn.Position = UDim2.new(0, 10, 0, 160)
killBtn.Text = "قتل"
killBtn.TextScaled = true
killBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
killBtn.TextColor3 = Color3.new(1, 1, 1)

-- زر سحب
local pullBtn = Instance.new("TextButton", frame)
pullBtn.Size = UDim2.new(1, -20, 0, 40)
pullBtn.Position = UDim2.new(0, 10, 0, 205)
pullBtn.Text = "سحب"
pullBtn.TextScaled = true
pullBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
pullBtn.TextColor3 = Color3.new(1, 1, 1)

-- زر تحديث
local refreshBtn = Instance.new("TextButton", frame)
refreshBtn.Size = UDim2.new(1, -20, 0, 30)
refreshBtn.Position = UDim2.new(0, 10, 0, 130)
refreshBtn.Text = "تحديث"
refreshBtn.TextScaled = true
refreshBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
refreshBtn.TextColor3 = Color3.new(1, 1, 1)

-- وظيفة التحديث
local selectedPlayer = nil
local function updatePlayerList()
	for _, child in pairs(playerList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local y = 0
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= player then
			local btn = Instance.new("TextButton", playerList)
			btn.Size = UDim2.new(1, 0, 0, 25)
			btn.Position = UDim2.new(0, 0, 0, y)
			btn.Text = plr.Name
			btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.TextScaled = true
			y = y + 25
			btn.MouseButton1Click:Connect(function()
				selectedPlayer = plr
				dropdown.Text = "المختار: " .. plr.Name
				playerList.Visible = false
			end)
		end
	end

	playerList.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- اتصالات الأزرار
dropdown.MouseButton1Click:Connect(function()
	updatePlayerList()
	playerList.Visible = not playerList.Visible
end)

refreshBtn.MouseButton1Click:Connect(function()
	updatePlayerList()
end)

pullBtn.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character and player.Character then
		local root = player.Character:FindFirstChild("HumanoidRootPart")
		local targetRoot = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
		if root and targetRoot then
			targetRoot.CFrame = root.CFrame + Vector3.new(2, 0, 0)
		end
	end
end)

killBtn.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character then
		local humanoid = selectedPlayer.Character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid.Health = 0
		end
	end
end)