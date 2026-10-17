-- ==========================================
-- SCRIPT MOD: VIỆT HÓA & ẨN DISCORD (REDZ HUB)
-- ==========================================

local Settings = {
    -- Thêm các thiết lập của bạn vào đây nếu cần (để trống nếu dùng mặc định)
}

-- 1. Tải và chạy script gốc
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))(Settings)
end)

if not success then
    warn("Không thể tải script gốc: " .. tostring(err))
    return
end

-- 2. Tự động xử lý UI sau khi script hiển thị giao diện
task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local function modifyUI(root)
        for _, obj in ipairs(root:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                local textLower = string.lower(obj.Text)
                
                -- Ẩn phần Discord hoặc nút Copy Link Discord
                if textLower:find("discord") or textLower:find("copy link") or textLower:find("invite") then
                    local parent = obj.Parent
                    if parent and parent:IsA("GuiObject") then
                        parent.Visible = false
                    end
                end

                -- Việt hóa các tính năng phổ biến trong Redz Hub
                local exactText = obj.Text
                if exactText == "Auto Farm" then
                    obj.Text = "Tự Động Cày"
                elseif exactText == "Combat" then
                    obj.Text = "Đánh Nhau / PVP"
                elseif exactText == "Stats" then
                    obj.Text = "Nâng Chỉ Số"
                elseif exactText == "Teleport" then
                    obj.Text = "Dịch Chuyển"
                elseif exactText == "Shop" then
                    obj.Text = "Cửa Hàng"
                elseif exactText == "Misc" then
                    obj.Text = "Tính Năng Khác"
                elseif exactText == "Settings" then
                    obj.Text = "Cài Đặt"
                elseif exactText == "Fruits" then
                    obj.Text = "Trái Ác Quỷ"
                end
            end
        end
    end

    -- Theo dõi CoreGui và PlayerGui khi UI xuất hiện
    task.wait(1) -- Đợi UI load xong lần đầu
    pcall(function()
        modifyUI(CoreGui)
        if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
            modifyUI(LocalPlayer.PlayerGui)
        end
    end)

    -- Lắng nghe các thành phần mới được thêm vào giao diện
    CoreGui.DescendantAdded:Connect(function()
        task.wait(0.1)
        pcall(function() modifyUI(CoreGui) end)
    end)
    
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        LocalPlayer.PlayerGui.DescendantAdded:Connect(function()
            task.wait(0.1)
            pcall(function() modifyUI(LocalPlayer.PlayerGui) end)
        end)
    end
end)
