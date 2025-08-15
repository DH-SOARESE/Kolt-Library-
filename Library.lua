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
    btn.Parent = parent
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
    scroll.ScrollBarThickness = 0
    scroll.ScrollBarImageTransparency = 1
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
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
local toggleButton = createButton(uiFolder, "TOGGLE UI", UDim2.new(0,86,0,32), UDim2.new(0,4,0,20))
local lockButton = createButton(uiFolder, "LOCK", UDim2.new(0,86,0,28), UDim2.new(0,4,0,52))

-- Main UI container
local mainUI = createFrame(screenGui, UDim2.new(0,454,0,278), UDim2.new(0,138,0,6), "MAIN_UI")

-- Backgrounds
local bgOuter = createFrame(mainUI, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), "BACKGROUND_OUTER", true)
local bgInner = createFrame(bgOuter, UDim2.new(0,442,0,234), UDim2.new(0,6,0,40), "BACKGROUND_INNER", true)

-- Title
local titleFrame = createFrame(mainUI, UDim2.new(0,442,0,28), UDim2.new(0,6,0,4), "TITLE", true)
local titleLabel = Instance.new("TextLabel", titleFrame)
titleLabel.Size = UDim2.new(1, -4, 1, 0)
titleLabel.Position = UDim2.new(0,4,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "UI LIBRARY KOLT"
titleLabel.TextColor3 = TEXT_COLOR
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.FontFace = FONT
titleLabel.TextSize = 18

-- Tabs container
local tabs = createFrame(bgInner, UDim2.new(0,434,0,32), UDim2.new(0,4,0,4), "TABS", true)
local tabsFrame = Instance.new("ScrollingFrame", tabs)
tabsFrame.Size = UDim2.new(1, -6, 1, -4)
tabsFrame.Position = UDim2.new(0,2,0,2)
tabsFrame.BackgroundTransparency = 1
tabsFrame.BorderSizePixel = 0
tabsFrame.ScrollBarThickness = 0
tabsFrame.ScrollBarImageTransparency = 1
tabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.X

-- Sections
local leftSection, leftScroll = createScrollingSection(mainUI, "Left", UDim2.new(0,10,0,78), UDim2.new(0,204,0,190))
local rightSection, rightScroll = createScrollingSection(mainUI, "Right", UDim2.new(0,220,0,78), UDim2.new(0,224,0,190))

-- Tabs & Features Manager
local TabsManager = { Tabs = {}, CurrentTab = nil }

function TabsManager:AddTab(name)
    local btn = createButton(tabsFrame, name, UDim2.new(0,100,0,28), UDim2.new(0,0,0,0))
    btn.MouseButton1Click:Connect(function()
        self:SelectTab(name)
    end)
    table.insert(self.Tabs, {Name=name, Button=btn, Features={}})
    if not self.CurrentTab then self:SelectTab(name) end
    return btn
end

function TabsManager:SelectTab(name)
    self.CurrentTab = name
    for _, scroll in pairs({leftScroll, rightScroll}) do
        for _,child in pairs(scroll:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
    end
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
