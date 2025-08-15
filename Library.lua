-- 📦 KOLT UI Flat Library
-- Autor: DH_SOARES (Flat Design, sem bordas arredondadas)
-- Uso: local UI, Tabs = loadstring(game:HttpGet("link.lua"))()

local Library = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Cores padrão
local Theme = {
    Background = Color3.fromRGB(15, 15, 20),
    Section = Color3.fromRGB(18, 18, 25),
    Accent = Color3.fromRGB(0, 102, 255),
    Text = Color3.fromRGB(255, 255, 255)
}

-- Criar UI principal
function Library:CreateUI()
    local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Name = "KOLT_UI"

    local mainFrame = Instance.new("Frame", ScreenGui)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.Size = UDim2.new(0, 520, 0, 320)
    mainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)

    local mainStroke = Instance.new("UIStroke", mainFrame)
    mainStroke.Thickness = 2
    mainStroke.Color = Theme.Accent
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Dragging
    local dragging, dragLock = false, false
    local dragStart, startPos

    mainFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not dragLock then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- Barra de título
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    titleBar.Size = UDim2.new(1, 0, 0, 40)

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, -12, 1, 0)
    titleLabel.Position = UDim2.new(0, 6, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.Text = "KOLT UI"
    titleLabel.TextColor3 = Theme.Text
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local tabHolder = Instance.new("Frame", mainFrame)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Size = UDim2.new(1, -20, 0, 30)
    tabHolder.Position = UDim2.new(0, 10, 0, 45)

    local UIList = Instance.new("UIListLayout", tabHolder)
    UIList.FillDirection = Enum.FillDirection.Horizontal
    UIList.Padding = UDim.new(0, 8)

    local Tabs = {}
    Library._tabs = {}
    Library._mainFrame = mainFrame
    Library._tabHolder = tabHolder
    Library._contents = Tabs
    return ScreenGui, Tabs
end

-- Criar nova Tab
function Library:AddTab(name)
    local tabBtn = Instance.new("TextButton", self._tabHolder)
    tabBtn.Size = UDim2.new(0, 100, 1, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 14
    tabBtn.TextColor3 = Theme.Text
    tabBtn.Text = name

    local stroke = Instance.new("UIStroke", tabBtn)
    stroke.Thickness = 1.5
    stroke.Color = Theme.Accent
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local page = Instance.new("Frame", self._mainFrame)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, -20, 1, -85)
    page.Position = UDim2.new(0, 10, 0, 80)
    page.Visible = false

    local leftSection = Instance.new("Frame", page)
    leftSection.BackgroundColor3 = Theme.Section
    leftSection.Size = UDim2.new(0.48, 0, 1, 0)

    local rightSection = Instance.new("Frame", page)
    rightSection.BackgroundColor3 = Theme.Section
    rightSection.Size = UDim2.new(0.48, 0, 1, 0)
    rightSection.Position = UDim2.new(0.52, 0, 0, 0)

    local leftList = Instance.new("UIListLayout", leftSection)
    leftList.Padding = UDim.new(0, 6)
    leftList.FillDirection = Enum.FillDirection.Vertical

    local rightList = Instance.new("UIListLayout", rightSection)
    rightList.Padding = UDim.new(0, 6)
    rightList.FillDirection = Enum.FillDirection.Vertical

    self._tabs[tabBtn] = page
    self._contents[name] = {Left = leftSection, Right = rightSection}

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(self._tabs) do p.Visible = false end
        page.Visible = true
    end)

    return self._contents[name]
end

-- Criar Checkbox
function Library:AddCheckbox(parent, text, default, callback)
    local chk = Instance.new("TextButton", parent)
    chk.Size = UDim2.new(1, -10, 0, 28)
    chk.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    chk.Text = ""
    local stroke = Instance.new("UIStroke", chk)
    stroke.Color = Theme.Accent

    local label = Instance.new("TextLabel", chk)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text

    local state = default or false
    chk.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
    end)
end

-- Criar Slider
function Library:AddSlider(parent, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.Size = UDim2.new(1, -10, 0, 50)
    sliderFrame.BackgroundColor3 = Theme.Section

    local label = Instance.new("TextLabel", sliderFrame)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text

    local bar = Instance.new("Frame", sliderFrame)
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.new(0, 10, 0, 28)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.Accent

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local moveConn
            moveConn = UserInputService.InputChanged:Connect(function(moveInput)
                if moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                    local pct = math.clamp((moveInput.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    fill.Size = UDim2.new(pct, 0, 1, 0)
                    callback(math.floor(min + pct * (max - min)))
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    moveConn:Disconnect()
                end
            end)
        end
    end)
end

-- Criar Botão
function Library:AddButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Theme.Text
    btn.Text = text
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.Accent
    btn.MouseButton1Click:Connect(callback)
end

-- Criar Dropdown (multi ou single)
function Library:AddDropdown(parent, text, options, multi, callback)
    local ddFrame = Instance.new("Frame", parent)
    ddFrame.Size = UDim2.new(1, -10, 0, 28)
    ddFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

    local label = Instance.new("TextLabel", ddFrame)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text

    local selected = multi and {} or nil
    ddFrame.MouseButton1Click:Connect(function()
        for _, opt in ipairs(options) do
            callback(opt)
        end
    end)
end

return Library
