return (function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer

    local Library = {}

    local Theme = {
        Main = Color3.fromRGB(18, 18, 25),
        Accent = Color3.fromRGB(0, 102, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Header = Color3.fromRGB(15, 15, 20),
        Button = Color3.fromRGB(25, 25, 35),
        Hover = Color3.fromRGB(35, 35, 45),
        Border = Color3.fromRGB(25, 25, 35)
    }

    local components = {}

    function components.AddButton(parent, options)
        local buttonFrame = Instance.new("Frame")
        buttonFrame.BackgroundTransparency = 1
        buttonFrame.Size = UDim2.new(1, 0, 0, 30)
        buttonFrame.LayoutOrder = options.LayoutOrder or 0
        buttonFrame.Parent = parent

        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundColor3 = Theme.Button
        button.Text = options.Text or "Button"
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.TextColor3 = Theme.Text
        button.Parent = buttonFrame

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Color = Theme.Accent
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = button

        button.MouseButton1Click:Connect(function()
            if options.DoubleClick and UserInputService.InputBegan:wait().UserInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
            if options.Func then
                options.Func()
            end
        end)

        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Theme.Hover
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Theme.Button
        end)
    end
    
    function components.AddToggle(parent, key, options)
        local state = options.Default or false

        local elemFrame = Instance.new("Frame")
        elemFrame.BackgroundTransparency = 1
        elemFrame.Size = UDim2.new(1, 0, 0, 20)
        elemFrame.LayoutOrder = options.LayoutOrder or 0
        elemFrame.Parent = parent

        local cbLabel = Instance.new("TextLabel", elemFrame)
        cbLabel.Size = UDim2.new(1, -30, 1, 0)
        cbLabel.BackgroundTransparency = 1
        cbLabel.Font = Enum.Font.Gotham
        cbLabel.TextSize = 14
        cbLabel.TextColor3 = Theme.Text
        cbLabel.Text = options.Text or "Toggle"
        cbLabel.TextXAlignment = Enum.TextXAlignment.Left

        local cbBtn = Instance.new("TextButton", elemFrame)
        cbBtn.Size = UDim2.new(0, 20, 0, 20)
        cbBtn.Position = UDim2.new(1, -20, 0, 0)
        cbBtn.BackgroundColor3 = Theme.Button
        cbBtn.Text = ""
        cbBtn.Parent = elemFrame

        local cbStroke = Instance.new("UIStroke", cbBtn)
        cbStroke.Thickness = 1
        cbStroke.Color = Theme.Accent
        cbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local checkMark = Instance.new("TextLabel", cbBtn)
        checkMark.Size = UDim2.new(1, 0, 1, 0)
        checkMark.BackgroundTransparency = 1
        checkMark.Text = state and "✔" or ""
        checkMark.TextColor3 = Color3.fromRGB(0, 255, 0)
        checkMark.Font = Enum.Font.GothamBold
        checkMark.TextSize = 16
        
        local function updateUI()
            checkMark.Text = state and "✔" or ""
            cbBtn.BackgroundColor3 = state and Theme.Accent or Theme.Button
            cbStroke.Color = state and Theme.Accent or Theme.Accent
        end

        cbBtn.MouseButton1Click:Connect(function()
            state = not state
            updateUI()
            if options.Callback then
                options.Callback(state)
            end
        end)
        
        updateUI() -- Initial state update
    end

    function components.AddSlider(parent, key, options)
        local value = options.Default or options.Min or 0
        local min = options.Min or 0
        local max = options.Max or 100
        local rounding = options.Rounding or 1
        local compact = options.Compact or false

        local sliderFrame = Instance.new("Frame")
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Size = UDim2.new(1, 0, 0, compact and 25 or 45)
        sliderFrame.LayoutOrder = options.LayoutOrder or 0
        sliderFrame.Parent = parent

        local titleLabel = Instance.new("TextLabel", sliderFrame)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Size = UDim2.new(1, 0, 0, 15)
        titleLabel.Font = Enum.Font.Gotham
        titleLabel.TextSize = 14
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextColor3 = Theme.Text
        titleLabel.Text = options.Text or "Slider"

        local valueLabel = Instance.new("TextLabel", sliderFrame)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Size = UDim2.new(1, 0, 0, 15)
        valueLabel.Position = UDim2.new(0, 0, 0, 0)
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextSize = 14
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.TextColor3 = Theme.Text

        local sliderBg = Instance.new("Frame", sliderFrame)
        sliderBg.BackgroundColor3 = Theme.Button
        sliderBg.Size = UDim2.new(1, 0, 0, 5)
        sliderBg.Position = UDim2.new(0, 0, 0, compact and 20 or 30)

        local sliderFill = Instance.new("Frame", sliderBg)
        sliderFill.BackgroundColor3 = Theme.Accent
        sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        sliderFill.Parent = sliderBg

        local function updateValue(input)
            local mouseX = input.Position.X
            local sliderX = sliderBg.AbsolutePosition.X
            local sliderWidth = sliderBg.AbsoluteSize.X
            local ratio = math.clamp((mouseX - sliderX) / sliderWidth, 0, 1)
            
            value = min + ratio * (max - min)
            if rounding > 0 then
                value = math.floor(value / rounding + 0.5) * rounding
            end
            
            value = math.clamp(value, min, max)

            sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            valueLabel.Text = string.format("%.1f", value)
            
            if options.Callback then
                options.Callback(value)
            end
        end

        local isDragging = false
        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
                updateValue(input)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateValue(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)

        valueLabel.Text = string.format("%.1f", value)
    end
    
    function components.AddDropdown(parent, key, options)
        local text = options.Text or "Dropdown"
        local values = options.Values or {}
        local isMulti = options.Multi or false
        local selectedValues = {}
        if options.Default then
            if isMulti then
                for _, val in ipairs(options.Default) do
                    selectedValues[val] = true
                end
            else
                selectedValues[options.Default] = true
            end
        end
    
        local elemFrame = Instance.new("Frame")
        elemFrame.BackgroundTransparency = 1
        elemFrame.Size = UDim2.new(1, 0, 0, 30)
        elemFrame.LayoutOrder = options.LayoutOrder or 0
        elemFrame.Parent = parent
    
        local dropdownButton = Instance.new("TextButton", elemFrame)
        dropdownButton.Size = UDim2.new(1, 0, 1, 0)
        dropdownButton.BackgroundColor3 = Theme.Button
        dropdownButton.Font = Enum.Font.Gotham
        dropdownButton.TextSize = 14
        dropdownButton.TextColor3 = Theme.Text
        dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
        dropdownButton.Text = text
        dropdownButton.TextWrapped = true
    
        local arrow = Instance.new("TextLabel", dropdownButton)
        arrow.BackgroundTransparency = 1
        arrow.Text = "▼"
        arrow.TextColor3 = Theme.Text
        arrow.Size = UDim2.new(0, 20, 1, 0)
        arrow.Position = UDim2.new(1, -20, 0, 0)
        arrow.Font = Enum.Font.Gotham
        arrow.TextSize = 12
    
        local dropdownStroke = Instance.new("UIStroke", dropdownButton)
        dropdownStroke.Thickness = 1
        dropdownStroke.Color = Theme.Accent
        dropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
        local dropdownList = Instance.new("Frame")
        dropdownList.BackgroundTransparency = 1
        dropdownList.Size = UDim2.new(1, 0, 0, 0)
        dropdownList.Position = UDim2.new(0, 0, 1, 5)
        dropdownList.Visible = false
        dropdownList.Parent = parent
    
        local listLayout = Instance.new("UIListLayout", dropdownList)
        listLayout.FillDirection = Enum.FillDirection.Vertical
        listLayout.Padding = UDim.new(0, 2)
    
        local function updateButtonText()
            local display = {}
            if isMulti then
                for val, selected in pairs(selectedValues) do
                    if selected then table.insert(display, val) end
                end
            else
                for val, selected in pairs(selectedValues) do
                    if selected then display = {val} end
                end
            end
            dropdownButton.Text = text .. ": " .. (table.concat(display, ", ") or "Nenhum")
        end
    
        local function createOption(value)
            local optionButton = Instance.new("TextButton")
            optionButton.Size = UDim2.new(1, 0, 0, 25)
            optionButton.BackgroundColor3 = Theme.Button
            optionButton.Text = value
            optionButton.Font = Enum.Font.Gotham
            optionButton.TextSize = 14
            optionButton.TextColor3 = Theme.Text
            optionButton.TextXAlignment = Enum.TextXAlignment.Left
            optionButton.Parent = dropdownList
    
            local optionStroke = Instance.new("UIStroke", optionButton)
            optionStroke.Thickness = 1
            optionStroke.Color = Theme.Accent
            optionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
            if selectedValues[value] then
                optionButton.BackgroundColor3 = Theme.Accent
            end
    
            optionButton.MouseButton1Click:Connect(function()
                if isMulti then
                    selectedValues[value] = not selectedValues[value]
                else
                    for k in pairs(selectedValues) do selectedValues[k] = false end
                    selectedValues[value] = true
                    dropdownList.Visible = false
                end
                
                for _, btn in pairs(dropdownList:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = selectedValues[btn.Text] and Theme.Accent or Theme.Button
                    end
                end
                
                updateButtonText()
                if options.Callback then
                    options.Callback(selectedValues)
                end
            end)
    
            optionButton.MouseEnter:Connect(function() optionButton.BackgroundColor3 = Theme.Hover end)
            optionButton.MouseLeave:Connect(function() 
                optionButton.BackgroundColor3 = selectedValues[value] and Theme.Accent or Theme.Button
            end)
        end
    
        for _, value in ipairs(values) do
            createOption(value)
        end
    
        dropdownButton.MouseButton1Click:Connect(function()
            dropdownList.Visible = not dropdownList.Visible
        end)
    
        -- Recalculate size of dropdown list
        dropdownList.Size = UDim2.new(1, 0, 0, #values * 27) -- 25 height + 2 padding
    
        updateButtonText()
    end

    function Library:CreateWindow(options)
        local Window = {}
        local tabs = {}
        local currentTab = nil

        local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Name = "KOLT_UI"

        local mainFrame = Instance.new("Frame", ScreenGui)
        mainFrame.BackgroundColor3 = Theme.Main
        mainFrame.Size = UDim2.new(0, 550, 0, 350)
        mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)

        local mainStroke = Instance.new("UIStroke", mainFrame)
        mainStroke.Thickness = 2
        mainStroke.Color = Theme.Accent
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        
        local dragging, dragLock = false, false
        local dragStart, startPos

        local titleBar = Instance.new("Frame", mainFrame)
        titleBar.BackgroundColor3 = Theme.Header
        titleBar.Size = UDim2.new(1, 0, 0, 35)

        titleBar.InputBegan:Connect(function(input)
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

        local titleLabel = Instance.new("TextLabel", titleBar)
        titleLabel.Size = UDim2.new(1, -10, 1, 0)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 18
        titleLabel.Text = options.Title or "KOLT UI"
        titleLabel.TextColor3 = Theme.Text
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left

        local tabHolder = Instance.new("Frame", mainFrame)
        tabHolder.BackgroundTransparency = 1
        tabHolder.Size = UDim2.new(1, -20, 0, 30)
        tabHolder.Position = UDim2.new(0, 10, 0, 40)

        local UIList = Instance.new("UIListLayout", tabHolder)
        UIList.FillDirection = Enum.FillDirection.Horizontal
        UIList.Padding = UDim.new(0, 6)
        UIList.SortOrder = Enum.SortOrder.LayoutOrder

        local tabContainer = Instance.new("Frame", mainFrame)
        tabContainer.BackgroundTransparency = 1
        tabContainer.Size = UDim2.new(1, -20, 1, -80)
        tabContainer.Position = UDim2.new(0, 10, 0, 75)

        function Window:AddTab(name)
            local Tab = {}

            local tabBtn = Instance.new("TextButton", tabHolder)
            tabBtn.Size = UDim2.new(0, 90, 1, 0)
            tabBtn.BackgroundColor3 = Theme.Button
            tabBtn.Font = Enum.Font.Gotham
            tabBtn.TextSize = 14
            tabBtn.TextColor3 = Theme.Text
            tabBtn.Text = name

            local stroke = Instance.new("UIStroke", tabBtn)
            stroke.Thickness = 1
            stroke.Color = Theme.Accent
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local page = Instance.new("Frame", tabContainer)
            page.BackgroundTransparency = 1
            page.Size = UDim2.new(1, 0, 1, 0)
            page.Visible = false

            local leftColumn = Instance.new("ScrollingFrame", page)
            leftColumn.BackgroundTransparency = 1
            leftColumn.Size = UDim2.new(0.48, 0, 1, 0)
            leftColumn.CanvasSize = UDim2.new(0, 0, 0, 0)
            leftColumn.ScrollBarThickness = 5

            local rightColumn = leftColumn:Clone()
            rightColumn.Position = UDim2.new(0.52, 0, 0, 0)
            rightColumn.Parent = page

            local leftList = Instance.new("UIListLayout", leftColumn)
            leftList.Padding = UDim.new(0, 5)
            leftList.SortOrder = Enum.SortOrder.LayoutOrder
            local leftPad = Instance.new("UIPadding", leftColumn)
            leftPad.PaddingTop = UDim.new(0, 5)
            leftPad.PaddingLeft = UDim.new(0, 5)
            leftPad.PaddingRight = UDim.new(0, 5)
            leftPad.PaddingBottom = UDim.new(0, 5)

            local rightList = Instance.new("UIListLayout", rightColumn)
            rightList.Padding = UDim.new(0, 5)
            rightList.SortOrder = Enum.SortOrder.LayoutOrder
            local rightPad = Instance.new("UIPadding", rightColumn)
            rightPad.PaddingTop = UDim.new(0, 5)
            rightPad.PaddingLeft = UDim.new(0, 5)
            rightPad.PaddingRight = UDim.new(0, 5)
            rightPad.PaddingBottom = UDim.new(0, 5)

            function Tab:AddLeftGroupbox(title)
                local Section = {}
                local groupbox = Instance.new("Frame", leftColumn)
                groupbox.BackgroundColor3 = Theme.Border
                groupbox.Size = UDim2.new(1, 0, 0, 0)
                groupbox.AutomaticSize = Enum.AutomaticSize.Y
                local gbStroke = Instance.new("UIStroke", groupbox)
                gbStroke.Color = Theme.Accent
                gbStroke.Thickness = 1
                gbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                local gbTitle = Instance.new("TextLabel", groupbox)
                gbTitle.Size = UDim2.new(1, -20, 0, 20)
                gbTitle.Position = UDim2.new(0, 10, 0, 5)
                gbTitle.BackgroundTransparency = 1
                gbTitle.Font = Enum.Font.GothamSemibold
                gbTitle.TextSize = 16
                gbTitle.TextColor3 = Theme.Text
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

                function Section:AddButton(options) components.AddButton(contentFrame, options) end
                function Section:AddCheckbox(key, options) components.AddToggle(contentFrame, key, options) end
                function Section:AddToggle(key, options) components.AddToggle(contentFrame, key, options) end
                function Section:AddSlider(key, options) components.AddSlider(contentFrame, key, options) end
                function Section:AddDropdown(key, options) components.AddDropdown(contentFrame, key, options) end
                return Section
            end

            function Tab:AddRightGroupbox(title)
                local Section = {}
                local groupbox = Instance.new("Frame", rightColumn)
                groupbox.BackgroundColor3 = Theme.Border
                groupbox.Size = UDim2.new(1, 0, 0, 0)
                groupbox.AutomaticSize = Enum.AutomaticSize.Y
                local gbStroke = Instance.new("UIStroke", groupbox)
                gbStroke.Color = Theme.Accent
                gbStroke.Thickness = 1
                gbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                local gbTitle = Instance.new("TextLabel", groupbox)
                gbTitle.Size = UDim2.new(1, -20, 0, 20)
                gbTitle.Position = UDim2.new(0, 10, 0, 5)
                gbTitle.BackgroundTransparency = 1
                gbTitle.Font = Enum.Font.GothamSemibold
                gbTitle.TextSize = 16
                gbTitle.TextColor3 = Theme.Text
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

                function Section:AddButton(options) components.AddButton(contentFrame, options) end
                function Section:AddCheckbox(key, options) components.AddToggle(contentFrame, key, options) end
                function Section:AddToggle(key, options) components.AddToggle(contentFrame, key, options) end
                function Section:AddSlider(key, options) components.AddSlider(contentFrame, key, options) end
                function Section:AddDropdown(key, options) components.AddDropdown(contentFrame, key, options) end
                return Section
            end

            tabs[tabBtn] = page
            
            tabBtn.MouseButton1Click:Connect(function()
                if currentTab then
                    tabs[currentTab].Visible = false
                    currentTab.BackgroundColor3 = Theme.Button
                end
                page.Visible = true
                tabBtn.BackgroundColor3 = Theme.Accent
                currentTab = tabBtn
            end)

            if not currentTab then
                tabBtn:MouseButton1Click()
            end

            return Tab
        end

        local function createExternalButton(text, posY, callback)
            local btn = Instance.new("TextButton", ScreenGui)
            btn.Size = UDim2.new(0, 120, 0, 36)
            btn.Position = UDim2.new(0, 10, 0, posY)
            btn.BackgroundColor3 = Theme.Button
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextColor3 = Theme.Text
            btn.Text = text

            local btnStroke = Instance.new("UIStroke", btn)
            btnStroke.Thickness = 2
            btnStroke.Color = Theme.Accent
            btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Theme.Hover end)
            btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Theme.Button end)
            btn.MouseButton1Click:Connect(callback)
        end

        createExternalButton("TOGGLE UI", 12, function() mainFrame.Visible = not mainFrame.Visible end)
        createExternalButton("LOCK UI", 52, function() dragLock = not dragLock end)

        return Window
    end

    return Library
end)()
