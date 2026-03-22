if _G.Loaded then return end
_G.Loaded = true
_G.Toggle = {}
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

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(1,-20,0,40)
box.Position = UDim2.new(0,10,0,40)
box.Text = savedKey
box.PlaceholderText = "Nhập key..."
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", box)

local check = Instance.new("TextButton", frame)
check.Size = UDim2.new(1,-20,0,35)
check.Position = UDim2.new(0,10,0,90)
check.Text = "XÁC NHẬN"
check.BackgroundColor3 = Color3.fromRGB(50,50,50)
check.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", check)

local link = Instance.new("TextButton", frame)
link.Size = UDim2.new(1,-20,0,30)
link.Position = UDim2.new(0,10,0,130)
link.Text = "📋 Copy Link"
link.BackgroundColor3 = Color3.fromRGB(60,60,60)
link.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", link)

link.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://taplayma.com/link/q4bBnT4gd0")
    end
end)

local unlocked=false
check.MouseButton1Click:Connect(function()
    if box.Text==correctKey then
        unlocked=true
        if writefile then writefile("forest_key.txt",box.Text) end
        keyGui:Destroy()
    end
end)

if savedKey==correctKey then
    unlocked=true
    keyGui:Destroy()
end

repeat task.wait() until unlocked
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", game.CoreGui)

-- LOGO
local logo = Instance.new("TextLabel", gui)
logo.Size = UDim2.new(0,260,0,30)
logo.Position = UDim2.new(0,10,0,10)
logo.BackgroundTransparency = 1
logo.Text = "💀 anhlyhud | @anh.vip.pro.fruits"
logo.TextColor3 = Color3.new(1,1,1)
logo.TextScaled = true
logo.Font = Enum.Font.GothamBold

-- OPEN
local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,55,0,55)
open.Position = UDim2.new(0,20,0,200)
open.Text = "≡"
open.BackgroundColor3 = Color3.fromRGB(20,20,20)
open.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", open)

-- DRAG BTN
local dragging,startPos,startFrame
open.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        startPos=i.Position
        startFrame=open.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType==Enum.UserInputType.Touch then
        local d=i.Position-startPos
        open.Position=UDim2.new(startFrame.X.Scale,startFrame.X.Offset+d.X,startFrame.Y.Scale,startFrame.Y.Offset+d.Y)
    end
end)

open.InputEnded:Connect(function() dragging=false end)

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,300,0,380)
main.Position = UDim2.new(0.5,-150,0.5,-190)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible=false
Instance.new("UICorner", main)

open.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- DRAG MENU
main.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        startPos=i.Position
        startFrame=main.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType==Enum.UserInputType.Touch then
        local d=i.Position-startPos
        main.Position=UDim2.new(startFrame.X.Scale,startFrame.X.Offset+d.X,startFrame.Y.Scale,startFrame.Y.Offset+d.Y)
    end
end)

main.InputEnded:Connect(function() dragging=false end)

-- TAB
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(1,0,0,45)
tabBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", tabBar)

local function page()
    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1,0,1,-50)
    scroll.Position = UDim2.new(0,0,0,50)
    scroll.ScrollBarThickness = 4
    scroll.BackgroundTransparency = 1
    scroll.Visible = false

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,6)

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
    end)

    return scroll
end

local combat = page()
local farm = page()
local misc = page()
combat.Visible = true

local function switch(tab)
    combat.Visible=false
    farm.Visible=false
    misc.Visible=false
    tab.Visible=true
end

local function makeTab(text,pos,tab)
    local b = Instance.new("TextButton", tabBar)
    b.Size = UDim2.new(0.33,0,1,0)
    b.Position = UDim2.new(pos,0,0,0)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)

    b.MouseButton1Click:Connect(function()
        switch(tab)
    end)
end

makeTab("⚔️",0,combat)
makeTab("🤖",0.33,farm)
makeTab("⚙️",0.66,misc)

local function btn(parent,text,func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-10,0,40)
    b.Text = text.." OFF"
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", b)

    local state=false
    b.MouseButton1Click:Connect(function()
        state=not state
        b.Text=text.." "..(state and "ON" or "OFF")
        func(state)
    end)
end
-- GOD
btn(combat,"💀 God",function(v)
    _G.Toggle.God=v
    task.spawn(function()
        while _G.Toggle.God do
            local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if h then h.Health=h.MaxHealth end
            task.wait(0.1)
        end
    end)
end)

-- AURA PRO (ĐÁNH THẬT)
btn(combat,"⚔️ Aura Pro",function(v)
    _G.Toggle.Aura=v

    task.spawn(function()
        while _G.Toggle.Aura do
            local char=player.Character
            local root=char and char:FindFirstChild("HumanoidRootPart")

            if char and root then
                local tool=char:FindFirstChildOfClass("Tool")

                for _,m in pairs(workspace:GetDescendants()) do
                    if m:IsA("Model")
                    and m:FindFirstChildOfClass("Humanoid")
                    and not game.Players:GetPlayerFromCharacter(m) then

                        local hrp=m:FindFirstChild("HumanoidRootPart")
                        local hum=m:FindFirstChildOfClass("Humanoid")

                        if hrp and hum and hum.Health>0 then
                            if (hrp.Position-root.Position).Magnitude<=20 then
                                root.CFrame=CFrame.new(root.Position,hrp.Position)
                                if tool then tool:Activate() end
                            end
                        end
                    end
                end
            end

            task.wait(0.2)
        end
    end)
end)

-- AUTO FARM PRO
btn(farm,"🤖 Auto Farm Pro",function(v)
    _G.Toggle.Farm=v

    task.spawn(function()
        while _G.Toggle.Farm do
            local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")

            if root then
                local nearest=nil
                local dist=math.huge

                for _,m in pairs(workspace:GetDescendants()) do
                    if m:IsA("Model")
                    and m:FindFirstChildOfClass("Humanoid")
                    and not game.Players:GetPlayerFromCharacter(m) then

                        local hrp=m:FindFirstChild("HumanoidRootPart")
                        local hum=m:FindFirstChildOfClass("Humanoid")

                        if hrp and hum and hum.Health>0 then
                            local d=(hrp.Position-root.Position).Magnitude
                            if d<dist then
                                dist=d
                                nearest=hrp
                            end
                        end
                    end
                end

                if nearest then
                    root.CFrame=nearest.CFrame*CFrame.new(0,0,3)
                end
            end

            task.wait(0.3)
        end
    end)
end)

-- SPEED
btn(misc,"⚡ Speed",function(v)
    local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed=v and 80 or 16 end
end)

-- JUMP
btn(misc,"🦘 Jump",function(v)
    local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.JumpPower=v and 120 or 50 end
end)

-- ESP PLAYER
btn(misc,"👁️ ESP Player",function(v)
    for _,p in pairs(game.Players:GetPlayers()) do
        if p~=player and p.Character then
            if v then
                if not p.Character:FindFirstChild("ESP") then
                    local h=Instance.new("Highlight",p.Character)
                    h.Name="ESP"
                    h.FillColor=Color3.fromRGB(255,0,0)
                end
            else
                if p.Character:FindFirstChild("ESP") then
                    p.Character.ESP:Destroy()
                end
            end
        end
    end
end)
