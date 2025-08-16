--[[
  --Kolt UI library V1.0
]]--


local KoltUI = {}

-- Services
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Main UI creation
function KoltUI.Create()
    local self = {}
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Ui Kolt"
    screenGui.DisplayOrder = 2147483647
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    CollectionService:AddTag(screenGui, "main")

    -- Create features folder
    local featuresFolder = Instance.new("Folder")
    featuresFolder.Name = "Feature"
    featuresFolder.Parent = screenGui

    -- Create UI folder
    local uiFolder = Instance.new("Folder")
    uiFolder.Name = "UI"
    uiFolder.Parent = screenGui

    -- Create menu frame
    local menu = Instance.new("Frame")
    menu.Name = "MENU"
    menu.ZIndex = 6
    menu.BorderSizePixel = 0
    menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menu.Size = UDim2.new(0, 454, 0, 278)
    menu.Position = UDim2.new(0, 98, 0, 20)
    menu.Parent = uiFolder

    -- Menu background
    local menuBackground = Instance.new("Frame")
    menuBackground.Name = "BACKGROUND"
    menuBackground.BorderSizePixel = 0
    menuBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuBackground.Size = UDim2.new(0, 454, 0, 278)
    menuBackground.Parent = menu

    -- Inner background
    local innerBackground = Instance.new("Frame")
    innerBackground.Name = "BACKGROUND"
    innerBackground.BorderSizePixel = 0
    innerBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    innerBackground.Size = UDim2.new(0, 442, 0, 234)
    innerBackground.Position = UDim2.new(0, 6, 0, 40)
    innerBackground.Parent = menuBackground

    -- Tabs frame
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Name = "TABs"
    tabsFrame.BorderSizePixel = 0
    tabsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tabsFrame.Size = UDim2.new(0, 434, 0, 32)
    tabsFrame.Position = UDim2.new(0, 4, 0, 4)
    tabsFrame.Parent = innerBackground

    -- Scroll tabs
    local scrollTabs = Instance.new("ScrollingFrame")
    scrollTabs.Name = "Scrolli Tabs"
    scrollTabs.ScrollingDirection = Enum.ScrollingDirection.X
    scrollTabs.BorderSizePixel = 0
    scrollTabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    scrollTabs.BackgroundTransparency = 1
    scrollTabs.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    scrollTabs.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    scrollTabs.AutomaticCanvasSize = Enum.AutomaticSize.X
    scrollTabs.AutomaticSize = Enum.AutomaticSize.X
    scrollTabs.Size = UDim2.new(0, 418, 0, 28)
    scrollTabs.Position = UDim2.new(0, 2, 0, 2)
    scrollTabs.Parent = tabsFrame

    -- UI strokes
    local tabsStroke = Instance.new("UIStroke")
    tabsStroke.Color = Color3.fromRGB(0, 0, 255)
    tabsStroke.Parent = tabsFrame

    local innerBackgroundStroke = Instance.new("UIStroke")
    innerBackgroundStroke.Color = Color3.fromRGB(0, 0, 255)
    innerBackgroundStroke.Parent = innerBackground

    local menuBackgroundStroke = Instance.new("UIStroke")
    menuBackgroundStroke.Color = Color3.fromRGB(0, 0, 255)
    menuBackgroundStroke.Parent = menuBackground

    -- Right frame
    local rightFrame = Instance.new("Frame")
    rightFrame.Name = "Right"
    rightFrame.ZIndex = 6
    rightFrame.BorderSizePixel = 0
    rightFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    rightFrame.Size = UDim2.new(0, 214, 0, 190)
    rightFrame.Position = UDim2.new(0, 230, 0, 80)
    rightFrame.Parent = menu

    local rightScroll = Instance.new("ScrollingFrame")
    rightScroll.Name = "Scroll Left"
    rightScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    rightScroll.BorderSizePixel = 0
    rightScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    rightScroll.BackgroundTransparency = 1
    rightScroll.ScrollBarImageTransparency = 1
    rightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    rightScroll.Size = UDim2.new(0, 214, 0, 190)
    rightScroll.Parent = rightFrame

    local rightStroke = Instance.new("UIStroke")
    rightStroke.Color = Color3.fromRGB(0, 0, 255)
    rightStroke.Parent = rightFrame

    -- Left frame
    local leftFrame = Instance.new("Frame")
    leftFrame.Name = "Left"
    leftFrame.ZIndex = 6
    leftFrame.BorderSizePixel = 0
    leftFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    leftFrame.Size = UDim2.new(0, 214, 0, 190)
    leftFrame.Position = UDim2.new(0, 10, 0, 80)
    leftFrame.Parent = menu

    local leftScroll = Instance.new("ScrollingFrame")
    leftScroll.Name = "Scroll Left"
    leftScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    leftScroll.BorderSizePixel = 0
    leftScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    leftScroll.BackgroundTransparency = 1
    leftScroll.ScrollBarImageTransparency = 1
    leftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    leftScroll.Size = UDim2.new(0, 214, 0, 190)
    leftScroll.CanvasPosition = Vector2.new(0, 18.0017)
    leftScroll.Parent = leftFrame

    local leftStroke = Instance.new("UIStroke")
    leftStroke.Color = Color3.fromRGB(0, 0, 255)
    leftStroke.Parent = leftFrame

    -- Title frame
    local titleFrame = Instance.new("Frame")
    titleFrame.Name = "Title"
    titleFrame.BorderSizePixel = 0
    titleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleFrame.Size = UDim2.new(0, 442, 0, 28)
    titleFrame.Position = UDim2.new(0, 6, 0, 4)
    titleFrame.Parent = menu

    local titleLabel = Instance.new("TextLabel")
    titleLabel.BorderSizePixel = 0
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Size = UDim2.new(0, 438, 0, 28)
    titleLabel.Text = "Kolt UI Title"
    titleLabel.Position = UDim2.new(0, 4, 0, 0)
    titleLabel.Parent = titleFrame

    local titleStroke = Instance.new("UIStroke")
    titleStroke.Color = Color3.fromRGB(0, 0, 255)
    titleStroke.Parent = titleFrame

    -- UI Open/Lock
    local uiOpenLockFolder = Instance.new("Folder")
    uiOpenLockFolder.Name = "UI OPEN/LOCK"
    uiOpenLockFolder.Parent = screenGui

    local openLockBackground = Instance.new("Frame")
    openLockBackground.Name = "BACKGROUND"
    openLockBackground.ZIndex = 998
    openLockBackground.BorderSizePixel = 0
    openLockBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    openLockBackground.Size = UDim2.new(0, 96, 0, 70)
    openLockBackground.Position = UDim2.new(0, -2, 0, 16)
    openLockBackground.Parent = uiOpenLockFolder

    -- Toggle UI button
    local showHideButton = Instance.new("TextButton")
    showHideButton.Name = "Show/Hide"
    showHideButton.BorderSizePixel = 0
    showHideButton.TextSize = 17
    showHideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    showHideButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    showHideButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    showHideButton.ZIndex = 999
    showHideButton.Size = UDim2.new(0, 86, 0, 30)
    showHideButton.Text = "Toggle UI"
    showHideButton.Position = UDim2.new(0, 4, 0, 20)
    showHideButton.Parent = uiOpenLockFolder

    local showHideStroke = Instance.new("UIStroke")
    showHideStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    showHideStroke.Thickness = 2
    showHideStroke.Color = Color3.fromRGB(0, 0, 255)
    showHideStroke.Parent = showHideButton

    -- Lock/Unlock button
    local lockUnlockButton = Instance.new("TextButton")
    lockUnlockButton.Name = "Lock/Unlock"
    lockUnlockButton.BorderSizePixel = 0
    lockUnlockButton.TextSize = 20
    lockUnlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    lockUnlockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    lockUnlockButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    lockUnlockButton.ZIndex = 999
    lockUnlockButton.Size = UDim2.new(0, 86, 0, 30)
    lockUnlockButton.Text = "Lock"
    lockUnlockButton.Position = UDim2.new(0, 4, 0, 52)
    lockUnlockButton.Parent = uiOpenLockFolder

    local lockUnlockStroke = Instance.new("UIStroke")
    lockUnlockStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    lockUnlockStroke.Thickness = 2
    lockUnlockStroke.Color = Color3.fromRGB(0, 0, 255)
    lockUnlockStroke.Parent = lockUnlockButton

    -- UI toggle functionality
    showHideButton.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
    end)

    -- Lock functionality
    local isLocked = false
    lockUnlockButton.MouseButton1Click:Connect(function()
        isLocked = not isLocked
        lockUnlockButton.Text = isLocked and "Unlock" or "Lock"
        menu.Active = not isLocked
        menu.Draggable = not isLocked
    end)

    -- Public methods
    function self.NewTab(name)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name
        tabButton.BorderSizePixel = 0
        tabButton.TextSize = 15
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
        tabButton.ZIndex = 10
        tabButton.Size = UDim2.new(0, 48, 0, 20)
        tabButton.Text = name
        tabButton.Parent = scrollTabs
        
        local tabButtonStroke = Instance.new("UIStroke")
        tabButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        tabButtonStroke.Thickness = 2
        tabButtonStroke.Color = Color3.fromRGB(0, 0, 255)
        tabButtonStroke.Parent = tabButton
        
        return tabButton
    end

    function self.NewSection(name, parentFrame)
        local sectionFolder = Instance.new("Folder")
        sectionFolder.Name = "Groupboxes"
        sectionFolder.Parent = featuresFolder

        local container = Instance.new("Frame")
        container.Name = name
        container.ZIndex = 9
        container.BorderSizePixel = 0
        container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        container.BackgroundTransparency = 1
        container.Size = UDim2.new(0, 206, 0, 84)
        container.Position = UDim2.new(0, 112, 0, 104)
        container.Parent = parentFrame or leftScroll

        local sectionName = Instance.new("TextLabel")
        sectionName.Name = "Name"
        sectionName.ZIndex = 11
        sectionName.BorderSizePixel = 0
        sectionName.TextSize = 12
        sectionName.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        sectionName.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
        sectionName.TextColor3 = Color3.fromRGB(255, 255, 255)
        sectionName.Size = UDim2.new(0, 40, 0, 8)
        sectionName.Text = name
        sectionName.Position = UDim2.new(0, 14, 0, -4)
        sectionName.Parent = container

        local sectionStroke = Instance.new("UIStroke")
        sectionStroke.Color = Color3.fromRGB(0, 0, 255)
        sectionStroke.Parent = container
        
        return container
    end

    function self.NewButton(name, parent, callback)
        local buttonFolder = Instance.new("Folder")
        buttonFolder.Name = "Button"
        buttonFolder.Parent = featuresFolder

        local textButton = Instance.new("TextButton")
        textButton.TextWrapped = true
        textButton.BorderSizePixel = 0
        textButton.TextSize = 12
        textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        textButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        textButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
        textButton.ZIndex = 11
        textButton.Size = UDim2.new(0, 198, 0, 20)
        textButton.Text = name
        textButton.Position = UDim2.new(0, 116, 0, 164)
        textButton.Parent = parent

        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        buttonStroke.Thickness = 0.9
        buttonStroke.Color = Color3.fromRGB(0, 0, 255)
        buttonStroke.Parent = textButton
        
        if callback then
            textButton.MouseButton1Click:Connect(callback)
        end
        
        return textButton
    end

    function self.NewCheckbox(name, parent, callback)
        local checkboxFolder = Instance.new("Folder")
        checkboxFolder.Name = "Checkbox"
        checkboxFolder.Parent = featuresFolder

        local checkboxBackground = Instance.new("Frame")
        checkboxBackground.Name = "Background"
        checkboxBackground.ZIndex = 11
        checkboxBackground.BorderSizePixel = 0
        checkboxBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        checkboxBackground.Size = UDim2.new(0, 18, 0, 18)
        checkboxBackground.Position = UDim2.new(0, 116, 0, 141)
        checkboxBackground.Parent = parent

        local offFrame = Instance.new("Frame")
        offFrame.Name = "OFF"
        offFrame.BorderSizePixel = 0
        offFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        offFrame.BackgroundTransparency = 1
        offFrame.Size = UDim2.new(0, 14, 0, 14)
        offFrame.Position = UDim2.new(0, 2, 0, 2)
        offFrame.Parent = checkboxBackground

        local offCorner = Instance.new("UICorner")
        offCorner.CornerRadius = UDim.new(0, 2)
        offCorner.Parent = offFrame

        local offStroke = Instance.new("UIStroke")
        offStroke.Color = Color3.fromRGB(0, 0, 255)
        offStroke.Parent = offFrame

        local onFrame = Instance.new("Frame")
        onFrame.Name = "ON"
        onFrame.Visible = false
        onFrame.BorderSizePixel = 0
        onFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        onFrame.Size = UDim2.new(0, 14, 0, 14)
        onFrame.Position = UDim2.new(0, 2, 0, 2)
        onFrame.Parent = checkboxBackground

        local onCorner = Instance.new("UICorner")
        onCorner.CornerRadius = UDim.new(0, 2)
        onCorner.Parent = onFrame

        local checkboxLabel = Instance.new("TextLabel")
        checkboxLabel.BorderSizePixel = 0
        checkboxLabel.TextSize = 12
        checkboxLabel.TextXAlignment = Enum.TextXAlignment.Left
        checkboxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        checkboxLabel.BackgroundTransparency = 1
        checkboxLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
        checkboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        checkboxLabel.Size = UDim2.new(0, 178, 0, 18)
        checkboxLabel.Text = name
        checkboxLabel.Position = UDim2.new(0, 22, 0, 0)
        checkboxLabel.Parent = checkboxBackground

        local checkboxStroke = Instance.new("UIStroke")
        checkboxStroke.Color = Color3.fromRGB(0, 0, 255)
        checkboxStroke.Parent = checkboxBackground

        local isChecked = false
        
        checkboxBackground.MouseButton1Click:Connect(function()
            isChecked = not isChecked
            onFrame.Visible = isChecked
            offFrame.Visible = not isChecked
            
            if callback then
                callback(isChecked)
            end
        end)
        
        return {
            SetValue = function(value)
                isChecked = value
                onFrame.Visible = value
                offFrame.Visible = not value
            end,
            GetValue = function()
                return isChecked
            end
        }
    end

    function self.NewSlider(name, parent, min, max, default, rounding, callback)
        local sliderFolder = Instance.new("Folder")
        sliderFolder.Name = "Slider"
        sliderFolder.Parent = featuresFolder

        local sliderBackground = Instance.new("Frame")
        sliderBackground.Name = "BACKGROUND"
        sliderBackground.ZIndex = 11
        sliderBackground.BorderSizePixel = 0
        sliderBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        sliderBackground.Size = UDim2.new(0, 198, 0, 20)
        sliderBackground.Position = UDim2.new(0, 0, 0, 0)
        sliderBackground.Parent = parent

        local progressBar = Instance.new("Frame")
        progressBar.Name = "ProgressBar"
        progressBar.BorderSizePixel = 0
        progressBar.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        progressBar.Size = UDim2.new(0, 0, 0, 16)
        progressBar.Position = UDim2.new(0, 2, 0, 2)
        progressBar.Parent = sliderBackground

        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "Value"
        valueLabel.BorderSizePixel = 0
        valueLabel.TextSize = 12
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        valueLabel.BackgroundTransparency = 1
        valueLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
        valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        valueLabel.Size = UDim2.new(1, -4, 1, 0)
        valueLabel.Text = "0 / 100"
        valueLabel.Parent = sliderBackground

        local nameLabel = Instance.new("TextLabel")
        nameLabel.BorderSizePixel = 0
        nameLabel.TextSize = 12
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.BackgroundTransparency = 1
        nameLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.Size = UDim2.new(0, 100, 1, 0)
        nameLabel.Text = name
        nameLabel.Parent = sliderBackground

        local sliderStroke = Instance.new("UIStroke")
        sliderStroke.Color = Color3.fromRGB(0, 0, 255)
        sliderStroke.Parent = sliderBackground

        local Min = min or 0
        local Max = max or 100
        local Default = default or 50
        local Rounding = rounding or 1

        local CurrentValue = Default
        local dragging = false

        local function setValue(value)
            -- Clamping
            value = math.clamp(value, Min, Max)

            -- Rounding  
            value = math.floor(value / Rounding + 0.5) * Rounding  

            -- Proportions
            local percent = (value - Min) / (Max - Min)  
            progressBar.Size = UDim2.new(percent, -4, 0, 16)  

            -- Update label  
            valueLabel.Text = tostring(value) .. " / " .. tostring(Max)  

            CurrentValue = value
            
            if callback then
                callback(value)
            end

            return value
        end

        -- Initial value
        setValue(Default)

        -- Drag functionality
        sliderBackground.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local mouseX = UserInputService:GetMouseLocation().X
                local relative = (mouseX - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
                setValue(Min + (Max - Min) * relative)
            end
        end)

        sliderBackground.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouseX = UserInputService:GetMouseLocation().X
                local relative = (mouseX - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X
                setValue(Min + (Max - Min) * relative)
            end
        end)

        return {
            SetValue = setValue,
            GetValue = function() return CurrentValue end
        }
    end

    function self.SetTitle(text)
        titleLabel.Text = text or "Kolt UI Title"
    end

    return self
end

return KoltUI
