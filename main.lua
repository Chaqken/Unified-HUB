-- Coded by Chaqken.
-- If you have any questions, tips, suggestions or bugs lmk - Chaqken#5838


-- Makes sure that the correct game is only used while using the script.
-- GAME: https://www.roblox.com/games/9711302332/UPD-7-Clicker-Heroes
local player = game.Players.LocalPlayer

if (game.PlaceId == 9711302332) then
    print("Launching Unified Hub.")

else
    player:Kick("Invalid game - Unified Hub")
end



getgenv().autoTap = false -- Value for Autoclicker
getgenv().autoRebirth = false -- Value for Rebirth
getgenv().buyEgg = false -- Value for buying 1 egg.
getgenv().buyThreeEgg = false -- Value for buying 3 eggs
getgenv().autoPet = false -- Value for always equip best pet.
getgenv().sellPets = false -- Work in progress.
getgenv().upgradePet = false -- Value for always evolve pet.



-- UI elements, made by  Rayfield - https://discord.gg/fcEhETeG9X

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Unified Hub",
    LoadingTitle = "Unified Hub",
    LoadingSubtitle = "by Chaqken",
    ConfigurationSaving = {
        Enabled = false, -- (ConfigurationSaving - Disabled)
        FolderName = nil,
        FileName = "Big Hub"
    },
    Discord = { -- Auto join discord (Disabled)
        Enabled = false,
        Invite = "sirius",
        RememberJoins = false
    },
    KeySystem = false, -- Key system ( Disabled)
    KeySettings = {
        Title = "Sirius Hub",
        Subtitle = "Key System",
        Note = "Join the discord (discord.gg/sirius)",
        FileName = "SiriusKey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = "Hello"
    }
})

-- The tabs for the HUB
local Tab = Window:CreateTab("AutoFarm", 4483362458)
local Pet = Window:CreateTab("Pets", 4483362458)
local MISC = Window:CreateTab("MISC", 4483362458)


-- All the Buttons, sliders, dropdowns and toggles are here.
local Toggle = Tab:CreateToggle({
    Name = "Auto Clicker",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().autoTap = Value
        doTap()
    end,
})

local Slider = Tab:CreateSlider({
    Name = "Rebirth Setting",
    Range = { 0 , 35 },
    Increment = 1,
    Suffix = "level Rebirths",
    CurrentValue = 0,
    Flag = "Slider1",
    Callback = function(Value)
        amount = Value
    end,
})

local Toggle = Tab:CreateToggle({
    Name = "Auto Rebirths",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().autoRebirth = Value
        doRebirth()
    end,
})



local Button = Tab:CreateButton({
    Name = "Buy Max More Rebirth Levels",
    Callback = function()
        maxRebirth()
    end,
})

local Toggle = Pet:CreateToggle({
    Name = "Always Equip Best Pets",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().autoPet = Value
        equipPet()
    end,
})

local Toggle = Pet:CreateToggle({
    Name = "Always Evolve Pets",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().upgradePet = Value
        evolvePet()
    end,
})

local Section = Pet:CreateSection("Buy 1 Egg")

local Dropdown = Pet:CreateDropdown({ -- 1 egg
    Name = "Egg Selection",
    Options = { "Select Option", "Starter", "Iceberg", "Toy", "Brick", "Atlantis", "Trident", "Eruption", "Obsidian",
        "Asteroid", "Galaxy", "Cyborg", "Tech", "Ninja", "Master", "Desert", "Sandy", "Cupcake", "Sugar Rush" },
    CurrentOption = "Select Option",
    Flag = "Dropdown1",
    Callback = function(Option)
        thing = Option
    end,
})

local Toggle = Pet:CreateToggle({
    Name = "Auto Buy Pets",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().buyEgg = Value
        doEgg()
    end,
})



local Section = Pet:CreateSection("Buy 3 Eggs")

local Dropdown = Pet:CreateDropdown({ -- 3 eggs
    Name = "3 Eggs Selection",
    Options = { "Select Option", "Starter", "Iceberg", "Toy", "Brick", "Atlantis", "Trident", "Eruption", "Obsidian",
        "Asteroid", "Galaxy", "Cyborg", "Tech", "Ninja", "Master", "Desert", "Sandy", "Cupcake", "Sugar Rush" },
    CurrentOption = "Select Option",
    Flag = "Dropdown1",
    Callback = function(Option)
        thing = Option
    end,
})

local Toggle = Pet:CreateToggle({
    Name = "Auto Buy 3 Pets",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().buyThreeEgg = Value
        doEggs()
    end,
})

local Button = MISC:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            print("Launched anti AFK")
        end)
    end,
})

local Button = MISC:CreateButton({
    Name = "No purchase Prompts",
    Callback = function()
        noGUI()
    end,
})

local Button = MISC:CreateButton({
    Name = "Credits",
    Callback = function()
        credit()
    end,
})

local Button = MISC:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        print("You have destroyed the UI!")
        Rayfield:Destroy()
    end,
})






-- All scripts/remotes are here.
local remotePath = game:GetService("ReplicatedStorage").Shared.Modules.Utilities.NetworkUtility.Events;


function doTap()
    spawn(function()
        while autoTap == true do
            local args = { [1] = "Tap Capacity", [2] = "HandleTapActivation", [3] = "Home" }
            remotePath.UpdateGemUpgrades:FireServer(unpack(args))
            wait()
        end
    end)
end

function doRebirth()
    spawn(function()
        while autoRebirth == true do
            local args = { [1] = "BuyRebirths", [2] = amount }
            remotePath.UpdateRebirths:FireServer(unpack(args))
            wait(3)
        end
    end)
end

function doEgg()
    spawn(function()
        while buyEgg == true do
            local args = {
                [1] = "PurchaseEgg",
                [2] = thing
            }
            game:GetService("ReplicatedStorage").Shared.Modules.Utilities.NetworkUtility.Events.UpdatePets:FireServer(unpack(args))
            wait(4)
        end
    end)
end

function doEggs()
    spawn(function()
        while buyThreeEgg == true do
            local args = {
                [1] = "PurchaseEgg",
                [2] = thing,
                [3] = true
            }
            game:GetService("ReplicatedStorage").Shared.Modules.Utilities.NetworkUtility.Events.UpdatePets:FireServer(unpack(args))
            wait(4)
        end
    end)
end

function equipPet()
    spawn(function()
        while autoPet == true do
            local args = { [1] = "EquipBestPets" }
            game:GetService("ReplicatedStorage").Shared.Modules.Utilities.NetworkUtility.Events.UpdatePets:FireServer(unpack(args))
            wait(10)
        end
    end)
end

function evolvePet()
    spawn(function()
        while upgradePet == true do
            local args = { [1] = "EvolveAllPets" }
            game:GetService("ReplicatedStorage").Shared.Modules.Utilities.NetworkUtility.Events.UpdatePets:FireServer(unpack(args))
            wait(11)
        end
    end)
end

-- Was going to make a teleport script but decided not too. WORK IN PROGRESS
function getCurrentPlayerPOS()
    local plyr = game.Players.LocalPlayer;
    if plyr.Character then
        return plyr.Character.HumanoidRootPart.Positionl
    end
    return false;
end

function teleportTO(placeCFrame)
    local plyr = game.Players.LocalPlayer;
    if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end

-- teleportTO(game:GetService("Workspace").Worlds.Winter.Assets.Others.Portal.TitlePart.CFrame)

function noGUI()
    local COREGUI = game:GetService("CoreGui")
    COREGUI.PurchasePrompt.Enabled = false
    print("No Prompts enabled")
end

function credit()
    Rayfield:Notify({
        Title = "Credits",
        Content = "Hi I am Chaqken and I have coded this script from scratch except for the ui, this is my first script ever so thank you",
        Duration = 6.5,
        Image = 4483362458,
        Actions = { -- Notification Buttons
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("The user tapped Okay!")
                end
            },
        },
    })
end

function maxRebirth()
    local args = {
        [1] = "More Rebirths",
        [2] = "BuyMax",
        [3] = "Home"
    }

    game:GetService("ReplicatedStorage").Shared.Modules.Utilities.NetworkUtility.Events.UpdateGemUpgrades:FireServer(unpack(args))
end
