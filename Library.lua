-- 🎨 KOLT UI Library - Modular & Improved
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local player = Players.LocalPlayer

-- Constants
local MAIN_COLOR = Color3.fromRGB(0, 0, 0)
local ACCENT_COLOR = Color3.fromRGB(0, 0, 255)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local FONT = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)

-- Library Table
local KOLT_UI = {}
KOLT_UI.Config = {}

-- =========================================================
-- 🛠 Helpers
-- =========================================================
local function addStroke(inst, color, thickness)
local stroke = Instance.new("UIStroke", inst)
stroke.Color = color
stroke.Thickness = thickness or 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
return stroke
end

local function createFrame(parent, size, position, name, withStroke)
local frame = Instance.new("Frame")
frame.Size = size
frame.Position = position
frame.Name = name or ""
frame.BackgroundColor3 = MAIN_COLOR
frame.BorderSizePixel = 0
frame.Parent = parent
if withStroke then addStroke(frame, ACCENT_COLOR) end
return frame
end

local function createButton(parent, text, size, position)
local btn = Instance.new("TextButton")
btn.Size = size
btn.Position = position
btn.BackgroundColor3 = MAIN_COLOR
btn.BorderSizePixel = 0
btn.TextColor3 = TEXT_COLOR
btn.TextSize = 15
btn.FontFace = FONT
btn.Text = text
btn.TextYAlignment = Enum.TextYAlignment.Center
btn.ZIndex = 999
btn.Parent = parent
addStroke(btn, ACCENT_COLOR)
return btn
end

local function createScrollingSection(parent, name, position, size)
local frame = createFrame(parent, size, position, name, true)
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -4, 1, -4)
scroll.Position = UDim2.new(0, 2, 0, 2)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 0
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
return frame, scroll
end

-- =========================================================
-- 🎛 Feature Creators
-- =========================================================
function KOLT_UI.CreateFeatureButton(parent, text, callback)
local btn = createButton(parent, text, UDim2.new(1, -6, 0, 28), UDim2.new(0, 3, 0, 3))
if callback then
btn.MouseButton1Click:Connect(callback)
end
return btn
end

function KOLT_UI.CreateSlider(parent, min, max, callback)
local frame = createFrame(parent, UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 0))
local bar = createFrame(frame, UDim2.new(1, 0, 0, 8), UDim2.new(0, 0, 0, 8))
local knob = createFrame(bar, UDim2.new(0, 16, 0, 16), UDim2.new(0, 0, 0, -4))
local dragging = false

knob.InputBegan:Connect(function(input)    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end    
end)    
knob.InputEnded:Connect(function(input)    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end    
end)    
UserInputService.InputChanged:Connect(function(input)    
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then    
        local relX = math.clamp(input.Position.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)    
        knob.Position = UDim2.new(0, relX - 8, 0, -4)    
        local value = min + (relX / bar.AbsoluteSize.X) * (max - min)    
        if callback then callback(value) end    
    end    
end)    
return frame

end

-- =========================================================
-- 🖥 UI Setup
-- =========================================================
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CollectionService:AddTag(screenGui, "main")
KOLT_UI.ScreenGui = screenGui

local uiFolder = Instance.new("Folder", screenGui)
uiFolder.Name = "UI_LS"

-- Main UI container
local mainUI = createFrame(screenGui, UDim2.new(0, 454, 0, 278), UDim2.new(0, 138, 0, 6), "MAIN_UI")

-- Outer / Inner backgrounds
local bgOuter = createFrame(mainUI, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), "BACKGROUND_OUTER", true)
local bgInner = createFrame(bgOuter, UDim2.new(0, 442, 0, 234), UDim2.new(0, 6, 0, 40), "BACKGROUND_INNER", true)

-- Title Bar
local titleFrame = createFrame(mainUI, UDim2.new(0, 442, 0, 28), UDim2.new(0, 6, 0, 4), "TITLE", true)
local titleLabel = Instance.new("TextLabel", titleFrame)
titleLabel.Size = UDim2.new(1, -4, 1, 0)
titleLabel.Position = UDim2.new(0, 4, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "UI LIBRARY KOLT"
titleLabel.TextColor3 = TEXT_COLOR
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.FontFace = FONT
titleLabel.TextSize = 18

-- Tabs container
local tabs = createFrame(bgInner, UDim2.new(0, 434, 0, 32), UDim2.new(0, 4, 0, 4), "TABS", false)
local tabsFrame = Instance.new("ScrollingFrame", tabs)
tabsFrame.Size = UDim2.new(1, 0, 1, 0)
tabsFrame.Position = UDim2.new(0, 0, 0, 0)
tabsFrame.BackgroundTransparency = 1
tabsFrame.BorderSizePixel = 0
tabsFrame.ScrollBarThickness = 0
tabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
tabsFrame.ScrollingDirection = Enum.ScrollingDirection.X
local tabsLayout = Instance.new("UIListLayout", tabsFrame)
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Padding = UDim.new(0, 4)

-- Sections (Left / Right)
local leftSection, leftScroll = createScrollingSection(mainUI, "Left", UDim2.new(0, 10, 0, 78), UDim2.new(0, 204, 0, 190))
local rightSection, rightScroll = createScrollingSection(mainUI, "Right", UDim2.new(0, 220, 0, 78), UDim2.new(0, 224, 0, 190))
local leftLayout = Instance.new("UIListLayout", leftScroll)
leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
leftLayout.Padding = UDim.new(0, 5)
local rightLayout = Instance.new("UIListLayout", rightScroll)
rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
rightLayout.Padding = UDim.new(0, 5)

-- =========================================================
-- 📂 Tabs Manager
-- =========================================================
local TabsManager = { Tabs = {}, CurrentTab = nil }

function TabsManager:SelectTab(name)
self.CurrentTab = name
for _, scroll in pairs({ leftScroll, rightScroll }) do
for _, child in pairs(scroll:GetChildren()) do
if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
child:Destroy()
end
end
end
for _, tab in pairs(self.Tabs) do
if tab.Name == name then
for _, feat in pairs(tab.Features) do
feat.Func()
end
end
end
end

function KOLT_UI:CreateWindow(config)
titleLabel.Text = config.Title or "UI LIBRARY KOLT"
local window = {}
window.AddTab = function(self, name)
local btn = createButton(tabsFrame, name, UDim2.new(0, 100, 1, 0), UDim2.new(0, 0, 0, 0))
btn.MouseButton1Click:Connect(function()
TabsManager:SelectTab(name)
end)
local tab = { Name = name, Button = btn, Features = {} }
table.insert(TabsManager.Tabs, tab)
if not TabsManager.CurrentTab then TabsManager:SelectTab(name) end
local tabobj = {}
tabobj.AddLeftGroupbox = function(self, gname)
local group = { Name = gname, Elements = {} }
table.insert(tab.Features, {
Func = function()
local scroll = leftScroll
local gframe = createFrame(scroll, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "Groupbox", true)
local title = Instance.new("TextLabel", gframe)
title.Text = gname
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 5, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = TEXT_COLOR
title.FontFace = FONT
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
local container = Instance.new("Frame", gframe)
container.Size = UDim2.new(1, -10, 1, -25)
container.Position = UDim2.new(0, 5, 0, 20)
container.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", container)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
gframe.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y + 30)
end)
for _, elem in ipairs(group.Elements) do
elem(container)
end
end
})
local groupobj = {}
groupobj.AddButton = function(self, options)
local text = options.Text or "Button"
local callback = options.Callback or function() end
table.insert(group.Elements, function(cont)
local btn = createButton(cont, text, UDim2.new(1, 0, 0, 28), UDim2.new(0, 0, 0, 0))
btn.MouseButton1Click:Connect(callback)
end)
end
groupobj.AddCheckbox = function(self, key, options)
table.insert(group.Elements, function(cont)
local default = options.Default or false
local text = options.Text or "Checkbox"
local callback = options.Callback or function() end
local checked = KOLT_UI.Config[key] ~= nil and KOLT_UI.Config[key] or default
local frame = createFrame(cont, UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 0))
local label = Instance.new("TextLabel", frame)
label.Text = text
label.Size = UDim2.new(1, -30, 1, 0)
label.Position = UDim2.new(0, 4, 0, 0)
label.BackgroundTransparency = 1
label.TextColor3 = TEXT_COLOR
label.FontFace = FONT
label.TextSize = 15
label.TextXAlignment = Enum.TextXAlignment.Left
local box = createFrame(frame, UDim2.new(0, 20, 0, 20), UDim2.new(1, -24, 0, 2), "Box", true)
box.BackgroundColor3 = checked and ACCENT_COLOR or MAIN_COLOR
local checkmark = Instance.new("TextLabel", box)
checkmark.Size = UDim2.new(1, 0, 1, 0)
checkmark.BackgroundTransparency = 1
checkmark.Text = checked and "✔" or ""
checkmark.TextColor3 = TEXT_COLOR
checkmark.TextSize = 16
checkmark.Font = Enum.Font.SourceSansBold
checkmark.TextXAlignment = Enum.TextXAlignment.Center
checkmark.TextYAlignment = Enum.TextYAlignment.Center
box.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
checked = not checked
box.BackgroundColor3 = checked and ACCENT_COLOR or MAIN_COLOR
checkmark.Text = checked and "✔" or ""
KOLT_UI.Config[key] = checked
callback(checked)
end
end)
end)
end
groupobj.AddSlider = function(self, key, options)
local min = options.Min or 0
local max = options.Max or 100
local default = options.Default or min
local text = options.Text or "Slider"
local callback = options.Callback or function(v) end
local value = KOLT_UI.Config[key] ~= nil and KOLT_UI.Config[key] or default
table.insert(group.Elements, function(cont)
local frame = createFrame(cont, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0))
local label = Instance.new("TextLabel", frame)
label.Text = text
label.Size = UDim2.new(1, -50, 0, 20)
label.Position = UDim2.new(0, 4, 0, 0)
label.BackgroundTransparency = 1
label.TextColor3 = TEXT_COLOR
label.FontFace = FONT
label.TextSize = 15
label.TextXAlignment = Enum.TextXAlignment.Left
local valLabel = Instance.new("TextLabel", frame)
valLabel.Text = tostring(value)
valLabel.Size = UDim2.new(0, 50, 0, 20)
valLabel.Position = UDim2.new(1, -54, 0, 0)
valLabel.BackgroundTransparency = 1
valLabel.TextColor3 = TEXT_COLOR
valLabel.FontFace = FONT
valLabel.TextSize = 15
valLabel.TextXAlignment = Enum.TextXAlignment.Right
local sliderFrame = createFrame(frame, UDim2.new(1, -8, 0, 24), UDim2.new(0, 4, 0, 20))
local bar = createFrame(sliderFrame, UDim2.new(1, 0, 0, 8), UDim2.new(0, 0, 0, 8))
local knob = createFrame(bar, UDim2.new(0, 16, 0, 16), UDim2.new(0, 0, 0, -4))
local dragging = false
local relX = (value - min) / (max - min) * bar.AbsoluteSize.X
knob.Position = UDim2.new(0, relX - 8, 0, -4)
knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
end)
knob.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relX = math.clamp(input.Position.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
        knob.Position = UDim2.new(0, relX - 8, 0, -4)
        value = math.floor(min + (relX / bar.AbsoluteSize.X) * (max - min))
        valLabel.Text = tostring(value)
        KOLT_UI.Config[key] = value
        callback(value)
    end
end)
end)
end
return groupobj
end
tabobj.AddRightGroupbox = function(self, gname)
local group = { Name = gname, Elements = {} }
table.insert(tab.Features, {
Func = function()
local scroll = rightScroll
local gframe = createFrame(scroll, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "Groupbox", true)
local title = Instance.new("TextLabel", gframe)
title.Text = gname
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 5, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = TEXT_COLOR
title.FontFace = FONT
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
local container = Instance.new("Frame", gframe)
container.Size = UDim2.new(1, -10, 1, -25)
container.Position = UDim2.new(0, 5, 0, 20)
container.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", container)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
gframe.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y + 30)
end)
for _, elem in ipairs(group.Elements) do
elem(container)
end
end
})
local groupobj = {}
groupobj.AddButton = function(self, options)
local text = options.Text or "Button"
local callback = options.Callback or function() end
table.insert(group.Elements, function(cont)
local btn = createButton(cont, text, UDim2.new(1, 0, 0, 28), UDim2.new(0, 0, 0, 0))
btn.MouseButton1Click:Connect(callback)
end)
end
groupobj.AddCheckbox = function(self, key, options)
table.insert(group.Elements, function(cont)
local default = options.Default or false
local text = options.Text or "Checkbox"
local callback = options.Callback or function() end
local checked = KOLT_UI.Config[key] ~= nil and KOLT_UI.Config[key] or default
local frame = createFrame(cont, UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 0))
local label = Instance.new("TextLabel", frame)
label.Text = text
label.Size = UDim2.new(1, -30, 1, 0)
label.Position = UDim2.new(0, 4, 0, 0)
label.BackgroundTransparency = 1
label.TextColor3 = TEXT_COLOR
label.FontFace = FONT
label.TextSize = 15
label.TextXAlignment = Enum.TextXAlignment.Left
local box = createFrame(frame, UDim2.new(0, 20, 0, 20), UDim2.new(1, -24, 0, 2), "Box", true)
box.BackgroundColor3 = checked and ACCENT_COLOR or MAIN_COLOR
local checkmark = Instance.new("TextLabel", box)
checkmark.Size = UDim2.new(1, 0, 1, 0)
checkmark.BackgroundTransparency = 1
checkmark.Text = checked and "✔" or ""
checkmark.TextColor3 = TEXT_COLOR
checkmark.TextSize = 16
checkmark.Font = Enum.Font.SourceSansBold
checkmark.TextXAlignment = Enum.TextXAlignment.Center
checkmark.TextYAlignment = Enum.TextYAlignment.Center
box.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
checked = not checked
box.BackgroundColor3 = checked and ACCENT_COLOR or MAIN_COLOR
checkmark.Text = checked and "✔" or ""
KOLT_UI.Config[key] = checked
callback(checked)
end
end)
end)
end
groupobj.AddSlider = function(self, key, options)
local min = options.Min or 0
local max = options.Max or 100
local default = options.Default or min
local text = options.Text or "Slider"
local callback = options.Callback or function(v) end
local value = KOLT_UI.Config[key] ~= nil and KOLT_UI.Config[key] or default
table.insert(group.Elements, function(cont)
local frame = createFrame(cont, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0))
local label = Instance.new("TextLabel", frame)
label.Text = text
label.Size = UDim2.new(1, -50, 0, 20)
label.Position = UDim2.new(0, 4, 0, 0)
label.BackgroundTransparency = 1
label.TextColor3 = TEXT_COLOR
label.FontFace = FONT
label.TextSize = 15
label.TextXAlignment = Enum.TextXAlignment.Left
local valLabel = Instance.new("TextLabel", frame)
valLabel.Text = tostring(value)
valLabel.Size = UDim2.new(0, 50, 0, 20)
valLabel.Position = UDim2.new(1, -54, 0, 0)
valLabel.BackgroundTransparency = 1
valLabel.TextColor3 = TEXT_COLOR
valLabel.FontFace = FONT
valLabel.TextSize = 15
valLabel.TextXAlignment = Enum.TextXAlignment.Right
local sliderFrame = createFrame(frame, UDim2.new(1, -8, 0, 24), UDim2.new(0, 4, 0, 20))
local bar = createFrame(sliderFrame, UDim2.new(1, 0, 0, 8), UDim2.new(0, 0, 0, 8))
local knob = createFrame(bar, UDim2.new(0, 16, 0, 16), UDim2.new(0, 0, 0, -4))
local dragging = false
local relX = (value - min) / (max - min) * bar.AbsoluteSize.X
knob.Position = UDim2.new(0, relX - 8, 0, -4)
knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
end)
knob.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relX = math.clamp(input.Position.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
        knob.Position = UDim2.new(0, relX - 8, 0, -4)
        value = math.floor(min + (relX / bar.AbsoluteSize.X) * (max - min))
        valLabel.Text = tostring(value)
        KOLT_UI.Config[key] = value
        callback(value)
    end
end)
end)
end
return groupobj
end
return tabobj
end
return window
end

-- =========================================================
-- 🔒 Toggle & Drag (Mantidos fora das funções helpers)
-- =========================================================
local toggleButton = createButton(uiFolder, "TOGGLE UI", UDim2.new(0, 86, 0, 32), UDim2.new(0, 4, 0, 20))
local lockButton = createButton(uiFolder, "LOCK", UDim2.new(0, 86, 0, 28), UDim2.new(0, 4, 0, 52))
local locked = true

toggleButton.MouseButton1Click:Connect(function()
mainUI.Visible = not mainUI.Visible
end)

lockButton.MouseButton1Click:Connect(function()
locked = not locked
lockButton.Text = locked and "LOCK" or "UNLOCK"
end)

-- Drag logic
local dragging, dragInput, dragStart, startPos
local function update(input)
local delta = input.Position - dragStart
mainUI.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleFrame.InputBegan:Connect(function(input)
if locked then return end
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = mainUI.Position
local conn
conn = input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
conn:Disconnect()
end
end)
end
end)

titleFrame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)

UserInputService.InputChanged:Connect(function(input)
if dragging and input == dragInput then
update(input)
end
end)

-- Return Library
return KOLT_UI
