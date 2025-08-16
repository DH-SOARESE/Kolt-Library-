-- Kolt UI Library
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")

local Library = {}
Library.__index = Library

-- Função principal: criar janela
function Library:CreateWindow(title)
    local self = setmetatable({}, Library)

    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KoltUI"
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    CollectionService:AddTag(screenGui, "main")
    self.Gui = screenGui

    -- Menu principal
    local menu = Instance.new("Frame")
    menu.Name = "Menu"
    menu.Size = UDim2.new(0, 454, 0, 278)
    menu.Position = UDim2.new(0.5, -227, 0.5, -139)
    menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menu.Parent = screenGui
    self.Menu = menu

    local titleFrame = Instance.new("Frame")
    titleFrame.Name = "Title"
    titleFrame.Size = UDim2.new(1, -12, 0, 28)
    titleFrame.Position = UDim2.new(0, 6, 0, 4)
    titleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleFrame.Parent = menu

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title or "Kolt UI"
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = titleFrame

    self.Tabs = {}

    return self
end

-- Criar Tab
function Library:CreateTab(tabName)
    local tab = {}
    tab.Sections = {}

    -- Container para a Tab
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = tabName
    tabFrame.Size = UDim2.new(1, -20, 1, -40)
    tabFrame.Position = UDim2.new(0, 10, 0, 40)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.Parent = self.Menu

    tab.Frame = tabFrame
    table.insert(self.Tabs, tab)

    -- Botão da Tab
    local button = Instance.new("TextButton")
    button.Text = tabName
    button.Size = UDim2.new(0, 100, 0, 28)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = self.Menu

    local index = #self.Tabs
    button.Position = UDim2.new(0, 10 + (index-1)*110, 0, 0)

    button.MouseButton1Click:Connect(function()
        for _, t in ipairs(self.Tabs) do
            t.Frame.Visible = false
        end
        tabFrame.Visible = true
    end)

    return tab
end

-- Criar Section
function Library:CreateSection(tab, sectionName)
    local section = {}
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Name = sectionName
    sectionFrame.Size = UDim2.new(1, -20, 0, 100)
    sectionFrame.Position = UDim2.new(0, 10, 0, #tab.Sections * 110)
    sectionFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    sectionFrame.Parent = tab.Frame

    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Text = sectionName
    sectionLabel.Size = UDim2.new(1, 0, 0, 20)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionLabel.Font = Enum.Font.GothamBold
    sectionLabel.Parent = sectionFrame

    section.Frame = sectionFrame
    table.insert(tab.Sections, section)

    -- Métodos da seção
    function section:AddButton(name, callback)
        local btn = Instance.new("TextButton")
        btn.Text = name
        btn.Size = UDim2.new(1, -10, 0, 28)
        btn.Position = UDim2.new(0, 5, 0, 25)
        btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Parent = sectionFrame
        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    function section:AddCheckbox(name, callback)
        local box = Instance.new("TextButton")
        box.Text = "[ ] " .. name
        box.Size = UDim2.new(1, -10, 0, 28)
        box.Position = UDim2.new(0, 5, 0, 60)
        box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Parent = sectionFrame

        local state = false
        box.MouseButton1Click:Connect(function()
            state = not state
            box.Text = (state and "[X] " or "[ ] ") .. name
            if callback then callback(state) end
        end)
    end

    function section:AddSlider(name, min, max, default, step, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, -10, 0, 40)
        sliderFrame.Position = UDim2.new(0, 5, 0, 95)
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Parent = sectionFrame

        local label = Instance.new("TextLabel")
        label.Text = name .. ": " .. tostring(default)
        label.Size = UDim2.new(1, 0, 0, 20)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Parent = sliderFrame

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, -20, 0, 6)
        bar.Position = UDim2.new(0, 10, 0, 25)
        bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        bar.Parent = sliderFrame

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        fill.Parent = bar

        local currentValue = default

        local function setValue(v)
            v = math.clamp(v, min, max)
            v = math.floor(v/step+0.5)*step
            currentValue = v
            fill.Size = UDim2.new((v-min)/(max-min), 0, 1, 0)
            label.Text = name .. ": " .. tostring(v)
            if callback then callback(v) end
        end

        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local mouse = UserInputService:GetMouseLocation().X
                local rel = (mouse - bar.AbsolutePosition.X)/bar.AbsoluteSize.X
                setValue(min + (max-min)*rel)
            end
        end)
    end

    return section
end

return Library
