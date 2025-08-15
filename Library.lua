--KOLT UI LIBRARY V1
return (function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer

    local Library = {}

    function Library:CreateWindow(options)
        local Window = {}

        local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Name = "KOLT_UI"

        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "Window"
        mainFrame.Parent = ScreenGui
        mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        mainFrame.Size = UDim2.new(0, 500, 0, 300)
        mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
        mainFrame.Active = true -- Important for input detection

        local mainStroke = Instance.new("UIStroke", mainFrame)
        mainStroke.Thickness = 2
        mainStroke.Color = Color3.fromRGB(0, 102, 255)
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- Dragging logic
        local dragging, dragStart, startPos, dragLock = false, Vector2.new(), UDim2.new(), false

        local function onInputBegan(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not dragLock then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
            end
        end

        local function onInputChanged(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end

        local function onInputEnded(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end

        UserInputService.InputChanged:Connect(onInputChanged)
        UserInputService.InputEnded:Connect(onInputEnded)

        local titleBar = Instance.new("Frame", mainFrame)
        titleBar.Name = "TitleBar"
        titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        titleBar.Size = UDim2.new(1, 0, 0, 40)
        titleBar.InputBegan:Connect(onInputBegan) -- Only the title bar is draggable

        local titleStroke = Instance.new("UIStroke", titleBar)
        titleStroke.Color = Color3.fromRGB(0, 102, 255)
        titleStroke.Thickness = 1.5
        titleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local titleLabel = Instance.new("TextLabel", titleBar)
        titleLabel.Size = UDim2.new(1, -20, 1, 0)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 20
        titleLabel.Text = options.Title or "KOLT UI"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left

        local tabHolder = Instance.new("Frame", mainFrame)
        tabHolder.Name = "TabHolder"
        tabHolder.BackgroundTransparency = 1
        tabHolder.Size = UDim2.new(1, -20, 0, 30)
        tabHolder.Position = UDim2.new(0, 10, 0, 45)

        local UIList = Instance.new("UIListLayout", tabHolder)
        UIList.FillDirection = Enum.FillDirection.Horizontal
        UIList.Padding = UDim.new(0, 6)
        UIList.HorizontalAlignment = Enum.HorizontalAlignment.Left

        local tabContainer = Instance.new("Frame", mainFrame)
        tabContainer.Name = "TabContainer"
        tabContainer.BackgroundTransparency = 1
        tabContainer.Size = UDim2.new(1, -20, 1, -85)
        tabContainer.Position = UDim2.new(0, 10, 0, 80)

        local tabs = {}

        function Window:AddTab(name)
            local Tab = {}

            local tabBtn = Instance.new("TextButton", tabHolder)
            tabBtn.Name = name .. "TabButton"
            tabBtn.Size = UDim2.new(0, 90, 1, 0)
            tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            tabBtn.Font = Enum.Font.Gotham
            tabBtn.TextSize = 14
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabBtn.Text = name

            local stroke = Instance.new("UIStroke", tabBtn)
            stroke.Thickness = 1.5
            stroke.Color = Color3.fromRGB(0, 102, 255)
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local page = Instance.new("Frame", tabContainer)
            page.Name = name .. "Page"
            page.BackgroundTransparency = 1
            page.Size = UDim2.new(1, 0, 1, 0)
            page.Visible = false

            -- Left Column
            local leftColumn = Instance.new("ScrollingFrame", page)
            leftColumn.Name = "LeftColumn"
            leftColumn.BackgroundTransparency = 1
            leftColumn.Size = UDim2.new(0.48, 0, 1, 0)
            leftColumn.CanvasSize = UDim2.new(0, 0, 0, 0)
            leftColumn.ScrollBarThickness = 0
            leftColumn.AutomaticCanvasSize = Enum.AutomaticSize.Y

            local leftList = Instance.new("UIListLayout", leftColumn)
            leftList.Padding = UDim.new(0, 5)
            leftList.SortOrder = Enum.SortOrder.LayoutOrder

            local leftPad = Instance.new("UIPadding", leftColumn)
            leftPad.PaddingTop = UDim.new(0, 5)
            leftPad.PaddingLeft = UDim.new(0, 5)
            leftPad.PaddingRight = UDim.new(0, 5)
            leftPad.PaddingBottom = UDim.new(0, 5)
            
            -- Right Column
            local rightColumn = Instance.new("ScrollingFrame", page)
            rightColumn.Name = "RightColumn"
            rightColumn.BackgroundTransparency = 1
            rightColumn.Size = UDim2.new(0.48, 0, 1, 0)
            rightColumn.Position = UDim2.new(0.52, 0, 0, 0)
            rightColumn.CanvasSize = UDim2.new(0, 0, 0, 0)
            rightColumn.ScrollBarThickness = 0
            rightColumn.AutomaticCanvasSize = Enum.AutomaticSize.Y

            local rightList = Instance.new("UIListLayout", rightColumn)
            rightList.Padding = UDim.new(0, 5)
            rightList.SortOrder = Enum.SortOrder.LayoutOrder

            local rightPad = Instance.new("UIPadding", rightColumn)
            rightPad.PaddingTop = UDim.new(0, 5)
            rightPad.PaddingLeft = UDim.new(0, 5)
            rightPad.PaddingRight = UDim.new(0, 5)
            rightPad.PaddingBottom = UDim.new(0, 5)


            tabs[tabBtn] = page

            tabBtn.MouseButton1Click:Connect(function()
                for tBtn, p in pairs(tabs) do
                    p.Visible = false
                    tBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    local btnStroke = tBtn:FindFirstChildOfClass("UIStroke")
                    if btnStroke then
                        btnStroke.Color = Color3.fromRGB(0, 102, 255)
                    end
                end
                page.Visible = true
                tabBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                local btnStroke = tabBtn:FindFirstChildOfClass("UIStroke")
                if btnStroke then
                    btnStroke.Color = Color3.fromRGB(0, 102, 255)
                end
            end)

            if next(tabs) == tabBtn then
                page.Visible = true
                tabBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
            end
            
            -- Helper function to create a groupbox
            local function createGroupbox(parent, title)
                local Section = {}
                
                local groupbox = Instance.new("Frame", parent)
                groupbox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                groupbox.Size = UDim2.new(1, 0, 0, 0)
                groupbox.AutomaticSize = Enum.AutomaticSize.Y

                local gbStroke = Instance.new("UIStroke", groupbox)
                gbStroke.Color = Color3.fromRGB(0, 102, 255)
                gbStroke.Thickness = 1
                gbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local gbTitle = Instance.new("TextLabel", groupbox)
                gbTitle.Size = UDim2.new(1, -20, 0, 20)
                gbTitle.Position = UDim2.new(0, 10, 0, 5)
                gbTitle.BackgroundTransparency = 1
                gbTitle.Font = Enum.Font.GothamSemibold
                gbTitle.TextSize = 16
                gbTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                gbTitle.Text = title
                gbTitle.TextXAlignment = Enum.TextXAlignment.Left

                local contentFrame = Instance.new("Frame", groupbox)
                contentFrame.BackgroundTransparency = 1
                contentFrame.Size = UDim2.new(1, 0, 1, -30)
                contentFrame.Position = UDim2.new(0, 0, 0, 25)
                contentFrame.AutomaticSize = Enum.AutomaticSize.Y

                local contentList = Instance.new("UIListLayout", contentFrame)
                contentList.Padding = UDim.new(0, 5)
                contentList.SortOrder = Enum.SortOrder.LayoutOrder

                local contentPad = Instance.new("UIPadding", contentFrame)
                contentPad.PaddingLeft = UDim.new(0, 10)
                contentPad.PaddingRight = UDim.new(0, 10)
                contentPad.PaddingTop = UDim.new(0, 5)
                contentPad.PaddingBottom = UDim.new(0, 5)

                -- Button
                function Section:AddButton(options)
                    local text = options.Text or "Button"
                    local func = options.Func or function() end
                    local doubleClick = options.DoubleClick or false

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)
                    elemFrame.AutomaticSize = Enum.AutomaticSize.Y

                    local btn = Instance.new("TextButton", elemFrame)
                    btn.Size = UDim2.new(1, 0, 0, 25)
                    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    btn.Text = text
                    btn.Font = Enum.Font.Gotham
                    btn.TextSize = 14
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local btnStroke = Instance.new("UIStroke", btn)
                    btnStroke.Thickness = 1
                    btnStroke.Color = Color3.fromRGB(0, 102, 255)
                    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local lastClick = 0
                    btn.MouseButton1Click:Connect(function()
                        if doubleClick then
                            if tick() - lastClick <= 0.3 then
                                func()
                            end
                            lastClick = tick()
                        else
                            func()
                        end
                    end)
                    
                    local addedButtons = {}
                    
                    function Section:AddSubButton(options)
                        local subBtn = Instance.new("TextButton", elemFrame)
                        subBtn.Size = UDim2.new(1, -20, 0, 25)
                        subBtn.Position = UDim2.new(0, 20, 0, 30 + (#addedButtons * 30))
                        subBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                        subBtn.Text = options.Text or "Sub Button"
                        subBtn.Font = Enum.Font.Gotham
                        subBtn.TextSize = 12
                        subBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        
                        local subBtnStroke = Instance.new("UIStroke", subBtn)
                        subBtnStroke.Thickness = 1
                        subBtnStroke.Color = Color3.fromRGB(0, 102, 255)
                        subBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        
                        subBtn.MouseButton1Click:Connect(options.Func)
                        
                        table.insert(addedButtons, subBtn)
                        elemFrame.Size = UDim2.new(1, 0, 0, 30 + (#addedButtons * 30))
                    end
                    
                    return Section
                end

                -- Checkbox and Toggle (combined and simplified)
                function Section:AddToggle(key, opt)
                    local text = opt.Text or "Toggle"
                    local default = opt.Default or false
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 20)

                    local label = Instance.new("TextLabel", elemFrame)
                    label.Size = UDim2.new(1, -30, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Font = Enum.Font.Gotham
                    label.TextSize = 14
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.Text = text
                    label.TextXAlignment = Enum.TextXAlignment.Left

                    local toggleBtn = Instance.new("TextButton", elemFrame)
                    toggleBtn.Size = UDim2.new(0, 30, 0, 18)
                    toggleBtn.Position = UDim2.new(1, -30, 0, 1)
                    toggleBtn.BackgroundColor3 = default and Color3.fromRGB(0, 102, 255) or Color3.fromRGB(25, 25, 35)
                    toggleBtn.Text = ""

                    local toggleStroke = Instance.new("UIStroke", toggleBtn)
                    toggleStroke.Thickness = 1
                    toggleStroke.Color = Color3.fromRGB(0, 102, 255)
                    toggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    
                    local dot = Instance.new("Frame", toggleBtn)
                    dot.Size = UDim2.new(0, 12, 0, 12)
                    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dot.Position = default and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)

                    local state = default
                    toggleBtn.MouseButton1Click:Connect(function()
                        state = not state
                        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 102, 255) or Color3.fromRGB(25, 25, 35)
                        dot:TweenPosition(UDim2.new(state and 1 or 0, state and -15 or 3, 0.5, -6), "Out", "Quad", 0.2)
                        callback(state)
                    end)
                end
                
                function Section:AddCheckbox(key, opt)
                    local text = opt.Text or "Checkbox"
                    local default = opt.Default or false
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 20)

                    local cbLabel = Instance.new("TextLabel", elemFrame)
                    cbLabel.Size = UDim2.new(1, -30, 1, 0)
                    cbLabel.BackgroundTransparency = 1
                    cbLabel.Font = Enum.Font.Gotham
                    cbLabel.TextSize = 14
                    cbLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    cbLabel.Text = text
                    cbLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local cbBtn = Instance.new("TextButton", elemFrame)
                    cbBtn.Size = UDim2.new(0, 20, 0, 20)
                    cbBtn.Position = UDim2.new(1, -20, 0, 0)
                    cbBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    cbBtn.Text = ""

                    local cbStroke = Instance.new("UIStroke", cbBtn)
                    cbStroke.Thickness = 1
                    cbStroke.Color = Color3.fromRGB(0, 102, 255)
                    cbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local checkMark = Instance.new("TextLabel", cbBtn)
                    checkMark.Size = UDim2.new(1, 0, 1, 0)
                    checkMark.BackgroundTransparency = 1
                    checkMark.Text = default and "✔" or ""
                    checkMark.TextColor3 = Color3.fromRGB(0, 255, 0)
                    checkMark.Font = Enum.Font.GothamBold
                    checkMark.TextSize = 16

                    local state = default
                    cbBtn.MouseButton1Click:Connect(function()
                        state = not state
                        checkMark.Text = state and "✔" or ""
                        callback(state)
                    end)
                end
                
                -- Slider
                function Section:AddSlider(key, opt)
                    local text = opt.Text or "Slider"
                    local default = opt.Default or 0
                    local min = opt.Min or 0
                    local max = opt.Max or 100
                    local rounding = opt.Rounding or 0
                    local compact = opt.Compact or false
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, compact and 30 or 50)
                    
                    local titleLabel = Instance.new("TextLabel", elemFrame)
                    titleLabel.Size = UDim2.new(1, 0, 0, 15)
                    titleLabel.Position = UDim2.new(0, 0, 0, 0)
                    titleLabel.BackgroundTransparency = 1
                    titleLabel.Font = Enum.Font.Gotham
                    titleLabel.TextSize = 14
                    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    titleLabel.Text = text .. ": " .. string.format("%." .. tostring(rounding) .. "f", default)
                    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local sliderFrame = Instance.new("Frame", elemFrame)
                    sliderFrame.Size = UDim2.new(1, 0, 0, 10)
                    sliderFrame.Position = UDim2.new(0, 0, 0, compact and 15 or 30)
                    sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    
                    local sliderStroke = Instance.new("UIStroke", sliderFrame)
                    sliderStroke.Thickness = 1
                    sliderStroke.Color = Color3.fromRGB(0, 102, 255)
                    sliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    
                    local fill = Instance.new("Frame", sliderFrame)
                    fill.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                    fill.Size = UDim2.new(0, 0, 1, 0)
                    
                    local value
                    local draggingSlider = false
                    
                    local function updateSlider(input)
                        local x = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
                        local ratio = x / sliderFrame.AbsoluteSize.X
                        value = min + ratio * (max - min)
                        
                        fill.Size = UDim2.new(ratio, 0, 1, 0)
                        titleLabel.Text = text .. ": " .. string.format("%." .. tostring(rounding) .. "f", value)
                        callback(value)
                    end
                    
                    sliderFrame.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            draggingSlider = true
                            updateSlider(input)
                        end
                    end)
                    
                    UserInputService.InputChanged:Connect(function(input)
                        if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input)
                        end
                    end)
                    
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            draggingSlider = false
                        end
                    end)
                    
                    -- Initial state
                    local ratio = (default - min) / (max - min)
                    fill.Size = UDim2.new(ratio, 0, 1, 0)
                end
                
                -- Dropdown
                function Section:AddDropdown(key, opt)
                    local values = opt.Values or {}
                    local text = opt.Text or "Dropdown"
                    local multi = opt.Multi or false
                    local default = opt.Default or (multi and {} or nil)
                    local callback = opt.Callback or function() end
                    
                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)
                    
                    local dropdownBtn = Instance.new("TextButton", elemFrame)
                    dropdownBtn.Size = UDim2.new(1, 0, 1, 0)
                    dropdownBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    dropdownBtn.Text = text
                    dropdownBtn.Font = Enum.Font.Gotham
                    dropdownBtn.TextSize = 14
                    dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    
                    local dropdownStroke = Instance.new("UIStroke", dropdownBtn)
                    dropdownStroke.Thickness = 1
                    dropdownStroke.Color = Color3.fromRGB(0, 102, 255)
                    dropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    
                    local menuFrame = Instance.new("Frame", elemFrame)
                    menuFrame.Name = "Menu"
                    menuFrame.Visible = false
                    menuFrame.BackgroundTransparency = 1
                    menuFrame.Size = UDim2.new(1, 0, 0, #values * 25)
                    menuFrame.Position = UDim2.new(0, 0, 0, 30)
                    
                    local menuList = Instance.new("UIListLayout", menuFrame)
                    menuList.Padding = UDim.new(0, 2)
                    menuList.SortOrder = Enum.SortOrder.LayoutOrder
                    
                    local menuBG = Instance.new("Frame", menuFrame)
                    menuBG.Size = UDim2.new(1, 0, 1, 0)
                    menuBG.Position = UDim2.new(0, 0, 0, 0)
                    menuBG.ZIndex = 1
                    menuBG.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                    menuBG.BorderSizePixel = 0
                    
                    local menuStroke = Instance.new("UIStroke", menuBG)
                    menuStroke.Thickness = 1
                    menuStroke.Color = Color3.fromRGB(0, 102, 255)
                    menuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    
                    menuBG.Parent = menuFrame
                    
                    local function updateDropdownText()
                        if multi then
                            local selectedCount = 0
                            for _, selected in pairs(default) do
                                if selected then selectedCount = selectedCount + 1 end
                            end
                            dropdownBtn.Text = text .. " (" .. selectedCount .. ")"
                        else
                            dropdownBtn.Text = text .. ": " .. (default or "None")
                        end
                    end
                    
                    local function createOptionButton(optionText)
                        local optionBtn = Instance.new("TextButton", menuFrame)
                        optionBtn.Size = UDim2.new(1, -4, 0, 20)
                        optionBtn.Position = UDim2.new(0, 2, 0, 0)
                        optionBtn.ZIndex = 2
                        optionBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        optionBtn.Text = optionText
                        optionBtn.Font = Enum.Font.Gotham
                        optionBtn.TextSize = 12
                        optionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        
                        local stroke = Instance.new("UIStroke", optionBtn)
                        stroke.Thickness = 1
                        stroke.Color = Color3.fromRGB(0, 102, 255)
                        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        
                        optionBtn.MouseButton1Click:Connect(function()
                            if multi then
                                if default[optionText] then
                                    default[optionText] = nil
                                    optionBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                                else
                                    default[optionText] = true
                                    optionBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                                end
                                callback(default)
                            else
                                default = optionText
                                for _, child in pairs(menuFrame:GetChildren()) do
                                    if child:IsA("TextButton") then
                                        child.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                                    end
                                end
                                optionBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                                menuFrame.Visible = false
                                callback(default)
                            end
                            updateDropdownText()
                        end)
                        
                        return optionBtn
                    end
                    
                    for _, option in ipairs(values) do
                        local optionBtn = createOptionButton(option)
                        if multi and default[option] or (not multi and default == option) then
                            optionBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                        end
                    end
                    
                    dropdownBtn.MouseButton1Click:Connect(function()
                        menuFrame.Visible = not menuFrame.Visible
                    end)
                    
                    updateDropdownText()
                end

                return Section
            end

            function Tab:AddLeftGroupbox(title)
                return createGroupbox(leftColumn, title)
            end

            function Tab:AddRightGroupbox(title)
                return createGroupbox(rightColumn, title)
            end

            return Tab
        end
        
        -- External buttons (improved positioning and hover effects)
        local function createExternalButton(text, posY, callback)
            local btn = Instance.new("TextButton", ScreenGui)
            btn.Size = UDim2.new(0, 120, 0, 36)
            btn.Position = UDim2.new(0, 10, 0, posY)
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = text

            local btnStroke = Instance.new("UIStroke", btn)
            btnStroke.Thickness = 2
            btnStroke.Color = Color3.fromRGB(0, 102, 255)
            btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45) end)
            btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35) end)
            btn.MouseButton1Click:Connect(callback)

            return btn
        end

        createExternalButton("TOGGLE UI", 12, function() mainFrame.Visible = not mainFrame.Visible end)
        createExternalButton("LOCK UI", 52, function() dragLock = not dragLock end)

        return Window
    end
    
    return Library
end)()
