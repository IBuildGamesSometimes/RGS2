local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local module = {}

local DragToggle
local DragStartPosition
local FrameStartPosition
local DragSpeed = 0.1

local function Drag(Input)
    local Delta = Input.Position - DragStartPosition
    local Position = UDim2.new(
        FrameStartPosition.X.Scale,
        FrameStartPosition.X.Offset + Delta.X,
        FrameStartPosition.Y.Scale,
        FrameStartPosition.Y.Offset + Delta.Y
    )
    TweenService:Create(DragToggle, TweenInfo.new(DragSpeed), {Position = Position}):Play()
 end

function HandleFrameDrag(frame)
    frame.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
            local Connection
            DragToggle = frame
            DragStartPosition = Input.Position
            FrameStartPosition = frame.Position
            Connection = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    DragToggle = nil
                    DragStartPosition = nil
                    FrameStartPosition = nil
                    Connection:Disconnect()
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            if DragToggle == frame then
                Drag(Input)
            end
        end
    end)
end

function module.New(Settings,AllowFrameDrag)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    local Frame = Instance.new("Frame")
    Frame.BackgroundColor3 = Color3.fromRGB(89,89,89)
    Frame.Size = UDim2.new(0.2,0,0.3,0)
    Frame.Parent = ScreenGui
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1,0,0.1,0)
    TextLabel.Position = UDim2.new(0,0,0,0)
    TextLabel.BackgroundColor3 = Color3.fromRGB(50,50,50)
    TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
    TextLabel.TextScaled = true
    TextLabel.Text = "Settings"
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.Parent = Frame
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1,0,0.8,0)
    ScrollingFrame.Position = UDim2.new(0,0,0.1,0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ScrollingFrame
    for Setting,Function in pairs(Settings) do
        local TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.new(1,0,0.2,0)
        TextButton.BackgroundTransparency = 0.5
        TextButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
        TextButton.TextColor3 = Color3.fromRGB(255,255,255)
        TextButton.TextScaled = true
        TextButton.Text = Setting
        TextButton.Font = Enum.Font.FredokaOne
        TextButton.Parent = ScrollingFrame
        getgenv()[Setting] = false
        TextButton.Activated:Connect(function()
            if getgenv()[Setting] == false then
                getgenv()[Setting] = true
                TextButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
            else
                getgenv()[Setting] = false
                TextButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
            end
            if Function then
                Function(getgenv()[Setting])
            end
        end)
    end
    if AllowFrameDrag then
        HandleFrameDrag(Frame)
    end
end

return module
