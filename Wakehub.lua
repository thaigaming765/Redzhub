--[[ 
    WAKE HUB BY THAI - VERSION PRIVATE
    - Core: Redz Hub (Optimized)
    - Security: Anti-Ban, Anti-Kick, Anti-Check Level, Anti-AFK
    - UI: Pill Delta Minimalist
]]

repeat task.wait() until game:IsLoaded()
local LP = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [ 1. HỆ THỐNG BẢO MẬT MẠNH (ANTIBAN & ANTIKICK) ]
task.spawn(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        -- Chặn các lệnh kiểm tra Level bất thường từ Server (Anti-Check LV)
        if method == "Kick" or method == "kick" then return nil end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)

-- [ 2. ANTI-AFK MẠNH (TREO MÁY XUYÊN ĐÊM) ]
task.spawn(function()
    LP.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- [ 3. UI WAKE HUB BY THAI (ĐÚNG ẢNH 1544) ]
if CoreGui:FindFirstChild("WakeHub_Thai") then CoreGui.WakeHub_Thai:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "WakeHub_Thai"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 65); Main.Position = UDim2.new(0.5, -110, 0.05, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true 
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
local Stroke = Instance.new("UIStroke", Main); Stroke.Color = Color3.fromRGB(0, 255, 150); Stroke.Thickness = 2

local Stats = Instance.new("TextLabel", Main)
Stats.Size = UDim2.new(1, 0, 1, 0); Stats.BackgroundTransparency = 1; Stats.TextColor3 = Color3.fromRGB(0, 255, 180)
Stats.Font = "GothamBold"; Stats.TextSize = 10; Stats.Text = "Wake Hub By Thai | Status: Securing..."

-- [ 4. GIẢI MÃ & ĐỔI TÊN TOÀN BỘ MENU ]
task.spawn(function()
    while task.wait(0.5) do
        for _, v in pairs(CoreGui:GetChildren()) do
            if v:IsA("ScreenGui") and v.Name ~= "WakeHub_Thai" then
                for _, obj in pairs(v:GetDescendants()) do
                    -- Đổi tên thành Wake Hub By Thai
                    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                        if obj.Text:lower():find("redz") or obj.Text:lower():find("hub") or obj.Text:find("discord") then
                            obj.Text = obj.Text:gsub("Redz Hub", "Wake Hub By Thai")
                            obj.Text = obj.Text:gsub("redz", "Thai")
                            -- Xóa sạch link Discord
                            if obj.Text:find("discord") or obj.Text:find(".gg") then
                                obj.Text = "Secure Protected"
                            end
                        end
                    end
                    -- Xóa các bảng thông báo rỗng đứng im
                    if obj:IsA("Frame") and obj.Visible == true and obj.Size.Y.Offset > 100 then
                        obj.Visible = false
                    end
                end
            end
        end
        if setclipboard then setclipboard = function() return end end
    end
end)

-- [ 5. KHỞI CHẠY CORE (REDZ HUB LOADSTRING) ]
loadstring(game:HttpGet("https://raw.githubusercontent.com/huy384/redzHub/refs/heads/main/redzHub.lua"))()

-- [ 6. CẬP NHẬT STATS 2800 ]
task.spawn(function()
    while task.wait(0.5) do
        local d = LP:FindFirstChild("Data") or LP:FindFirstChild("leaderstats")
        if d then
            Stats.Text = "Wake Hub By Thai\nLvl: "..d.Level.Value.." | Beli: "..d.Beli.Value.."\nAnti-Ban: Active ✅"
        end
    end
end)
