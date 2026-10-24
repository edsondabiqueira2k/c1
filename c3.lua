local syde = loadstring(game:HttpGet("https://raw.githubusercontent.com/essencejs/syde/refs/heads/main/source", true))()

syde:Load({
	Logo = '7488932274',
	Name = 'ez.',
	Status = 'Stable',
	Accent = Color3.fromRGB(56, 189, 248),
	HitBox = Color3.fromRGB(56, 189, 248),
	AutoLoad = false,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = 'ez',
		FileName = "config"
	}
})

local Window = syde:Init({
	Title = 'ez.';
	SubText = 'universal executor'
})

local CombatTab = Window:InitTab('combat')
local VisualTab = Window:InitTab('visual')
local MovementTab = Window:InitTab('movement')
local MiscTab = Window:InitTab('misc')

-- combat
CombatTab:Section('aim', '8932620770')

CombatTab:Toggle({
	Title = 'aimbot',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezAimbot = value
	end,
})

CombatTab:CreateSlider({
	Title = 'aim settings',
	Sliders = {
		{
			Title = 'fov',
			Range = {20, 500},
			Increment = 10,
			StarterValue = 100,
			CallBack = function(value)
				_G.ezAimFOV = value
			end,
		},
		{
			Title = 'smoothing',
			Range = {0, 1},
			Increment = 0.05,
			StarterValue = 0.2,
			CallBack = function(value)
				_G.ezAimSmooth = value
			end,
		}
	}
})

CombatTab:Dropdown({
	Title = 'target part',
	Options = {'Head', 'Torso', 'HumanoidRootPart'},
	PlaceHolder = 'select part...',
	CallBack = function(option)
		_G.ezAimPart = option
	end,
})

CombatTab:Section('trigger')

CombatTab:Toggle({
	Title = 'triggerbot',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezTrigger = value
	end,
})

CombatTab:CreateSlider({
	Title = 'trigger delay',
	Sliders = {
		{
			Title = 'delay (ms)',
			Range = {0, 500},
			Increment = 10,
			StarterValue = 50,
			CallBack = function(value)
				_G.ezTriggerDelay = value
			end,
		}
	}
})

-- visual
VisualTab:Section('esp', '8932620770')

VisualTab:Toggle({
	Title = 'box esp',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezBoxESP = value
	end,
})

VisualTab:Toggle({
	Title = 'name esp',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezNameESP = value
	end,
})

VisualTab:Toggle({
	Title = 'distance esp',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezDistanceESP = value
	end,
})

VisualTab:Toggle({
	Title = 'health esp',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezHealthESP = value
	end,
})

VisualTab:Toggle({
	Title = 'skeleton esp',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezSkeletonESP = value
	end,
})

VisualTab:Toggle({
	Title = 'tracers',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezTracers = value
	end,
})

VisualTab:Section('colors')

VisualTab:ColorPicker({
	Title = 'esp color',
	Color = Color3.fromRGB(56, 189, 248),
	CallBack = function(color)
		_G.ezESPColor = color
	end,
})

VisualTab:CreateSlider({
	Title = 'esp settings',
	Sliders = {
		{
			Title = 'max distance',
			Range = {100, 5000},
			Increment = 100,
			StarterValue = 2000,
			CallBack = function(value)
				_G.ezESPDistance = value
			end,
		},
		{
			Title = 'thickness',
			Range = {1, 5},
			Increment = 0.5,
			StarterValue = 2,
			CallBack = function(value)
				_G.ezESPThickness = value
			end,
		}
	}
})

VisualTab:Section('world')

VisualTab:Toggle({
	Title = 'fov circle',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezFOVCircle = value
	end,
})

VisualTab:Toggle({
	Title = 'crosshair',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezCrosshair = value
	end,
})

VisualTab:Toggle({
	Title = 'fullbright',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezFullbright = value
		if value then
			game.Lighting.Brightness = 2
			game.Lighting.ClockTime = 14
			game.Lighting.FogEnd = 100000
			game.Lighting.GlobalShadows = false
			game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		else
			game.Lighting.Brightness = 1
			game.Lighting.ClockTime = 12
			game.Lighting.FogEnd = 100000
			game.Lighting.GlobalShadows = true
			game.Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
		end
	end,
})

-- movement
MovementTab:Section('speed', '8932620770')

MovementTab:Toggle({
	Title = 'speed hack',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezSpeed = value
	end,
})

MovementTab:CreateSlider({
	Title = 'movement config',
	Sliders = {
		{
			Title = 'walk speed',
			Range = {16, 200},
			Increment = 2,
			StarterValue = 16,
			CallBack = function(value)
				_G.ezWalkSpeed = value
			end,
		},
		{
			Title = 'jump power',
			Range = {50, 300},
			Increment = 5,
			StarterValue = 50,
			CallBack = function(value)
				_G.ezJumpPower = value
			end,
		}
	}
})

MovementTab:Section('flight')

MovementTab:Toggle({
	Title = 'fly',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezFly = value
	end,
})

MovementTab:CreateSlider({
	Title = 'fly speed',
	Sliders = {
		{
			Title = 'speed',
			Range = {10, 200},
			Increment = 5,
			StarterValue = 50,
			CallBack = function(value)
				_G.ezFlySpeed = value
			end,
		}
	}
})

MovementTab:Section('other')

MovementTab:Toggle({
	Title = 'noclip',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezNoclip = value
	end,
})

MovementTab:Toggle({
	Title = 'infinite jump',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezInfJump = value
	end,
})

-- misc
MiscTab:Section('automation', '8932620770')

MiscTab:Toggle({
	Title = 'auto farm',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezAutoFarm = value
	end,
})

MiscTab:Toggle({
	Title = 'auto collect',
	Value = false,
	Config = true,
	CallBack = function(value)
		_G.ezAutoCollect = value
	end,
})

MiscTab:Section('player')

MiscTab:Toggle({
	Title = 'god mode',
	Description = 'reset to disable',
	Value = false,
	CallBack = function(value)
		_G.ezGodMode = value
		if value then
			local player = game.Players.LocalPlayer
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.Name = "1"
				local l = player.Character["1"]:Clone()
				l.Parent = player.Character
				l.Name = "Humanoid"
				wait(0.1)
				player.Character["1"]:Destroy()
				game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
				player.Character.Animate.Disabled = true
				wait(0.1)
				player.Character.Animate.Disabled = false
			end
		end
	end,
})

MiscTab:Button({
	Title = 'respawn',
	CallBack = function()
		local player = game.Players.LocalPlayer
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.Health = 0
		end
	end,
})

MiscTab:Section('keybinds')

MiscTab:Keybind({
	Title = 'toggle ui',
	Key = Enum.KeyCode.RightShift,
	CallBack = function()
		syde:Toggle()
	end,
})

MiscTab:Keybind({
	Title = 'panic key',
	Description = 'disables all features',
	Key = Enum.KeyCode.Delete,
	CallBack = function()
		_G.ezAimbot = false
		_G.ezTrigger = false
		_G.ezBoxESP = false
		_G.ezNameESP = false
		_G.ezDistanceESP = false
		_G.ezHealthESP = false
		_G.ezSkeletonESP = false
		_G.ezTracers = false
		_G.ezSpeed = false
		_G.ezFly = false
		_G.ezNoclip = false
		_G.ezAutoFarm = false
		_G.ezAutoCollect = false
		syde:Notify({
			Title = 'panic',
			Content = 'all features disabled',
			Duration = 2
		})
	end,
})

MiscTab:Section('info')

MiscTab:Label('ez. v0.1', 'Center')
MiscTab:Label('universal roblox executor', 'Center')

-- init globals
_G.ezAimbot = false
_G.ezAimFOV = 100
_G.ezAimSmooth = 0.2
_G.ezAimPart = 'Head'
_G.ezTrigger = false
_G.ezTriggerDelay = 50
_G.ezBoxESP = false
_G.ezNameESP = false
_G.ezDistanceESP = false
_G.ezHealthESP = false
_G.ezSkeletonESP = false
_G.ezTracers = false
_G.ezESPColor = Color3.fromRGB(56, 189, 248)
_G.ezESPDistance = 2000
_G.ezESPThickness = 2
_G.ezFOVCircle = false
_G.ezCrosshair = false
_G.ezFullbright = false
_G.ezSpeed = false
_G.ezWalkSpeed = 16
_G.ezJumpPower = 50
_G.ezFly = false
_G.ezFlySpeed = 50
_G.ezNoclip = false
_G.ezInfJump = false
_G.ezAutoFarm = false
_G.ezAutoCollect = false
_G.ezGodMode = false

syde:Notify({
	Title = 'ez.',
	Content = 'ui carregada — runtime pronto',
	Duration = 3
})

print('ez. ui carregada')
