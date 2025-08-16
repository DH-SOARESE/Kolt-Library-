-- 🎨 KOLT UI Library - Modular (Tabs → Sections → Options)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local Library = {}
Library.__index = Library

-- Janela principal
function Library:CreateWindow(title, config)
    local Window = {}
    setmetatable(Window, Library)

    -- Gui principal
    Window.Gui = Instance.new("ScreenGui")
    Window.Gui.Name = "KoltUI"
    Window.Gui.Parent = player:WaitForChild("PlayerGui")

    -- Frame principal
    Window.Main = Instance.new("Frame")
    Window.Main.Size = config.Size or UDim2.new(0, 454, 0, 278)
    Window.Main.Position = UDim2.new(0.5, -227, 0.5, -139)
    Window.Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.Main.Parent = Window.Gui

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 24)
    Title.BackgroundTransparency = 1
    Title.Text = title or "KOLT UI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.Parent = Window.Main

    -- Tabs container
    Window.TabBar = Instance.new("Frame")
    Window.TabBar.Size = UDim2.new(1, 0, 0, 30)
    Window.TabBar.Position = UDim2.new(0, 0, 0, 24)
    Window.TabBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Window.TabBar.Parent = Window.Main

    local Layout = Instance.new("UIListLayout", Window.TabBar)
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.Padding = UDim.new(0, 5)

    Window.Tabs = {}
    return Window
end

-- Criar aba
function Library:CreateTab(name)
    local Tab = {}
    setmetatable(Tab, Library)

    Tab.Button = Instance.new("TextButton")
    Tab.Button.Size = UDim2.new(0, 80, 1, 0)
    Tab.Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab.Button.Text = name
    Tab.Button.Parent = self.TabBar

    Tab.Content = Instance.new("Frame")
    Tab.Content.Size = UDim2.new(1, 0, 1, -54)
    Tab.Content.Position = UDim2.new(0, 0, 0, 54)
    Tab.Content.BackgroundTransparency = 1
    Tab.Content.Visible = false
    Tab.Content.Parent = self.Main

    local Left = Instance.new("ScrollingFrame", Tab.Content)
    Left.Name = "Left"
    Left.Size = UDim2.new(0.5, -5, 1, 0)
    Left.CanvasSize = UDim2.new(0, 0, 0, 0)
    Left.BackgroundTransparency = 1
    Left.ScrollBarThickness = 4

    local Right = Instance.new("ScrollingFrame", Tab.Content)
    Right.Name = "Right"
    Right.Size = UDim2.new(0.5, -5, 1, 0)
    Right.Position = UDim2.new(0.5, 5, 0, 0)
    Right.CanvasSize = UDim2.new(0, 0, 0, 0)
    Right.BackgroundTransparency = 1
    Right.ScrollBarThickness = 4

    Tab.Sections = { Left = Left, Right = Right }

    Tab.Button.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Content.Visible = false
        end
        Tab.Content.Visible = true
    end)

    table.insert(self.Tabs, Tab)
    if #self.Tabs == 1 then
        Tab.Content.Visible = true
    end

    return Tab
end

-- Criar seção
function Library:CreateSection(name, side)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, -10, 0, 30)
    Section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 24)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 16
    Label.Parent = Section

    Section.Parent = self.Sections[side] or self.Sections.Left
    return setmetatable({ Frame = Section }, Library)
end

-- Adicionar botão
function Library:AddButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 28)
    Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = text
    Btn.Parent = self.Frame
    Btn.MouseButton1Click:Connect(callback)
end

-- Adicionar checkbox
function Library:AddCheckbox(text, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 28)
    Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Frame.Parent = self.Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -28, 1, 0)
    Label.Position = UDim2.new(0, 28, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Parent = Frame

    local Box = Instance.new("TextButton")
    Box.Size = UDim2.new(0, 24, 0, 24)
    Box.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    Box.Text = ""
    Box.Parent = Frame

    local state = default
    Box.MouseButton1Click:Connect(function()
        state = not state
        Box.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        if callback then callback(state) end
    end)
end

-- Adicionar slider
function Library:AddSlider(text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 36)
    Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Frame.Parent = self.Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 14)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 14
    Label.Parent = Frame

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -10, 0, 6)
    SliderBar.Position = UDim2.new(0, 5, 0, 20)
    SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderBar.Parent = Frame

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    Fill.Parent = SliderBar

    local dragging = false
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    SliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pct = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * pct)
            Fill.Size = UDim2.new(pct, 0, 1, 0)
            Label.Text = text .. ": " .. value
            if callback then callback(value) end
        end
    end)
end

return Library
