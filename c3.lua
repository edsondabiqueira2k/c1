local ez = loadstring(game:HttpGet("https://raw.githubusercontent.com/edsondabiqueira2k/c1/refs/heads/main/ez"))()

-- opcional
ez.LoadFont({ Name = "ValleySans" })

local win = ez:Window({
    Name = "ezUI",
    Title = "ez.",
    Subtitle = "Minha UI",
    Icon = "terminal",
    Keybind = "RightControl",
    Size = UDim2.fromOffset(640, 480),
    ConfigurationSaving = { Enabled = true, FolderName = "ezconfig", FileName = "default" },
})

local tab = win:Tab({ Name = "Main", Icon = "home", Desc = "Aba principal" })
tab:Section("Geral")
tab:Button({ Name = "Executar", Desc = "Faz algo", Icon = "play", Style = "Primary", Callback = function() end })
tab:Toggle({ Name = "Auto", Flag = "Auto", Default = false, Callback = function(v) end })
tab:Slider({ Name = "Velocidade", Flag = "Speed", Min = 0, Max = 100, Default = 50 })
tab:Dropdown({ Name = "Modo", Flag = "Mode", Options = { "A", "B", "C" }, Default = "A" })
tab:Input({ Name = "Nome", Placeholder = "digite..." })
tab:Keybind({ Name = "Toggle", Default = "F" })
tab:ColorPicker({ Name = "Cor", Flag = "Color", Default = Color3.new(1,1,1) })

win:Notify({ Title = "Pronto", Content = "Lib carregada", Icon = "check", Type = "Success" })
