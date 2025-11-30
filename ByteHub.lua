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

redzlib:SetTheme("Dark")

local Tab1 = Window:MakeTab({"Principal", "egg"})
local Section1 = Tab1:AddSection({"Byte Hub - Speed"})

Tab1:AddDiscordInvite({
    Name = "Byte Hub",
    Description = "Join server",
    Logo = "rbxassetid://237723462",
    Invite = "https://discord.gg/Jwt3nQGyu8",
})


---------------------------------------------------------------------
-- LÓGICA
---------------------------------------------------------------------

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function SetWalkSpeed(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end

local function SetJump(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = value
    end
end


---------------------------------------------------------------------
-- SLIDERS
---------------------------------------------------------------------

local walkSlider = Tab1:AddSlider({
    Name = "WalkSpeed",
    Min = 1,
    Max = 100,
    Increase = 1,
    Default = 16,
    Callback = function(Value)
        SetWalkSpeed(Value)
    end
})

local jumpSlider = Tab1:AddSlider({
    Name = "WalkJump",
    Min = 1,
    Max = 300,
    Increase = 1,
    Default = 50,
    Callback = function(Value)
        SetJump(Value)
    end
})


---------------------------------------------------------------------
-- BOTÃO RESET
---------------------------------------------------------------------

Tab1:AddButton({"Reset Walk", function()

    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        
        -- Reset valores padrões
        char.Humanoid.WalkSpeed = 16
        char.Humanoid.JumpPower = 50
    end

    -- Atualiza sliders visualmente
    walkSlider:Set(16)
    jumpSlider:Set(50)

    -- Popup de confirmação
    Window:Dialog({
        Title = "Walk Resetado",
        Text = "Seu WalkSpeed e Jump foram restaurados aos valores padrão!",
        Options = {
            {
                Label = "OK",
                Callback = function() end
            }
        }
    })
end})

---------------------------------------------------------------------
-- FIM
---------------------------------------------------------------------

local Section2 = Tab1:AddSection({"Byte Hub - Extras"})

local Physics = game:GetService("PhysicsService")

-- Criar collision group
local groupName = "NoclipGroup"

if not pcall(function()
    Physics:CreateCollisionGroup(groupName)
end) then
    -- Já existe, ignorar
end

-- Faz o grupo ignorar colisões com tudo
Physics:CollisionGroupSetCollidable(groupName, groupName, false)

-----------------------------
-- Separação somente
-----------------------------

local function SetNoclip(enabled)
    local character = player.Character
    if not character then return end

    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            if enabled then
                Physics:SetPartCollisionGroup(part, groupName)
            else
                Physics:SetPartCollisionGroup(part, "Default")
            end
        end
    end
end

local Toggle1 = Tab1:AddToggle({
    Name = "Noclip",
    Description = "Ativa a habilidade de atravessar paredes",
    Default = false 
})

Toggle1:Callback(function(Value)
    SetNoclip(Value)

    -- Opcional: popup mostrando o estado
    Window:Dialog({
        Title = "Noclip",
        Text = Value and "Noclip On" or "Noclip Off",
        Options = {
            { Label = "OK", Callback = function() end }
        }
    })
end)

---------------------------------------------------------------------
-- HITBOX EXPAND VISUAL
---------------------------------------------------------------------

local hitboxToggle = Tab1:AddToggle({
    Name = "Hitbox Expand",
    Description = "Ativa/desativa o aumento da hitbox visível",
    Default = false
})

local hitboxSlider = Tab1:AddSlider({
    Name = "Hitbox Size",
    Min = 1,
    Max = 10,
    Increase = 0.1,
    Default = 1,
    Callback = function(Value)
        if hitboxToggle.Value and hitboxPart then
            hitboxPart.Size = Vector3.new(2, 2, 1) * Value
        end
    end
})

-- Criar o hitbox (ciano e transparente)
local hitboxPart

local function CreateHitbox()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Criar apenas se não existir
    if not hitboxPart then
        hitboxPart = Instance.new("Part")
        hitboxPart.Anchored = true
        hitboxPart.CanCollide = false
        hitboxPart.Transparency = 0.5
        hitboxPart.Color = Color3.fromRGB(0, 255, 255) -- Ciano
        hitboxPart.Material = Enum.Material.Neon
        hitboxPart.Parent = workspace
    end

    -- Atualiza posição e tamanho
    hitboxPart.Size = Vector3.new(2, 2, 1) * hitboxSlider.Value
    hitboxPart.CFrame = root.CFrame
end

-- Atualizar continuamente se toggle estiver ativo
game:GetService("RunService").RenderStepped:Connect(function()
    if hitboxToggle.Value then
        CreateHitbox()
        hitboxPart.Transparency = 0.5
        hitboxPart.CanCollide = false
    else
        if hitboxPart then
            hitboxPart:Destroy()
            hitboxPart = nil
        end
    end
end)

