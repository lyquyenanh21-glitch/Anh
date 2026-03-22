--// FOREST VIP PRO MAX FINAL

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

-- ===== WATERMARK =====
local credit = Instance.new("TextLabel", gui)
credit.Size = UDim2.new(0,260,0,25)
credit.Position = UDim2.new(0.5,-130,0,10)
credit.BackgroundTransparency = 1
credit.Text = "anh ly hud | tiktok: @anh.vip.pro.fruits"
credit.TextColor3 = Color3.new(1,1,1)
credit.TextStrokeTransparency = 0
credit.TextScaled = true
credit.ZIndex = 999

-- ===== NÚT MENU (KÉO ĐƯỢC) =====
local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,60,0,60)
open.Position = UDim2.new(0,20,0,200)
open.Text = "≡"
open.BackgroundColor3 = Color3.fromRGB(0,0,0)

local dragging, startPos, startFramePos
open.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        startPos = i.Position
        startFramePos = open.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.Touch then
        local delta = i.Position - startPos
        open.Position = UDim2.new(
            startFramePos.X.Scale,
            startFramePos.X.Offset + delta.X,
            startFramePos.Y.Scale,
            startFramePos.Y.Offset + delta.Y
        )
    end
end)

open.InputEnded:Connect(function()
    dragging = false
end)

-- ===== MENU =====
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,320,0,360)
main.Position = UDim2.new(0.3,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible = false

open.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- kéo menu
local draggingM, startPosM, startFramePosM
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        draggingM = true
        startPosM = i.Position
        startFramePosM = main.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if draggingM and i.UserInputType == Enum.UserInputType.Touch then
        local delta = i.Position - startPosM
        main.Position = UDim2.new(
            startFramePosM.X.Scale,
            startFramePosM.X.Offset + delta.X,
            startFramePosM.Y.Scale,
            startFramePosM.Y.Offset + delta.Y
        )
    end
end)

main.InputEnded:Connect(function()
    draggingM = false
end)

-- layout
local layout = Instance.new("UIListLayout", main)
layout.Padding = UDim.new(0,5)

local function btn(text, func)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(1,0,0,40)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)

    b.MouseButton1Click:Connect(function()
        func(b)
    end)
end

-- =========================
-- 💀 FAKE GOD
-- =========================
local god = false
btn("Fake God: OFF", function(b)
    god = not god
    b.Text = "Fake God: "..(god and "ON" or "OFF")

    task.spawn(function()
        while god do
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = hum.MaxHealth end
            task.wait(0.15)
        end
    end)
end)

-- =========================
-- ⚡ SPEED
-- =========================
local speed = false
local function applySpeed()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = speed and 90 or 16 end
end

btn("Speed: OFF", function(b)
    speed = not speed
    b.Text = "Speed: "..(speed and "ON" or "OFF")
    applySpeed()
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    applySpeed()
end)

-- =========================
-- 🦘 JUMP x3
-- =========================
local jump = false
local function applyJump()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = jump and 150 or 50 end
end

btn("Jump x3: OFF", function(b)
    jump = not jump
    b.Text = "Jump x3: "..(jump and "ON" or "OFF")
    applyJump()
end)

-- =========================
-- ✈️ FLY
-- =========================
local fly = false
btn("Fly: OFF", function(b)
    fly = not fly
    b.Text = "Fly: "..(fly and "ON" or "OFF")

    task.spawn(function()
        while fly do
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Velocity = Vector3.new(0,20,0) end
            task.wait(0.1)
        end
    end)
end)

-- =========================
-- 🧱 NOCLIP
-- =========================
local noclip = false
btn("NoClip: OFF", function(b)
    noclip = not noclip
    b.Text = "NoClip: "..(noclip and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
    if noclip then
        local char = player.Character
        if char then
            for _,v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- =========================
-- 👁️ ESP PLAYER
-- =========================
btn("ESP Player", function()
    for _,p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and not p.Character:FindFirstChild("ESP") then
            local hl = Instance.new("Highlight", p.Character)
            hl.Name = "ESP"
            hl.FillColor = Color3.fromRGB(255,0,0)
        end
    end
end)

-- =========================
-- 👹 ESP NPC
-- =========================
btn("ESP NPC", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
            if not v:FindFirstChild("NPC") then
                local hl = Instance.new("Highlight", v)
                hl.Name = "NPC"
                hl.FillColor = Color3.fromRGB(255,100,0)
            end
        end
    end
end)

-- =========================
-- ⚔️ KILL AURA
-- =========================
local aura = false
btn("Kill Aura: OFF", function(b)
    aura = not aura
    b.Text = "Kill Aura: "..(aura and "ON" or "OFF")

    task.spawn(function()
        while aura do
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

            if root then
                for _,v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Model")
                    and v:FindFirstChildOfClass("Humanoid")
                    and not game.Players:GetPlayerFromCharacter(v) then

                        local hrp = v:FindFirstChild("HumanoidRootPart")
                        local hum = v:FindFirstChildOfClass("Humanoid")

                        if hrp and hum and hum.Health > 0 then
                            if (hrp.Position - root.Position).Magnitude <= 20 then
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

-- =========================
-- 🤖 AUTO FARM PRO
-- =========================
local autofarm = false
btn("Auto Farm PRO: OFF", function(b)
    autofarm = not autofarm
    b.Text = "Auto Farm PRO: "..(autofarm and "ON" or "OFF")

    task.spawn(function()
        while autofarm do
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

            if root then
                local closest, dist = nil, math.huge

                for _,v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Model")
                    and v:FindFirstChildOfClass("Humanoid")
                    and not game.Players:GetPlayerFromCharacter(v) then

                        local hrp = v:FindFirstChild("HumanoidRootPart")
                        local hum = v:FindFirstChildOfClass("Humanoid")

                        if hrp and hum and hum.Health > 0 then
                            local d = (hrp.Position - root.Position).Magnitude
                            if d < dist then
                                dist = d
                                closest = v
                            end
                        end
                    end
                end

                if closest then
                    local hrp = closest:FindFirstChild("HumanoidRootPart")
                    local hum = closest:FindFirstChildOfClass("Humanoid")

                    if hrp and hum then
                        root.CFrame = root.CFrame:Lerp(hrp.CFrame * CFrame.new(0,0,5), 0.2)
                        hum:TakeDamage(5)
                    end
                end
            end

            task.wait(0.3)
        end
    end)
end)

-- =========================
-- 🧹 FIX LAG
-- =========================
btn("Fix Lag", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        end
        if v:IsA("Decal") then
            v:Destroy()
        end
    end
end)
