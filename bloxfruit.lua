local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0.3, 0, 0.6, 0)
mainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true
mainFrame.Active = true

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Text = "Blox Fruits Ultimate Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 150, 136)
titleLabel.TextScaled = true

local delay = 0.1

function createButton(name, position, callback)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0.8, 0, 0.1, 0)
    btn.Position = position
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(255, 69, 58)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = btn.BackgroundColor3 == Color3.fromRGB(0, 255, 0) and Color3.fromRGB(255, 69, 58) or Color3.fromRGB(0, 255, 0)
        callback(btn.BackgroundColor3 == Color3.fromRGB(0, 255, 0))
    end)
end

local function tpMobs()
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") then
            v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
        end
    end
end

local function autoFarmLevel(active)
    local player = game.Players.LocalPlayer
    while active do
        tpMobs()
        local level = player.leaderstats.Level.Value
        if level >= 700 and level < 1500 then
            for _, quest in pairs(game.Workspace.Quests:GetChildren()) do
                if quest:FindFirstChild("QuestPart") then
                    player.Character.HumanoidRootPart.CFrame = quest.QuestPart.CFrame
                    wait(2)
                    fireproximityprompt(quest.QuestPart.ProximityPrompt)
                end
            end
        elseif level >= 1500 and level < 1800 then
            for _, quest in pairs(game.Workspace.Quests:GetChildren()) do
                if quest:FindFirstChild("QuestPart") then
                    player.Character.HumanoidRootPart.CFrame = quest.QuestPart.CFrame
                    wait(2)
                    fireproximityprompt(quest.QuestPart.ProximityPrompt)
                end
            end
            local pirateTeamLocation = game.Workspace:FindFirstChild("PirateTeamLocation")
            if pirateTeamLocation then
                player.Character.HumanoidRootPart.CFrame = pirateTeamLocation.CFrame
            end
        elseif level >= 1800 then
            local raceIsland = game.Workspace:FindFirstChild("RaceIsland")
            if raceIsland then
                player.Character.HumanoidRootPart.CFrame = raceIsland.CFrame
                wait(2)
                for _, quest in pairs(game.Workspace.RaceQuests:GetChildren()) do
                    if quest:FindFirstChild("QuestPart") then
                        player.Character.HumanoidRootPart.CFrame = quest.QuestPart.CFrame
                        wait(2)
                        fireproximityprompt(quest.QuestPart.ProximityPrompt)
                    end
                end
            end
        end
        
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
                wait(delay)
                game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0))
            end
        end
    end
end

local function autoCompleteQuests()
    for _, quest in pairs(game:GetService("Workspace").Quests:GetChildren()) do
        if quest:FindFirstChild("QuestPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = quest.QuestPart.CFrame
            wait(2)
            fireproximityprompt(quest.QuestPart.ProximityPrompt)
        end
    end
end

local function autoBossFight(active)
    while active do
        for _, boss in pairs(game.Workspace.Bosses:GetChildren()) do
            if boss:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame
                while boss.Humanoid.Health > 0 and active do
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0))
                    wait(delay)
                    game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0))
                end
            end
        end
        wait(1)
    end
end

local function collectAllSwords()
    local swords = {"Sword1", "Sword2", "Sword3"}
    for _, swordName in pairs(swords) do
        local sword = game.Workspace:FindFirstChild(swordName)
        if sword then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sword.CFrame
            wait(1)
            fireproximityprompt(sword.ProximityPrompt)
        end
    end
end

local function detectIslands()
    local islands = {}
    for _, part in pairs(game.Workspace:GetChildren()) do
        if part:IsA("Model") and part:FindFirstChild("IslandPart") then
            table.insert(islands, part.Name)
        end
    end
    return islands
end

local function createIslandSelection()
    local islandList = detectIslands()
    local islandFrame = Instance.new("Frame", mainFrame)
    islandFrame.Size = UDim2.new(1, 0, 0.8, 0)
    islandFrame.Position = UDim2.new(0, 0, 0.1, 0)
    islandFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    islandFrame.Visible = false

    local function addButton(islandName)
        local btn = Instance.new("TextButton", islandFrame)
        btn.Size = UDim2.new(1, 0, 0.1, 0)
        btn.Text = islandName
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 136)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.TextScaled = true
        btn.MouseButton1Click:Connect(function()
            teleportToIsland(islandName)
        end)
    end

    for _, islandName in pairs(islandList) do
        addButton(islandName)
    end

    return islandFrame
end

local function teleportToIsland(islandName)
    local island = game.Workspace:FindFirstChild(islandName)
    if island then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = island.CFrame
    end
end

local delayInput = Instance.new("TextBox", mainFrame)
delayInput.Size = UDim2.new(0.8, 0, 0.1, 0)
delayInput.Position = UDim2.new(0.1, 0, 0.75, 0)
delayInput.Text = tostring(delay)
delayInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
delayInput.TextColor3 = Color3.fromRGB(0, 0, 0)
delayInput.TextScaled = true

local applyButton = Instance.new("TextButton", mainFrame)
applyButton.Size = UDim2.new(0.8, 0, 0.1, 0)
applyButton.Position = UDim2.new(0.1, 0, 0.9, 0)
applyButton.Text = "Apply Delay"
applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 136)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextScaled = true

applyButton.MouseButton1Click:Connect(function()
    local newDelay = tonumber(delayInput.Text)
    if newDelay and newDelay > 0 then
        delay = newDelay
    end
end)

local islandSelectionButton = Instance.new("TextButton", mainFrame)
islandSelectionButton.Size = UDim2.new(0.8, 0, 0.1, 0)
islandSelectionButton.Position = UDim2.new(0.1, 0, 0.2, 0)
islandSelectionButton.Text = "Select Island"
islandSelectionButton.BackgroundColor3 = Color3.fromRGB(0, 150, 136)
islandSelectionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
islandSelectionButton.TextScaled = true

local islandFrame = createIslandSelection()

islandSelectionButton.MouseButton1Click:Connect(function()
    islandFrame.Visible = not islandFrame.Visible
end)

createButton("Auto Farm", UDim2.new(0.1, 0, 0.3, 0), function(active)
    autoFarmLevel(active)
end)

createButton("Complete Quests", UDim2.new(0.1, 0, 0.4, 0), function(active)
    autoCompleteQuests()
end)

createButton("Farm Bosses", UDim2.new(0.1, 0, 0.5, 0), function(active)
    autoBossFight(active)
end)

createButton("Collect Swords", UDim2.new(0.1, 0, 0.6, 0), function(active)
    collectAllSwords()
end)

mainFrame.Visible = true