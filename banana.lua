-- 🍌 Banana FULL HUB (Final Version)

-- ===== GLOBAL CONTROL =====
getgenv().AutoFarm = false
getgenv().AutoAttack = false

-- ===== UI =====
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BananaFinal"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 650, 0, 400)
Main.Position = UDim2.new(0.5, -325, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active = true
Main.Draggable = true

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0,160,1,0)
Side.BackgroundColor3 = Color3.fromRGB(28,28,28)

local Title = Instance.new("TextLabel", Side)
Title.Size = UDim2.new(1,0,0,50)
Title.Text = "🍌 Banana Hub"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1

local Tabs = {"Farm","Combat","Player","Misc"}
local Pages = {}

for i,v in pairs(Tabs) do
    local Btn = Instance.new("TextButton", Side)
    Btn.Size = UDim2.new(1,0,0,40)
    Btn.Position = UDim2.new(0,0,0,50+(i-1)*40)
    Btn.Text = v
    Btn.BackgroundColor3 = Color3.fromRGB(35,35,35)

    local Page = Instance.new("Frame", Main)
    Page.Size = UDim2.new(1,-160,1,0)
    Page.Position = UDim2.new(0,160,0,0)
    Page.Visible = false
    Page.BackgroundColor3 = Color3.fromRGB(22,22,22)

    Pages[v] = Page

    Btn.MouseButton1Click:Connect(function()
        for _,p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
    end)
end

Pages["Farm"].Visible = true

-- ===== UI HELPER =====
local function CreateToggle(parent, text, y, callback)
    local state = false

    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(0,200,0,40)
    Btn.Position = UDim2.new(0,20,0,y)
    Btn.Text = text.." [OFF]"
    Btn.BackgroundColor3 = Color3.fromRGB(45,45,45)

    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = text.." ["..(state and "ON" or "OFF").."]"
        callback(state)
    end)
end

-- ===== TOGGLES =====
CreateToggle(Pages["Farm"], "Auto Farm", 20, function(state)
    getgenv().AutoFarm = state
end)

CreateToggle(Pages["Combat"], "Auto Attack", 80, function(state)
    getgenv().AutoAttack = state
end)

-- ===== LOAD YOUR SCRIPT =====
task.spawn(function()
    repeat task.wait() until game:IsLoaded()

    -- load script gốc của bạn
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lyquyenanh21-glitch/Anh/refs/heads/main/anh.vip.pro.fruits-Kaitun.flix-lag.lua"))()
    end)

    if not success then
        warn("Script lỗi:", err)
    end
end)

print("🍌 Banana FINAL Loaded")