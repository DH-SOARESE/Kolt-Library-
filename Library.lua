return (function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer

    local G2L = {}

    -- ScreenGui
    G2L["ScreenGui_1"] = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    G2L["ScreenGui_1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    G2L["ScreenGui_1"].Name = "KOLT_UI"

    -- Frame Principal
    local mainFrame = Instance.new("Frame", G2L["ScreenGui_1"])
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    mainFrame.Size = UDim2.new(0, 500, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)

    local mainStroke = Instance.new("UIStroke", mainFrame)
    mainStroke.Thickness = 2
    mainStroke.Color = Color3.fromRGB(0, 102, 255)
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Arraste
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

    mainFrame.InputBegan:Connect(onInputBegan)
    UserInputService.InputChanged:Connect(onInputChanged)
    UserInputService.InputEnded:Connect(onInputEnded)

    -- Barra de título
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    titleBar.Size = UDim2.new(1, 0, 0, 40)

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
    titleLabel.Text = "KOLT UI"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Tabs
    local tabHolder = Instance.new("Frame", mainFrame)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Size = UDim2.new(1, -20, 0, 30)
    tabHolder.Position = UDim2.new(0, 10, 0, 45)

    local UIList = Instance.new("UIListLayout", tabHolder)
    UIList.FillDirection = Enum.FillDirection.Horizontal
    UIList.Padding = UDim.new(0, 6)

    local tabs, contents = {}, {}

    local function createTab(name)
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

        local page = Instance.new("Frame", mainFrame)
        page.BackgroundTransparency = 1
        page.Size = UDim2.new(1, -20, 1, -85)
        page.Position = UDim2.new(0, 10, 0, 80)
        page.Visible = false

        local leftSection = Instance.new("Frame", page)
        leftSection.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        leftSection.Size = UDim2.new(0.48, 0, 1, 0)
        leftSection.Position = UDim2.new(0,0,0,0)

        local rightSection = Instance.new("Frame", page)
        rightSection.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
        rightSection.Size = UDim2.new(0.48, 0, 1, 0)
        rightSection.Position = UDim2.new(0.52,0,0,0)

        tabs[tabBtn] = page
        contents[name] = {Left = leftSection, Right = rightSection}

        tabBtn.MouseButton1Click:Connect(function()
            for tBtn, p in pairs(tabs) do
                p.Visible = false
                tBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            end
            page.Visible = true
            tabBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 255)
        end)

        return contents[name]
    end

    -- Botões externos flat
    local function createButton(text, posY, callback)
        local btn = Instance.new("TextButton", G2L["ScreenGui_1"])
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

        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(35,35,45) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(25,25,35) end)
        btn.MouseButton1Click:Connect(callback)

        return btn
    end

    -- Criando tabs padrão
    local tab1 = createTab("Main")
    local tab2 = createTab("Settings")
    tabs[tabHolder:FindFirstChildOfClass("TextButton")].Visible = true
    tabHolder:FindFirstChildOfClass("TextButton").BackgroundColor3 = Color3.fromRGB(0,102,255)

    -- Criando botões padrão
    createButton("TOGGLE UI", 12, function() mainFrame.Visible = not mainFrame.Visible end)
    createButton("LOCK UI", 52, function() dragLock = not dragLock end)

    return {
        ScreenGui = G2L["ScreenGui_1"],
        CreateTab = createTab,
        CreateButton = createButton,
        Contents = contents
    }
end)()
