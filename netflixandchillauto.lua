-- SETTINGS
local enabled = true
local showVisualZone = true -- Set to false if you want the red box invisible from the start

-- THE COORDINATES
local minX, maxX = -62.2, 93.0
local minZ, maxZ = 22.1, 50.8
local minY, maxY = -117.8, -114.5 

local target1v1 = Vector3.new(31.7, -114.5, 57.9)

-- Visual Red Box Setup
local zone = Instance.new("Part")
zone.Name = "TeleportZoneVisual"
zone.Parent = game.Workspace
zone.Size = Vector3.new(maxX - minX, 15, maxZ - minZ)
zone.Position = Vector3.new((minX + maxX)/2, minY + 5, (minZ + maxZ)/2)
zone.Anchored = true
zone.CanCollide = false
zone.Color = Color3.fromRGB(255, 0, 0)
zone.Material = Enum.Material.Neon
zone.Transparency = showVisualZone and 0.7 or 1

-- Main Logic Loop
task.spawn(function()
    while task.wait(0.3) do
        if enabled then
            local player = game.Players.LocalPlayer
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                local p = hrp.Position
                -- Boundary Check (X and Z)
                if (p.X >= minX and p.X <= maxX) and 
                   (p.Z >= minZ and p.Z <= maxZ) then
                    
                    -- Teleport
                    hrp.CFrame = CFrame.new(target1v1 + Vector3.new(0, 3, 0))
                    
                    -- Wait to prevent infinite teleport loops
                    task.wait(3) 
                end
            end
        end
    end
end)
