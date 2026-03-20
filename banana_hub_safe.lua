-- BANANA STYLE SAFE HUB

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

getgenv().AutoClick = false
getgenv().AutoSkill = false
getgenv().AimMob = false
getgenv().AutoQuest = false

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,480)
main.Position = UDim2.new(0.05,0,0.2,0)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)

-- Tabs
local tabs = Instance.new("Frame", main)
tabs.Size = UDim2.new(1,0,0,40)

local pages = {}

function createPage(name)
    local page = Instance.new("Frame", main)
    page.Size = UDim2.new(1,0,1,-40)
    page.Position = UDim2.new(0,0,0,40)
    page.Visible = false

    local layout = Instance.new("UIListLayout", page)
    pages[name] = page

    local btn = Instance.new("TextButton", tabs)
    btn.Size = UDim2.new(0,120,1,0)
    btn.Text = name

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)

    return page
end

function toggle(parent, text, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-10,0,40)
    b.Text = text.." : OFF"

    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = text.." : "..(state and "ON" or "OFF")
        callback(state)
    end)
end

-- Pages
local farm = createPage("Farm")
local combat = createPage("Combat")
local visual = createPage("Visual")

farm.Visible = true

-- AUTO CLICK
toggle(farm, "Auto Click", function(v)
    getgenv().AutoClick = v
end)

-- AUTO SKILL
toggle(farm, "Auto Skill", function(v)
    getgenv().AutoSkill = v
end)

-- AIM MOB
toggle(combat, "Aim Mob", function(v)
    getgenv().AimMob = v
end)

-- AUTO QUEST
toggle(farm, "Auto Quest Helper", function(v)
    getgenv().AutoQuest = v
end)

function getNearestMob()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local nearest, dist = nil, math.huge

    for _,v in pairs(workspace:GetDescendants()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if v.Humanoid.Health > 0 then
                local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end
    end
    return nearest
end

local highlight = Instance.new("Highlight")
highlight.FillColor = Color3.fromRGB(255,0,0)

spawn(function()
    while task.wait(math.random(5,10)/10) do

        if getgenv().AutoClick then
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
            game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
        end

        if getgenv().AutoSkill then
            local keys = {"Z","X","C"}
            local key = keys[math.random(1,#keys)]

            game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
            task.wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
        end

        if getgenv().AimMob then
            local mob = getNearestMob()
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                highlight.Parent = mob

                char.HumanoidRootPart.CFrame =
                    CFrame.new(char.HumanoidRootPart.Position, mob.HumanoidRootPart.Position)
            end
        else
            highlight.Parent = nil
        end

        if getgenv().AutoQuest then
            if player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") then
                local level = player.Data.Level.Value

                if level < 50 then
                    print("Farm Bandit")
                elseif level < 100 then
                    print("Farm Monkey")
                else
                    print("Farm Boss")
                end
            end
        end

    end
end)
