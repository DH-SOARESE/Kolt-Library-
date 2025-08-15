local Library = {}

function Library:CreateWindow(options)
    local title = options.Title or "Untitled"
    
    -- Create the UI instances as provided
    local CollectionService = game:GetService("CollectionService")
    local G2L = {}
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI
    G2L["KOLT UI_1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    G2L["KOLT UI_1"]["Name"] = [[KOLT UI]]
    G2L["KOLT UI_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
    
    -- Tags
    CollectionService:AddTag(G2L["KOLT UI_1"], [[main]])
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES
    G2L["FEATURES_2"] = Instance.new("Folder", G2L["KOLT UI_1"])
    G2L["FEATURES_2"]["Name"] = [[FEATURES]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SLIDER
    G2L["SLIDER_3"] = Instance.new("Folder", G2L["FEATURES_2"])
    G2L["SLIDER_3"]["Name"] = [[SLIDER]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SLIDER.BACKGROUND 
    G2L["BACKGROUND _4"] = Instance.new("Frame", G2L["SLIDER_3"])
    G2L["BACKGROUND _4"]["Visible"] = false
    G2L["BACKGROUND _4"]["ZIndex"] = 11
    G2L["BACKGROUND _4"]["BorderSizePixel"] = 0
    G2L["BACKGROUND _4"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["BACKGROUND _4"]["Size"] = UDim2.new(0, 188, 0, 20)
    G2L["BACKGROUND _4"]["Position"] = UDim2.new(0, 8, 0, 72)
    G2L["BACKGROUND _4"]["Name"] = [[BACKGROUND ]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SLIDER.BACKGROUND .PROGRESSBAR
    G2L["PROGRESSBAR_5"] = Instance.new("Frame", G2L["BACKGROUND _4"])
    G2L["PROGRESSBAR_5"]["BorderSizePixel"] = 0
    G2L["PROGRESSBAR_5"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 242)
    G2L["PROGRESSBAR_5"]["Size"] = UDim2.new(0, 184, 0, 16)
    G2L["PROGRESSBAR_5"]["Position"] = UDim2.new(0, 2, 0, 2)
    G2L["PROGRESSBAR_5"]["Name"] = [[PROGRESSBAR]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SLIDER.BACKGROUND .VALUE
    G2L["VALUE_6"] = Instance.new("TextLabel", G2L["BACKGROUND _4"])
    G2L["VALUE_6"]["BorderSizePixel"] = 0
    G2L["VALUE_6"]["TextSize"] = 10
    G2L["VALUE_6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["VALUE_6"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["VALUE_6"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["VALUE_6"]["BackgroundTransparency"] = 1
    G2L["VALUE_6"]["Size"] = UDim2.new(0, 188, 0, 20)
    G2L["VALUE_6"]["Text"] = [[VALUE]]
    G2L["VALUE_6"]["Name"] = [[VALUE]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SLIDER.BACKGROUND .UIStroke
    G2L["UIStroke_7"] = Instance.new("UIStroke", G2L["BACKGROUND _4"])
    G2L["UIStroke_7"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SEÇÃO
    G2L["SEÇÃO_8"] = Instance.new("Folder", G2L["FEATURES_2"])
    G2L["SEÇÃO_8"]["Name"] = [[SEÇÃO]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SEÇÃO.Frame
    G2L["Frame_9"] = Instance.new("Frame", G2L["SEÇÃO_8"])
    G2L["Frame_9"]["Visible"] = false
    G2L["Frame_9"]["ZIndex"] = 9
    G2L["Frame_9"]["BorderSizePixel"] = 0
    G2L["Frame_9"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["Frame_9"]["Size"] = UDim2.new(0, 196, 0, 92)
    G2L["Frame_9"]["Position"] = UDim2.new(0, 4, 0, 8)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SEÇÃO.Frame.UIStroke
    G2L["UIStroke_a"] = Instance.new("UIStroke", G2L["Frame_9"])
    G2L["UIStroke_a"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.SEÇÃO.Frame.NAME
    G2L["NAME_b"] = Instance.new("TextLabel", G2L["Frame_9"])
    G2L["NAME_b"]["ZIndex"] = 11
    G2L["NAME_b"]["BorderSizePixel"] = 0
    G2L["NAME_b"]["TextSize"] = 12
    G2L["NAME_b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["NAME_b"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["NAME_b"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["NAME_b"]["Size"] = UDim2.new(0, 40, 0, 8)
    G2L["NAME_b"]["Text"] = [[NAME]]
    G2L["NAME_b"]["Name"] = [[NAME]]
    G2L["NAME_b"]["Position"] = UDim2.new(0, 14, 0, -4)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.BUTTON
    G2L["BUTTON_c"] = Instance.new("Folder", G2L["FEATURES_2"])
    G2L["BUTTON_c"]["Name"] = [[BUTTON]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.BUTTON.TextButton
    G2L["TextButton_d"] = Instance.new("TextButton", G2L["BUTTON_c"])
    G2L["TextButton_d"]["BorderSizePixel"] = 0
    G2L["TextButton_d"]["TextSize"] = 20
    G2L["TextButton_d"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["TextButton_d"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["TextButton_d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["TextButton_d"]["ZIndex"] = 11
    G2L["TextButton_d"]["Size"] = UDim2.new(0, 192, 0, 24)
    G2L["TextButton_d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["TextButton_d"]["Text"] = [[BUTTON]]
    G2L["TextButton_d"]["Visible"] = false
    G2L["TextButton_d"]["Position"] = UDim2.new(0, 6, 0, 16)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.BUTTON.TextButton.UIStroke
    G2L["UIStroke_e"] = Instance.new("UIStroke", G2L["TextButton_d"])
    G2L["UIStroke_e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
    G2L["UIStroke_e"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.CHECKBOX
    G2L["CHECKBOX_f"] = Instance.new("Folder", G2L["FEATURES_2"])
    G2L["CHECKBOX_f"]["Name"] = [[CHECKBOX]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.CHECKBOX.STATUS
    G2L["STATUS_10"] = Instance.new("Frame", G2L["CHECKBOX_f"])
    G2L["STATUS_10"]["ZIndex"] = 11
    G2L["STATUS_10"]["BorderSizePixel"] = 0
    G2L["STATUS_10"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["STATUS_10"]["Size"] = UDim2.new(0, 18, 0, 18)
    G2L["STATUS_10"]["Position"] = UDim2.new(0, 7, 0, 47)
    G2L["STATUS_10"]["Name"] = [[STATUS]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.CHECKBOX.STATUS.UICorner
    G2L["UICorner_11"] = Instance.new("UICorner", G2L["STATUS_10"])
    G2L["UICorner_11"]["CornerRadius"] = UDim.new(0, 2)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.CHECKBOX.STATUS.ATIVO
    G2L["ATIVO_12"] = Instance.new("Frame", G2L["STATUS_10"])
    G2L["ATIVO_12"]["BorderSizePixel"] = 0
    G2L["ATIVO_12"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 255)
    G2L["ATIVO_12"]["Size"] = UDim2.new(0, 14, 0, 14)
    G2L["ATIVO_12"]["Position"] = UDim2.new(0, 2, 0, 2)
    G2L["ATIVO_12"]["Name"] = [[ATIVO]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.CHECKBOX.STATUS.ATIVO.UICorner
    G2L["UICorner_13"] = Instance.new("UICorner", G2L["ATIVO_12"])
    G2L["UICorner_13"]["CornerRadius"] = UDim.new(0, 2)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.CHECKBOX.STATUS.UIStroke
    G2L["UIStroke_14"] = Instance.new("UIStroke", G2L["STATUS_10"])
    G2L["UIStroke_14"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.CHECKBOX.STATUS.TextLabel
    G2L["TextLabel_15"] = Instance.new("TextLabel", G2L["STATUS_10"])
    G2L["TextLabel_15"]["BorderSizePixel"] = 0
    G2L["TextLabel_15"]["TextSize"] = 12
    G2L["TextLabel_15"]["TextXAlignment"] = Enum.TextXAlignment.Left
    G2L["TextLabel_15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["TextLabel_15"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["TextLabel_15"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["TextLabel_15"]["BackgroundTransparency"] = 1
    G2L["TextLabel_15"]["Size"] = UDim2.new(0, 166, 0, 18)
    G2L["TextLabel_15"]["Text"] = [[CHECKBOX]]
    G2L["TextLabel_15"]["Position"] = UDim2.new(0, 22, 0, 0)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.TAB_BUTTON
    G2L["TAB_BUTTON_16"] = Instance.new("Folder", G2L["FEATURES_2"])
    G2L["TAB_BUTTON_16"]["Name"] = [[TAB_BUTTON]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.TAB_BUTTON.TextButton
    G2L["TextButton_17"] = Instance.new("TextButton", G2L["TAB_BUTTON_16"])
    G2L["TextButton_17"]["BorderSizePixel"] = 0
    G2L["TextButton_17"]["TextSize"] = 15
    G2L["TextButton_17"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["TextButton_17"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["TextButton_17"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["TextButton_17"]["ZIndex"] = 10
    G2L["TextButton_17"]["Size"] = UDim2.new(0, 66, 0, 24)
    G2L["TextButton_17"]["Text"] = [[TAB]]
    G2L["TextButton_17"]["Visible"] = false
    G2L["TextButton_17"]["Position"] = UDim2.new(0, 114, 0, 68)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.FEATURES.TAB_BUTTON.TextButton.UIStroke
    G2L["UIStroke_18"] = Instance.new("UIStroke", G2L["TextButton_17"])
    G2L["UIStroke_18"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
    G2L["UIStroke_18"]["Thickness"] = 2
    G2L["UIStroke_18"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU
    G2L["MENU_19"] = Instance.new("Frame", G2L["KOLT UI_1"])
    G2L["MENU_19"]["ZIndex"] = 6
    G2L["MENU_19"]["BorderSizePixel"] = 0
    G2L["MENU_19"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["MENU_19"]["Size"] = UDim2.new(0, 454, 0, 278)
    G2L["MENU_19"]["Position"] = UDim2.new(0, 100, 0, 20)
    G2L["MENU_19"]["Name"] = [[MENU]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.BACKGROUND
    G2L["BACKGROUND_1a"] = Instance.new("Frame", G2L["MENU_19"])
    G2L["BACKGROUND_1a"]["BorderSizePixel"] = 0
    G2L["BACKGROUND_1a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["BACKGROUND_1a"]["Size"] = UDim2.new(0, 454, 0, 278)
    G2L["BACKGROUND_1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 255)
    G2L["BACKGROUND_1a"]["Name"] = [[BACKGROUND]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.BACKGROUND.BACKGROUND
    G2L["BACKGROUND_1b"] = Instance.new("Frame", G2L["BACKGROUND_1a"])
    G2L["BACKGROUND_1b"]["BorderSizePixel"] = 0
    G2L["BACKGROUND_1b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["BACKGROUND_1b"]["Size"] = UDim2.new(0, 442, 0, 234)
    G2L["BACKGROUND_1b"]["Position"] = UDim2.new(0, 6, 0, 40)
    G2L["BACKGROUND_1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 255)
    G2L["BACKGROUND_1b"]["Name"] = [[BACKGROUND]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.BACKGROUND.BACKGROUND.TABs
    G2L["TABs_1c"] = Instance.new("Frame", G2L["BACKGROUND_1b"])
    G2L["TABs_1c"]["BorderSizePixel"] = 0
    G2L["TABs_1c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["TABs_1c"]["Size"] = UDim2.new(0, 434, 0, 32)
    G2L["TABs_1c"]["Position"] = UDim2.new(0, 4, 0, 4)
    G2L["TABs_1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 255)
    G2L["TABs_1c"]["Name"] = [[TABs]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.BACKGROUND.BACKGROUND.TABs.Scrolli Tabs
    G2L["Scrolli Tabs_1d"] = Instance.new("ScrollingFrame", G2L["TABs_1c"])
    G2L["Scrolli Tabs_1d"]["ScrollingDirection"] = Enum.ScrollingDirection.X
    G2L["Scrolli Tabs_1d"]["BorderSizePixel"] = 0
    G2L["Scrolli Tabs_1d"]["VerticalScrollBarInset"] = Enum.ScrollBarInset.ScrollBar
    G2L["Scrolli Tabs_1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["Scrolli Tabs_1d"]["Name"] = [[Scrolli Tabs]]
    G2L["Scrolli Tabs_1d"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.ScrollBar
    G2L["Scrolli Tabs_1d"]["AutomaticCanvasSize"] = Enum.AutomaticSize.X
    G2L["Scrolli Tabs_1d"]["AutomaticSize"] = Enum.AutomaticSize.X
    G2L["Scrolli Tabs_1d"]["Size"] = UDim2.new(0, 418, 0, 28)
    G2L["Scrolli Tabs_1d"]["Position"] = UDim2.new(0, 2, 0, 2)
    G2L["Scrolli Tabs_1d"]["BackgroundTransparency"] = 1
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.BACKGROUND.BACKGROUND.TABs.UIStroke
    G2L["UIStroke_1e"] = Instance.new("UIStroke", G2L["TABs_1c"])
    G2L["UIStroke_1e"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.BACKGROUND.BACKGROUND.UIStroke
    G2L["UIStroke_1f"] = Instance.new("UIStroke", G2L["BACKGROUND_1b"])
    G2L["UIStroke_1f"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.BACKGROUND.UIStroke
    G2L["UIStroke_20"] = Instance.new("UIStroke", G2L["BACKGROUND_1a"])
    G2L["UIStroke_20"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.Right
    G2L["Right_21"] = Instance.new("Frame", G2L["MENU_19"])
    G2L["Right_21"]["BorderSizePixel"] = 0
    G2L["Right_21"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["Right_21"]["Size"] = UDim2.new(0, 214, 0, 190)
    G2L["Right_21"]["Position"] = UDim2.new(0, 230, 0, 80)
    G2L["Right_21"]["Name"] = [[Right]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.Right.UIStroke
    G2L["UIStroke_22"] = Instance.new("UIStroke", G2L["Right_21"])
    G2L["UIStroke_22"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.Right.Scroll Right
    G2L["Scroll Right_23"] = Instance.new("ScrollingFrame", G2L["Right_21"])
    G2L["Scroll Right_23"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
    G2L["Scroll Right_23"]["BorderSizePixel"] = 0
    G2L["Scroll Right_23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["Scroll Right_23"]["Name"] = [[Scroll Right]]
    G2L["Scroll Right_23"]["ScrollBarImageTransparency"] = 1
    G2L["Scroll Right_23"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
    G2L["Scroll Right_23"]["Size"] = UDim2.new(0, 214, 0, 190)
    G2L["Scroll Right_23"]["BackgroundTransparency"] = 1
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.Left
    G2L["Left_24"] = Instance.new("Frame", G2L["MENU_19"])
    G2L["Left_24"]["BorderSizePixel"] = 0
    G2L["Left_24"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["Left_24"]["Size"] = UDim2.new(0, 214, 0, 190)
    G2L["Left_24"]["Position"] = UDim2.new(0, 10, 0, 80)
    G2L["Left_24"]["Name"] = [[Left]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.Left.Scroll Left
    G2L["Scroll Left_25"] = Instance.new("ScrollingFrame", G2L["Left_24"])
    G2L["Scroll Left_25"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
    G2L["Scroll Left_25"]["BorderSizePixel"] = 0
    G2L["Scroll Left_25"]["CanvasPosition"] = Vector2.new(12, 190)
    G2L["Scroll Left_25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["Scroll Left_25"]["Name"] = [[Scroll Left]]
    G2L["Scroll Left_25"]["ScrollBarImageTransparency"] = 1
    G2L["Scroll Left_25"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
    G2L["Scroll Left_25"]["Size"] = UDim2.new(0, 214, 0, 190)
    G2L["Scroll Left_25"]["BackgroundTransparency"] = 1
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.Left.UIStroke
    G2L["UIStroke_26"] = Instance.new("UIStroke", G2L["Left_24"])
    G2L["UIStroke_26"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.TITLE
    G2L["TITLE_27"] = Instance.new("Frame", G2L["MENU_19"])
    G2L["TITLE_27"]["BorderSizePixel"] = 0
    G2L["TITLE_27"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["TITLE_27"]["Size"] = UDim2.new(0, 442, 0, 28)
    G2L["TITLE_27"]["Position"] = UDim2.new(0, 6, 0, 4)
    G2L["TITLE_27"]["BorderColor3"] = Color3.fromRGB(0, 0, 255)
    G2L["TITLE_27"]["Name"] = [[TITLE]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.TITLE.TextLabel
    G2L["TextLabel_28"] = Instance.new("TextLabel", G2L["TITLE_27"])
    G2L["TextLabel_28"]["BorderSizePixel"] = 0
    G2L["TextLabel_28"]["TextSize"] = 18
    G2L["TextLabel_28"]["TextXAlignment"] = Enum.TextXAlignment.Left
    G2L["TextLabel_28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["TextLabel_28"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["TextLabel_28"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["TextLabel_28"]["BackgroundTransparency"] = 1
    G2L["TextLabel_28"]["Size"] = UDim2.new(0, 438, 0, 28)
    G2L["TextLabel_28"]["Text"] = [[TITLE]]
    G2L["TextLabel_28"]["Position"] = UDim2.new(0, 4, 0, 0)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.MENU.TITLE.UIStroke
    G2L["UIStroke_29"] = Instance.new("UIStroke", G2L["TITLE_27"])
    G2L["UIStroke_29"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.UI_FRAG
    G2L["UI_FRAG_2a"] = Instance.new("Folder", G2L["KOLT UI_1"])
    G2L["UI_FRAG_2a"]["Name"] = [[UI_FRAG]]
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.UI_FRAG.Show/Hide
    G2L["Show/Hide_2b"] = Instance.new("TextButton", G2L["UI_FRAG_2a"])
    G2L["Show/Hide_2b"]["BorderSizePixel"] = 0
    G2L["Show/Hide_2b"]["TextSize"] = 17
    G2L["Show/Hide_2b"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["Show/Hide_2b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["Show/Hide_2b"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["Show/Hide_2b"]["ZIndex"] = 999
    G2L["Show/Hide_2b"]["Size"] = UDim2.new(0, 86, 0, 32)
    G2L["Show/Hide_2b"]["Text"] = [[TOGGLE UI]]
    G2L["Show/Hide_2b"]["Name"] = [[Show/Hide]]
    G2L["Show/Hide_2b"]["Position"] = UDim2.new(0, 4, 0, 20)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.UI_FRAG.Show/Hide.UIStroke
    G2L["UIStroke_2c"] = Instance.new("UIStroke", G2L["Show/Hide_2b"])
    G2L["UIStroke_2c"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
    G2L["UIStroke_2c"]["Thickness"] = 2
    G2L["UIStroke_2c"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.UI_FRAG.Lock/Unlock
    G2L["Lock/Unlock_2d"] = Instance.new("TextButton", G2L["UI_FRAG_2a"])
    G2L["Lock/Unlock_2d"]["BorderSizePixel"] = 0
    G2L["Lock/Unlock_2d"]["TextSize"] = 15
    G2L["Lock/Unlock_2d"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
    G2L["Lock/Unlock_2d"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
    G2L["Lock/Unlock_2d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    G2L["Lock/Unlock_2d"]["ZIndex"] = 999
    G2L["Lock/Unlock_2d"]["Size"] = UDim2.new(0, 86, 0, 28)
    G2L["Lock/Unlock_2d"]["Text"] = [[LOCK]]
    G2L["Lock/Unlock_2d"]["Name"] = [[Lock/Unlock]]
    G2L["Lock/Unlock_2d"]["Position"] = UDim2.new(0, 4, 0, 52)
    
    -- Players.DH_SOARES00.PlayerGui.KOLT UI.UI_FRAG.Lock/Unlock.UIStroke
    G2L["UIStroke_2e"] = Instance.new("UIStroke", G2L["Lock/Unlock_2d"])
    G2L["UIStroke_2e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
    G2L["UIStroke_2e"]["Thickness"] = 2
    G2L["UIStroke_2e"]["Color"] = Color3.fromRGB(0, 0, 255)
    
    local gui = G2L["KOLT UI_1"]
    
    gui.MENU.TITLE.TextLabel.Text = title
    
    -- Add UIListLayouts
    local listTabs = Instance.new("UIListLayout")
    listTabs.Parent = gui.MENU.BACKGROUND.BACKGROUND.TABs["Scrolli Tabs"]
    listTabs.FillDirection = Enum.FillDirection.Horizontal
    listTabs.SortOrder = Enum.SortOrder.LayoutOrder
    listTabs.Padding = UDim.new(0, 4)
    
    local listLeft = Instance.new("UIListLayout")
    listLeft.Parent = gui.MENU.Left["Scroll Left"]
    listLeft.SortOrder = Enum.SortOrder.LayoutOrder
    listLeft.Padding = UDim.new(0, 4)
    
    local listRight = Instance.new("UIListLayout")
    listRight.Parent = gui.MENU.Right["Scroll Right"]
    listRight.SortOrder = Enum.SortOrder.LayoutOrder
    listRight.Padding = UDim.new(0, 4)
    
    -- Draggable functionality
    local UIS = game:GetService("UserInputService")
    local locked = false
    
    local function makeDraggable(topbar, frame)
        local dragging = false
        local dragInput
        local dragStart
        local startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        topbar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not locked then
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
        
        topbar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
        
        UIS.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    
    makeDraggable(gui.MENU.TITLE, gui.MENU)
    
    -- Toggle UI button
    local toggleBtn = gui.UI_FRAG["Show/Hide"]
    toggleBtn.MouseButton1Click:Connect(function()
        gui.MENU.Visible = not gui.MENU.Visible
    end)
    
    -- Lock/Unlock button
    local lockBtn = gui.UI_FRAG["Lock/Unlock"]
    lockBtn.Text = "LOCK"
    lockBtn.MouseButton1Click:Connect(function()
        locked = not locked
        lockBtn.Text = locked and "UNLOCK" or "LOCK"
    end)
    
    -- Window object
    local window = {}
    local tabs = {}
    local currentTab = nil
    
    function window:AddTab(name)
        local tabBtn = gui.FEATURES.TAB_BUTTON.TextButton:Clone()
        tabBtn.Visible = true
        tabBtn.Text = name
        tabBtn.Parent = gui.MENU.BACKGROUND.BACKGROUND.TABs["Scrolli Tabs"]
        
        local tab = {}
        tab.leftSections = {}
        tab.rightSections = {}
        tab.button = tabBtn
        tabs[name] = tab
        
        local function select()
            if currentTab == tab then return end
            currentTab = tab
            
            for _, t in pairs(tabs) do
                for _, sec in ipairs(t.leftSections) do
                    sec.Visible = false
                end
                for _, sec in ipairs(t.rightSections) do
                    sec.Visible = false
                end
                t.button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                t.button.UIStroke.Color = Color3.fromRGB(0, 0, 255)
            end
            
            for _, sec in ipairs(tab.leftSections) do
                sec.Visible = true
            end
            for _, sec in ipairs(tab.rightSections) do
                sec.Visible = true
            end
            
            tabBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
            tabBtn.UIStroke.Color = Color3.fromRGB(255, 255, 255)
        end
        
        tabBtn.MouseButton1Click:Connect(select)
        if not currentTab then select() end
        
        local function createContainer(side, secName)
            local section = gui.FEATURES["SEÇÃO"].Frame:Clone()
            section.Visible = false
            section.Parent = side == "left" and gui.MENU.Left["Scroll Left"] or gui.MENU.Right["Scroll Right"]
            section.NAME.Text = secName
            section.Size = UDim2.new(1, 0, 0, 0)
            section.AutomaticSize = Enum.AutomaticSize.Y
            
            local list = Instance.new("UIListLayout", section)
            list.SortOrder = Enum.SortOrder.LayoutOrder
            list.Padding = UDim.new(0, 8)
            list.HorizontalAlignment = Enum.HorizontalAlignment.Left
            
            table.insert(side == "left" and tab.leftSections or tab.rightSections, section)
            if currentTab == tab then section.Visible = true end
            
            local cont = {}
            
            function cont:AddButton(opts)
                local btn = gui.FEATURES.BUTTON.TextButton:Clone()
                btn.Visible = true
                btn.Text = opts.Text or "Button"
                btn.Parent = section
                btn.MouseButton1Click:Connect(opts.Func or function() end)
            end
            
            function cont:AddCheckbox(opts)
                local check = gui.FEATURES.CHECKBOX.STATUS:Clone()
                check.TextLabel.Text = opts.Text or "Checkbox"
                check.Parent = section
                
                local enabled = opts.Default or false
                check.ATIVO.Visible = enabled
                local cb = opts.Callback or function() end
                
                local function toggle()
                    enabled = not enabled
                    check.ATIVO.Visible = enabled
                    cb(enabled)
                end
                
                check.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        toggle()
                    end
                end)
                
                check.TextLabel.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        toggle()
                    end
                end)
            end
            
            function cont:AddSlider(opts)
                local slider = gui.FEATURES.SLIDER["BACKGROUND "]:Clone()
                slider.Visible = true
                slider.Parent = section
                
                local min = opts.Min or 0
                local max = opts.Max or 100
                local value = opts.Default or min
                local rounding = opts.Rounding or 0
                local cb = opts.Callback or function() end
                
                local function setValue(val)
                    val = math.clamp(val, min, max)
                    if rounding == 0 then
                        val = math.floor(val + 0.5)
                    else
                        local mult = 10 ^ rounding
                        val = math.floor(val * mult + 0.5) / mult
                    end
                    slider.VALUE.Text = tostring(val)
                    local pct = (val - min) / (max - min)
                    slider.PROGRESSBAR.Size = UDim2.new(pct, 0, 0, 16)
                    cb(val)
                end
                
                setValue(value)
                
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
                
                UIS.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local rel = input.Position.X - slider.AbsolutePosition.X
                        local pct = math.clamp(rel / slider.AbsoluteSize.X, 0, 1)
                        local val = min + (max - min) * pct
                        setValue(val)
                    end
                end)
            end
            
            return cont
        end
        
        function tab:AddLeftContainer(name)
            return createContainer("left", name)
        end
        
        function tab:AddRightContainer(name)
            return createContainer("right", name)
        end
        
        return tab
    end
    
    return window
end

return Library
