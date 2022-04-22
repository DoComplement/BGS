
-- wait until your character is loaded in cuz im bad at coding

local Event = game:GetService("ReplicatedStorage").NetworkRemoteEvent
local LP = game:GetService("Players").LocalPlayer
local p_L, p_B, p_F, b_F, UI, g_
local p_Q = {}
local sum = 0, p_Max

local function closeFrames(b)
    local s = {"Codes", "Index", "Boosts", "Prizes"};
    for i = 1, #s do LP.PlayerGui.ScreenGui.StatsFrame[s[i]].Visible = b end
    LP.PlayerGui.ScreenGui.StatsFrame.Coins.More.Visible = b
    LP.PlayerGui.ScreenGui.StatsFrame.Gems.More.Visible = b
    LP.PlayerGui.ScreenGui.MainButtons.Visible = b
    LP.PlayerGui.ScreenGui.Settings.Visible = b
end

if not LP:FindFirstChild("leaderstats") then repeat wait(1) until LP:FindFirstChild("leaderstats") end
closeFrames(false); wait(3)
LP.Character:FindFirstChild("HumanoidRootPart").Anchored = true

-- teleports the user to the lab and repeatedly teleports the user to the NPC until the b_F is loaded
if (not LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")) then
    Event:FireServer("Teleport", "LabSpawn"); closeFrames(false); wait(0.5)
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1740.89038, 2705.99048, 11044.1572, -0.984202802, -4.41739587e-08, -0.177044764, -3.80400742e-08, 1, -3.80401666e-08, 0.177044764, -3.07044417e-08, -0.984202802)
    wait(1)
end

-- assigns BrewingFrame variable and calling respective ui repository
b_F = LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame"); wait(0.5)
if b_F.Brewing.Brew3.Gamepass.Visible then 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DoComplement/BGS/main/UI/Two"))(); g_ = 2
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DoComplement/BGS/main/UI/Three"))(); g_ = 3
end 

-- assigns UI and Potions directory variables
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v:FindFirstChild("MainFrame") then 
        UI = v; p_L = v.MainFrame.Body.Potions_N.P_List; p_B = v.MainFrame.Body.Potions_B
    end
end

-- fills p_Q with blank data then removes the close button on the BrewingFrame
for i = 1, #p_L:GetChildren()/2 do table.insert(p_Q, 0) end
if b_F:FindFirstChild("Close") then b_F.Close.Parent = nil end; b_F.Visible = false

-- checks if either the skip b_F is visible, given the visibile attribute value of the parent Brewing b_F
local function checkSkip(i)
    return (b_F.Brewing["Brew"..i].Brewing.Visible and b_F.Brewing["Brew"..i].Brewing.Skip.Visible)
end
        
-- returns the index of a potion in the list based on the name of the potion in the parameter - str -
local function getPotion(str)
    for i = 1, #p_L:GetChildren() do
        if string.match(str, p_L:FindFirstChild("Recipe"..i).Text) then return i end
    end
end

-- function to get the main button to the screen
local function getp1_F()
    if LP.PlayerGui.ScreenGui:FindFirstChild("PetsFrame") then LP.PlayerGui.ScreenGui:FindFirstChild("PetsFrame").Parent = nil end
    local m_B = LP.PlayerGui.ScreenGui.MainButtons
    local m_UIL = m_B.UIListLayout
            
    m_UIL.Parent = LP.PlayerGui; if not m_B.Visible then m_B.Visible = true end
    for i,v in pairs(m_B:GetChildren()) do if v:IsA("ImageButton") and v.Name ~= "Pets" then v.Visible = false end end
            
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Waiting for PetsFrame...",
        Text = "Please open your PetsFrame to initialize the potion quantities",
        Duration = 5
    })
            
    repeat wait(); m_B.Pets.Position = UDim2.new(0, LP:GetMouse().X - 1700, 0, LP:GetMouse().Y - 539) 
    until LP.PlayerGui.ScreenGui:FindFirstChild("PetsFrame")
        
    m_B.Visible = false
    m_UIL.Parent = m_B
end

-- function to count the total number of cumulative and unique potions the user contains
local function getp2_F(vis)
    local p_UIL = p_F.Tabs.UIListLayout
        
    for i, v in pairs(p_F.Tabs:GetChildren()) do if v:IsA("ImageButton") then v.Visible = false end end
    p_F.Main.Visible = false; p_F.Stats.Visible = false; p_UIL.Parent = LP.PlayerGui
    p_F.Main.Pages.Potions.List.Grid.UIGridLayout.CellSize = UDim2.new(0, 10, 0, 10)
        
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "PetsFrame found...",
        Text = "Please open your Potions tab to initialize the potion quantities",
        Duration = 5
    }) 
        
    wait(1)
    p_F.Tabs.Potions.Visible = true
    repeat wait(); p_F.Tabs.Potions.Position = UDim2.new(0, LP:GetMouse().X - 1436, 0, LP:GetMouse().Y - 202)
    until p_F.Main.Title.Text == "My Potions"
    p_F.Tabs.Potions.Visible = false
    p_UIL.Parent = p_F.Tabs
    
    p_Max = tonumber(string.sub(p_F.Main.Counters.Stored.Amount.Text, string.find(p_F.Main.Counters.Stored.Amount.Text, "/") + 1, string.len(p_F.Main.Counters.Stored.Amount.Text))) 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Potions tab found...",
        Text = "Processing potion quantities...",
        Duration = 5
    }) 
        
    wait(3) -- data may take a few seconds to load
    for i,v in pairs(p_F.Main.Pages.Potions.List.Grid:GetChildren()) do
        if v:FindFirstChild("Detail") then p_Q[getPotion(v.Detail.Inner.PotionName.Text)] = p_Q[getPotion(v.Detail.Inner.PotionName.Text)] + 1; sum = sum + 1 end
    end
    
    p_F.Main.Pages.Potions.List.Grid.UIGridLayout.CellSize = UDim2.new(0, 115, 0, 115)
    LP.PlayerGui.ScreenGui.MainButtons.Pets.Position = UDim2.new(0, 0, 0, 0)
    p_F.Tabs.Potions.Position = UDim2.new(1, 5, 0, 0)
    p_F.Main.Visible = true; p_F.Stats.Visible = true
    closeFrames(vis)
    for i, v in pairs(p_F.Tabs:GetChildren()) do if v:IsA("ImageButton") then v.Visible = true end end
    for i, v in pairs(LP.PlayerGui.ScreenGui.MainButtons:GetChildren()) do if v:IsA("ImageButton") then v.Visible = true end end
end

Event:FireServer("Teleport", "LabLeaveSpawn"); wait(0.5)
LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1697.16882, 1855.47021, 11037.1455, 1, 0, -1.93564623e-10, 0, 1, 0, 1.93564623e-10, 0, 1)
wait(2)

getp1_F(); p_F = LP.PlayerGui.ScreenGui:FindFirstChild("PetsFrame"); getp2_F(true) 
Event:FireServer("Teleport", "LabSpawn"); wait(0.5)
LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1740.89038, 2705.99048, 11044.1572, -0.984202802, -4.41739587e-08, -0.177044764, -3.80400742e-08, 1, -3.80401666e-08, 0.177044764, -3.07044417e-08, -0.984202802)
LP.PlayerGui.ScreenGui:WaitForChild("BrewingFrame")
Event:FireServer("Teleport", "LabLeaveSpawn")
LP.Character["HumanoidRootPart"].Anchored = false

-- checks if the user is capable of brewing some potion
local function checkBrew(str)
    local s_F = LP.PlayerGui.ScreenGui.StatsFrame
    local stats = {s_F["Stars"].Amount.Text, s_F["Crystals"].Amount.Text, s_F["Magma"].Amount.Text}
    local index = getPotion(str)
    local b
    pcall(function()
        if index < 3 then b = LP.leaderstats.Gems.Value >= 10000000 
        elseif index == 3 then b = LP.leaderstats.Gems.Value >= 15000000
        elseif index == 4 then b = p_Q[1] > 2 and tonumber(stats[1]) >= 20000000; if b then p_Q[1] = p_Q[1] - 3; sum = sum - 3 end
        elseif index == 5 then b = p_Q[2] > 2 and tonumber(stats[2]) >= 20000000; if b then p_Q[2] = p_Q[2] - 3; sum = sum - 3 end
        elseif index == 6 then b = p_Q[3] > 4 and tonumber(stats[3]) >= 100000000; if b then p_Q[3] = p_Q[3] - 5; sum = sum - 5 end
        elseif index == 7 then b = (p_Q[6] > 0 and p_Q[4] > 4); if b then p_Q[6] = p_Q[6] - 1; p_Q[4] = p_Q[4] - 5; sum = sum - 6 end
        elseif index == 8 then b = (p_Q[6] > 0 and p_Q[5] > 4); if b then p_Q[6] = p_Q[6] - 1; p_Q[5] = p_Q[5] - 5; sum = sum - 6 end
        else b = (p_Q[6] > 2 and LP.leaderstats.Gems.Value >= 250000000); if b then p_Q[6] = p_Q[6] - 3; sum = sum - 3 end end
    end)
    return b
end

spawn(function()
    while wait(1) do 
         pcall(function() for i = 1, #p_Q do if p_L["qRecipe"..i].Text ~= (":  " .. tostring(p_Q[i])) then p_L["qRecipe"..i].Text = (":  " .. tostring(p_Q[i])) end end end)
    end
end)

UI.MainFrame.Body.Buttons.Pot_Upd.MouseButton1Down:Connect(function()
    local t_bool = LP.PlayerGui.ScreenGui.StatsFrame.Coins.More.Visible ; sum = 0
    for i = 1, #p_Q do p_Q[i] = 0 end
    getp1_F(); getp2_F(t_bool);
    LP.PlayerGui.ScreenGui.PetsFrame.Parent = nil;
end)

-- main loop
spawn(function()
    while wait(1) do
        pcall(function()
            if (UI.MainFrame.Body.C_Indicator.C_Color.BackgroundColor3 == Color3.fromRGB(0, 214, 0) and b_F) then
                for i = g_, 1, -1 do
                    if (not checkSkip(i)) then
                        if b_F.Brewing["Brew"..i].Empty.Visible then
                            for x = 1, g_ do
                                if p_B["P_Label"..x].Text ~= "Empty Potion Slot" and p_B["P_Bool"..x].Value then -- checks for a ready potion
                                    if checkBrew(p_B["P_Label"..x].Text) and sum < p_Max then
                                        Event:FireServer("BrewPotion", getPotion(p_B["P_Label"..x].Text)) -- brews the potion
                                        p_B["P_Bool"..x].Value = false
                                    else print("Either you\'ve maxed your potion storage, or you don\'t have enough resources to brew: " .. p_B["P_Label"..x].Text) end break
                                end
                            end
                        else
                            for x = 1, g_ do 
                                if b_F.Brewing["Brew"..i].Brewing.ItemName.Text == p_B["P_Label"..x].Text and not p_B["P_Bool"..x].Value then -- checks collected potion is still being brewed
                                    p_B["P_Bool"..x].Value = true
                                    break
                                end
                            end
                            p_Q[getPotion(b_F.Brewing["Brew"..i].Brewing.ItemName.Text)] = p_Q[getPotion(b_F.Brewing["Brew"..i].Brewing.ItemName.Text)] + 1;  sum = sum + 1
                            Event:FireServer("ClaimPotion", i)
                        end
                        wait(0.5)
                    end
                end
            end
       end) 
    end
end)

warn("Program fully loaded! If you encounter any bugs/problems, or, if you have any questions/suggestions, ")
warn("please PM me either by discord - dooop#0496 - or through V3rmillion.net - Activities12 -")
