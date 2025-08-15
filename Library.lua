-- 🎨 KOLT UI Library
local Library = {}
Library.__index = Library

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CollectionService = game:GetService("CollectionService")

-- Função para criar a GUI principal
function Library:CreateUI()
    local ui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    ui.Name = "KOLT UI"
    ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    CollectionService:AddTag(ui, "main")

    -- Pasta de Features
    local features = Instance.new("Folder", ui)
    features.Name = "FEATURES"

    -- Menu principal
    local menu = Instance.new("Frame", ui)
    menu.Name = "MENU"
    menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menu.Size = UDim2.new(0, 454, 0, 278)
    menu.Position = UDim2.new(0, 100, 0, 20)

    -- Background dentro do Menu
    local bg = Instance.new("Frame", menu)
    bg.Name = "BACKGROUND"
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.Size = UDim2.new(0, 454, 0, 278)

    -- Title
    local title = Instance.new("Frame", menu)
    title.Name = "TITLE"
    title.Size = UDim2.new(0, 442, 0, 28)
    title.Position = UDim2.new(0, 6, 0, 4)
    title.BackgroundColor3 = Color3.fromRGB(0,0,0)
    local titleLabel = Instance.new("TextLabel", title)
    titleLabel.Size = UDim2.new(1,0,1,0)
    titleLabel.Text = "TITLE"
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Pasta de UI_FRAG (botões Show/Hide e Lock)
    local uiFrag = Instance.new("Folder", ui)
    uiFrag.Name = "UI_FRAG"

    local toggleBtn = Instance.new("TextButton", uiFrag)
    toggleBtn.Name = "Show/Hide"
    toggleBtn.Size = UDim2.new(0,86,0,32)
    toggleBtn.Position = UDim2.new(0,4,0,20)
    toggleBtn.Text = "TOGGLE UI"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 17

    local lockBtn = Instance.new("TextButton", uiFrag)
    lockBtn.Name = "Lock/Unlock"
    lockBtn.Size = UDim2.new(0,86,0,28)
    lockBtn.Position = UDim2.new(0,4,0,52)
    lockBtn.Text = "LOCK"
    lockBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    lockBtn.TextColor3 = Color3.fromRGB(255,255,255)
    lockBtn.Font = Enum.Font.GothamBold
    lockBtn.TextSize = 15

    -- Guardando referências
    self.UI = ui
    self.Menu = menu
    self.Features = features
    self.UI_FRAG = uiFrag

    return self
end

-- Função para criar uma nova Tab
function Library:AddTab(name)
    local tabFolder = Instance.new("Folder", self.Features)
    tabFolder.Name = name or "TAB"
    return tabFolder
end

-- Função para adicionar Section dentro de uma Tab
function Library:AddSection(tab, name)
    local section = Instance.new("Folder", tab)
    section.Name = name or "SECTION"
    return section
end

-- Função para adicionar Button
function Library:AddButton(section, name, callback)
    local btn = Instance.new("TextButton", section)
    btn.Size = UDim2.new(0,192,0,24)
    btn.Text = name or "BUTTON"
    btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return btn
end

-- Função para adicionar Checkbox
function Library:AddCheckbox(section, name, callback)
    local folder = Instance.new("Folder", section)
    folder.Name = name or "CHECKBOX"
    local frame = Instance.new("Frame", folder)
    frame.Size = UDim2.new(0,18,0,18)
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    local inner = Instance.new("Frame", frame)
    inner.Size = UDim2.new(0,14,0,14)
    inner.Position = UDim2.new(0,2,0,2)
    inner.BackgroundColor3 = Color3.fromRGB(0,0,255)
    inner.Visible = false

    local label = Instance.new("TextLabel", frame)
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0,22,0,0)
    label.Size = UDim2.new(0,166,0,18)

    frame.MouseButton1Click:Connect(function()
        inner.Visible = not inner.Visible
        if callback then callback(inner.Visible) end
    end)
    return frame
end

return Library
