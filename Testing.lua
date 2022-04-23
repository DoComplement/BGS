

local HEADER = true
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do if v:FindFirstChild("MainFrame") then HEADER = false end end

if HEADER then
    local chars = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
    	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}
    
    local name = ""
    local fN = ""
    for i = 1, math.random(5, 16) do name = name .. chars[math.random(1, #chars)]; fN = fN .. chars[math.random(1, #chars)] end
    
    -- Instances:
    
    local MainUi_3 = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local UICorner = Instance.new("UICorner")
    local Body = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local UIGradient_2 = Instance.new("UIGradient")
    local Potions_B = Instance.new("Frame")
    local P_Image1 = Instance.new("ImageLabel")
    local UICorner_3 = Instance.new("UICorner")
    local P_Label1 = Instance.new("TextLabel")
    local UICorner_4 = Instance.new("UICorner")
    local P_Reset1 = Instance.new("ImageButton")
    local P_Reset2 = Instance.new("ImageButton")
    local P_Image2 = Instance.new("ImageLabel")
    local P_Label2 = Instance.new("TextLabel")
    local UICorner_5 = Instance.new("UICorner")
    local P_Label3 = Instance.new("TextLabel")
    local UICorner_6 = Instance.new("UICorner")
    local P_Image3 = Instance.new("ImageLabel")
    local P_Reset3 = Instance.new("ImageButton")
    local Event_TP = Instance.new("TextButton")
    local UICorner_7 = Instance.new("UICorner")
    local Inv_GameUi = Instance.new("TextButton")
    local UICorner_8 = Instance.new("UICorner")
    local Lab_TP = Instance.new("TextButton")
    local UICorner_9 = Instance.new("UICorner")
    local Inv_Ui = Instance.new("TextButton")
    local UICorner_10 = Instance.new("UICorner")
    local C_Label = Instance.new("TextLabel")
    local Potions_N = Instance.new("Frame")
    local UICorner_11 = Instance.new("UICorner")
    local Potions_C = Instance.new("ImageButton")
    local P_List = Instance.new("Frame")
    local UIGradient_3 = Instance.new("UIGradient")
    local P_Label = Instance.new("TextLabel")
    local C_Indicator = Instance.new("ImageButton")
    local C_Color = Instance.new("TextLabel")
    local UICorner_13 = Instance.new("UICorner")
    local B_Indicator = Instance.new("ImageButton")
    local B_Color = Instance.new("TextLabel")
    local f1 = Instance.new("Folder")
    local UICorner_14 = Instance.new("UICorner")
    local Main_C = Instance.new("ImageButton")
    local Warning_Icon = Instance.new("ImageButton")
    local Warning_Label = Instance.new("TextLabel")
    local Title = Instance.new("TextLabel")
    local Buttons = Instance.new("Frame")
    local Pot_Upd = Instance.new("TextButton")
    local UICorner_12 = Instance.new("UICorner")
    local UIListLayout = Instance.new("UIListLayout")
    local P_Bool1 = Instance.new("BoolValue")
    local P_Bool2 = Instance.new("BoolValue")
    local P_Bool3 = Instance.new("BoolValue")
    
    local p_F, b_F, p_Max
    local Event = game:GetService("ReplicatedStorage").NetworkRemoteEvent
    local LP = game:GetService("Players").LocalPlayer
    local g_Constraint = false
    local g_UIVis = true
    local b_Constraint = false
    local Main_Moving = false
    local C_Moving = false
    local images = {}
    local P_list = {"Empty Potion Slot", "Empty Potion Slot", "Empty Potion Slot"}
    local g_P = {}
    local n_T = {}
    local i_T = {}
    local p_T = {}
    local f_S = {}
    local p_Q = {}
    local sum = 0
    --Properties:
    
    local function closeFrames(b)
    	local s = {"Codes", "Index", "Boosts", "Prizes"};
    	for i = 1, #s do LP.PlayerGui.ScreenGui.StatsFrame[s[i]].Visible = b end
    	LP.PlayerGui.ScreenGui.StatsFrame.Coins.More.Visible = b
    	LP.PlayerGui.ScreenGui.StatsFrame.Gems.More.Visible = b
    	LP.PlayerGui.ScreenGui.MainButtons.Visible = b
    	LP.PlayerGui.ScreenGui.Settings.Visible = b
    end
    
    -- checks if either the skip b_F is visible, given the visibile attribute value of the parent Brewing b_F
    local function checkSkip(i)
    	return (b_F.Brewing["Brew"..i].Brewing.Visible and b_F.Brewing["Brew"..i].Brewing.Skip.Visible)
    end
    
    -- returns the index of a potion in the list based on the name of the potion in the parameter - str -
    local function getPotion(str)
    	for i = 1, #i_T[48]:GetChildren() do
    		if string.match(str, i_T[48]:FindFirstChild("Recipe"..i).Text) then return i end
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
    
    if not LP:FindFirstChild("leaderstats") then repeat wait(1) until LP:FindFirstChild("leaderstats") end
    closeFrames(false); wait(3)
    LP.Character:FindFirstChild("HumanoidRootPart").Anchored = true
    
    -- teleports the user to the lab and repeatedly teleports the user to the NPC until the b_F is loaded
    if (not LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")) then
    	Event:FireServer("Teleport", "LabSpawn"); closeFrames(false); wait(0.5)
    	LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1740.89038, 2705.99048, 11044.1572, -0.984202802, -4.41739587e-08, -0.177044764, -3.80400742e-08, 1, -3.80401666e-08, 0.177044764, -3.07044417e-08, -0.984202802)
    	wait(1)
    end
    
    b_F = LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")
    
    -- fix this by replacing all the instance references to the t_I[...] calls
    local function cfun(index, obj)
        --pcall(function()
        	if index == 1 then
        		obj.MouseButton1Down:Connect(function()
        			if i_T[17].ImageTransparency ~= 0.5 then
        				for i = 1, 2 do
        					i_T[9]["P_Label"..i].Text = i_T[9]["P_Label"..(i + 1)].Text
        					i_T[9]["P_Reset"..i].ImageTransparency = i_T[9]["P_Reset"..(i + 1)].ImageTransparency
        					i_T[9]["P_Image"..i].Image = i_T[9]["P_Image"..(i + 1)].Image
        					i_T[9]["P_Image"..i].ImageTransparency = i_T[9]["P_Image"..(i + 1)].ImageTransparency
        					i_T[9]["P_Bool"..i].Value = i_T[9]["P_Bool"..(i + 1)].Value
        					P_list[i] = i_T[9]["P_Label"..i].Text
        				end
        				if i_T[22].Text ~= "Empty Potion Slot" then
        					i_T[22].Text = "Empty Potion Slot"
        					i_T[25].ImageTransparency = 0.5
        					i_T[24].ImageTransparency = 1
        					i_T[16].Value = false
        					P_list[3] = i_T[22].Text
        				end
        				if g_Constraint and i_T[12].Text == "Empty Potion Slot" then
        					g_Constraint = false
        					i_T[39].BackgroundColor3 = Color3.fromRGB(214, 0, 0)
        					i_T[44].Text = "Currently:  Idle"
        				end
        			end
        		end)
        	elseif index == 2 then
        		obj.MouseButton1Down:Connect(function()
        			if i_T[18].ImageTransparency ~= 0.5 then
        				i_T[20].Text = i_T[22].Text
        				i_T[19].Image = i_T[24].Image
        				i_T[19].ImageTransparency = i_T[24].ImageTransparency
        				i_T[18].ImageTransparency = i_T[25].ImageTransparency
        				i_T[15].Value = i_T[16].Value
        				P_list[2] = i_T[20].Text
        				if i_T[22].Text ~= "Empty Potion Slot" then
        					i_T[22].Text = "Empty Potion Slot"
        					i_T[24].ImageTransparency = 1
        					i_T[25].ImageTransparency = 0.5
        					i_T[16].Value = false
        					P_list[3] = i_T[22].Text
        				end
        			end
        		end)
        	elseif index == 3 then
        		obj.MouseButton1Down:Connect(function()
        			if i_T[25].ImageTransparency ~= 0.5 then
        				i_T[22].Text = "Empty Potion Slot"
        				i_T[25].ImageTransparency = 0.5
        				i_T[24].ImageTransparency = 1
        				i_T[16].Value = false
        				P_list[3] = i_T[22].Text
        			end
        		end)
        	elseif index == 4 then
        		obj.MouseButton1Down:Connect(function()
        			-- write condition to check if user is already at event aready, (then don't teleport)
        			game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer("Teleport", "EventSpawn")
        		end)
        	elseif index == 5 then
        		obj.MouseButton1Down:Connect(function() g_UIVis = not g_UIVis; closeFrames(g_UIVis) end)
        	elseif index == 6 then
        		obj.MouseButton1Down:Connect(function()
        			-- check if the user is already there
        			game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer("Teleport", "LabSpawn")
        		end)
        	elseif index == 7 then
        		obj.MouseButton1Down:Connect(function()
        			if b_F then b_F.Visible = not b_F.Visible end
        		end) 
        	elseif index == 8 then
        		obj.MouseButton1Down:Connect(function()
        			local t_bool = LP.PlayerGui.ScreenGui.StatsFrame.Coins.More.Visible ; sum = 0
        			for i = 1, #p_Q do p_Q[i] = 0 end
        			getp1_F(); getp2_F(t_bool);
        			LP.PlayerGui.ScreenGui.PetsFrame.Parent = nil;
        		end)
        	elseif index == 9 then
        		obj.MouseButton1Down:Connect(function()
        			if i_T[12].Text == "Empty Potion Slot" then
        				i_T[44].Text = "No potions to brew!"
        				wait(4)
        				if not g_Constraint then i_T[44].Text = "Currently:  Idle" end
        			else
        				if g_Constraint then i_T[39].BackgroundColor3 = Color3.fromRGB(214, 0, 0); i_T[44].Text = "Currently:  Idle"
        				else i_T[39].BackgroundColor3 = Color3.fromRGB(0, 214, 0); i_T[44].Text = "Currently:  Brewing" end
        				g_Constraint = not g_Constraint
        			end
        		end)
        	elseif index == 10 then
        		obj.MouseButton1Down:Connect(function()
        			if b_Constraint then i_T[42].BackgroundColor3 = Color3.fromRGB(214, 0, 0)
        			else i_T[42].BackgroundColor3 = Color3.fromRGB(0, 214, 0) end
        			b_Constraint = not b_Constraint
        		end)
        	elseif index == 11 then
        		obj.MouseButton1Down:Connect(function()
        			if i_T[47].Rotation == 0 and not C_Moving then
        				C_Moving = true
        				i_T[48]:TweenSize(UDim2.new(0, 188, 0, 0), "Out", "Sine", 0.5, true)
        				repeat i_T[47].Rotation = i_T[47].Rotation + 10 wait(0.01) until i_T[47].Rotation == 90 
        				C_Moving = false
        			elseif not C_Moving then
        				C_Moving = true
        				i_T[48]:TweenSize(UDim2.new(0, 188, 0, 23 + 19*#b_F.Recipes:GetChildren()), "Out", "Sine", 0.5, true)
        				repeat i_T[47].Rotation = i_T[47].Rotation - 10 wait(0.01) until i_T[47].Rotation == 0 
        				C_Moving = false
        			end 
        		end)
        	elseif index == 12 then
        		obj.MouseButton1Down:Connect(function()
        			if i_T[78].Rotation == 0 and not Main_Moving then
        				Main_Moving = true
        				if i_T[47].Rotation == 0 then 
        					i_T[48]:TweenSize(UDim2.new(0, 188, 0, 0), "Out", "Sine", 0.5, true) 
        					repeat i_T[47].Rotation = i_T[47].Rotation + 10 wait(0.01) until i_T[47].Rotation == 90 
        				end
        				i_T[47].Visible = false
        				i_T[6]:TweenSize(UDim2.new(0, 255, 0, 0), "Out", "Sine", 0.5, true)
        				i_T[6].ClipsDescendants = true
        				repeat i_T[78].Rotation = i_T[78].Rotation + 10 wait(0.01) until i_T[78].Rotation == 90 
        				Main_Moving = false
        			elseif not Main_Moving then
        				Main_Moving = true
        				i_T[6]:TweenSize(UDim2.new(0, 255, 0, 189), "Out", "Sine", 0.5, true)
        				repeat i_T[78].Rotation = i_T[78].Rotation - 10 wait(0.01) until i_T[78].Rotation == 0 
        				i_T[6].ClipsDescendants = false
        				i_T[47].Visible = true
        				Main_Moving = false
        			end 
        		end)
        	else
                obj.MouseButton1Down:Connect(function()
                    local i = tonumber(string.sub(obj.Name, 7))
                    for x = 1, 3 do
        				if i_T[9]["P_Label"..x].Text == "Empty Potion Slot" then
        					i_T[9]["P_Label"..x].Text = obj.Text
        					i_T[9]["P_Reset"..x].ImageTransparency = 0
        					i_T[9]["P_Image"..x].Image = images[i]
        					i_T[9]["P_Image"..x].ImageTransparency = 0
        					i_T[9]["P_Bool"..x].Value = true
        					P_list[x] = obj.Text
        					break
        				end 
        			end
                end)
            end
        --end)
    end
    
    MainUi_3.Name = name
    MainUi_3.Parent = game:GetService("CoreGui")
    MainUi_3.ZIndexBehavior = Enum.ZIndexBehavior.Global
    n_T[1] = name; i_T[1] = MainUi_3; p_T[1] = game:GetService("CoreGui")
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = MainUi_3
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 0, 0, 0)
    MainFrame.Selectable = true
    MainFrame.Size = UDim2.new(0, 255, 0, 24)
    MainFrame.Visible = false
    
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(172, 32, 182)), ColorSequenceKeypoint.new(0.42, Color3.fromRGB(211, 124, 127)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(211, 225, 7))}
    UIGradient.Parent = MainFrame
    
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = MainFrame
    
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.100000001, 0, 0.100000001, 0)
    Title.Size = UDim2.new(0, 107, 0, 18)
    Title.Font = Enum.Font.SourceSans
    Title.Text = "AutoBrew"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14.000
    Title.TextStrokeTransparency = 0.750
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    Body.Name = "Body"
    Body.Parent = MainFrame
    Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0, 0, 0.899999976, 0)
    Body.Size = UDim2.new(0, 255, 0, 189)
    
    UICorner_2.CornerRadius = UDim.new(0, 2)
    UICorner_2.Parent = Body
    UICorner_2.Name = "UICorner_2"
    
    UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(56, 56, 56)), ColorSequenceKeypoint.new(0.62, Color3.fromRGB(107, 107, 107)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(134, 134, 134))}
    UIGradient_2.Parent = Body
    UIGradient_2.Name = "UIGradient_2"
    
    Potions_B.Name = "Potions_B"
    Potions_B.Parent = Body
    Potions_B.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Potions_B.BackgroundTransparency = 0.500
    Potions_B.BorderSizePixel = 0
    Potions_B.Position = UDim2.new(0.0370370895, 0, 0.162235066, 0)
    Potions_B.Size = UDim2.new(0, 188, 0, 126)
    
    P_Image1.Name = "P_Image1"
    P_Image1.Parent = Potions_B
    P_Image1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    P_Image1.BackgroundTransparency = 1.000
    P_Image1.BorderSizePixel = 0
    P_Image1.Position = UDim2.new(0.00680850819, 0, 0.0710000023, 0)
    P_Image1.Size = UDim2.new(0, 34, 0, 34)
    P_Image1.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    P_Image1.ImageTransparency = 1.000
    
    UICorner_3.Parent = Potions_B
    UICorner_3.Name = "UICorner_3"
    
    P_Label1.Name = "P_Label1"
    P_Label1.Parent = Potions_B
    P_Label1.BackgroundColor3 = Color3.fromRGB(236, 87, 77)
    P_Label1.Position = UDim2.new(0.200000003, 0, 0.0900000036, 0)
    P_Label1.Size = UDim2.new(0, 123, 0, 29)
    P_Label1.Font = Enum.Font.SourceSans
    P_Label1.Text = "Empty Potion Slot"
    P_Label1.TextColor3 = Color3.fromRGB(0, 0, 0)
    P_Label1.TextSize = 14.000
    
    UICorner_4.Parent = P_Label1
    UICorner_4.Name = "UICorner_4"
    
    P_Bool1.Parent = Potions_B
    P_Bool1.Name = "P_Bool1"
    P_Bool1.Value = false
    
    P_Bool2.Parent = Potions_B
    P_Bool2.Name = "P_Bool2"
    P_Bool2.Value = false
    
    P_Bool3.Parent = Potions_B
    P_Bool3.Name = "P_Bool3"
    P_Bool3.Value = false
    
    -- 17
    P_Reset1.Name = "P_Reset1"
    P_Reset1.Parent = Potions_B
    P_Reset1.BackgroundTransparency = 1.000
    P_Reset1.Position = UDim2.new(0.860000014, 0, 0.100000001, 0)
    P_Reset1.Size = UDim2.new(0, 25, 0, 25)
    P_Reset1.ZIndex = 2
    P_Reset1.Image = "rbxassetid://6764432408"
    P_Reset1.ImageRectOffset = Vector2.new(200, 600)
    P_Reset1.ImageRectSize = Vector2.new(50, 50)
    P_Reset1.ImageTransparency = 0.5
    f_S[1] = "P_Reset1"
    
    -- 18
    P_Reset2.Name = "P_Reset2"
    P_Reset2.Parent = Potions_B
    P_Reset2.BackgroundTransparency = 1.000
    P_Reset2.Position = UDim2.new(0.860000014, 0, 0.3936508, 0)
    P_Reset2.Size = UDim2.new(0, 25, 0, 25)
    P_Reset2.ZIndex = 2
    P_Reset2.Image = "rbxassetid://6764432408"
    P_Reset2.ImageRectOffset = Vector2.new(200, 600)
    P_Reset2.ImageRectSize = Vector2.new(50, 50)
    P_Reset2.ImageTransparency = 0.5
    f_S[2] = "P_Reset2"
    
    P_Image2.Name = "P_Image2"
    P_Image2.Parent = Potions_B
    P_Image2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    P_Image2.BackgroundTransparency = 1.000
    P_Image2.BorderSizePixel = 0
    P_Image2.Position = UDim2.new(0.00680850819, 0, 0.364650816, 0)
    P_Image2.Size = UDim2.new(0, 34, 0, 34)
    P_Image2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    P_Image2.ImageTransparency = 1.000
    
    P_Label2.Name = "P_Label2"
    P_Label2.Parent = Potions_B
    P_Label2.BackgroundColor3 = Color3.fromRGB(236, 87, 77)
    P_Label2.Position = UDim2.new(0.200000003, 0, 0.38365081, 0)
    P_Label2.Size = UDim2.new(0, 123, 0, 29)
    P_Label2.Font = Enum.Font.SourceSans
    P_Label2.Text = "Empty Potion Slot"
    P_Label2.TextColor3 = Color3.fromRGB(0, 0, 0)
    P_Label2.TextSize = 14.000
    
    UICorner_5.Parent = P_Label2
    UICorner_5.Name = "UICorner_5"
    
    P_Label3.Name = "P_Label3"
    P_Label3.Parent = Potions_B
    P_Label3.BackgroundColor3 = Color3.fromRGB(236, 87, 77)
    P_Label3.Position = UDim2.new(0.200000003, 0, 0.677999973, 0)
    P_Label3.Size = UDim2.new(0, 123, 0, 29)
    P_Label3.Font = Enum.Font.SourceSans
    P_Label3.Text = "Empty Potion Slot"
    P_Label3.TextColor3 = Color3.fromRGB(0, 0, 0)
    P_Label3.TextSize = 14.000
    
    UICorner_6.Parent = P_Label3
    UICorner_6.Name = "UICorner_6"
    
    P_Image3.Name = "P_Image3"
    P_Image3.Parent = Potions_B
    P_Image3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    P_Image3.BackgroundTransparency = 1.000
    P_Image3.BorderSizePixel = 0
    P_Image3.Position = UDim2.new(0.00700000022, 0, 0.658999979, 0)
    P_Image3.Size = UDim2.new(0, 34, 0, 34)
    P_Image3.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    P_Image3.ImageTransparency = 1.000
    
    
    P_Reset3.Name = "P_Reset3"
    P_Reset3.Parent = Potions_B
    P_Reset3.BackgroundTransparency = 1.000
    P_Reset3.Position = UDim2.new(0.860000014, 0, 0.688000023, 0)
    P_Reset3.Size = UDim2.new(0, 25, 0, 25)
    P_Reset3.ZIndex = 2
    P_Reset3.Image = "rbxassetid://6764432408"
    P_Reset3.ImageRectOffset = Vector2.new(200, 600)
    P_Reset3.ImageRectSize = Vector2.new(50, 50)
    P_Reset3.ImageTransparency = 0.5
    f_S[3] = "P_Reset3"
    
    Buttons.Name = "Buttons"
    Buttons.Parent = Body
    Buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Buttons.BackgroundTransparency = 1.000
    Buttons.BorderSizePixel = 0
    Buttons.Position = UDim2.new(0.810000002, 0, 0.112999998, 0)
    Buttons.Size = UDim2.new(0, 46, 0, 155)
    
    Event_TP.Name = "Event_TP"
    Event_TP.Parent = Buttons
    Event_TP.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Event_TP.BackgroundTransparency = 0.660
    Event_TP.BorderSizePixel = 0
    Event_TP.Position = UDim2.new(0.805999994, 0, 0.0299999993, 0)
    Event_TP.Size = UDim2.new(0, 40, 0, 24)
    Event_TP.Font = Enum.Font.SourceSans
    Event_TP.Text = "Event"
    Event_TP.TextColor3 = Color3.fromRGB(255, 255, 255)
    Event_TP.TextSize = 14.000
    f_S[4] = "Event_TP"
    
    UICorner_7.CornerRadius = UDim.new(0, 4)
    UICorner_7.Parent = Event_TP
    UICorner_7.Name = "UICorner_7"
    
    Inv_GameUi.Name = "Inv_GameUi"
    Inv_GameUi.Parent = Buttons
    Inv_GameUi.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Inv_GameUi.BackgroundTransparency = 0.660
    Inv_GameUi.BorderSizePixel = 0
    Inv_GameUi.Position = UDim2.new(0.805999994, 0, 0.430000007, 0)
    Inv_GameUi.Size = UDim2.new(0, 40, 0, 24)
    Inv_GameUi.Font = Enum.Font.SourceSans
    Inv_GameUi.Text = "Inv."
    Inv_GameUi.TextColor3 = Color3.fromRGB(255, 255, 255)
    Inv_GameUi.TextSize = 14.000
    
    Inv_GameUi.Name = "Inv_GameUi"
    Inv_GameUi.Parent = Buttons
    Inv_GameUi.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Inv_GameUi.BackgroundTransparency = 0.660
    Inv_GameUi.BorderSizePixel = 0
    Inv_GameUi.Position = UDim2.new(0.805999994, 0, 0.430000007, 0)
    Inv_GameUi.Size = UDim2.new(0, 40, 0, 24)
    Inv_GameUi.Font = Enum.Font.SourceSans
    Inv_GameUi.Text = "Inv."
    Inv_GameUi.TextColor3 = Color3.fromRGB(255, 255, 255)
    Inv_GameUi.TextSize = 14.000
    f_S[5] = "Inv_GameUi"
    
    UICorner_8.CornerRadius = UDim.new(0, 4)
    UICorner_8.Parent = Inv_GameUi
    UICorner_8.Name = "UICorner_8"
    
    Lab_TP.Name = "Lab_TP"
    Lab_TP.Parent = Buttons
    Lab_TP.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Lab_TP.BackgroundTransparency = 0.660
    Lab_TP.BorderSizePixel = 0
    Lab_TP.Position = UDim2.new(0.805999994, 0, 0.230000004, 0)
    Lab_TP.Size = UDim2.new(0, 40, 0, 24)
    Lab_TP.Font = Enum.Font.SourceSans
    Lab_TP.Text = "Lab"
    Lab_TP.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lab_TP.TextSize = 14.000
    f_S[6] = "Lab_TP"
    
    UICorner_9.CornerRadius = UDim.new(0, 4)
    UICorner_9.Parent = Lab_TP
    
    Inv_Ui.Name = "Inv_Ui"
    Inv_Ui.Parent = Buttons
    Inv_Ui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Inv_Ui.BackgroundTransparency = 0.660
    Inv_Ui.BorderSizePixel = 0
    Inv_Ui.Position = UDim2.new(0.805999994, 0, 0.620000005, 0)
    Inv_Ui.Size = UDim2.new(0, 40, 0, 24)
    Inv_Ui.Font = Enum.Font.SourceSans
    Inv_Ui.Text = "UI"
    Inv_Ui.TextColor3 = Color3.fromRGB(255, 255, 255)
    Inv_Ui.TextSize = 14.000
    f_S[7] = "Inv_Ui"
    
    UICorner_10.CornerRadius = UDim.new(0, 4)
    UICorner_10.Parent = Inv_Ui
    UICorner_10.Name = "UICorner_10"
    
    Pot_Upd.Name = "Pot_Upd"
    Pot_Upd.Parent = Buttons
    Pot_Upd.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Pot_Upd.BackgroundTransparency = 0.660
    Pot_Upd.BorderSizePixel = 0
    Pot_Upd.Position = UDim2.new(0.805999994, 0, 0.810000002, 0)
    Pot_Upd.Size = UDim2.new(0, 40, 0, 24)
    Pot_Upd.Font = Enum.Font.SourceSans
    Pot_Upd.Text = "Upd."
    Pot_Upd.TextColor3 = Color3.fromRGB(255, 255, 255)
    Pot_Upd.TextSize = 14.000
    f_S[8] = "Pot_Upd"
    
    UICorner_12.CornerRadius = UDim.new(0, 4)
    UICorner_12.Parent = Pot_Upd
    UICorner_12.Name = "UICorner_12"
    
    UIListLayout.Parent = Buttons
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0.0399999991, 0)
    
    C_Indicator.Name = "C_Indicator"
    C_Indicator.Parent = Body
    C_Indicator.BackgroundTransparency = 1.000
    C_Indicator.Position = UDim2.new(0.0390000008, 0, 0.0149999997, 0)
    C_Indicator.Size = UDim2.new(0, 25, 0, 25)
    C_Indicator.ZIndex = 2
    C_Indicator.Image = "rbxassetid://3926309567"
    C_Indicator.ImageRectOffset = Vector2.new(628, 420)
    C_Indicator.ImageRectSize = Vector2.new(48, 48)
    f_S[9] = "C_Indicator"
    
    C_Color.Name = "C_Color"
    C_Color.Parent = C_Indicator
    C_Color.BackgroundColor3 = Color3.fromRGB(214, 0, 0)
    C_Color.Position = UDim2.new(0.22, 0, 0.20, 0)
    C_Color.Size = UDim2.new(0, 15, 0, 15)
    C_Color.Font = Enum.Font.SourceSans
    C_Color.Text = ""
    C_Color.TextColor3 = Color3.fromRGB(0, 0, 0)
    C_Color.TextSize = 14.000
    
    UICorner_13.CornerRadius = UDim.new(0, 100)
    UICorner_13.Parent = C_Color
    UICorner_13.Name = "UICorner_13"
    
    B_Indicator.Name = "B_Indicator"
    B_Indicator.Parent = Body
    B_Indicator.BackgroundTransparency = 1.000
    B_Indicator.Position = UDim2.new(0.670372546, 0, 0.0149999997, 0)
    B_Indicator.Size = UDim2.new(0, 25, 0, 25)
    B_Indicator.ZIndex = 2
    B_Indicator.Image = "rbxassetid://3926309567"
    B_Indicator.ImageRectOffset = Vector2.new(628, 420)
    B_Indicator.ImageRectSize = Vector2.new(48, 48)
    f_S[10] = "B_Indicator"
    
    B_Color.Name = "B_Color"
    B_Color.Parent = B_Indicator
    B_Color.BackgroundColor3 = Color3.fromRGB(214, 0, 0)
    B_Color.Position = UDim2.new(0.22, 0, 0.20, 0)
    B_Color.Size = UDim2.new(0, 15, 0, 15)
    B_Color.Font = Enum.Font.SourceSans
    B_Color.Text = ""
    B_Color.TextColor3 = Color3.fromRGB(0, 0, 0)
    B_Color.TextSize = 14.000
    
    UICorner_14.CornerRadius = UDim.new(0, 100)
    UICorner_14.Parent = B_Color
    UICorner_14.Name = "UICorner_14"
    
    C_Label.Name = "C_Label"
    C_Label.Parent = Body
    C_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    C_Label.BackgroundTransparency = 1.000
    C_Label.Position = UDim2.new(0.149019614, 0, 0.0211640205, 0)
    C_Label.Size = UDim2.new(0, 76, 0, 21)
    C_Label.Font = Enum.Font.SourceSans
    C_Label.Text = "Currently:  Idle"
    C_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    C_Label.TextSize = 14.000
    C_Label.TextXAlignment = Enum.TextXAlignment.Left
    
    Potions_N.Name = "Potions_N"
    Potions_N.Parent = Body
    Potions_N.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Potions_N.BackgroundTransparency = 0.600
    Potions_N.Position = UDim2.new(0.0352941193, 0, 0.862433851, 0)
    Potions_N.Size = UDim2.new(0, 188, 0, 19)
    
    UICorner_11.CornerRadius = UDim.new(0, 3)
    UICorner_11.Parent = Potions_N
    UICorner_11.Name = "UICorner_11"
    
    Potions_C.Name = "Potions_C"
    Potions_C.Parent = Potions_N
    Potions_C.BackgroundTransparency = 1.000
    Potions_C.Position = UDim2.new(0.879999995, 0, -0.25, 0)
    Potions_C.Rotation = 90.000
    Potions_C.Selectable = false
    Potions_C.Size = UDim2.new(0, 25, 0, 28)
    Potions_C.ZIndex = 2
    Potions_C.Image = "rbxassetid://3926305904"
    Potions_C.ImageRectOffset = Vector2.new(564, 284)
    Potions_C.ImageRectSize = Vector2.new(36, 36)
    f_S[11] = "Potions_C"
    
    P_List.Name = "P_List"
    P_List.Parent = Potions_N
    P_List.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
    P_List.BackgroundTransparency = 0.020
    P_List.BorderSizePixel = 0
    P_List.ClipsDescendants = true
    P_List.Position = UDim2.new(0.00200000009, 0, 0.970000029, 0)
    P_List.Size = UDim2.new(0, 188, 0, 0)
    P_List.Visible = true
    
    UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
    UIGradient_3.Parent = Potions_N
    UIGradient_3.Name = "UIGradient_3"
    
    P_Label.Name = "P_Label"
    P_Label.Parent = Body
    P_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    P_Label.BackgroundTransparency = 1.000
    P_Label.Position = UDim2.new(0.175999999, 0, 0.870000005, 0)
    P_Label.Size = UDim2.new(0, 63, 0, 15)
    P_Label.Font = Enum.Font.SourceSans
    P_Label.Text = "Choose Potion(s)"
    P_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    P_Label.TextSize = 14.000
    P_Label.TextStrokeTransparency = 0.750
    P_Label.TextXAlignment = Enum.TextXAlignment.Left
    
    Main_C.Name = "Main_C"
    Main_C.Parent = MainFrame
    Main_C.BackgroundTransparency = 1.000
    Main_C.Position = UDim2.new(0.889999986, 0, -0.075000003, 0)
    Main_C.Selectable = false
    Main_C.Size = UDim2.new(0, 25, 0, 28)
    Main_C.ZIndex = 2
    Main_C.Image = "rbxassetid://3926305904"
    Main_C.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Main_C.ImageRectOffset = Vector2.new(564, 284)
    Main_C.ImageRectSize = Vector2.new(36, 36)
    f_S[12] = "Main_C"
    
    Warning_Label.Name = "Warning_Label"
    Warning_Label.Parent = MainFrame
    Warning_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Warning_Label.BackgroundTransparency = 1.000
    Warning_Label.Position = UDim2.new(0.101960786, 0, -0.96825397, 0)
    Warning_Label.Size = UDim2.new(0, 200, 0, 18)
    Warning_Label.Font = Enum.Font.SourceSans
    Warning_Label.Text = "Warning! BrewingFrame Unloaded!"
    Warning_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Warning_Label.TextSize = 14.000
    Warning_Label.TextStrokeTransparency = 0.750
    Warning_Label.TextTransparency = 0
    Warning_Label.Visible = false
    
    Warning_Icon.Name = "Warning_Icon"
    Warning_Icon.Parent = MainFrame
    Warning_Icon.BackgroundColor3 = Color3.fromRGB(165, 0, 0)
    Warning_Icon.BackgroundTransparency = 1.000
    Warning_Icon.BorderSizePixel = 0
    Warning_Icon.Position = UDim2.new(0.0350000001, 0, -1.06666672, 0)
    Warning_Icon.Size = UDim2.new(0, 25, 0, 25)
    Warning_Icon.ZIndex = 2
    Warning_Icon.Image = "rbxassetid://3926305904"
    Warning_Icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
    Warning_Icon.ImageRectOffset = Vector2.new(364, 324)
    Warning_Icon.ImageRectSize = Vector2.new(36, 36)
    Warning_Icon.ImageTransparency = 0
    Warning_Icon.Visible = false
    f1:Remove(); f1.Name = fN
    
    spawn(function()
    	while wait(1) do
    		pcall(function()
    			if not LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame") then
    				i_T[79].Visible = true
    				repeat i_T[80].Visible = not i_T[80].Visible; wait(1) until LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")
    				i_T[79].Visible = false
    				i_T[80].Visible = false
    			elseif not ((g_Constraint and i_T[39].BackgroundColor3 == Color3.fromRGB(0, 214, 0) and i_T[44].Text == "Currently:  Brewing")
    				or ((not g_Constraint) and i_T[39].BackgroundColor3 == Color3.fromRGB(214, 0, 0) and (i_T[44].Text == "Currently:  Idle" or i_T[44].Text == "No potions to brew!"))) then
    				i_T[39].BackgroundColor3 = Color3.fromRGB(214, 0, 0); i_T[44].Text = "Currently:  Idle"; g_Constraint = false
    			end
    		end)
    	end
    end)
    
    spawn(function()
    	while wait(0.8) do if b_Constraint then game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer("BlowBubble") end end
    end)
    
    spawn(function()
    	while wait(1) do
    		pcall(function()
    			for i = 1, 3 do
    				if i_T[9]["P_Label"..i].Text ~= P_list[i] then i_T[9]["P_Label"..i].Text = P_list[i] end
    			end
    			for i = 1, #g_P do
    				if i_T[48]["Recipe"..i].Text ~= g_P[i] then i_T[48]["Recipe"..i].Text = g_P[i] end
    			end
    		end)
    	end
    end)
    
    pcall(function()
    	for i = 1, #b_F.Recipes:GetChildren() - 1 do
    		local temp = b_F.Recipes:FindFirstChild("Recipe"..i)
    
    		local Temp = Instance.new("TextButton")
    		local TextLabel = Instance.new("TextLabel")
    		local t_UIC = Instance.new("UICorner")
    
    		Temp.Name = temp.Name
    		Temp.Parent = P_List
    		Temp.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    		Temp.BackgroundTransparency = 0.250
    		Temp.Position = UDim2.new(0.035, 0, 0.035 + 0.105*(i - 1), 0)
    		Temp.Size = UDim2.new(0, 149, 0, 19)
    		Temp.Font = Enum.Font.SourceSans
    		Temp.Text = temp.ItemName.Text
    		Temp.TextColor3 = Color3.fromRGB(255, 255, 255)
    		Temp.TextSize = 14.000
    		Temp.TextStrokeTransparency = 0.750
    
    		TextLabel.Name = "q"..temp.Name
    		TextLabel.Parent = P_List
    		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    		TextLabel.BackgroundTransparency = 1.000
    		TextLabel.Position = UDim2.new(0.84, 0, 0.035 + 0.105*(i - 1), 0)
    		TextLabel.Size = UDim2.new(0, 35, 0, 19)
    		TextLabel.Font = Enum.Font.SourceSans
    		TextLabel.Text = ":  "
    		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    		TextLabel.TextSize = 14.000
    		TextLabel.TextStrokeTransparency = 0.750
    		TextLabel.TextXAlignment = "Left"
    		f_S[12 + i] = temp.Name
    
    		table.insert(images, tostring(temp.ItemImage.Image))
    		table.insert(g_P, temp.ItemName.Text)
    
    		t_UIC.CornerRadius = UDim.new(0, 8)
    		t_UIC.Parent = Temp
    		t_UIC.Name = tostring(15 + i)
    	end
    end)
    
    MainUi_3:Clone().Parent = f1
    writefile("TEST.txt", "")
    for i, v in pairs(game:GetService("CoreGui")[name]:GetDescendants()) do
    	i_T[i + 1] = v; n_T[i + 1] = v.Name; p_T[i + 1] = v.Parent
    	for x = 1, #f_S do if v.Name == f_S[x] then cfun(x, v) end end
    	appendfile("TEST.txt", tostring(i) .. " | " .. tostring(i_T[i]) .. "\n")
    end
    
    spawn(function()
    	while wait(1) do
    		for i = 1, #i_T do
    			if i_T[i].Parent ~= p_T[i] then 
    			    if i_T[i].Parent == nil then 
    			        pcall(function() i_T[i]:Destroy() end); 
    					for x, c in pairs(f1:GetDescendants()) do 
    					    if x == i then
    					        print("Cloning:", c)
    					        c:Clone().Parent = p_T[i]; wait(0.5); i_T[i] = p_T[i]:FindFirstChild(n_T[i])
    					        for z, t in pairs(i_T[i]:GetDescendants()) do 
    					            print("Expected:", t, "| Repairing:", n_T[x + z])
    					            print("Fixing parent:", p_T[x + z], "to", t.Parent)
    					            i_T[x + z] = t
    					            p_T[x + z] = t.Parent
    					            for y = 1, #f_S do
    					                if n_T[x + z] == f_S[y] then
    					                    print("Calling cfun(" .. tostring(y) .. ",", tostring(i_T[x + z]) .. ")")
    					                    cfun(y, i_T[x + z])
    					                end
    					            end
    					        end
    					    end
    					end  
    				else i_T[i].Parent = p_T[i] print("Fixing Parent of", i_T[i], "to be", p_T[i]) end end
    			if i_T[i].Name ~= n_T[i] then i_T[i].Name = n_T[i] end
    		end
    	end
    end)
    
    -- fills p_Q with blank data then removes the close button on the BrewingFrame
    for i = 1, #i_T[48]:GetChildren()/2 do table.insert(p_Q, 0) end
    if b_F:FindFirstChild("Close") then b_F.Close.Parent = nil end; b_F.Visible = false
    
    
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
    		pcall(function() for i = 1, #p_Q do if i_T[48]["qRecipe"..i].Text ~= (":  " .. tostring(p_Q[i])) then i_T[48]["qRecipe"..i].Text = (":  " .. tostring(p_Q[i])) end end end)
    	end
    end)
    
    -- main loop
    spawn(function()
    	while wait(1) do
    		pcall(function()
    			if (i_T[39].BackgroundColor3 == Color3.fromRGB(0, 214, 0) and b_F) then
    				for i = 3, 1, -1 do
    					if (not checkSkip(i)) then
    						if b_F.Brewing["Brew"..i].Empty.Visible then
    							for x = 1, 3 do
    								if i_T[9]["P_Label"..x].Text ~= "Empty Potion Slot" and i_T[9]["P_Bool"..x].Value then -- checks for a ready potion
    									if checkBrew(i_T[9]["P_Label"..x].Text) and sum < p_Max then
    										Event:FireServer("BrewPotion", getPotion(i_T[9]["P_Label"..x].Text)) -- brews the potion
    										i_T[9]["P_Bool"..x].Value = false
    									else print("Either you\'ve maxed your potion storage, or you don\'t have enough resources to brew: " .. i_T[9]["P_Label"..x].Text) end break
    								end
    							end
    						else
    							for x = 1, 3 do 
    								if b_F.Brewing["Brew"..i].Brewing.ItemName.Text == i_T[9]["P_Label"..x].Text and not i_T[9]["P_Bool"..x].Value then -- checks collected potion is still being brewed
    									i_T[9]["P_Bool"..x].Value = true
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
    
    warn("\n\nProgram fully loaded! If you encounter any bugs/problems, or, if you have any questions/suggestions, ")
    warn("please PM me either by discord - dooop#0496 - or through V3rmillion.net - Activities12 -")
    MainFrame.Visible = true; f1[name].MainFrame.Visible = true
end
