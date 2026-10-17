-- ==========================================
-- THAIMOD48H - REDZ HUB VIỆT HÓA & NÂNG CẤP
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- 1. TẠO BẢNG LOADING (Bo góc + thaimod48h + Ống tải)
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

-- Thanh ống tải (Khung nền)
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 260, 0, 10)
BarBg.Position = UDim2.new(0.5, -130, 0, 95)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
BarBg.BorderSizePixel = 0
BarBg.Parent = Frame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(1, 0)
BarBgCorner.Parent = BarBg

-- Thanh ống tải (Ruột thanh)
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

-- 2. TIẾN TRÌNH KHỞI CHẠY
task.spawn(function()
    updateProgress(0.3, "Đang khởi tạo cấu hình...", 0.4)
    task.wait(0.4)

    updateProgress(0.6, "Đang kích hoạt Anti-AFK...", 0.4)
    task.wait(0.4)

    -- Anti-AFK (Chống văng 20 phút)
    pcall(function()
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)

    updateProgress(0.8, "Đang dọn dẹp hiệu ứng rác...", 0.4)
    
    -- TỰ ĐỘNG XÓA HIỆU ỨNG RÁC GIÚP GIẢM LAG MEMU
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") then
                v.Enabled = false
            end
        end
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
    end)
    task.wait(0.4)

    updateProgress(1.0, "Đang mở Redz Hub...", 0.3)
    task.wait(0.3)

    -- Tắt bảng loading
    TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    ScreenGui:Destroy()

    -- 3. CHẠY SCRIPT REDZ HUB GỐC
    local Settings = {
        JoinServer = false,
        AutoJoinServer = false
    }

    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))(Settings)
        end)
    end)

    -- 4. HIỆN THÔNG BÁO MÀU CẦU VỒNG TRONG 10 GiÂY
    task.spawn(function()
        local NoticeGui = Instance.new("ScreenGui")
        NoticeGui.Name = "RainbowNotice"
        NoticeGui.IgnoreGuiInset = true
        pcall(function() NoticeGui.Parent = CoreGui end)
        if not NoticeGui.Parent and LocalPlayer:FindFirstChild("PlayerGui") then
            NoticeGui.Parent = LocalPlayer.PlayerGui
        end

        local NoticeText = Instance.new("TextLabel")
        NoticeText.Size = UDim2.new(1, 0, 0, 50)
        NoticeText.Position = UDim2.new(0, 0, 0, 20)
        NoticeText.BackgroundTransparency = 1
        NoticeText.Text = "Script mod này đang trong giai đoạn beta do tác giả xài Gemini free:()"
        NoticeText.TextSize = 18
        NoticeText.Font = Enum.Font.GothamBold
        NoticeText.TextStrokeTransparency = 0.2
        NoticeText.Parent = NoticeGui

        -- Hiệu ứng cầu vồng
        local running = true
        task.spawn(function()
            local hue = 0
            while running do
                hue = (hue + 0.01) % 1
                NoticeText.TextColor3 = Color3.fromHSV(hue, 1, 1)
                task.wait(0.03)
            end
        end)

        -- Biến mất sau 10 giây
        task.wait(10)
        running = false
        TweenService:Create(NoticeText, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
        task.wait(0.5)
        NoticeGui:Destroy()
    end)

    -- 5. BỘ VIỆT HÓA MỞ RỘNG (MỚI: DỊCH SÂU TẤT CẢ TÍNH NĂNG)
    task.spawn(function()
        local translations = {
            -- Các tab chính
            ["auto farm"] = "Tự Động Cày",
            ["farm level"] = "Cày Level",
            ["stats"] = "Nâng Chỉ Số",
            ["teleport"] = "Dịch Chuyển",
            ["shop"] = "Cửa Hàng",
            ["fruit"] = "Trái Ác Quỷ",
            ["fruits"] = "Trái Ác Quỷ",
            ["misc"] = "Tính Năng Khác",
            ["settings"] = "Cài Đặt",
            ["combat"] = "PVP / Chiến Đấu",
            ["player"] = "Người Chơi",
            ["quest"] = "Nhiệm Vụ",
            ["mastery"] = "Cày Thông Thạo",
            ["raid"] = "Đi Phụ Bản",
            ["dungeon"] = "Phụ Bản",
            ["weapon"] = "Vũ Khí",
            
            -- Lựa chọn & Thao tác
            ["select weapon"] = "Chọn Vũ Khí",
            ["select quest"] = "Chọn Nhiệm Vụ",
            ["select mode"] = "Chọn Chế Độ",
            ["select player"] = "Chọn Người Chơi",
            ["select fruit"] = "Chọn Trái Ác Quỷ",
            ["select island"] = "Chọn Đảo",
            ["buy"] = "Mua",
            ["random"] = "Săn Ngẫu Nhiên",
            ["store"] = "Cất Trái Ác Quỷ",
            ["store all fruits"] = "Cất Tất Cả Trái",
            ["bring mob"] = "Gom Quái",
            ["fast attack"] = "Đánh Nhanh",
            ["auto click"] = "Tự Nhấp Chuột",
            ["enable"] = "Bật",
            ["disable"] = "Tắt",
            ["auto quest"] = "Tự Nhận Nhiệm Vụ",

            -- Tùy chỉnh nhân vật / Chỉ số
            ["melee"] = "Cận Chiến",
            ["defense"] = "Phòng Thủ",
            ["sword"] = "Kiếm",
            ["gun"] = "Súng",
            ["bloxfruit"] = "Trái Ác Quỷ",
            ["demon fruit"] = "Trái Ác Quỷ"
        }

        local function translateElement(obj)
            if not obj then return end
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                local txt = obj.Text
                if txt and txt ~= "" then
                    local lowerTxt = string.lower(txt)
                    
                    -- Tìm và dịch chính xác
                    for key, val in pairs(translations) do
                        if lowerTxt == key or lowerTxt:find(key) then
                            obj.Text = val
                            break
                        end
                    end
                end
            end
        end

        task.wait(2)

        -- Quét liên tục để cập nhật từ tiếng Việt ngay khi bạn mở các tab
        while true do
            pcall(function()
                for _, obj in ipairs(CoreGui:GetDescendants()) do
                    translateElement(obj)
                end
                if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
                    for _, obj in ipairs(LocalPlayer.PlayerGui:GetDescendants()) do
                        translateElement(obj)
                    end
                end
            end)
            task.wait(1.5) -- Quét nhanh mỗi 1.5s để dịch kịp lúc bấm tab
        end
    end)
end)
