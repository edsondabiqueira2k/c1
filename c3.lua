-- ez. | standalone gui
-- sem dependências externas

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- globals
_G.ez = {
	aimbot = false,
	aimFov = 100,
	aimSmooth = 0.2,
	aimPart = "Head",
	boxESP = false,
	nameESP = false,
	distanceESP = false,
	healthESP = false,
	espColor = Color3.fromRGB(56, 189, 248),
	espDistance = 2000,
	speed = false,
	walkSpeed = 16,
	jumpPower = 50,
	fly = false,
	flySpeed = 50,
	noclip = false,
}

-- utility
local function tween(obj, props, time, style)
	TweenService:Create(obj, TweenInfo.new(time or 0.3, style or Enum.EasingStyle.Quart), props):Play()
end

local function makeCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 12)
	corner.Parent = parent
	return corner
end

local function makeStroke(parent, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(40, 40, 40)
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
	return stroke
end

local function makeGradient(parent, colors, rotation)
	local gradient = Instance.new("UIGradient")
	gradient.Color = colors or ColorSequence.new(Color3.fromRGB(255, 255, 255))
	gradient.Rotation = rotation or 0
	gradient.Parent = parent
	return gradient
end

-- gui container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ezGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- main frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 550, 0, 400)
Main.Position = UDim2.new(0.5, -275, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

makeCorner(Main, 16)
makeStroke(Main, Color3.fromRGB(35, 35, 35), 1.5, 0)

local MainShadow = Instance.new("ImageLabel")
MainShadow.Name = "Shadow"
MainShadow.Size = UDim2.new(1, 40, 1, 40)
MainShadow.Position = UDim2.new(0, -20, 0, -20)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxassetid://1316045217"
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ImageTransparency = 0.7
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(10, 10, 118, 118)
MainShadow.ZIndex = 0
MainShadow.Parent = Main

-- topbar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

makeCorner(TopBar, 16)

local TopBarBottom = Instance.new("Frame")
TopBarBottom.Size = UDim2.new(1, 0, 0, 16)
TopBarBottom.Position = UDim2.new(0, 0, 1, -16)
TopBarBottom.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBarBottom.BorderSizePixel = 0
TopBarBottom.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ez."
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(0, 200, 1, 0)
Subtitle.Position = UDim2.new(0, 60, 0, 0)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "universal"
Subtitle.TextColor3 = Color3.fromRGB(120, 120, 120)
Subtitle.TextSize = 14
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

-- close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "Close"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 24
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar

makeCorner(CloseBtn, 8)

CloseBtn.MouseEnter:Connect(function()
	tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}, 0.2)
end)
CloseBtn.MouseLeave:Connect(function()
	tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(26, 26, 26)}, 0.2)
end)
CloseBtn.MouseButton1Click:Connect(function()
	tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.4, Enum.EasingStyle.Exponential)
	task.wait(0.4)
	ScreenGui:Destroy()
end)

-- tabs container
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 140, 1, -70)
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Main

-- content container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -170, 1, -70)
ContentContainer.Position = UDim2.new(0, 160, 0, 60)
ContentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContentContainer.BorderSizePixel = 0
ContentContainer.ClipsDescendants = true
ContentContainer.Parent = Main

makeCorner(ContentContainer, 12)

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Name = "Scroll"
ContentScroll.Size = UDim2.new(1, -10, 1, -10)
ContentScroll.Position = UDim2.new(0, 5, 0, 5)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(56, 189, 248)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentContainer

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentScroll

ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ContentScroll.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
end)

-- tab system
local tabs = {}
local currentTab = nil

local function createTab(name, icon)
	local tabButton = Instance.new("TextButton")
	tabButton.Name = name
	tabButton.Size = UDim2.new(1, 0, 0, 40)
	tabButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	tabButton.BorderSizePixel = 0
	tabButton.Text = ""
	tabButton.AutoButtonColor = false
	tabButton.Parent = TabContainer
	
	makeCorner(tabButton, 10)
	
	local tabIcon = Instance.new("ImageLabel")
	tabIcon.Name = "Icon"
	tabIcon.Size = UDim2.new(0, 20, 0, 20)
	tabIcon.Position = UDim2.new(0, 12, 0.5, -10)
	tabIcon.BackgroundTransparency = 1
	tabIcon.Image = icon or ""
	tabIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
	tabIcon.Parent = tabButton
	
	local tabLabel = Instance.new("TextLabel")
	tabLabel.Name = "Label"
	tabLabel.Size = UDim2.new(1, -45, 1, 0)
	tabLabel.Position = UDim2.new(0, 40, 0, 0)
	tabLabel.BackgroundTransparency = 1
	tabLabel.Text = name
	tabLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	tabLabel.TextSize = 14
	tabLabel.Font = Enum.Font.GothamMedium
	tabLabel.TextXAlignment = Enum.TextXAlignment.Left
	tabLabel.Parent = tabButton
	
	local tabContent = Instance.new("Folder")
	tabContent.Name = name .. "Content"
	tabContent.Parent = ContentScroll
	
	local function selectTab()
		for _, t in pairs(tabs) do
			tween(t.button, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, 0.2)
			tween(t.icon, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
			tween(t.label, {TextColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
			for _, item in pairs(t.content:GetChildren()) do
				item.Visible = false
			end
		end
		
		tween(tabButton, {BackgroundColor3 = Color3.fromRGB(56, 189, 248)}, 0.2)
		tween(tabIcon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
		tween(tabLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
		
		for _, item in pairs(tabContent:GetChildren()) do
			item.Visible = true
		end
		
		currentTab = name
	end
	
	tabButton.MouseButton1Click:Connect(selectTab)
	
	tabButton.MouseEnter:Connect(function()
		if currentTab ~= name then
			tween(tabButton, {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}, 0.2)
		end
	end)
	
	tabButton.MouseLeave:Connect(function()
		if currentTab ~= name then
			tween(tabButton, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, 0.2)
		end
	end)
	
	tabs[name] = {
		button = tabButton,
		icon = tabIcon,
		label = tabLabel,
		content = tabContent,
		select = selectTab
	}
	
	return tabs[name]
end

-- element creators
local function createSection(tab, title)
	local section = Instance.new("Frame")
	section.Name = "Section_" .. title
	section.Size = UDim2.new(1, 0, 0, 30)
	section.BackgroundTransparency = 1
	section.Visible = false
	section.Parent = tab.content
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = title:upper()
	label.TextColor3 = Color3.fromRGB(100, 100, 100)
	label.TextSize = 12
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = section
	
	return section
end

local function createToggle(tab, title, default, callback)
	local toggle = Instance.new("Frame")
	toggle.Name = "Toggle_" .. title
	toggle.Size = UDim2.new(1, 0, 0, 40)
	toggle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	toggle.BorderSizePixel = 0
	toggle.Visible = false
	toggle.Parent = tab.content
	
	makeCorner(toggle, 10)
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 1, 0)
	label.Position = UDim2.new(0, 15, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = title
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.TextSize = 14
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = toggle
	
	local switchBg = Instance.new("Frame")
	switchBg.Name = "Switch"
	switchBg.Size = UDim2.new(0, 44, 0, 24)
	switchBg.Position = UDim2.new(1, -54, 0.5, -12)
	switchBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	switchBg.BorderSizePixel = 0
	switchBg.Parent = toggle
	
	makeCorner(switchBg, 12)
	
	local switchCircle = Instance.new("Frame")
	switchCircle.Name = "Circle"
	switchCircle.Size = UDim2.new(0, 18, 0, 18)
	switchCircle.Position = UDim2.new(0, 3, 0.5, -9)
	switchCircle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	switchCircle.BorderSizePixel = 0
	switchCircle.Parent = switchBg
	
	makeCorner(switchCircle, 9)
	
	local state = default or false
	
	local function updateToggle()
		if state then
			tween(switchBg, {BackgroundColor3 = Color3.fromRGB(56, 189, 248)}, 0.3)
			tween(switchCircle, {Position = UDim2.new(0, 23, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}, 0.3)
		else
			tween(switchBg, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.3)
			tween(switchCircle, {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.3)
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
	slider.Size = UDim2.new(1, 0, 0, 50)
	slider.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	slider.BorderSizePixel = 0
	slider.Visible = false
	slider.Parent = tab.content
	
	makeCorner(slider, 10)
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.6, 0, 0, 20)
	label.Position = UDim2.new(0, 15, 0, 8)
	label.BackgroundTransparency = 1
	label.Text = title
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.TextSize = 14
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = slider
	
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 60, 0, 20)
	valueLabel.Position = UDim2.new(1, -70, 0, 8)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	valueLabel.TextColor3 = Color3.fromRGB(56, 189, 248)
	valueLabel.TextSize = 13
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = slider
	
	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(1, -30, 0, 4)
	sliderBg.Position = UDim2.new(0, 15, 1, -14)
	sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = slider
	
	makeCorner(sliderBg, 2)
	
	local sliderFill = Instance.new("Frame")
	sliderFill.Name = "Fill"
	sliderFill.Size = UDim2.new(0, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg
	
	makeCorner(sliderFill, 2)
	
	local sliderBtn = Instance.new("TextButton")
	sliderBtn.Size = UDim2.new(1, 0, 1, 0)
	sliderBtn.Position = UDim2.new(0, 0, 0, 0)
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
		tween(sliderFill, {Size = UDim2.new(fillSize, 0, 1, 0)}, 0.1)
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
		updateSlider(UserInputService:GetMouseLocation())
	end)
	
	-- init
	local fillSize = (value - min) / (max - min)
	sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
	
	return slider
end

local function createButton(tab, title, callback)
	local button = Instance.new("TextButton")
	button.Name = "Button_" .. title
	button.Size = UDim2.new(1, 0, 0, 40)
	button.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
	button.BorderSizePixel = 0
	button.Text = title
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 14
	button.Font = Enum.Font.GothamBold
	button.AutoButtonColor = false
	button.Visible = false
	button.Parent = tab.content
	
	makeCorner(button, 10)
	
	button.MouseEnter:Connect(function()
		tween(button, {BackgroundColor3 = Color3.fromRGB(66, 199, 255)}, 0.2)
	end)
	
	button.MouseLeave:Connect(function()
		tween(button, {BackgroundColor3 = Color3.fromRGB(56, 189, 248)}, 0.2)
	end)
	
	button.MouseButton1Click:Connect(function()
		tween(button, {Size = UDim2.new(1, -4, 0, 38)}, 0.1)
		task.wait(0.1)
		tween(button, {Size = UDim2.new(1, 0, 0, 40)}, 0.1)
		if callback then callback() end
	end)
	
	return button
end

-- create tabs
local combatTab = createTab("combat", "rbxassetid://10734950309")
local visualTab = createTab("visual", "rbxassetid://10747372992")
local movementTab = createTab("movement", "rbxassetid://10723407389")
local miscTab = createTab("misc", "rbxassetid://10723343321")

-- combat tab
createSection(combatTab, "aim")
createToggle(combatTab, "aimbot", false, function(v) _G.ez.aimbot = v end)
createSlider(combatTab, "fov", 20, 500, 100, 10, function(v) _G.ez.aimFov = v end)
createSlider(combatTab, "smoothing", 0, 1, 0.2, 0.05, function(v) _G.ez.aimSmooth = v end)

createSection(combatTab, "trigger")
createToggle(combatTab, "triggerbot", false, function(v) print("trigger:", v) end)
createSlider(combatTab, "delay (ms)", 0, 500, 50, 10, function(v) print("delay:", v) end)

-- visual tab
createSection(visualTab, "esp")
createToggle(visualTab, "box esp", false, function(v) _G.ez.boxESP = v end)
createToggle(visualTab, "name esp", false, function(v) _G.ez.nameESP = v end)
createToggle(visualTab, "distance esp", false, function(v) _G.ez.distanceESP = v end)
createToggle(visualTab, "health esp", false, function(v) _G.ez.healthESP = v end)

createSection(visualTab, "world")
createToggle(visualTab, "fov circle", false, function(v) print("fov circle:", v) end)
createToggle(visualTab, "fullbright", false, function(v)
	if v then
		game.Lighting.Brightness = 2
		game.Lighting.ClockTime = 14
		game.Lighting.FogEnd = 100000
	else
		game.Lighting.Brightness = 1
		game.Lighting.ClockTime = 12
		game.Lighting.FogEnd = 100000
	end
end)

-- movement tab
createSection(movementTab, "speed")
createToggle(movementTab, "speed hack", false, function(v) _G.ez.speed = v end)
createSlider(movementTab, "walk speed", 16, 200, 16, 2, function(v) _G.ez.walkSpeed = v end)
createSlider(movementTab, "jump power", 50, 300, 50, 5, function(v) _G.ez.jumpPower = v end)

createSection(movementTab, "flight")
createToggle(movementTab, "fly", false, function(v) _G.ez.fly = v end)
createSlider(movementTab, "fly speed", 10, 200, 50, 5, function(v) _G.ez.flySpeed = v end)

createSection(movementTab, "other")
createToggle(movementTab, "noclip", false, function(v) _G.ez.noclip = v end)
createToggle(movementTab, "infinite jump", false, function(v) print("inf jump:", v) end)

-- misc tab
createSection(miscTab, "player")
createButton(miscTab, "respawn", function()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.Health = 0
	end
end)

createButton(miscTab, "destroy gui", function()
	tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.4, Enum.EasingStyle.Exponential)
	task.wait(0.4)
	ScreenGui:Destroy()
end)

-- auto-select first tab
task.wait(0.1)
combatTab.select()

-- dragging
local dragging = false
local dragInput, startPos, startMousePos

TopBar.InputBegan:Connect(function(input)
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

-- intro animation
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
MainShadow.ImageTransparency = 1

task.wait(0.2)
tween(Main, {Size = UDim2.new(0, 550, 0, 400)}, 0.6, Enum.EasingStyle.Exponential)
tween(Main, {Position = UDim2.new(0.5, -275, 0.5, -200)}, 0.6, Enum.EasingStyle.Exponential)
tween(MainShadow, {ImageTransparency = 0.7}, 0.6)

print("ez. gui loaded")
