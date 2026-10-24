-- ez. | https://discord.gg/UcCEgWBh
-- Functional cheat hub using WindUI

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- Initialize global state table
_G.ez = _G.ez or {
    Combat = {},
    Player = {},
    Visual = {},
    Misc = {}
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Utility Functions
local function GetClosestPlayerToCursor(fov)
    local closestPlayer = nil
    local shortestDistance = fov or math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local screenPoint, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    
    return closestPlayer
end

local function CreateESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ezESP"
    highlight.FillColor = _G.ez.Visual.ESPColor or Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
end

local function RemoveESP(player)
    if player.Character and player.Character:FindFirstChild("ezESP") then
        player.Character.ezESP:Destroy()
    end
end

-- Create Window
local Window = WindUI:CreateWindow({
    Title = "ez. | https://discord.gg/UcCEgWBh",
    Icon = "rbxassetid://10723415903",
    Author = "ez. team",
    Folder = "ezConfig",
    Size = UDim2.fromOffset(550, 600),
    KeySystem = {
        Key = "ez2024",
        Note = "Join discord.gg/UcCEgWBh",
        URL = "https://discord.gg/UcCEgWBh",
        SaveKey = true
    },
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 170,
})

-- Combat Tab
local CombatTab = Window:Tab({
    Name = "Combat",
    Icon = "rbxassetid://10723407389",
    Color = Color3.fromRGB(255, 0, 0)
})

CombatTab:Section({
    Name = "Aimbot"
})

CombatTab:Toggle({
    Name = "Enable Aimbot",
    Flag = "AimbotEnabled",
    Default = false,
    Callback = function(value)
        _G.ez.Combat.AimbotEnabled = value
    end
})

CombatTab:Slider({
    Name = "Aimbot FOV",
    Flag = "AimbotFOV",
    Min = 50,
    Max = 500,
    Default = 200,
    Callback = function(value)
        _G.ez.Combat.AimbotFOV = value
    end
})

CombatTab:Slider({
    Name = "Aimbot Smoothing",
    Flag = "AimbotSmoothing",
    Min = 1,
    Max = 20,
    Default = 5,
    Callback = function(value)
        _G.ez.Combat.AimbotSmoothing = value
    end
})

CombatTab:Dropdown({
    Name = "Aimbot Target Part",
    Flag = "AimbotTargetPart",
    List = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = "Head",
    Callback = function(value)
        _G.ez.Combat.AimbotTargetPart = value
    end
})

CombatTab:Section({
    Name = "Triggerbot"
})

CombatTab:Toggle({
    Name = "Enable Triggerbot",
    Flag = "TriggerbotEnabled",
    Default = false,
    Callback = function(value)
        _G.ez.Combat.TriggerbotEnabled = value
    end
})

CombatTab:Slider({
    Name = "Trigger Delay (ms)",
    Flag = "TriggerDelay",
    Min = 0,
    Max = 500,
    Default = 100,
    Callback = function(value)
        _G.ez.Combat.TriggerDelay = value / 1000
    end
})

-- Player Tab
local PlayerTab = Window:Tab({
    Name = "Player",
    Icon = "rbxassetid://10747373176",
    Color = Color3.fromRGB(0, 255, 0)
})

PlayerTab:Section({
    Name = "Movement"
})

PlayerTab:Toggle({
    Name = "Speed Hack",
    Flag = "SpeedHack",
    Default = false,
    Callback = function(value)
        _G.ez.Player.SpeedHack = value
        if not value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

PlayerTab:Slider({
    Name = "Walk Speed",
    Flag = "WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 100,
    Callback = function(value)
        _G.ez.Player.WalkSpeed = value
    end
})

PlayerTab:Toggle({
    Name = "Jump Power Hack",
    Flag = "JumpPowerHack",
    Default = false,
    Callback = function(value)
        _G.ez.Player.JumpPowerHack = value
        if not value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
})

PlayerTab:Slider({
    Name = "Jump Power",
    Flag = "JumpPower",
    Min = 50,
    Max = 500,
    Default = 150,
    Callback = function(value)
        _G.ez.Player.JumpPower = value
    end
})

PlayerTab:Toggle({
    Name = "Fly",
    Flag = "Fly",
    Default = false,
    Callback = function(value)
        _G.ez.Player.Fly = value
    end
})

PlayerTab:Slider({
    Name = "Fly Speed",
    Flag = "FlySpeed",
    Min = 10,
    Max = 500,
    Default = 50,
    Callback = function(value)
        _G.ez.Player.FlySpeed = value
    end
})

PlayerTab:Toggle({
    Name = "Noclip",
    Flag = "Noclip",
    Default = false,
    Callback = function(value)
        _G.ez.Player.Noclip = value
    end
})

PlayerTab:Section({
    Name = "Other"
})

PlayerTab:Toggle({
    Name = "Infinite Jump",
    Flag = "InfiniteJump",
    Default = false,
    Callback = function(value)
        _G.ez.Player.InfiniteJump = value
    end
})

-- Visual Tab
local VisualTab = Window:Tab({
    Name = "Visual",
    Icon = "rbxassetid://10734950309",
    Color = Color3.fromRGB(0, 150, 255)
})

VisualTab:Section({
    Name = "ESP"
})

VisualTab:Toggle({
    Name = "Player ESP",
    Flag = "PlayerESP",
    Default = false,
    Callback = function(value)
        _G.ez.Visual.PlayerESP = value
        if value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    CreateESP(player)
                end
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                RemoveESP(player)
            end
        end
    end
})

VisualTab:Colorpicker({
    Name = "ESP Color",
    Flag = "ESPColor",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(value)
        _G.ez.Visual.ESPColor = value
        if _G.ez.Visual.PlayerESP then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("ezESP") then
                    player.Character.ezESP.FillColor = value
                end
            end
        end
    end
})

VisualTab:Section({
    Name = "World"
})

VisualTab:Toggle({
    Name = "Fullbright",
    Flag = "Fullbright",
    Default = false,
    Callback = function(value)
        _G.ez.Visual.Fullbright = value
        if value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        end
    end
})

VisualTab:Toggle({
    Name = "FOV Circle",
    Flag = "FOVCircle",
    Default = false,
    Callback = function(value)
        _G.ez.Visual.FOVCircle = value
    end
})

VisualTab:Slider({
    Name = "FOV Size",
    Flag = "FOVSize",
    Min = 50,
    Max = 500,
    Default = 200,
    Callback = function(value)
        _G.ez.Visual.FOVSize = value
    end
})

-- Misc Tab
local MiscTab = Window:Tab({
    Name = "Misc",
    Icon = "rbxassetid://10734926394",
    Color = Color3.fromRGB(255, 255, 0)
})

MiscTab:Section({
    Name = "Teleport"
})

MiscTab:Button({
    Name = "Teleport to Random Player",
    Callback = function()
        local players = Players:GetPlayers()
        local randomPlayer = players[math.random(1, #players)]
        if randomPlayer ~= LocalPlayer and randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
        end
    end
})

MiscTab:Input({
    Name = "Teleport to Player",
    Flag = "TeleportPlayerName",
    Placeholder = "Enter player name",
    Callback = function(value)
        local targetPlayer = Players:FindFirstChild(value)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    end
})

MiscTab:Section({
    Name = "Other"
})

MiscTab:Button({
    Name = "Respawn",
    Callback = function()
        LocalPlayer.Character.Humanoid.Health = 0
    end
})

MiscTab:Toggle({
    Name = "Remove Fog",
    Flag = "RemoveFog",
    Default = false,
    Callback = function(value)
        if value then
            Lighting.FogEnd = 100000
        else
            Lighting.FogEnd = 10000
        end
    end
})

MiscTab:Button({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

-- Main Loops
RunService.RenderStepped:Connect(function()
    -- Aimbot
    if _G.ez.Combat.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestPlayerToCursor(_G.ez.Combat.AimbotFOV)
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild(_G.ez.Combat.AimbotTargetPart or "Head")
            if targetPart then
                local aimPos = Camera:WorldToViewportPoint(targetPart.Position)
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local smoothing = _G.ez.Combat.AimbotSmoothing or 5
                
                mousemoverel(
                    (aimPos.X - mousePos.X) / smoothing,
                    (aimPos.Y - mousePos.Y) / smoothing
                )
            end
        end
    end
    
    -- Triggerbot
    if _G.ez.Combat.TriggerbotEnabled then
        local target = Mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") then
            local player = Players:GetPlayerFromCharacter(target.Parent)
            if player and player ~= LocalPlayer then
                task.wait(_G.ez.Combat.TriggerDelay or 0.1)
                mouse1click()
            end
        end
    end
    
    -- Speed Hack
    if _G.ez.Player.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = _G.ez.Player.WalkSpeed or 100
    end
    
    -- Jump Power Hack
    if _G.ez.Player.JumpPowerHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = _G.ez.Player.JumpPower or 150
    end
    
    -- Noclip
    if _G.ez.Player.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Fly System
local flyConnection
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and _G.ez.Player.Fly then
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local hrp = char.HumanoidRootPart
        local speed = _G.ez.Player.FlySpeed or 50
        
        if input.KeyCode == Enum.KeyCode.W then
            _G.ez.Player.FlyingForward = true
        elseif input.KeyCode == Enum.KeyCode.S then
            _G.ez.Player.FlyingBackward = true
        elseif input.KeyCode == Enum.KeyCode.A then
            _G.ez.Player.FlyingLeft = true
        elseif input.KeyCode == Enum.KeyCode.D then
            _G.ez.Player.FlyingRight = true
        elseif input.KeyCode == Enum.KeyCode.Space then
            _G.ez.Player.FlyingUp = true
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            _G.ez.Player.FlyingDown = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then
        _G.ez.Player.FlyingForward = false
    elseif input.KeyCode == Enum.KeyCode.S then
        _G.ez.Player.FlyingBackward = false
    elseif input.KeyCode == Enum.KeyCode.A then
        _G.ez.Player.FlyingLeft = false
    elseif input.KeyCode == Enum.KeyCode.D then
        _G.ez.Player.FlyingRight = false
    elseif input.KeyCode == Enum.KeyCode.Space then
        _G.ez.Player.FlyingUp = false
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        _G.ez.Player.FlyingDown = false
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.ez.Player.Fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local speed = _G.ez.Player.FlySpeed or 50
        local vel = Vector3.new(0, 0, 0)
        
        if _G.ez.Player.FlyingForward then vel = vel + Camera.CFrame.LookVector * speed end
        if _G.ez.Player.FlyingBackward then vel = vel - Camera.CFrame.LookVector * speed end
        if _G.ez.Player.FlyingLeft then vel = vel - Camera.CFrame.RightVector * speed end
        if _G.ez.Player.FlyingRight then vel = vel + Camera.CFrame.RightVector * speed end
        if _G.ez.Player.FlyingUp then vel = vel + Vector3.new(0, speed, 0) end
        if _G.ez.Player.FlyingDown then vel = vel - Vector3.new(0, speed, 0) end
        
        hrp.Velocity = vel
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if _G.ez.Player.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- FOV Circle Drawing
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 2
fovCircle.NumSides = 64
fovCircle.Filled = false
fovCircle.Transparency = 1
fovCircle.Color = Color3.fromRGB(255, 255, 255)

RunService.RenderStepped:Connect(function()
    if _G.ez.Visual.FOVCircle then
        fovCircle.Visible = true
        fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
        fovCircle.Radius = _G.ez.Visual.FOVSize or 200
    else
        fovCircle.Visible = false
    end
end)

-- ESP Auto-Update
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if _G.ez.Visual.PlayerESP then
            task.wait(0.5)
            CreateESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

print("ez. loaded | discord.gg/UcCEgWBh")
