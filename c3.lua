-- ez. | https://discord.gg/UcCEgWBh

local ez = loadstring(game:HttpGet("https://raw.githubusercontent.com/edsondabiqueira2k/c1/refs/heads/main/ez"))()

local Window = ez:CreateWindow({ Title = "ez." })
local Tab = Window:AddTab("Combat")
local Section = Tab:AddSection("Aimbot")
Section:AddToggle("Habilitar", false, function(v) print(v) end)
