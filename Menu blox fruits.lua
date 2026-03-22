if _G.Loaded then return end
_G.Loaded = true
_G.Toggle = {}

--// KEY
local correctKey="anhprofruits"
local linkGetKey="https://taplayma.com/link/q4bBnT4gd0"

local saved=""
pcall(function()
    if readfile and isfile("forest_key.txt") then
        saved=readfile("forest_key.txt")
    end
end)

local k=Instance.new("ScreenGui",game.CoreGui)
local f=Instance.new("Frame",k)
f.Size=UDim2.new(0,260,0,180)
f.Position=UDim2.new(0.5,-130,0.5,-90)

local box=Instance.new("TextBox",f)
box.Size=UDim2.new(1,-20,0,40)
box.Position=UDim2.new(0,10,0,40)
box.Text=saved

local btn=Instance.new("TextButton",f)
btn.Size=UDim2.new(1,-20,0,35)
btn.Position=UDim2.new(0,10,0,90)
btn.Text="XÁC NHẬN"

btn.MouseButton1Click:Connect(function()
    if box.Text==correctKey then
        if writefile then writefile("forest_key.txt",box.Text) end
        k:Destroy()
        _G.Unlocked=true
    end
end)

repeat task.wait() until _G.Unlocked

--// SERVICES
local plr=game.Players.LocalPlayer
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")

--// GUI
local gui=Instance.new("ScreenGui",game.CoreGui)

local open=Instance.new("TextButton",gui)
open.Size=UDim2.new(0,50,0,50)
open.Text="≡"

local main=Instance.new("Frame",gui)
main.Size=UDim2.new(0,320,0,420)
main.Visible=false

open.MouseButton1Click:Connect(function()
    main.Visible=not main.Visible
end)

-- DRAG
local function drag(f)
    local d,s,sp
    f.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch then
            d=true s=i.Position sp=f.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if d then
            local delta=i.Position-s
            f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+delta.X,sp.Y.Scale,sp.Y.Offset+delta.Y)
        end
    end)
end
drag(open) drag(main)

-- AI FARM CORE
local function getTarget()
    local root=plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    local boss, mob, chest

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") then
            local hum=v:FindFirstChildOfClass("Humanoid")
            local hrp=v:FindFirstChild("HumanoidRootPart")

            if hum and hrp and hum.Health>0 then
                if string.find(v.Name,"Boss") then
                    boss=hrp
                else
                    mob=hrp
                end
            end
        end

        if v:IsA("Part") and string.find(v.Name,"Chest") then
            chest=v
        end
    end

    return boss or mob or chest
end

-- TOGGLE BUTTON
local function makeBtn(txt,func,y)
    local b=Instance.new("TextButton",main)
    b.Size=UDim2.new(1,-20,0,40)
    b.Position=UDim2.new(0,10,0,y)
    b.Text=txt.." OFF"

    local s=false
    b.MouseButton1Click:Connect(function()
        s=not s
        b.Text=txt.." "..(s and "ON" or "OFF")
        func(s)
    end)
end

-- GOD
makeBtn("💀 God",function(v)
    _G.Toggle.God=v
end,10)

-- AI FARM
makeBtn("🤖 AI FARM",function(v)
    _G.Toggle.AI=v
end,60)

-- SPEED
makeBtn("⚡ Speed",function(v)
    local h=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed=v and 80 or 16 end
end,110)

-- LOOP
RunService.RenderStepped:Connect(function()
    local char=plr.Character
    local root=char and char:FindFirstChild("HumanoidRootPart")
    local tool=char and char:FindFirstChildOfClass("Tool")

    if _G.Toggle.God then
        local h=char and char:FindFirstChildOfClass("Humanoid")
        if h then h.Health=h.MaxHealth end
    end

    if _G.Toggle.AI and root then
        local target=getTarget()
        if target then
            root.CFrame=target.CFrame*CFrame.new(0,0,3)
            if tool then tool:Activate() end
        end
    end
end)
