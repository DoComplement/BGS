
-- wait until your character is loaded in cuz im bad at coding

local MS = game:GetService("MarketplaceService")
local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer
local Event = RS.NetworkRemoteEvent
local Function = RS.NetworkRemoteFunction
local Frame
local g_

-- teleports the user to the lab and repeatedly teleports the user to the NPC until the frame is loaded
pcall(function()
    if (not LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")) then
        Event:FireServer("Teleport", "LabSpawn")
        repeat wait(0.5)
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1740.89038, 2705.99048, 11044.1572, -0.984202802, -4.41739587e-08, -0.177044764, -3.80400742e-08, 1, -3.80401666e-08, 0.177044764, -3.07044417e-08, -0.984202802)
        until LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")
        
        Frame = LP.PlayerGui.ScreenGui:FindFirstChild("BrewingFrame")
        if Frame.Brewing.Brew3.Gamepass.Visible then g_ = 2 else g_ = 3 end
    end
end)

-- defines the loop constraint for the auto brewer
pcall(function()
    if (not LP:FindFirstChild("LOOP_CONSTRAINT")) then
        local folder = Instance.new("Folder")
        folder.Name = "LOOP_CONSTRAINT"
        folder.Parent = LP
        
        local pFolder = Instance.new("Folder")
        pFolder.Name = "Potions"
        pFolder.Parent = LP
        
        -- creates the parts to hold the names of the potions to produce
        -- the transparency of the part (for now) is the brew tag
        for i = 1, g_ do
            local temp = Instance.new("Part")
            temp.Name = "Add Potion"
            temp.Parent = pFolder
        end
        
        local part = Instance.new("Part")
        part.Name = "False"
        part.Parent = folder
    end
end)

-- defining variables for convenience
local Folder = LP.Potions
local Constraint = LP.LOOP_CONSTRAINT:FindFirstChildOfClass("Part")

-- assigns the Visible attribute of all of the frames which cause the BrewingFrame to close when interacted with
local function iFrames(b)
    pcall(function()
        local d = LP.PlayerGui.ScreenGui
        local s = {"Codes", "Index", "Boosts", "Prizes"}
        
        for i = 1, #s do d.StatsFrame:FindFirstChild(s[i]).Visible = b end
        
        d.StatsFrame.Coins.More.Visible = b
        d.StatsFrame.Gems.More.Visible = b
        d.MainButtons.Visible = b
        d.Settings.Visible = b
    end)
end

-- to be called in the case where someone buys the Extra Brew Slot mid-game
-- check passive condition on user's roblox account before giving possibility for this to be called
-- (Change check condition from if the gamepass frame is visible to a condition if the user has purchased the Dev. Product)

local function checkVIP()
    print("Not yet...")
end

warn("\nProgram Succesfully Initiated\nThanks for using the script ig\n")
if Frame:FindFirstChild("Close") then Frame.Close:Remove() end -- removes the close button so the BrewingFrame doesn't get accidentaly closed
iFrames(false) -- closes all the other GUIS so the BrewingFrame doesn't get accidentaly closed
-- The BrewingFrame is closed when ANY other GUI is opened

-- complements the visibility of the BrewingFrame
local function cFrame()
    if Frame then
        if Frame.Visible then
            Frame.Visible = false
        else
            Frame.Visible = true
            iFrames(false)
        end
    end
end

-- inverts the loop constraint
local function lConstraint()
    if (Constraint.Name == "True") then
        Constraint.Name = "False"
    else
        Constraint.Name = "True"
    end
end
-- when implemented with the gui, have a local variable to represent to constraint and a box to interact with the constraint
-- This removes the possibility for accidental or forced tampering with the constraint directly
-- (check if the box corresponding to the contraint is tampered with (deleted, moved, renamed, color changed, etc.))

-- checks if either the skip frame is visible, given the visibile attribute value of the parent Brewing frame
local function checkSkip(i)
    return (Frame.Brewing:FindFirstChild("Brew"..i).Brewing.Visible and Frame.Brewing:FindFirstChild("Brew"..i).Brewing.Skip.Visible)
end

-- potion list (In order according the the game and corresponding remote function index calls)
local Potions = {"+1 Level", "+1 Enchant", "Shadow Potion", "Max Level", "Max Enchant", "Max Shadow", "Potion of Money", "Potion of Worlds", "Potion of Bubbles"}

-- returns the index of a potion in the list based on the name of the potion in the parameter - str -
local function getPotion(str)
    for i = 1, #Potions do
        if string.match(str, Potions[i]) then return i end
    end
end

-- test with using a pcall for the main loop

-- main loop
spawn(function()
    while wait(1) do
        pcall(function()
            if (Constraint.Name == "True" and Frame) then
                for i = 1, g_ do
                    if (not checkSkip(i)) then
                        if Frame.Brewing:FindFirstChild("Brew"..i).Empty.Visible then
                            for x, v in pairs(Folder:GetChildren()) do
                                if v.Transparency == 0  then -- checks for a ready potion
                                    print("Brewing", v.Name) -- outputs which potion is being brewed
                                    Event:FireServer("BrewPotion", getPotion(v.Name)) -- brews the potion
                                    v.Transparency = 1 -- sets the corresponding brew tag
                                    break
                                end
                            end
                        else
                            print("Claimed", Frame.Brewing:FindFirstChild("Brew"..i).Brewing.ItemName.Text) -- outputs which potion is claimed
                            for x, v in pairs(Folder:GetChildren()) do -- looping through automated potion brewing set
                                if Frame.Brewing:FindFirstChild("Brew"..i).Brewing.ItemName.Text == v.Name then -- checks collected potion is still being brewed
                                    v.Transparency = 0 -- resets brew tag
                                    break
                                end
                            end
                            Event:FireServer("ClaimPotion", i)
                        end
                        wait(0.5)
                    end
                end
            end
        end)
    end
end)

