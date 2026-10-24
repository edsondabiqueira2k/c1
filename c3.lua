-- ez. | neverlose-style gui
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")

local player = Players.LocalPlayer

-- globals
_G.ez = {
	aimbot = false,
	aimFov = 100,
	aimSmooth = 0.2,
	boxESP = false,
	nameESP = false,
	walkSpeed = 16,
	jumpPower = 50,
	fly = false,
	noclip = false,
}

-- utility
local function makeCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = parent
	return corner
end

local function makeStroke(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(30, 30, 30)
	stroke.Thickness = thickness or 1
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
	return stroke
end

-- splash screen
local Splash = Instance.new("ScreenGui")
Splash.Name = "ezSplash"
Splash.ResetOnSpawn = false
Splash.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Splash.Parent = CoreGui

local SplashBg = Instance.new("Frame")
SplashBg.Size = UDim2.new(1, 0, 1, 0)
SplashBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SplashBg.BorderSizePixel = 0
SplashBg.Parent = Splash

local SplashText = Instance.new("TextLabel")
SplashText.Size = UDim2.new(0, 200, 0, 80)
SplashText.Position = UDim2.new(0.5, -100, 0.5, -40)
SplashText.BackgroundTransparency = 1
SplashText.Text = "ez."
SplashText.TextColor3 = Color3.fromRGB(255, 255, 255)
SplashText.TextSize = 64
SplashText.Font = Enum.Font.GothamBold
SplashText.Parent = SplashBg

task.wait(1.5)

SplashBg.BackgroundTransparency = 0
for i = 0, 1, 0.05 do
	SplashBg.BackgroundTransparency = i
	task.wait(0.02)
end

Splash:Destroy()

-- main gui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ezGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- toggle button (orb)
local ToggleOrb = Instance.new("TextButton")
ToggleOrb.Name = "ToggleOrb"
ToggleOrb.Size = UDim2.new(0, 50, 0, 50)
ToggleOrb.Position = UDim2.new(0, 20, 0, 20)
ToggleOrb.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleOrb.BorderSizePixel = 0
ToggleOrb.Text = ""
ToggleOrb.AutoButtonColor = false
ToggleOrb.Parent = ScreenGui

makeCorner(ToggleOrb, 25)
makeStroke(ToggleOrb, Color3.fromRGB(40, 40, 40), 2)

local OrbLabel = Instance.new("TextLabel")
OrbLabel.Size = UDim2.new(1, 0, 1, 0)
OrbLabel.BackgroundTransparency = 1
OrbLabel.Text = "ez"
OrbLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
OrbLabel.TextSize = 16
OrbLabel.Font = Enum.Font.GothamBold
OrbLabel.Parent = ToggleOrb

-- main frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 700, 0, 500)
Main.Position = UDim2.new(0.5, -350, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = true
Main.Parent = ScreenGui

makeCorner(Main, 0)
makeStroke(Main, Color3.fromRGB(25, 25, 25), 1)

-- sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.Position = UDim2.new(0, 0, 0, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarSep = Instance.new("Frame")
SidebarSep.Size = UDim2.new(0, 1, 1, 0)
SidebarSep.Position = UDim2.new(1, 0, 0, 0)
SidebarSep.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SidebarSep.BorderSizePixel = 0
SidebarSep.Parent = Sidebar

-- logo
local Logo = Instance.new("TextLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(1, 0, 0, 60)
Logo.Position = UDim2.new(0, 0, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "ez."
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextSize = 28
Logo.Font = Enum.Font.GothamBold
Logo.Parent = Sidebar

-- tab container
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, 0, 1, -80)
TabContainer.Position = UDim2.new(0, 0, 0, 70)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Sidebar

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 4)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabContainer

-- content container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -180, 1, 0)
ContentContainer.Position = UDim2.new(0, 180, 0, 0)
ContentContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ContentContainer.BorderSizePixel = 0
ContentContainer.ClipsDescendants = true
ContentContainer.Parent = Main

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Name = "Scroll"
ContentScroll.Size = UDim2.new(1, -20, 1, -20)
ContentScroll.Position = UDim2.new(0, 10, 0, 10)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 3
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentContainer

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentScroll

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ContentScroll.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- tab system
local tabs = {}
local currentTab = nil

local function createTab(name)
	local tabButton = Instance.new("TextButton")
	tabButton.Name = name
	tabButton.Size = UDim2.new(1, -20, 0, 35)
	tabButton.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	tabButton.BorderSizePixel = 0
	tabButton.Text = name
	tabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
	tabButton.TextSize = 14
	tabButton.Font = Enum.Font.GothamMedium
	tabButton.AutoButtonColor = false
	tabButton.Parent = TabContainer
	
	makeCorner(tabButton, 4)
	
	local tabContent = Instance.new("Folder")
	tabContent.Name = name .. "Content"
	tabContent.Parent = ContentScroll
	
	local function selectTab()
		for _, t in pairs(tabs) do
			t.button.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
			t.button.TextColor3 = Color3.fromRGB(150, 150, 150)
			for _, item in pairs(t.content:GetChildren()) do
				item.Visible = false
			end
		end
		
		tabButton.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
		tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		
		for _, item in pairs(tabContent:GetChildren()) do
			item.Visible = true
		end
		
		currentTab = name
	end
	
	tabButton.MouseButton1Click:Connect(selectTab)
	
	tabs[name] = {
		button = tabButton,
		content = tabContent,
		select = selectTab
	}
	
	return tabs[name]
end

-- element creators
local function createSection(tab, title)
	local section = Instance.new("Frame")
	section.Name = "Section_" .. title
	section.Size = UDim2.new(1, 0, 0, 25)
	section.BackgroundTransparency = 1
	section.Visible = false
	section.Parent = tab.content
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = title:upper()
	label.TextColor3 = Color3.fromRGB(80, 80, 80)
	label.TextSize = 11
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = section
	
	return section
end

local function createToggle(tab, title, default, callback)
	local toggle = Instance.new("Frame")
	toggle.Name = "Toggle_" .. title
	toggle.Size = UDim2.new(1, 0, 0, 35)
	toggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	toggle.BorderSizePixel = 0
	toggle.Visible = false
	toggle.Parent = tab.content
	
	makeCorner(toggle, 4)
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -50, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = title
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.TextSize = 13
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = toggle
	
	local checkbox = Instance.new("Frame")
	checkbox.Name = "Checkbox"
	checkbox.Size = UDim2.new(0, 18, 0, 18)
	checkbox.Position = UDim2.new(1, -30, 0.5, -9)
	checkbox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	checkbox.BorderSizePixel = 0
	checkbox.Parent = toggle
	
	makeCorner(checkbox, 3)
	makeStroke(checkbox, Color3.fromRGB(40, 40, 40), 1)
	
	local checkmark = Instance.new("TextLabel")
	checkmark.Size = UDim2.new(1, 0, 1, 0)
	checkmark.BackgroundTransparency = 1
	checkmark.Text = "✓"
	checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
	checkmark.TextSize = 14
	checkmark.Font = Enum.Font.GothamBold
	checkmark.Visible = false
	checkmark.Parent = checkbox
	
	local state = default or false
	
	local function updateToggle()
		if state then
			checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			checkmark.Visible = true
		else
			checkbox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			checkmark.Visible = false
		end
		if callback then callback(state) end
	end
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 1, 0)
	btn.BackgroundTransparency = 1
	btn.Text = ""
	btn.Parent = toggle
	
	btn.MouseButton1Click:Connect(function()
		state = not state
		updateToggle()
	end)
	
	updateToggle()
	
	return toggle
end

local function createSlider(tab, title, min, max, default, increment, callback)
	local slider = Instance.new("Frame")
	slider.Name = "Slider_" .. title
	slider.Size = UDim2.new(1, 0, 0, 45)
	slider.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	slider.BorderSizePixel = 0
	slider.Visible = false
	slider.Parent = tab.content
	
	makeCorner(slider, 4)
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.6, 0, 0, 18)
	label.Position = UDim2.new(0, 12, 0, 6)
	label.BackgroundTransparency = 1
	label.Text = title
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.TextSize = 13
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = slider
	
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 50, 0, 18)
	valueLabel.Position = UDim2.new(1, -62, 0, 6)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	valueLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	valueLabel.TextSize = 12
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = slider
	
	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(1, -24, 0, 3)
	sliderBg.Position = UDim2.new(0, 12, 1, -12)
	sliderBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = slider
	
	makeCorner(sliderBg, 2)
	
	local sliderFill = Instance.new("Frame")
	sliderFill.Name = "Fill"
	sliderFill.Size = UDim2.new(0, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg
	
	makeCorner(sliderFill, 2)
	
	local sliderBtn = Instance.new("TextButton")
	sliderBtn.Size = UDim2.new(1, 0, 1, 0)
	sliderBtn.BackgroundTransparency = 1
	sliderBtn.Text = ""
	sliderBtn.Parent = sliderBg
	
	local dragging = false
	local value = default
	
	local function updateSlider(input)
		local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
		value = math.floor((min + (max - min) * pos) / increment + 0.5) * increment
		value = math.clamp(value, min, max)
		
		local fillSize = (value - min) / (max - min)
		sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
		valueLabel.Text = tostring(value)
		
		if callback then callback(value) end
	end
	
	sliderBtn.MouseButton1Down:Connect(function()
		dragging = true
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateSlider(input)
		end
	end)
	
	sliderBtn.MouseButton1Click:Connect(function()
		local mousePos = UserInputService:GetMouseLocation()
		updateSlider({Position = Vector3.new(mousePos.X, mousePos.Y, 0)})
	end)
	
	local fillSize = (value - min) / (max - min)
	sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
	
	return slider
end

local function createButton(tab, title, callback)
	local button = Instance.new("TextButton")
	button.Name = "Button_" .. title
	button.Size = UDim2.new(1, 0, 0, 35)
	button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	button.BorderSizePixel = 0
	button.Text = title
	button.TextColor3 = Color3.fromRGB(200, 200, 200)
	button.TextSize = 13
	button.Font = Enum.Font.GothamMedium
	button.AutoButtonColor = false
	button.Visible = false
	button.Parent = tab.content
	
	makeCorner(button, 4)
	makeStroke(button, Color3.fromRGB(40, 40, 40), 1)
	
	button.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)
	
	return button
end

-- create tabs
local combatTab = createTab("Combat")
local playerTab = createTab("Player")
local clientTab = createTab("Client")
local ezTab = createTab("ez.")
local miscTab = createTab("Misc")

-- combat tab
createSection(combatTab, "aim")
createToggle(combatTab, "aimbot", false, function(v) _G.ez.aimbot = v print("aimbot:", v) end)
createSlider(combatTab, "fov", 20, 500, 100, 10, function(v) _G.ez.aimFov = v end)
createSlider(combatTab, "smoothing", 0, 1, 0.2, 0.05, function(v) _G.ez.aimSmooth = v end)

createSection(combatTab, "trigger")
createToggle(combatTab, "triggerbot", false, function(v) print("trigger:", v) end)
createSlider(combatTab, "delay (ms)", 0, 500, 50, 10, function(v) print("delay:", v) end)

-- player tab
createSection(playerTab, "movement")
createToggle(playerTab, "speed hack", false, function(v) _G.ez.speed = v end)
createSlider(playerTab, "walk speed", 16, 200, 16, 2, function(v) _G.ez.walkSpeed = v end)
createSlider(playerTab, "jump power", 50, 300, 50, 5, function(v) _G.ez.jumpPower = v end)

createSection(playerTab, "abilities")
createToggle(playerTab, "fly", false, function(v) _G.ez.fly = v end)
createToggle(playerTab, "noclip", false, function(v) _G.ez.noclip = v end)
createToggle(playerTab, "infinite jump", false, function(v) print("inf jump:", v) end)

-- client tab
createSection(clientTab, "esp")
createToggle(clientTab, "box esp", false, function(v) _G.ez.boxESP = v end)
createToggle(clientTab, "name esp", false, function(v) _G.ez.nameESP = v end)
createToggle(clientTab, "distance esp", false, function(v) print("distance esp:", v) end)
createToggle(clientTab, "health esp", false, function(v) print("health esp:", v) end)

createSection(clientTab, "world")
createToggle(clientTab, "fov circle", false, function(v) print("fov circle:", v) end)
createToggle(clientTab, "fullbright", false, function(v)
	if v then
		game.Lighting.Brightness = 2
		game.Lighting.ClockTime = 14
		game.Lighting.FogEnd = 100000
	else
		game.Lighting.Brightness = 1
		game.Lighting.ClockTime = 12
	end
end)

-- ez. tab
createSection(ezTab, "info")
createButton(ezTab, "respawn", function()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.Health = 0
	end
end)

createButton(ezTab, "destroy gui", function()
	ScreenGui:Destroy()
end)

-- misc tab
createSection(miscTab, "automation")
createToggle(miscTab, "auto farm", false, function(v) print("auto farm:", v) end)
createToggle(miscTab, "auto collect", false, function(v) print("auto collect:", v) end)

-- toggle visibility
local guiVisible = true
ToggleOrb.MouseButton1Click:Connect(function()
	guiVisible = not guiVisible
	Main.Visible = guiVisible
end)

-- dragging
local dragging = false
local dragInput, startPos, startMousePos

Sidebar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		startPos = Main.Position
		startMousePos = input.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - startMousePos
		Main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

-- auto-select first tab
task.wait(0.1)
combatTab.select()

print("ez. loaded")
