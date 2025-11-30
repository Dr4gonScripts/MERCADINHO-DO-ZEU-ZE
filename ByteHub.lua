local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local Window = redzlib:MakeWindow({
  Title = "Byte Hub | Universal",
  SubTitle = "by draknessxz",
  SaveFolder = "ByteTAB"
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://237723462", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

Tab1:AddDiscordInvite({
    Name = "Byte Hub",
    Description = "Join server",
    Logo = "rbxassetid://237723462",
    Invite = "https://discord.gg/Jwt3nQGyu8",
})

  redzlib:SetTheme("Dark")

local Tab1 = Window:MakeTab({"Principal", "egg"})
local Section1 = Tab1:AddSection({"Byte Hub"})

Tab1:AddSlider({
    Name = "WalkSpeed",
    Min = 1,
    Max = 100,
    Increase = 1,
    Default = 16,
    Callback = function(Value)
        SetWalkSpeed(Value)
    end
})


Tab1:AddSlider({
    Name = "WalkJump",
    Min = 1,
    Max = 300,
    Increase = 1,
    Default = 50,
    Callback = function(Value)
        SetJump(Value)
    end
})


-- Logica

local Players = game:GetService("Players")
local player = Players.LocalPlayer


local function SetWalkSpeed(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end


local function SetJump(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = value -- JumpPower controla a altura do pulo
    end
end


