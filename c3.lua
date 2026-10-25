local ez = loadstring(game:HttpGet("https://raw.githubusercontent.com/edsondabiqueira2k/c1/refs/heads/main/ez"))()

local Window = ez:CreateWindow({Title = "ez.", Subtitle = "v1.0"})
local AimbotTab = Window:CreateTab("Aimbot")
Window:AddSection(AimbotTab, "Aimbot Settings")
Window:AddToggle(AimbotTab, {Title = "Enable Aimbot", Value = false, Flag = "aim_enabled", Callback = function(v) print("Aimbot:", v) end})
Window:AddSlider(AimbotTab, {Title = "FOV", Min = 10, Max = 360, Value = 90, Flag = "aim_fov", Callback = function(v) print("FOV:", v) end})
Window:AddDropdown(AimbotTab, {Title = "Target Part", Options = {"Head", "Torso"}, Value = "Head", Flag = "aim_target"})
