-- ModuleScript for Kolt UI Library
-- Place this in a ModuleScript and require it in a LocalScript

local KoltUI = {}

local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")

function KoltUI.new(title)
    local self = setmetatable({}, {__index = KoltUI})
    self.Tabs = {}
    self.ActiveTab = nil

    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Ui Kolt"
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    CollectionService:AddTag(ScreenGui, "main")

    -- FEATURES Folder
    local FEATURES = Instance.new("Folder", ScreenGui)
    FEATURES.Name = "FEATURES"
    FEATURES.Visible = false  -- Hide templates

    -- SLIDER Template
    local SLIDER = Instance.new("Folder", FEATURES)
    SLIDER.Name = "SLIDER"
    local BACKGROUND_ = Instance.new("Frame", SLIDER)
    BACKGROUND_.Name = "BACKGROUND "
    BACKGROUND_.ZIndex = 11
    BACKGROUND_.BorderSizePixel = 0
    BACKGROUND_.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND_.Size = UDim2.new(0, 198, 0, 20)
    local PROGRESSBAR = Instance.new("Frame", BACKGROUND_)
    PROGRESSBAR.Name = "PROGRESSBAR"
    PROGRESSBAR.BorderSizePixel = 0
    PROGRESSBAR.BackgroundColor3 = Color3.fromRGB(0, 0, 242)
    PROGRESSBAR.Size = UDim2.new(0, 194, 0, 16)
    PROGRESSBAR.Position = UDim2.new(0, 2, 0, 2)
    local VALUE_ = Instance.new("TextLabel", BACKGROUND_)
    VALUE_.Name = " VALUE"
    VALUE_.BorderSizePixel = 0
    VALUE_.TextSize = 10
    VALUE_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VALUE_.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    VALUE_.TextColor3 = Color3.fromRGB(255, 255, 255)
    VALUE_.BackgroundTransparency = 1
    VALUE_.Size = UDim2.new(0, 188, 0, 20)
    VALUE_.Text = "VALUE/VALUE"
    local UIStroke1 = Instance.new("UIStroke", BACKGROUND_)
    UIStroke1.Color = Color3.fromRGB(0, 0, 255)

    -- CHECKBOX Template
    local CHECKBOX = Instance.new("Folder", FEATURES)
    CHECKBOX.Name = "CHECKBOX"
    local Background = Instance.new("Frame", CHECKBOX)
    Background.Name = "Background"
    Background.ZIndex = 11
    Background.BorderSizePixel = 0
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.Size = UDim2.new(0, 18, 0, 18)
    local UICorner1 = Instance.new("UICorner", Background)
    UICorner1.CornerRadius = UDim.new(0, 2)
    local ON = Instance.new("Frame", Background)
    ON.Name = "ON"
    ON.Visible = false
    ON.BorderSizePixel = 0
    ON.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    ON.Size = UDim2.new(0, 14, 0, 14)
    ON.Position = UDim2.new(0, 2, 0, 2)
    local UICorner2 = Instance.new("UICorner", ON)
    UICorner2.CornerRadius = UDim.new(0, 2)
    local UIStroke2 = Instance.new("UIStroke", Background)
    UIStroke2.Color = Color3.fromRGB(0, 0, 255)
    local TextLabel = Instance.new("TextLabel", Background)
    TextLabel.BorderSizePixel = 0
    TextLabel.TextSize = 12
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(0, 178, 0, 18)
    TextLabel.Position = UDim2.new(0, 22, 0, 0)
    TextLabel.Text = "CHECKBOX"
    local OFF = Instance.new("Frame", Background)
    OFF.Name = "OFF"
    OFF.BorderSizePixel = 0
    OFF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OFF.Size = UDim2.new(0, 14, 0, 14)
    OFF.Position = UDim2.new(0, 2, 0, 2)
    OFF.BackgroundTransparency = 1
    local UIStroke3 = Instance.new("UIStroke", OFF)
    UIStroke3.Color = Color3.fromRGB(0, 0, 255)
    local UICorner3 = Instance.new("UICorner", OFF)
    UICorner3.CornerRadius = UDim.new(0, 2)

    -- BUTTON Template
    local BUTTON = Instance.new("Folder", FEATURES)
    BUTTON.Name = "BUTTON"
    local TextButton = Instance.new("TextButton", BUTTON)
    TextButton.BorderSizePixel = 0
    TextButton.TextSize = 12
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    TextButton.ZIndex = 11
    TextButton.Size = UDim2.new(0, 198, 0, 20)
    TextButton.Text = "Click Me"
    local UIStroke4 = Instance.new("UIStroke", TextButton)
    UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke4.Thickness = 0.9
    UIStroke4.Color = Color3.fromRGB(0, 0, 255)

    -- SEÇÃO Template
    local SEÇÃO = Instance.new("Folder", FEATURES)
    SEÇÃO.Name = "SEÇÃO"
    local CONTAINER = Instance.new("Frame", SEÇÃO)
    CONTAINER.Name = "CONTAINER"
    CONTAINER.ZIndex = 9
    CONTAINER.BorderSizePixel = 0
    CONTAINER.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CONTAINER.Size = UDim2.new(0, 206, 0, 112)
    CONTAINER.BackgroundTransparency = 1
    local NAME = Instance.new("TextLabel", CONTAINER)
    NAME.Name = "NAME"
    NAME.ZIndex = 11
    NAME.BorderSizePixel = 0
    NAME.TextSize = 12
    NAME.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NAME.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    NAME.TextColor3 = Color3.fromRGB(255, 255, 255)
    NAME.Size = UDim2.new(0, 40, 0, 8)
    NAME.Text = "NAME"
    NAME.Position = UDim2.new(0, 14, 0, -4)
    local UIStroke5 = Instance.new("UIStroke", CONTAINER)
    UIStroke5.Color = Color3.fromRGB(0, 0, 255)

    -- TAB_BUTTON Template
    local TAB_BUTTON = Instance.new("Folder", FEATURES)
    TAB_BUTTON.Name = "TAB_BUTTON"
    local Button_Tab = Instance.new("TextButton", TAB_BUTTON)
    Button_Tab.Name = "Button_Tab"
    Button_Tab.BorderSizePixel = 0
    Button_Tab.TextSize = 15
    Button_Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button_Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Button_Tab.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    Button_Tab.ZIndex = 10
    Button_Tab.Size = UDim2.new(0, 48, 0, 20)
    Button_Tab.Text = "TAB"
    local UIStroke6 = Instance.new("UIStroke", Button_Tab)
    UIStroke6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke6.Thickness = 2
    UIStroke6.Color = Color3.fromRGB(0, 0, 255)

    -- UI OPEN/LOCK
    local UI_OPEN_LOCK = Instance.new("Folder", ScreenGui)
    UI_OPEN_LOCK.Name = "UI OPEN/LOCK"
    local Show_Hide = Instance.new("TextButton", UI_OPEN_LOCK)
    Show_Hide.Name = "Show/Hide"
    Show_Hide.BorderSizePixel = 0
    Show_Hide.TextSize = 17
    Show_Hide.TextColor3 = Color3.fromRGB(255, 255, 255)
    Show_Hide.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Show_Hide.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    Show_Hide.ZIndex = 999
    Show_Hide.Size = UDim2.new(0, 86, 0, 30)
    Show_Hide.Text = "Toggle UI"
    Show_Hide.Position = UDim2.new(0, 4, 0, 20)
    local UIStroke7 = Instance.new("UIStroke", Show_Hide)
    UIStroke7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke7.Thickness = 2
    UIStroke7.Color = Color3.fromRGB(0, 0, 255)
    local Lock_Unlock = Instance.new("TextButton", UI_OPEN_LOCK)
    Lock_Unlock.Name = "Lock/Unlock"
    Lock_Unlock.BorderSizePixel = 0
    Lock_Unlock.TextSize = 20
    Lock_Unlock.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lock_Unlock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Lock_Unlock.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    Lock_Unlock.ZIndex = 999
    Lock_Unlock.Size = UDim2.new(0, 86, 0, 30)
    Lock_Unlock.Text = "Lock"
    Lock_Unlock.Position = UDim2.new(0, 4, 0, 52)
    local UIStroke8 = Instance.new("UIStroke", Lock_Unlock)
    UIStroke8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke8.Thickness = 2
    UIStroke8.Color = Color3.fromRGB(0, 0, 255)
    local BACKGROUND_open = Instance.new("Frame", UI_OPEN_LOCK)
    BACKGROUND_open.Name = "BACKGROUND"
    BACKGROUND_open.ZIndex = 998
    BACKGROUND_open.BorderSizePixel = 0
    BACKGROUND_open.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND_open.Size = UDim2.new(0, 96, 0, 70)
    BACKGROUND_open.Position = UDim2.new(0, -2, 0, 16)

    -- UI Folder
    local UI = Instance.new("Folder", ScreenGui)
    UI.Name = "UI"

    -- MENU
    local MENU = Instance.new("Frame", UI)
    MENU.Name = "MENU"
    MENU.ZIndex = 6
    MENU.BorderSizePixel = 0
    MENU.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MENU.Size = UDim2.new(0, 454, 0, 278)
    MENU.Position = UDim2.new(0, 98, 0, 20)
    local BACKGROUND_menu = Instance.new("Frame", MENU)
    BACKGROUND_menu.Name = "BACKGROUND"
    BACKGROUND_menu.BorderSizePixel = 0
    BACKGROUND_menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND_menu.Size = UDim2.new(0, 454, 0, 278)
    local BACKGROUND_inner = Instance.new("Frame", BACKGROUND_menu)
    BACKGROUND_inner.Name = "BACKGROUND"
    BACKGROUND_inner.BorderSizePixel = 0
    BACKGROUND_inner.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND_inner.Size = UDim2.new(0, 442, 0, 234)
    BACKGROUND_inner.Position = UDim2.new(0, 6, 0, 40)
    local TABs = Instance.new("Frame", BACKGROUND_inner)
    TABs.Name = "TABs"
    TABs.BorderSizePixel = 0
    TABs.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TABs.Size = UDim2.new(0, 434, 0, 32)
    TABs.Position = UDim2.new(0, 4, 0, 4)
    local Scrolli_Tabs = Instance.new("ScrollingFrame", TABs)
    Scrolli_Tabs.Name = "Scrolli Tabs"
    Scrolli_Tabs.ScrollingDirection = Enum.ScrollingDirection.X
    Scrolli_Tabs.BorderSizePixel = 0
    Scrolli_Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Scrolli_Tabs.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    Scrolli_Tabs.AutomaticCanvasSize = Enum.AutomaticSize.X
    Scrolli_Tabs.Size = UDim2.new(0, 418, 0, 28)
    Scrolli_Tabs.Position = UDim2.new(0, 2, 0, 2)
    Scrolli_Tabs.BackgroundTransparency = 1
    local UIStroke9 = Instance.new("UIStroke", TABs)
    UIStroke9.Color = Color3.fromRGB(0, 0, 255)
    local UIStroke10 = Instance.new("UIStroke", BACKGROUND_inner)
    UIStroke10.Color = Color3.fromRGB(0, 0, 255)
    local UIStroke11 = Instance.new("UIStroke", BACKGROUND_menu)
    UIStroke11.Color = Color3.fromRGB(0, 0, 255)
    local TITLE = Instance.new("Frame", MENU)
    TITLE.Name = "TITLE"
    TITLE.BorderSizePixel = 0
    TITLE.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TITLE.Size = UDim2.new(0, 442, 0, 28)
    TITLE.Position = UDim2.new(0, 6, 0, 4)
    local TextLabel_title = Instance.new("TextLabel", TITLE)
    TextLabel_title.BorderSizePixel = 0
    TextLabel_title.TextSize = 18
    TextLabel_title.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel_title.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_title.BackgroundTransparency = 1
    TextLabel_title.Size = UDim2.new(0, 438, 0, 28)
    TextLabel_title.Position = UDim2.new(0, 4, 0, 0)
    TextLabel_title.Text = title
    local UIStroke12 = Instance.new("UIStroke", TITLE)
    UIStroke12.Color = Color3.fromRGB(0, 0, 255)
    local Frame_divider = Instance.new("Frame", TITLE)
    Frame_divider.BorderSizePixel = 0
    Frame_divider.BackgroundColor3 = Color3.fromRGB(129, 65, 255)
    Frame_divider.Size = UDim2.new(0, 442, 0, 2)
    Frame_divider.Position = UDim2.new(0, 0, 0, 31)
    local UICorner4 = Instance.new("UICorner", Frame_divider)
    local Left = Instance.new("Frame", MENU)
    Left.Name = "Left"
    Left.ZIndex = 6
    Left.BorderSizePixel = 0
    Left.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Left.Size = UDim2.new(0, 214, 0, 190)
    Left.Position = UDim2.new(0, 10, 0, 80)
    local UIStroke13 = Instance.new("UIStroke", Left)
    UIStroke13.Color = Color3.fromRGB(0, 0, 255)
    local Scroll_Left = Instance.new("ScrollingFrame", Left)
    Scroll_Left.Name = "Scroll Left"
    Scroll_Left.ScrollingDirection = Enum.ScrollingDirection.Y
    Scroll_Left.BorderSizePixel = 0
    Scroll_Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Scroll_Left.ScrollBarImageTransparency = 1
    Scroll_Left.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll_Left.Size = UDim2.new(0, 214, 0, 190)
    Scroll_Left.BackgroundTransparency = 1
    local Right = Instance.new("Frame", MENU)
    Right.Name = "Right"
    Right.ZIndex = 6
    Right.BorderSizePixel = 0
    Right.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Right.Size = UDim2.new(0, 214, 0, 190)
    Right.Position = UDim2.new(0, 230, 0, 80)
    local UIStroke14 = Instance.new("UIStroke", Right)
    UIStroke14.Color = Color3.fromRGB(0, 0, 255)
    local Scroll_Right = Instance.new("ScrollingFrame", Right)
    Scroll_Right.Name = "Scroll Right"
    Scroll_Right.ScrollingDirection = Enum.ScrollingDirection.Y
    Scroll_Right.BorderSizePixel = 0
    Scroll_Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Scroll_Right.ScrollBarImageTransparency = 1
    Scroll_Right.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll_Right.Size = UDim2.new(0, 214, 0, 190)
    Scroll_Right.BackgroundTransparency = 1

    -- Hide original Left and Right
    Left.Visible = false
    Right.Visible = false

    -- Tab scroll layout
    local TabLayout = Instance.new("UIListLayout", Scrolli_Tabs)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 4)

    -- Drag functionality
    local dragEnabled = true
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function updateDrag(input)
        local delta = input.Position - dragStart
        MENU.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    TITLE.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragEnabled then
            dragging = true
            dragStart = input.Position
            startPos = MENU.Position
            local conn
            conn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    conn:Disconnect()
                end
            end)
        end
    end)

    TITLE.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)

    -- Toggle UI
    Show_Hide.MouseButton1Click:Connect(function()
        MENU.Visible = not MENU.Visible
    end)

    -- Lock/Unlock (toggle drag)
    local locked = false
    Lock_Unlock.MouseButton1Click:Connect(function()
        locked = not locked
        if locked then
            Lock_Unlock.Text = "Unlock"
            dragEnabled = false
        else
            Lock_Unlock.Text = "Lock"
            dragEnabled = true
        end
    end)

    -- CreateTab function
    function self:CreateTab(name)
        local tab = {}
        tab.Sections = {}

        local button = FEATURES.TAB_BUTTON.Button_Tab:Clone()
        button.Text = name
        button.Parent = Scrolli_Tabs
        button.Visible = true

        local tabLeft = Left:Clone()
        tabLeft.Name = name .. "_Left"
        tabLeft.Parent = MENU
        tabLeft.Visible = false
        tabLeft.Position = Left.Position  -- Overlap

        local tabRight = Right:Clone()
        tabRight.Name = name .. "_Right"
        tabRight.Parent = MENU
        tabRight.Visible = false
        tabRight.Position = Right.Position  -- Overlap

        -- Layouts for scrolls
        local leftLayout = Instance.new("UIListLayout", tabLeft["Scroll Left"])
        leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        leftLayout.Padding = UDim.new(0, 4)

        local rightLayout = Instance.new("UIListLayout", tabRight["Scroll Right"])
        rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rightLayout.Padding = UDim.new(0, 4)

        tab.Left = tabLeft
        tab.Right = tabRight
        tab.Button = button

        self.Tabs[name] = tab

        button.MouseButton1Click:Connect(function()
            self:SelectTab(name)
        end)

        if not self.ActiveTab then
            self:SelectTab(name)
        end

        -- CreateSection function for this tab
        function tab:CreateSection(sectionName, side)
            side = side:lower()
            local scroll
            if side == "left" then
                scroll = self.Left["Scroll Left"]
            elseif side == "right" then
                scroll = self.Right["Scroll Right"]
            else
                error("Side must be 'Left' or 'Right'")
            end

            local container = FEATURES.SEÇÃO.CONTAINER:Clone()
            container.NAME.Text = sectionName
            container.Parent = scroll
            container.Visible = true
            container.Size = UDim2.new(1, 0, 0, 0)
            container.AutomaticSize = Enum.AutomaticSize.Y

            local sectionLayout = Instance.new("UIListLayout", container)
            sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionLayout.Padding = UDim.new(0, 4)

            local sectionPadding = Instance.new("UIPadding", container)
            sectionPadding.PaddingTop = UDim.new(0, 8)
            sectionPadding.PaddingLeft = UDim.new(0, 4)
            sectionPadding.PaddingRight = UDim.new(0, 4)
            sectionPadding.PaddingBottom = UDim.new(0, 4)

            local sectionObj = {}
            sectionObj.Container = container

            -- CreateButton
            function sectionObj:CreateButton(buttonName, callback)
                local btn = FEATURES.BUTTON.TextButton:Clone()
                btn.Text = buttonName
                btn.Parent = container
                btn.Visible = true
                btn.Size = UDim2.new(1, 0, 0, 20)
                btn.Activated:Connect(callback)
            end

            -- CreateToggle (Checkbox)
            function sectionObj:CreateToggle(toggleName, default, callback)
                local chk = FEATURES.CHECKBOX.Background:Clone()
                chk.TextLabel.Text = toggleName
                chk.Parent = container
                chk.Visible = true
                chk.Size = UDim2.new(1, 0, 0, 18)
                local state = default
                chk.ON.Visible = state
                chk.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        state = not state
                        chk.ON.Visible = state
                        callback(state)
                    end
                end)
            end

            -- CreateSlider
            function sectionObj:CreateSlider(sliderName, min, max, default, callback)
                local sld = FEATURES.SLIDER["BACKGROUND "]:Clone()
                sld.Parent = container
                sld.Visible = true
                sld.Size = UDim2.new(1, 0, 0, 20)
                local value = default
                local function updateValue(newValue)
                    newValue = math.clamp(math.round(newValue), min, max)  -- Assume integer
                    value = newValue
                    sld[" VALUE"].Text = value .. "/" .. max
                    local progress = (value - min) / (max - min)
                    sld.PROGRESSBAR.Size = UDim2.new(progress, 0, 1, 0)
                    callback(value)
                end
                updateValue(default)
                local dragging = false
                sld.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                sld.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local relativeX = math.clamp((input.Position.X - sld.AbsolutePosition.X) / sld.AbsoluteSize.X, 0, 1)
                        local newValue = min + (max - min) * relativeX
                        updateValue(newValue)
                    end
                end)
            end

            tab.Sections[sectionName] = sectionObj
            return sectionObj
        end

        return tab
    end

    -- SelectTab function
    function self:SelectTab(name)
        if self.ActiveTab then
            local oldTab = self.Tabs[self.ActiveTab]
            oldTab.Left.Visible = false
            oldTab.Right.Visible = false
            oldTab.Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        end
        local newTab = self.Tabs[name]
        newTab.Left.Visible = true
        newTab.Right.Visible = true
        newTab.Button.BackgroundColor3 = Color3.fromRGB(0, 0, 50)  -- Highlight
        self.ActiveTab = name
    end

    return self
end

return KoltUI
