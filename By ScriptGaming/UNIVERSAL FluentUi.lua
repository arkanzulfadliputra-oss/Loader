local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "UNIVERSAL",
    SubTitle = "by SC Gaming",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Esp = Window:AddTab({ Title = "Esp", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

Fluent:Notify({
    Title = "Fluent",
    Content = "Script has been loaded",
    SubContent = "Ready",
    Duration = 5
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
            humanoid.WalkSpeed = currentSpeed
        end
    end
end

local Slider = Tabs.Main:AddSlider("WalkSpeedSlider", {
    Title = "WalkSpeed",
    Description = "Well",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        currentSpeed = Value
        applySpeed()
        print("WalkSpeed set to:", Value)
    end
})

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
local noclipConn = nil

local function startNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    
    noclipConn = RunService.Stepped:Connect(function()
        if noclipActive then
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
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
    
    local character = LocalPlayer.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local NoclipToggle = Tabs.Main:AddToggle("NoclipToggle", {
    Title = "Noclip",
    Description = "Wallhack",
    Default = false
})

NoclipToggle:OnChanged(function()
    noclipActive = Options.NoclipToggle.Value
    if noclipActive then
        startNoclip()
        print("Noclip: ON")
    else
        stopNoclip()
        print("Noclip: OFF")
    end
end)

Options.NoclipToggle:SetValue(false)

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

local AntiAFKToggle = Tabs.Main:AddToggle("AntiAFKToggle", {
    Title = "Anti AFK",
    Description = "AFK",
    Default = false
})

AntiAFKToggle:OnChanged(function()
    antiAFKActive = Options.AntiAFKToggle.Value
    if antiAFKActive then
        startAntiAFK()
        print("Anti AFK: ON")
    else
        stopAntiAFK()
        print("Anti AFK: OFF")
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local espActive = false
local espObjects = {}

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
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
        else
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        end
    else
        highlight.FillColor = Color3.fromRGB(255, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
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
    
    espObjects[player] = {
        Highlight = highlight,
        Billboard = billboard
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
end

local function stopESP()
    for player, _ in pairs(espObjects) do
        removeESP(player)
    end
    espObjects = {}
end

local EspToggle = Tabs.Esp:AddToggle("EspToggle", {
    Title = "ESP Player",
    Description = "Esp",
    Default = false
})

EspToggle:OnChanged(function()
    espActive = Options.EspToggle.Value
    if espActive then
        startESP()
        print("ESP Player: ON")
    else
        stopESP()
        print("ESP Player: OFF")
    end
end)

Options.EspToggle:SetValue(false)

Options.AntiAFKToggle:SetValue(false)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()
