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
local RunService = game:GetService("RunService")

_G.Toggle = {}

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

-- nút mở
local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,55,0,55)
open.Position = UDim2.new(0,20,0,200)
open.Text = "≡"
open.BackgroundColor3 = Color3.fromRGB(20,20,20)
open.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", open)

-- drag nút
local draggingBtn,startPosBtn,startFrameBtn
open.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch then
        draggingBtn=true
        startPosBtn=i.Position
        startFrameBtn=open.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if draggingBtn and i.UserInputType==Enum.UserInputType.Touch then
        local d=i.Position-startPosBtn
        open.Position=UDim2.new(startFrameBtn.X.Scale,startFrameBtn.X.Offset+d.X,startFrameBtn.Y.Scale,startFrameBtn.Y.Offset+d.Y)
    end
end)

open.InputEnded:Connect(function() draggingBtn=false end)

-- menu
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,280,0,360)
main.Position = UDim2.new(0.5,-140,0.5,-180)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible=false
Instance.new("UICorner", main)

open.MouseButton1Click:Connect(function()
    main.Visible=not main.Visible
end)

-- drag menu
local dragging,startPos,startFrame
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

-- pages
local function page()
    local f=Instance.new("Frame",main)
    f.Size=UDim2.new(1,0,1,0)
    f.BackgroundTransparency=1
    f.Visible=false
    local layout=Instance.new("UIListLayout",f)
    layout.Padding=UDim.new(0,5)
    return f
end

local combat=page()
local farm=page()
local misc=page()
combat.Visible=true

-- button
local function btn(parent,text,func)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(1,-10,0,35)
    b.Text=text.." OFF"
    b.TextColor3=Color3.new(1,1,1)
    b.BackgroundColor3=Color3.fromRGB(45,45,45)
    Instance.new("UICorner",b)

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

-- SPEED
btn(misc,"⚡ Speed",function(v)
    local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed=v and 90 or 16 end
end)

-- JUMP
btn(misc,"🦘 Jump",function(v)
    local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.JumpPower=v and 120 or 50 end
end)

-- NOCLIP
local noclip=false
btn(misc,"🧱 NoClip",function(v) noclip=v end)

RunService.Stepped:Connect(function()
    if noclip and player.Character then
        for _,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end
end)

-- AURA REAL
btn(combat,"⚔️ Aura",function(v)
    _G.Toggle.Aura=v
    task.spawn(function()
        while _G.Toggle.Aura do
            local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _,m in pairs(workspace:GetDescendants()) do
                    if m:IsA("Model")
                    and m:FindFirstChildOfClass("Humanoid")
                    and not game.Players:GetPlayerFromCharacter(m) then

                        local hrp=m:FindFirstChild("HumanoidRootPart")
                        local hum=m:FindFirstChildOfClass("Humanoid")

                        if hrp and hum and hum.Health>0 then
                            if (hrp.Position-root.Position).Magnitude<=25 then
                                root.CFrame=hrp.CFrame*CFrame.new(0,0,3)
                            end
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    end)
end)

-- AUTO FARM
btn(farm,"🤖 Auto Farm",function(v)
    _G.Toggle.Farm=v
    task.spawn(function()
        while _G.Toggle.Farm do
            local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _,m in pairs(workspace:GetDescendants()) do
                    if m:IsA("Model")
                    and m:FindFirstChildOfClass("Humanoid")
                    and not game.Players:GetPlayerFromCharacter(m) then
                        local hrp=m:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            root.CFrame=hrp.CFrame*CFrame.new(0,0,4)
                            break
                        end
                    end
                end
            end
            task.wait(0.3)
        end
    end)
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

-- ESP NPC
btn(misc,"👹 ESP NPC",function(v)
    for _,m in pairs(workspace:GetDescendants()) do
        if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") then
            if not game.Players:GetPlayerFromCharacter(m) then
                if v then
                    if not m:FindFirstChild("NPCESP") then
                        local h=Instance.new("Highlight",m)
                        h.Name="NPCESP"
                        h.FillColor=Color3.fromRGB(255,100,0)
                    end
                else
                    if m:FindFirstChild("NPCESP") then
                        m.NPCESP:Destroy()
                    end
                end
            end
        end
    end
end)

-- BRING ITEM (ỔN ĐỊNH)
btn(farm,"🧲 Bring Item",function(v)
    _G.Toggle.Bring=v
    task.spawn(function()
        while _G.Toggle.Bring do
            local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _,obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") then
                        local h=obj:FindFirstChild("Handle")
                        if h and (h.Position-root.Position).Magnitude<=200 then
                            h.CFrame=root.CFrame*CFrame.new(0,0,-3)
                        end
                    end
                end
            end
            task.wait(0.4)
        end
    end)
end)
