-- 🎨 KOLT UI Library - Modular & Improved (Mobile & Horizontal Tabs)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local player = Players.LocalPlayer

-- Constants
local MAIN_COLOR = Color3.fromRGB(30, 30, 30)
local ACCENT_COLOR = Color3.fromRGB(0, 170, 255)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local FONT = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
local ROUND_CORNER = UDim.new(0,6)

-- Library Table
local KOLT_UI = {}

-- Helper functions
local function addStroke(inst, color, thickness)
    local stroke = Instance.new("UIStroke", inst)
    stroke.Color = color
    stroke.Thickness = thickness or 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return stroke
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
    btn.AutoButtonColor = true
    btn.Parent = parent
    btn.ClipsDescendants = true
    addStroke(btn, ACCENT_COLOR)
    return btn
end

local function createFrame(parent, size, position, name, withStroke)
    local frame = Instance.new("Frame", parent)
    frame.Size = size
    frame.Position = position
    frame.Name = name or ""
    frame.BackgroundColor3 = MAIN_COLOR
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.AnchorPoint = Vector2.new(0,0)
    if withStroke then addStroke(frame, ACCENT_COLOR) end
    return frame
end

local function createScrollingSection(parent, name, position, size)
    local frame = createFrame(parent, size, position, name, true)
    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1, -4, 1, -4)
    scroll.Position = UDim2.new(0, 2, 0, 2)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 6
    scroll.ScrollBarImageTransparency = 0.7
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    return frame, scroll
end

-- ScreenGui
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CollectionService:AddTag(screenGui, "main")
KOLT_UI.ScreenGui = screenGui

-- UI Folder
local uiFolder = Instance.new("Folder", screenGui)
uiFolder.Name = "UI_LS"

-- Toggle & Lock buttons
local toggleButton = createButton(uiFolder, "TOGGLE UI", UDim2.new(0,100,0,36), UDim2.new(0,8,0,20))
local lockButton = createButton(uiFolder, "LOCK", UDim2.new(0,100,0,36), UDim2.new(0,8,0,64))

-- Main UI container
local mainUI = createFrame(screenGui, UDim2.new(0,480,0,300), UDim2.new(0,140,0,10), "MAIN_UI", true)

-- Backgrounds
local bgOuter = createFrame(mainUI, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), "BACKGROUND_OUTER", true)
local bgInner = createFrame(bgOuter, UDim2.new(0,460,0,250), UDim2.new(0,10,0,40), "BACKGROUND_INNER", true)

-- Title
local titleFrame = createFrame(mainUI, UDim2.new(0,460,0,32), UDim2.new(0,10,0,4), "TITLE", true)
local titleLabel = Instance.new("TextLabel", titleFrame)
titleLabel.Size = UDim2.new(1, -8, 1, 0)
titleLabel.Position = UDim2.new(0,4,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "KOLT UI LIBRARY"
titleLabel.TextColor3 = TEXT_COLOR
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.FontFace = FONT
titleLabel.TextSize = 20

-- Tabs container (horizontal scroll)
local tabs = createFrame(bgInner, UDim2.new(0,440,0,36), UDim2.new(0,10,0,4), "TABS", true)
local tabsFrame = Instance.new("ScrollingFrame", tabs)
tabsFrame.Size = UDim2.new(1, -4, 1, -4)
tabsFrame.Position = UDim2.new(0,2,0,2)
tabsFrame.BackgroundTransparency = 1
tabsFrame.BorderSizePixel = 0
tabsFrame.ScrollBarThickness = 6
tabsFrame.ScrollBarImageTransparency = 0.7
tabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
tabsFrame.ScrollBarImageColor3 = ACCENT_COLOR
tabsFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
tabsFrame.CanvasSize = UDim2.new(0,0,0,0)

-- Sections
local leftSection, leftScroll = createScrollingSection(mainUI, "Left", UDim2.new(0,10,0,80), UDim2.new(0,210,0,180))
local rightSection, rightScroll = createScrollingSection(mainUI, "Right", UDim2.new(0,230,0,80), UDim2.new(0,220,0,180))

-- Tabs & Features Manager
local TabsManager = { Tabs = {}, CurrentTab = nil }

function TabsManager:AddTab(name)
    local btn = createButton(tabsFrame, name, UDim2.new(0,100,0,28), UDim2.new(0,0,0,0))
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(function()
        self:SelectTab(name)
    end)
    table.insert(self.Tabs, {Name=name, Button=btn, Features={}})
    if not self.CurrentTab then self:SelectTab(name) end
    return btn
end

function TabsManager:SelectTab(name)
    self.CurrentTab = name
    -- Limpa sections
    for _, scroll in pairs({leftScroll, rightScroll}) do
        scroll:ClearAllChildren()
    end
    -- Adiciona features
    for _,tab in pairs(self.Tabs) do
        if tab.Name == name then
            for _,feat in pairs(tab.Features) do
                feat.Func()
            end
        end
    end
end

function TabsManager:AddFeature(tabName, parentSide, name, func)
    for _,tab in pairs(self.Tabs) do
        if tab.Name == tabName then
            table.insert(tab.Features, {Name=name, Func=function()
                func(parentSide=="Left" and leftScroll or rightScroll)
            end})
        end
    end
    if self.CurrentTab == tabName then self:SelectTab(tabName) end
end

-- Drag & Toggle
local locked = true
lockButton.MouseButton1Click:Connect(function()
    locked = not locked
    lockButton.Text = locked and "LOCK" or "UNLOCK"
end)
toggleButton.MouseButton1Click:Connect(function()
    mainUI.Visible = not mainUI.Visible
end)

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    mainUI.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
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

-- Expose TabsManager
KOLT_UI.Tabs = TabsManager

-- Return library
return KOLT_UI
