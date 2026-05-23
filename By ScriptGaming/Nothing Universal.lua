local NothingLibrary = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/3345-c-a-t-s-u-s/NOTHING/main/source.lua'))()

local Windows = NothingLibrary.new({
    Title = "SC GAMING",
    Description = "SC GAMING",
    Keybind = Enum.KeyCode.LeftControl,
    Logo = 'http://www.roblox.com/asset/?id=18898582662'
})

local TabFrame1 = Windows:NewTab({
    Title = "Player",
    Description = "Player",
    Icon = "rbxassetid://7992557358"
})

local Section = TabFrame1:NewSection({
    Title = "LocalPlayer",
    Icon = "rbxassetid://7992557358",
    Position = "Left"
})

local SectionRight = TabFrame1:NewSection({
    Title = "Other",
    Icon = "rbxassetid://7743869054",
    Position = "Right"
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local currentSpeed = 16 

local function applySpeed()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = currentSpeed  -- PAKE VARIABLE DARI LUAR
        end
    end
end

Section:NewSlider({
    Title = "WalkSpeed",
    Min = 15,
    Max = 50,
    Default = 16,
    Callback = function(value)
        currentSpeed = value
        applySpeed()
        print("WalkSpeed: " .. currentSpeed)
    end,
})

print("Current speed Fast: " .. currentSpeed)

task.spawn(function()
    while wait(5) do
        print("Speed sekarang: " .. currentSpeed)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    applySpeed()
end)

RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and humanoid.WalkSpeed ~= currentSpeed then
            humanoid.WalkSpeed = currentSpeed
        end
    end
end)

applySpeed()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local noclipActive = false
local character = nil
local noclipConn = nil

local function startNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    
    noclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if char and noclipActive then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function stopNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

Section:NewToggle({
    Title = "Noclip",
    Default = false,
    Callback = function(value)
        noclipActive = value
        if noclipActive then
            startNoclip()
            print("Noclip: ON")
        else
            stopNoclip()
            print("Noclip: OFF")
        end
    end,
})

LocalPlayer.CharacterAdded:Connect(function()
    if noclipActive then
        task.wait(0.5)
        startNoclip()
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local antiAFKActive = false
local afkConnection = nil

local function startAntiAFK()
    if afkConnection then
        afkConnection:Disconnect()
        afkConnection = nil
    end
    
    afkConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if antiAFKActive then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                game:GetService("ReplicatedStorage"):FindFirstChild("LocalInput"):FireServer("Jump")
            end)
        end
    end)
end

local function stopAntiAFK()
    if afkConnection then
        afkConnection:Disconnect()
        afkConnection = nil
    end
end

SectionRight:NewButton({
    Title = "Anti AFK(Don't Use)",
    Callback = function()
        if not antiAFKActive then
            antiAFKActive = true
            startAntiAFK()
            print("Anti AFK: ON")
            return
        end
        
        antiAFKActive = false
        stopAntiAFK()
        print("Anti AFK: OFF")
    end,
})

local TabFrame2 = Windows:NewTab({
    Title = "ESP",
    Description = "ESP",
    Icon = "rbxassetid://7733960981"
})

local Section = TabFrame2:NewSection({
    Title = "ESP",
    Icon = "rbxassetid://120129574453255",
    Position = "Left"
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local espActive = false
local espObjects = {}

local colors = {
    ["Friend"] = Color3.fromRGB(0, 255, 0),
    ["Enemy"] = Color3.fromRGB(255, 0, 0),
    ["Neutral"] = Color3.fromRGB(255, 255, 0)
}

local function createESP(player)
    if not player.Character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = player.Character
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    if player.Team and LocalPlayer.Team then
        if player.Team == LocalPlayer.Team then
            highlight.FillColor = colors.Friend
            highlight.OutlineColor = colors.Friend
        else
            highlight.FillColor = colors.Enemy
            highlight.OutlineColor = colors.Enemy
        end
    else
        highlight.FillColor = colors.Neutral
        highlight.OutlineColor = colors.Neutral
    end
    
    highlight.Parent = player.Character
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Name"
    billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = player.Character
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.Parent = billboard
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 1, 0)
    distanceLabel.Position = UDim2.new(0, 0, 1, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = ""
    distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distanceLabel.TextSize = 10
    distanceLabel.Font = Enum.Font.Code
    distanceLabel.Parent = billboard
    
    espObjects[player] = {
        Highlight = highlight,
        Billboard = billboard,
        NameLabel = nameLabel,
        DistanceLabel = distanceLabel
    }
end

local function removeESP(player)
    if espObjects[player] then
        if espObjects[player].Highlight then
            espObjects[player].Highlight:Destroy()
        end
        if espObjects[player].Billboard then
            espObjects[player].Billboard:Destroy()
        end
        espObjects[player] = nil
    end
end

local function updateDistance()
    local char = LocalPlayer.Character
    local rootPart = char and char:FindFirstChild("HumanoidRootPart")
    
    if not rootPart then return end
    
    for player, data in pairs(espObjects) do
        if data.DistanceLabel and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local distance = (rootPart.Position - targetRoot.Position).Magnitude
                data.DistanceLabel.Text = math.floor(distance) .. " studs"
            end
        end
    end
end

local function startESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        if espActive then
            player.CharacterAdded:Connect(function()
                if espActive then
                    task.wait(0.5)
                    createESP(player)
                end
            end)
            if player ~= LocalPlayer then
                createESP(player)
            end
        end
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        removeESP(player)
    end)
    
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        for player, data in pairs(espObjects) do
            if player.Character then
                if data.Highlight then
                    data.Highlight.Adornee = player.Character
                end
                if data.Billboard then
                    data.Billboard.Parent = player.Character
                end
            end
        end
    end)
    
    task.spawn(function()
        while espActive do
            updateDistance()
            task.wait(0.2)
        end
    end)
end

local function stopESP()
    for player, _ in pairs(espObjects) do
        removeESP(player)
    end
    espObjects = {}
end

Section:NewToggle({
    Title = "ESP Player",
    Default = false,
    Callback = function(value)
        espActive = value
        if espActive then
            startESP()
            print("ESP Player: ON")
        else
            stopESP()
            print("ESP Player: OFF")
        end
    end,
})
