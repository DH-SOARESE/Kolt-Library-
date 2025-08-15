-- 🎨 KOLT UI Library - Modular & Improved (OOP Style)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- =========================================================
-- 🎨 CONFIGURAÇÕES DE ESTILO
-- =========================================================
local MAIN_COLOR = Color3.fromRGB(0, 0, 0)
local ACCENT_COLOR = Color3.fromRGB(0, 0, 255)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local FONT = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)

-- =========================================================
-- 🛠 Funções Helpers
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
    scroll.ScrollBarThickness = 0 -- Invisível
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    return frame, scroll
end

-- =========================================================
-- 📦 CLASSES
-- =========================================================
local Library = {}
Library.__index = Library

local WindowClass = {}
WindowClass.__index = WindowClass

local TabClass = {}
TabClass.__index = TabClass

local GroupboxClass = {}
GroupboxClass.__index = GroupboxClass

-- =========================================================
-- 📂 Métodos da Library
-- =========================================================
function Library:CreateWindow(config)
    local selfLib = setmetatable({}, Library)

    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    selfLib.ScreenGui = screenGui

    local mainUI = createFrame(screenGui, UDim2.new(0, 454, 0, 278), UDim2.new(0.5, -227, 0.5, -139), "MAIN_UI")
    selfLib.MainUI = mainUI

    local titleFrame = createFrame(mainUI, UDim2.new(1, -12, 0, 28), UDim2.new(0, 6, 0, 4), "TITLE", true)
    local titleLabel = Instance.new("TextLabel", titleFrame)
    titleLabel.Size = UDim2.new(1, -4, 1, 0)
    titleLabel.Position = UDim2.new(0, 4, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title or "KOLT UI"
    titleLabel.TextColor3 = TEXT_COLOR
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.FontFace = FONT
    titleLabel.TextSize = 18

    local tabs = createFrame(mainUI, UDim2.new(1, -20, 0, 32), UDim2.new(0, 10, 0, 36), "TABS", true)
    local tabsFrame = Instance.new("ScrollingFrame", tabs)
    tabsFrame.Size = UDim2.new(1, -6, 1, -4)
    tabsFrame.Position = UDim2.new(0, 2, 0, 2)
    tabsFrame.BackgroundTransparency = 1
    tabsFrame.BorderSizePixel = 0
    tabsFrame.ScrollBarThickness = 0
    tabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.X

    selfLib.TabsFrame = tabsFrame
    selfLib.Tabs = {}
    selfLib.CurrentTab = nil

    return setmetatable(selfLib, WindowClass)
end

-- =========================================================
-- 📑 Métodos do Window
-- =========================================================
function WindowClass:AddTab(name)
    local tabData = setmetatable({}, TabClass)
    tabData.Name = name
    tabData.ParentWindow = self
    tabData.FeaturesLeft = {}
    tabData.FeaturesRight = {}

    local btn = createButton(self.TabsFrame, name, UDim2.new(0, 100, 0, 28), UDim2.new(0, #self.Tabs * 102, 0, 0))
    btn.MouseButton1Click:Connect(function()
        self:SelectTab(tabData)
    end)

    table.insert(self.Tabs, tabData)
    if not self.CurrentTab then
        self:SelectTab(tabData)
    end
    return tabData
end

function WindowClass:SelectTab(tab)
    self.CurrentTab = tab
    if self.LeftScroll then self.LeftScroll:ClearAllChildren() end
    if self.RightScroll then self.RightScroll:ClearAllChildren() end

    local leftFrame, leftScroll = createScrollingSection(self.MainUI, "Left", UDim2.new(0, 10, 0, 78), UDim2.new(0, 204, 0, 190))
    local rightFrame, rightScroll = createScrollingSection(self.MainUI, "Right", UDim2.new(0, 220, 0, 78), UDim2.new(0, 224, 0, 190))
    self.LeftScroll, self.RightScroll = leftScroll, rightScroll

    for _, func in ipairs(tab.FeaturesLeft) do func(leftScroll) end
    for _, func in ipairs(tab.FeaturesRight) do func(rightScroll) end
end

-- =========================================================
-- 📦 Métodos do Tab
-- =========================================================
function TabClass:AddLeftGroupbox(title)
    local group = setmetatable({}, GroupboxClass)
    group.Title = title
    group.Side = "Left"
    group.ParentTab = self

    table.insert(self.FeaturesLeft, function(parent)
        group:Render(parent)
    end)

    if self.ParentWindow.CurrentTab == self then
        self.ParentWindow:SelectTab(self)
    end

    return group
end

function TabClass:AddRightGroupbox(title)
    local group = setmetatable({}, GroupboxClass)
    group.Title = title
    group.Side = "Right"
    group.ParentTab = self

    table.insert(self.FeaturesRight, function(parent)
        group:Render(parent)
    end)

    if self.ParentWindow.CurrentTab == self then
        self.ParentWindow:SelectTab(self)
    end

    return group
end

-- =========================================================
-- 🧩 Métodos do Groupbox
-- =========================================================
function GroupboxClass:Render(parent)
    local frame = createFrame(parent, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "Groupbox", true)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -4, 0, 20)
    label.Position = UDim2.new(0, 4, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Title
    label.TextColor3 = TEXT_COLOR
    label.FontFace = FONT
    label.TextSize = 16
    self.Content = frame
end

function GroupboxClass:AddCheckbox(id, data)
    local cbFrame = createFrame(self.Content, UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 28))
    local label = Instance.new("TextLabel", cbFrame)
    label.Text = data.Text
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.new(0, 4, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = TEXT_COLOR
    label.FontFace = FONT
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = createFrame(cbFrame, UDim2.new(0, 20, 0, 20), UDim2.new(1, -24, 0, 2), "Box", true)
    local checked = data.Default or false
    box.BackgroundColor3 = checked and ACCENT_COLOR or MAIN_COLOR

    box.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            checked = not checked
            box.BackgroundColor3 = checked and ACCENT_COLOR or MAIN_COLOR
            if data.Callback then data.Callback(checked) end
        end
    end)
end

function GroupboxClass:AddButton(text, callback)
    local btn = createButton(self.Content, text, UDim2.new(1, -6, 0, 28), UDim2.new(0, 3, 0, 60))
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
end

function GroupboxClass:AddSlider(min, max, callback)
    local frame = createFrame(self.Content, UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 92))
    local bar = createFrame(frame, UDim2.new(1, 0, 0, 8), UDim2.new(0, 0, 0, 8))
    local knob = createFrame(bar, UDim2.new(0, 16, 0, 16), UDim2.new(0, 0, 0, -4))
    local dragging = false

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relX = math.clamp(input.Position.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
            knob.Position = UDim2.new(0, relX - 8, 0, -4)
            local value = min + (relX / bar.AbsoluteSize.X) * (max - min)
            if callback then callback(value) end
        end
    end)
end

-- =========================================================
-- 🔄 Retorna Library
-- =========================================================
return Library
