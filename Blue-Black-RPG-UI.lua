
--==================================================
-- BLUE & BLACK RPG COMMAND UI
-- ANIMATED + FULLY SCALABLE EDITION
-- MOBILE | TABLET | PC
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old UI
local Old = PlayerGui:FindFirstChild("BlueRPG_UI")
if Old then
    Old:Destroy()
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlueRPG_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Main Panel
local Main = Instance.new("Frame")
Main.Name = "MainPanel"
Main.Size = UDim2.fromOffset(420, 290)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(8, 10, 16)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

-- SCALING SYSTEM
local Scale = Instance.new("UIScale")
Scale.Scale = 1
Scale.Parent = Main

local function UpdateScale()
    local Camera = workspace.CurrentCamera
    if not Camera then return end

    local Viewport = Camera.ViewportSize

    local WidthScale = (Viewport.X - 32) / 420
    local HeightScale = (Viewport.Y - 32) / 290

    Scale.Scale = math.clamp(
        math.min(WidthScale, HeightScale),
        0.45,
        1.15
    )
end

local function ConnectCamera(Camera)
    if not Camera then return end

    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
    UpdateScale()
end

ConnectCamera(workspace.CurrentCamera)

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    ConnectCamera(workspace.CurrentCamera)
end)

-- Main Corner
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = Main

-- Animated Border
local Border = Instance.new("UIStroke")
Border.Thickness = 3
Border.Color = Color3.fromRGB(0, 110, 255)
Border.Parent = Main

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 40, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 40, 120))
})
Gradient.Parent = Border

task.spawn(function()
    while ScreenGui.Parent do
        local Tween = TweenService:Create(
            Gradient,
            TweenInfo.new(2, Enum.EasingStyle.Linear),
            {Rotation = 360}
        )

        Tween:Play()
        Tween.Completed:Wait()
        Gradient.Rotation = 0
    end
end)

-- Inner Panel
local Inner = Instance.new("Frame")
Inner.Size = UDim2.new(1, -12, 1, -12)
Inner.Position = UDim2.fromOffset(6, 6)
Inner.BackgroundColor3 = Color3.fromRGB(12, 15, 23)
Inner.BorderSizePixel = 0
Inner.Parent = Main

local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0, 6)
InnerCorner.Parent = Inner

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 42)
Title.BackgroundTransparency = 1
Title.Text = "COMMAND PANEL"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 19
Title.Parent = Inner

-- Center Diamond
local Diamond = Instance.new("Frame")
Diamond.Size = UDim2.fromOffset(9, 9)
Diamond.Position = UDim2.new(0.5, -4, 0, 43)
Diamond.Rotation = 45
Diamond.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Diamond.BorderSizePixel = 0
Diamond.Parent = Inner

-- Tabs
local TabHolder = Instance.new("Frame")
TabHolder.Size = UDim2.new(1, -24, 0, 38)
TabHolder.Position = UDim2.fromOffset(12, 65)
TabHolder.BackgroundTransparency = 1
TabHolder.Parent = Inner

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 8)
TabLayout.Parent = TabHolder

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -28, 1, -125)
Content.Position = UDim2.fromOffset(14, 112)
Content.BackgroundColor3 = Color3.fromRGB(8, 11, 18)
Content.BorderSizePixel = 0
Content.Parent = Inner

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 5)
ContentCorner.Parent = Content

-- Pages
local Pages = {}

local function CreatePage(Name)
    local Page = Instance.new("Frame")
    Page.Name = Name
    Page.Size = UDim2.fromScale(1, 1)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = Content

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.fromScale(1, 1)
    Label.BackgroundTransparency = 1
    Label.Text = Name .. " CONTENT"
    Label.TextColor3 = Color3.fromRGB(170, 190, 210)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.Parent = Page

    Pages[Name] = Page
end

CreatePage("TAB 1")
CreatePage("TAB 2")
CreatePage("TAB 3")

-- Tab Creation
local function CreateTab(Name)
    local Button = Instance.new("TextButton")
    Button.Name = Name
    Button.Size = UDim2.new(0, 115, 1, 0)
    Button.BackgroundColor3 = Color3.fromRGB(15, 22, 35)
    Button.Text = Name
    Button.TextColor3 = Color3.fromRGB(150, 190, 220)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.AutoButtonColor = false
    Button.Parent = TabHolder

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 100, 200)
    Stroke.Thickness = 1
    Stroke.Parent = Button

    Button.Activated:Connect(function()
        for TabName, Page in pairs(Pages) do
            Page.Visible = TabName == Name
        end

        for _, Other in ipairs(TabHolder:GetChildren()) do
            if Other:IsA("TextButton") then
                Other.BackgroundColor3 =
                    Other == Button
                    and Color3.fromRGB(0, 65, 125)
                    or Color3.fromRGB(15, 22, 35)
            end
        end
    end)

    return Button
end

CreateTab("TAB 1")
CreateTab("TAB 2")
CreateTab("TAB 3")

-- Default Tab
Pages["TAB 1"].Visible = true

local FirstTab = TabHolder:FindFirstChild("TAB 1")
if FirstTab then
    FirstTab.BackgroundColor3 = Color3.fromRGB(0, 65, 125)
end

-- DRAGGING SYSTEM
local Dragging = false
local DragStart
local StartPosition

Main.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
    end
end)

print("BLUE & BLACK RPG COMMAND UI - SCALABLE EDITION LOADED")
