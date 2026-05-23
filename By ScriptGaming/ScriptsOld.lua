local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JadulLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.6
Background.Parent = ScreenGui

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 400, 0, 250)
LoadingFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadingFrame.BorderSizePixel = 3
LoadingFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
LoadingFrame.Parent = ScreenGui

local RainbowBorder = Instance.new("UIStroke")
RainbowBorder.Thickness = 4
RainbowBorder.Parent = LoadingFrame

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = LoadingFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "LOADING"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.TextSize = 28
Title.Font = Enum.Font.Arcade
Title.Parent = LoadingFrame

local LoadingDots = Instance.new("TextLabel")
LoadingDots.Size = UDim2.new(1, 0, 0, 30)
LoadingDots.Position = UDim2.new(0, 0, 0, 55)
LoadingDots.BackgroundTransparency = 1
LoadingDots.Text = "......."
LoadingDots.TextColor3 = Color3.fromRGB(255, 255, 0)
LoadingDots.TextSize = 24
LoadingDots.Font = Enum.Font.Arcade
LoadingDots.Parent = LoadingFrame

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, 0, 0, 25)
SubText.Position = UDim2.new(0, 0, 0, 90)
SubText.BackgroundTransparency = 1
SubText.Text = "Loading Data......"
SubText.TextColor3 = Color3.fromRGB(200, 200, 200)
SubText.TextSize = 14
SubText.Font = Enum.Font.SourceSans
SubText.Parent = LoadingFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0.7, 0, 0, 12)
BarBg.Position = UDim2.new(0.15, 0, 0, 125)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
BarBg.BorderSizePixel = 1
BarBg.BorderColor3 = Color3.fromRGB(0, 0, 0)
BarBg.Parent = LoadingFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = BarBg

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 0, 20)
PercentText.Position = UDim2.new(0, 0, 0, 145)
PercentText.BackgroundTransparency = 1
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentText.TextSize = 12
PercentText.Font = Enum.Font.SourceSans
PercentText.Parent = LoadingFrame

local BottomText = Instance.new("TextLabel")
BottomText.Size = UDim2.new(1, 0, 0, 20)
BottomText.Position = UDim2.new(0, 0, 0, 210)
BottomText.BackgroundTransparency = 1
BottomText.Text = "Please wait..."
BottomText.TextColor3 = Color3.fromRGB(150, 150, 150)
BottomText.TextSize = 11
BottomText.Font = Enum.Font.SourceSans
BottomText.Parent = LoadingFrame

local dotCount = 0
local subIndex = 0
local subMessages = {"Loading Data......", "Update......", "And......."}

local function AnimateLoadingDots()
    dotCount = dotCount + 0.2
    local numDots = 3 + math.floor(math.sin(dotCount) * 4 + 4)
    local dots = string.rep(".", math.min(7, numDots))
    LoadingDots.Text = dots
end

local function UpdateSubText()
    subIndex = subIndex + 1
    if subIndex > #subMessages then
        subIndex = 1
    end
    SubText.Text = subMessages[subIndex]
end

local hue = 0
local function UpdateRainbow()
    hue = (hue + 0.015) % 1
    RainbowBorder.Color = Color3.fromHSV(hue, 1, 1)
end

local progress = 0
local duration = 10

local startTime = tick()
local lastSubChange = 0

local function UpdateLoading()
    local elapsed = tick() - startTime
    progress = math.min(1, elapsed / duration)
    local percent = math.floor(progress * 100)
    
    LoadingBar.Size = UDim2.new(progress, 0, 1, 0)
    PercentText.Text = percent .. "%"
    
    if progress >= 1 then
        BottomText.Text = "Kicked by server..."
        PercentText.Text = "100%"
        LoadingBar.Size = UDim2.new(1, 0, 1, 0)
        wait(0.5)
        LocalPlayer:Kick("Please Upgrade to the Latest Version")
    end
end

local function StartAnimations()
    local dotTimer = 0
    local subTimer = 0
    
    local connection = RunService.RenderStepped:Connect(function(dt)
        dotTimer = dotTimer + dt
        subTimer = subTimer + dt
        
        if dotTimer >= 0.15 then
            dotTimer = 0
            AnimateLoadingDots()
        end
        
        if subTimer >= 2 then
            subTimer = 0
            UpdateSubText()
        end
        
        UpdateRainbow()
        UpdateLoading()
        
        if progress >= 1 then
            connection:Disconnect()
        end
    end)
end

StartAnimations()
