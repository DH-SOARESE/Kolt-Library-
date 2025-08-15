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

        local mainFrame = Instance.new("Frame", ScreenGui)
        mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        mainFrame.Size = UDim2.new(0, 500, 0, 300)
        mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)

        local mainCorner = Instance.new("UICorner", mainFrame)
        mainCorner.CornerRadius = UDim.new(0, 8)

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

        local titleCorner = Instance.new("UICorner", titleBar)
        titleCorner.CornerRadius = UDim.new(0, 8)

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

            local tabCorner = Instance.new("UICorner", tabBtn)
            tabCorner.CornerRadius = UDim.new(0, 6)

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

                local gbCorner = Instance.new("UICorner", groupbox)
                gbCorner.CornerRadius = UDim.new(0, 6)

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

                function Section:AddCheckbox(opt)
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

                    local cbCorner = Instance.new("UICorner", cbBtn)
                    cbCorner.CornerRadius = UDim.new(0, 4)

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

                function Section:AddSlider(opt)
                    local text = opt.Text or "Slider"
                    local min = opt.Min or 0
                    local max = opt.Max or 100
                    local default = opt.Default or min
                    local step = opt.Step or 1
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 40)

                    local sliderLabel = Instance.new("TextLabel", elemFrame)
                    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                    sliderLabel.BackgroundTransparency = 1
                    sliderLabel.Font = Enum.Font.Gotham
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderLabel.Text = text
                    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local sliderBar = Instance.new("Frame", elemFrame)
                    sliderBar.Size = UDim2.new(1, 0, 0, 6)
                    sliderBar.Position = UDim2.new(0, 0, 0, 25)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

                    local barCorner = Instance.new("UICorner", sliderBar)
                    barCorner.CornerRadius = UDim.new(0, 3)

                    local sliderFill = Instance.new("Frame", sliderBar)
                    sliderFill.Size = UDim2.new(0, 0, 1, 0)
                    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 102, 255)

                    local fillCorner = Instance.new("UICorner", sliderFill)
                    fillCorner.CornerRadius = UDim.new(0, 3)

                    local sliderValue = Instance.new("TextLabel", elemFrame)
                    sliderValue.Size = UDim2.new(0, 50, 0, 20)
                    sliderValue.Position = UDim2.new(1, -50, 0, 0)
                    sliderValue.BackgroundTransparency = 1
                    sliderValue.Font = Enum.Font.Gotham
                    sliderValue.TextSize = 14
                    sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderValue.Text = tostring(default)

                    local value = default
                    local function updateSlider(pos)
                        local percent = math.clamp((pos.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                        value = math.floor(min + percent * (max - min) / step) * step
                        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        sliderValue.Text = tostring(value)
                        callback(value)
                    end

                    local sliding = false
                    sliderBar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = true
                            updateSlider(input.Position)
                        end
                    end)

                    sliderBar.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = false
                        end
                    end)

                    UserInputService.InputChanged:Connect(function(input)
                        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input.Position)
                        end
                    end)

                    -- Set default
                    updateSlider(Vector2.new(sliderBar.AbsolutePosition.X + (default - min) / (max - min) * sliderBar.AbsoluteSize.X, 0))
                end

                function Section:AddDropdown(opt)
                    local text = opt.Text or "Dropdown"
                    local options = opt.Options or {}
                    local default = opt.Default or options[1]
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local ddLabel = Instance.new("TextLabel", elemFrame)
                    ddLabel.Size = UDim2.new(1, 0, 0, 20)
                    ddLabel.BackgroundTransparency = 1
                    ddLabel.Font = Enum.Font.Gotham
                    ddLabel.TextSize = 14
                    ddLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ddLabel.Text = text
                    ddLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local ddBtn = Instance.new("TextButton", elemFrame)
                    ddBtn.Size = UDim2.new(1, 0, 0, 25)
                    ddBtn.Position = UDim2.new(0, 0, 0, 20)
                    ddBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    ddBtn.Text = default or "Select"
                    ddBtn.Font = Enum.Font.Gotham
                    ddBtn.TextSize = 14
                    ddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local ddCorner = Instance.new("UICorner", ddBtn)
                    ddCorner.CornerRadius = UDim.new(0, 4)

                    local ddStroke = Instance.new("UIStroke", ddBtn)
                    ddStroke.Thickness = 1
                    ddStroke.Color = Color3.fromRGB(0, 102, 255)
                    ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local ddList = Instance.new("ScrollingFrame", elemFrame)
                    ddList.Size = UDim2.new(1, 0, 0, 100)
                    ddList.Position = UDim2.new(0, 0, 0, 45)
                    ddList.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                    ddList.Visible = false
                    ddList.ScrollBarThickness = 4
                    ddList.CanvasSize = UDim2.new(0, 0, 0, 0)
                    ddList.AutomaticCanvasSize = Enum.AutomaticSize.Y

                    local listCorner = Instance.new("UICorner", ddList)
                    listCorner.CornerRadius = UDim.new(0, 4)

                    local listStroke = Instance.new("UIStroke", ddList)
                    listStroke.Thickness = 1
                    listStroke.Color = Color3.fromRGB(0, 102, 255)
                    listStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local listLayout = Instance.new("UIListLayout", ddList)
                    listLayout.Padding = UDim.new(0, 2)
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

                    local listPad = Instance.new("UIPadding", ddList)
                    listPad.PaddingTop = UDim.new(0, 2)
                    listPad.PaddingBottom = UDim.new(0, 2)
                    listPad.PaddingLeft = UDim.new(0, 2)
                    listPad.PaddingRight = UDim.new(0, 2)

                    for _, option in ipairs(options) do
                        local optBtn = Instance.new("TextButton", ddList)
                        optBtn.Size = UDim2.new(1, 0, 0, 25)
                        optBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        optBtn.Text = option
                        optBtn.Font = Enum.Font.Gotham
                        optBtn.TextSize = 14
                        optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

                        local optCorner = Instance.new("UICorner", optBtn)
                        optCorner.CornerRadius = UDim.new(0, 4)

                        optBtn.MouseButton1Click:Connect(function()
                            ddBtn.Text = option
                            callback(option)
                            ddList.Visible = false
                        end)
                    end

                    ddBtn.MouseButton1Click:Connect(function()
                        ddList.Visible = not ddList.Visible
                    end)

                    -- Close on outside click
                    local function closeDropdown(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and ddList.Visible then
                            local absPos = ddList.AbsolutePosition
                            local absSize = ddList.AbsoluteSize
                            if not (input.Position.X >= absPos.X and input.Position.X <= absPos.X + absSize.X and input.Position.Y >= absPos.Y and input.Position.Y <= absPos.Y + absSize.Y) and
                               not (input.Position.X >= ddBtn.AbsolutePosition.X and input.Position.X <= ddBtn.AbsolutePosition.X + ddBtn.AbsoluteSize.X and input.Position.Y >= ddBtn.AbsolutePosition.Y and input.Position.Y <= ddBtn.AbsolutePosition.Y + ddBtn.AbsoluteSize.Y) then
                                ddList.Visible = false
                            end
                        end
                    end
                    UserInputService.InputBegan:Connect(closeDropdown)
                end

                function Section:AddMultiDropdown(opt)
                    local text = opt.Text or "Multi Dropdown"
                    local options = opt.Options or {}
                    local default = opt.Default or {}
                    local callback = opt.Callback or function() end

                    local selected = {}
                    for _, def in ipairs(default) do
                        selected[def] = true
                    end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local ddLabel = Instance.new("TextLabel", elemFrame)
                    ddLabel.Size = UDim2.new(1, 0, 0, 20)
                    ddLabel.BackgroundTransparency = 1
                    ddLabel.Font = Enum.Font.Gotham
                    ddLabel.TextSize = 14
                    ddLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ddLabel.Text = text
                    ddLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local ddBtn = Instance.new("TextButton", elemFrame)
                    ddBtn.Size = UDim2.new(1, 0, 0, 25)
                    ddBtn.Position = UDim2.new(0, 0, 0, 20)
                    ddBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    ddBtn.Text = table.concat(default, ", ") or "Select"
                    ddBtn.Font = Enum.Font.Gotham
                    ddBtn.TextSize = 14
                    ddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local ddCorner = Instance.new("UICorner", ddBtn)
                    ddCorner.CornerRadius = UDim.new(0, 4)

                    local ddStroke = Instance.new("UIStroke", ddBtn)
                    ddStroke.Thickness = 1
                    ddStroke.Color = Color3.fromRGB(0, 102, 255)
                    ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local ddList = Instance.new("ScrollingFrame", elemFrame)
                    ddList.Size = UDim2.new(1, 0, 0, 100)
                    ddList.Position = UDim2.new(0, 0, 0, 45)
                    ddList.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                    ddList.Visible = false
                    ddList.ScrollBarThickness = 4
                    ddList.CanvasSize = UDim2.new(0, 0, 0, 0)
                    ddList.AutomaticCanvasSize = Enum.AutomaticSize.Y

                    local listCorner = Instance.new("UICorner", ddList)
                    listCorner.CornerRadius = UDim.new(0, 4)

                    local listStroke = Instance.new("UIStroke", ddList)
                    listStroke.Thickness = 1
                    listStroke.Color = Color3.fromRGB(0, 102, 255)
                    listStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local listLayout = Instance.new("UIListLayout", ddList)
                    listLayout.Padding = UDim.new(0, 2)
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

                    local listPad = Instance.new("UIPadding", ddList)
                    listPad.PaddingTop = UDim.new(0, 2)
                    listPad.PaddingBottom = UDim.new(0, 2)
                    listPad.PaddingLeft = UDim.new(0, 2)
                    listPad.PaddingRight = UDim.new(0, 2)

                    local function updateText()
                        local sel = {}
                        for k in pairs(selected) do table.insert(sel, k) end
                        ddBtn.Text = table.concat(sel, ", ") or "Select"
                        callback(sel)
                    end

                    for _, option in ipairs(options) do
                        local optFrame = Instance.new("Frame", ddList)
                        optFrame.Size = UDim2.new(1, 0, 0, 25)
                        optFrame.BackgroundTransparency = 1

                        local optLabel = Instance.new("TextLabel", optFrame)
                        optLabel.Size = UDim2.new(1, -30, 1, 0)
                        optLabel.BackgroundTransparency = 1
                        optLabel.Font = Enum.Font.Gotham
                        optLabel.TextSize = 14
                        optLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        optLabel.Text = option
                        optLabel.TextXAlignment = Enum.TextXAlignment.Left

                        local optCb = Instance.new("TextButton", optFrame)
                        optCb.Size = UDim2.new(0, 20, 0, 20)
                        optCb.Position = UDim2.new(1, -25, 0, 2.5)
                        optCb.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        optCb.Text = ""

                        local optCorner = Instance.new("UICorner", optCb)
                        optCorner.CornerRadius = UDim.new(0, 4)

                        local optStroke = Instance.new("UIStroke", optCb)
                        optStroke.Thickness = 1
                        optStroke.Color = Color3.fromRGB(0, 102, 255)
                        optStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                        local optCheck = Instance.new("TextLabel", optCb)
                        optCheck.Size = UDim2.new(1, 0, 1, 0)
                        optCheck.BackgroundTransparency = 1
                        optCheck.Text = selected[option] and "✔" or ""
                        optCheck.TextColor3 = Color3.fromRGB(0, 255, 0)
                        optCheck.Font = Enum.Font.GothamBold
                        optCheck.TextSize = 16

                        optCb.MouseButton1Click:Connect(function()
                            selected[option] = not selected[option]
                            optCheck.Text = selected[option] and "✔" or ""
                            updateText()
                        end)
                    end

                    ddBtn.MouseButton1Click:Connect(function()
                        ddList.Visible = not ddList.Visible
                    end)

                    -- Close on outside click
                    local function closeDropdown(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and ddList.Visible then
                            local absPos = ddList.AbsolutePosition
                            local absSize = ddList.AbsoluteSize
                            if not (input.Position.X >= absPos.X and input.Position.X <= absPos.X + absSize.X and input.Position.Y >= absPos.Y and input.Position.Y <= absPos.Y + absSize.Y) and
                               not (input.Position.X >= ddBtn.AbsolutePosition.X and input.Position.X <= ddBtn.AbsolutePosition.X + ddBtn.AbsoluteSize.X and input.Position.Y >= ddBtn.AbsolutePosition.Y and input.Position.Y <= ddBtn.AbsolutePosition.Y + ddBtn.AbsoluteSize.Y) then
                                ddList.Visible = false
                            end
                        end
                    end
                    UserInputService.InputBegan:Connect(closeDropdown)
                end

                function Section:AddInput(opt)
                    local text = opt.Text or "Input"
                    local default = opt.Default or ""
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local inputLabel = Instance.new("TextLabel", elemFrame)
                    inputLabel.Size = UDim2.new(1, 0, 0, 20)
                    inputLabel.BackgroundTransparency = 1
                    inputLabel.Font = Enum.Font.Gotham
                    inputLabel.TextSize = 14
                    inputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    inputLabel.Text = text
                    inputLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local inputBox = Instance.new("TextBox", elemFrame)
                    inputBox.Size = UDim2.new(1, 0, 0, 25)
                    inputBox.Position = UDim2.new(0, 0, 0, 20)
                    inputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    inputBox.Text = default
                    inputBox.Font = Enum.Font.Gotham
                    inputBox.TextSize = 14
                    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    inputBox.ClearTextOnFocus = false

                    local inputCorner = Instance.new("UICorner", inputBox)
                    inputCorner.CornerRadius = UDim.new(0, 4)

                    local inputStroke = Instance.new("UIStroke", inputBox)
                    inputStroke.Thickness = 1
                    inputStroke.Color = Color3.fromRGB(0, 102, 255)
                    inputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    inputBox.FocusLost:Connect(function(enter)
                        if enter then
                            callback(inputBox.Text)
                        end
                    end)
                end

                function Section:AddButton(opt)
                    local text = opt.Text or "Button"
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local btn = Instance.new("TextButton", elemFrame)
                    btn.Size = UDim2.new(1, 0, 1, 0)
                    btn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                    btn.Font = Enum.Font.GothamBold
                    btn.TextSize = 14
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.Text = text

                    local btnCorner = Instance.new("UICorner", btn)
                    btnCorner.CornerRadius = UDim.new(0, 6)

                    local btnStroke = Instance.new("UIStroke", btn)
                    btnStroke.Thickness = 1
                    btnStroke.Color = Color3.fromRGB(0, 102, 255)
                    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    btn.MouseEnter:Connect(function()
                        btn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
                    end)

                    btn.MouseLeave:Connect(function()
                        btn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                    end)

                    btn.MouseButton1Click:Connect(callback)
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

                local gbCorner = Instance.new("UICorner", groupbox)
                gbCorner.CornerRadius = UDim.new(0, 6)

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

                -- Find the right column's list layout
                local rightList = rightColumn:FindFirstChildOfClass("UIListLayout")

                contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    rightColumn.CanvasSize = UDim2.new(0, 0, 0, rightList.AbsoluteContentSize.Y + 10)
                end)

                function Section:AddCheckbox(opt)
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

                    local cbCorner = Instance.new("UICorner", cbBtn)
                    cbCorner.CornerRadius = UDim.new(0, 4)

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

                function Section:AddSlider(opt)
                    local text = opt.Text or "Slider"
                    local min = opt.Min or 0
                    local max = opt.Max or 100
                    local default = opt.Default or min
                    local step = opt.Step or 1
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 40)

                    local sliderLabel = Instance.new("TextLabel", elemFrame)
                    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                    sliderLabel.BackgroundTransparency = 1
                    sliderLabel.Font = Enum.Font.Gotham
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderLabel.Text = text
                    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local sliderBar = Instance.new("Frame", elemFrame)
                    sliderBar.Size = UDim2.new(1, 0, 0, 6)
                    sliderBar.Position = UDim2.new(0, 0, 0, 25)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

                    local barCorner = Instance.new("UICorner", sliderBar)
                    barCorner.CornerRadius = UDim.new(0, 3)

                    local sliderFill = Instance.new("Frame", sliderBar)
                    sliderFill.Size = UDim2.new(0, 0, 1, 0)
                    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 102, 255)

                    local fillCorner = Instance.new("UICorner", sliderFill)
                    fillCorner.CornerRadius = UDim.new(0, 3)

                    local sliderValue = Instance.new("TextLabel", elemFrame)
                    sliderValue.Size = UDim2.new(0, 50, 0, 20)
                    sliderValue.Position = UDim2.new(1, -50, 0, 0)
                    sliderValue.BackgroundTransparency = 1
                    sliderValue.Font = Enum.Font.Gotham
                    sliderValue.TextSize = 14
                    sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderValue.Text = tostring(default)

                    local value = default
                    local function updateSlider(pos)
                        local percent = math.clamp((pos.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                        value = math.floor(min + percent * (max - min) / step) * step
                        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        sliderValue.Text = tostring(value)
                        callback(value)
                    end

                    local sliding = false
                    sliderBar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = true
                            updateSlider(input.Position)
                        end
                    end)

                    sliderBar.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            sliding = false
                        end
                    end)

                    UserInputService.InputChanged:Connect(function(input)
                        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input.Position)
                        end
                    end)

                    -- Set default
                    updateSlider(Vector2.new(sliderBar.AbsolutePosition.X + (default - min) / (max - min) * sliderBar.AbsoluteSize.X, 0))
                end

                function Section:AddDropdown(opt)
                    local text = opt.Text or "Dropdown"
                    local options = opt.Options or {}
                    local default = opt.Default or options[1]
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local ddLabel = Instance.new("TextLabel", elemFrame)
                    ddLabel.Size = UDim2.new(1, 0, 0, 20)
                    ddLabel.BackgroundTransparency = 1
                    ddLabel.Font = Enum.Font.Gotham
                    ddLabel.TextSize = 14
                    ddLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ddLabel.Text = text
                    ddLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local ddBtn = Instance.new("TextButton", elemFrame)
                    ddBtn.Size = UDim2.new(1, 0, 0, 25)
                    ddBtn.Position = UDim2.new(0, 0, 0, 20)
                    ddBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    ddBtn.Text = default or "Select"
                    ddBtn.Font = Enum.Font.Gotham
                    ddBtn.TextSize = 14
                    ddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local ddCorner = Instance.new("UICorner", ddBtn)
                    ddCorner.CornerRadius = UDim.new(0, 4)

                    local ddStroke = Instance.new("UIStroke", ddBtn)
                    ddStroke.Thickness = 1
                    ddStroke.Color = Color3.fromRGB(0, 102, 255)
                    ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local ddList = Instance.new("ScrollingFrame", elemFrame)
                    ddList.Size = UDim2.new(1, 0, 0, 100)
                    ddList.Position = UDim2.new(0, 0, 0, 45)
                    ddList.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                    ddList.Visible = false
                    ddList.ScrollBarThickness = 4
                    ddList.CanvasSize = UDim2.new(0, 0, 0, 0)
                    ddList.AutomaticCanvasSize = Enum.AutomaticSize.Y

                    local listCorner = Instance.new("UICorner", ddList)
                    listCorner.CornerRadius = UDim.new(0, 4)

                    local listStroke = Instance.new("UIStroke", ddList)
                    listStroke.Thickness = 1
                    listStroke.Color = Color3.fromRGB(0, 102, 255)
                    listStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local listLayout = Instance.new("UIListLayout", ddList)
                    listLayout.Padding = UDim.new(0, 2)
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

                    local listPad = Instance.new("UIPadding", ddList)
                    listPad.PaddingTop = UDim.new(0, 2)
                    listPad.PaddingBottom = UDim.new(0, 2)
                    listPad.PaddingLeft = UDim.new(0, 2)
                    listPad.PaddingRight = UDim.new(0, 2)

                    for _, option in ipairs(options) do
                        local optBtn = Instance.new("TextButton", ddList)
                        optBtn.Size = UDim2.new(1, 0, 0, 25)
                        optBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        optBtn.Text = option
                        optBtn.Font = Enum.Font.Gotham
                        optBtn.TextSize = 14
                        optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

                        local optCorner = Instance.new("UICorner", optBtn)
                        optCorner.CornerRadius = UDim.new(0, 4)

                        optBtn.MouseButton1Click:Connect(function()
                            ddBtn.Text = option
                            callback(option)
                            ddList.Visible = false
                        end)
                    end

                    ddBtn.MouseButton1Click:Connect(function()
                        ddList.Visible = not ddList.Visible
                    end)

                    -- Close on outside click
                    local function closeDropdown(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and ddList.Visible then
                            local absPos = ddList.AbsolutePosition
                            local absSize = ddList.AbsoluteSize
                            if not (input.Position.X >= absPos.X and input.Position.X <= absPos.X + absSize.X and input.Position.Y >= absPos.Y and input.Position.Y <= absPos.Y + absSize.Y) and
                               not (input.Position.X >= ddBtn.AbsolutePosition.X and input.Position.X <= ddBtn.AbsolutePosition.X + ddBtn.AbsoluteSize.X and input.Position.Y >= ddBtn.AbsolutePosition.Y and input.Position.Y <= ddBtn.AbsolutePosition.Y + ddBtn.AbsoluteSize.Y) then
                                ddList.Visible = false
                            end
                        end
                    end
                    UserInputService.InputBegan:Connect(closeDropdown)
                end

                function Section:AddMultiDropdown(opt)
                    local text = opt.Text or "Multi Dropdown"
                    local options = opt.Options or {}
                    local default = opt.Default or {}
                    local callback = opt.Callback or function() end

                    local selected = {}
                    for _, def in ipairs(default) do
                        selected[def] = true
                    end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local ddLabel = Instance.new("TextLabel", elemFrame)
                    ddLabel.Size = UDim2.new(1, 0, 0, 20)
                    ddLabel.BackgroundTransparency = 1
                    ddLabel.Font = Enum.Font.Gotham
                    ddLabel.TextSize = 14
                    ddLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ddLabel.Text = text
                    ddLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local ddBtn = Instance.new("TextButton", elemFrame)
                    ddBtn.Size = UDim2.new(1, 0, 0, 25)
                    ddBtn.Position = UDim2.new(0, 0, 0, 20)
                    ddBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    ddBtn.Text = table.concat(default, ", ") or "Select"
                    ddBtn.Font = Enum.Font.Gotham
                    ddBtn.TextSize = 14
                    ddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local ddCorner = Instance.new("UICorner", ddBtn)
                    ddCorner.CornerRadius = UDim.new(0, 4)

                    local ddStroke = Instance.new("UIStroke", ddBtn)
                    ddStroke.Thickness = 1
                    ddStroke.Color = Color3.fromRGB(0, 102, 255)
                    ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local ddList = Instance.new("ScrollingFrame", elemFrame)
                    ddList.Size = UDim2.new(1, 0, 0, 100)
                    ddList.Position = UDim2.new(0, 0, 0, 45)
                    ddList.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
                    ddList.Visible = false
                    ddList.ScrollBarThickness = 4
                    ddList.CanvasSize = UDim2.new(0, 0, 0, 0)
                    ddList.AutomaticCanvasSize = Enum.AutomaticSize.Y

                    local listCorner = Instance.new("UICorner", ddList)
                    listCorner.CornerRadius = UDim.new(0, 4)

                    local listStroke = Instance.new("UIStroke", ddList)
                    listStroke.Thickness = 1
                    listStroke.Color = Color3.fromRGB(0, 102, 255)
                    listStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    local listLayout = Instance.new("UIListLayout", ddList)
                    listLayout.Padding = UDim.new(0, 2)
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

                    local listPad = Instance.new("UIPadding", ddList)
                    listPad.PaddingTop = UDim.new(0, 2)
                    listPad.PaddingBottom = UDim.new(0, 2)
                    listPad.PaddingLeft = UDim.new(0, 2)
                    listPad.PaddingRight = UDim.new(0, 2)

                    local function updateText()
                        local sel = {}
                        for k in pairs(selected) do table.insert(sel, k) end
                        ddBtn.Text = table.concat(sel, ", ") or "Select"
                        callback(sel)
                    end

                    for _, option in ipairs(options) do
                        local optFrame = Instance.new("Frame", ddList)
                        optFrame.Size = UDim2.new(1, 0, 0, 25)
                        optFrame.BackgroundTransparency = 1

                        local optLabel = Instance.new("TextLabel", optFrame)
                        optLabel.Size = UDim2.new(1, -30, 1, 0)
                        optLabel.BackgroundTransparency = 1
                        optLabel.Font = Enum.Font.Gotham
                        optLabel.TextSize = 14
                        optLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        optLabel.Text = option
                        optLabel.TextXAlignment = Enum.TextXAlignment.Left

                        local optCb = Instance.new("TextButton", optFrame)
                        optCb.Size = UDim2.new(0, 20, 0, 20)
                        optCb.Position = UDim2.new(1, -25, 0, 2.5)
                        optCb.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                        optCb.Text = ""

                        local optCorner = Instance.new("UICorner", optCb)
                        optCorner.CornerRadius = UDim.new(0, 4)

                        local optStroke = Instance.new("UIStroke", optCb)
                        optStroke.Thickness = 1
                        optStroke.Color = Color3.fromRGB(0, 102, 255)
                        optStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                        local optCheck = Instance.new("TextLabel", optCb)
                        optCheck.Size = UDim2.new(1, 0, 1, 0)
                        optCheck.BackgroundTransparency = 1
                        optCheck.Text = selected[option] and "✔" or ""
                        optCheck.TextColor3 = Color3.fromRGB(0, 255, 0)
                        optCheck.Font = Enum.Font.GothamBold
                        optCheck.TextSize = 16

                        optCb.MouseButton1Click:Connect(function()
                            selected[option] = not selected[option]
                            optCheck.Text = selected[option] and "✔" or ""
                            updateText()
                        end)
                    end

                    ddBtn.MouseButton1Click:Connect(function()
                        ddList.Visible = not ddList.Visible
                    end)

                    -- Close on outside click
                    local function closeDropdown(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and ddList.Visible then
                            local absPos = ddList.AbsolutePosition
                            local absSize = ddList.AbsoluteSize
                            if not (input.Position.X >= absPos.X and input.Position.X <= absPos.X + absSize.X and input.Position.Y >= absPos.Y and input.Position.Y <= absPos.Y + absSize.Y) and
                               not (input.Position.X >= ddBtn.AbsolutePosition.X and input.Position.X <= ddBtn.AbsolutePosition.X + ddBtn.AbsoluteSize.X and input.Position.Y >= ddBtn.AbsolutePosition.Y and input.Position.Y <= ddBtn.AbsolutePosition.Y + ddBtn.AbsoluteSize.Y) then
                                ddList.Visible = false
                            end
                        end
                    end
                    UserInputService.InputBegan:Connect(closeDropdown)
                end

                function Section:AddInput(opt)
                    local text = opt.Text or "Input"
                    local default = opt.Default or ""
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local inputLabel = Instance.new("TextLabel", elemFrame)
                    inputLabel.Size = UDim2.new(1, 0, 0, 20)
                    inputLabel.BackgroundTransparency = 1
                    inputLabel.Font = Enum.Font.Gotham
                    inputLabel.TextSize = 14
                    inputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    inputLabel.Text = text
                    inputLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local inputBox = Instance.new("TextBox", elemFrame)
                    inputBox.Size = UDim2.new(1, 0, 0, 25)
                    inputBox.Position = UDim2.new(0, 0, 0, 20)
                    inputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    inputBox.Text = default
                    inputBox.Font = Enum.Font.Gotham
                    inputBox.TextSize = 14
                    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    inputBox.ClearTextOnFocus = false

                    local inputCorner = Instance.new("UICorner", inputBox)
                    inputCorner.CornerRadius = UDim.new(0, 4)

                    local inputStroke = Instance.new("UIStroke", inputBox)
                    inputStroke.Thickness = 1
                    inputStroke.Color = Color3.fromRGB(0, 102, 255)
                    inputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    inputBox.FocusLost:Connect(function(enter)
                        if enter then
                            callback(inputBox.Text)
                        end
                    end)
                end

                function Section:AddButton(opt)
                    local text = opt.Text or "Button"
                    local callback = opt.Callback or function() end

                    local elemFrame = Instance.new("Frame", contentFrame)
                    elemFrame.BackgroundTransparency = 1
                    elemFrame.Size = UDim2.new(1, 0, 0, 30)

                    local btn = Instance.new("TextButton", elemFrame)
                    btn.Size = UDim2.new(1, 0, 1, 0)
                    btn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                    btn.Font = Enum.Font.GothamBold
                    btn.TextSize = 14
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.Text = text

                    local btnCorner = Instance.new("UICorner", btn)
                    btnCorner.CornerRadius = UDim.new(0, 6)

                    local btnStroke = Instance.new("UIStroke", btn)
                    btnStroke.Thickness = 1
                    btnStroke.Color = Color3.fromRGB(0, 102, 255)
                    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    btn.MouseEnter:Connect(function()
                        btn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
                    end)

                    btn.MouseLeave:Connect(function()
                        btn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
                    end)

                    btn.MouseButton1Click:Connect(callback)
                end

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

            local btnCorner = Instance.new("UICorner", btn)
            btnCorner.CornerRadius = UDim.new(0, 6)

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
