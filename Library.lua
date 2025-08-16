local KoltUI = {}

function KoltUI:CreateWindow(title)
    local Library = {}
    
    -- Services
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UiKolt"
    screenGui.DisplayOrder = 2147483647
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local uiFolder = Instance.new("Folder")
    uiFolder.Name = "UI"
    uiFolder.Parent = screenGui
    
    local menu = Instance.new("Frame")
    menu.Name = "MENU"
    menu.ZIndex = 6
    menu.BorderSizePixel = 0
    menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menu.Size = UDim2.new(0, 454, 0, 278)
    menu.Position = UDim2.new(0.5, -227, 0.5, -139)
    menu.Parent = uiFolder
    
    local menuBackground = Instance.new("Frame")
    menuBackground.Name = "BACKGROUND"
    menuBackground.BorderSizePixel = 0
    menuBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuBackground.Size = UDim2.new(1, 0, 1, 0)
    menuBackground.Parent = menu
    
    local innerBackground = Instance.new("Frame")
    innerBackground.Name = "BACKGROUND"
    innerBackground.BorderSizePixel = 0
    innerBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    innerBackground.Size = UDim2.new(0, 442, 0, 234)
    innerBackground.Position = UDim2.new(0, 6, 0, 40)
    innerBackground.Parent = menuBackground
    
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Name = "TABs"
    tabsFrame.BorderSizePixel = 0
    tabsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tabsFrame.Size = UDim2.new(0, 434, 0, 32)
    tabsFrame.Position = UDim2.new(0, 4, 0, 4)
    tabsFrame.Parent = innerBackground
    
    local scrollTabs = Instance.new("ScrollingFrame")
    scrollTabs.Name = "ScrollTabs"
    scrollTabs.ScrollingDirection = Enum.ScrollingDirection.X
    scrollTabs.BorderSizePixel = 0
    scrollTabs.BackgroundTransparency = 1
    scrollTabs.AutomaticCanvasSize = Enum.AutomaticSize.X
    scrollTabs.Size = UDim2.new(0, 418, 0, 28)
    scrollTabs.Position = UDim2.new(0, 2, 0, 2)
    scrollTabs.Parent = tabsFrame
    
    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.FillDirection = Enum.FillDirection.Horizontal
    tabListLayout.Padding = UDim.new(0, 4)
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabListLayout.Parent = scrollTabs
    
    local tabsStroke = Instance.new("UIStroke")
    tabsStroke.Color = Color3.fromRGB(0, 0, 255)
    tabsStroke.Parent = tabsFrame
    
    local innerBackgroundStroke = Instance.new("UIStroke")
    innerBackgroundStroke.Color = Color3.fromRGB(0, 0, 255)
    innerBackgroundStroke.Parent = innerBackground
    
    local menuBackgroundStroke = Instance.new("UIStroke")
    menuBackgroundStroke.Color = Color3.fromRGB(0, 0, 255)
    menuBackgroundStroke.Parent = menuBackground
    
    local leftFrame = Instance.new("Frame")
    leftFrame.Name = "Left"
    leftFrame.ZIndex = 6
    leftFrame.BorderSizePixel = 0
    leftFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    leftFrame.Size = UDim2.new(0, 214, 0, 190)
    leftFrame.Position = UDim2.new(0, 10, 0, 80)
    leftFrame.Parent = menu
    
    local leftScroll = Instance.new("ScrollingFrame")
    leftScroll.Name = "ScrollLeft"
    leftScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    leftScroll.BorderSizePixel = 0
    leftScroll.BackgroundTransparency = 1
    leftScroll.ScrollBarThickness = 0
    leftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    leftScroll.Size = UDim2.new(1, 0, 1, 0)
    leftScroll.Parent = leftFrame
    
    local leftListLayout = Instance.new("UIListLayout")
    leftListLayout.Padding = UDim.new(0, 4)
    leftListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    leftListLayout.Parent = leftScroll
    
    local leftStroke = Instance.new("UIStroke")
    leftStroke.Color = Color3.fromRGB(0, 0, 255)
    leftStroke.Parent = leftFrame
    
    local rightFrame = Instance.new("Frame")
    rightFrame.Name = "Right"
    rightFrame.ZIndex = 6
    rightFrame.BorderSizePixel = 0
    rightFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    rightFrame.Size = UDim2.new(0, 214, 0, 190)
    rightFrame.Position = UDim2.new(0, 230, 0, 80)
    rightFrame.Parent = menu
    
    local rightScroll = Instance.new("ScrollingFrame")
    rightScroll.Name = "ScrollRight"
    rightScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    rightScroll.BorderSizePixel = 0
    rightScroll.BackgroundTransparency = 1
    rightScroll.ScrollBarThickness = 0
    rightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    rightScroll.Size = UDim2.new(1, 0, 1, 0)
    rightScroll.Parent = rightFrame
    
    local rightListLayout = Instance.new("UIListLayout")
    rightListLayout.Padding = UDim.new(0, 4)
    rightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    rightListLayout.Parent = rightScroll
    
    local rightStroke = Instance.new("UIStroke")
    rightStroke.Color = Color3.fromRGB(0, 0, 255)
    rightStroke.Parent = rightFrame
    
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
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Size = UDim2.new(0, 438, 0, 28)
    titleLabel.Position = UDim2.new(0, 4, 0, 0)
    titleLabel.Text = title or "Kolt UI Title"
    titleLabel.Parent = titleFrame
    
    local titleStroke = Instance.new("UIStroke")
    titleStroke.Color = Color3.fromRGB(0, 0, 255)
    titleStroke.Parent = titleFrame
    
    -- UI OPEN/LOCK
    local uiOpenLockFolder = Instance.new("Folder")
    uiOpenLockFolder.Name = "UIOpenLock"
    uiOpenLockFolder.Parent = screenGui
    
    local openLockBackground = Instance.new("Frame")
    openLockBackground.Name = "BACKGROUND"
    openLockBackground.ZIndex = 998
    openLockBackground.BorderSizePixel = 0
    openLockBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    openLockBackground.Size = UDim2.new(0, 96, 0, 70)
    openLockBackground.Position = UDim2.new(0, -2, 0, 16)
    openLockBackground.Parent = uiOpenLockFolder
    
    local showHideButton = Instance.new("TextButton")
    showHideButton.Name = "ShowHide"
    showHideButton.BorderSizePixel = 0
    showHideButton.TextSize = 17
    showHideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    showHideButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    showHideButton.Font = Enum.Font.GothamBlack
    showHideButton.ZIndex = 999
    showHideButton.Size = UDim2.new(0, 86, 0, 30)
    showHideButton.Text = "Toggle UI"
    showHideButton.Position = UDim2.new(0, 4, 0, 20)
    showHideButton.Parent = openLockBackground
    
    local showHideStroke = Instance.new("UIStroke")
    showHideStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    showHideStroke.Thickness = 2
    showHideStroke.Color = Color3.fromRGB(0, 0, 255)
    showHideStroke.Parent = showHideButton
    
    local lockUnlockButton = Instance.new("TextButton")
    lockUnlockButton.Name = "LockUnlock"
    lockUnlockButton.BorderSizePixel = 0
    lockUnlockButton.TextSize = 20
    lockUnlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    lockUnlockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    lockUnlockButton.Font = Enum.Font.GothamBlack
    lockUnlockButton.ZIndex = 999
    lockUnlockButton.Size = UDim2.new(0, 86, 0, 30)
    lockUnlockButton.Text = "Lock"
    lockUnlockButton.Position = UDim2.new(0, 4, 0, 52)
    lockUnlockButton.Parent = openLockBackground
    
    local lockUnlockStroke = Instance.new("UIStroke")
    lockUnlockStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    lockUnlockStroke.Thickness = 2
    lockUnlockStroke.Color = Color3.fromRGB(0, 0, 255)
    lockUnlockStroke.Parent = lockUnlockButton
    
    -- Toggle UI visibility
    local uiVisible = true
    showHideButton.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        menu.Visible = uiVisible
    end)
    
    -- Lock/Unlock UI (disables/enables the ScreenGui)
    local uiLocked = false
    lockUnlockButton.MouseButton1Click:Connect(function()
        uiLocked = not uiLocked
        screenGui.Enabled = not uiLocked
        lockUnlockButton.Text = uiLocked and "Unlock" or "Lock"
    end)
    
    -- Tab management
    local tabs = {}
    local currentTab = nil
    
    function Library:AddTab(name)
        local tab = {}
        
        local tabButton = Instance.new("TextButton")
        tabButton.Name = "ButtonTab"
        tabButton.BorderSizePixel = 0
        tabButton.TextSize = 15
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        tabButton.Font = Enum.Font.GothamBlack
        tabButton.ZIndex = 10
        tabButton.Size = UDim2.new(0, 48, 0, 20)
        tabButton.Text = name
        tabButton.Parent = scrollTabs
        
        local tabButtonStroke = Instance.new("UIStroke")
        tabButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        tabButtonStroke.Thickness = 2
        tabButtonStroke.Color = Color3.fromRGB(0, 0, 255)
        tabButtonStroke.Parent = tabButton
        
        local leftContent = Instance.new("Frame")
        leftContent.Name = "LeftContent"
        leftContent.BackgroundTransparency = 1
        leftContent.Size = UDim2.new(1, 0, 0, 0)
        leftContent.AutomaticSize = Enum.AutomaticSize.Y
        
        local leftContentLayout = Instance.new("UIListLayout")
        leftContentLayout.Padding = UDim.new(0, 4)
        leftContentLayout.Parent = leftContent
        
        local rightContent = Instance.new("Frame")
        rightContent.Name = "RightContent"
        rightContent.BackgroundTransparency = 1
        rightContent.Size = UDim2.new(1, 0, 0, 0)
        rightContent.AutomaticSize = Enum.AutomaticSize.Y
        
        local rightContentLayout = Instance.new("UIListLayout")
        rightContentLayout.Padding = UDim.new(0, 4)
        rightContentLayout.Parent = rightContent
        
        tab.left = leftContent
        tab.right = rightContent
        tab.button = tabButton
        
        tabButton.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.left.Parent = nil
                currentTab.right.Parent = nil
                currentTab.button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            end
            leftContent.Parent = leftScroll
            rightContent.Parent = rightScroll
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            currentTab = tab
        end)
        
        table.insert(tabs, tab)
        
        if not currentTab then
            tabButton.MouseButton1Click:Fire()
        end
        
        function tab:AddSection(sectionName, side)
            local section = {}
            
            local container = Instance.new("Frame")
            container.Name = "CONTAINER"
            container.ZIndex = 9
            container.BorderSizePixel = 0
            container.BackgroundTransparency = 1
            container.Size = UDim2.new(1, 0, 0, 0)
            container.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionLayout = Instance.new("UIListLayout")
            sectionLayout.Padding = UDim.new(0, 4)
            sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionLayout.Parent = container
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "Name"
            nameLabel.ZIndex = 11
            nameLabel.BorderSizePixel = 0
            nameLabel.TextSize = 12
            nameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Font = Enum.Font.GothamBlack
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.Size = UDim2.new(1, 0, 0, 8)
            nameLabel.Text = sectionName
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Position = UDim2.new(0, 14, 0, -4)
            nameLabel.Parent = container
            
            local sectionStroke = Instance.new("UIStroke")
            sectionStroke.Color = Color3.fromRGB(0, 0, 255)
            sectionStroke.Parent = container
            
            local parentContent = (side == "left") and leftContent or rightContent
            container.Parent = parentContent
            
            function section:AddSlider(sliderName, min, max, default, rounding, callback)
                rounding = rounding or 1
                callback = callback or function() end
                
                local sliderContainer = Instance.new("Frame")
                sliderContainer.BackgroundTransparency = 1
                sliderContainer.Size = UDim2.new(1, 0, 0, 38)
                sliderContainer.Parent = container
                
                local sliderNameLabel = Instance.new("TextLabel")
                sliderNameLabel.Text = sliderName
                sliderNameLabel.BackgroundTransparency = 1
                sliderNameLabel.Size = UDim2.new(1, 0, 0, 20)
                sliderNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                sliderNameLabel.TextSize = 12
                sliderNameLabel.Font = Enum.Font.GothamBold
                sliderNameLabel.TextXAlignment = Enum.TextXAlignment.Left
                sliderNameLabel.Parent = sliderContainer
                
                local sliderBackground = Instance.new("Frame")
                sliderBackground.Name = "BACKGROUND"
                sliderBackground.ZIndex = 11
                sliderBackground.BorderSizePixel = 0
                sliderBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                sliderBackground.Size = UDim2.new(1, 0, 0, 18)
                sliderBackground.Position = UDim2.new(0, 0, 0, 20)
                sliderBackground.Parent = sliderContainer
                
                local sliderStroke = Instance.new("UIStroke")
                sliderStroke.Color = Color3.fromRGB(0, 0, 255)
                sliderStroke.Parent = sliderBackground
                
                local progressBar = Instance.new("Frame")
                progressBar.Name = "ProgressBar"
                progressBar.BorderSizePixel = 0
                progressBar.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
                progressBar.Position = UDim2.new(0, 2, 0, 1)
                progressBar.Size = UDim2.new(0, 0, 0, 16)
                progressBar.Parent = sliderBackground
                
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Name = "Value"
                valueLabel.BorderSizePixel = 0
                valueLabel.BackgroundTransparency = 1
                valueLabel.TextSize = 12
                valueLabel.Font = Enum.Font.GothamBold
                valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                valueLabel.Size = UDim2.new(0, 60, 1, 0)
                valueLabel.Position = UDim2.new(1, -60, 0, 0)
                valueLabel.Text = ""
                valueLabel.Parent = sliderBackground
                
                local function setValue(value)
                    value = math.clamp(value, min, max)
                    value = math.floor(value / rounding + 0.5) * rounding
                    local percent = (value - min) / (max - min)
                    progressBar.Size = UDim2.new(percent, -4, 0, 16)
                    valueLabel.Text = tostring(value) .. " / " .. tostring(max)
                    callback(value)
                    return value
                end
                
                local currentValue = setValue(default or min)
                
                local dragging = false
                
                sliderBackground.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                
                sliderBackground.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                RunService.RenderStepped:Connect(function()
                    if dragging then
                        local mouseX = UserInputService:GetMouseLocation().X
                        local relative = math.clamp((mouseX - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
                        currentValue = setValue(min + (max - min) * relative)
                    end
                end)
            end
            
            function section:AddCheckbox(checkName, default, callback)
                callback = callback or function() end
                
                local checkboxBackground = Instance.new("Frame")
                checkboxBackground.Name = "CheckboxBackground"
                checkboxBackground.ZIndex = 11
                checkboxBackground.BorderSizePixel = 0
                checkboxBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                checkboxBackground.Size = UDim2.new(1, 0, 0, 18)
                checkboxBackground.Parent = container
                
                local checkboxStroke = Instance.new("UIStroke")
                checkboxStroke.Color = Color3.fromRGB(0, 0, 255)
                checkboxStroke.Parent = checkboxBackground
                
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
                checkboxLabel.BackgroundTransparency = 1
                checkboxLabel.Font = Enum.Font.GothamBlack
                checkboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                checkboxLabel.Size = UDim2.new(1, -22, 1, 0)
                checkboxLabel.Text = checkName
                checkboxLabel.Position = UDim2.new(0, 22, 0, 0)
                checkboxLabel.Parent = checkboxBackground
                
                local enabled = default or false
                onFrame.Visible = enabled
                offFrame.Visible = not enabled
                
                local function toggle()
                    enabled = not enabled
                    onFrame.Visible = enabled
                    offFrame.Visible = not enabled
                    callback(enabled)
                end
                
                checkboxBackground.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        toggle()
                    end
                end)
            end
            
            function section:AddButton(btnName, callback)
                callback = callback or function() end
                
                local textButton = Instance.new("TextButton")
                textButton.TextWrapped = true
                textButton.BorderSizePixel = 0
                textButton.TextSize = 12
                textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                textButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                textButton.Font = Enum.Font.GothamBlack
                textButton.ZIndex = 11
                textButton.Size = UDim2.new(1, 0, 0, 20)
                textButton.Text = btnName
                textButton.Parent = container
                
                local buttonStroke = Instance.new("UIStroke")
                buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                buttonStroke.Thickness = 0.9
                buttonStroke.Color = Color3.fromRGB(0, 0, 255)
                buttonStroke.Parent = textButton
                
                textButton.MouseButton1Click:Connect(callback)
            end
            
            return section
        end
        
        return tab
    end
    
    return Library
end

return KoltUI
