
-- wait until your character is loaded in cuz im bad at coding

local Event = game:GetService("ReplicatedStorage").NetworkRemoteEvent
local LP = game:GetService("Players").LocalPlayer
local Frame
local Potions
local UI
local g_
local p_Q = {}
local sum = 0

if not LP:FindFirstChild("leaderstats") then repeat wait(2) until LP:FindFirstChild("leaderstats") end
wait(4)

-- teleports the user to the lab and repeatedly teleports the user to the NPC until the frame is loaded
pcall(function()
    if (not LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")) then
        Event:FireServer("Teleport", "LabSpawn")
        repeat wait(0.5)
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1740.89038, 2705.99048, 11044.1572, -0.984202802, -4.41739587e-08, -0.177044764, -3.80400742e-08, 1, -3.80401666e-08, 0.177044764, -3.07044417e-08, -0.984202802)
        until LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")
    end
    
    Frame = LP.PlayerGui.ScreenGui:WaitForChild("BrewingFrame")
    if Frame.Brewing.Brew3.Gamepass.Visible then 
        g_ = 2
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DoComplement/BGS/main/UI/Two"))()
    else
        g_ = 3
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DoComplement/BGS/main/UI/Three"))()
    end 
end)


for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v:FindFirstChild("MainFrame") then UI = v; Potions = v.MainFrame.Body.Potions_N.P_List end
end

for i = 1, #Potions:GetChildren() do table.insert(p_Q, 0) end
if Frame:FindFirstChild("Close") then Frame.Close:Remove() end 
Frame.Visible = false

-- checks if either the skip frame is visible, given the visibile attribute value of the parent Brewing frame
local function checkSkip(i)
    return (Frame.Brewing:FindFirstChild("Brew"..i).Brewing.Visible and Frame.Brewing:FindFirstChild("Brew"..i).Brewing.Skip.Visible)
end
        
-- returns the index of a potion in the list based on the name of the potion in the parameter - str -
local function getPotion(str)
    for i = 1, #Potions:GetChildren() do
        if string.match(str, Potions:FindFirstChild("Recipe"..i).Text) then return i end
    end
end

Event:FireServer("Teleport", "LabLeaveSpawn")
wait(2)
-- sequence of forced steps to get the user to open their PetsFrame to initialize the amount of potions the user has
pcall(function()
    local m_B = LP.PlayerGui.ScreenGui.MainButtons
    local m_UIL = m_B.UIListLayout
    
    for i, v in pairs(m_B:GetChildren()) do 
        if v:IsA("ImageButton") and v.Name ~= "Pets" then v.Visible = false end
    end
    
    m_UIL.Parent = LP.PlayerGui
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Waiting for PetsFrame...",
        Text = "Please open your PetsFrame to initialize the potion quantities",
        Duration = 5
    })
    
    repeat wait(); m_B.Pets.Position = UDim2.new(0, LP:GetMouse().X - 1700, 0, LP:GetMouse().Y - 539) 
    until LP.PlayerGui.ScreenGui:FindFirstChild("PetsFrame")
    m_B.Pets.Visible = false
    
    local p_F = LP.PlayerGui.ScreenGui:FindFirstChild("PetsFrame")
    local p_UIL = p_F.Tabs.UIListLayout
    local t_D = p_F.Main.Pages.Potions.List.Grid
    t_D.UIGridLayout.CellSize = UDim2.new(0, 10, 0, 10)
    
    p_UIL.Parent = LP.PlayerGui
    p_F.Main.Visible = false
    p_F.Stats.Visible = false
    for i, v in pairs(p_F.Tabs:GetChildren()) do
        if v.Name ~= "Potions" then v.Visible = false end
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "PetsFrame found...",
        Text = "Please open your Potions tab to initialize the potion quantities",
        Duration = 5
    }) 
    
    repeat wait(); p_F.Tabs.Potions.Position = UDim2.new(0, LP:GetMouse().X - 1436, 0, LP:GetMouse().Y - 202)
    until #p_F.Main.Pages.Potions.List.Grid:GetChildren() > 1 
    p_F.Tabs.Potions.Visible = false
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Potions tab found...",
        Text = "Processing potion quantities...",
        Duration = 5
    }) 
    
    wait(3) -- data may take a few seconds to load
    for i,v in pairs(t_D:GetChildren()) do
        sum = sum + 1
        if v:FindFirstChild("Detail") then p_Q[getPotion(v.Detail.Inner.PotionName.Text)] = p_Q[getPotion(v.Detail.Inner.PotionName.Text)] + 1 end
    end
    
    t_D.UIGridLayout.CellSize = UDim2.new(0, 115, 0, 115)
    m_B.Pets.Position = UDim2.new(0, 0, 0, 0)
    p_F.Tabs.Potions.Position = UDim2.new(1, 5, 0, 0)
    p_F.Main.Visible = true
    p_F.Stats.Visible = true
    m_UIL.Parent = m_B
    p_UIL.Parent = p_F.Tabs
    for i, v in pairs(m_B:GetChildren()) do
        if v:IsA("ImageButton") then v.Visible = true end
    end
    for i, v in pairs(p_F.Tabs:GetChildren()) do
        if v:IsA("ImageButton") then v.Visible = true end
    end
    
    Event:FireServer("Teleport", "LabSpawn")
    repeat wait(0.5)
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1740.89038, 2705.99048, 11044.1572, -0.984202802, -4.41739587e-08, -0.177044764, -3.80400742e-08, 1, -3.80401666e-08, 0.177044764, -3.07044417e-08, -0.984202802)
    until LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")
    Event:FireServer("Teleport", "LabLeaveSpawn")
end)

for i = 1, #p_Q do print("Quantity of " .. Potions["Recipe"..i].Text .. " = " .. p_Q[i]) end

-- checks if the user is capable of brewing some potion
local function checkBrew(str)
    local index = getPotion(str)
    pcall(function()
        if index < 3 then if LP.PlayerGui.leaderstats.Gems.Value >= 10000000 then q_P[index] = q_P[index] - 1; sum = sum - 1; return true else return false end
        elseif index == 3 then if LP.PlayerGui.leaderstats.Gems.Value >= 15000000 then q_P[3] = q_P[3] - 1; sum = sum - 1; return true else return false end
        elseif index == 4 then if q_P[1] > 2 then q_P[1] = q_P[1] - 3; sum = sum - 3; return true end
        elseif index == 5 then if q_P[2] > 2 then q_P[2] = q_P[2] - 3; sum = sum - 3; return true end
        elseif index == 6 then if q_P[3] > 4 then q_P[3] = q_P[3] - 5; sum = sum - 5; return true end
        elseif index == 7 then if q_P[6] > 0 and q_P[4] > 4 then q_P[6] = q_P[6] - 1; q_P[4] = q_P[4] - 5; sum = sum - 6; return true else return false end
        elseif index == 8 then if q_P[6] > 0 and q_P[5] > 4 then q_P[6] = q_P[6] - 1; q_P[5] = q_P[5] - 5; sum = sum - 6; return true else return false end
        else if q_P[6] > 2 and LP.PlayerGui.leaderstats.Gems.Value >= 250000000 then q_P[6] = q_P[6] - 3; sum = sum - 3; return true else return false end end
    end)
end

-- main loop
spawn(function()
    while wait(1) do
        pcall(function()
            if (UI.MainFrame.Body.C_Indicator.ImageColor3 == Color3.fromRGB(0, 255, 0) and Frame) then
                for i = 1, g_ do
                    if (not checkSkip(i)) then
                        if Frame.Brewing["Brew"..i].Empty.Visible then
                            for x = 1, g_ do
                                if UI.MainFrame.Body.Potions_B["P_Label"..x].Text ~= "Empty Potion Slot" and UI.MainFrame.Body.Potions_B["P_Bool"..x].Value then -- checks for a ready potion
                                    if checkBrew(UI.MainFrame.Body.Potions_B["P_Label"..x].Text) then
                                        Event:FireServer("BrewPotion", getPotion(UI.MainFrame.Body.Potions_B["P_Label"..x].Text)) -- brews the potion
                                        UI.MainFrame.Body.Potions_B["P_Bool"..x].Value = false
                                        break
                                    else print("Not enough resources to brew " .. UI.MainFrame.Body.Potions_B["P_Label"..x].Text) end
                                end
                            end
                        else
                            for x = 1, g_ do 
                                if Frame.Brewing["Brew"..i].Brewing.ItemName.Text == UI.MainFrame.Body.Potions_B["P_Label"..x].Text and not UI.MainFrame.Body.Potions_B["P_Bool"..x].Value then -- checks collected potion is still being brewed
                                    UI.MainFrame.Body.Potions_B["P_Bool"..x].Value = true
                                    Event:FireServer("ClaimPotion", i)
                                    p_Q[getPotion(UI.MainFrame.Body.Potions_B["P_Label"..x].Text)] = q_P[getPotion(UI.MainFrame.Body.Potions_B["P_Label"..x].Text)] + 1; sum = sum + 1
                                    break
                                end
                            end
                        end
                        wait(0.5)
                    end
                end
            end
        end)
    end
end)

warn("Program fully loaded!\n\nIf you encounter any bugs/problems, ")
warn("PM me either by discord - dooop#0496 - or through V3rmillion.net - Activities12 -")
warn("detailing the problem. Thanks again for using the script!")

