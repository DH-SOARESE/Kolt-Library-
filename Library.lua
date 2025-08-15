return (function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer

    local Library = {}

    -- Color palette for a refined, modern look
    local Colors = {
        Primary = Color3.fromRGB(20, 20, 30),      -- Dark background
        Secondary = Color3.fromRGB(30, 30, 45),    -- Slightly lighter for elements
        Accent = Color3.fromRGB(0, 120, 255),      -- Vibrant blue for highlights
        Text = Color3.fromRGB(220, 220, 220),      -- Light gray for readability
        Active = Color3.fromRGB(40, 150, 255),     -- Brighter blue for active states
        Hover = Color3.fromRGB(50, 50, 70),        -- Subtle hover effect
        Success = Color3.fromRGB(0, 255, 100),     -- Green for checkmarks
    }

    function Library:CreateWindow(options)
        local Window = {}

        -- Create ScreenGui
        local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Name = "KOLT_UI"
        ScreenGui.IgnoreGuiInset = true

        -- Main frame
        local mainFrame = Instance.new("Frame", ScreenGui)
        mainFrame.BackgroundColor3 = Colors.Primary
        mainFrame.Size = UDim2.new(0, 550, 0, 350)
        mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
        mainFrame.ClipsDescendants = true

        local mainStroke = Instance.new("UIStroke", mainFrame)
        mainStroke.Thickness = 1.5
        mainStroke.Color = Colors.Accent
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- Dragging functionality (title bar only)
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

        -- Title bar
        local titleBar = Instance.new("Frame", mainFrame)
        titleBar.BackgroundColor3 = Colors.Secondary
        titleBar.Size = UDim2.new(1, 0, 0, 40)
        titleBar.InputBegan:Connect(onInputBegan)

        local titleStroke = Instance.new("UIStroke", titleBar)
        titleStroke.Color = Colors.Accent
        titleStroke.Thickness = 1
        titleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local titleLabel = Instance.new("TextLabel", titleBar)
        titleLabel.Size = UDim2.new(1, -20, 1, 0)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.SourceSansPro
        titleLabel.TextSize = 18
        titleLabel.Text = options.Title or "KOLT UI"
        titleLabel.TextColor3 = Colors.Text
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left

        -- Tab holder
        local tabHolder = Instance.new("Frame", mainFrame)
        tabHolder.BackgroundTransparency = 1
        tabHolder.Size = UDim2.new(1, -20, 0, 30)
        tabHolder.Position = UDim2.new(0, 10, 0, 45)

        local UIList = Instance.new("UIListLayout", tabHolder)
        UIList.FillDirection = Enum.FillDirection.Horizontal
        UIList.Padding = UDim.new(0, 8)

        -- Tab container
        local tabContainer = Instance.new("Frame", mainFrame)
        tabContainer.BackgroundTransparency = 1
        tabContainer.Size = UDim2.new(1, -20, 1, -85)
        tabContainer.Position = UDim2.new(0, 10, 0, 80)

        local tabs = {}

        function Window:AddTab(name)
            local Tab = {}

            -- Tab button
            local tabBtn = Instance.new("TextButton", tabHolder)
            tabBtn.Size = UDim2.new(0, 100, 1, 0)
            tabBtn.BackgroundColor3 = Colors.Secondary
            tabBtn.Font = Enum.Font.SourceSansPro
            tabBtn.TextSize = 14
            tabBtn.TextColor3 = Colors.Text
            tabBtn.Text = name

            local stroke = Instance.new("UIStroke", tabBtn)
            stroke.Thickness = 1
            stroke.Color = Colors.Accent
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            -- Hover effect
            tabBtn.MouseEnter:Connect(function() tabBtn.BackgroundColor3 = Colors.Hover end)
            tabBtn.MouseLeave:Connect(function() if not tabs[tabBtn].Visible then tabBtn.BackgroundColor3 = Colors.Secondary end end)

            -- Tab page
            local page = Instance.new("Frame", tabContainer)
            page.BackgroundTransparency = 1
            page.Size = UDim2.new(1, 0, 1, 0)
            page.Visible = false

            -- Columns
            local leftColumn = Instance.new("ScrollingFrame", page)
            leftColumn.BackgroundTransparency = 1
            leftColumn.Size = UDim2.new(0.48, 0, 1, 0)
            leftColumn.CanvasSize = UDim2.new(0, 0, 0, 0)
            leftColumn.ScrollBarThickness = 4
            leftColumn.ScrollBarImageColor3 = Colors.Accent
            leftColumn.AutomaticCanvasSize = Enum.AutomaticSize.Y

            local leftList = Instance.new("UIListLayout", leftColumn)
            leftList.Padding = UDim.new(0, 8)
            leftList.SortOrder = Enum.SortOrder.LayoutOrder

            local leftPad = Instance.new("UIPadding", leftColumn)
            leftPad.PaddingTop = UDim.new(0, 8)
            leftPad.PaddingLeft = UDim.new(0, 8)
            leftPad.PaddingRight = UDim.new(0, 8)
            leftPad.PaddingBottom = UDim.new(0, 8)

            local rightColumn = leftColumn:Clone()
            rightColumn.Position = UDim2.new(0.52, 0, 0, 0)
            rightColumn.Parent = page

            tabs[tabBtn] = page

            tabBtn.MouseButton1Click:Connect(function()
                for tBtn, p in pairs(tabs) do
                    p.Visible = false
                    tBtn.BackgroundColor3 = Colors.Secondary
                end
                page.Visible = true
                tabBtn.BackgroundColor3 = Colors.Active
            end)

            if next(tabs) == tabBtn then
                page.Visible = true
                tabBtn.BackgroundColor3 = Colors.Active
            end

            -- Groupbox (shared for left and right)
            local function createGroupbox(column, title)
                local Section = {}

                local groupbox = Instance.new("Frame", column)
                groupbox.BackgroundColor3 = Colors.Secondary
                groupbox.Size = UDim2.new(1, 0, 0, 0)
                groupbox.AutomaticSize = Enum.AutomaticSize.Y

                local gbStroke = Instance.new("UIStroke", groupbox)
                gbStroke.Color = Colors.Accent
                gbStroke.Thickness = 1
                gbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local gbTitle = Instance.new("TextLabel", groupbox)
                gbTitle.Size = UDim2.new(1, -20, 0, 24)
                gbTitle.Position = UDim2.new(0, 10, 0, 8)
                gbTitle.BackgroundTransparency = 1
                gbTitle.Font = Enum.Font.SourceSansPro
                gbTitle.TextSize = 16
                gbTitle.TextColor3 = Colors.Text
                gbTitle.Text = title
                gbTitle.TextXAlignment = Enum.TextXAlignment.Left

                local contentFrame = Instance.new("Frame", groupbox)
                contentFrame.BackgroundTransparency = 1
                contentFrame.Size = UDim2.new(1, 0, 1, -32)
                contentFrame.Position = UDim2.new(0, 0, 0, 32)
                contentFrame.AutomaticSize = Enum.AutomaticSize.Y

                local contentList = Instance.new("UIListLayout", contentFrame)
                contentList.Padding = UDim.new(0, 8)
                contentList.SortOrder = Enum.SortOrder.LayoutOrder

                local contentPad = Instance.new("UIPadding", contentFrame)
                contentPad.PaddingLeft = UDim.new(0, 12)
                contentPad.PaddingRight = UDim.new(0, 12)
                contentPad.PaddingTop = UDim.new(0, 8)
                contentPad.PaddingBottom = UDim.new(0, 8)

                contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    column.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 16)
                end)

                -- Button
                function Section:AddButton(opt)
                    local button = Instance.new("TextButton", contentFrame)
                    button.Size = UDim2.new(1, 0, 0, 32)
                    button.BackgroundColor3 = Colors.Secondary
                    button.Font = Enum.Font.SourceSansPro
                    button.TextSize = 14
                    button.TextColor3 = Colors.Text
                    button.Text = opt.Text or "Click Me"

                    local btnStroke = Instance.new("UIStroke", button)
                    btnStroke.Thickness = 1
                    btnStroke.Color = Colors.Accent
                    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    button.MouseEnter:Connect(function() button.BackgroundColor3 = Colors.Hover end)
                    button.MouseLeave:Connect(function() button.BackgroundColor3 = Colors.Secondary end)

                    local clickCount = 0
                    local lastClick = 0
                    button.MouseButton1Click:Connect(function()
                        if opt.DoubleClick then
                            local currentTime = tick()
                            if currentTime - lastClick < 0.5 then
                                clickCount = clickCount + 1
                                if clickCount >= 2 then
                                    opt.Func()
                                    clickCount = 0
                                end
                            else
                                clickCount = 1
                            end
                            lastClick = currentTime
                        else
                            opt.Func()
                        end
                    end)

                    -- Sub-button
                    function button:AddButton(subOpt)
                        local subButton = Instance.new("TextButton", contentFrame)
                        subButton.Size = UDim2.new(1, -20, 0, 28)
                        subButton.Position = UDim2.new(0, 20, 0, 0)
                        subButton.BackgroundColor3 = Colors.Secondary
                        subButton.Font = Enum.Font.SourceSansPro
                        subButton.TextSize = 13
                        subButton.TextColor3 = Colors.Text
                        subButton.Text = subOpt.Text or "Sub Button"

                        local subStroke = Instance.new("UIStroke", subButton)
                        subStroke.Thickness = 1
                        subStroke.Color = Colors.Accent
                        subStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                        subButton.MouseEnter:Connect(function() subButton.BackgroundColor3 = Colors.Hover end)
                        subButton.MouseLeave:Connect(function() subButton.BackgroundColor3 = Colors.Secondary end)
                        subButton.MouseButton1Click:Connect(subOpt.Func)
                    end

                    return button
                end

                -- Checkbox/Toggle (unified for consistency)
                function Section:AddCheckbox(key, opt)
                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 24)

                    local cbLabel = Instance.new("TextLabel", elemFrame)
                    cbLabel.Size = UDim2.new(1, -32, 1, 0)
                    cbLabel.BackgroundTransparency = 1
                    cbLabel.Font = Enum.Font.SourceSansPro
                    cbLabel.TextSize = 14
                    cbLabel.TextColor3 = Colors.Text
                    cbLabel.Text = opt.Text or "Checkbox"
                    cbLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local cbBtn = Instance.new("TextButton", elemFrame)
                    cbBtn.Size = UDim2.new(0, 24, 0, 24)
                    cbBtn.Position = UDim2.new(1, -24, 0, 0)
                    cbBtn.BackgroundColor3 = Colors.Secondary
                    cbBtn.Text = ""

                    local cbStroke = Instance.new("UIStroke", cbBtn)
                    cbStroke.Thickness = 1
                    cbStroke.Color = Colors.Accent
                    cbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local checkMark = Instance.new("TextLabel", cbBtn)
                    checkMark.Size = UDim2.new(1, 0, 1, 0)
                    checkMark.BackgroundTransparency = 1
                    checkMark.Text = opt.Default and "✔" or ""
                    checkMark.TextColor3 = Colors.Success
                    checkMark.Font = Enum.Font.SourceSansPro
                    checkMark.TextSize = 16

                    if opt.Tooltip then
                        cbLabel.MouseEnter:Connect(function()
                            -- Implement tooltip (placeholder for future expansion)
                        end)
                    end

                    local state = opt.Default or false
                    cbBtn.MouseButton1Click:Connect(function()
                        state = not state
                        checkMark.Text = state and "✔" or ""
                        opt.Callback(state)
                    end)

                    return { Set = function(value) state = value; checkMark.Text = state and "✔" or ""; opt.Callback(state) end }
                end

                -- Toggle (alias for Checkbox)
                function Section:AddToggle(key, opt)
                    return Section:AddCheckbox(key, opt)
                end

                -- Slider
                function Section:AddSlider(key, opt)
                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 40)

                    local sliderLabel = Instance.new("TextLabel", elemFrame)
                    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                    sliderLabel.BackgroundTransparency = 1
                    sliderLabel.Font = Enum.Font.SourceSansPro
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Colors.Text
                    sliderLabel.Text = opt.Text or "Slider"
                    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local sliderTrack = Instance.new("Frame", elemFrame)
                    sliderTrack.Size = UDim2.new(1, -10, 0, 8)
                    sliderTrack.Position = UDim2.new(0, 5, 0, 28)
                    sliderTrack.BackgroundColor3 = Colors.Secondary

                    local trackStroke = Instance.new("UIStroke", sliderTrack)
                    trackStroke.Thickness = 1
                    trackStroke.Color = Colors.Accent

                    local sliderFill = Instance.new("Frame", sliderTrack)
                    sliderFill.Size = UDim2.new(0, 0, 1, 0)
                    sliderFill.BackgroundColor3 = Colors.Active

                    local sliderKnob = Instance.new("Frame", sliderTrack)
                    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
                    sliderKnob.Position = UDim2.new(0, 0, -0.5, 0)
                    sliderKnob.BackgroundColor3 = Colors.Text

                    local knobStroke = Instance.new("UIStroke", sliderKnob)
                    knobStroke.Thickness = 1
                    knobStroke.Color = Colors.Accent

                    local value = opt.Default or opt.Min or 0
                    local min, max = opt.Min or 0, opt.Max or 100
                    local rounding = opt.Rounding or 0

                    local function updateSlider(inputPos)
                        local trackSize = sliderTrack.AbsoluteSize.X
                        local relativeX = math.clamp((inputPos - sliderTrack.AbsolutePosition.X) / trackSize, 0, 1)
                        value = min + (max - min) * relativeX
                        value = math.round(value * 10^rounding) / 10^rounding
                        sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
                        sliderKnob.Position = UDim2.new(relativeX, -8, -0.5, 0)
                        sliderLabel.Text = opt.Text .. ": " .. tostring(value)
                        opt.Callback(value)
                    end

                    sliderTrack.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            updateSlider(input.Position.X)
                        end
                    end)

                    sliderTrack.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            if input.UserInputState == Enum.UserInputState.Change then
                                updateSlider(input.Position.X)
                            end
                        end
                    end)

                    -- Initial setup
                    local initialRelative = (value - min) / (max - min)
                    sliderFill.Size = UDim2.new(initialRelative, 0, 1, 0)
                    sliderKnob.Position = UDim2.new(initialRelative, -8, -0.5, 0)
                    sliderLabel.Text = opt.Text .. ": " .. tostring(value)

                    return { Set = function(newValue) value = math.clamp(newValue, min, max); updateSlider(sliderTrack.AbsolutePosition.X + (newValue - min) / (max - min) * sliderTrack.AbsoluteSize.X) end }
                end

                -- Dropdown
                function Section:AddDropdown(key, opt)
                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 32)

                    local ddLabel = Instance.new("TextLabel", elemFrame)
                    ddLabel.Size = UDim2.new(1, -32, 0, 20)
                    ddLabel.BackgroundTransparency = 1
                    ddLabel.Font = Enum.Font.SourceSansPro
                    ddLabel.TextSize = 14
                    ddLabel.TextColor3 = Colors.Text
                    ddLabel.Text = opt.Text or "Dropdown"
                    ddLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local ddBtn = Instance.new("TextButton", elemFrame)
                    ddBtn.Size = UDim2.new(1, 0, 0, 24)
                    ddBtn.BackgroundColor3 = Colors.Secondary
                    ddBtn.Font = Enum.Font.SourceSansPro
                    ddBtn.TextSize = 14
                    ddBtn.TextColor3 = Colors.Text
                    ddBtn.Text = type(opt.Default) == "table" and table.concat(opt.Default, ", ") or opt.Values[opt.Default] or opt.Values[1]

                    local ddStroke = Instance.new("UIStroke", ddBtn)
                    ddStroke.Thickness = 1
                    ddStroke.Color = Colors.Accent

                    local ddList = Instance.new("Frame", elemFrame)
                    ddList.Size = UDim2.new(1, 0, 0, 0)
                    ddList.Position = UDim2.new(0, 0, 0, 32)
                    ddList.BackgroundColor3 = Colors.Secondary
                    ddList.Visible = false
                    ddList.AutomaticSize = Enum.AutomaticSize.Y

                    local listStroke = Instance.new("UIStroke", ddList)
                    listStroke.Thickness = 1
                    listStroke.Color = Colors.Accent

                    local listLayout = Instance.new("UIListLayout", ddList)
                    listLayout.Padding = UDim.new(0, 4)

                    local selected = opt.Multi and (opt.Default or {}) or (opt.Values[opt.Default] or opt.Values[1])

                    local function updateText()
                        ddBtn.Text = opt.Multi and table.concat(selected, ", ") or selected
                        opt.Callback(opt.Multi and selected or selected)
                    end

                    for _, value in ipairs(opt.Values) do
                        local optionBtn = Instance.new("TextButton", ddList)
                        optionBtn.Size = UDim2.new(1, 0, 0, 24)
                        optionBtn.BackgroundColor3 = Colors.Secondary
                        optionBtn.Font = Enum.Font.SourceSansPro
                        optionBtn.TextSize = 14
                        optionBtn.TextColor3 = Colors.Text
                        optionBtn.Text = value

                        local optStroke = Instance.new("UIStroke", optionBtn)
                        optStroke.Thickness = 1
                        optStroke.Color = Colors.Accent

                        optionBtn.MouseEnter:Connect(function() optionBtn.BackgroundColor3 = Colors.Hover end)
                        optionBtn.MouseLeave:Connect(function() optionBtn.BackgroundColor3 = Colors.Secondary end)

                        optionBtn.MouseButton1Click:Connect(function()
                            if opt.Multi then
                                selected[value] = not selected[value]
                            else
                                selected = value
                                ddList.Visible = false
                            end
                            updateText()
                        end)
                    end

                    ddBtn.MouseButton1Click:Connect(function()
                        ddList.Visible = not ddList.Visible
                    end)

                    updateText()

                    return { Set = function(value) selected = value; updateText(); ddList.Visible = false end }
                end

                return Section
            end

            Tab.AddLeftGroupbox = function(_, title) return createGroupbox(leftColumn, title) end
            Tab.AddRightGroupbox = function(_, title) return createGroupbox(rightColumn, title) end

            return Tab
        end

        -- External buttons
        local function createExternalButton(text, posY, callback)
            local btn = Instance.new("TextButton", ScreenGui)
            btn.Size = UDim2.new(0, 140, 0, 32)
            btn.Position = UDim2.new(0, 10, 0, posY)
            btn.BackgroundColor3 = Colors.Secondary
            btn.Font = Enum.Font.SourceSansPro
            btn.TextSize = 14
            btn.TextColor3 = Colors.Text
            btn.Text = text

            local btnStroke = Instance.new("UIStroke", btn)
            btnStroke.Thickness = 1
            btnStroke.Color = Colors.Accent

            btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Colors.Hover end)
            btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Colors.Secondary end)
            btn.MouseButton1Click:Connect(callback)

            return btn
        end

        createExternalButton("TOGGLE UI", 10, function() mainFrame.Visible = not mainFrame.Visible end)
        createExternalButton("LOCK UI", 50, function() dragLock = not dragLock end)

        return Window
    end

    return Library
end)()
