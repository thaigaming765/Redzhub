local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local CG = game:GetService("CoreGui")

task.spawn(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then return nil end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)

task.spawn(function()
    LP.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

task.spawn(function()
    while task.wait(0.5) do
        for _, v in pairs(CG:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                if v.Text:find("Redz") or v.Text:find("Hub") or v.Text:find("discord") or v.Text:find(".gg") then
                    v.Text = v.Text:gsub("Redz Hub", "Wake Hub By Thai")
                    v.Text = v.Text:gsub("Redz", "Thai")
                    v.Text = v.Text:gsub("discord%.gg/%w+", "Protected")
                    v.Text = v.Text:gsub("https://%S+", "")
                end
            end
        end
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/huy384/redzHub/refs/heads/main/redzHub.lua"))()
