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

        local mainStroke = Instance.new("UIStroke", mainFrame)
        mainStroke.Thickness = 2
        mainStroke.Color = Color3.fromRGB(0, 102, 255)
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        -- Melhoria no sistema de arrastar para suportar toque
        local dragging = false
        local dragStart
        local startPos

        local function onInputBegan(input, gameProcessed)
            -- Verifica se o tipo de entrada é MouseButton1 ou Touch e se o evento não é processado pelo jogo
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not gameProcessed then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
            end
        end

        local function onInputChanged(input, gameProcessed)
            -- Garante que o arrastar só funcione com o tipo de entrada correto e se a interface estiver sendo arrastada
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end

        local function onInputEnded(input)
            -- Reseta o estado de arrastar no final do clique/toque
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end

        UserInputService.InputBegan:Connect(onInputBegan)
        UserInputService.InputChanged:Connect(onInputChanged)
        UserInputService.InputEnded:Connect(onInputEnded)

        local titleBar = Instance.new("Frame", mainFrame)
        titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        titleBar.Size = UDim2.new(1, 0, 0, 40)
        
        -- Evento de arrastar conectado diretamente à barra de título
        titleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
            end
        end)
        
        -- Garante que o arrastar pare mesmo se o input terminar fora da titleBar
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

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
            leftColumn.AutomaticCanvasSize = Enum.AutomaticSize.Y

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

            tabBtn.Activated:Connect(function() -- Usa Activated para compatibilidade total com toque/clique
                for tBtn, p in pairs(tabs) do
                    p.Visible = false
                    tBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                end
                page.Visible = true
                tabBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
            end)

            if not next(tabs) then -- Simplificado para checar se é a primeira aba
                page.Visible = true
                tabBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
            end

            function Tab:AddLeftGroupbox(title)
                local Section = {}

                local groupbox = Instance.new("Frame", leftColumn)
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
                    leftColumn.CanvasSize = UDim2.new(0, 0, 0, leftList.AbsoluteContentSize.Y + 10)
                end)

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
                    cbBtn.Activated:Connect(function() -- Usa Activated para clique/toque
                        state = not state
                        checkMark.Text = state and "✔" or ""
                        callback(state)
                    end)
                end

                return Section
            end

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
                    rightColumn.CanvasSize = UDim2.new(0, 0, 0, rightColumn:FindFirstChild("UIListLayout").AbsoluteContentSize.Y + 10)
                end)

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
                    cbBtn.Activated:Connect(function() -- Usa Activated para clique/toque
                        state = not state
                        checkMark.Text = state and "✔" or ""
                        callback(state)
                    end)
                end

                return Section
            end

            return Tab
        end

        -- Botões externos adaptados para toque
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

            -- Evento Activated para clique/toque
            btn.Activated:Connect(callback) 
            
            -- Para mobile, eventos de hover não são práticos, mas podemos manter para PC
            btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45) end)
            btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35) end)

            return btn
        end

        createExternalButton("TOGGLE UI", 12, function() mainFrame.Visible = not mainFrame.Visible end)
        createExternalButton("LOCK UI", 52, function() dragLock = not dragLock end)

        return Window
    end

    return Library
end)()
