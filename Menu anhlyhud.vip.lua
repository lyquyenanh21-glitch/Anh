--// 🔐 KEY SYSTEM

local correctKey = "anhprofruits"

local savedKey = ""
pcall(function()
    if readfile and isfile("forest_key.txt") then
        savedKey = readfile("forest_key.txt")
    end
end)

local keyGui = Instance.new("ScreenGui", game.CoreGui)

local frame = Instance.new("Frame", keyGui)
frame.Size = UDim2.new(0,260,0,180)
frame.Position = UDim2.new(0.5,-130,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "🔐 ENTER KEY"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(1,-20,0,40)
box.Position = UDim2.new(0,10,0,50)
box.Text = savedKey
box.PlaceholderText = "Nhập key..."
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", box)

local check = Instance.new("TextButton", frame)
check.Size = UDim2.new(1,-20,0,35)
check.Position = UDim2.new(0,10,0,100)
check.Text = "XÁC NHẬN"
check.BackgroundColor3 = Color3.fromRGB(50,50,50)
check.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", check)

-- link
local linkBtn = Instance.new("TextButton", frame)
linkBtn.Size = UDim2.new(1,-20,0,30)
linkBtn.Position = UDim2.new(0,10,0,140)
linkBtn.Text = "📋 Copy Link Get Key"
linkBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
linkBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", linkBtn)

local link = "https://taplayma.com/link/q4bBnT4gd0"

linkBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(link) end
    linkBtn.Text = "✅ Đã copy!"
    task.wait(1.5)
    linkBtn.Text = "📋 Copy Link Get Key"
end)

local unlocked = false

check.MouseButton1Click:Connect(function()
    if box.Text == correctKey then
        unlocked = true
        if writefile then writefile("forest_key.txt", box.Text) end
        keyGui:Destroy()
    else
        check.Text = "❌ Sai key"
        task.wait(1)
        check.Text = "XÁC NHẬN"
    end
end)

if savedKey == correctKey then
    unlocked = true
    keyGui:Destroy()
end

repeat task.wait() until unlocked
--// UI PRO MAX

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", game.CoreGui)

local settings = {
    god=false,speed=false,jump=false,fly=false,
    noclip=false,aura=false,autofarm=false
}

-- nút mở
local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,55,0,55)
open.Position = UDim2.new(0,20,0,200)
open.Text = "≡"
open.BackgroundColor3 = Color3.fromRGB(20,20,20)
open.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", open).CornerRadius = UDim.new(1,0)

-- menu
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,280,0,320)
main.Position = UDim2.new(0.5,-140,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible = false
Instance.new("UICorner", main)

open.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- tab system
local pages = {}
local function createPage(name)
    local page = Instance.new("Frame", main)
    page.Size = UDim2.new(1,0,1,-40)
    page.Position = UDim2.new(0,0,0,40)
    page.BackgroundTransparency = 1
    page.Visible = false
    pages[name]=page
    return page
end

local combat = createPage("combat")
local farm = createPage("farm")
local misc = createPage("misc")

combat.Visible = true

-- button
local function btn(parent,text,key,func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-10,0,35)
    b.Text = text..": OFF"
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", b)

    b.MouseButton1Click:Connect(function()
        settings[key]=not settings[key]
        b.Text = text..": "..(settings[key] and "ON" or "OFF")
        func(settings[key])
    end)
end
-- GOD
local god=false
btn(combat,"💀 God","god",function(v)
    god=v
    task.spawn(function()
        while god do
            local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if h then h.Health=h.MaxHealth end
            task.wait(0.15)
        end
    end)
end)

-- SPEED
btn(misc,"⚡ Speed","speed",function(v)
    local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = v and 90 or 16 end
end)

-- JUMP x3
btn(misc,"🦘 Jump","jump",function(v)
    local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.JumpPower = v and 150 or 50 end
end)

-- FLY
local fly=false
btn(misc,"✈️ Fly","fly",function(v)
    fly=v
    task.spawn(function()
        while fly do
            local r=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if r then r.Velocity=Vector3.new(0,20,0) end
            task.wait(0.1)
        end
    end)
end)

-- NOCLIP
local noclip=false
btn(misc,"🧱 NoClip","noclip",function(v)
    noclip=v
end)

RunService.Stepped:Connect(function()
    if noclip then
        for _,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end
end)

-- AURA
local aura=false
btn(combat,"⚔️ Aura","aura",function(v)
    aura=v
    task.spawn(function()
        while aura do
            local r=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if r then
                for _,v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") then
                        local hrp=v:FindFirstChild("HumanoidRootPart")
                        local hum=v:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health>0 then
                            if (hrp.Position-r.Position).Magnitude<=20 then
                                hum:TakeDamage(5)
                            end
                        end
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end)

-- AUTO FARM
local autofarm=false
btn(farm,"🤖 Auto Farm","autofarm",function(v)
    autofarm=v
end)
