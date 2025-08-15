-- 🎨 KOLT UI Library - Modular & Improved (Touch + Horizontal Tabs + Modern Style)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local player = Players.LocalPlayer

-- 🎨 Theme
local MAIN_COLOR   = Color3.fromRGB(25, 25, 25)
local ACCENT_COLOR = Color3.fromRGB(0, 102, 255)
local TEXT_COLOR   = Color3.fromRGB(255, 255, 255)
local HOVER_COLOR  = Color3.fromRGB(40, 40, 40)
local FONT         = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)

-- Library
local KOLT_UI = {}
KOLT_UI.Config = {}

-- =========================================================
-- Helpers
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
    btn.AutoButtonColor = false
    btn.Parent = parent
    addStroke(btn, ACCENT_COLOR)

    -- Hover / Touch Feedback
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = HOVER_COLOR
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = MAIN_COLOR
    end)
    btn.TouchTap:Connect(function()
        btn.BackgroundColor3 = HOVER_COLOR
        task.delay(0.15, function()
            btn.BackgroundColor3 = MAIN_COLOR
        end)
    end)
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
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    return frame, scroll
end

-- =========================================================
-- Features
-- =========================================================
function KOLT_UI.CreateFeatureButton(parent, text, callback)
    local btn = createButton(parent, text, UDim2.new(1, -6, 0, 30), UDim2.new(0, 3, 0, 3))
    if callback then
        btn.MouseButton1Click:Connect(callback)
        btn.TouchTap:Connect(callback)
    end
    return btn
end

function KOLT_UI.CreateSlider(parent, min, max, callback)
    local frame = createFrame(parent, UDim2.new(1, 0, 0, 28), UDim2.new())
    frame.BackgroundTransparency = 1

    local bar = createFrame(frame, UDim2.new(1, -10, 0, 8), UDim2.new(0, 5, 0, 10))
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    local fill = createFrame(bar, UDim2.new(0, 0, 1, 0), UDim2.new())
    fill.BackgroundColor3 = ACCENT_COLOR

    local knob = createFrame(bar, UDim2.new(0, 16, 0, 16), UDim2.new(0, 0, 0, -4))
    knob.BackgroundColor3 = ACCENT_COLOR
    knob.ZIndex = 10

    local dragging = false

    local function updateSlider(inputX)
        local relX = math.clamp(inputX - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
        knob.Position = UDim2.new(0, relX - 8, 0, -4)
        fill.Size = UDim2.new(relX / bar.AbsoluteSize.X, 0, 1, 0)
        local value = min + (relX / bar.AbsoluteSize.X) * (max - min)
        if callback then callback(math.floor(value)) end
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input.Position.X)
        end
    end)

    return frame
end

-- =========================================================
-- UI Setup
-- =========================================================
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CollectionService:AddTag(screenGui, "main")
KOLT_UI.ScreenGui = screenGui

local uiFolder = Instance.new("Folder", screenGui)
uiFolder.Name = "UI_LS"

local mainUI = createFrame(screenGui, UDim2.new(0, 454, 0, 278), UDim2.new(0.3, 0, 0.2, 0), "MAIN_UI")

-- Inner BG
local bgInner = createFrame(mainUI, UDim2.new(0, 442, 0, 234), UDim2.new(0, 6, 0, 40), "BACKGROUND_INNER", true)

-- Title
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

-- Tabs (Horizontal scroll)
local tabs = createFrame(bgInner, UDim2.new(0, 434, 0, 32), UDim2.new(0, 4, 0, 4), "TABS", true)
local tabsFrame = Instance.new("ScrollingFrame", tabs)
tabsFrame.Size = UDim2.new(1, -6, 1, -4)
tabsFrame.Position = UDim2.new(0, 2, 0, 2)
tabsFrame.BackgroundTransparency = 1
tabsFrame.BorderSizePixel = 0
tabsFrame.ScrollBarThickness = 0 -- Invisível
tabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
tabsFrame.ScrollingDirection = Enum.ScrollingDirection.X -- Apenas horizontal

local tabsLayout = Instance.new("UIListLayout", tabsFrame)
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Padding = UDim.new(0, 2)

-- Sections
local leftSection, leftScroll = createScrollingSection(mainUI, "Left", UDim2.new(0, 10, 0, 78), UDim2.new(0, 204, 0, 190))
local rightSection, rightScroll = createScrollingSection(mainUI, "Right", UDim2.new(0, 220, 0, 78), UDim2.new(0, 224, 0, 190))

-- Layouts
Instance.new("UIListLayout", leftScroll).Padding = UDim.new(0, 5)
Instance.new("UIListLayout", rightScroll).Padding = UDim.new(0, 5)

-- =========================================================
-- Dragging (Mouse + Touch)
-- =========================================================
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    mainUI.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainUI.Position
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

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

return KOLT_UI
