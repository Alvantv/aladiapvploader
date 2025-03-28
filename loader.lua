--[[
  ALADIA SCRIPT LOADER - PREMIUM VERSION
  - Full-screen note display
  - Time-based expiration (DD/MM/YYYY HH:MM)
  - Modern dark theme
  - Confirmation dialogs
  - Loading animations
  - Anti-spam buttons
  - GitHub whitelist integration
  - Blacklist system
  - Purchase requirement check
]]

local function CreateMainGUI()
    -- Color scheme
    local darkBackground = Color3.fromRGB(10, 10, 15)
    local darkerPanel = Color3.fromRGB(20, 20, 25)
    local darkestPanel = Color3.fromRGB(15, 15, 20)
    local textColor = Color3.fromRGB(220, 220, 220)
    local errorRed = Color3.fromRGB(150, 50, 50)
    local successGreen = Color3.fromRGB(50, 150, 50)
    local accentColor = Color3.fromRGB(70, 130, 150)
    local warningYellow = Color3.fromRGB(150, 130, 50)
    local warningRed = Color3.fromRGB(150, 50, 50)
    local buttonHover = Color3.fromRGB(35, 35, 40)

    -- Main GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KemilingHUB | Aladia"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- Parent GUI safely
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end)
    if not success then
        warn("Failed to parent GUI: "..tostring(err))
        return
    end

    -- Current Username
    local currentUsername = game.Players.LocalPlayer.Name

    -- Function to check user status from GitHub
    local function GetUserStatus()
        local success, whitelist = pcall(function()
            local response = game:HttpGet("https://raw.githubusercontent.com/Alvantv/aladiapvploader/refs/heads/main/list.lua", true)
            
            if not response or type(response) ~= "string" or response:len() < 5 then
                error("Invalid whitelist response")
            end
            
            if response:find("<html") or response:find("<!DOCTYPE") then
                error("Whitelist not found")
            end
            
            return response
        end)

        if not success then
            warn("[ALADIA LOADER] Whitelist fetch error: "..tostring(whitelist))
            return {
                blacklisted = false,
                needsPurchase = false,
                note = ""
            }
        end

        local status = {
            blacklisted = false,
            needsPurchase = false,
            note = ""
        }
        
        -- Check for user entry
        for line in whitelist:gmatch("[^\r\n]+") do
            -- Check for blacklist status
            local user, blacklistStatus = line:match("Usn:%s*(.-)%s*|%s*Blacklist:%s*(%S+)")
            if user and blacklistStatus then
                if string.lower(user) == string.lower(currentUsername) and string.lower(blacklistStatus) == "true" then
                    status.blacklisted = true
                end
            end
            
            -- Check for purchase requirement
            local user, needsBuy = line:match("Usn:%s*(.-)%s*|%s*Nbuy:%s*(%S+)")
            if user and needsBuy then
                if string.lower(user) == string.lower(currentUsername) and string.lower(needsBuy) == "true" then
                    status.needsPurchase = true
                end
            end
            
            -- Check for custom note
            local user, note = line:match("Usn:%s*(.-)%s*|%s*Note:%s*(.+)")
            if user and note then
                if string.lower(user) == string.lower(currentUsername) then
                    status.note = note
                end
            end
        end
        
        return status
    end

    -- Check user status
    local userStatus = GetUserStatus()

    -- Main container
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
    Title.Text = "KemilingHUB | Aladia"
    Title.TextColor3 = textColor
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

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

    -- Menu button
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

    MenuButton.MouseButton1Click:Connect(function()
        setclipboard("https://dsc.gg/kemilinghub")
        ShowNotification("Discord Link Copied!", accentColor)
    end)

    -- If user is blacklisted, show message and return
    if userStatus.blacklisted then
        -- Warning text
        local WarningText = Instance.new("TextLabel")
        WarningText.Name = "WarningText"
        WarningText.Parent = MainFrame
        WarningText.BackgroundTransparency = 1
        WarningText.Size = UDim2.new(1, -40, 0, 40)
        WarningText.Position = UDim2.new(0, 20, 0.24, 0)
        WarningText.Font = Enum.Font.GothamBold
        WarningText.Text = "⚠ WARNING ⚠"
        WarningText.TextColor3 = warningRed
        WarningText.TextSize = 24
        WarningText.TextWrapped = true

        local BlacklistMessage = Instance.new("TextLabel")
        BlacklistMessage.Name = "BlacklistMessage"
        BlacklistMessage.Parent = MainFrame
        BlacklistMessage.BackgroundTransparency = 1
        BlacklistMessage.Size = UDim2.new(1, -40, 0.6, 0)
        BlacklistMessage.Position = UDim2.new(0, 20, 0.26, 0)
        BlacklistMessage.Font = Enum.Font.GothamBold
        BlacklistMessage.Text = "AKUN KAMU TELAH DI BLACKLIST"
        BlacklistMessage.TextColor3 = warningRed
        BlacklistMessage.TextSize = 24
        BlacklistMessage.TextWrapped = true

        local BlacklistMessage = Instance.new("TextLabel")
        BlacklistMessage.Name = "BlacklistMessage"
        BlacklistMessage.Parent = MainFrame
        BlacklistMessage.BackgroundTransparency = 1
        BlacklistMessage.Size = UDim2.new(1, -40, 0.6, 0)
        BlacklistMessage.Position = UDim2.new(0.10, 20, 0.63, 0)
        BlacklistMessage.Font = Enum.Font.GothamBold
        BlacklistMessage.Text = "Req Unblacklist di sini -->"
        BlacklistMessage.TextColor3 = textColor
        BlacklistMessage.TextSize = 18
        BlacklistMessage.TextWrapped = true
        
        -- Disable all functionality
        return
    end

    -- If user needs to purchase, show message
    if userStatus.needsPurchase then
        local PurchaseFrame = Instance.new("Frame")
        PurchaseFrame.Name = "PurchaseFrame"
        PurchaseFrame.Parent = MainFrame
        PurchaseFrame.BackgroundTransparency = 1
        PurchaseFrame.Size = UDim2.new(1, 0, 1, 0)
        
        local WarningText = Instance.new("TextLabel")
        WarningText.Name = "WarningText"
        WarningText.Parent = PurchaseFrame
        WarningText.BackgroundTransparency = 1
        WarningText.Size = UDim2.new(1, -40, 0, 40)
        WarningText.Position = UDim2.new(0, 20, 0.24, 0)
        WarningText.Font = Enum.Font.GothamBold
        WarningText.Text = "⚠ PURCHASE REQUIRED ⚠"
        WarningText.TextColor3 = warningYellow
        WarningText.TextSize = 20
        WarningText.TextWrapped = true

        local PurchaseMessage = Instance.new("TextLabel")
        PurchaseMessage.Name = "PurchaseMessage"
        PurchaseMessage.Parent = PurchaseFrame
        PurchaseMessage.BackgroundTransparency = 1
        PurchaseMessage.Size = UDim2.new(1, -40, 0.6, 0)
        PurchaseMessage.Position = UDim2.new(0, 20, 0.23, 0)
        PurchaseMessage.Font = Enum.Font.GothamBold
        PurchaseMessage.Text = "You need to purchase access (40k/week) to continue using this cheat"
        PurchaseMessage.TextColor3 = textColor
        PurchaseMessage.TextSize = 16
        PurchaseMessage.TextWrapped = true
        
        -- Add contact information or purchase button here if needed
        local ContactButton = Instance.new("TextButton")
        ContactButton.Name = "ContactButton"
        ContactButton.Parent = PurchaseFrame
        ContactButton.BackgroundColor3 = darkestPanel
        ContactButton.Position = UDim2.new(0.5, -100, 0.7, 0)
        ContactButton.Size = UDim2.new(0, 200, 0, 40)
        ContactButton.Font = Enum.Font.GothamBold
        ContactButton.Text = "CONTACT US"
        ContactButton.TextColor3 = textColor
        ContactButton.TextSize = 14
        ContactButton.AutoButtonColor = false
        
        ContactButton.MouseButton1Click:Connect(function()
            setclipboard("https://dsc.gg/kemilinghub")
            ShowNotification("Discord link copied!", accentColor)
        end)
        
        return
    end

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

    -- Footer
    local Footer = Instance.new("TextLabel")
    Footer.Name = "Footer"
    Footer.Parent = MainFrame
    Footer.BackgroundTransparency = 1
    Footer.Position = UDim2.new(0, 0, 0.9, 0)
    Footer.Size = UDim2.new(1, 0, 0, 30)
    Footer.Font = Enum.Font.Gotham
    Footer.Text = "ALADIA SCRIPT | TIME-BASED LICENSE"
    Footer.TextColor3 = Color3.fromRGB(100, 100, 100)
    Footer.TextSize = 12

    -- Click sound
    local function PlayClickSound()
        local clickSound = Instance.new("Sound")
        clickSound.SoundId = "rbxassetid://138080526"
        clickSound.Volume = 0.3
        clickSound.Parent = MainFrame
        clickSound:Play()
        game:GetService("Debris"):AddItem(clickSound, 2)
    end

    -- Time-based expiration check
    local function IsKeyExpired(expDateTime)
        local day, month, year, hour, minute = expDateTime:match("(%d+)/(%d+)/(%d+)%s+(%d+):(%d+)")
        if not day or not month or not year or not hour or not minute then
            day, month, year = expDateTime:match("(%d+)/(%d+)/(%d+)")
            if not day or not month or not year then
                return true
            end
            hour = "23"
            minute = "59"
        end
        
        day = tonumber(day)
        month = tonumber(month)
        year = tonumber(year)
        hour = tonumber(hour)
        minute = tonumber(minute)
        
        local currentDateTime = os.date("*t")
        
        if year > currentDateTime.year then
            return false
        elseif year < currentDateTime.year then
            return true
        else
            if month > currentDateTime.month then
                return false
            elseif month < currentDateTime.month then
                return true
            else
                if day > currentDateTime.day then
                    return false
                elseif day < currentDateTime.day then
                    return true
                else
                    if hour > currentDateTime.hour then
                        return false
                    elseif hour < currentDateTime.hour then
                        return true
                    else
                        return minute < currentDateTime.min
                    end
                end
            end
        end
    end

    -- Full-screen note display
    local function ShowFullScreenNote(message)
        local NoteOverlay = Instance.new("Frame")
        NoteOverlay.Name = "NoteOverlay"
        NoteOverlay.Parent = ScreenGui
        NoteOverlay.BackgroundColor3 = darkestPanel
        NoteOverlay.Size = UDim2.new(1, 0, 1, 0)
        NoteOverlay.ZIndex = 50
        
        local NoteContainer = Instance.new("Frame")
        NoteContainer.Name = "NoteContainer"
        NoteContainer.Parent = NoteOverlay
        NoteContainer.BackgroundColor3 = darkerPanel
        NoteContainer.Size = UDim2.new(1, -40, 1, -40)
        NoteContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        NoteContainer.AnchorPoint = Vector2.new(0.5, 0.5)
        NoteContainer.ZIndex = 51
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = NoteContainer
        
        local TitleBar = Instance.new("Frame")
        TitleBar.Name = "TitleBar"
        TitleBar.Parent = NoteContainer
        TitleBar.BackgroundColor3 = darkestPanel
        TitleBar.Size = UDim2.new(1, 0, 0, 60)
        TitleBar.Position = UDim2.new(0, 0, 0, 0)
        
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Parent = TitleBar
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, -40, 1, 0)
        Title.Position = UDim2.new(0, 20, 0, 0)
        Title.Font = Enum.Font.GothamBold
        Title.Text = "ALADIA SCRIPT NOTIFICATION"
        Title.TextColor3 = warningYellow
        Title.TextSize = 24
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.ZIndex = 52
        
        local WarningText = Instance.new("TextLabel")
        WarningText.Name = "WarningText"
        WarningText.Parent = NoteContainer
        WarningText.BackgroundTransparency = 1
        WarningText.Size = UDim2.new(1, -40, 0, 40)
        WarningText.Position = UDim2.new(0, 20, 0.2, 50)
        WarningText.Font = Enum.Font.GothamBold
        WarningText.Text = "⚠ WARNING ⚠"
        WarningText.TextColor3 = warningRed
        WarningText.TextSize = 44
        WarningText.ZIndex = 52
        WarningText.TextYAlignment = Enum.TextYAlignment.Bottom

        local ScrollFrame = Instance.new("ScrollingFrame")
        ScrollFrame.Name = "ScrollFrame"
        ScrollFrame.Parent = NoteContainer
        ScrollFrame.BackgroundTransparency = 1
        ScrollFrame.Size = UDim2.new(1, -40, 0.6, 0)
        ScrollFrame.Position = UDim2.new(0, 20, 0.5, 0)
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollFrame.ScrollBarThickness = 8
        ScrollFrame.ZIndex = 52
        ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        
        local MessageText = Instance.new("TextLabel")
        MessageText.Name = "MessageText"
        MessageText.Parent = ScrollFrame
        MessageText.BackgroundTransparency = 1
        MessageText.Size = UDim2.new(1, 0, 0, 0)
        MessageText.Font = Enum.Font.GothamBold
        MessageText.Text = message
        MessageText.TextColor3 = textColor
        MessageText.TextSize = 20
        MessageText.TextWrapped = true
        MessageText.TextXAlignment = Enum.TextXAlignment.Center
        MessageText.TextYAlignment = Enum.TextYAlignment.Top
        MessageText.AutomaticSize = Enum.AutomaticSize.Y
        MessageText.ZIndex = 52
        
        MessageText:GetPropertyChangedSignal("TextBounds"):Connect(function()
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, MessageText.TextBounds.Y + 20)
        end)
        
        local CloseButton = Instance.new("TextButton")
        CloseButton.Name = "CloseButton"
        CloseButton.Parent = NoteContainer
        CloseButton.BackgroundColor3 = darkestPanel
        CloseButton.Size = UDim2.new(0.6, 0, 0, 60)
        CloseButton.Position = UDim2.new(0.2, 0, 0.9, -30)
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.Text = "CLOSE MESSAGE"
        CloseButton.TextColor3 = textColor
        CloseButton.TextSize = 18
        CloseButton.AutoButtonColor = false
        CloseButton.ZIndex = 52
        
        local UICorner2 = Instance.new("UICorner")
        UICorner2.CornerRadius = UDim.new(0, 6)
        UICorner2.Parent = CloseButton
        
        CloseButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = buttonHover
            }):Play()
        end)
        
        CloseButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = darkestPanel
            }):Play()
        end)
        
        CloseButton.MouseButton1Click:Connect(function()
            PlayClickSound()
            game:GetService("TweenService"):Create(NoteOverlay, TweenInfo.new(0.3), {
                BackgroundTransparency = 1
            }):Play()
            task.wait(0.3)
            NoteOverlay:Destroy()
        end)
        
        NoteOverlay.BackgroundTransparency = 1
        NoteContainer.Size = UDim2.new(0, 0, 0, 0)
        NoteContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        game:GetService("TweenService"):Create(NoteOverlay, TweenInfo.new(0.3), {
            BackgroundTransparency = 0
        }):Play()
        
        game:GetService("TweenService"):Create(NoteContainer, TweenInfo.new(0.3), {
            Size = UDim2.new(1, -40, 1, -40),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
    end

    -- Confirmation dialog
    local function CreateConfirmationDialog(title, message, confirmCallback)
        local Overlay = Instance.new("Frame")
        Overlay.Name = "ConfirmationOverlay"
        Overlay.Parent = ScreenGui
        Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        Overlay.BackgroundTransparency = 0.7
        Overlay.Size = UDim2.new(1, 0, 1, 0)
        Overlay.ZIndex = 10
        
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
        DialogMessage.ZIndex = 12
        
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Name = "ButtonContainer"
        ButtonContainer.Parent = DialogFrame
        ButtonContainer.BackgroundTransparency = 1
        ButtonContainer.Size = UDim2.new(1, -20, 0, 40)
        ButtonContainer.Position = UDim2.new(0, 10, 1, -50)
        ButtonContainer.ZIndex = 12
        
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
        
        DialogFrame.Size = UDim2.new(0, 0, 0, 0)
        DialogFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        game:GetService("TweenService"):Create(DialogFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 320, 0, 200),
            Position = UDim2.new(0.5, -160, 0.5, -100)
        }):Play()
    end

    -- Premium Button Functionality
    PremiumButton.MouseButton1Click:Connect(function()
        PlayClickSound()
        PremiumButton.Visible = false
        BasicButton.Visible = false
        Title.Text = "ENTER LICENSE KEY"
        
        local LicenseFrame = Instance.new("Frame")
        LicenseFrame.Name = "LicenseFrame"
        LicenseFrame.Parent = MainFrame
        LicenseFrame.BackgroundTransparency = 1
        LicenseFrame.Size = UDim2.new(1, 0, 1, -50)
        LicenseFrame.Position = UDim2.new(0, 0, 0, 50)
        
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
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Name = "StatusLabel"
        StatusLabel.Parent = LicenseFrame
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0, 20, 0.2, 0)
        StatusLabel.Size = UDim2.new(1, -40, 0, 20)
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.Text = ""
        StatusLabel.TextColor3 = errorRed
        StatusLabel.TextSize = 14
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local KeyInputContainer = Instance.new("Frame")
        KeyInputContainer.Name = "KeyInputContainer"
        KeyInputContainer.Parent = LicenseFrame
        KeyInputContainer.BackgroundColor3 = darkestPanel
        KeyInputContainer.Position = UDim2.new(0.5, -140, 0.4, 0)
        KeyInputContainer.Size = UDim2.new(0, 280, 0, 50)
        
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
        
        local isVerifying = false
        
        VerifyButton.MouseButton1Click:Connect(function()
            if isVerifying then return end
            isVerifying = true
            PlayClickSound()
            
            VerifyButton.Text = "VERIFYING..."
            VerifyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            
            local enteredKey = KeyInput.Text
            enteredKey = string.upper(enteredKey:gsub("%s+", ""))
            
            if enteredKey == "" then
                StatusLabel.Text = "PLEASE ENTER A VALID KEY"
                isVerifying = false
                VerifyButton.Text = "VERIFY KEY"
                VerifyButton.BackgroundColor3 = darkestPanel
                return
            end

            local success, whitelist = pcall(function()
                local response = game:HttpGet("https://raw.githubusercontent.com/Alvantv/aladiapvploader/refs/heads/main/list.lua", true)
                
                if not response or type(response) ~= "string" or response:len() < 5 then
                    error("Invalid whitelist response")
                end
                
                if response:find("<html") or response:find("<!DOCTYPE") then
                    error("Whitelist not found")
                end
                
                return response
            end)
            
            if not success then
                StatusLabel.Text = "FAILED TO LOAD WHITELIST"
                StatusLabel.TextColor3 = errorRed
                isVerifying = false
                VerifyButton.Text = "VERIFY KEY"
                VerifyButton.BackgroundColor3 = darkestPanel
                warn("[ALADIA LOADER] Whitelist fetch error: "..tostring(whitelist))
                return
            end

            local isValid = false
            local isPremium = false
            local isExpired = false
            local expirationDate = ""
            local note = ""
            
            for line in whitelist:gmatch("[^\r\n]+") do
                local user, key, foundNote = line:match("Usn:%s*(.-)%s*|%s*Key:%s*(%S+)%s*|%s*Note:%s*(.+)")
                if user and key and foundNote then
                    if string.lower(user) == string.lower(currentUsername) 
                       and string.upper(key) == enteredKey then
                        isValid = true
                        isPremium = true
                        note = foundNote
                        isExpired = false
                        break
                    end
                else
                    local user, key, exp = line:match("Usn:%s*(.-)%s*|%s*Key:%s*(%S+)%s*|%s*Exp:%s*(.+)")
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
            end

            if isValid then
                if isExpired then
                    StatusLabel.Text = "LICENSE EXPIRED ("..expirationDate..")"
                    StatusLabel.TextColor3 = errorRed
                else
                    StatusLabel.Text = ""
                    
                    if note ~= "" then
                        ShowFullScreenNote(note)
                        
                        task.delay(5, function()
                            LicenseFrame:Destroy()
                            Title.Text = "KemilingHUB | Aladia"
                            PremiumButton.Visible = true
                            BasicButton.Visible = true
                        end)
                    else
                        CreateConfirmationDialog(
                            "PREMIUM SCRIPT", 
                            "Are you sure you want to load the premium script?\nExpires: "..expirationDate,
                            function(confirmed)
                                if confirmed then
                                    local LoadingFrame = Instance.new("Frame")
                                    LoadingFrame.Name = "LoadingFrame"
                                    LoadingFrame.Parent = MainFrame
                                    LoadingFrame.BackgroundColor3 = darkestPanel
                                    LoadingFrame.Size = UDim2.new(1, 0, 0, 30)
                                    LoadingFrame.Position = UDim2.new(0, 0, 1, -30)
                                    LoadingFrame.AnchorPoint = Vector2.new(0, 1)
                                    
                                    local LoadingBar = Instance.new("Frame")
                                    LoadingBar.Name = "LoadingBar"
                                    LoadingBar.Parent = LoadingFrame
                                    LoadingBar.BackgroundColor3 = accentColor
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

                                    local duration = 1
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
                                end
                            end
                        )
                    end
                end
            else
                StatusLabel.Text = "INVALID LICENSE KEY"
                StatusLabel.TextColor3 = errorRed
            end
            
            -- Reset button state
            isVerifying = false
            VerifyButton.Text = "VERIFY KEY"
            VerifyButton.BackgroundColor3 = darkestPanel
        end)
        
        -- Back Button Functionality
        BackButton.MouseButton1Click:Connect(function()
            PlayClickSound()
            LicenseFrame:Destroy()
            Title.Text = "KemilingHUB | Aladia"
            PremiumButton.Visible = true
            BasicButton.Visible = true
        end)
    end)

    -- Basic Button Functionality
    local isConfirming = false
    
    BasicButton.MouseButton1Click:Connect(function()
        if isConfirming then return end
        isConfirming = true
        PlayClickSound()
        
        CreateConfirmationDialog(
            "BASIC SCRIPT", 
            "Are you sure you want to load the basic script?",
            function(confirmed)
                isConfirming = false
                
                if confirmed then
                    PremiumButton.Visible = false
                    BasicButton.Visible = false
                    Title.Text = "LOADING BASIC..."
                    
                    -- Loading animation
                    local LoadingFrame = Instance.new("Frame")
                    LoadingFrame.Name = "LoadingFrame"
                    LoadingFrame.Parent = MainFrame
                    LoadingFrame.BackgroundColor3 = darkestPanel
                    LoadingFrame.Size = UDim2.new(1, 0, 0, 30)
                    LoadingFrame.Position = UDim2.new(0, 0, 1, -30)
                    LoadingFrame.AnchorPoint = Vector2.new(0, 1)
                    
                    local LoadingBar = Instance.new("Frame")
                    LoadingBar.Name = "LoadingBar"
                    LoadingBar.Parent = LoadingFrame
                    LoadingBar.BackgroundColor3 = accentColor
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

                    local duration = 3
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
                end
            end
        )
    end)
end

-- Error handling
local success, err = pcall(CreateMainGUI)
if not success then
    warn("ALADIA LOADER ERROR: "..tostring(err))
    
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
    ErrorTitle.TextColor3 = Color3.fromRGB(150, 50, 50)
    ErrorTitle.Size = UDim2.new(1, 0, 0, 40)
    ErrorTitle.Parent = ErrorFrame
    
    local ErrorMsg = Instance.new("TextLabel")
    ErrorMsg.Text = "Failed to initialize loader:\n"..tostring(err)
    ErrorMsg.TextColor3 = Color3.fromRGB(220, 220, 220)
    ErrorMsg.Size = UDim2.new(1, -20, 1, -60)
    ErrorMsg.Position = UDim2.new(0, 10, 0, 50)
    ErrorMsg.TextWrapped = true
    ErrorMsg.Parent = ErrorFrame
    
    task.delay(5, function()
        ErrorGui:Destroy()
    end)
end
