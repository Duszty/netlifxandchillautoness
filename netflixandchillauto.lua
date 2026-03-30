local Window = Library:CreateWindow({
    Title = 'Custom Zone TP',
    Center = true,
    AutoShow = true,
})

local Tab = Window:AddTab('Main')
local Group = Tab:AddLeftGroupbox('Status')

-- THE COORDINATES YOU PINPOINTED
local minX, maxX = -62.2, 93.0
local minZ, maxZ = 22.1, 50.8
local minY, maxY = -117.8, -114.5 -- Using your Y range

local target1v1 = Vector3.new(31.7, -114.5, 57.9)
local enabled = true

-- Visual Red Box
local zone = Instance.new("Part", game.Workspace)
zone.Size = Vector3.new(maxX - minX, 15, maxZ - minZ)
zone.Position = Vector3.new((minX + maxX)/2, minY + 5, (minZ + maxZ)/2)
zone.Anchored = true
zone.CanCollide = false
zone.Color = Color3.fromRGB(255, 0, 0)
zone.Material = Enum.Material.Neon
zone.Transparency = 0.7

task.spawn(function()
    while task.wait(0.3) do
        if enabled then
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp then
                local p = hrp.Position
                -- Check if player is inside the X, Y, and Z boundaries
                if (p.X >= minX and p.X <= maxX) and 
                   (p.Z >= minZ and p.Z <= maxZ) then

                    hrp.CFrame = CFrame.new(target1v1 + Vector3.new(0, 3, 0))
                    Library:Notify("Zone Triggered: Teleporting...")
                    task.wait(3) -- Cooldown
                end
            end
        end
    end
end)

Group:AddToggle('ZoneToggle', {
    Text = 'Zone TP Enabled',
    Default = true,
    Callback = function(Value) enabled = Value end
})

Group:AddButton({
    Text = 'Remove Visual Red',
    Func = function() zone.Transparency = 1 end
})
