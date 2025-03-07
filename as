local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer

Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    print("Anti-AFK: Prevented kick")
end)

local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, - 9.5, -2)
local numberOfParts = math.ceil(totalDistance / partSize)
local function createParts()
for x = 0, numberOfParts - 1 do
for z = 0, numberOfParts - 1 do
    local newPartSide = Instance.new("Part")
    newPartSide.Size = Vector3.new(partSize, 1, partSize)
    newPartSide.Position = startPosition + Vector3.new(x * partSize, 0, z * partSize)
    newPartSide.Anchored = true
    newPartSide.Transparency = 1
    newPartSide.CanCollide = true
    newPartSide.Name = "Part_Side_" .. x .. "_" .. z
    newPartSide.Parent = workspace
    table.insert(parts, newPartSide)
    local newPartLeftRight = Instance.new("Part")
    newPartLeftRight.Size = Vector3.new(partSize, 1, partSize)
    newPartLeftRight.Position = startPosition + Vector3.new(- x * partSize, 0, z * partSize)
    newPartLeftRight.Anchored = true
    newPartLeftRight.Transparency = 1
    newPartLeftRight.CanCollide = true
    newPartLeftRight.Name = "Part_LeftRight_" .. x .. "_" .. z
    newPartLeftRight.Parent = workspace
    table.insert(parts, newPartLeftRight)
    local newPartUpLeft = Instance.new("Part")
    newPartUpLeft.Size = Vector3.new(partSize, 1, partSize)
    newPartUpLeft.Position = startPosition + Vector3.new(- x * partSize, 0, - z * partSize)
    newPartUpLeft.Anchored = true
    newPartUpLeft.Transparency = 1
    newPartUpLeft.CanCollide = true
    newPartUpLeft.Name = "Part_UpLeft_" .. x .. "_" .. z
    newPartUpLeft.Parent = workspace
    table.insert(parts, newPartUpLeft)
    local newPartUpRight = Instance.new("Part")
    newPartUpRight.Size = Vector3.new(partSize, 1, partSize)
    newPartUpRight.Position = startPosition + Vector3.new(x * partSize, 0, - z * partSize)
    newPartUpRight.Anchored = true
    newPartUpRight.Transparency = 1
    newPartUpRight.CanCollide = true
    newPartUpRight.Name = "Part_UpRight_" .. x .. "_" .. z
    newPartUpRight.Parent = workspace
    table.insert(parts, newPartUpRight)
end
end
end

local function makePartsWalkthrough()
for _, part in ipairs(parts) do
if part and part.Parent then
    part.CanCollide = false
end
end
end

local function makePartsSolid()
for _, part in ipairs(parts) do
if part and part.Parent then
    part.CanCollide = true
end
end
end

local Library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/TryharderKid/Ui-SOon/refs/heads/main/DownloadIG"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/TryharderKid/Ui-SOon/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/TryharderKid/Ui-SOon/master/Addons/InterfaceManager.luau"))()

local Window = Library:CreateWindow{
Title = `Pxrson Private Script`,
SubTitle = "Dawg got the best Script",
TabWidth = 160,
Size = UDim2.fromOffset(830, 525),
Resize = true,
MinSize = Vector2.new(470, 380),
Acrylic = true,
Theme = "Havoc Color",
MinimizeKey = Enum.KeyCode.RightControl
}

local Tabs = {
Home = Window:CreateTab{
Title = "Home",
Icon = "scan-face"
},
Main = Window:CreateTab{
Title = "Main",
Icon = "map"
},
Rebirths = Window:CreateTab{
Title = "Rebirths",
Icon = "refresh-ccw"
},
Killer = Window:CreateTab{
Title = "Killer",
Icon = "skull"
},
Crystal = Window:CreateTab{
Title = "Crystal",
Icon = "gem"
},
Status = Window:CreateTab{
Title = "Status",
Icon = "circle-plus"
},
Miscellaneous = Window:CreateTab{
Title = "Miscellaneous",
Icon = "grid-2x2"
},
Settings = Window:CreateTab{
Title = "Settings",
Icon = "settings"
}
}

local Options = Library.Options

local MainSection = Tabs.Home:CreateSection("LocalPlayer")

local Input = Tabs.Home:CreateInput("WalkSpeed", {
Title = "Set WalkSpeed",
Default = "16",
Placeholder = "Enter Speed Value",
Numeric = true,
Finished = true,
Callback = function(Value)
selectedSpeed = Value
if _G.AutoSpeed then
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(selectedSpeed)
    end
end
end
})

local Toggle = Tabs.Home:CreateToggle("AutoSpeed", {
Title = "Enable WalkSpeed",
Description = "",
Default = false,
Callback = function(Value)
_G.AutoSpeed = Value
while _G.AutoSpeed do
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(selectedSpeed)
    end
    task.wait()
end
end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
if Toggle:GetState() then
char:WaitForChild("Humanoid").WalkSpeed = tonumber(Input:GetValue())
end
end)

local Toggle = Tabs.Home:CreateToggle("InfiniteJump", {
Title = "Infinite Jump",
Description = "Jump Infinite",
Default = false,
Callback = function(Value)
_G.InfiniteJump = Value
local Player = game:GetService('Players').LocalPlayer
local UserInputService = game:GetService('UserInputService')
UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        Player.Character:FindFirstChildOfClass('Humanoid'):ChangeState('Jumping')
    end
end)
end
})

local MainSection = Tabs.Home:CreateSection("Size")

local Input = Tabs.Home:CreateInput("SizeAmount", {
Title = "Size Amount",
Default = "2",
Placeholder = "Type here...",
Numeric = true,
Finished = true,
Callback = function(Value)
selectedSize = Value
if _G.AutoSize then
    game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
end
end
})

local Toggle = Tabs.Home:CreateToggle("AutoSize", {
Title = "Auto Set Size",
Description = "",
Default = false,
Callback = function(Value)
_G.AutoSize = Value
while _G.AutoSize do
    game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
    task.wait(0.1)
end
end
})

local MainSection = Tabs.Main:CreateSection("Farming Gym")

local function pressE()
local vim = game:GetService("VirtualInputManager")
vim:SendKeyEvent(true, "E", false, game)
task.wait(0.1)
vim:SendKeyEvent(false, "E", false, game)
end

local function autoLift()
while getgenv().working and task.wait() do
game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end
end

local function teleportAndStart(machineName, position)
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
task.wait(0.5)
pressE()
autoLift()
end
end

local locations = {
["Starter Island"] = true,
["Legend Beach"] = true,
["Frost Gym"] = true,
["Mythical Gym"] = true,
["Eternal Gym"] = true,
["Legend Gym"] = true,
["Muscle King Gym"] = true,
["Jungle Gym"] = true
}

local locationsList = {
"Starter Island",
"Legend Beach",
"Frost Gym",
"Mythical Gym",
"Eternal Gym",
"Legend Gym",
"Muscle King Gym",
"Jungle Gym"
}

local workoutPositions = {
["Bench Press"] = {
["Starter Island"] = CFrame.new(- 17.0609932, 3.31417918, - 2.48164988),
["Legend Beach"] = CFrame.new(470.334656, 3.31417966, - 321.053925),
["Frost Gym"] = CFrame.new(- 3013.24194, 39.2158546, - 335.036926),
["Mythical Gym"] = CFrame.new(2371.7356, 39.2158546, 1246.31555),
["Eternal Gym"] = CFrame.new(- 7176.19141, 45.394104, - 1106.31421),
["Legend Gym"] = CFrame.new(4111.91748, 1020.46674, - 3799.97217),
["Muscle King Gym"] = CFrame.new(- 8590.06152, 46.0167427, - 6043.34717),
["Jungle Gym"] = CFrame.new(-8173, 64, 1898)
},
["Squat"] = {
["Starter Island"] = CFrame.new(- 48.8711243, 3.31417918, - 11.8831778),
["Legend Beach"] = CFrame.new(470.334656, 3.31417966, - 321.053925),
["Frost Gym"] = CFrame.new(- 2933.47998, 29.6399612, - 579.946045),
["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
["Eternal Gym"] = CFrame.new(- 7176.19141, 45.394104, - 1106.31421),
["Legend Gym"] = CFrame.new(4304.99023, 987.829956, - 4124.2334),
["Muscle King Gym"] = CFrame.new(- 8940.12402, 13.1642084, - 5699.13477),
["Jungle Gym"] = CFrame.new(-8352, 34, 2878)
},
["Deadlift"] = {
["Starter Island"] = CFrame.new(- 48.8711243, 3.31417918, - 11.8831778),
["Legend Beach"] = CFrame.new(470.334656, 3.31417966, - 321.053925),
["Frost Gym"] = CFrame.new(- 2933.47998, 29.6399612, - 579.946045),
["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
["Eternal Gym"] = CFrame.new(- 7176.19141, 45.394104, - 1106.31421),
["Legend Gym"] = CFrame.new(4304.99023, 987.829956, - 4124.2334),
["Muscle King Gym"] = CFrame.new(- 8940.12402, 13.1642084, - 5699.13477)
},
["Pull Up"] = {
["Starter Island"] = CFrame.new(- 33.3047485, 3.31417918, - 11.8831778),
["Legend Beach"] = CFrame.new(470.334656, 3.31417966, - 321.053925),
["Frost Gym"] = CFrame.new(- 2933.47998, 29.6399612, - 579.946045),
["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
["Eternal Gym"] = CFrame.new(- 7176.19141, 45.394104, - 1106.31421),
["Legend Gym"] = CFrame.new(4304.99023, 987.829956, - 4124.2334),
["Muscle King Gym"] = CFrame.new(- 8940.12402, 13.1642084, - 5699.13477),
["Jungle Gym"] = CFrame.new(-8666, 34, 2070)
},
["Boulder"] = {
["Starter Island"] = CFrame.new(- 33.3047485, 3.31417918, - 11.8831778),
["Legend Beach"] = CFrame.new(470.334656, 3.31417966, - 321.053925),
["Frost Gym"] = CFrame.new(- 2933.47998, 29.6399612, - 579.946045),
["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
["Eternal Gym"] = CFrame.new(- 7176.19141, 45.394104, - 1106.31421),
["Legend Gym"] = CFrame.new(4304.99023, 987.829956, - 4124.2334),
["Muscle King Gym"] = CFrame.new(- 8940.12402, 13.1642084, - 5699.13477),
["Jungle Gym"] = CFrame.new(-8621, 34, 2684)
}
}

local workoutTypes = {
"Bench Press",
"Squat",
"Deadlift",
"Pull Up",
"Boulder"
}
for _, workoutType in ipairs(workoutTypes) do
local dropdown = Tabs.Main:CreateDropdown(workoutType .. " dropdown", {
Title = "Select " .. workoutType,
Description = "Choose Your Training Location",
Values = locationsList,
Multi = false,
Default = 1,
Callback = function(Value)
    _G["select" .. string.lower(string.gsub(workoutType, " ", ""))] = Value
end
})
local toggle = Tabs.Main:CreateToggle(workoutType .. " Toggle", {
Title = "Farm " .. workoutType,
Description = "Auto Trains " .. workoutType,
Default = false,
Callback = function(Value)
    getgenv().working = Value
    if Value then
        local selected = _G["select" .. string.lower(string.gsub(workoutType, " ", ""))]
        if workoutPositions[workoutType][selected] then
            teleportAndStart(workoutType, workoutPositions[workoutType][selected])
        end
    end
end
})
end

local MainSection = Tabs.Main:CreateSection("Farming General")

local Toggle = Tabs.Main:CreateToggle("Weight", {
Title = "Auto Weight",
Default = false,
Callback = function(Value)
_G.AutoWeight = Value
if Value then
    local weightTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
    if weightTool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(weightTool)
    end
else
    local equipped = game.Players.LocalPlayer.Character:FindFirstChild("Weight")
    if equipped then
        equipped.Parent = game.Players.LocalPlayer.Backpack
    end
end

while _G.AutoWeight do
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
    task.wait()
end
end
})

local Toggle = Tabs.Main:CreateToggle("Pushups", {
Title = "Auto Pushups",
Default = false,
Callback = function(Value)
_G.AutoPushups = Value
if Value then
    local pushupsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
    if pushupsTool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(pushupsTool)
    end
else
    local equipped = game.Players.LocalPlayer.Character:FindFirstChild("Pushups")
    if equipped then
        equipped.Parent = game.Players.LocalPlayer.Backpack
    end
end

while _G.AutoPushups do
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
    task.wait()
end
end
})

local Toggle = Tabs.Main:CreateToggle("Situps", {
Title = "Auto Situps",
Default = false,
Callback = function(Value)
_G.AutoSitups = Value
if Value then
    local situpsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Situps")
    if situpsTool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(situpsTool)
    end
else
    local equipped = game.Players.LocalPlayer.Character:FindFirstChild("Situps")
    if equipped then
        equipped.Parent = game.Players.LocalPlayer.Backpack
    end
end

while _G.AutoSitups do
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
    task.wait()
end
end
})

local Toggle = Tabs.Main:CreateToggle("Punch", {
Title = "Auto Punch",
Default = false,
Callback = function(Value)
_G.fastHitActive = Value
if Value then
    local function equipAndModifyPunch()
        while _G.fastHitActive do
            local punch = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
            if punch then
                punch.Parent = game.Players.LocalPlayer.Character
                if punch:FindFirstChild("attackTime") then
                    punch.attackTime.Value = 0
                end
            end
            task.wait()
        end
    end

    local function rapidPunch()
        while _G.fastHitActive do
            game.Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
            game.Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
            if game.Players.LocalPlayer.Character:FindFirstChild("Punch") then
                game.Players.LocalPlayer.Character.Punch:Activate()
            end
            task.wait()
        end
    end

    task.spawn(equipAndModifyPunch)
    task.spawn(rapidPunch)
else
    local equipped = game.Players.LocalPlayer.Character:FindFirstChild("Punch")
    if equipped then
        equipped.Parent = game.Players.LocalPlayer.Backpack
    end
end
end
})

local MainSection = Tabs.Main:CreateSection("Misc")

local autoGiftsToggle = Tabs.Main:AddToggle("AutoGifts", {
Title = "",
Default = false,
Callback = function(v)
while v do
    for i = 1, 8 do
        game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
    end
    task.wait(1)
end
end
})

local Toggle = Tabs.Main:CreateToggle("ToggleName", {
Title = "Lock Pos",
Description = "",
Default = false,
Callback = function(Value)
if Value then
    local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
        end
    end)
else
    if getgenv().posLock then
        getgenv().posLock:Disconnect()
    end
end
end
})

Tabs.Main:CreateToggle("AntiKnockback", {
Title = "Anti-KnockBack",
Description = "",
Default = false,
Callback = function(Value)
if Value then
    local playerName = game.Players.LocalPlayer.Name
    local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
    local bodyVelocity = Instance.new("BodyVelocity")
    
    bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.P = 1250
    bodyVelocity.Parent = rootPart
else
    local playerName = game.Players.LocalPlayer.Name
    local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
    local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
    
    if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
        existingVelocity:Destroy()
    end
end
end
})

local Toggle = Tabs.Main:CreateToggle("WalkOnWater", {
Title = "Walk on Water",
Description = "",
Default = false,
Callback = function(Value)
if Value then
    createParts()
else
    makePartsWalkthrough()
end
end
})

Tabs.Main:CreateParagraph("Tools Changer", {
Title = "- [ Faster Tool ] -",
Content = "",
TitleAlignment = "Middle",
ContentAlignment = Enum.TextXAlignment.Center
})

local Toggle = Tabs.Main:CreateToggle("ToolSpeed", {
Title = "Fast Tools",
Description = "Fast Tools..., What u didn't get.",
Default = false,
Callback = function(Value)
_G.FastTools = Value
local defaultSpeeds = {
    {
        "Punch",
        "attackTime",
        Value and 0 or 0.35
    },
    {
        "Ground Slam",
        "attackTime",
        Value and 0 or 6
    },
    {
        "Stomp",
        "attackTime",
        Value and 0 or 7
    },
    {
        "Handstands",
        "repTime",
        Value and 0 or 1
    },
    {
        "Pushups",
        "repTime",
        Value and 0 or 1
    },
    {
        "Weight",
        "repTime",
        Value and 0 or 1
    },
    {
        "Situps",
        "repTime",
        Value and 0 or 1
    }
}
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
for _, toolInfo in ipairs(defaultSpeeds) do
    local tool = backpack:FindFirstChild(toolInfo[1])
    if tool and tool:FindFirstChild(toolInfo[2]) then
        tool[toolInfo[2]].Value = toolInfo[3]
    end
    local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
    if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
        equippedTool[toolInfo[2]].Value = toolInfo[3]
    end
end
end
})

local selectrock = ""
local Toggle = Tabs.Main:CreateToggle("TinyIslandRock", {
	Title = "Farm Tiny Island Rock",
	Description = "Farm rocks at Tiny Island",
	Default = false,
	Callback = function(Value)
		selectrock = "Tiny Island Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 0 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("StarterIslandRock", {
	Title = "Farm Starter Island Rock",
	Description = "Farm rocks at Starter Island",
	Default = false,
	Callback = function(Value)
		selectrock = "Starter Island Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 100 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 100 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("LegendBeachRock", {
	Title = "Farm Legend Beach Rock",
	Description = "Farm rocks at Legend Beach",
	Default = false,
	Callback = function(Value)
		selectrock = "Legend Beach Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 5000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 5000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

function gettool()
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local Toggle = Tabs.Main:CreateToggle("FrostGymRock", {
	Title = "Farm Frost Gym Rock",
	Description = "Farm rocks at Frost Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Frost Gym Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 150000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 150000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("MythicalGymRock", {
	Title = "Farm Mythical Gym Rock",
	Description = "Farm rocks at Mythical Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Mythical Gym Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 400000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 400000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("EternalGymRock", {
	Title = "Farm Eternal Gym Rock",
	Description = "Farm rocks at Eternal Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Eternal Gym Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 750000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 750000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("LegendGymRock", {
	Title = "Farm Legend Gym Rock",
	Description = "Farm rocks at Legend Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Legend Gym Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 1000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("MuscleKingGymRock", {
	Title = "Farm Muscle King Gym Rock",
	Description = "Farm rocks at Muscle King Gym",
	Default = false,
	Callback = function(Value)
		selectrock = "Muscle King Gym Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 5000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Toggle = Tabs.Main:CreateToggle("AncientJungleRock", {
	Title = "Farm Ancient Jungle Rock",
	Description = "Farm rocks at Ancient Jungle",
	Default = false,
	Callback = function(Value)
		selectrock = "Ancient Jungle Rock"
		getgenv().Main = Value
		while getgenv().Main do
			task.wait()
			if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
				for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
					if v.Name == "neededDurability" and v.Value == 10000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
						firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
						gettool()
					end
				end
			end
		end
	end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local rebirthEvent = ReplicatedStorage.rEvents.rebirthRemote
local rebirthStat = LocalPlayer.leaderstats.Rebirths

local Section = Tabs.Rebirths:CreateSection("Auto Rebirth")

local targetRebirthValue = 1
local initialRebirths = rebirthStat.Value
local startTime = tick()

local function formatNumber(num)
    if num >= 1e15 then
        return string.format("%.1fQI", num/1e15)
    elseif num >= 1e12 then
        return string.format("%.1fQ", num/1e12)
    elseif num >= 1e6 then
        return string.format("%.1fM", num/1e6)
    elseif num >= 1e3 then
        return string.format("%.1fK", num/1e3)
    else
        return tostring(num)
    end
end

local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    local ms = math.floor((tick() % 1) * 1000)
    
    return string.format("%d Days %d Hours %d Minutes %d Seconds %d MS", 
        days, hours, minutes, secs, ms)
end

local StatDisplay = Tabs.Rebirths:CreateParagraph("RebirthStats", {
    Title = "Rebirth Statistics",
    Content = "Loading stats...",
    TitleAlignment = "Left",
    ContentAlignment = Enum.TextXAlignment.Left
})

local function updateRebirthStats()
    local currentRebirths = rebirthStat.Value
    local gained = currentRebirths - initialRebirths
    local elapsedTime = tick() - startTime
    
    local statsFormat = [[
Target Rebirths: %s | %s
Current Rebirths: %s | %s
Rebirths Gained: %s | %s
Timer: %s]]

    StatDisplay:SetContent(string.format(
        statsFormat,
        tostring(targetRebirthValue):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""),
        formatNumber(targetRebirthValue),
        tostring(currentRebirths):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""),
        formatNumber(currentRebirths),
        tostring(gained):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""),
        formatNumber(gained),
        formatTime(elapsedTime)
    ))
end

RunService.RenderStepped:Connect(updateRebirthStats)
rebirthStat.Changed:Connect(updateRebirthStats)

local function parseNumber(input)
    local cleanInput = input:gsub("[^%d.]", "")
    return tonumber(cleanInput) or 1
end

local targetInput = Tabs.Rebirths:CreateInput("TargetRebirth", {
    Title = "Target Rebirth Amount",
    Description = "Set your rebirth goal (Accepts: 19000 or 19,000)",
    Default = "1",
    Placeholder = "Enter amount...",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        local parsedValue = parseNumber(Value)
        local currentRebirths = LocalPlayer.leaderstats.Rebirths.Value
        
        if parsedValue <= currentRebirths then
            Library:Notify("Target Value Invalid", "Enter a Higher Rebirth Value")
            return
        end
        
        targetRebirthValue = parsedValue
        updateRebirthStats()
    end
})

local function getRebirthCost()
    local currentRebirths = LocalPlayer.leaderstats.Rebirths.Value
    local rebirthCost = 10000 + (5000 * currentRebirths)
    
    if LocalPlayer.ultimatesFolder:FindFirstChild("Golden Rebirth") then
        local goldenRebirths = LocalPlayer.ultimatesFolder["Golden Rebirth"].Value
        rebirthCost = math.floor(rebirthCost * (1 - (goldenRebirths * 0.1)))
    end
    
    return rebirthCost
end

local targetRebirthLoop
local targetToggle = Tabs.Rebirths:CreateToggle("AutoRebirthTarget", {
    Title = "Rebirth Farm 1",
    Description = "Auto Rebirth To Target",
    Default = false,
    Callback = function(Value)
        if Value then
            targetRebirthLoop = task.spawn(function()
                while task.wait(0.1) do
                    if LocalPlayer.leaderstats.Rebirths.Value >= targetRebirthValue then
                        targetToggle:SetValue(false)
                        break
                    end
                    
                    if LocalPlayer.leaderstats.Strength.Value >= getRebirthCost() then
                        rebirthEvent:InvokeServer("rebirthRequest")
                    end
                end
            end)
        else
            if targetRebirthLoop then
                task.cancel(targetRebirthLoop)
                targetRebirthLoop = nil
            end
        end
    end
})

local infiniteRebirthLoop
local infiniteToggle = Tabs.Rebirths:CreateToggle("AutoRebirthInfinite", {
    Title = "Auto Rebirth (Infinite)",
    Description = "Continuously rebirth without stopping",
    Default = false,
    Callback = function(Value)
        if Value then
            infiniteRebirthLoop = task.spawn(function()
                while task.wait(0.1) do
                    if LocalPlayer.leaderstats.Strength.Value >= getRebirthCost() then
                        rebirthEvent:InvokeServer("rebirthRequest")
                    end
                end
            end)
        else
            if infiniteRebirthLoop then
                task.cancel(infiniteRebirthLoop)
                infiniteRebirthLoop = nil
            end
        end
    end
})

local MainSection = Tabs.Rebirths:CreateSection("Misc Rebirths")

local Toggle = Tabs.Rebirths:CreateToggle("Anti-TeleportRebirth", {
    Title = "Anti-Teleport If Rebirthed",
    Description = "",
    Default = false,
    Callback = function(Value)
        if Value then
            local lastPosition = nil
            
            -- Method 1: Position Save & Restore
            local function savePosition()
                if game.Players.LocalPlayer.Character and 
                   game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    lastPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            
            local function restorePosition()
                if lastPosition and 
                   game.Players.LocalPlayer.Character and 
                   game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastPosition
                end
            end
            
            -- Method 2: Spawn Location Override
            if game.Players.LocalPlayer.Character then
                local spawnPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                game.Players.LocalPlayer.RespawnLocation = spawnPos
            end
            
            -- Method 3: Teleport Event Blocking
            for _, v in pairs(getconnections(game.Players.LocalPlayer.Character.Humanoid.Died)) do
                v:Disable()
            end
            
            -- Method 4: Character State Tracking
            game.Players.LocalPlayer.CharacterRemoving:Connect(savePosition)
            
            -- Method 5: Multi-Phase Position Restore
            game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
                char:WaitForChild("HumanoidRootPart")
                task.wait(0.1)
                restorePosition()
                task.wait(0.2)
                restorePosition() -- Double check
            end)
            
            -- Method 6: CFrame Lock
            game:GetService("RunService").Heartbeat:Connect(function()
                if lastPosition and Value then
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastPosition
                    end)
                end
            end)
        end
    end
})

local Section = Tabs.Killer:CreateSection("Auto Kill")


local KillToggle = Tabs.Killer:CreateToggle("KillToggle", {
    Title = "Start Killing",
    Default = false,
    Callback = function(Value)
        isKilling = Value
        
        -- Equip Punch Tool
        if Value then
            for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if tool.ClassName == "Tool" and tool.Name == "Punch" then
                    tool.Parent = game.Players.LocalPlayer.Character
                end
            end
        end
        
        -- Auto Punch Loop
        task.spawn(function()
            while isKilling do
                local player = game.Players.LocalPlayer
                player.muscleEvent:FireServer("punch", "rightHand")
                player.muscleEvent:FireServer("punch", "leftHand")
                task.wait()
            end
        end)
        
        -- Kill Loop
        task.spawn(function()
            while isKilling do
                task.spawn(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer and not whitelist[player.UserId] then
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local character = Players.LocalPlayer.Character
                                if character and character:FindFirstChild("LeftHand") then
                                    task.spawn(function()
                                        firetouchinterest(player.Character.HumanoidRootPart, character.LeftHand, 0)
                                        task.wait()
                                        firetouchinterest(player.Character.HumanoidRootPart, character.LeftHand, 1)
                                    end)
                                end
                            end
                        end
                    end
                end)
                task.wait()
            end
        end)
    end
})

local eggsList = {
    "Blue Crystal",
    "Green Crystal",
    "Frost Crystal",
    "Mythical Crystal",
    "Inferno Crystal",
    "Legend Crystal",
    "Muscle Elite Crystal",
    "Galaxy Oracle Crystal",
    "Jungle Crystal"
}

local dropdown = Tabs.Crystal:CreateDropdown("EggDropdown", {
    Title = "Select Crystal",
    Description = "Choose Your Crystal to Open",
    Values = eggsList,
    Multi = false,
    Default = 1,
    Callback = function(Value)
        selectedEgg = Value
    end
})

local Toggle = Tabs.Crystal:CreateToggle("AutoOpenEgg", {
    Title = "Auto Open Crystal",
    Description = "Opens selected crystal automatically",
    Default = false,
    Callback = function(Value)
        getgenv().autoEgg = Value
        
        task.spawn(function()
            while getgenv().autoEgg and selectedEgg do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedEgg)
                task.wait(1)
            end
        end)
    end
})

local IntSection = Tabs.Status:CreateSection("Player Stats")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

-- Timer Variables
local startTime = 0
local sessionStartTime = os.time()
local timerRunning = false

-- Stat Tracking Variables
local strengthGained = 0
local lastStrengthValue = nil
local rebirthsGained = 0
local lastRebirthsValue = nil
local killsGained = 0
local lastKillsValue = nil
local brawlsGained = 0
local lastBrawlsValue = nil
local goodKarmaGained = 0
local lastGoodKarmaValue = nil
local evilKarmaGained = 0
local lastEvilKarmaValue = nil
local durabilityGained = 0
local lastDurabilityValue = nil
local agilityGained = 0
local lastAgilityValue = nil
local muscleKingTimeGained = 0
local lastMuscleKingTimeValue = nil

-- Create UI Elements
local TimerParagraph = Tabs.Status:CreateParagraph("SessionTimer", {
    Title = "Session Time",
    Content = "0d 0h 0m 0s",
    TitleAlignment = "Left",
    ContentAlignment = Enum.TextXAlignment.Left
})

local CustomTimerParagraph = Tabs.Status:CreateParagraph("CustomTimer", {
    Title = "Custom Timer",
    Content = "Timer not started",
    TitleAlignment = "Left",
    ContentAlignment = Enum.TextXAlignment.Left
})

Tabs.Status:CreateButton{
    Title = "Start/Stop Timer",
    Description = "Track your training sessions",
    Callback = function()
        if not timerRunning then
            startTime = os.time()
            timerRunning = true
            CustomTimerParagraph:SetContent("Timer running...")
        else
            timerRunning = false
            CustomTimerParagraph:SetContent("Timer stopped")
        end
    end
}

local StatsParagraph = Tabs.Status:CreateParagraph("CurrentStats", {
    Title = "Current Stats",
    Content = "Loading stats...",
    TitleAlignment = "Left",
    ContentAlignment = Enum.TextXAlignment.Left
})

local GainsParagraph = Tabs.Status:CreateParagraph("GainedStats", {
    Title = "Gained Stats",
    Content = "Loading gains...",
    TitleAlignment = "Left",
    ContentAlignment = Enum.TextXAlignment.Left
})

local function formatNumber(number)
    local formatted = tostring(math.floor(number))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local function formatStat(number)
    local suffixes = {"", "K", "M", "B", "T", "Qa", "Qi"}
    local suffixIndex = 1
    local value = number
    
    while value >= 1000 and suffixIndex < #suffixes do
        value = value / 1000
        suffixIndex = suffixIndex + 1
    end
    
    return string.format("%.1f%s", value, suffixes[suffixIndex])
end

local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%dd %dh %dm %ds", days, hours, minutes, secs)
end

-- Wait for game load
repeat task.wait() until game:IsLoaded()
if not player.Character then player.CharacterAdded:Wait() end
repeat task.wait() until player:FindFirstChild("leaderstats") and player:FindFirstChild("goodKarma")

-- Main Update Loop
RunService.RenderStepped:Connect(function()
    -- Update Timers
    local sessionTime = os.time() - sessionStartTime
    TimerParagraph:SetContent(formatTime(sessionTime))
    if timerRunning then
        local elapsed = os.time() - startTime
        CustomTimerParagraph:SetContent(formatTime(elapsed))
    end

    -- Get Current Stats
    local currentStrength = player.leaderstats.Strength.Value
    local currentRebirths = player.leaderstats.Rebirths.Value
    local currentKills = player.leaderstats.Kills.Value
    local currentBrawls = player.leaderstats.Brawls.Value
    local currentGoodKarma = player.goodKarma.Value
    local currentEvilKarma = player.evilKarma.Value
    local currentDurability = player.Durability.Value
    local currentAgility = player.Agility.Value
    local currentMuscleKingTime = player.muscleKingTime.Value

    -- Track Gains
    if lastStrengthValue == nil then
        lastStrengthValue = currentStrength
    elseif currentStrength > lastStrengthValue then
        strengthGained = strengthGained + (currentStrength - lastStrengthValue)
    end
    lastStrengthValue = currentStrength

    if lastRebirthsValue == nil then
        lastRebirthsValue = currentRebirths
    elseif currentRebirths > lastRebirthsValue then
        rebirthsGained = rebirthsGained + (currentRebirths - lastRebirthsValue)
    end
    lastRebirthsValue = currentRebirths

    if lastKillsValue == nil then
        lastKillsValue = currentKills
    elseif currentKills > lastKillsValue then
        killsGained = killsGained + (currentKills - lastKillsValue)
    end
    lastKillsValue = currentKills

    if lastBrawlsValue == nil then
        lastBrawlsValue = currentBrawls
    elseif currentBrawls > lastBrawlsValue then
        brawlsGained = brawlsGained + (currentBrawls - lastBrawlsValue)
    end
    lastBrawlsValue = currentBrawls

    if lastGoodKarmaValue == nil then
        lastGoodKarmaValue = currentGoodKarma
    elseif currentGoodKarma > lastGoodKarmaValue then
        goodKarmaGained = goodKarmaGained + (currentGoodKarma - lastGoodKarmaValue)
    end
    lastGoodKarmaValue = currentGoodKarma

    if lastEvilKarmaValue == nil then
        lastEvilKarmaValue = currentEvilKarma
    elseif currentEvilKarma > lastEvilKarmaValue then
        evilKarmaGained = evilKarmaGained + (currentEvilKarma - lastEvilKarmaValue)
    end
    lastEvilKarmaValue = currentEvilKarma

    if lastDurabilityValue == nil then
        lastDurabilityValue = currentDurability
    elseif currentDurability > lastDurabilityValue then
        durabilityGained = durabilityGained + (currentDurability - lastDurabilityValue)
    end
    lastDurabilityValue = currentDurability

    if lastAgilityValue == nil then
        lastAgilityValue = currentAgility
    elseif currentAgility > lastAgilityValue then
        agilityGained = agilityGained + (currentAgility - lastAgilityValue)
    end
    lastAgilityValue = currentAgility

    if lastMuscleKingTimeValue == nil then
        lastMuscleKingTimeValue = currentMuscleKingTime
    elseif currentMuscleKingTime > lastMuscleKingTimeValue then
        muscleKingTimeGained = muscleKingTimeGained + (currentMuscleKingTime - lastMuscleKingTimeValue)
    end
    lastMuscleKingTimeValue = currentMuscleKingTime

    -- Update Display
    StatsParagraph:SetContent(string.format([[
Strength: %s (%s)
Rebirths: %s (%s)
Kills: %s (%s)
Brawls: %s (%s)
Durability: %s (%s)
Good Karma: %s (%s)
Bad Karma: %s (%s)
Agility: %s (%s)
Muscle King Time: %s (%s)]], 
        formatNumber(currentStrength), formatStat(currentStrength),
        formatNumber(currentRebirths), formatStat(currentRebirths),
        formatNumber(currentKills), formatStat(currentKills),
        formatNumber(currentBrawls), formatStat(currentBrawls),
        formatNumber(currentDurability), formatStat(currentDurability),
        formatNumber(currentGoodKarma), formatStat(currentGoodKarma),
        formatNumber(currentEvilKarma), formatStat(currentEvilKarma),
        formatNumber(currentAgility), formatStat(currentAgility),
        formatNumber(currentMuscleKingTime), formatStat(currentMuscleKingTime)
    ))
    
    GainsParagraph:SetContent(string.format([[
Strength: %s (%s)
Rebirths: %s (%s)
Kills: %s (%s)
Brawls: %s (%s)
Durability: %s (%s)
Good Karma: %s (%s)
Bad Karma: %s (%s)
Agility: %s (%s)
Muscle King Time: %s (%s)]], 
        formatNumber(strengthGained), formatStat(strengthGained),
        formatNumber(rebirthsGained), formatStat(rebirthsGained),
        formatNumber(killsGained), formatStat(killsGained),
        formatNumber(brawlsGained), formatStat(brawlsGained),
        formatNumber(durabilityGained), formatStat(durabilityGained),
        formatNumber(goodKarmaGained), formatStat(goodKarmaGained),
        formatNumber(evilKarmaGained), formatStat(evilKarmaGained),
        formatNumber(agilityGained), formatStat(agilityGained),
        formatNumber(muscleKingTimeGained), formatStat(muscleKingTimeGained)
    ))
end)

local Players = game:GetService("Players")
local selectedPlayer = nil

local function GetPlayerList()
    local playerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        table.insert(playerList, player.DisplayName)
    end
    return playerList
end

local PlayerStatsParagraph = Tabs.Status:CreateParagraph("PlayerStats", {
    Title = "Player Stats",
    Content = "Select a player and click View Stats",
    TitleAlignment = "Left",
    ContentAlignment = Enum.TextXAlignment.Left
})

local PlayerSeletor = Tabs.Status:CreateDropdown("PlayerSelector", {
    Title = "Player Selector",
    Values = GetPlayerList(),
    Multi = false,
    Default = "",
    Callback = function(value)
        for _, player in pairs(Players:GetPlayers()) do
            if player.DisplayName == value then
                selectedPlayer = player
                break
            end
        end
    end
})

Tabs.Status:CreateButton({
    Title = "View Player Stats",
    Description = "Display selected player's stats",
    Callback = function()
        if selectedPlayer and Players:FindFirstChild(selectedPlayer.Name) then
            PlayerStatsParagraph:SetContent(string.format([[
>Player: %s (%s)
>Strength: %s (%s)
>Rebirths: %s (%s)
>Kills: %s (%s)
>Brawls: %s (%s)
>Durability: %s (%s)
>Good Karma: %s (%s)
>Bad Karma: %s (%s)
>Agility: %s (%s)
>Muscle King Time: %s (%s)]], 
                selectedPlayer.DisplayName, selectedPlayer.Name,
                formatNumber(selectedPlayer.leaderstats.Strength.Value), formatStat(selectedPlayer.leaderstats.Strength.Value),
                formatNumber(selectedPlayer.leaderstats.Rebirths.Value), formatStat(selectedPlayer.leaderstats.Rebirths.Value),
                formatNumber(selectedPlayer.leaderstats.Kills.Value), formatStat(selectedPlayer.leaderstats.Kills.Value),
                formatNumber(selectedPlayer.leaderstats.Brawls.Value), formatStat(selectedPlayer.leaderstats.Brawls.Value),
                formatNumber(selectedPlayer.Durability.Value), formatStat(selectedPlayer.Durability.Value),
                formatNumber(selectedPlayer.goodKarma.Value), formatStat(selectedPlayer.goodKarma.Value),
                formatNumber(selectedPlayer.evilKarma.Value), formatStat(selectedPlayer.evilKarma.Value),
                formatNumber(selectedPlayer.Agility.Value), formatStat(selectedPlayer.Agility.Value),
                formatNumber(selectedPlayer.muscleKingTime.Value), formatStat(selectedPlayer.muscleKingTime.Value)
            ))
        else
            PlayerStatsParagraph:SetContent("This Player has left")
        end
    end
})

Players.PlayerAdded:Connect(function()
    Dropdown:SetValues(GetPlayerList())
end)

Players.PlayerRemoving:Connect(function(player)
    Dropdown:SetValues(GetPlayerList())
    if selectedPlayer and player == selectedPlayer then
        PlayerStatsParagraph:SetContent("This Player has left")
    end
end)

local MainSection = Tabs.Miscellaneous:CreateSection("Misc")

local StrengthInput = Tabs.Miscellaneous:CreateInput("StrengthStat", {
    Title = "Visual Strength",
    Description = "Set your displayed strength",
    Default = "",
    Placeholder = "Enter strength amount",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.leaderstats.Strength.Value = Value
    end
})

local RebirthInput = Tabs.Miscellaneous:CreateInput("RebirthStat", {
    Title = "Visual Rebirths",
    Description = "Set your displayed rebirths",
    Default = "",
    Placeholder = "Enter rebirth amount",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.leaderstats.Rebirths.Value = Value
    end
})

local KillsInput = Tabs.Miscellaneous:CreateInput("KillsStat", {
    Title = "Visual Kills",
    Description = "Set your displayed kills",
    Default = "",
    Placeholder = "Enter kills amount",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.leaderstats.Kills.Value = Value
    end
})

local BrawlsInput = Tabs.Miscellaneous:CreateInput("BrawlsStat", {
    Title = "Visual Brawls",
    Description = "Set your displayed brawls",
    Default = "",
    Placeholder = "Enter brawls amount",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.leaderstats.Brawls.Value = Value
    end
})

SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes{}
InterfaceManager:SetFolder("LurnaiScriptHub")
SaveManager:SetFolder("LurnaiScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

