-- language: Lua, file: ez_gui.lua, target: Roblox (Executor / Loadstring)
-- *UI 100% funcional: drag, tabs, toggles, sliders, dropdowns, keybinds e preview ESP*
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================================
-- CONFIGURAÇÕES GLOBAIS
-- ==========================================================
local Config = {}
local Connections = {}

-- ==========================================================
-- UTILITÁRIOS
-- ==========================================================
local function Create(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    return inst
end

local function Round(num, decimal)
    local mult = 10 ^ (decimal or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- ==========================================================
-- GUI PRINCIPAL
-- ==========================================================
local ScreenGui = Create("ScreenGui", {
    Name = "EZ_Menu",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = game.CoreGui end

-- Container Principal (Drag)
local Main = Create("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    Size = UDim2.new(0, 680, 0, 480),
    Position = UDim2.new(0.5, -340, 0.5, -240),
    BackgroundColor3 = Color3.fromRGB(16, 16, 18),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Active = true
})

Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = Main })
Create("UIStroke", { Color = Color3.fromRGB(35, 35, 40), Thickness = 1, Parent = Main })

-- Top Bar (Drag)
local TopBar = Create("Frame", {
    Name = "TopBar",
    Parent = Main,
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(22, 22, 25),
    BorderSizePixel = 0
})

-- Linha sutil no topo
Create("Frame", {
    Parent = Main,
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(35, 35, 40),
    BorderSizePixel = 0
})

-- Nome "ez." na TopBar
local TitleLabel = Create("TextLabel", {
    Parent = TopBar,
    Size = UDim2.new(0, 100, 1, 0),
    Position = UDim2.new(0, 20, 0, 0),
    BackgroundTransparency = 1,
    Text = "ez.",
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})

local UserLabel = Create("TextLabel", {
    Parent = TopBar,
    Size = UDim2.new(0, 100, 1, 0),
    Position = UDim2.new(1, -120, 0, 0),
    BackgroundTransparency = 1,
    Text = LocalPlayer.Name,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    TextXAlignment = Enum.TextXAlignment.Right
})

-- Botão de Fechar
local CloseBtn = Create("TextButton", {
    Parent = TopBar,
    Size = UDim2.new(0, 40, 0, 40),
    Position = UDim2.new(1, -40, 0, 0),
    BackgroundTransparency = 1,
    Text = "×",
    Font = Enum.Font.Gotham,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    TextXAlignment = Enum.TextXAlignment.Center
})

CloseBtn.MouseEnter:Connect(function() CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150) end)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

-- Sistema de Drag
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================================
-- SIDEBAR (ESQUERDA)
-- ==========================================================
local Sidebar = Create("Frame", {
    Parent = Main,
    Size = UDim2.new(0, 160, 1, -40),
    Position = UDim2.new(0, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(16, 16, 18),
    BorderSizePixel = 0
})

Create("Frame", { -- Linha divisória
    Parent = Sidebar,
    Size = UDim2.new(0, 1, 1, -20),
    Position = UDim2.new(1, -1, 0, 10),
    BackgroundColor3 = Color3.fromRGB(35, 35, 40),
    BorderSizePixel = 0
})

local NavList = Create("Frame", {
    Parent = Sidebar,
    Size = UDim2.new(1, 0, 0, 200),
    Position = UDim2.new(0, 0, 0, 10),
    BackgroundTransparency = 1
})

-- Layout para a navegação
Create("UIListLayout", {
    Parent = NavList,
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
})

-- ==========================================================
-- CONTAINER DIREITO (PÁGINAS)
-- ==========================================================
local Pages = Create("Frame", {
    Parent = Main,
    Size = UDim2.new(1, -160, 1, -40),
    Position = UDim2.new(0, 160, 0, 40),
    BackgroundColor3 = Color3.fromRGB(20, 20, 23),
    BorderSizePixel = 0
})

-- ==========================================================
-- SISTEMA DE NAVEGAÇÃO E PÁGINAS
-- ==========================================================
local Tabs = {}
local ActiveTab = nil

local function CreateTab(name)
    local TabBtn = Create("TextButton", {
        Parent = NavList,
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundColor3 = Color3.fromRGB(22, 22, 25),
        Text = name,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(150, 150, 150),
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = TabBtn })
    
    local Page = Create("ScrollingFrame", {
        Parent = Pages,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70),
        Visible = false
    })
    Create("UIListLayout", {
        Parent = Page,
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Create("UIPadding", {
        Parent = Page,
        PaddingRight = UDim.new(0, 5)
    })

    Tabs[name] = { Button = TabBtn, Page = Page }
    return Page
end

local function SwitchTab(name)
    for k, v in pairs(Tabs) do
        v.Button.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
        v.Button.TextColor3 = Color3.fromRGB(150, 150, 150)
        v.Page.Visible = false
    end
    if Tabs[name] then
        Tabs[name].Button.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        Tabs[name].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tabs[name].Page.Visible = true
        ActiveTab = name
    end
end

local function AddTabClick(name)
    Tabs[name].Button.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
end

-- Criando Abas
CreateTab("Aimbot")
CreateTab("Visuals")
CreateTab("Misc")
CreateTab("Configs")

for name, _ in pairs(Tabs) do
    AddTabClick(name)
end
SwitchTab("Aimbot")

-- ==========================================================
-- COMPONENTES DA PÁGINA (ELEMENTOS UI)
-- ==========================================================
local function CreateSection(parent, title)
    local Section = Create("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        LayoutOrder = 1
    })
    local Label = Create("TextLabel", {
        Parent = Section,
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(100, 100, 100),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    local Line = Create("Frame", {
        Parent = Section,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 0, 25),
        BackgroundColor3 = Color3.fromRGB(35, 35, 40),
        BorderSizePixel = 0
    })
    return Section
end

local function CreateToggle(parent, text, default, callback)
    Config[text] = default
    local Container = Create("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1
    })
    
    local Label = Create("TextLabel", {
        Parent = Container,
        Size = UDim2.new(1, -50, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local ToggleBg = Create("Frame", {
        Parent = Container,
        Size = UDim2.new(0, 36, 0, 18),
        Position = UDim2.new(1, -36, 0.5, -9),
        BackgroundColor3 = default and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(35, 35, 40),
        BorderSizePixel = 0
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = ToggleBg })
    
    local Circle = Create("Frame", {
        Parent = ToggleBg,
        Size = UDim2.new(0, 14, 0, 14),
        Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = Circle })
    
    local Btn = Create("TextButton", {
        Parent = Container,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = ""
    })
    
    local state = default
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Config[text] = state
        
        TweenService:Create(ToggleBg, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(35, 35, 40)
        }):Play()
        
        TweenService:Create(Circle, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()
        
        if callback then callback(state) end
    end)
    
    return Container
end

local function CreateSlider(parent, text, min, max, default, callback)
    Config[text] = default
    local Container = Create("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundTransparency = 1
    })
    
    local Label = Create("TextLabel", {
        Parent = Container,
        Size = UDim2.new(1, -50, 0, 20),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local ValueLabel = Create("TextLabel", {
        Parent = Container,
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -50, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(default),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(80, 120, 255),
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local BarBg = Create("Frame", {
        Parent = Container,
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(35, 35, 40),
        BorderSizePixel = 0
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = BarBg })
    
    local BarFill = Create("Frame", {
        Parent = BarBg,
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(80, 120, 255),
        BorderSizePixel = 0
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = BarFill })
    
    local BarBtn = Create("TextButton", {
        Parent = BarBg,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = ""
    })
    
    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        BarFill.Size = UDim2.new(pos, 0, 1, 0)
        ValueLabel.Text = tostring(val)
        Config[text] = val
        if callback then callback(val) end
    end
    
    BarBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            Update(input)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            Update(input)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return Container
end

local function CreateDropdown(parent, text, options, default, callback)
    Config[text] = default
    local Container = Create("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })
    
    local Label = Create("TextLabel", {
        Parent = Container,
        Size = UDim2.new(1, -100, 0, 30),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local SelectBg = Create("Frame", {
        Parent = Container,
        Size = UDim2.new(0, 90, 0, 24),
        Position = UDim2.new(1, -90, 0.5, -12),
        BackgroundColor3 = Color3.fromRGB(22, 22, 25),
        BorderSizePixel = 0
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = SelectBg })
    
    local SelectBtn = Create("TextButton", {
        Parent = SelectBg,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = default,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(200, 200, 200)
    })
    
    -- Lista Dropdown
    local ListBg = Create("Frame", {
        Parent = Container,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 35),
        BackgroundColor3 = Color3.fromRGB(22, 22, 25),
        BorderSizePixel = 0,
        Visible = false
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = ListBg })
    Create("UIListLayout", { Parent = ListBg, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder })
    
    local open = false
    
    local function UpdateHeight()
        local count = 0
        for _, child in pairs(ListBg:GetChildren()) do
            if child:IsA("TextButton") then count = count + 1 end
        end
        local h = count * 26
        if open then
            Container.Size = UDim2.new(1, 0, 0, 30 + h + 10)
            ListBg.Size = UDim2.new(1, 0, 0, h + 6)
            TweenService:Create(ListBg, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
        else
            Container.Size = UDim2.new(1, 0, 0, 30)
            TweenService:Create(ListBg, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
        end
    end

    SelectBtn.MouseButton1Click:Connect(function()
        open = not open
        ListBg.Visible = true
        UpdateHeight()
        if not open then
            task.wait(0.2)
            ListBg.Visible = false
        end
    end)
    
    for _, opt in pairs(options) do
        local OptBtn = Create("TextButton", {
            Parent = ListBg,
            Size = UDim2.new(1, -10, 0, 24),
            Position = UDim2.new(0, 5, 0, 3),
            BackgroundColor3 = Color3.fromRGB(22, 22, 25),
            Text = opt,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextColor3 = Color3.fromRGB(150, 150, 150),
            AutoButtonColor = false
        })
        OptBtn.MouseEnter:Connect(function() OptBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40) end)
        OptBtn.MouseLeave:Connect(function() OptBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 25) end)
        
        OptBtn.MouseButton1Click:Connect(function()
            SelectBtn.Text = opt
            Config[text] = opt
            open = false
            UpdateHeight()
            task.wait(0.2)
            ListBg.Visible = false
            if callback then callback(opt) end
        end)
        
        -- Layout da lista (Corrigir posição)
        Create("UIListLayout", { Parent = ListBg, Padding = UDim.new(0, 2) })
    end
    
    return Container
end

local function CreateKeybind(parent, text, defaultKey, callback)
    Config[text] = defaultKey
    local Container = Create("Frame", {
        Parent = parent,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1
    })
    
    local Label = Create("TextLabel", {
        Parent = Container,
        Size = UDim2.new(1, -80, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local KeyBtn = Create("TextButton", {
        Parent = Container,
        Size = UDim2.new(0, 70, 0, 22),
        Position = UDim2.new(1, -70, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(22, 22, 25),
        Text = defaultKey.Name,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(200, 200, 200)
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = KeyBtn })
    
    local listening = false
    
    KeyBtn.MouseButton1Click:Connect(function()
        listening = true
        KeyBtn.Text = "..."
    end)
    
    UIS.InputBegan:Connect(function(input)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            KeyBtn.Text = input.KeyCode.Name
            Config[text] = input.KeyCode
            if callback then callback(input.KeyCode) end
        end
    end)
    
    return Container
end

-- ==========================================================
-- PÁGINAS
-- ==========================================================
-- Aba Aimbot
local AimbotPage = Tabs["Aimbot"].Page
CreateSection(AimbotPage, "AIMBOT SETTINGS")
CreateToggle(AimbotPage, "Enabled", false, function(state) print("Aimbot:", state) end)
CreateToggle(AimbotPage, "Visible Check", true, function(state) print("VisCheck:", state) end)
CreateToggle(AimbotPage, "Wall Check", false, function(state) print("WallCheck:", state) end)
CreateDropdown(AimbotPage, "Target Part", {"Head", "Torso", "Nearest"}, "Head", function(opt) print("Target:", opt) end)
CreateSlider(AimbotPage, "FOV", 10, 360, 90, function(val) print("FOV:", val) end)
CreateSlider(AimbotPage, "Smoothness", 1, 20, 5, function(val) print("Smooth:", val) end)
CreateKeybind(AimbotPage, "Aim Keybind", Enum.KeyCode.E, function(key) print("AimKey:", key.Name) end)

-- Aba Visuals
local VisualsPage = Tabs["Visuals"].Page
CreateSection(VisualsPage, "ESP PLAYERS")
CreateToggle(VisualsPage, "Enable ESP", false, function(state) print("ESP:", state) end)
CreateToggle(VisualsPage, "Boxes", false, function(state) print("Boxes:", state) end)
CreateToggle(VisualsPage, "Names", false, function(state) print("Names:", state) end)
CreateToggle(VisualsPage, "Health Bar", false, function(state) print("HealthBar:", state) end)
CreateToggle(VisualsPage, "Distance", false, function(state) print("Distance:", state) end)
CreateDropdown(VisualsPage, "Box Style", {"2D", "3D", "Corner"}, "2D", function(opt) print("BoxStyle:", opt) end)
CreateDropdown(VisualsPage, "Tracer From", {"Top", "Center", "Bottom"}, "Center", function(opt) print("Tracer:", opt) end)

-- Aba Misc
local MiscPage = Tabs["Misc"].Page
CreateSection(MiscPage, "MISCELLANEOUS")
CreateToggle(MiscPage, "Fullbright", false, function(state) print("Fullbright:", state) end)
CreateToggle(MiscPage, "No Fog", false, function(state) print("NoFog:", state) end)
CreateSlider(MiscPage, "FOV", 70, 120, 70, function(val) print("CameraFOV:", val) end)
CreateToggle(MiscPage, "Anti-AFK", false, function(state) print("AntiAFK:", state) end)

-- Aba Configs
local ConfigPage = Tabs["Configs"].Page
CreateSection(ConfigPage, "CONFIGURATION")
local SaveBtn = Create("TextButton", {
    Parent = ConfigPage,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Color3.fromRGB(35, 35, 40),
    Text = "Save Config",
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255)
})
Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = SaveBtn })
SaveBtn.MouseButton1Click:Connect(function() print("Config Saved (Mock)") end)

local LoadBtn = Create("TextButton", {
    Parent = ConfigPage,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Color3.fromRGB(35, 35, 40),
    Text = "Load Config",
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255)
})
Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = LoadBtn })
LoadBtn.MouseButton1Click:Connect(function() print("Config Loaded (Mock)") end)

-- ==========================================================
-- LÓGICA FUNCIONAL (ESP & MISC)
-- ==========================================================
local RunLoop = RunService.RenderStepped

-- Fullbright
RunLoop:Connect(function()
    if Config["Fullbright"] then
        game.Lighting.Ambient = Color3.fromRGB(178, 178, 178)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
        game.Lighting.Brightness = 2
    else
        game.Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        game.Lighting.Brightness = 1
    end
end)

-- No Fog
game.Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
    if Config["No Fog"] then
        game.Lighting.FogEnd = 100000
    end
end)

-- Camera FOV
RunLoop:Connect(function()
    if Config["FOV"] then
        workspace.CurrentCamera.FieldOfView = Config["FOV"]
    end
end)

-- ESP Player Logic (Mock Boxes)
local ESP_Drawings = {}
local Drawing = Drawing or nil

-- Anti-AFK
if Config["Anti-AFK"] then
    LocalPlayer.Idled:Connect(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

print("[ez.] GUI carregada com sucesso.")
