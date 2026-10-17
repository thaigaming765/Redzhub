-- ==========================================
-- THAIMOD48H - MEME SEA LOADER & MOD (FIXED)
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- 1. TẠO GIAO DIỆN LOADING (Bo góc + thaimod48h + Ống tải)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThaimodLoading"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent and LocalPlayer:FindFirstChild("PlayerGui") then
    ScreenGui.Parent = LocalPlayer.PlayerGui
end

-- Khung chữ nhật bo góc
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 140)
Frame.Position = UDim2.new(0.5, -160, 0.5, -70)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Frame

-- Chữ thaimod48h
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "thaimod48h"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Trạng thái tải
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 55)
Status.BackgroundTransparency = 1
Status.Text = "Đang khởi tạo..."
Status.TextColor3 = Color3.fromRGB(170, 170, 180)
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.Parent = Frame

-- Ống tải script (Nền thanh ngang)
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 260, 0, 10)
BarBg.Position = UDim2.new(0.5, -130, 0, 95)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
BarBg.BorderSizePixel = 0
BarBg.Parent = Frame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(1, 0)
BarBgCorner.Parent = BarBg

-- Ống tải script (Phần chạy thanh ngang)
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(1, 0)
BarFillCorner.Parent = BarFill

local function updateProgress(targetSize, text, duration)
    Status.Text = text
    TweenService:Create(BarFill, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(targetSize, 0, 1, 0)
    }):Play()
end

-- 2. TIẾN TRÌNH CHẠY SCRIPT
task.spawn(function()
    updateProgress(0.4, "Đang kết nối tài nguyên...", 0.4)
    task.wait(0.5)

    updateProgress(0.8, "Đang tải script Meme Sea...", 0.5)
    task.wait(0.5)

    updateProgress(1.0, "Tải hoàn tất! Đang bật...", 0.3)
    task.wait(0.4)

    -- Đóng giao diện Loading
    TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    ScreenGui:Destroy()

    -- BẬT SCRIPT GỐC (Gọi URL trực tiếp để không bị lặp vô tận)
    task.spawn(function()
        local scriptUrl = "https://raw.githubusercontent.com/thaigaming765/Redzhub/refs/heads/main/Rdmemesea.lua"
        loadstring(game:HttpGet(scriptUrl))()
    end)

    -- 3. BẬT ANTI-AFK (Chống văng 20 phút do đứng im)
    task.spawn(function()
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)

    -- 4. BỘ VIỆT HÓA VÀ ẨN DISCORD (Mượt nhẹ trên giả lập Memu)
    task.spawn(function()
        local translations = {
            ["auto farm"] = "Tự Động Cày",
            ["farm"] = "Cày Bắp",
            ["quest"] = "Nhiệm Vụ",
            ["stats"] = "Nâng Chỉ Số",
            ["teleport"] = "Dịch Chuyển",
            ["shop"] = "Cửa Hàng",
            ["fruits"] = "Trái Ác Quỷ",
            ["fruit"] = "Trái Ác Quỷ",
            ["misc"] = "Tính Năng Khác",
            ["settings"] = "Cài Đặt",
            ["combat"] = "PVP / Đánh Nhau",
            ["player"] = "Người Chơi",
            ["weapon"] = "Vũ Khí",
            ["select"] = "Chọn"
        }

        local function processObject(obj)
            if not obj then return end
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                local txt = obj.Text
                if txt and txt ~= "" then
                    local lowerTxt = string.lower(txt)

                    -- Ẩn Discord
                    if lowerTxt:find("discord") or lowerTxt:find("copy link") or lowerTxt:find("invite") then
                        if obj.Parent and obj.Parent:IsA("GuiObject") then
                            obj.Parent.Visible = false
                        end
                        obj.Visible = false
                        return
                    end

                    -- Việt hóa
                    for key, val in pairs(translations) do
                        if lowerTxt == key or lowerTxt:find(key) then
                            obj.Text = val
                            break
                        end
                    end
                end
            end
        end

        -- Đợi menu RedzHub xuất hiện rồi mới quét
        task.wait(3)

        while true do
            pcall(function()
                for _, obj in ipairs(CoreGui:GetDescendants()) do
                    processObject(obj)
                end
                if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
                    for _, obj in ipairs(LocalPlayer.PlayerGui:GetDescendants()) do
                        processObject(obj)
                    end
                end
            end)
            task.wait(3) -- Quét mỗi 3 giây để không tốn RAM Memu
        end
    end)
end)
