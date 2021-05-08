--[[

    __      __          _            _       ______  _____ _____    __  __           _       _      
    \ \    / /         (_)          ( )     |  ____|/ ____|  __ \  |  \/  |         | |     | |     
     \ \  / /   _ _ __  ___  ___   _|/ ___  | |__  | (___ | |__) | | \  / | ___   __| |_   _| | ___ 
      \ \/ / | | | '_ \| \ \/ / | | | / __| |  __|  \___ \|  ___/  | |\/| |/ _ \ / _` | | | | |/ _ \
       \  /| |_| | | | | |>  <| |_| | \__ \ | |____ ____) | |      | |  | | (_) | (_| | |_| | |  __/
        \/  \__, |_| |_|_/_/\_\\__,_| |___/ |______|_____/|_|      |_|  |_|\___/ \__,_|\__,_|_|\___|
             __/ |                                                                                  
            |___/
            
    Vynixu's ESP Module v1.0.1a
    
    Scripting - Vynixu
    
    [ What's new? ]
    
    [*] Fixed re-adding ESP to an object
    
]]--

-- Wow it's open source would you look at that. Piss off you fucking skid

local ESP = {
    Container = {},
    Settings = {
        Enabled = true,
        Distance = true,
        Health = true,
        Tracers = true,
        Rainbow = false,
    }
}

-- Services

local Players = game:GetService("Players")
local RS = game:GetService("RunService")

-- Variables

local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local RootPart = Char:WaitForChild("HumanoidRootPart")

local Cam = workspace.CurrentCamera
local BottomMiddle = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y)

-- Functions

function ESP.Add(plr, root, colour)
    if ESP.Container[root] then
        ESP.Remove(root)
    end

    local Holder = {
        Draw = {
            Name = Drawing.new("Text"),
            Display = Drawing.new("Text"),
            Tracer = Drawing.new("Line"),
        },
        Connections = {},
        Colour = colour,
    }

    ESP.Container[root] = Holder

    Holder.Draw.Name.Text = plr.Name
    Holder.Draw.Name.Color = Holder.Colour
    Holder.Draw.Name.Outline = true
    Holder.Draw.Name.Center = true

    Holder.Draw.Display.Color = Color3.fromRGB(255,255,255)
    Holder.Draw.Display.Outline = true
    Holder.Draw.Display.Center = true

    Holder.Draw.Tracer.Color = Holder.Colour
    Holder.Draw.Tracer.From = BottomMiddle

    root.AncestryChanged:Connect(function()
        if not root:IsDescendantOf(workspace) then
            ESP.Remove(root)
        end
    end)

    Holder.Connections.Connection = RS.Stepped:Connect(function()
        if ESP.Settings.Enabled then
            local Pos, onScreen = ESP.WTVPoint(root.CFrame)
            if Pos and onScreen then
                local NamePos = Vector2.new(Pos.X, Pos.Y - 14)
                local DisplayPos = Vector2.new(Pos.X, Pos.Y)

                Holder.Draw.Name.Position = NamePos
                Holder.Draw.Display.Position = DisplayPos
                Holder.Draw.Tracer.To = Vector2.new(Pos.X, Pos.Y)

                ESP.UpdateDisplay(Holder, root, ESP.IsPlayer(plr) and plr.Character:FindFirstChild("Humanoid") or nil)
            end
            ESP.UpdateVisibility(Holder, root)
            ESP.UpdateColour(Holder)

        elseif Holder.Draw.Name.Visible then
            for i, v in next, Holder.Draw do
                v.Visible = false
            end
        end
    end)
end

function ESP.Remove(root)
    for i, v in next, ESP.Container do
        if i == root then
            for _, x in next, v.Draw do
                x:Remove()
            end
            for _, x in next, v.Connections do
                x:Disconnect()
            end
            ESP.Container[i] = nil
        end
    end
end

function ESP.IsPlayer(plr)
    return plr.Parent == Players
end

function ESP.GetXZMagnitude(root)
    return (Vector3.new(RootPart.Position.X, 0, RootPart.Position.Z) - Vector3.new(root.Position.X, 0, root.Position.Z)).Magnitude
end

function ESP.GetHealth(hum)
    return math.floor(hum.Health / hum.MaxHealth * 100)
end

function ESP.WTVPoint(pos)
    return Cam:WorldToViewportPoint(Vector3.new(pos.Position.X, pos.Position.Y, pos.Position.Z))
end

function ESP.UpdateVisibility(holder, root)
    local Pos, onScreen = ESP.WTVPoint(root.CFrame)
    for i, v in next, holder.Draw do
        v.Visible = (Pos and onScreen)
    end
end

function ESP.UpdateDisplay(holder, root, hum)
    local Health = (hum and ESP.Settings.Health) and "["..ESP.GetHealth(hum).."%] " or ""
    local Dist = (root and ESP.Settings.Distance) and "["..math.floor(ESP.GetXZMagnitude(root.CFrame)).." studs]" or ""
    holder.Draw.Display.Text = Health..Dist
end

function ESP.UpdateColour(holder)
    local colour = ESP.Settings.Rainbow and Color3.fromHSV(tick() % 5 / 5, 1, 1) or holder.Colour
    holder.Draw.Name.Color = colour
    holder.Draw.Tracer.Color = colour
end

-- Passive

Plr.CharacterAdded:Connect(function(char)
    Char, RootPart = char, char:WaitForChild("HumanoidRootPart")
end)

-- Return

return ESP
