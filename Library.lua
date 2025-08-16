--[[ UI KOLT LIBRARY V1.0 ]]--


local KoltUI = {}
KoltUI.__index = KoltUI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local CollectionService = game:GetService("CollectionService")

function KoltUI.new(title)
    local self = setmetatable({}, KoltUI)
    
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Ui Kolt"
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = PlayerGui
    CollectionService:AddTag(self.ScreenGui, "main")
    
    -- FEATURES Folder (for templates, but we'll use dynamically)
    local FEATURES = Instance.new("Folder")
    FEATURES.Name = "FEATURES"
    FEATURES.Parent = self.ScreenGui
    
    -- Create templates for features
    self:CreateTemplates(FEATURES)
    
    -- UI OPEN/LOCK
    local UI_OPEN_LOCK = Instance.new("Folder")
    UI_OPEN_LOCK.Name = "UI OPEN/LOCK"
    UI_OPEN_LOCK.Parent = self.ScreenGui
    
    local BACKGROUND = Instance.new("Frame")
    BACKGROUND.Name = "BACKGROUND"
    BACKGROUND.ZIndex = 998
    BACKGROUND.BorderSizePixel = 0
    BACKGROUND.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND.Size = UDim2.new(0, 96, 0, 70)
    BACKGROUND.Position = UDim2.new(0, -2, 0, 16)
    BACKGROUND.Parent = UI_OPEN_LOCK
    
    local Show_Hide = Instance.new("TextButton")
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
    Show_Hide.Parent = UI_OPEN_LOCK
    
    local UIStroke_Show = Instance.new("UIStroke")
    UIStroke_Show.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_Show.Thickness = 2
    UIStroke_Show.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_Show.Parent = Show_Hide
    
    local Lock_Unlock = Instance.new("TextButton")
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
    Lock_Unlock.Parent = UI_OPEN_LOCK
    
    local UIStroke_Lock = Instance.new("UIStroke")
    UIStroke_Lock.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_Lock.Thickness = 2
    UIStroke_Lock.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_Lock.Parent = Lock_Unlock
    
    -- UI Folder
    local UI = Instance.new("Folder")
    UI.Name = "UI"
    UI.Parent = self.ScreenGui
    
    -- MENU
    self.Menu = Instance.new("Frame")
    self.Menu.Name = "MENU"
    self.Menu.ZIndex = 6
    self.Menu.BorderSizePixel = 0
    self.Menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.Menu.Size = UDim2.new(0, 454, 0, 278)
    self.Menu.Position = UDim2.new(0.5, -227, 0.5, -139)  -- Center it
    self.Menu.Parent = UI
    self.Menu.Visible = true  -- Initial visibility
    
    -- Make Menu draggable
    self:MakeDraggable(self.Menu)
    
    local BACKGROUND_MENU = Instance.new("Frame")
    BACKGROUND_MENU.Name = "BACKGROUND"
    BACKGROUND_MENU.BorderSizePixel = 0
    BACKGROUND_MENU.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND_MENU.Size = UDim2.new(1, 0, 1, 0)
    BACKGROUND_MENU.Parent = self.Menu
    
    local UIStroke_MENU = Instance.new("UIStroke")
    UIStroke_MENU.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_MENU.Parent = BACKGROUND_MENU
    
    local TITLE_FRAME = Instance.new("Frame")
    TITLE_FRAME.Name = "TITLE"
    TITLE_FRAME.BorderSizePixel = 0
    TITLE_FRAME.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TITLE_FRAME.Size = UDim2.new(0, 442, 0, 28)
    TITLE_FRAME.Position = UDim2.new(0, 6, 0, 4)
    TITLE_FRAME.Parent = self.Menu
    
    local TextLabel_TITLE = Instance.new("TextLabel")
    TextLabel_TITLE.BorderSizePixel = 0
    TextLabel_TITLE.TextSize = 18
    TextLabel_TITLE.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_TITLE.BackgroundTransparency = 1
    TextLabel_TITLE.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel_TITLE.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_TITLE.Size = UDim2.new(1, -4, 1, 0)
    TextLabel_TITLE.Position = UDim2.new(0, 4, 0, 0)
    TextLabel_TITLE.Text = title or "Kolt UI Title"
    TextLabel_TITLE.Parent = TITLE_FRAME
    
    local UIStroke_TITLE = Instance.new("UIStroke")
    UIStroke_TITLE.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_TITLE.Parent = TITLE_FRAME
    
    local Frame_DIVIDER = Instance.new("Frame")
    Frame_DIVIDER.BorderSizePixel = 0
    Frame_DIVIDER.BackgroundColor3 = Color3.fromRGB(0, 0, 255)  -- Changed to blue as per strokes
    Frame_DIVIDER.Size = UDim2.new(1, 0, 0, 2)
    Frame_DIVIDER.Position = UDim2.new(0, 0, 1, 0)
    Frame_DIVIDER.Parent = TITLE_FRAME
    
    local UICorner_DIVIDER = Instance.new("UICorner")
    UICorner_DIVIDER.Parent = Frame_DIVIDER
    
    local BACKGROUND_CONTENT = Instance.new("Frame")
    BACKGROUND_CONTENT.Name = "BACKGROUND"
    BACKGROUND_CONTENT.BorderSizePixel = 0
    BACKGROUND_CONTENT.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND_CONTENT.Size = UDim2.new(0, 442, 0, 234)
    BACKGROUND_CONTENT.Position = UDim2.new(0, 6, 0, 40)
    BACKGROUND_CONTENT.Parent = self.Menu
    
    local UIStroke_CONTENT = Instance.new("UIStroke")
    UIStroke_CONTENT.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_CONTENT.Parent = BACKGROUND_CONTENT
    
    local TABs_FRAME = Instance.new("Frame")
    TABs_FRAME.Name = "TABs"
    TABs_FRAME.BorderSizePixel = 0
    TABs_FRAME.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TABs_FRAME.Size = UDim2.new(0, 434, 0, 32)
    TABs_FRAME.Position = UDim2.new(0, 4, 0, 4)
    TABs_FRAME.Parent = BACKGROUND_CONTENT
    
    local UIStroke_TABs = Instance.new("UIStroke")
    UIStroke_TABs.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_TABs.Parent = TABs_FRAME
    
    self.ScrollTabs = Instance.new("ScrollingFrame")
    self.ScrollTabs.Name = "Scrolli Tabs"
    self.ScrollTabs.ScrollingDirection = Enum.ScrollingDirection.X
    self.ScrollTabs.BorderSizePixel = 0
    self.ScrollTabs.BackgroundTransparency = 1
    self.ScrollTabs.AutomaticCanvasSize = Enum.AutomaticSize.X
    self.ScrollTabs.Size = UDim2.new(0, 418, 0, 28)
    self.ScrollTabs.Position = UDim2.new(0, 2, 0, 2)
    self.ScrollTabs.Parent = TABs_FRAME
    self.ScrollTabs.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    
    local UIListLayout_Tabs = Instance.new("UIListLayout")
    UIListLayout_Tabs.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_Tabs.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_Tabs.Padding = UDim.new(0, 4)
    UIListLayout_Tabs.Parent = self.ScrollTabs
    
    -- Content Area for Tabs
    self.TabContents = Instance.new("Frame")
    self.TabContents.Name = "TabContents"
    self.TabContents.BackgroundTransparency = 1
    self.TabContents.Size = UDim2.new(1, 0, 1, -40)
    self.TabContents.Position = UDim2.new(0, 0, 0, 40)
    self.TabContents.Parent = BACKGROUND_CONTENT
    
    -- Tabs table
    self.Tabs = {}
    self.CurrentTab = nil
    
    -- Toggle UI functionality
    Show_Hide.MouseButton1Click:Connect(function()
        self.Menu.Visible = not self.Menu.Visible
    end)
    
    -- Lock/Unlock (toggle draggable? For now, placeholder)
    self.Locked = false
    Lock_Unlock.MouseButton1Click:Connect(function()
        self.Locked = not self.Locked
        Lock_Unlock.Text = self.Locked and "Unlock" or "Lock"
        -- If locked, disable dragging, but since dragging is on title, we can toggle the drag script
    end)
    
    return self
end

function KoltUI:CreateTemplates(featuresFolder)
    -- SLIDER Template
    local SLIDER = Instance.new("Folder")
    SLIDER.Name = "SLIDER"
    SLIDER.Parent = featuresFolder
    
    local BACKGROUND_SLIDER = Instance.new("Frame")
    BACKGROUND_SLIDER.Name = "BACKGROUND "
    BACKGROUND_SLIDER.ZIndex = 11
    BACKGROUND_SLIDER.BorderSizePixel = 0
    BACKGROUND_SLIDER.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BACKGROUND_SLIDER.Size = UDim2.new(0, 198, 0, 20)
    BACKGROUND_SLIDER.Parent = SLIDER
    
    local PROGRESSBAR = Instance.new("Frame")
    PROGRESSBAR.Name = "PROGRESSBAR"
    PROGRESSBAR.BorderSizePixel = 0
    PROGRESSBAR.BackgroundColor3 = Color3.fromRGB(0, 0, 242)
    PROGRESSBAR.Size = UDim2.new(0, 194, 0, 16)
    PROGRESSBAR.Position = UDim2.new(0, 2, 0, 2)
    PROGRESSBAR.Parent = BACKGROUND_SLIDER
    
    local VALUE = Instance.new("TextLabel")
    VALUE.Name = " VALUE"
    VALUE.BorderSizePixel = 0
    VALUE.TextSize = 10
    VALUE.BackgroundTransparency = 1
    VALUE.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    VALUE.TextColor3 = Color3.fromRGB(255, 255, 255)
    VALUE.Size = UDim2.new(0, 188, 0, 20)
    VALUE.Text = "VALUE/VALUE"
    VALUE.Parent = BACKGROUND_SLIDER
    
    local UIStroke_SLIDER = Instance.new("UIStroke")
    UIStroke_SLIDER.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_SLIDER.Parent = BACKGROUND_SLIDER
    
    -- CHECKBOX Template
    local CHECKBOX = Instance.new("Folder")
    CHECKBOX.Name = "CHECKBOX"
    CHECKBOX.Parent = featuresFolder
    
    local Background_CHECK = Instance.new("Frame")
    Background_CHECK.Name = "Background"
    Background_CHECK.ZIndex = 11
    Background_CHECK.BorderSizePixel = 0
    Background_CHECK.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background_CHECK.Size = UDim2.new(0, 18, 0, 18)
    Background_CHECK.Parent = CHECKBOX
    
    local UICorner_CHECK = Instance.new("UICorner")
    UICorner_CHECK.CornerRadius = UDim.new(0, 2)
    UICorner_CHECK.Parent = Background_CHECK
    
    local ON = Instance.new("Frame")
    ON.Name = "ON"
    ON.Visible = false
    ON.BorderSizePixel = 0
    ON.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    ON.Size = UDim2.new(0, 14, 0, 14)
    ON.Position = UDim2.new(0, 2, 0, 2)
    ON.Parent = Background_CHECK
    
    local UICorner_ON = Instance.new("UICorner")
    UICorner_ON.CornerRadius = UDim.new(0, 2)
    UICorner_ON.Parent = ON
    
    local OFF = Instance.new("Frame")
    OFF.Name = "OFF"
    OFF.BorderSizePixel = 0
    OFF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OFF.Size = UDim2.new(0, 14, 0, 14)
    OFF.Position = UDim2.new(0, 2, 0, 2)
    OFF.BackgroundTransparency = 1
    OFF.Parent = Background_CHECK
    
    local UIStroke_OFF = Instance.new("UIStroke")
    UIStroke_OFF.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_OFF.Parent = OFF
    
    local UICorner_OFF = Instance.new("UICorner")
    UICorner_OFF.CornerRadius = UDim.new(0, 2)
    UICorner_OFF.Parent = OFF
    
    local UIStroke_CHECK = Instance.new("UIStroke")
    UIStroke_CHECK.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_CHECK.Parent = Background_CHECK
    
    local TextLabel_CHECK = Instance.new("TextLabel")
    TextLabel_CHECK.BorderSizePixel = 0
    TextLabel_CHECK.TextSize = 12
    TextLabel_CHECK.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_CHECK.BackgroundTransparency = 1
    TextLabel_CHECK.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    TextLabel_CHECK.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_CHECK.Size = UDim2.new(0, 178, 0, 18)
    TextLabel_CHECK.Position = UDim2.new(0, 22, 0, 0)
    TextLabel_CHECK.Text = "CHECKBOX"
    TextLabel_CHECK.Parent = Background_CHECK
    
    -- BUTTON Template
    local BUTTON = Instance.new("Folder")
    BUTTON.Name = "BUTTON"
    BUTTON.Parent = featuresFolder
    
    local TextButton_BTN = Instance.new("TextButton")
    TextButton_BTN.BorderSizePixel = 0
    TextButton_BTN.TextSize = 12
    TextButton_BTN.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton_BTN.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton_BTN.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    TextButton_BTN.ZIndex = 11
    TextButton_BTN.Size = UDim2.new(0, 198, 0, 20)
    TextButton_BTN.Text = "Click Me"
    TextButton_BTN.Parent = BUTTON
    
    local UIStroke_BTN = Instance.new("UIStroke")
    UIStroke_BTN.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_BTN.Thickness = 0.9
    UIStroke_BTN.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_BTN.Parent = TextButton_BTN
    
    -- SECTION Template
    local SEÇÃO = Instance.new("Folder")
    SEÇÃO.Name = "SEÇÃO"
    SEÇÃO.Parent = featuresFolder
    
    local CONTAINER_SEC = Instance.new("Frame")
    CONTAINER_SEC.Name = "CONTAINER"
    CONTAINER_SEC.ZIndex = 9
    CONTAINER_SEC.BorderSizePixel = 0
    CONTAINER_SEC.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CONTAINER_SEC.Size = UDim2.new(0, 206, 0, 112)
    CONTAINER_SEC.BackgroundTransparency = 1
    CONTAINER_SEC.Parent = SEÇÃO
    
    local NAME_SEC = Instance.new("TextLabel")
    NAME_SEC.Name = "NAME"
    NAME_SEC.ZIndex = 11
    NAME_SEC.BorderSizePixel = 0
    NAME_SEC.TextSize = 12
    NAME_SEC.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NAME_SEC.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    NAME_SEC.TextColor3 = Color3.fromRGB(255, 255, 255)
    NAME_SEC.Size = UDim2.new(0, 40, 0, 8)
    NAME_SEC.Text = "NAME"
    NAME_SEC.Position = UDim2.new(0, 14, 0, -4)
    NAME_SEC.Parent = CONTAINER_SEC
    
    local UIStroke_SEC = Instance.new("UIStroke")
    UIStroke_SEC.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_SEC.Parent = CONTAINER_SEC
    
    -- TAB_BUTTON Template
    local TAB_BUTTON = Instance.new("Folder")
    TAB_BUTTON.Name = "TAB_BUTTON"
    TAB_BUTTON.Parent = featuresFolder
    
    local Button_Tab = Instance.new("TextButton")
    Button_Tab.Name = "Button_Tab"
    Button_Tab.BorderSizePixel = 0
    Button_Tab.TextSize = 15
    Button_Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button_Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Button_Tab.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    Button_Tab.ZIndex = 10
    Button_Tab.Size = UDim2.new(0, 48, 0, 20)
    Button_Tab.Text = "TAB"
    Button_Tab.Parent = TAB_BUTTON
    
    local UIStroke_Tab = Instance.new("UIStroke")
    UIStroke_Tab.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke_Tab.Thickness = 2
    UIStroke_Tab.Color = Color3.fromRGB(0, 0, 255)
    UIStroke_Tab.Parent = Button_Tab
    
    self.Templates = {
        Slider = BACKGROUND_SLIDER,
        Checkbox = Background_CHECK,
        Button = TextButton_BTN,
        Section = CONTAINER_SEC,
        TabButton = Button_Tab
    }
end

function KoltUI:MakeDraggable(frame)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function KoltUI:AddTab(name)
    local tab = {}
    tab.Name = name
    tab.Sections = {Left = {}, Right = {}}
    
    -- Create Tab Button
    local tabButton = self.Templates.TabButton:Clone()
    tabButton.Text = name
    tabButton.Parent = self.ScrollTabs
    tabButton.Size = UDim2.new(0, tabButton.TextBounds.X + 20, 0, 20)  -- Auto size width
    
    -- Create Tab Content Frame
    tab.Content = Instance.new("Frame")
    tab.Content.Name = name .. "_Content"
    tab.Content.BackgroundTransparency = 1
    tab.Content.Size = UDim2.new(1, 0, 1, 0)
    tab.Content.Visible = false
    tab.Content.Parent = self.TabContents
    
    -- Left Column
    tab.Left = Instance.new("ScrollingFrame")
    tab.Left.Name = "Scroll Left"
    tab.Left.ScrollingDirection = Enum.ScrollingDirection.Y
    tab.Left.BorderSizePixel = 0
    tab.Left.BackgroundTransparency = 1
    tab.Left.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tab.Left.Size = UDim2.new(0.5, -2, 1, 0)
    tab.Left.Position = UDim2.new(0, 4, 0, 0)
    tab.Left.ScrollBarImageTransparency = 1
    tab.Left.Parent = tab.Content
    
    local UIListLayout_Left = Instance.new("UIListLayout")
    UIListLayout_Left.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_Left.Padding = UDim.new(0, 4)
    UIListLayout_Left.Parent = tab.Left
    
    -- Right Column
    tab.Right = Instance.new("ScrollingFrame")
    tab.Right.Name = "Scroll Right"
    tab.Right.ScrollingDirection = Enum.ScrollingDirection.Y
    tab.Right.BorderSizePixel = 0
    tab.Right.BackgroundTransparency = 1
    tab.Right.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tab.Right.Size = UDim2.new(0.5, -2, 1, 0)
    tab.Right.Position = UDim2.new(0.5, 2, 0, 0)
    tab.Right.ScrollBarImageTransparency = 1
    tab.Right.Parent = tab.Content
    
    local UIListLayout_Right = Instance.new("UIListLayout")
    UIListLayout_Right.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_Right.Padding = UDim.new(0, 4)
    UIListLayout_Right.Parent = tab.Right
    
    -- Switch tab on click
    tabButton.MouseButton1Click:Connect(function()
        if self.CurrentTab then
            self.CurrentTab.Content.Visible = false
            self.CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        end
        tab.Content.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 50)  -- Highlight active tab
        self.CurrentTab = tab
        tab.Button = tabButton
    end)
    
    table.insert(self.Tabs, tab)
    
    -- If first tab, select it
    if #self.Tabs == 1 then
        tabButton:SimulatePropertyChanged("MouseButton1Click")  -- Trigger click
    end
    
    function tab:AddSection(name, side)
        side = side or "Left"
        local sectionSide = side == "Left" and tab.Left or tab.Right
        
        local section = self.Templates.Section:Clone()
        section.NAME.Text = name
        section.Parent = sectionSide
        
        -- Adjust size dynamically
        section.Size = UDim2.new(1, -20, 0, 0)  -- Height auto
        
        local content = Instance.new("Frame")
        content.BackgroundTransparency = 1
        content.Size = UDim2.new(1, 0, 1, 0)
        content.Parent = section
        
        local UIListLayout_Sec = Instance.new("UIListLayout")
        UIListLayout_Sec.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_Sec.Padding = UDim.new(0, 4)
        UIListLayout_Sec.Parent = content
        
        content:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            section.Size = UDim2.new(1, -20, 0, content.AbsoluteSize.Y + 20)  -- Padding
        end)
        
        local secObj = {}
        
        function secObj:AddButton(btnName, callback)
            local button = self.Templates.Button:Clone()
            button.Text = btnName
            button.Parent = content
            button.MouseButton1Click:Connect(callback or function() end)
        end
        
        function secObj:AddCheckbox(chkName, default, callback)
            local checkbox = self.Templates.Checkbox:Clone()
            checkbox.TextLabel.Text = chkName
            checkbox.Parent = content
            local toggled = default or false
            checkbox.ON.Visible = toggled
            checkbox.OFF.Visible = not toggled
            checkbox.MouseButton1Click:Connect(function()
                toggled = not toggled
                checkbox.ON.Visible = toggled
                checkbox.OFF.Visible = not toggled
                if callback then callback(toggled) end
            end)
        end
        
        function secObj:AddSlider(sldName, min, max, default, callback)
            local slider = self.Templates.Slider:Clone()
            slider.Parent = content
            local value = default or min
            local function updateValue()
                slider[" VALUE"].Text = value .. "/" .. max
                slider.PROGRESSBAR.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            end
            updateValue()
            
            local dragging = false
            slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            slider.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local relativeX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    value = math.floor(min + relativeX * (max - min))
                    updateValue()
                    if callback then callback(value) end
                end
            end)
        end
        
        return secObj
    end
    
    return tab
end

return function(title)
    return KoltUI.new(title)
end
