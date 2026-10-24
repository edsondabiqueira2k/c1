local Library = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/raw/refs/heads/main/main.lua"))()

local Window = Library:CreateWindow({
    Title = "My Script",
    Footer = "v1.0.0",
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true
})

local HomeTab = Window:AddTab({
    Name = "Home",
    Description = "Welcome User!",
    Icon = "armchair"
})

local MainTab = Window:AddTab({
    Name = "Main",
    Description = "",
    Icon = "house"
})

local LeftGroupbox = MainTab:AddLeftGroupbox("Settings", "wrench")
local RightGroupbox = MainTab:AddRightGroupbox("Information", "info")
local LeftGroupbox1 = HomeTab:AddLeftGroupbox("Settings1", "wrench")
local RightGroupbox1 = HomeTab:AddRightGroupbox("Information1", "info")


-- Always capture the reference returned by AddToggle
local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Inf Speed",
    Default = false,
    Tooltip = "Its An Inf Speed",
    Callback = function(Value)
        print("Toggle changed to:", Value)
    end
})

-- You can also create checkboxes instead of switch-style toggles
local MyCheckbox = LeftGroupbox:AddCheckbox("MyCheckbox", {
    Text = "Example Checkbox",
    Default = false,
    Callback = function(Value)
        print("Checkbox changed to:", Value)
    end
})

local Label = RightGroupbox:AddLabel("Yes No Info")
local WrappedLabel = Groupbox:AddLabel({
    Text = "This is a wrapped label that will break into multiple lines",
    DoesWrap = true
})

-- Always capture the reference returned by AddToggle
local MyToggle = LeftGroupbox1:AddToggle("MyToggle", {
    Text = "Inf Speed",
    Default = false,
    Tooltip = "Its An Inf Speed",
    Callback = function(Value)
        print("Toggle changed to:", Value)
    end
})
