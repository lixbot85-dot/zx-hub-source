
--[[
	||ZXhub
        || version: 1.0.9
        || Brazil-Exclusive script
        || Redzlib
        || Build: 444
        || Versão final
]]

local Script_Unfinished = false
local Skip_load = true
--// Services \\--
print("[ OK ] | Loading things...")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local player = Players.LocalPlayer
local PlaceId_1 = game.PlaceId
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaLandy/Scripts/refs/heads/main/NotificationSystemV2/Main.lua"))()
local TextChatService = game:GetService("TextChatService")
local Character = Players.LocalPlayer.Character
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

--//BlackList\\--

if player.Name == "Rafael22ricado" then
	print("[ RESTART ] | User is blacklisted.")
	Notification("Fatal Error", "Script não pode ser usado devido ao seu IP.", 5, 4590657391)
	return
elseif player.Name == "ROBLOX" then
	print("[ RESTART ] | Roblox detected.")
	Notification("Fatal Error", "", 5, 4590657391)
	return
elseif player.Name == "minecine_7" then
	print("[ RESTART ] | minecine is blocked.")
	Notification("Fatal Error", "", 5, 4590657391)
	return
end
--// PreLoader \\--

local function PreLoadSound(ID)
	local Test = Instance.new("Sound")
	Test.SoundId = "rbxassetid://" .. ID
	while Test.Loaded == false do
	end
	repeat return until Test.Loaded == true

	Notification("Loader", "Som carregado!", 5, 4590657391)
	Test:Destroy()
end

--//Script LOCKER\\--

if Script_Unfinished == true then
	print("[ RESTART ] | Unfinished.")
	Notification("Fatal Error", "Script está fechado.", 5, 4590657391)
	return
end

--// URL LOADER\\--

local function Load(url)
	coroutine.wrap(function()
		local success, scriptFunction = pcall(function()
			return loadstring(game:HttpGet(url, true))
		end)

		if success and scriptFunction then
			coroutine.wrap(scriptFunction)() 
		else
			warn("Failed to load script:", scriptFunction)
		end
	end)()
end

--//FrontFlip Options\\--

local Frontflip = Instance.new("StringValue")
Frontflip.Name = "FrontFlipKey"
Frontflip.Parent = game.Players.LocalPlayer
Frontflip.Value = "Z"

print("[ RESTART ] | FrontFlipKey created.")
--//Services2\\--
local function Forsakennotify(Image, Text, Subtext)

end

local function disablePlayerCollision(character)
	if not character then return end

	for _, part in character:GetChildren() do
		if part:IsA("BasePart") then
			-- Cria NoCollisionConstraint para cada player
			for _, otherPlayer in Players:GetPlayers() do
				if otherPlayer ~= player and otherPlayer.Character then
					for _, otherPart in otherPlayer.Character:GetChildren() do
						if otherPart:IsA("BasePart") then
							local noCollision = Instance.new("NoCollisionConstraint")
							noCollision.Part0 = part
							noCollision.Part1 = otherPart
							noCollision.Parent = part
						end
					end
				end
			end
		end
	end
end

local function onPlayerAdded(newPlayer)
	newPlayer.CharacterAdded:Connect(function(newCharacter)
		task.wait(1) -- Espera o personagem carregar completamente

		-- Desativa colisão entre o jogador local e o novo player
		if player.Character then
			for _, part in player.Character:GetChildren() do
				if part:IsA("BasePart") then
					for _, otherPart in newCharacter:GetChildren() do
						if otherPart:IsA("BasePart") then
							local noCollision = Instance.new("NoCollisionConstraint")
							noCollision.Part0 = part
							noCollision.Part1 = otherPart
							noCollision.Parent = part
						end
					end
				end
			end
		end
	end)
end

local function MusicPlayer(ID, Volumeset)
	if ID == "PararOSom" then
		if game.Workspace:FindFirstChild("MusicPlayerZXhub") then
			game.Workspace.MusicPlayerZXhub:Destroy()
		end
	else
		if not game.Workspace:FindFirstChild("MusicPlayerZXhub") then
			local sound = Instance.new("Sound")
			sound.Name = "MusicPlayerZXhub"
			sound.SoundId = "rbxassetid://" .. ID
			sound.Volume = Volumeset
			sound.Looped = true
			sound.Parent = workspace
			sound:Play()
		end
	end
end

local function SfxPlayer(ID, Volumeset, Wait)
	if ID == "PararOSom" then
		if game.Workspace:FindFirstChild("SFXZX") then
			game.Workspace.SFXZX:Destroy()
		end
	else
		if not game.Workspace:FindFirstChild("SFXZX") then
			local sound = Instance.new("Sound")
			sound.Name = "SFXZX"
			sound.SoundId = "rbxassetid://" .. ID
			sound.Volume = Volumeset
			sound.Looped = true
			sound.Parent = workspace
			sound:Play()
			task.wait(Wait)
			sound:Destroy()
		end
	end
end

local function onCharacterAdded(character)
	task.wait(1) -- Espera o personagem carregar completamente
	disablePlayerCollision(character)
end
--// Executor Verify \\--

local executor = "Failed to get executor name"

if syn then
	executor = "Synapse Z"
	print("[ OK ] | Executor detected: Synapse Z.")
elseif Krnl or KRNL then
	executor = "KRNL"
	print("[ OK ] | Executor detected: KRNL.")
elseif Fluxus then
	executor = "Fluxus"
	print("[ OK ] | Executor detected: Fluxus.")
elseif typeof(getexecutorname) == "function" then
	executor = getexecutorname()
elseif typeof(getexecutor) == "function" then
	executor = getexecutor()
elseif typeof(identifyexecutor) == "function" then
	executor = identifyexecutor()
else
	executor = "Cannot Detect Executor"
end

if executor == "Xeno" then
	print("[ NO ] | Executor detected.")
	Notification("Aviso", "Seu executor não tem suporte para Decompilação.", 5, 4590657391)
end
if executor == "Solara" then
	print("[ NO ] | Executor detected.")
	Notification("Aviso", "Seu executor não tem suporte para Decompilação.", 5, 4590657391)
end
if executor == "Trigon" then
	print("[ RESTART ] | Executor detected.")
	Notification("Fatal Error", "Executor não roda esse tipo de script. (ERROR: 001)", 5, 4590657391)
	return
end

--// Load External Scripts \\--
pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/totallynothimplayz/Jd/refs/heads/main/Forsaken%20Kill%20The%20Killers"))()
end)

pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/skibidi399/Forsaken-ultra-instinct-script/refs/heads/main/Script"))()
end)

pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PlutomasterAccount/Forsaken-ESP/refs/heads/main/Forsaken%20ESP%20Plutomaster.lua"))()
end)

--// Utility Functions \\--
local function FrontFlip()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/SHRTRYScriptMANhere/stolenahhfrotflip/refs/heads/main/Flip",true))()
	end)
end

local function SpoofDevice()

	local UserInputService = game:GetService("UserInputService")
	local Network = require(game.ReplicatedStorage.Modules.Network)

	local DeviceSpoof = {}
	local ForcedDevice = "Console" -- change to "Mobile", "Console" or "PC"

	DeviceSpoof.Changed = Instance.new("BindableEvent").Event
	DeviceSpoof.Value = ForcedDevice

	local function ApplySpoof()
		DeviceSpoof.Value = ForcedDevice
		Network:FireServerConnection("SetDevice", "REMOTE_EVENT", ForcedDevice)
	end

	ApplySpoof()

	UserInputService.LastInputTypeChanged:Connect(ApplySpoof)

	while wait() do
		ApplySpoof()
	end

	return DeviceSpoof

end
--// Lists \\--
local KillerList = {"Select"}
local SurvivorList = {"Select"}
local EmoteList = {"Select"}
local BetrayedSkins = {"16thNight1x1x1x1", "Betrayed1x1x1x1", "Champion1x1x1x1", "Christmas1x1x1x1", "Classic1x1x1x1", "Monochrome1x1x1x1", "Timeless1x1x1x1", "Voidbound1x1x1x1", "Player1x1x1x1", "Darkness1x1x1x1", "Eggs1x1x1x1"}
local JohnSkins = {"AllStarJohnDoe", "AnnihilationJohnDoe", "ButcherJohnDoe", "ChristmasJohnDoe", "DemonKingJohnDoe", "Pedro.EXE", "PlayerJohnDoe", "RochasJohnDoe", "ScriptBuilderJohnDoe"}
local C00lkidSkin = {"CupcakesC00l", "Bluudude", "MaskedManC00l", "SaviorC00l", "SchoolC00l", "StrictC00l", "FancyC00l", "PrettyPrincess"}
local Milestone1x4 = {"Milestone25IxIxIxI", "Milestone50IxIxIxI", "Milestone75IxIxIxI", "Milestone100IxIxIxI"}
local MilestoneJason = {"Milestone25Jason", "Milestone50Jason", "Milestone75Jason", "Milestone100Jason"}
local JasonSkins = {"BarberJason", "ArrivalJason", "CombatInitiationJason", "DeepSleepJason", "DeliriousJason", "HitboxAccurateJason", "InsaneStreamerJason", "JobJason", "NyanwolfJason", "PlayerJason", "RetroJason", "VIPJason", "VanityJason"}

--// Verification Functions \\--
local function VerifyKillerFolder()
	Forsakennotify("rbxassetid://71014873973869", "ZXhub", "Uhhh... ESSE SCRIPT está offline no momento.")
	local folder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Killers")
	table.clear(KillerList)
	for _, v in ipairs(folder:GetChildren()) do
		if v:IsA("Folder") then table.insert(KillerList, v.Name) end
	end
end

local function VerifySurvivorFolder()
	Forsakennotify("rbxassetid://71014873973869", "ZXhub", "Uhhh... ESSE SCRIPT está offline no momento.")
	local folder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Survivors")
	table.clear(SurvivorList)
	for _, v in ipairs(folder:GetChildren()) do
		if v:IsA("Folder") then table.insert(SurvivorList, v.Name) end
	end
end

local function VerifyEmoteFolder()
	Forsakennotify("rbxassetid://71014873973869", "ZXhub", "Uhhh... ESSE SCRIPT está offline no momento.")
	local folder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Emotes")
	table.clear(EmoteList)
	for _, v in ipairs(folder:GetChildren()) do
		if v:IsA("Folder") or v:IsA("Animation") or v:IsA("StringValue") then
			table.insert(EmoteList, v.Name)
		end
	end
end

--// Unlock Functions \\--
local function UnlockKiller(name)
	local target = ReplicatedStorage.Assets.Killers:FindFirstChild(name)
	if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end
end

local function UnlockKillerSkin(KillerName, name)
	local target = ReplicatedStorage.Assets.Skins.Killers:FindFirstChild(KillerName):FindFirstChild(name)
	if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end
end

local function UnlockSurvivor(name)
	local target = ReplicatedStorage.Assets.Survivors:FindFirstChild(name)
	if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end
end

local function UnlockEmote(name)
	local target = ReplicatedStorage.Assets.Emotes:FindFirstChild(name)
	if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end
end

local function VerifyAndUnlockEmotes()
	local folder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Emotes")
	table.clear(EmoteList)

	for _, v in ipairs(folder:GetChildren()) do
		if v:IsA("ModuleScript") then
			table.insert(EmoteList, v.Name)
			UnlockEmote(v.Name) -- já desbloqueia
		end
	end
end

--// REDZLIB part \\--
local Window = redzlib:MakeWindow({
	Title = "ZXhub(Build 444)",
	SubTitle = "FORGED IN THE FLAMES OF HELL!11!",
	SaveFolder = "ForsakenUniversalUniversal_1"
})
Window:AddMinimizeButton({
	Button = { Image = "rbxassetid://71014873973869", BackgroundTransparency = 0 },
	Corner = { CornerRadius = UDim.new(35, 1) },
})
local Tab1 = Window:MakeTab({"Botões", "archive"})
local Section = Tab1:AddSection({"Botões(Algums podem quebrar)"})
local Paragraph = Tab1:AddParagraph({"Aviso", "Bem, script foi terminado.\nVai ser apenas atualizado para corrigir erros."})

Tab1:AddButton({"auto-Gerador", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Forsakontol/refs/heads/main/Do%20generator"))()
	end)

end})

Tab1:AddButton({"Anti-moderator", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Forsakontol/refs/heads/main/Anti%20Moderator"))()
	end)

end})

Tab1:AddButton({"INF STAMINA(Funciona em executor de QUALIDADE)", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-INF-Stamina-53084"))()
	end)

end})

local Section = Tab1:AddSection({"Nada aqui :("})

local Tab2 = Window:MakeTab({"Destruição", "axe"})

Tab2:AddButton({"YeetGuiHUB", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-yeet-GUI-2025-edition-49031"))()
	end)

end})

local Tab3 = Window:MakeTab({"Desbloqueadores manuais", "archive"})

Tab3:AddButton({"Wave", function(Value)
	UnlockEmote("Wave")
end})

Tab3:AddButton({"MissTheQuiet", function(Value)
	UnlockEmote("_MissTheQuiet")
	UnlockEmote("MissTheQuiet")
end})

Tab3:AddButton({"Jason", function(Value)
	UnlockKiller("Jason")
end})

Tab3:AddButton({"1x1x1x1", function(Value)
	UnlockKiller("1x1x1x1")
end})

Tab3:AddButton({"JohnDoe", function(Value)
	UnlockKiller("JohnDoe")
	UnlockKiller("Johndoe")
end})

Tab3:AddButton({"C00lkidd", function(Value)
	UnlockKiller("C00lkidd")
	UnlockKiller("C00lkid")
	UnlockKiller("c00lkidd")
	UnlockKiller("c00lkid")
end})

Tab3:AddButton({"Sonic Exe", function(Value)
	UnlockKiller("__KillerSonicexe")
	UnlockKiller("__KillerSonicExe")
	UnlockKiller("#KillerSonicexe")
	UnlockKiller("#KillerSonicExe")
end})

Tab3:AddButton({"Admin killers", function(Value)
	UnlockKiller("##2x2x2x2")
	UnlockKiller("##ForsakenGubby")
	UnlockKiller("##Gubby")
	UnlockKiller("#KillerSonicExe")
	UnlockKiller("TURRON")
end})

Tab3:AddButton({"1x4 milestones", function(Value)
	UnlockKiller("1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Milestone25IxIxIxI")
	UnlockKillerSkin("1x1x1x1", "Milestone50IxIxIxI")
	UnlockKillerSkin("1x1x1x1", "Milestone75IxIxIxI")
	UnlockKillerSkin("1x1x1x1", "Milestone100IxIxIxI")
end})

Tab3:AddButton({"1x4 skins", function(Value)
	UnlockKiller("1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "16thNight1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "1G1G1G1(NEW)")
	UnlockKillerSkin("1x1x1x1", "1x1x1x1IfHedidntlockin")
	UnlockKillerSkin("1x1x1x1", "Betrayed1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Bloodlust")
	UnlockKillerSkin("1x1x1x1", "Champion1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Christmas1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Classic1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Darkness1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Eggs1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Guardian1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Hacklord1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Monochrome1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "OriginalX")
	UnlockKillerSkin("1x1x1x1", "Player1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "PurpleScyth")
	UnlockKillerSkin("1x1x1x1", "SoccerLegend1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Timeless1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "TwoTime1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Voidbound1x1x1x1")
end})

Tab3:AddButton({"John Pork MILESTONES", function(Value)
	UnlockKiller("JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone25JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone50JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone75JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone100JohnDoe")
end})

Tab3:AddButton({"John Pork skins", function(Value)
	UnlockKiller("JohnDoe")
	UnlockKillerSkin("JohnDoe", "25TestJohnDoe")
	UnlockKillerSkin("JohnDoe", "AllStarJohnDoe")
	UnlockKillerSkin("JohnDoe", "AnnihilationJohnDoe")
	UnlockKillerSkin("JohnDoe", "ButcherJohnDoe")
	UnlockKillerSkin("JohnDoe", "ChristmasJohnDoe")
	UnlockKillerSkin("JohnDoe", "DemonKingJohnDoe")
	UnlockKillerSkin("JohnDoe", "ChristmasJohnDoe")
	UnlockKillerSkin("JohnDoe", "DibsJohnDoe")
	UnlockKillerSkin("JohnDoe", "Friend (NEW)")
	UnlockKillerSkin("JohnDoe", "GasharpoonJohnDoe")
	UnlockKillerSkin("JohnDoe", "Jane Doe")
	UnlockKillerSkin("JohnDoe", "JohnDoeIfHeDidntlockIn")
	UnlockKillerSkin("JohnDoe", "Pedro.EXE")
	UnlockKillerSkin("JohnDoe", "PlayerJohnDoe")
	UnlockKillerSkin("JohnDoe", "PoachedJohnDoe")
	UnlockKillerSkin("JohnDoe", "RochasJohnDoe")
	UnlockKillerSkin("JohnDoe", "ScriptBuilderJohnDoe")
end})

Tab3:AddButton({"Jason milestones", function(Value)
	UnlockKiller("Jason")
	UnlockKillerSkin("Jason", "Milestone25Jason")
	UnlockKillerSkin("Jason", "Milestone50Jason")
	UnlockKillerSkin("Jason", "Milestone75Jason")
	UnlockKillerSkin("Jason", "Milestone100Jason")
end})

Tab3:AddButton({"Jason Skins", function(Value)
	UnlockKiller("Jason")
	UnlockKillerSkin("Jason", "AlfredDrevisJason")
	UnlockKillerSkin("Jason", "BarberJason")
	UnlockKillerSkin("Jason", "CombatInitiationJason")
	UnlockKillerSkin("Jason", "CounselorJason")
	UnlockKillerSkin("Jason", "DeadRabbitsJason")
	UnlockKillerSkin("Jason", "DeepSleepJason")
	UnlockKillerSkin("Jason", "DeliriousJason")
	UnlockKillerSkin("Jason", "DevoutJason")
	UnlockKillerSkin("Jason", "EasterRipperJason")
	UnlockKillerSkin("Jason", "HitboxAccurateJason")
	UnlockKillerSkin("Jason", "InsaneStreamerJason")
	UnlockKillerSkin("Jason", "LeatherfaceJason")
	UnlockKillerSkin("Jason", "LumberJackJason")
	UnlockKillerSkin("Jason", "ManhattanJason")
	UnlockKillerSkin("Jason", "NyanwolfJason")
	UnlockKillerSkin("Jason", "PartyJason")
	UnlockKillerSkin("Jason", "RetroJason")
	UnlockKillerSkin("Jason", "VIPJason")
	UnlockKillerSkin("Jason", "VanityJason")
	UnlockKillerSkin("Jason", "WeightsonJorthees")
end})

Tab3:AddButton({"Emotes", function(Value)
	UnlockEmote("AintNoLovinMyMan")
	UnlockEmote("AolGuy")
	UnlockEmote("AshleyLookAtMe")
	UnlockEmote("Assumptions")
	UnlockEmote("BagUp")
	UnlockEmote("Brickbattler")
	UnlockEmote("CCShimmy")
	UnlockEmote("CaliforniaGirls")
	UnlockEmote("Caramell")
	UnlockEmote("DistractionDance")
	UnlockEmote("Drumsticks")
	UnlockEmote("Eggrolled")
	UnlockEmote("GangnamStyle")
	UnlockEmote("Griddy")
	UnlockEmote("HakariDance")
	UnlockEmote("Headbanger")
	UnlockEmote("Hero")
	UnlockEmote("HeyNow")
	UnlockEmote("Hotdog")
	UnlockEmote("Houdini")
	UnlockEmote("Insanity")
	UnlockEmote("JumpingForJoy")
	UnlockEmote("Jumpstyle")
	UnlockEmote("KazotskyKick")
	UnlockEmote("Khaled")
	UnlockEmote("Locked")
	UnlockEmote("MonsterMash")
	UnlockEmote("OppaGangnam")
	UnlockEmote("PYT")
	UnlockEmote("Poisoned")
	UnlockEmote("PopDance")
	UnlockEmote("Prince")
	UnlockEmote("Schadenfreude")
	UnlockEmote("Silly")
	UnlockEmote("Skeleton")
	UnlockEmote("SoRetro")--
	UnlockEmote("StockDance")
	UnlockEmote("SubjectThree")
	UnlockEmote("Sukuna")
	UnlockEmote("TwoTwoTwo")
	UnlockEmote("Wait")
	UnlockEmote("_SillyBilly")
end})

Tab3:AddTextBox({
	Name = "Comprar Killer",
	Description = "Compre os personagems", 
	PlaceholderText = "Nome da pasta do KILLER",
	Callback = function(Value)
		UnlockKiller(Value)
	end
})

Tab3:AddTextBox({
	Name = "Comprar Emote",
	Description = "Compre os personagems", 
	PlaceholderText = "Nome da pasta do KILLER",
	Callback = function(Value)
		UnlockEmote(Value)
	end
})

Tab3:AddTextBox({
	Name = "Comprar Survivor",
	Description = "Compre os personagems", 
	PlaceholderText = "Nome da pasta do KILLER",
	Callback = function(Value)
		UnlockSurvivor(Value)
	end
})
--[[local function UpdateMusic()

	if game.workspace.Themes.Lobby then
		if LobbyTheme == "ScriptShowCase" then
			game.workspace.Themes.Lobby.SoundId = "rbxassetid://132391713003461"
			game.workspace.Themes.Lobby.Playing = true
		end
		if LobbyTheme == "Chinese" then
			game.workspace.Themes.Lobby.SoundId = "rbxassetid://1845974783"
			game.workspace.Themes.Lobby.Playing = true
		end
		if LobbyTheme == "Sans" then
			game.workspace.Themes.Lobby.SoundId = "rbxassetid://78368445861935"
			game.workspace.Themes.Lobby.Playing = true
		end
		if LobbyTheme == "Song That Might Play When You Fight Sans" then
			game.workspace.Themes.Lobby.SoundId = "rbxassetid://79583063289850"
			game.workspace.Themes.Lobby.Playing = true
		end
		if LobbyTheme == "UnderfellSans" then
			game.workspace.Themes.Lobby.SoundId = "rbxassetid://101730223568557"
			game.workspace.Themes.Lobby.Playing = true
		end
		if LobbyTheme == "Potential" then
			game.workspace.Themes.Lobby.SoundId = "rbxassetid://105768067934044"
			game.workspace.Themes.Lobby.Playing = true
		end
		if LobbyTheme == "LegendBowl" then
			game.workspace.Themes.Lobby.SoundId = "rbxassetid://100758335412058"
			game.workspace.Themes.Lobby.Playing = true
		end
	end

	if game.workspace.Themes.LastManStanding then

		if LMSTheme == "You're mine!" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://131581569937863"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "Song That Might Play When You Fight Sans" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://79583063289850"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "Potential" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://105768067934044"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "Memorial" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://101233497282609"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "FootballFunk" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://110470226407626"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "RAGE" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://102511771666136"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "BRISA RETOLAM" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://139810673145941"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "Awakened" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://81193288411086"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "FeelsGood" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://73898672682890"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "RetroLMS" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://94242094804130"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "DayDream" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://120361722061939"
			game.workspace.Themes.LastManStanding.Playing = true
		end
		if LMSTheme == "FrozenHeart" then
			game.workspace.Themes.LastManStanding.SoundId = "rbxassetid://83045703457176"
			game.workspace.Themes.LastManStanding.Playing = true
		end
	end

end]]


local Tab6 = Window:MakeTab({"Preciso", "cherry"})

Tab6:AddButton({"Fechar YEETGUI", function(Value)
	Forsakennotify("rbxassetid://71014873973869", "ZXhub", "Isso está quebrado.")
	if script.parent.YeetGui then
		script.parent.YeetGui:Destroy()
	end
end})

Tab6:AddButton({"Executor", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/dnezero/zeroware/refs/heads/main/_"))()
	end)
end})

Tab6:AddButton({"ZxAdmin(Pastebin)", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://pastebin.com/raw/6kBCQBqL"))()
	end)
end})

Tab6:AddButton({"ZxAdmin(ScriptBlox)", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-ZxAdmin-54163"))()
	end)
end})

Tab6:AddButton({"Dex Explorer", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end)
end})

Tab6:AddButton({"Infinite Yield(Modificado)", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-IY-UniversalForsaken-support-51625"))()
	end)
end})

Tab6:AddButton({"AnimationSpy(Procurar animação)", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/17kShotsss/AnimationSpy/refs/heads/main/AnimationSpy.lua"))()
	end)
end})

Tab6:AddButton({"", function(Value)

end})

--//MusicPlayer\\--
local VolumeSet = 5
local Tab7 = Window:MakeTab({"Música", "cherry"})
local MusicList = {"PararOSom", "132391713003461", "79583063289850", "78368445861935", "94242094804130", "110470226407626", "102511771666136"}

Tab7:AddDiscordInvite({
	Name = "Club Dz7 RBX",
	Description = "Servidor da fonte de algums sons",
	Logo = "rbxassetid://186880204",
	Invite = "https://discord.gg/RUy63fAPfF",
})

Tab7:AddButton({"Parar a música", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
end})

local Dropdown = Tab7:AddDropdown({
	Name = "",
	Description = "Toca o tema que você deseja",
	Options = MusicList,
	Default = "PararOSom",
	Flag = "Dropdown MusicPlayer",
	Callback = function(Value)
		MusicPlayer("PararOSom", VolumeSet)
		MusicPlayer(Value, VolumeSet)
	end
})

Tab7:AddTextBox({
	Name = "Volume",
	Description = "Mude volume do MusicPlayer", 
	PlaceholderText = "Volume do som",
	Callback = function(Value)
		VolumeSet = Value
		if game.Workspace:FindFirstChild("MusicPlayerZXhub") then
			game.Workspace.MusicPlayerZXhub.Volume = Value
		end
	end
})

Tab7:AddTextBox({
	Name = "Pitch(Não salva)",
	Description = "Mude o Playback do MusicPlayer", 
	PlaceholderText = "Playback",
	Callback = function(Value)
		if game.Workspace:FindFirstChild("MusicPlayerZXhub") then
			game.Workspace.MusicPlayerZXhub.Pitch = Value
		end
	end
})

local Section = Tab7:AddSection({"Soundtrack(In-game themes)"})

Tab7:AddButton({"LastManStanding", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer(game.ReplicatedStorage.Assets.Sounds.OST.eternalFight, VolumeSet)
end})

Tab7:AddButton({"YouPoorThing", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer(game.ReplicatedStorage.Assets.Sounds.OST.youPoorThing, VolumeSet)
end})

Tab7:AddButton({"Lobby", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer(game.ReplicatedStorage.Assets.Sounds.OST.lobby, VolumeSet)
end})


local Section = Tab7:AddSection({"Música de NOIA"})

Tab7:AddButton({"Forsaken but not forgotten", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("121896541568175", VolumeSet)
end})

Tab7:AddButton({"Samson", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("82532151247975", VolumeSet)
end})

local Section = Tab7:AddSection({"Novos"})

Tab7:AddButton({"Forsaken In Darkness", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("90848507281830", VolumeSet)
end})

Tab7:AddButton({"BYE BYE", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("89916518452218", VolumeSet)
end})

Tab7:AddButton({"RAGE", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("87429130418599", VolumeSet)
end})

Tab7:AddButton({"Ritual(Two Time)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("92554905493642", VolumeSet)
end})

Tab7:AddButton({"FutureFUNK(BACKDOORED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("95225718699329", VolumeSet)
end})

Tab7:AddButton({"JoyV2(BACKDOORED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("123774349359596", VolumeSet)
end})

Tab7:AddButton({"Emotions(BACKDOORED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("88032446501071", VolumeSet)
end})

Tab7:AddButton({"Penalty(BACKDOORED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("129618861574215", VolumeSet)
end})

Tab7:AddButton({"Dubstep(BACKDOORED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("104581910674582", VolumeSet)
end})

Tab7:AddButton({"Spooky Scary Skeeletons(BACKDOORED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("71956674693421", VolumeSet)
end})

Tab7:AddButton({"Chase Theme(BACKDOORED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("138335406857832", VolumeSet)
end})

Tab7:AddButton({"Cataclysm", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("124460367514427", VolumeSet)
end})

Tab7:AddButton({"Red Buster", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("78097209202274", VolumeSet)
end})

Tab7:AddButton({"NEW BLOOD", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("119435747002780", VolumeSet)
end})

Tab7:AddButton({"ETERNITY", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("94683110091181", VolumeSet)
end})

Tab7:AddButton({"ROAR IN KNIGHT", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("78097209202274", VolumeSet)
end})

Tab7:AddButton({"Cyber's World", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("85230380878710", VolumeSet)
end})

Tab7:AddButton({"Field Of Hopes And Dreams", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("73721603843391", VolumeSet)
end})

Tab7:AddButton({"The World Revolving", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("89967120507744", VolumeSet)
end})

Tab7:AddButton({"The Legend", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("135898180146709", VolumeSet)
end})

Tab7:AddButton({"School", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("85112774535877", VolumeSet)
end})

Tab7:AddButton({"ATHAZAGORAPHOBIA", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("118485807480462", VolumeSet)
end})

Tab7:AddButton({"Green Room", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("76588614620804", VolumeSet)
end})

Tab7:AddButton({"Beginning", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("71180639813631", VolumeSet)
end})

Tab7:AddButton({"Rude Buster(8-bit)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("120441398857133", VolumeSet)
end})

Tab7:AddButton({"Rude Buster(0.16 pitch)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("101924910042557", VolumeSet)
end})

local Section = Tab7:AddSection({"ZXHub Library"})

Tab7:AddButton({"Rude Buster(8-bit)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("120441398857133", VolumeSet)
end})

Tab7:AddButton({"ATHAZAGORAPHOBIA", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("118485807480462", VolumeSet)
end})

Tab7:AddButton({"ETERNITY", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("94683110091181", VolumeSet)
end})

Tab7:AddButton({"SansMUSIC ( Copyrighted ;( )", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("79583063289850", VolumeSet)
end})

Tab7:AddButton({"Bossa Me (a)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("1837768517", VolumeSet)
end})

Tab7:AddButton({"The Greatest (OUTRO)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("140427033214331", VolumeSet)
end})

Tab7:AddButton({"Ghost 12", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("78469849341084", VolumeSet)
end})

Tab7:AddButton({"CHARA", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("70631807399198", VolumeSet)
end})

Tab7:AddButton({"Boss fight 3", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("98069162367799", VolumeSet)
end})

Tab7:AddButton({"Bad Time", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("134453206423714", VolumeSet)
end})

Tab7:AddButton({"ROAR IN KNIGHT", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("78097209202274", VolumeSet)
end})

Tab7:AddButton({"Cyber's World", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("85230380878710", VolumeSet)
end})

Tab7:AddButton({"Field Of Hopes And Dreams", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("73721603843391", VolumeSet)
end})

Tab7:AddButton({"The World Revolving", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("89967120507744", VolumeSet)
end})

Tab7:AddButton({"The Legend", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("135898180146709", VolumeSet)
end})

Tab7:AddButton({"School", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("85112774535877", VolumeSet)
end})

Tab7:AddButton({"Green Room", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("76588614620804", VolumeSet)
end})

Tab7:AddButton({"Beginning", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("71180639813631", VolumeSet)
end})

Tab7:AddButton({"It's T.V TIME! (8-bit)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("135016968989292", VolumeSet)
end})

Tab7:AddButton({"It's T.V TIME! (Tenna)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("95455387850059", VolumeSet)
end})

Tab7:AddButton({"MAXLOVANIA", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("98935140307272", VolumeSet)
end})

Tab7:AddButton({"DUFFED", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("137471713724851", VolumeSet)
end})

Tab7:AddButton({"SkibiLovania (V2)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("81613619555704", VolumeSet)
end})

Tab7:AddButton({"SkibiLovania (Pt 2)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("111127591716814", VolumeSet)
end})

Tab7:AddButton({"SkibiLovania (V1)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("138112823479176", VolumeSet)
end})

Tab7:AddButton({"True Vengeance", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("117012968687265", VolumeSet)
end})

Tab7:AddButton({"Marble Zone", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("131819988986268", VolumeSet)
end})

Tab7:AddButton({"SHUCKSLOVANIA", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("135381080867649", VolumeSet)
end})

Tab7:AddButton({"Alibi", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("124895443026467", VolumeSet)
end})

Tab7:AddButton({"True Color V2", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("113574572597383", VolumeSet)
end})

Tab7:AddButton({"Red Buster", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("78097209202274", VolumeSet)
end})

Tab7:AddButton({"Twiddlefinger", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("110332967959964", VolumeSet)
end})

--110470226407626
Tab7:AddButton({"Funk", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("110470226407626", VolumeSet)
end})

Tab7:AddButton({"All dropping 8 bit Beats", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("9048375035", VolumeSet)
end})

Tab7:AddButton({"Castle in 8 bit", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("9048374858", VolumeSet)
end})

Tab7:AddButton({"Pixel Jungle", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("89091061200191", VolumeSet)
end})

Tab7:AddButton({"Old School Future Tech", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("9045971220", VolumeSet)
end})

Tab7:AddButton({"Anxiety", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("109504331469029", VolumeSet)
end})

Tab7:AddButton({"", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("", VolumeSet)
end})

Tab7:AddButton({"Asriel", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("88808485680832", VolumeSet)
end})

Tab7:AddButton({"Asriel(FNF)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("122406223371111", VolumeSet)
end})

Tab7:AddButton({"Bodypartz", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("127653283576622", VolumeSet)
end})

Tab7:AddButton({"Pac man phonk", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("120889371113999", VolumeSet)
end})

Tab7:AddButton({"GOOD GIRL PHONK", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("116709346800322", VolumeSet)
end})

Tab7:AddButton({"Forsaken PHONK", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("138825474468793", VolumeSet)
end})

Tab7:AddButton({"Forsaken PHONK SLOWED", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("117743970965483", VolumeSet)
end})

Tab7:AddButton({"Gettin' shadown (Friday Night Funkin)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("126935700945530", VolumeSet)
end})

Tab7:AddButton({"Indie cross BADTIME INST (Friday Night Funkin)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("86404519042945", VolumeSet)
end})

Tab7:AddButton({"Dreams (Friday Night Funkin)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("95740246610610", VolumeSet)
end})

Tab7:AddButton({"Nostalgia (Backrooms)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("120817494107898", VolumeSet)
end})

Tab7:AddButton({"Dreamcore", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("86247184974274", VolumeSet)
end})

Tab7:AddButton({"MESMERIZER", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("71934965392436", VolumeSet)
end})

Tab7:AddButton({"Moonlighthood", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("122389825417820", VolumeSet)
end})

Tab7:AddButton({"OFF THE KING (Forró)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("120324849313242", VolumeSet)
end})

Tab7:AddButton({"Schnuffel", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("100697759026652", VolumeSet)
end})

Tab7:AddButton({"Pai (PHONK)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("95046091312570", VolumeSet)
end})

Tab7:AddButton({"Mario (PHONK)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("132311372545619", VolumeSet)
end})

Tab7:AddButton({"Empina na onda", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("104621031886653", VolumeSet)
end})

Tab7:AddButton({"TAKE BACK MY SMILE", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("97378845201983", VolumeSet)
end})

Tab7:AddButton({"PASSO BEM ALTO", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("111318048787674", VolumeSet)
end})

Tab7:AddButton({"Megalovania Remix", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("101598365847186", VolumeSet)
end})

Tab7:AddButton({"Motivação 3", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("110860247960302", VolumeSet)
end})

Tab7:AddButton({"Speedrun song1", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("129898258606289", VolumeSet)
end})

Tab7:AddButton({"Montagem Tomada(SLOWED)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("114727662968481", VolumeSet)
	game.Workspace:FindFirstChild("MusicPlayerZXhub").Pitch = 0.8
end})

Tab7:AddButton({"Montagem Tomada", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("114727662968481", VolumeSet)
end})

Tab7:AddButton({"MONTAGEM SKY HIGH", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("123517126955383", VolumeSet)
end})

Tab7:AddButton({"MONTAGEM Deus do Olimpo", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("83889829891795", VolumeSet)
end})

Tab7:AddButton({"d3r - love bomb", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("18841888868", VolumeSet)
end})

Tab7:AddButton({"Print", function(Value)

end})

local Tab8 = Window:MakeTab({"Options", "brush"})

Tab8:AddButton({"Removedor de Gameplay paused", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gameplay-paused-remover-51882"))() 
	end)

end})

local Tab9 = Window:MakeTab({"Teste", "shieldalert"})
local Section = Tab9:AddSection({"Coisas de teste, esses scripts podem acabar com seu JOGO ou lagar. /nMelhor ir usar as outras opções."})

Tab9:AddButton({"Anti-VOID (Bom para uso de Kill The Killer, NÃO VAI MORRER pelo void.)", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AntiVoid-44167"))()
	end)

end})

Tab9:AddButton({"INF stamina (Test)", function(Value)

	local stamina = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)

	stamina.MaxStamina = 999999
	stamina.Stamina = 999999
	stamina.__staminaChangedEvent:Fire(stamina.Stamina)

end})

Tab9:AddButton({"???", function(Value)

	local stamina = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)

	stamina.MaxStamina = 666
	stamina.Stamina = 666
	stamina.__staminaChangedEvent:Fire(stamina.Stamina)

	SfxPlayer(9080161598, 0.2, 3)

end})

Tab9:AddButton({"Shiftlock (Test)", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-ShiftLock-Universal-Script-51730"))() 
	end)

end})

Tab9:AddButton({"Anti-Void (Test)", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Mobile-friendly-ANTI-VOID-52240"))() 
	end)

end})

Tab9:AddButton({"Adonis anti-cheat bypass(Test)", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua"))() 
	end)

end})

Tab9:AddButton({"Instant-respawn (Test)", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Instant-respawn-42095"))() 
	end)

end})

Tab9:AddButton({"Forsakened (PATCHED e QUEBRADO.)", function(Value)

	if executor == "Xeno" then
		Notification("Aviso", "SEU EXECUTOR não roda esse tipo de SCRIPT.", 5, 4590657391)
	end

	pcall(function()
		loadstring(game:HttpGet("https://pastebin.com/raw/cvQjqMdU"))() 
	end)

end})

local Tab10 = Window:MakeTab({"Hubs", "brush"})

Tab10:AddButton({"Bobby hub", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/BobJunior1/ForsakenBoi/refs/heads/main/B0bbyHub"))() 
	end)

end})

Tab10:AddButton({"FARTSAKEN", function(Value)

	script_key = "KEY"; -- A key might be required, if not, delete this line.
	loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/80b606551d4b7075eb3e229d6f68e4df.lua"))()


end})

local Tab11 = Window:MakeTab({"Forsaken", "brush"})

Tab11:AddButton({"Desativar PlayerList", function(Value)

	local v999 = require(game.ReplicatedStorage.Modules.PlayerList)
	
	v999.TogglePlayerList(false)
	
end})

Tab11:AddButton({"Ativar PlayerList", function(Value)

	local v999 = require(game.ReplicatedStorage.Modules.PlayerList)

	v999.TogglePlayerList(true)

end})

Tab11:AddButton({"MapVote Toggle", function(Value)

	local v999 = require(game.ReplicatedStorage.Modules.MapVoting)

	local l_workspace_Attribute_0 = workspace:GetAttribute("MapVotingEnabled");
	workspace:SetAttribute("MapVotingEnabled", not l_workspace_Attribute_0);
	
end})

Tab11:AddButton({"StartVote MapVote", function(Value)

	local v999 = require(game.ReplicatedStorage.Modules.MapVoting)
	
	v999.StartVote()
end})

local Dropdown = Tab11:AddDropdown({
	Name = "mudar a Velha Hitbox",
	Description = "Power of <font color='rgb(88, 101, 242)'>Hitbox.</font>",
	Options = {"DISABLE", "Poder LV1", "Poder LV2", "Poder LV3", "Poder LV4", "Poder LV5"},
	Default = "DISABLE",
	Flag = "dropdown teste",
	Callback = function(Value)
		local HitboxModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/nexeralt/ForsakenHitboxExtender/refs/heads/main/open%20source.luau"))()
		if Value == "DISABLE" then
			HitboxModule:StopExtendingHitbox()
		end
		if Value == "Poder LV1" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(10, 9e9)
		end
		if Value == "Poder LV2" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(20, 9e9)
		end
		if Value == "Poder LV3" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(30, 9e9)
		end
		if Value == "Poder LV4" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(40, 9e9)
		end
		if Value == "Poder LV5" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(50, 9e9)
		end
		if Value == "Poder LV6" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(60, 9e9)
		end
		if Value == "Poder LV7" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(70, 9e9)
		end
		if Value == "Poder LV8" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(80, 9e9)
		end
		if Value == "Poder LV9" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(90, 9e9)
		end
		if Value == "Poder LV10" then
			HitboxModule:StopExtendingHitbox()
			wait(1)
			HitboxModule:ExtendHitbox(100, 9e9)
		end
	end
})

--// FinalScripts \\--
PreLoadSound(86373709391543)
game.SoundService.Soundtrack.Volume = 0
game.SoundService.SoundEffects.Volume = 0
game.SoundService.Voicelines.Volume = 0
VerifySurvivorFolder()
VerifyEmoteFolder()
VerifyKillerFolder()
if Skip_load == true then
	Notification("Script", "Carregando... ( 0% )", 8, 4590657391)
	wait(10)
	Notification("Script", "FrontFlip carregado! ( 15% )", 3, 4590657391)
	FrontFlip()
	wait(5)
	Notification("Script", " Carregando música...( 20% )", 3, 4590657391)
	PreLoadSound(132721288328532)
	wait(15)
	Notification("Script", " Carregando Modules...( 35% )", 3, 4590657391)
	wait(3)
	Notification("Script", " Esperando resposta dos modules...( 55% )", 3, 4590657391)
	wait(3)
	Notification("Script", " game.replicatedstorage.Modules( 56% )", 5, 4590657391)
	wait(5)
	Notification("Script", " Modules.Icon( 72% )", 3, 4590657391)
	wait(4)
	Notification("Script", " Modules.Hitboxes( 72% )", 3, 4590657391)
	wait(6)
	Notification("Script", " Modules.Sounds( 74% )", 3, 4590657391)
	wait(4)
	Notification("Script", " Modules.Sprite( 78% )", 3, 4590657391)
	wait(8)
	Notification("Script", " Modules.Schematics( 72% )", 3, 4590657391)
	wait(4)
	Notification("Script", " Terminando o script...( 90% )", 3, 4590657391)
	wait(4)
	Notification("Script", " Terminando o script...( 93% )", 3, 4590657391)
	wait(4)
	Notification("Script", " Terminando o script...( 98% )", 3, 4590657391)
	wait(4)
	if Script_Unfinished == true then
		Notification("Script", " Script está incompleto, pode não funcionar corretamente!", 5, 4590657391)
		local Window = redzlib:MakeWindow({
			Title = "ZXhub(BUILD incompleta)",
			SubTitle = "FORGED IN THE FLAMES OF HELL!11!",
			SaveFolder = "ForsakenUniversalUniversal_1"
		})
		return
	end
	Notification("Script", " CARREGADO!11!!( 100% )", 3, 4590657391)
	wait(4)
end
if Skip_load == true then
	FrontFlip()
end
SpoofDevice()
Notification("Aviso", "último Update, só vai ser atualizado para corrigir erros! Script vai ficar com a mesma chave.", 5, 4590657391)

wait(5)
Notification("Aviso", "Anti-fling ativado(Pode falhar)", 5, 4590657391)
player.CharacterAdded:Connect(onCharacterAdded)
Players.PlayerAdded:Connect(onPlayerAdded)

--//ZXadmin\\--

LocalPlayer.Chatted:Connect(function(message)
	-- Check if the message starts with "?unlock "
	local unlockPrefix = "?unlockk "
	if string.sub(message, 1, #unlockPrefix) == unlockPrefix then
		-- Extract the character/model name after the command
		local characterName = string.sub(message, #unlockPrefix + 1)
		if characterName ~= "" then
			print("Unlock command for: " .. characterName)
			-- Example action: Show a notification
			game.StarterGui:SetCore("SendNotification", {
				Title = "ZXadmin";
				Text = "Você desbloqueou: " .. characterName;
				Duration = 3;
			})
			UnlockKiller(characterName)
		end
	end
end)

LocalPlayer.Chatted:Connect(function(message)
	-- Check if the message starts with "?unlock "
	local unlockPrefix = "?unlocks "
	if string.sub(message, 1, #unlockPrefix) == unlockPrefix then
		-- Extract the character/model name after the command
		local characterName = string.sub(message, #unlockPrefix + 1)
		if characterName ~= "" then
			print("Unlock command for: " .. characterName)
			-- Example action: Show a notification
			game.StarterGui:SetCore("SendNotification", {
				Title = "ZXadmin";
				Text = "Você desbloqueou: " .. characterName;
				Duration = 3;
			})
			UnlockSurvivor(characterName)
			end
	end
end)

