while not game:IsLoaded() do
	task.wait(1)
end

local Services = setmetatable({}, {
	__index = function(self, Key)
		return game:GetService(Key)
	end
})

local QueueTeleport = queue_on_teleport or queueonteleport
local TeleportCode = [==[
	loadstring(game:HttpGet("https://raw.githubusercontent.com/GeorgeRoblox/myees/refs/heads/main/df.luau"))()
]==]

local LocalPlayer = Services.Players.LocalPlayer
local RemotesFolder = Services.ReplicatedStorage:FindFirstChild("RemotesFolder")
local CurrentRooms = Services.Workspace:FindFirstChild("CurrentRooms")
local GameData = Services.ReplicatedStorage:FindFirstChild("GameData")

local notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/GeorgeRoblox/Rhyans-notification/refs/heads/main/Notification20%25yes.lua"))()

FireBacon = "https://raw.githubusercontent.com/GeorgeRoblox/Notification/refs/heads/main/FireBacon.jpg"

local function SendNotify(Text)
notify("BlackKing", {
	Title = "George",
	Description = Text,
	Image = FireBacon,
	Color = Color3.fromRGB(255, 222, 189),
	Time = 5
})
end

if game.PlaceId == 6516141723 then
	SendNotify("Joining a run...")
	QueueTeleport(TeleportCode)
	RemotesFolder.CreateElevator:FireServer({
		Mods = {},
		Settings = {},
		Destination = "Hotel",
		FriendsOnly = false,
		MaxPlayers = "1"
	})
	return
end

if GameData and GameData.Floor.Value ~= "Hotel" then
	QueueTeleport([==[
		local RemotesFolder = game:GetService("ReplicatedStorage").RemotesFolder
		local function SendNotify(Text)
			if firesignal then
				firesignal(RemotesFolder.Caption.OnClientEvent, "[Abysall Hub] " .. Text)
			else
				RemotesFolder.CaptionClient:Fire("[Abysall Hub] " .. Text)
			end
		end

		local QueueTeleport = queue_on_teleport or queueonteleport
		QueueTeleport([=[loadstring(game:HttpGet("https://raw.githubusercontent.com/GeorgeRoblox/myees/refs/heads/main/df.luau"))()]=])

		SendNotify("Joining a run...")
		RemotesFolder.CreateElevator:FireServer({
			Mods = {},
			Settings = {},
			Destination = "Hotel",
			FriendsOnly = false,
			MaxPlayers = "1"
		})
		
	]==])
	RemotesFolder.Lobby:FireServer()
	return
end

if game.PlaceId ~= 6839171747 then
	QueueTeleport([==[
		local RemotesFolder = game:GetService("ReplicatedStorage").RemotesFolder
		local function SendNotify(Text)
			if firesignal then
				firesignal(RemotesFolder.Caption.OnClientEvent, "[Abysall Hub] " .. Text)
			else
				RemotesFolder.CaptionClient:Fire("[Abysall Hub] " .. Text)
			end
		end

		local QueueTeleport = queue_on_teleport or queueonteleport
		QueueTeleport([=[loadstring(game:HttpGet("https://raw.githubusercontent.com/GeorgeRoblox/myees/refs/heads/main/df.luau"))()]=])

		SendNotify("Joining a run...")
		RemotesFolder.CreateElevator:FireServer({
			Mods = {},
			Settings = {},
			Destination = "Hotel",
			FriendsOnly = false,
			MaxPlayers = "1"
		})
		
	]==])
	Services.TeleportService:Teleport(6516141723)
	return
end

if #CurrentRooms:GetChildren() > 1 or LocalPlayer.Character then
	SendNotify("Run has already started, joining a new run for best experience...")
	QueueTeleport(TeleportCode)
	RemotesFolder.PlayAgain:FireServer()
	return
end

while #CurrentRooms:GetChildren() < 1 or not LocalPlayer.Character do
	task.wait(1)
end

local MainUI = LocalPlayer.PlayerGui:WaitForChild("MainUI", 9e9)

if MainUI:FindFirstChild("ItemShop") then
	MainUI.ItemShop.Visible = false
	RemotesFolder.PreRunShop:FireServer({}, true)
end

task.wait(1)
fireproximityprompt(Services.Workspace:FindFirstChild("SkipPrompt", true))
Services.Workspace:FindFirstChild("Luggage_Cart_Crouch", true):Destroy()

local function WalkPosition(TargetPosition)
	local RootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 9e9)
	local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 9e9)

	local Finished = false
	local Connection = Services.RunService.RenderStepped:Connect(function()
		Humanoid:MoveTo(TargetPosition)
		if LocalPlayer:DistanceFromCharacter(TargetPosition) < 6 then
			Finished = true
		end
	end)

	while task.wait() do
		if Finished then
			Connection:Disconnect()
			break
		end
	end
	task.wait()

	return true
end
task.wait(1)

for Index, Object in pairs(CurrentRooms["0"].Assets:GetChildren()) do
	if Object.Name == "Potted_Plant" then
		Object.Collision.CanCollide = false
	end
end

SendNotify("Getting the key...")
local Door = CurrentRooms["0"]:FindFirstChild("Door")
Door.Lock.CanCollide = false
WalkPosition(Door.Lock.Position)

local Key = CurrentRooms["0"]:FindFirstChild("KeyObtain", true)
WalkPosition(Key.Hitbox.Position)
fireproximityprompt(Key:FindFirstChild("ModulePrompt", true))

SendNotify("Got the key, opening the door...")
local Door = CurrentRooms["0"]:FindFirstChild("Door")
Door.Lock.CanCollide = false
WalkPosition(Door.Lock.Position)
fireproximityprompt(Door:FindFirstChild("UnlockPrompt", true))

while not CurrentRooms:FindFirstChild("2") do
	task.wait()
end

if replicatesignal then
	replicatesignal(LocalPlayer.Kill)
else
	SendNotify("Please wait around 20 seconds to die")
	RemotesFolder.Underwater:FireServer(true)
end

RemotesFolder.Revive:FireServer(true)

task.wait(1)

local Room = CurrentRooms["2"]
local Key = Room:FindFirstChild("KeyObtain", true)
local Door = Room:FindFirstChild("Door")

if Key then

    WalkPosition(Key.Hitbox.Position)
    fireproximityprompt(Key:FindFirstChild("ModulePrompt", true))

    SendNotify("Got the key, opening the door...")

    Door.Lock.CanCollide = false
    WalkPosition(Door.Lock.Position)
    fireproximityprompt(Door:FindFirstChild("UnlockPrompt", true))

else
    SendNotify("No key in this room, going straight to the door...")

    Door.Lock.CanCollide = false
    WalkPosition(Door.Lock.Position)
    fireproximityprompt(Door:FindFirstChild("UnlockPrompt", true))
end

if replicatesignal then
	replicatesignal(LocalPlayer.Kill)
else
	SendNotify("Please wait around 20 seconds to die")
	RemotesFolder.Underwater:FireServer(true)
end

LocalPlayer:GetAttributeChangedSignal("Alive"):Wait()
SendNotify("Player has died, joining a new run...")

RemotesFolder.PlayAgain:FireServer()
QueueTeleport(TeleportCode)
