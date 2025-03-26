--[[
  ALADIA SCRIPT LOADER - PREMIUM VERSION
  - "INVALID LICENSE KEY" text below account
  - No "VERIFICATION SUCCESSFUL" text
  - Key expiration system
  - Modern dark theme
  - Confirmation dialogs
]]

local function CreateMainGUI()
    -- Dark color scheme
    local darkBackground = Color3.fromRGB(10, 10, 15)
    local darkerPanel = Color3.fromRGB(20, 20, 25)
    local darkestPanel = Color3.fromRGB(15, 15, 20)
    local textColor = Color3.fromRGB(220, 220, 220)
    local errorRed = Color3.fromRGB(150, 50, 50)
    local successGreen = Color3.fromRGB(50, 150, 50)
    local accentColor = Color3.fromRGB(70, 130, 150)
    local warningYellow = Color3.fromRGB(150, 130, 50)
    local buttonHover = Color3.fromRGB(35, 35, 40)

    -- Main GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KemilingHUB | Aladia"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- Error handling for parent assignment
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end)
    if not success then
        warn("Failed to parent GUI: "..tostring(err))
        return
    end

    -- Main container with shadow effect
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = darkerPanel
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 350, 0, 300)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.ClipsDescendants = true

    -- Shadow effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.BackgroundTransparency = 1
    Shadow.Size = UDim2.new(1, 10, 1, 10)
    Shadow.Position = UDim2.new(0, -5, 0, -5)
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.new(0, 0, 0)
    Shadow.ImageTransparency = 0.9
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.ZIndex = -1

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- 3-dot menu button (bottom right)
    local MenuButton = Instance.new("ImageButton")
    MenuButton.Name = "MenuButton"
    MenuButton.Parent = MainFrame
    MenuButton.BackgroundTransparency = 1
    MenuButton.Size = UDim2.new(0, 30, 0, 30)
    MenuButton.Position = UDim2.new(1, -35, 1, -35)
    MenuButton.Image = "rbxassetid://3926305904"
    MenuButton.ImageRectOffset = Vector2.new(164, 364)
    MenuButton.ImageRectSize = Vector2.new(36, 36)
    MenuButton.ImageColor3 = Color3.fromRGB(100, 100, 100)
    MenuButton.ZIndex = 2

    -- Menu button hover effect
    MenuButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(MenuButton, TweenInfo.new(0.2), {
            ImageColor3 = textColor
        }):Play()
    end)

    MenuButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(MenuButton, TweenInfo.new(0.2), {
            ImageColor3 = Color3.fromRGB(100, 100, 100)
        }):Play()
    end)

    -- Notification function
    local function ShowNotification(message, color)
        color = color or textColor
        
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Parent = ScreenGui
        Notification.BackgroundColor3 = darkestPanel
        Notification.Size = UDim2.new(0, 250, 0, 50)
        Notification.Position = UDim2.new(0.5, -125, 1, 0)
        Notification.AnchorPoint = Vector2.new(0.5, 0)
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Notification
        
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = color
        UIStroke.Thickness = 1
        UIStroke.Parent = Notification
        
        local NotifText = Instance.new("TextLabel")
        NotifText.Parent = Notification
        NotifText.BackgroundTransparency = 1
        NotifText.Size = UDim2.new(1, 0, 1, 0)
        NotifText.Font = Enum.Font.GothamMedium
        NotifText.Text = message
        NotifText.TextColor3 = textColor
        NotifText.TextSize = 14
        
        -- Animate notification
        game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -125, 1, -70)
        }):Play()
        
        task.wait(3)
        
        game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -125, 1, 0)
        }):Play()
        
        task.wait(0.3)
        Notification:Destroy()
    end

    -- Menu button functionality
    MenuButton.MouseButton1Click:Connect(function()
        setclipboard("https://dsc.gg/kemilinghub")
        ShowNotification("Discord Link Copied!", accentColor)
    end)

    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = darkestPanel
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 50)
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = Header

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "ALADIA SCRIPT LOADER"
    Title.TextColor3 = textColor
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Premium Button
    local PremiumButton = Instance.new("TextButton")
    PremiumButton.Name = "PremiumButton"
    PremiumButton.Parent = MainFrame
    PremiumButton.BackgroundColor3 = darkestPanel
    PremiumButton.Position = UDim2.new(0.5, -150, 0.3, 0)
    PremiumButton.Size = UDim2.new(0, 300, 0, 50)
    PremiumButton.Font = Enum.Font.GothamBold
    PremiumButton.Text = "PREMIUM ACCESS"
    PremiumButton.TextColor3 = textColor
    PremiumButton.TextSize = 16
    PremiumButton.AutoButtonColor = false

    local PremiumCorner = Instance.new("UICorner")
    PremiumCorner.CornerRadius = UDim.new(0, 6)
    PremiumCorner.Parent = PremiumButton

    local PremiumStroke = Instance.new("UIStroke")
    PremiumStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    PremiumStroke.Color = Color3.fromRGB(60, 60, 70)
    PremiumStroke.Thickness = 1
    PremiumStroke.Parent = PremiumButton

    -- Hover effects
    PremiumButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.2), {
            BackgroundColor3 = buttonHover,
            TextColor3 = textColor
        }):Play()
    end)

    PremiumButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.2), {
            BackgroundColor3 = darkestPanel,
            TextColor3 = textColor
        }):Play()
    end)

    -- Basic Button
    local BasicButton = Instance.new("TextButton")
    BasicButton.Name = "BasicButton"
    BasicButton.Parent = MainFrame
    BasicButton.BackgroundColor3 = darkestPanel
    BasicButton.Position = UDim2.new(0.5, -150, 0.5, 0)
    BasicButton.Size = UDim2.new(0, 300, 0, 50)
    BasicButton.Font = Enum.Font.GothamBold
    BasicButton.Text = "BASIC SCRIPT"
    BasicButton.TextColor3 = textColor
    BasicButton.TextSize = 16
    BasicButton.AutoButtonColor = false

    local BasicCorner = Instance.new("UICorner")
    BasicCorner.CornerRadius = UDim.new(0, 6)
    BasicCorner.Parent = BasicButton

    local BasicStroke = Instance.new("UIStroke")
    BasicStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    BasicStroke.Color = Color3.fromRGB(60, 60, 70)
    BasicStroke.Thickness = 1
    BasicStroke.Parent = BasicButton

    -- Hover effects
    BasicButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.2), {
            BackgroundColor3 = buttonHover,
            TextColor3 = textColor
        }):Play()
    end)

    BasicButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.2), {
            BackgroundColor3 = darkestPanel,
            TextColor3 = textColor
        }):Play()
    end)

    -- Footer
    local Footer = Instance.new("TextLabel")
    Footer.Name = "Footer"
    Footer.Parent = MainFrame
    Footer.BackgroundTransparency = 1
    Footer.Position = UDim2.new(0, 0, 0.9, 0)
    Footer.Size = UDim2.new(1, 0, 0, 30)
    Footer.Font = Enum.Font.Gotham
    Footer.Text = "ALADIA SCRIPT | DARK THEME"
    Footer.TextColor3 = Color3.fromRGB(100, 100, 100)
    Footer.TextSize = 12

    -- Click sound function
    local function PlayClickSound()
        local clickSound = Instance.new("Sound")
        clickSound.SoundId = "rbxassetid://138080526"
        clickSound.Volume = 0.3
        clickSound.Parent = MainFrame
        clickSound:Play()
        game:GetService("Debris"):AddItem(clickSound, 2)
    end

    -- Create modern confirmation dialog function
    local function CreateConfirmationDialog(title, message, confirmCallback)
        -- Create overlay
        local Overlay = Instance.new("Frame")
        Overlay.Name = "ConfirmationOverlay"
        Overlay.Parent = ScreenGui
        Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        Overlay.BackgroundTransparency = 0.7
        Overlay.Size = UDim2.new(1, 0, 1, 0)
        Overlay.ZIndex = 10
        
        -- Dialog frame (centered on screen)
        local DialogFrame = Instance.new("Frame")
        DialogFrame.Name = "DialogFrame"
        DialogFrame.Parent = Overlay
        DialogFrame.BackgroundColor3 = darkerPanel
        DialogFrame.Size = UDim2.new(0, 320, 0, 200)
        DialogFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
        DialogFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        DialogFrame.ZIndex = 11
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = DialogFrame
        
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(50, 50, 60)
        UIStroke.Thickness = 1
        UIStroke.Parent = DialogFrame
        
        -- Title
        local DialogTitle = Instance.new("TextLabel")
        DialogTitle.Name = "DialogTitle"
        DialogTitle.Parent = DialogFrame
        DialogTitle.BackgroundTransparency = 1
        DialogTitle.Size = UDim2.new(1, -20, 0, 40)
        DialogTitle.Position = UDim2.new(0, 10, 0, 10)
        DialogTitle.Font = Enum.Font.GothamBold
        DialogTitle.Text = title
        DialogTitle.TextColor3 = textColor
        DialogTitle.TextSize = 18
        DialogTitle.TextXAlignment = Enum.TextXAlignment.Left
        DialogTitle.ZIndex = 12
        
        -- Divider line
        local Divider = Instance.new("Frame")
        Divider.Name = "Divider"
        Divider.Parent = DialogFrame
        Divider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        Divider.BorderSizePixel = 0
        Divider.Size = UDim2.new(1, -20, 0, 1)
        Divider.Position = UDim2.new(0, 10, 0, 60)
        Divider.ZIndex = 12
        
        -- Message
        local DialogMessage = Instance.new("TextLabel")
        DialogMessage.Name = "DialogMessage"
        DialogMessage.Parent = DialogFrame
        DialogMessage.BackgroundTransparency = 1
        DialogMessage.Size = UDim2.new(1, -20, 0, 70)
        DialogMessage.Position = UDim2.new(0, 10, 0, 70)
        DialogMessage.Font = Enum.Font.Gotham
        DialogMessage.Text = message
        DialogMessage.TextColor3 = Color3.fromRGB(180, 180, 180)
        DialogMessage.TextSize = 14
        DialogMessage.TextWrapped = true
        DialogMessage.TextXAlignment = Enum.TextXAlignment.Left
        DialogMessage.TextYAlignment = Enum.TextYAlignment.Top
        DialogMessage.ZIndex = 12
        
        -- Button container
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Name = "ButtonContainer"
        ButtonContainer.Parent = DialogFrame
        ButtonContainer.BackgroundTransparency = 1
        ButtonContainer.Size = UDim2.new(1, -20, 0, 40)
        ButtonContainer.Position = UDim2.new(0, 10, 1, -50)
        ButtonContainer.ZIndex = 12
        
        -- No Button (left)
        local NoButton = Instance.new("TextButton")
        NoButton.Name = "NoButton"
        NoButton.Parent = ButtonContainer
        NoButton.BackgroundColor3 = darkestPanel
        NoButton.Size = UDim2.new(0.48, 0, 1, 0)
        NoButton.Position = UDim2.new(0, 0, 0, 0)
        NoButton.Font = Enum.Font.GothamMedium
        NoButton.Text = "NO"
        NoButton.TextColor3 = textColor
        NoButton.TextSize = 14
        NoButton.AutoButtonColor = false
        NoButton.ZIndex = 13
        
        local NoCorner = Instance.new("UICorner")
        NoCorner.CornerRadius = UDim.new(0, 6)
        NoCorner.Parent = NoButton
        
        local NoStroke = Instance.new("UIStroke")
        NoStroke.Color = Color3.fromRGB(70, 70, 80)
        NoStroke.Thickness = 1
        NoStroke.Parent = NoButton
        
        -- Yes Button (right)
        local YesButton = Instance.new("TextButton")
        YesButton.Name = "YesButton"
        YesButton.Parent = ButtonContainer
        YesButton.BackgroundColor3 = darkestPanel
        YesButton.Size = UDim2.new(0.48, 0, 1, 0)
        YesButton.Position = UDim2.new(0.52, 0, 0, 0)
        YesButton.Font = Enum.Font.GothamMedium
        YesButton.Text = "YES"
        YesButton.TextColor3 = textColor
        YesButton.TextSize = 14
        YesButton.AutoButtonColor = false
        YesButton.ZIndex = 13
        
        local YesCorner = Instance.new("UICorner")
        YesCorner.CornerRadius = UDim.new(0, 6)
        YesCorner.Parent = YesButton
        
        local YesStroke = Instance.new("UIStroke")
        YesStroke.Color = accentColor
        YesStroke.Thickness = 1
        YesStroke.Parent = YesButton
        
        -- Button hover effects
        YesButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(YesButton, TweenInfo.new(0.2), {
                BackgroundColor3 = buttonHover,
                TextColor3 = accentColor
            }):Play()
        end)
        
        YesButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(YesButton, TweenInfo.new(0.2), {
                BackgroundColor3 = darkestPanel,
                TextColor3 = textColor
            }):Play()
        end)
        
        NoButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(NoButton, TweenInfo.new(0.2), {
                BackgroundColor3 = buttonHover,
                TextColor3 = errorRed
            }):Play()
        end)
        
        NoButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(NoButton, TweenInfo.new(0.2), {
                BackgroundColor3 = darkestPanel,
                TextColor3 = textColor
            }):Play()
        end)
        
        -- Animation
        DialogFrame.Size = UDim2.new(0, 0, 0, 0)
        DialogFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        game:GetService("TweenService"):Create(DialogFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 320, 0, 200),
            Position = UDim2.new(0.5, -160, 0.5, -100)
        }):Play()
        
        -- Button functionality
        local function CloseDialog()
            game:GetService("TweenService"):Create(DialogFrame, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            
            game:GetService("TweenService"):Create(Overlay, TweenInfo.new(0.2), {
                BackgroundTransparency = 1
            }):Play()
            
            task.wait(0.2)
            Overlay:Destroy()
        end
        
        YesButton.MouseButton1Click:Connect(function()
            PlayClickSound()
            CloseDialog()
            confirmCallback(true)
        end)
        
        NoButton.MouseButton1Click:Connect(function()
            PlayClickSound()
            CloseDialog()
            confirmCallback(false)
        end)
    end

    -- Function to check if key is expired
    local function IsKeyExpired(expDate)
        -- Parse date in format DD/MM/YYYY
        local day, month, year = expDate:match("(%d+)/(%d+)/(%d+)")
        if not day or not month or not year then
            return true -- Invalid date format, treat as expired
        end
        
        day = tonumber(day)
        month = tonumber(month)
        year = tonumber(year)
        
        local currentDate = os.date("*t")
        local currentDay = currentDate.day
        local currentMonth = currentDate.month
        local currentYear = currentDate.year
        
        -- Compare dates
        if year > currentYear then
            return false
        elseif year < currentYear then
            return true
        else -- Same year
            if month > currentMonth then
                return false
            elseif month < currentMonth then
                return true
            else -- Same month
                return day < currentDay
            end
        end
    end

    -- Premium Button Functionality
    PremiumButton.MouseButton1Click:Connect(function()
        PlayClickSound()
        
        -- Animate button press
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 290, 0, 45)
        }):Play()
        
        task.wait(0.1)
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 300, 0, 50)
        }):Play()
        
        -- Hide main buttons
        PremiumButton.Visible = false
        BasicButton.Visible = false
        
        -- Animate title change
        game:GetService("TweenService"):Create(Title, TweenInfo.new(0.3), {
            TextTransparency = 1
        }):Play()
        
        task.wait(0.3)
        Title.Text = "ENTER LICENSE KEY"
        game:GetService("TweenService"):Create(Title, TweenInfo.new(0.3), {
            TextTransparency = 0
        }):Play()

        -- License Frame
        local LicenseFrame = Instance.new("Frame")
        LicenseFrame.Name = "LicenseFrame"
        LicenseFrame.Parent = MainFrame
        LicenseFrame.BackgroundTransparency = 1
        LicenseFrame.Size = UDim2.new(1, 0, 1, -50)
        LicenseFrame.Position = UDim2.new(0, 0, 1, 0)
        
        -- Animate entrance
        game:GetService("TweenService"):Create(LicenseFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0, 0, 0, 50)
        }):Play()

        -- Current Username Display
        local currentUsername = game.Players.LocalPlayer.Name
        local UsernameLabel = Instance.new("TextLabel")
        UsernameLabel.Name = "UsernameLabel"
        UsernameLabel.Parent = LicenseFrame
        UsernameLabel.BackgroundTransparency = 1
        UsernameLabel.Position = UDim2.new(0, 20, 0.1, 0)
        UsernameLabel.Size = UDim2.new(1, -40, 0, 20)
        UsernameLabel.Font = Enum.Font.GothamBold
        UsernameLabel.Text = "ACCOUNT: "..string.upper(currentUsername)
        UsernameLabel.TextColor3 = accentColor
        UsernameLabel.TextSize = 14
        UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
        UsernameLabel.TextTransparency = 1
        
        game:GetService("TweenService"):Create(UsernameLabel, TweenInfo.new(0.5), {
            TextTransparency = 0
        }):Play()

        -- Status Label (for error messages)
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Name = "StatusLabel"
        StatusLabel.Parent = LicenseFrame
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0, 20, 0.2, 0) -- Positioned below account
        StatusLabel.Size = UDim2.new(1, -40, 0, 20)
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.Text = ""
        StatusLabel.TextColor3 = errorRed
        StatusLabel.TextSize = 14
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        StatusLabel.TextTransparency = 1
        
        game:GetService("TweenService"):Create(StatusLabel, TweenInfo.new(0.5), {
            TextTransparency = 0
        }):Play()

        -- Key Input Container
        local KeyInputContainer = Instance.new("Frame")
        KeyInputContainer.Name = "KeyInputContainer"
        KeyInputContainer.Parent = LicenseFrame
        KeyInputContainer.BackgroundColor3 = darkestPanel
        KeyInputContainer.Position = UDim2.new(0.5, -140, 0.4, 0)
        KeyInputContainer.Size = UDim2.new(0, 280, 0, 50)
        KeyInputContainer.ClipsDescendants = true
        KeyInputContainer.BackgroundTransparency = 1

        local KeyInputContainerCorner = Instance.new("UICorner")
        KeyInputContainerCorner.CornerRadius = UDim.new(0, 6)
        KeyInputContainerCorner.Parent = KeyInputContainer

        local ContainerStroke = Instance.new("UIStroke")
        ContainerStroke.Color = Color3.fromRGB(60, 60, 70)
        ContainerStroke.Thickness = 1
        ContainerStroke.Parent = KeyInputContainer

        -- Animate container appearance
        game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(0.5), {
            BackgroundTransparency = 0
        }):Play()

        -- Key Input
        local KeyInput = Instance.new("TextBox")
        KeyInput.Name = "KeyInput"
        KeyInput.Parent = KeyInputContainer
        KeyInput.BackgroundTransparency = 1
        KeyInput.Size = UDim2.new(1, -20, 1, 0)
        KeyInput.Position = UDim2.new(0, 10, 0, 0)
        KeyInput.Font = Enum.Font.Gotham
        KeyInput.PlaceholderText = "ENTER YOUR LICENSE KEY"
        KeyInput.Text = ""
        KeyInput.TextColor3 = textColor
        KeyInput.TextSize = 14
        KeyInput.ClearTextOnFocus = false
        KeyInput.TextTransparency = 1

        game:GetService("TweenService"):Create(KeyInput, TweenInfo.new(0.5), {
            TextTransparency = 0
        }):Play()

        -- Back Button
        local BackButton = Instance.new("TextButton")
        BackButton.Name = "BackButton"
        BackButton.Parent = LicenseFrame
        BackButton.BackgroundColor3 = darkestPanel
        BackButton.Position = UDim2.new(0.5, -140, 0.8, 0)
        BackButton.Size = UDim2.new(0, 280, 0, 50)
        BackButton.Font = Enum.Font.GothamBold
        BackButton.Text = "BACK"
        BackButton.TextColor3 = textColor
        BackButton.TextSize = 16
        BackButton.AutoButtonColor = false
        BackButton.BackgroundTransparency = 1

        local BackCorner = Instance.new("UICorner")
        BackCorner.CornerRadius = UDim.new(0, 6)
        BackCorner.Parent = BackButton

        local BackStroke = Instance.new("UIStroke")
        BackStroke.Color = Color3.fromRGB(70, 50, 50)
        BackStroke.Thickness = 1
        BackStroke.Parent = BackButton

        -- Animate back button appearance
        game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.5), {
            BackgroundTransparency = 0
        }):Play()

        -- Hover effects for back button
        BackButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.2), {
                BackgroundColor3 = buttonHover,
                TextColor3 = errorRed
            }):Play()
        end)

        BackButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.2), {
                BackgroundColor3 = darkestPanel,
                TextColor3 = textColor
            }):Play()
        end)

        -- Verify Button
        local VerifyButton = Instance.new("TextButton")
        VerifyButton.Name = "VerifyButton"
        VerifyButton.Parent = LicenseFrame
        VerifyButton.BackgroundColor3 = darkestPanel
        VerifyButton.Position = UDim2.new(0.5, -140, 0.6, 0)
        VerifyButton.Size = UDim2.new(0, 280, 0, 50)
        VerifyButton.Font = Enum.Font.GothamBold
        VerifyButton.Text = "VERIFY KEY"
        VerifyButton.TextColor3 = textColor
        VerifyButton.TextSize = 16
        VerifyButton.AutoButtonColor = false
        VerifyButton.BackgroundTransparency = 1

        local VerifyCorner = Instance.new("UICorner")
        VerifyCorner.CornerRadius = UDim.new(0, 6)
        VerifyCorner.Parent = VerifyButton

        local VerifyStroke = Instance.new("UIStroke")
        VerifyStroke.Color = accentColor
        VerifyStroke.Thickness = 1
        VerifyStroke.Parent = VerifyButton

        -- Animate verify button appearance
        game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.5), {
            BackgroundTransparency = 0
        }):Play()

        -- Hover effects for verify button
        VerifyButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.2), {
                BackgroundColor3 = buttonHover,
                TextColor3 = accentColor
            }):Play()
        end)

        VerifyButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.2), {
                BackgroundColor3 = darkestPanel,
                TextColor3 = textColor
            }):Play()
        end)

        -- Back Button Functionality with animation
        BackButton.MouseButton1Click:Connect(function()
            PlayClickSound()
            
            -- Animate exit
            game:GetService("TweenService"):Create(LicenseFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0, 0, 1, 0)
            }):Play()
            
            game:GetService("TweenService"):Create(Title, TweenInfo.new(0.3), {
                TextTransparency = 1
            }):Play()
            
            task.wait(0.3)
            Title.Text = "ALADIA SCRIPT LOADER"
            game:GetService("TweenService"):Create(Title, TweenInfo.new(0.3), {
                TextTransparency = 0
            }):Play()
            
            task.wait(0.4)
            LicenseFrame:Destroy()
            PremiumButton.Visible = true
            BasicButton.Visible = true
        end)

        -- Verify Functionality with enhanced feedback
        VerifyButton.MouseButton1Click:Connect(function()
            PlayClickSound()
            
            -- Animate button press
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 270, 0, 45)
            }):Play()
            
            task.wait(0.1)
            
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 280, 0, 50)
            }):Play()
            
            local enteredKey = KeyInput.Text
            enteredKey = string.upper(enteredKey:gsub("%s+", ""))
            
            if enteredKey == "" then
                StatusLabel.Text = "PLEASE ENTER A VALID KEY"
                StatusLabel.TextColor3 = errorRed
                
                -- Shake animation for error
                local shakeTime = 0.3
                local shakeOffset = 5
                
                local originalPos = KeyInputContainer.Position
                
                for i = 1, 3 do
                    game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(shakeTime/6), {
                        Position = originalPos + UDim2.new(0, shakeOffset, 0, 0)
                    }):Play()
                    task.wait(shakeTime/6)
                    game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(shakeTime/6), {
                        Position = originalPos - UDim2.new(0, shakeOffset, 0, 0)
                    }):Play()
                    task.wait(shakeTime/6)
                end
                
                game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(shakeTime/6), {
                    Position = originalPos
                }):Play()
                
                return
            end

            -- Get whitelist from Pastebin (REPLACE WITH YOUR PASTEBIN URL)
            local success, whitelist = pcall(function()
                return game:HttpGet("https://pastebin.com/raw/DxMGTLAn")
            end)
            
            if not success then
                StatusLabel.Text = "CONNECTION ERROR"
                StatusLabel.TextColor3 = errorRed
                return
            end

            -- Check verification
            local isValid = false
            local isPremium = false
            local isExpired = false
            local expirationDate = ""
            
            for line in whitelist:gmatch("[^\r\n]+") do
                local user, key, exp = line:match("Usn:%s*(.-)%s*|%s*Key:%s*(%S+)%s*|%s*Exp:%s*(%S+)")
                if user and key and exp then
                    if string.lower(user) == string.lower(currentUsername) 
                       and string.upper(key) == enteredKey then
                        isValid = true
                        isPremium = true
                        expirationDate = exp
                        isExpired = IsKeyExpired(exp)
                        break
                    end
                end
            end

            if isValid then
                if isExpired then
                    StatusLabel.Text = "LICENSE EXPIRED ("..expirationDate..")"
                    StatusLabel.TextColor3 = errorRed
                    
                    -- Pulse animation for error
                    game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(40, 30, 30)
                    }):Play()
                    
                    task.wait(0.2)
                    
                    game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(0.5), {
                        BackgroundColor3 = darkestPanel
                    }):Play()
                else
                    -- Clear any previous error messages
                    StatusLabel.Text = ""
                    
                    -- Show confirmation dialog before loading premium script
                    CreateConfirmationDialog(
                        "PREMIUM SCRIPT", 
                        "Are you sure you want to load the premium script?\nExpires: "..expirationDate,
                        function(confirmed)
                            if confirmed then
                                -- Create loading animation at bottom
                                local LoadingFrame = Instance.new("Frame")
                                LoadingFrame.Name = "LoadingFrame"
                                LoadingFrame.Parent = MainFrame
                                LoadingFrame.BackgroundColor3 = darkestPanel
                                LoadingFrame.BorderSizePixel = 0
                                LoadingFrame.Position = UDim2.new(0, 0, 1, -30)
                                LoadingFrame.Size = UDim2.new(1, 0, 0, 30)
                                LoadingFrame.AnchorPoint = Vector2.new(0, 1)
                                
                                local LoadingBar = Instance.new("Frame")
                                LoadingBar.Name = "LoadingBar"
                                LoadingBar.Parent = LoadingFrame
                                LoadingBar.BackgroundColor3 = accentColor
                                LoadingBar.BorderSizePixel = 0
                                LoadingBar.Size = UDim2.new(0, 0, 1, 0)

                                local LoadingText = Instance.new("TextLabel")
                                LoadingText.Name = "LoadingText"
                                LoadingText.Parent = LoadingFrame
                                LoadingText.BackgroundTransparency = 1
                                LoadingText.Size = UDim2.new(1, 0, 1, 0)
                                LoadingText.Font = Enum.Font.GothamBold
                                LoadingText.Text = "LOADING PREMIUM: 0%"
                                LoadingText.TextColor3 = textColor
                                LoadingText.TextSize = 14

                                local duration = 5 -- 5-second loading for premium
                                local startTime = tick()
                                
                                local function update()
                                    local elapsed = tick() - startTime
                                    local progress = math.min(elapsed/duration, 1)
                                    
                                    LoadingBar.Size = UDim2.new(progress, 0, 1, 0)
                                    LoadingText.Text = "LOADING PREMIUM: "..math.floor(progress*100).."%"
                                    
                                    if progress < 1 then
                                        task.wait()
                                        update()
                                    else
                                        task.wait(0.5)
                                        ScreenGui:Destroy()
                                        loadstring(game:HttpGet("https://raw.githubusercontent.com/Alvantv/aladiapvpa/refs/heads/main/vipa.lua"))()
                                    end
                                end
                                
                                update()
                            else
                                -- User chose not to load the script
                                ShowNotification("Premium script loading canceled", warningYellow)
                            end
                        end
                    )
                end
            else
                StatusLabel.Text = "INVALID LICENSE KEY"
                StatusLabel.TextColor3 = errorRed
                
                -- Pulse animation for error
                game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 30, 30)
                }):Play()
                
                task.wait(0.2)
                
                game:GetService("TweenService"):Create(KeyInputContainer, TweenInfo.new(0.5), {
                    BackgroundColor3 = darkestPanel
                }):Play()
            end
        end)
    end)

    -- Basic Button Functionality with confirmation dialog
    BasicButton.MouseButton1Click:Connect(function()
        PlayClickSound()
        
        -- Animate button press
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 290, 0, 45)
        }):Play()
        
        task.wait(0.1)
        
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 300, 0, 50)
        }):Play()
        
        -- Show confirmation dialog
        CreateConfirmationDialog(
            "BASIC SCRIPT", 
            "Are you sure you want to load the basic script?",
            function(confirmed)
                if confirmed then
                    -- Hide main buttons
                    PremiumButton.Visible = false
                    BasicButton.Visible = false
                    
                    -- Animate title change
                    game:GetService("TweenService"):Create(Title, TweenInfo.new(0.3), {
                        TextTransparency = 1
                    }):Play()
                    
                    task.wait(0.3)
                    Title.Text = "LOADING BASIC..."
                    game:GetService("TweenService"):Create(Title, TweenInfo.new(0.3), {
                        TextTransparency = 0
                    }):Play()
                    
                    -- Create loading animation at bottom
                    local LoadingFrame = Instance.new("Frame")
                    LoadingFrame.Name = "LoadingFrame"
                    LoadingFrame.Parent = MainFrame
                    LoadingFrame.BackgroundColor3 = darkestPanel
                    LoadingFrame.BorderSizePixel = 0
                    LoadingFrame.Position = UDim2.new(0, 0, 1, -30)
                    LoadingFrame.Size = UDim2.new(1, 0, 0, 30)
                    LoadingFrame.AnchorPoint = Vector2.new(0, 1)
                    
                    local LoadingBar = Instance.new("Frame")
                    LoadingBar.Name = "LoadingBar"
                    LoadingBar.Parent = LoadingFrame
                    LoadingBar.BackgroundColor3 = accentColor
                    LoadingBar.BorderSizePixel = 0
                    LoadingBar.Size = UDim2.new(0, 0, 1, 0)

                    local LoadingText = Instance.new("TextLabel")
                    LoadingText.Name = "LoadingText"
                    LoadingText.Parent = LoadingFrame
                    LoadingText.BackgroundTransparency = 1
                    LoadingText.Size = UDim2.new(1, 0, 1, 0)
                    LoadingText.Font = Enum.Font.GothamBold
                    LoadingText.Text = "LOADING BASIC: 0%"
                    LoadingText.TextColor3 = textColor
                    LoadingText.TextSize = 14

                    local duration = 3 -- 3-second loading for basic
                    local startTime = tick()
                    
                    local function update()
                        local elapsed = tick() - startTime
                        local progress = math.min(elapsed/duration, 1)
                        
                        LoadingBar.Size = UDim2.new(progress, 0, 1, 0)
                        LoadingText.Text = "LOADING BASIC: "..math.floor(progress*100).."%"
                        
                        if progress < 1 then
                            task.wait()
                            update()
                        else
                            task.wait(0.5)
                            ScreenGui:Destroy()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/Alvantv/basicaladia/refs/heads/main/basical.lua"))()
                        end
                    end
                    
                    update()
                else
                    -- User chose not to load the script
                    ShowNotification("Basic script loading canceled", warningYellow)
                end
            end
        )
    end)
end

-- Enhanced error handling
local success, err = pcall(function()
    CreateMainGUI()
end)

if not success then
    warn("ALADIA LOADER ERROR: "..tostring(err))
    
    -- Create error message GUI
    local ErrorGui = Instance.new("ScreenGui")
    ErrorGui.Name = "ErrorGui"
    ErrorGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    local ErrorFrame = Instance.new("Frame")
    ErrorFrame.Size = UDim2.new(0, 300, 0, 150)
    ErrorFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    ErrorFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    ErrorFrame.Parent = ErrorGui
    
    local ErrorTitle = Instance.new("TextLabel")
    ErrorTitle.Text = "LOADER ERROR"
    ErrorTitle.Font = Enum.Font.GothamBold
    ErrorTitle.TextColor3 = errorRed
    ErrorTitle.Size = UDim2.new(1, 0, 0, 40)
    ErrorTitle.Parent = ErrorFrame
    
    local ErrorMsg = Instance.new("TextLabel")
    ErrorMsg.Text = "Failed to initialize loader:\n"..tostring(err)
    ErrorMsg.TextColor3 = textColor
    ErrorMsg.Size = UDim2.new(1, -20, 1, -60)
    ErrorMsg.Position = UDim2.new(0, 10, 0, 50)
    ErrorMsg.TextWrapped = true
    ErrorMsg.Parent = ErrorFrame
    
    -- Auto-close after 5 seconds
    task.delay(5, function()
        ErrorGui:Destroy()
    end)
end
