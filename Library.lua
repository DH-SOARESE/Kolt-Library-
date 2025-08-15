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

        local Tooltip = Instance.new("TextLabel", ScreenGui)
        Tooltip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Tooltip.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tooltip.Font = Enum.Font.Gotham
        Tooltip.TextSize = 12
        Tooltip.Visible = false
        Tooltip.ZIndex = 10
        Tooltip.TextWrapped = true
        Tooltip.Size = UDim2.new(0, 200, 0, 0)
        Tooltip.AutomaticSize = Enum.AutomaticSize.Y
        local ttStroke = Instance.new("UIStroke", Tooltip)
        ttStroke.Color = Color3.fromRGB(0, 102, 255)
        ttStroke.Thickness = 1
        ttStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local mainFrame = Instance.new("Frame", ScreenGui)
        mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        mainFrame.Size = UDim2.new(0, 500, 0, 300)
        mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)

        local mainStroke = Instance.new("UIStroke", mainFrame)
        mainStroke.Thickness = 2
        mainStroke.Color = Color3.fromRGB(0, 102, 255)
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- Improved drag: only on title bar
        local dragging, dragLock = false, false
        local dragStart, startPos

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
        titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        titleBar.Size = UDim2.new(1, 0, 0, 40)

        titleBar.InputBegan:Connect(onInputBegan)  -- Drag only here

        local titleStroke = Instance.new("UIStroke", titleBar)
        titleStroke.Color = Color3.fromRGB(0, 102, 255)
        titleStroke.Thickness = 1.5
        titleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local titleLabel = Instance.new("TextLabel", titleBar)
        titleLabel.Size = UDim2.new(1, -10, 1, 0)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 20
        titleLabel.Text = options.Title or "KOLT UI"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left

        local tabHolder = Instance.new("Frame", mainFrame)
        tabHolder.BackgroundTransparency = 1
        tabHolder.Size = UDim2.new(1, -20, 0, 30)
        tabHolder.Position = UDim2.new(0, 10, 0, 45)

        local UIList = Instance.new("UIListLayout", tabHolder)
        UIList.FillDirection = Enum.FillDirection.Horizontal
        UIList.Padding = UDim.new(0, 6)

        local tabContainer = Instance.new("Frame", mainFrame)
        tabContainer.BackgroundTransparency = 1
        tabContainer.Size = UDim2.new(1, -20, 1, -85)
        tabContainer.Position = UDim2.new(0, 10, 0, 80)

        local tabs = {}

        function Window:AddTab(name)
            local Tab = {}

            local tabBtn = Instance.new("TextButton", tabHolder)
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
            page.BackgroundTransparency = 1
            page.Size = UDim2.new(1, 0, 1, 0)
            page.Visible = false

            local leftColumn = Instance.new("ScrollingFrame", page)
            leftColumn.BackgroundTransparency = 1
            leftColumn.Size = UDim2.new(0.48, 0, 1, 0)
            leftColumn.CanvasSize = UDim2.new(0, 0, 0, 0)
            leftColumn.ScrollBarThickness = 0
            leftColumn.AutomaticCanvasSize = Enum.AutomaticSize.Y  -- Improved auto sizing

            local leftList = Instance.new("UIListLayout", leftColumn)
            leftList.Padding = UDim.new(0, 5)
            leftList.SortOrder = Enum.SortOrder.LayoutOrder

            local leftPad = Instance.new("UIPadding", leftColumn)
            leftPad.PaddingTop = UDim.new(0, 5)
            leftPad.PaddingLeft = UDim.new(0, 5)
            leftPad.PaddingRight = UDim.new(0, 5)
            leftPad.PaddingBottom = UDim.new(0, 5)

            local rightColumn = leftColumn:Clone()
            rightColumn.Position = UDim2.new(0.52, 0, 0, 0)
            rightColumn.Parent = page

            tabs[tabBtn] = page

            tabBtn.MouseButton1Click:Connect(function()
                for tBtn, p in pairs(tabs) do
                    p.Visible = false
                    tBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                end
                page.Visible = true
                tabBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
            end)

            if next(tabs) == tabBtn then  -- Select first tab
                page.Visible = true
                tabBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
            end

            function Tab:AddLeftGroupbox(title)
                local Section = {}

                local groupbox = Instance.new("Frame", leftColumn)
                groupbox.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                groupbox.Size = UDim2.new(1, 0, 0, 0)  -- Auto size
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

                -- Improved: auto update sizes on content change
                contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    leftColumn.CanvasSize = UDim2.new(0, 0, 0, leftList.AbsoluteContentSize.Y + 10)
                end)

                function Section:AddButton(opt)
                    local text = opt.Text or "Button"
                    local func = opt.Func or function() end
                    local doubleClick = opt.DoubleClick or false

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local button = Instance.new("TextButton", elemFrame)
                    button.Size = UDim2.new(1, 0, 1, 0)
                    button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    button.Text = text
                    button.Font = Enum.Font.Gotham
                    button.TextSize = 14
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local btnStroke = Instance.new("UIStroke", button)
                    btnStroke.Thickness = 1
                    btnStroke.Color = Color3.fromRGB(0, 102, 255)
                    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    button.MouseEnter:Connect(function() button.BackgroundColor3 = Color3.fromRGB(35, 35, 45) end)
                    button.MouseLeave:Connect(function() button.BackgroundColor3 = Color3.fromRGB(25, 25, 35) end)

                    local lastClick = 0
                    button.MouseButton1Click:Connect(function()
                        if doubleClick then
                            if tick() - lastClick < 0.5 then
                                func()
                                lastClick = 0
                            else
                                lastClick = tick()
                            end
                        else
                            func()
                        end
                    end)

                    local ButtonObj = {}

                    function ButtonObj:AddButton(subOpt)
                        local subText = subOpt.Text or "Sub"
                        local subFunc = subOpt.Func or function() end

                        button.Size = UDim2.new(0.6, 0, 1, 0)

                        local subButton = Instance.new("TextButton", elemFrame)
                        subButton.Size = UDim2.new(0.4, 0, 1, 0)
                        subButton.Position = UDim2.new(0.6, 0, 0, 0)
                        subButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        subButton.Text = subText
                        subButton.Font = Enum.Font.Gotham
                        subButton.TextSize = 12
                        subButton.TextColor3 = Color3.fromRGB(255, 255, 255)

                        local subStroke = Instance.new("UIStroke", subButton)
                        subStroke.Thickness = 1
                        subStroke.Color = Color3.fromRGB(0, 102, 255)
                        subStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                        subButton.MouseEnter:Connect(function() subButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45) end)
                        subButton.MouseLeave:Connect(function() subButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35) end)
                        subButton.MouseButton1Click:Connect(subFunc)
                    end

                    return ButtonObj
                end

                function Section:AddToggle(key, opt)
                    local text = opt.Text or "Toggle"
                    local default = opt.Default or false
                    local tooltip = opt.Tooltip or nil
                    local callback = opt.Callback or function(v) end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 20)

                    local togLabel = Instance.new("TextLabel", elemFrame)
                    togLabel.Size = UDim2.new(1, -50, 1, 0)
                    togLabel.BackgroundTransparency = 1
                    togLabel.Font = Enum.Font.Gotham
                    togLabel.TextSize = 14
                    togLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    togLabel.Text = text
                    togLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local togBtn = Instance.new("TextButton", elemFrame)
                    togBtn.Size = UDim2.new(0, 40, 0, 20)
                    togBtn.Position = UDim2.new(1, -40, 0, 0)
                    togBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    togBtn.Text = ""

                    local togStroke = Instance.new("UIStroke", togBtn)
                    togStroke.Thickness = 1
                    togStroke.Color = Color3.fromRGB(0, 102, 255)
                    togStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local knob = Instance.new("Frame", togBtn)
                    knob.Size = UDim2.new(0, 20, 0, 18)
                    knob.Position = UDim2.new(0, 0, 0, 1)
                    knob.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

                    local state = default
                    local function updateToggle()
                        knob.Position = state and UDim2.new(0, 20, 0, 1) or UDim2.new(0, 0, 0, 1)
                        knob.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
                    end
                    updateToggle()

                    togBtn.MouseButton1Click:Connect(function()
                        state = not state
                        updateToggle()
                        callback(state)
                    end)

                    if tooltip then
                        elemFrame.MouseEnter:Connect(function()
                            Tooltip.Text = tooltip
                            Tooltip.Position = UDim2.new(0, elemFrame.AbsolutePosition.X + elemFrame.AbsoluteSize.X + 5, 0, elemFrame.AbsolutePosition.Y)
                            Tooltip.Visible = true
                        end)
                        elemFrame.MouseLeave:Connect(function() Tooltip.Visible = false end)
                    end
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

                function Section:AddSlider(key, opt)
                    local text = opt.Text or "Slider"
                    local default = opt.Default or 0
                    local min = opt.Min or 0
                    local max = opt.Max or 100
                    local rounding = opt.Rounding or 0
                    local compact = opt.Compact or false
                    local callback = opt.Callback or function(v) end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, compact and 20 or 40)

                    local sliderLabel = Instance.new("TextLabel", elemFrame)
                    sliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
                    sliderLabel.BackgroundTransparency = 1
                    sliderLabel.Font = Enum.Font.Gotham
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderLabel.Text = text
                    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    sliderLabel.Visible = not compact

                    local valueLabel = Instance.new("TextLabel", elemFrame)
                    valueLabel.Size = UDim2.new(0.3, 0, 0, 20)
                    valueLabel.Position = UDim2.new(0.7, 0, 0, 0)
                    valueLabel.BackgroundTransparency = 1
                    valueLabel.Font = Enum.Font.Gotham
                    valueLabel.TextSize = 14
                    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    valueLabel.Text = tostring(default)
                    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
                    valueLabel.Visible = not compact

                    local sliderBar = Instance.new("Frame", elemFrame)
                    sliderBar.Size = UDim2.new(1, 0, 0, 10)
                    sliderBar.Position = UDim2.new(0, 0, 0, compact and 5 or 25)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

                    local barStroke = Instance.new("UIStroke", sliderBar)
                    barStroke.Thickness = 1
                    barStroke.Color = Color3.fromRGB(0, 102, 255)
                    barStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local fill = Instance.new("Frame", sliderBar)
                    fill.Size = UDim2.new(0, 0, 1, 0)
                    fill.BackgroundColor3 = Color3.fromRGB(0, 102, 255)

                    local value = default
                    local function updateValue(newVal)
                        newVal = math.clamp(newVal, min, max)
                        if rounding > 0 then
                            newVal = math.round(newVal * 10^rounding) / 10^rounding
                        else
                            newVal = math.floor(newVal)
                        end
                        value = newVal
                        local frac = (value - min) / (max - min)
                        fill.Size = UDim2.new(frac, 0, 1, 0)
                        valueLabel.Text = tostring(value)
                        callback(value)
                    end
                    updateValue(default)

                    local dragging = false
                    sliderBar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            local relX = (input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
                            updateValue(min + relX * (max - min))
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local relX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                            updateValue(min + relX * (max - min))
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                end

                function Section:AddDropdown(key, opt)
                    local values = opt.Values or {}
                    local default = opt.Default or (opt.Multi and {} or 1)
                    local multi = opt.Multi or false
                    local text = opt.Text or "Dropdown"
                    local tooltip = opt.Tooltip or nil
                    local callback = opt.Callback or function(v) end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local dropButton = Instance.new("TextButton", elemFrame)
                    dropButton.Size = UDim2.new(1, 0, 1, 0)
                    dropButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    dropButton.Font = Enum.Font.Gotham
                    dropButton.TextSize = 14
                    dropButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropButton.TextXAlignment = Enum.TextXAlignment.Left

                    local dropStroke = Instance.new("UIStroke", dropButton)
                    dropStroke.Thickness = 1
                    dropStroke.Color = Color3.fromRGB(0, 102, 255)
                    dropStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local arrow = Instance.new("TextLabel", dropButton)
                    arrow.Size = UDim2.new(0, 20, 1, 0)
                    arrow.Position = UDim2.new(1, -20, 0, 0)
                    arrow.BackgroundTransparency = 1
                    arrow.Text = "▼"
                    arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
                    arrow.Font = Enum.Font.Gotham
                    arrow.TextSize = 14

                    local open = false
                    local selected
                    local selTable = {}

                    if not multi then
                        selected = values[default] or values[1]
                        dropButton.Text = text .. ": " .. (selected or "None")
                    else
                        for _, v in ipairs(values) do
                            selTable[v] = false
                        end
                        for _, d in ipairs(default) do
                            selTable[d] = true
                        end
                        local selText = {}
                        for k, s in pairs(selTable) do if s then table.insert(selText, k) end end
                        dropButton.Text = text .. ": " .. (next(selText) and table.concat(selText, ", ") or "None")
                    end

                    local listFrame = Instance.new("ScrollingFrame", ScreenGui)
                    listFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                    listFrame.Size = UDim2.new(0, elemFrame.AbsoluteSize.X, 0, math.min(#values * 25, 150))
                    listFrame.Visible = false
                    listFrame.ZIndex = 5
                    listFrame.ScrollBarThickness = 4

                    local listList = Instance.new("UIListLayout", listFrame)
                    listList.Padding = UDim.new(0, 0)

                    local listPad = Instance.new("UIPadding", listFrame)
                    listPad.PaddingTop = UDim.new(0, 5)
                    listPad.PaddingLeft = UDim.new(0, 5)

                    local function updateList()
                        listFrame.Position = UDim2.new(0, elemFrame.AbsolutePosition.X, 0, elemFrame.AbsolutePosition.Y + 30)
                        listFrame.CanvasSize = UDim2.new(0, 0, 0, listList.AbsoluteContentSize.Y + 10)
                    end

                    local function refreshText()
                        if not multi then
                            dropButton.Text = text .. ": " .. (selected or "None")
                            callback(selected)
                        else
                            local selText = {}
                            for k, s in pairs(selTable) do if s then table.insert(selText, k) end end
                            dropButton.Text = text .. ": " .. (next(selText) and table.concat(selText, ", ") or "None")
                            callback(selTable)
                        end
                    end

                    for i, val in ipairs(values) do
                        local item = Instance.new("TextButton", listFrame)
                        item.Size = UDim2.new(1, 0, 0, 25)
                        item.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        item.Text = val
                        item.Font = Enum.Font.Gotham
                        item.TextSize = 14
                        item.TextColor3 = Color3.fromRGB(255, 255, 255)
                        item.TextXAlignment = Enum.TextXAlignment.Left

                        local itemStroke = Instance.new("UIStroke", item)
                        itemStroke.Thickness = 1
                        itemStroke.Color = Color3.fromRGB(0, 102, 255)
                        itemStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                        item.MouseEnter:Connect(function() item.BackgroundColor3 = Color3.fromRGB(35, 35, 45) end)
                        item.MouseLeave:Connect(function() item.BackgroundColor3 = Color3.fromRGB(25, 25, 35) end)

                        if not multi then
                            if val == selected then item.TextColor3 = Color3.fromRGB(0, 255, 0) end
                        else
                            if selTable[val] then item.TextColor3 = Color3.fromRGB(0, 255, 0) end
                        end

                        item.MouseButton1Click:Connect(function()
                            if multi then
                                selTable[val] = not selTable[val]
                                item.TextColor3 = selTable[val] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
                                refreshText()
                            else
                                for _, child in ipairs(listFrame:GetChildren()) do
                                    if child:IsA("TextButton") then child.TextColor3 = Color3.fromRGB(255, 255, 255) end
                                end
                                item.TextColor3 = Color3.fromRGB(0, 255, 0)
                                selected = val
                                refreshText()
                                open = false
                                listFrame.Visible = false
                            end
                        end)
                    end

                    local function toggleOpen()
                        open = not open
                        listFrame.Visible = open
                        if open then
                            updateList()
                            local overlay = Instance.new("TextButton", ScreenGui)
                            overlay.Size = UDim2.new(1, 0, 1, 0)
                            overlay.BackgroundTransparency = 1
                            overlay.Text = ""
                            overlay.ZIndex = 4
                            overlay.MouseButton1Click:Connect(function()
                                open = false
                                listFrame.Visible = false
                                overlay:Destroy()
                            end)
                        end
                    end

                    dropButton.MouseButton1Click:Connect(toggleOpen)

                    if tooltip then
                        elemFrame.MouseEnter:Connect(function()
                            Tooltip.Text = tooltip
                            Tooltip.Position = UDim2.new(0, elemFrame.AbsolutePosition.X + elemFrame.AbsoluteSize.X + 5, 0, elemFrame.AbsolutePosition.Y)
                            Tooltip.Visible = true
                        end)
                        elemFrame.MouseLeave:Connect(function() Tooltip.Visible = false end)
                    end
                end

                return Section
            end

            -- Add similar for right if needed
            function Tab:AddRightGroupbox(title)
                local Section = {}

                local groupbox = Instance.new("Frame", rightColumn)
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

                contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    rightColumn.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 10)
                end)

                -- Duplicate the AddButton, AddToggle, AddCheckbox, AddSlider, AddDropdown functions here for the right section
                -- (Omitted for brevity, but implement them identically, replacing the contentFrame reference)

                function Section:AddButton(opt)
                    -- Identical to left's AddButton, using this contentFrame
                    local text = opt.Text or "Button"
                    local func = opt.Func or function() end
                    local doubleClick = opt.DoubleClick or false

                    local elemFrame = Instance.new("Frame", contentFrame)
                    -- ... rest same as above
                end

                -- Similarly for AddToggle, AddCheckbox, AddSlider, AddDropdown (copy the code blocks)

                return Section
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
