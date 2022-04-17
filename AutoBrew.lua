
-- wait until your character is loaded in cuz im bad at coding

local Event = game:GetService("ReplicatedStorage").NetworkRemoteEvent
local LP = game:GetService("Players").LocalPlayer
local Frame
local Potions
local UI
local g_

if not LP:FindFirstChild("leaderstats") then repeat wait(2) until LP:FindFirstChild("leaderstats") end

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
print(UI.Name)

warn("\nProgram Succesfully Initiated\nThanks for using the script ig\n")
if Frame:FindFirstChild("Close") then Frame.Close:Remove() end 

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

-- test with using a pcall for the main loop

if Frame then print("Frame is loaded") else print("Some Error") end

-- main loop
spawn(function()
    while wait(1) do
        pcall(function()
            if (UI.Body.C_Indicator.ImageColor3 == Color3.fromRGB(0, 255, 0) and Frame) then
                for i = 1, g_ do
                    if (not checkSkip(i)) then
                        if Frame.Brewing["Brew"..i].Empty.Visible then
                            for x = 1, g_ do
                                if UI.MainFrame.Body.Potions_B["P_Label"..x].Text ~= "Empty Potion Slot" and UI.MainFrame.Body.Potions_B["P_Bool"..x] then -- checks for a ready potion
                                    Event:FireServer("BrewPotion", getPotion(UI.MainFrame.Body.Potions_B["P_Label"..x].Text)) -- brews the potion
                                    UI.MainFrame.Body.Potions_B["P_Bool"..x] = false
                                    break
                                end
                            end
                        else
                            for x = 1, g_ do 
                                if Frame.Brewing["Brew"..i].Brewing.ItemName.Text == UI.MainFrame.Body.Potions_B["P_Label"..x].Text and not UI.MainFrame.Body.Potions_B["P_Bool"..x] then -- checks collected potion is still being brewed
                                    UI.MainFrame.Body.Potions_B["P_Bool"..x] = true
                                    Event:FireServer("ClaimPotion", i)
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

