local KillQueue = {}

local CFrames = {
	["AK-47"] = CFrame.new(-933.276184, 94.1287842, 2056.50757, 0.00427169399, 7.74807063e-08, 0.99999094, -1.15140981e-08, 1, -7.74322473e-08, -0.99999094, -1.11832286e-08, 0.00427169399),
	["Remington 870 (Guard)"] = CFrame.new(826.941101, 99.9900055, 2255.91968, 0.999999702, -1.98958556e-08, -0.000784283737, 1.99129744e-08, 1, 2.18187655e-08, 0.000784283737, -2.18343761e-08, 0.999999702),
	["Remington 870 (Criminal)"] = CFrame.new(-945.207703, 94.1287842, 2056.38037, 0.00967568532, 7.7783227e-08, 0.99995321, -1.45837564e-08, 1, -7.76457512e-08, -0.99995321, -1.38317979e-08, 0.00967568532),
	["M9"] = CFrame.new(821.475525, 99.9899826, 2255.04858, 0.999646246, 4.7205595e-09, 0.0265972149, -1.96314676e-09, 1, -1.03699101e-07, -0.0265972149, 1.03610205e-07, 0.999646246),
	["M4A1"] = CFrame.new(854.068359, 99.9900055, 2254.83936, 0.999996901, -1.25656943e-08, 0.00236702268, 1.26199131e-08, 1, -2.2888921e-08, -0.00236702268, 2.29187176e-08, 0.999996901),
	["Riot Shield"] = CFrame.new(849.428223, 99.9900055, 2254.85425, 0.999885798, -1.29644135e-08, -0.0151139488, 1.26199131e-08, 1, -2.2888921e-08, 0.0151139488, 2.26955699e-08, 0.999885798),
	["Criminal Base"] = CFrame.new(-924.982788, 95.1273117, 2138.22974, -0.01514115, 4.4389445e-08, -0.999885559, -5.0008893e-08, 1, 4.51518147e-08, 0.999885559, 5.0686797e-08, -0.01514115),
	["Yard"] = CFrame.new(776.431519, 98.1899414, 2524.91895, -0.999886036, 3.67849466e-08, 0.0150980083, 3.62649537e-08, 1, -3.47149403e-08, -0.0150980083, -3.41634525e-08, -0.999886036),
	["Cells"] = CFrame.new(916.90564, 99.9899902, 2409.95752, -0.999995172, 2.05472812e-08, 0.00306595769, 2.0416083e-08, 1, -4.28221298e-08, -0.00306595769, -4.27593214e-08, -0.999995172),
	["Cafeteria"] = CFrame.new(916.262207, 99.9899826, 2344.8064, 0.999993801, 1.63763625e-09, -0.00352707505, -1.96196814e-09, 1, -9.19514562e-08, 0.00352707505, 9.19578014e-08, 0.999993801),
	["Cafeteria Kitchen"] = CFrame.new(963.562683, 99.9899597, 2240.49658, 0.695446253, -2.97293532e-08, 0.7185781, 3.57168695e-08, 1, 6.80537626e-09, -0.7185781, 2.09325854e-08, 0.695446253),
	["Guard Armory"] = CFrame.new(836.457947, 99.9900055, 2283.51123, 0.999959648, 1.02565195e-07, -0.00900303945, -1.02191713e-07, 1, 4.19438209e-08, 0.00900303945, -4.10221013e-08, 0.999959648),
	["Prison Gate"] = CFrame.new(487.016022, 98.1900101, 2247.58813, 0.0244596694, 5.71806567e-08, 0.999700844, 2.62643685e-08, 1, -5.78403778e-08, -0.999700844, 2.76712662e-08, 0.0244596694),
	["Car Spawn (Criminal)"] = CFrame.new(-909.68158, 95.1273117, 2152.95068, -0.999859512, 1.75644388e-08, 0.016758915, 1.74348305e-08, 1, -7.87971288e-09, -0.016758915, -7.5864186e-09, -0.999859512),
	["Car Spawn (City) 1"] = CFrame.new(-529.096924, 54.5750389, 1776.43274, 0.59292084, -5.12499874e-08, -0.805260777, -3.84759282e-08, 1, -9.19741439e-08, 0.805260777, 8.55165396e-08, 0.59292084),
	["Car Spawn (City) 2"] = CFrame.new(-195.717926, 54.5750237, 1879.81824, -0.0522688404, -1.89185076e-08, -0.998633087, -2.29093402e-08, 1, -1.77453181e-08, 0.998633087, 2.1950493e-08, -0.0522688404),
	["Freeway Hideout"] = CFrame.new(-78.9059448, 11.2191191, 1343.09668, 0.0444511548, 1.49661687e-08, 0.999011576, 8.75487345e-08, 1, -1.88764702e-08, -0.999011576, 8.83012774e-08, 0.0444511548),
}

local Loops = {
	PlayerChatted = nil
}

local LPlayer = game.Players.LocalPlayer;
local stateType = Enum.HumanoidStateType

local character = LPlayer.Character
local humanoid = character:WaitForChild("Humanoid")

humanoid:SetStateEnabled(stateType.FallingDown, false)
humanoid:SetStateEnabled(stateType.Ragdoll, false)
local M = LPlayer:GetMouse()
local Replic = game.ReplicatedStorage;

function GiveItem(Name)
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver[Name].ITEMPICKUP)
end

function Notification(Text)
	local Tooltip = LPlayer.PlayerGui.Home.hud.AddedGui.tooltip;
	Tooltip.Visible = true;
	Tooltip.BackgroundTransparency = 0.25;
	Tooltip.TextLabel.TextTransparency = 0;
	Tooltip.ImageLabel.ImageTransparency = 0.41;
	Tooltip.TextLabel.ZIndex = 10;
	Tooltip.TextLabel.Text = Text;
	delay(3, function()
		game:GetService("TweenService"):Create(Tooltip.ImageLabel, TweenInfo.new(1.5), {
			ImageTransparency = 1
		}):Play()
		game:GetService("TweenService"):Create(Tooltip.TextLabel, TweenInfo.new(1.5), {
			TextTransparency = 1
		}):Play()
		game:GetService("TweenService"):Create(Tooltip, TweenInfo.new(1.5), {
			BackgroundTransparency = 1
		}):Play()
	end)
end

function Chat(Text, Whisper)
	if Whisper then
		Replic.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w " .. Whisper.Name .. " " .. Text, "All")
	else
		Replic.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Text, "All")
	end
end

function ClientChat(Text, Colors, Size, Font)
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = Text,
		Color = Colors or Color3.fromRGB(255, 255, 255),
		Font = Enum.Font[Font] or Enum.Font.Code,
		FontSize = Size or Enum.FontSize.Size48
	})
end

function TeamEvent(Team)
	workspace.Remote.TeamEvent:FireServer(Team)
end

function Goto(CF)
	LPlayer.Character.HumanoidRootPart.CFrame = CF;
end

function GetPos(Plr)
	if Plr then
		return workspace[Plr.Name].HumanoidRootPart.CFrame;
	end;
	return LPlayer.Character.HumanoidRootPart.CFrame;
end

function LoadChr(Team)
	return workspace.Remote.loadchar:InvokeServer(nil, Team)
end

function GetTeam()
	return game.Players.LocalPlayer.TeamColor.Name
end

function GetCamPos()
	return workspace.CurrentCamera.CFrame
end

function Respawn()
	local GunsHad = {}
	for i, Tool in pairs(LPlayer.Backpack) do
		if Tool:FindFirstChild("GunStates") then
			table.insert(GunsHad, Tool.Name)
		end
	end
	for i, Tool in pairs(LPlayer.Character) do
		if Tool:FindFirstChild("GunStates") then
			table.insert(GunsHad, Tool.Name)
		end
	end
	local OldCF = GetPos()
	local OldCamCF = GetCamPos()
	LoadChr(GetTeam())
	Goto(OldCF)
	workspace.CurrentCamera.CFrame = OldCamCF
	for i, OldTool in pairs(GunsHad) do
		GiveItem(OldTool)
	end
end

function OppositeTeam(Team)
	if Team == "Medium stone grey" then
		return "Bright orange"
	end;
	if Team == "Really red" then
		return "Bright orange"
	end;
	if Team == "Bright blue" then
		return "Bright orange"
	end;
	if Team == "Bright orange" then
		return "Bright blue"
	end;
end


function InfiniteStamina()
	if typeof(getgc) ~= "function" then
		Notification("Your exploit does not have the required function for this.\nRequired function: getgc")
		return
	elseif typeof(debug.getupvalues) ~= "function" then
		Notification("Your exploit does not have the required function for this.\nRequired function: debug.getupvalues")
		return
	elseif typeof(debug.setupvalue) ~= "function" then
		Notification("Your exploit does not have the required function for this.\nRequired function: debug.setupvalue")
		return
	end
	for i, v in next, getgc() do
		if typeof(v) == "function" and getfenv(v).script and tostring(getfenv(v).script) == "ClientInputHandler" then
			for i2, v2 in next, debug.getupvalues(v) do
				if typeof(v2) == "number" then
					debug.setupvalue(v, i2, math.huge)
				end
			end
		end
	end
end
function AntiTaze()
	if typeof(getconnections) ~= "function" then
		Notification("Your exploit does not have the required function for this.\nRequired function: getconnections")
		return
	end
	getconnections(workspace.Remote.tazePlayer.OnClientEvent)[1]:Disable()
end

function AntiArrest()
	workspace.Remote.arrestPlayer.OnClientEvent:Connect(function()
		LPlayer.Character.ClientInputHandler.Disabled = true
		wait(0.5)
		LPlayer.Character.ClientInputHandler.Disabled = false
	end)
end

function GunMod(mod, value)
	for i, v in next, LPlayer.Backpack:GetChildren() do
		if v:IsA("Tool") and v.Name == "AK-47" or v.Name == "Remington 870" or v.Name == "M9" or v.Name == "M4A1" or v.Name == "Taser" then
			require(v.GunStates)[mod] = value
		end
	end
	for i, v in next, LPlayer.Character:GetChildren() do
		if v:IsA("Tool") and v.Name == "AK-47" or v.Name == "Remington 870" or v.Name == "M9" or v.Name == "M4A1" or v.Name == "Taser" then
			require(v.GunStates)[mod] = value
		end
	end
end

function GetPlayer(Stringa)
	local Found = {}
	local strl = Stringa:lower();
	if strl == "all" then
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			table.insert(Found, v)
		end
	elseif strl == "others" then
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name ~= LPlayer.Name then
				table.insert(Found, v)
			end
		end
	elseif strl == "me" then
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name == LPlayer.Name then
				table.insert(Found, v)
			end
		end
	else
		for _, Player in ipairs(game.Players:GetPlayers()) do
			if string.lower(Player.Name):match(string.lower(Stringa)) or string.lower(Player.DisplayName):match(string.lower(Stringa)) then
				table.insert(Found, Player)
			end
		end
		Found = {
			Found[1]
		};
	end
	return Found    
end

function Teleport(Player, Position)
	if Player == nil or Position == nil or Player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
		return
	end
	local savedcf = GetPos()
	workspace.Remote.loadchar:InvokeServer()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
	local CHAR = game.Players.LocalPlayer.Character
	CHAR.Humanoid.Name = "1"
	local c = CHAR["1"]:Clone()
	c.Name = "Humanoid"
	c.Parent = CHAR
	CHAR["1"]:Destroy()
	game.Workspace.CurrentCamera.CameraSubject = CHAR
	CHAR.Animate.Disabled = true
	wait()
	CHAR.Animate.Disabled = false
	CHAR.Humanoid.DisplayDistanceType = "None"
	game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("M9").Parent = CHAR
	local STOP = 0
	repeat
		wait(.1)
		STOP = STOP + 1
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0.75)
	until (not game.Players.LocalPlayer.Character:FindFirstChild("M9") or not game.Players.LocalPlayer.Character.HumanoidRootPart or not Player.Character.HumanoidRootPart or not game.Players.LocalPlayer.Character.HumanoidRootPart.Parent or not Player.Character.HumanoidRootPart.Parent or STOP > 500) and STOP > 3
	local STOP_2 = 0
	repeat
		wait()
		STOP_2 = STOP_2 + 1
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
	until STOP_2 > 10
	workspace.Remote.loadchar:InvokeServer()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
end

function MeleeKill(Player)
	workspace.Remote.ItemHandler:InvokeServer(workspace["Prison_ITEMS"].single["Crude Knife"].ITEMPICKUP)
	repeat wait() until LPlayer.Backpack:FindFirstChild("Crude Knife") or LPlayer.Character:FindFirstChild("Crude Knife")
	local tbl_main = 
	{
      Player, 
      LPlayer.Backpack["Crude Knife"]
	}

	for i=1,10 do
		Replic.meleeEvent:FireServer(unpack(tbl_main))
	end
end

function TeleportV(Player, Player2)
	if Player == nil or Player2 == nil or Player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
		return
	end
	local savedcf = GetPos()
	workspace.Remote.loadchar:InvokeServer()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
	local CHAR = game.Players.LocalPlayer.Character
	CHAR.Humanoid.Name = "1"
	local c = CHAR["1"]:Clone()
	c.Name = "Humanoid"
	c.Parent = CHAR
	CHAR["1"]:Destroy()
	game.Workspace.CurrentCamera.CameraSubject = CHAR
	CHAR.Animate.Disabled = true
	wait()
	CHAR.Animate.Disabled = false
	CHAR.Humanoid.DisplayDistanceType = "None"
	game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("M9").Parent = CHAR
	local STOP = 0
	repeat
		wait(.1)
		STOP = STOP + 1
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0.75)
	until (not game.Players.LocalPlayer.Character:FindFirstChild("M9") or not game.Players.LocalPlayer.Character.HumanoidRootPart or not Player.Character.HumanoidRootPart or not game.Players.LocalPlayer.Character.HumanoidRootPart.Parent or not Player.Character.HumanoidRootPart.Parent or STOP > 500) and STOP > 3
	local STOP_2 = 0
	repeat
		wait()
		STOP_2 = STOP_2 + 1
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Player2.Character.HumanoidRootPart.CFrame
	until STOP_2 > 10
	workspace.Remote.loadchar:InvokeServer()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
end

function CreateBeam(Player, Distance, Position)
	if Player then
		pcall(function()
			local Backpack = game.Players.LocalPlayer.Backpack
			local Character = game.Players.LocalPlayer.Character
			local Gun = Backpack:FindFirstChild("Remington 870") or Character:FindFirstChild("Remington 870")
			if not Gun then
				workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
			end
			Gun = Backpack:FindFirstChild("Remington 870") or Character:FindFirstChild("Remington 870")
			local Head = Player.Character.Head
			if Head and Player and Character and Backpack and Gun and Distance and Position then
				game.ReplicatedStorage.ShootEvent:FireServer({
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					}
				}, Gun)
			end
			Gun.Parent = game.Players.LocalPlayer.Character
			LPlayer.Character.Humanoid:UnequipTools()
			game.Players.LocalPlayer.Backpack:FindFirstChild("Remington 870"):Destroy()
		end)
	end
end

function CreateBeam2(Player, Distance, Position)
	if Player then
		pcall(function()
			local Backpack = game.Players.LocalPlayer.Backpack
			local Character = game.Players.LocalPlayer.Character
			local Gun = Backpack:FindFirstChild("AK-47") or Character:FindFirstChild("AK-47")
			if not Gun then
				workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
			end
			Gun = Backpack:FindFirstChild("AK-47") or Character:FindFirstChild("AK-47")
			local Head = Player.Character.Head
			if Head and Player and Character and Backpack and Gun and Distance and Position then
				game.ReplicatedStorage.ShootEvent:FireServer({
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
				}, Gun)
			end
			Gun.Parent = game.Players.LocalPlayer.Character
			LPlayer.Character.Humanoid:UnequipTools()
			game.Players.LocalPlayer.Backpack:FindFirstChild("AK-47"):Destroy()
		end)
	end
end
 
function CreateBeam3(Player, Distance, Position)
	if Player then
		pcall(function()
			local Backpack = game.Players.LocalPlayer.Backpack
			local Character = game.Players.LocalPlayer.Character
			local Gun = Backpack:FindFirstChild("M9") or Character:FindFirstChild("M9")
			if not Gun then
				workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
			end
			Gun = Backpack:FindFirstChild("M9") or Character:FindFirstChild("M9")
			local Head = Player.Character.Head
			if Head and Player and Character and Backpack and Gun and Distance and Position then
				game.ReplicatedStorage.ShootEvent:FireServer({
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					},
					{
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Distance"] = Distance,
						["Cframe"] = Position,
						["Hit"] = Head
					}
				}, Gun)
			end
		end)
	end
end

function Beam(Player, Distance, Time)
	if Player and Distance then
		local RunService = game:GetService("RunService")
		RunService:BindToRenderStep(Player.Name, math.huge, function()
			coroutine.wrap(function()
				CreateBeam(Player, Distance, Player.Character.HumanoidRootPart.CFrame)
			end)()
		end)
		delay(Time, function()
			pcall(function()
				RunService:UnbindFromRenderStep(Player.Name)
			end)
		end)
	end
end
 
function LagBeam(Player, Distance, Time)
	if Player and Distance then
		local RunService = game:GetService("RunService")
		RunService:BindToRenderStep(Player.Name, math.huge, function()
			coroutine.wrap(function()
				CreateBeam(Player, Distance, Player.Character.HumanoidRootPart.CFrame)
			end)()
			coroutine.wrap(function()
				CreateBeam2(Player, Distance, Player.Character.HumanoidRootPart.CFrame)
			end)()
			coroutine.wrap(function()
				CreateBeam3(Player, Distance, Player.Character.HumanoidRootPart.CFrame)
			end)()
		end)
		delay(Time, function()
			pcall(function()
				RunService:UnbindFromRenderStep(Player.Name)
			end)
		end)
	end
end

function MeleeEvent(Plr)
	Replic.meleeEvent:FireServer(Plr);
end

function OldKill(Player)
	local HadGun = true;
	local MyTeam = GetTeam()
	local MyPos = GetPos()
	local MyCamPos = GetCamPos()
	TeamEvent("Medium stone grey")
	Goto(MyPos)
	workspace.CurrentCamera.CFrame = MyCamPos;
	pcall(function()
		local Gun = game.Players.LocalPlayer.Character:FindFirstChild("Remington 870") or game.Players.LocalPlayer.Backpack:FindFirstChild("Remington 870")
		if Gun == nil then
			GiveItem("Remington 870");
			HadGun = false;
		end;
		Gun = game.Players.LocalPlayer.Character:FindFirstChild("Remington 870") or game.Players.LocalPlayer.Backpack:FindFirstChild("Remington 870")
		local FireEvent = {
			[1] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			},
			[2] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			},
			[3] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			},
			[4] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			},
			[5] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			},
			[6] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			},
			[7] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			},
			[8] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
				["Distance"] = 0,
				["Cframe"] = CFrame.new(),
				["Hit"] = Player.Character.Head
			}
		}
		game:GetService("ReplicatedStorage").ShootEvent:FireServer(FireEvent, Gun)
	end)
	TeamEvent(MyTeam)
	Goto(MyPos)
	workspace.CurrentCamera.CFrame = MyCamPos;
end

function GivePlayerTool(Item, Player)
	GiveItem(Item);
	local pos = GetPos()
	local cpos = GetCamPos()
	local lol = GetTeam()
	local stop = false;
	if stop == true then
		return;
	end;
	if workspace.Prison_ITEMS.giver:FindFirstChild(Item) then
		workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver:FindFirstChild(Item).ITEMPICKUP)
		local CHAR = game.Players.LocalPlayer.Character
		CHAR.Humanoid.Name = "1"
		local c = CHAR["1"]:Clone()
		c.Name = "Humanoid"
		c.Parent = CHAR
		CHAR["1"]:Destroy()
		game.Workspace.CurrentCamera.CameraSubject = CHAR
		CHAR.Animate.Disabled = true
		wait()
		CHAR.Animate.Disabled = false
		CHAR.Humanoid.DisplayDistanceType = "None"
		repeat
			wait()
		until LPlayer.Backpack:FindFirstChild(Item) or LPlayer.Character:FindFirstChild(Item)
		if LPlayer.Backpack:FindFirstChild(Item) then
			LPlayer.Backpack[Item].Parent = LPlayer.Character;
		end
		local STOP = 0
		repeat
			wait(.1)
			STOP = STOP + 1
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0.75)
		until (not game.Players.LocalPlayer.Character:FindFirstChild(Item) or not game.Players.LocalPlayer.Character.HumanoidRootPart or not Player.Character.HumanoidRootPart or not game.Players.LocalPlayer.Character.HumanoidRootPart.Parent or not Player.Character.HumanoidRootPart.Parent or STOP > 500) and STOP > 3
		LoadChr(lol)
		wait(0.1)
		Goto(pos)
		workspace.Camera.CFrame = cpos;
		return;
	end
end

function Kill(plr, method)
	local pooTable = {}
	local lolTable = {}
	local pogUsed
	local SavedCF = LPlayer.Character.HumanoidRootPart.CFrame;
	local SavedCamCF = GetCamPos();
	local SavedTeam = GetTeam()
	local vv = GetTeam();
	if KillQueue[plr.UserId] ~= nil or KillQueue[plr.UserId] == true then
		return
	end;
	KillQueue[plr.UserId] = true
	local SwitchedTeams = false;
	local oldcolor = LPlayer.TeamColor.Name
	if LPlayer.TeamColor.Name == plr.TeamColor.Name then
		TeamEvent(OppositeTeam(plr.TeamColor.Name));
		SwitchedTeams = true;
	end;
	if plr.TeamColor.Name == "Medium stone grey" then
		workspace.Remote.TeamEvent:FireServer("Bright blue")
	end;
	local gun = method or "Remington 870"
	local hadthegun = true;
	local gunInstance = LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	if gunInstance == nil then
		hadthegun = false;
	end;
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver[gun].ITEMPICKUP)
	repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	game.ReplicatedStorage.ReloadEvent:FireServer(LPlayer.Backpack[gun] or LPlayer.Character[gun])
	repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	local args = {
		[1] = {
			[1] = {
				["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-392.79403686523, 32.449165344238, 68.263359069824)),
				["Distance"] = 23.821922302246,
				["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.33503723145, 2392.59375), Vector3.new(0.99490803480148, -0.09966829419136, -0.014973159879446)),
				["Hit"] = workspace[plr.Name].Head
			},
			[2] = {
				["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-392.48315429688, 33.763328552246, 69.404510498047)),
				["Distance"] = 23.831678390503,
				["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.37702178955, 2392.6313476563), Vector3.new(0.99450075626373, -0.10315123945475, -0.018112052232027)),
				["Hit"] = workspace[plr.Name].Head
			},
			[3] = {
				["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-393.71801757813, 24.107759475708, 66.369728088379)),
				["Distance"] = 23.773683547974,
				["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.07206726074, 2392.5297851563), Vector3.new(0.99692684412003, -0.077747754752636, -0.0096018556505442)),
				["Hit"] = workspace[plr.Name].Head
			},
			[4] = {
				["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-395.65017700195, 28.086275100708, 51.692462921143)),
				["Distance"] = 23.802883148193,
				["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.19207000732, 2392.0632324219), Vector3.new(0.99570387601852, -0.087735749781132, 0.029601030051708)),
				["Hit"] = workspace[plr.Name].Head
			},
			[5] = {
				["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-395.87457275391, 31.009611129761, 48.184143066406)),
				["Distance"] = 23.82692527771,
				["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.28240203857, 2391.9533691406), Vector3.new(0.99469912052155, -0.095229558646679, 0.038792934268713)),
				["Hit"] = workspace[plr.Name].Head
			}
		},
		[2] = LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun)
	}
	repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	game.ReplicatedStorage.ShootEvent:FireServer(unpack(args))
	repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	game.ReplicatedStorage.ShootEvent:FireServer(unpack(args))
	if SwitchedTeams then
		workspace.Remote.TeamEvent:FireServer(oldcolor)
	end;
	if hadthegun == false then
		--LPlayer.Backpack:FindFirstChild(gun):Destroy()
	end;
	KillQueue[plr.UserId] = nil;
	TeamEvent("Bright orange")
	for i, v in next, LPlayer.Backpack:GetChildren() do
		if v:IsA("Tool") and v.Name == "AK-47" or v.Name == "Remington 870" or v.Name == "M9" or v.Name == "M4A1" or v.Name == "Taser" then
			table.insert(pooTable, v.Name)
			table.insert(lolTable, require(v.GunStates))
		end
	end
	for i, v in next, LPlayer.Character:GetChildren() do
		if v:IsA("Tool") and v.Name == "AK-47" or v.Name == "Remington 870" or v.Name == "M9" or v.Name == "M4A1" or v.Name == "Taser" then
			table.insert(pooTable, v.Name)
			table.insert(lolTable, require(v.GunStates))
			pogUsed = v.Name;
		end
	end
	if SavedTeam == "Medium stone grey" then
		TeamEvent("Bright orange")
	end;
	workspace.Remote.TeamEvent:FireServer(BrickColor.new(SavedTeam).Name)
	wait()
	--LPlayer.Character.ForceField:Destroy();
	if SavedTeam == "Really red" then
		Goto(CFrames["Criminal Base"])
	end;
	wait()
	--LPlayer.Character.HumanoidRootPart.CFrame = SavedCF;
	--workspace.Camera.CFrame = SavedCamCF;
	for i, v in pairs(pooTable) do
		GiveItem(v)
		repeat
			wait()
		until LPlayer.Backpack:FindFirstChild(v) or LPlayer.Character:FindFirstChild(v)
		if pogUsed == v then
			if LPlayer.Backpack:FindFirstChild(v) then
				LPlayer.Backpack:FindFirstChild(v).Parent = LPlayer.Character
			end
		end
	end
end

function KillArray(plrs, method)
	local pooTable = {}
	local lolTable = {}
	local pogUsed
	local SavedCF = LPlayer.Character.HumanoidRootPart.CFrame;
	local SavedCamCF = GetCamPos();
	local SavedTeam = GetTeam()
	local vv = GetTeam();
	--[[if KillQueue[plr.UserId] ~= nil or KillQueue[plr.UserId] == true then
		return
	end;]]
	--[[KillQueue[plr.UserId] = true]]
	local SwitchedTeams = false;
	local oldcolor = LPlayer.TeamColor.Name
	if plr.TeamColor.Name == "Medium stone grey" then
		workspace.Remote.TeamEvent:FireServer("Bright blue")
	end;
	local gun = method or "Remington 870"
	local hadthegun = true;
	local gunInstance = LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	if gunInstance == nil then
		hadthegun = false;
	end;
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver[gun].ITEMPICKUP)
	repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	game.ReplicatedStorage.ReloadEvent:FireServer(LPlayer.Backpack[gun] or LPlayer.Character[gun])
	repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
	for _,plr in pairs(plrs) do
		if LPlayer.TeamColor.Name == plr.TeamColor.Name then
		TeamEvent(OppositeTeam(plr.TeamColor.Name));
		SwitchedTeams = true;
	end;
		if plr.TeamColor.Name == "Medium stone grey" then
		workspace.Remote.TeamEvent:FireServer("Bright blue")
	end;
	    local args = {
			[1] = {
				[1] = {
					["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-392.79403686523, 32.449165344238, 68.263359069824)),
					["Distance"] = 23.821922302246,
					["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.33503723145, 2392.59375), Vector3.new(0.99490803480148, -0.09966829419136, -0.014973159879446)),
					["Hit"] = workspace[plr.Name].Head
				},
				[2] = {
					["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-392.48315429688, 33.763328552246, 69.404510498047)),
					["Distance"] = 23.831678390503,
					["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.37702178955, 2392.6313476563), Vector3.new(0.99450075626373, -0.10315123945475, -0.018112052232027)),
					["Hit"] = workspace[plr.Name].Head
				},
				[3] = {
					["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-393.71801757813, 24.107759475708, 66.369728088379)),
					["Distance"] = 23.773683547974,
					["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.07206726074, 2392.5297851563), Vector3.new(0.99692684412003, -0.077747754752636, -0.0096018556505442)),
					["Hit"] = workspace[plr.Name].Head
				},
				[4] = {
					["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-395.65017700195, 28.086275100708, 51.692462921143)),
					["Distance"] = 23.802883148193,
					["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.19207000732, 2392.0632324219), Vector3.new(0.99570387601852, -0.087735749781132, 0.029601030051708)),
					["Hit"] = workspace[plr.Name].Head
				},
				[5] = {
					["RayObject"] = Ray.new(Vector3.new(888.39965820313, 101.48999023438, 2388.4970703125), Vector3.new(-395.87457275391, 31.009611129761, 48.184143066406)),
					["Distance"] = 23.82692527771,
					["Cframe"] = CFrame.new(Vector3.new(875.65051269531, 102.28240203857, 2391.9533691406), Vector3.new(0.99469912052155, -0.095229558646679, 0.038792934268713)),
					["Hit"] = workspace[plr.Name].Head
				}
			},
			[2] = LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun)
		}
		repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
		game.ReplicatedStorage.ShootEvent:FireServer(unpack(args))
		repeat wait() until LPlayer.Backpack:FindFirstChild(gun) or LPlayer.Character:FindFirstChild(gun);
		game.ReplicatedStorage.ShootEvent:FireServer(unpack(args))
		if SwitchedTeams then
			workspace.Remote.TeamEvent:FireServer(oldcolor)
		end;
		if hadthegun == false then
			--LPlayer.Backpack:FindFirstChild(gun):Destroy()
		end;
		KillQueue[plr.UserId] = nil;
	end
	TeamEvent("Bright orange")
	for i, v in next, LPlayer.Backpack:GetChildren() do
		if v:IsA("Tool") and v.Name == "AK-47" or v.Name == "Remington 870" or v.Name == "M9" or v.Name == "M4A1" or v.Name == "Taser" then
			table.insert(pooTable, v.Name)
			table.insert(lolTable, require(v.GunStates))
		end
	end
	for i, v in next, LPlayer.Character:GetChildren() do
		if v:IsA("Tool") and v.Name == "AK-47" or v.Name == "Remington 870" or v.Name == "M9" or v.Name == "M4A1" or v.Name == "Taser" then
			table.insert(pooTable, v.Name)
			table.insert(lolTable, require(v.GunStates))
			pogUsed = v.Name;
		end
	end
	if SavedTeam == "Medium stone grey" then
		TeamEvent("Bright orange")
	end;
	workspace.Remote.TeamEvent:FireServer(BrickColor.new(SavedTeam).Name)
	wait()
	--LPlayer.Character.ForceField:Destroy();
	if SavedTeam == "Really red" then
		Goto(CFrames["Criminal Base"])
	end;
	wait()
	--LPlayer.Character.HumanoidRootPart.CFrame = SavedCF;
	--workspace.Camera.CFrame = SavedCamCF;
	for i, v in pairs(pooTable) do
		GiveItem(v)
		repeat
			wait()
		until LPlayer.Backpack:FindFirstChild(v) or LPlayer.Character:FindFirstChild(v)
		if pogUsed == v then
			if LPlayer.Backpack:FindFirstChild(v) then
				LPlayer.Backpack:FindFirstChild(v).Parent = LPlayer.Character
			end
		end
	end
end

function Punish(Target)
	Teleport(Target, CFrame.new(9e9, 9e9, 9e9))
end

return {
  KillPlayer = Kill;
  TeleportPlayerTo = Teleport;
  Goto = Goto;
  GetPos = GetPos;
  Respawn = Respawn;
  ModGuns = GunMod;
  Locations = CFrames;
  Notif = Notification;
  GetTeam = GetTeam;
  LoadChr = LoadChr;
  GiveItem = GiveItem;
  KArray = KillArray;
}
