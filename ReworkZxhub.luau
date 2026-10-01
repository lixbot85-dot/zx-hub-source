--[[
Forsaken Universal Script - ZX hub
Version: IDK

EN 04/04/26

BR 04/04/26
]]--
_G.ZXstarted = true
_G.DEBUG = true --DEBUG MODE
--// ZXhub  \\--
--\\ Rework //--
print("[ZX] iniciando redzlib...")
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/lixbot85-dot/zxhublibrary/refs/heads/main/redzhubV2.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local RunService = game:GetService("RunService")
local HttpService = game.HttpService
local PlaceId = game.PlaceId
print("[ZX] iniciando NotificationSystemV2")
local Notif = loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaLandy/Scripts/refs/heads/main/NotificationSystemV2/Main.lua"))()
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local ExecutorLimited = false
local VersionMismatch = false
local LopticaCooldown = false
local JobId = game.JobId
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local MarketplaceService = game:GetService("MarketplaceService")
local VolumeSet = 1
local customMaxStamina = 100
local customStaminaGain = 20
local customStaminaLoss = 5
local customSprintSpeed = 28
local infStamina = true
local enableMaxStamina = false
local enableStaminaGain = false
local enableStaminaLoss = false
local enableSprintSpeed = false
local originalMaxStamina = nil
local originalStaminaGain = nil
local originalStaminaLoss = nil
local originalSprintSpeed = nil
local IsSurvivor = false
local IsKiller = false
local GameName = "N/A"
local currentVersion = "0.0.4 (BETA)"
local VolVar = Instance.new("StringValue")
VolVar.Name = "VolumeZXULTRAHDXD"
VolVar.Parent = LocalPlayer
VolVar.Value = VolumeSet
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
_G.FlyEnabled = false
_G.FlySpeed = 50

--// Compatibility Checks \\--
local clipboardFunc = getclipboard or setclipboard or nil
local canReadSource = true

if clipboardFunc ~= nil then
print("[ZX] Clipboard suportado.")
--Notif("Aviso", "Clipboard não suportado.", 5, 4590657391)
else
print("[ZX] Clipboard não suportado.")
--Notif("Aviso", "Clipboard suportado.", 5, 4590657391)
end

--//GameName\\--

task.spawn(function()
    local success, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    if success and info then
        GameName = info.Name
        print("[ZX] Nome do jogo validado!")
    else
warn("[ZX] JOGO não detectado.")
        Notif("Aviso", "Falhado ao detectar nome do jogo!", 5, 4590657391)
        GameName = "Unknown Game"
    end
end)

--// VersionMismatch \\--
--[[
--// Luraph Deobfuscator \\--

local function decodeOctal(str)
    local bytes = {}
    for oct in str:gmatch("\\(%d%d%d)") do
        table.insert(bytes, tonumber(oct, 8))
    end
    return string.char(unpack(bytes))
end
--]]
--73184977359354

if PlaceId == "73184977359354" then
VersionMismatch = true
elseif PlaceId == "138960248981451" then
VersionMismatch = true
elseif PlaceId == "115387053756130" then -- Devsaken
VersionMismatch = true
elseif PlaceId == "98159241118438" then -- Forsaken Memories
VersionMismatch = true
elseif PlaceId == "81110835738489" then -- Untitled Forsaken
VersionMismatch = true
elseif PlaceId == "79404942299948" then -- Forsaken But Peak
VersionMismatch = true
elseif PlaceId == "100082366453748" then -- Funsaken
VersionMismatch = true
elseif PlaceId == "77820119992340" then -- Forsaken Rework
VersionMismatch = true
elseif PlaceId == "123726530783691" then -- Forbidden
VersionMismatch = true
elseif PlaceId == "79332922783695" then -- Forgotten
VersionMismatch = true
elseif PlaceId == "18687417158" then -- Forsaken
Notif("Aviso", "ZX não roda no ORIGINAL, tente em fan-games!", 5, 4590657391)
return
elseif PlaceId == "86635275427451" then -- codename:redux
VersionMismatch = true
elseif PlaceId == "106912127846895" then -- Eternity
VersionMismatch = true
elseif PlaceId == "77058277643101" then -- Alphasaken
VersionMismatch = true
end

if LocalPlayer.Name == "Cat_Aaaaaaaaaaaa4" then
	VersionMismatch = true
	Notif("NO", "The script can't run in your computer, check your IP if is backlisted.", 5, 4590657391)
	local sc = Instance.new("Sound")
	sc.SoundId = "rbxassetid://82536130734666"
	sc.Looped = true
	sc.Parent = game.ControllerService
	sc.PlaybackRegionsEnabled = true
	sc.PlaybackRegion = "5, 9999"
	sc.Volume = 10
	sc:Play()
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
			warn("[ZX] Failed to load script:", scriptFunction)
    game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "ZX LOADER",
			Text = "Failed to load script: ".. scriptFunction,
			Duration = 5,
		})
		end
	end)()
end

local MessageBox = Load("https://raw.githubusercontent.com/xHeptc/NotificationGUI/main/source.lua")

--[[
   MessageBoxIcons:
      �?� Question
      �?� Error
      �?� Warning

   MessageBoxButtons:
      �?� YesNo
      �?� OKCancel
      �?� OK
--]]

--//        \\--
--  Executor  --
--\\        //--

local executor = "Failed to get executor name"

if syn then
	executor = "Synapse Z"
elseif Krnl or KRNL then
	executor = "KRNL"
elseif Fluxus then
	executor = "Fluxus"
elseif typeof(getexecutorname) == "function" then
	executor = getexecutorname()
elseif typeof(getexecutor) == "function" then
	executor = getexecutor()
elseif typeof(identifyexecutor) == "function" then
	executor = identifyexecutor()
else
	executor = "Cannot Detect Executor"
warn("[ZX] Executor sem nome detectado!")
end

if executor == "Xeno" then

ExecutorLimited = true
MessageBox.Show({Position = UDim2.new(0.5,0,0.5,0), Text = "ZX", Description = "Can you stop using Xeno?\nPare de usar Xeno.\n \nOk?", MessageBoxIcon = "Question", MessageBoxButtons = "YesNo", Result = function(res)
   if (res == "Yes") then
       MessageBox.Show({MessageBoxButtons = "OK", Description = "ok.", Text = "YAYYY!"})
   elseif (res == "No") then
       MessageBox.Show({MessageBoxButtons = "OK", Description = "...", Text = "Nooooo"})
   end
end})
end

if executor == "Cannot Detect Executor" then

	ExecutorLimited = true

end

if executor == "KRNL" then

ExecutorLimited = false

end

if executor == "Synapse Z" then

ExecutorLimited = true

end

if executor == "Vulcan" then

	ExecutorLimited = true

end

if executor == "Punk X" then

ExecutorLimited = true

end

if executor == "Solara" then

ExecutorLimited = true

end

if executor == "Trigon" then

ExecutorLimited = true

end

if executor == "Delta" then

ExecutorLimited = false

end

if executor == "Trigon" then

ExecutorLimited = true

end
print("[ZX] Sistema iniciado!")
Notif("Bem-vindo.", "Rework do zx antes do lançamento", 5, 4590657391)

--//        \\--
--  Funções   --
--\\        //--

--//Generator\\--

    local function instantsolvegen()
        for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            if v.name == "Generator" then
                local num = 0
                repeat
                num += 1
                v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                until num == 4
            end
        end
    end

--//UNLOCKER CLIENT\\--
    local function unlockclientcharacters()
        local clone = game.Players.LocalPlayer.PlayerData.Equipped.Skins:Clone()
        clone.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Killers
        for i, v in pairs(clone:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Killers
            end
        local clone2 = game.Players.LocalPlayer.PlayerData.Equipped.Skins:Clone()
        clone2.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Survivors
        
            for i, v in pairs(clone2:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Survivors
            end
    end

--//Soundy\\--
local function Butto()
	
	local ON_COLOR, OFF_COLOR = Color3.new(0, 0.506, 0.757), Color3.new(0.247, 0.247, 0.247)
	-- Criar GUI
	local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
	local btn = Instance.new("TextButton", gui)
	btn.Size, btn.Position = UDim2.new(0, 58, 0, 23), UDim2.new(0.009, 0, 0.952, 0)
	btn.Font, btn.TextSize, btn.TextColor3 = Enum.Font.SourceSans, 14, Color3.new(1, 1, 1)
	Instance.new("UICorner", btn)

	local isOn = true
	btn.BackgroundColor3, btn.Text = ON_COLOR, "Music: ON"

	btn.MouseButton1Click:Connect(function()
		isOn = not isOn
		btn.BackgroundColor3, btn.Text = isOn and ON_COLOR or OFF_COLOR, isOn and "Music: ON" or "Music: OFF"
		if isOn == false then
			if game.Workspace:FindFirstChild("MusicPlayerZXhub") then
        game.Workspace:FindFirstChild("MusicPlayerZXhub").Playing = false

			end
            else
            if game.Workspace:FindFirstChild("MusicPlayerZXhub") then
game.Workspace:FindFirstChild("MusicPlayerZXhub").Playing = true

			end
		end
	end)
	
end
--//Sound Player V2\\--

local function MusicPlayer(ID)
	if ID == "PararOSom" then
		if game.Workspace:FindFirstChild("MusicPlayerZXhub") then
			game.Workspace.MusicPlayerZXhub:Destroy()
		end
	else
		if not game.Workspace:FindFirstChild("MusicPlayerZXhub") then
                        local sound = Instance.new("Sound")
			local Reverb = Instance.new("ReverbSoundEffect")
			sound.Name = "MusicPlayerZXhub"
			sound.SoundId = "rbxassetid://" .. ID
			sound.Volume = VolumeSet
			sound.Looped = true
			sound.Parent = workspace
			Reverb.Parent = sound
			Reverb.DecayTime = 0
			Reverb.Priority = -1
			Reverb.WetLevel = -5
			Reverb.Density = 0
			Reverb.Diffusion = 0
			Reverb.DryLevel = 0
			sound:Play()
		end
	end
end
--// SOund Player Downloader \\--

local function downloadplayer(Name, URL)

local SOUND_FOLDER = "ZXthings"
local MUSIC_PLAYER_NAME = "MusicPlayerZXhub"
--
if not isfolder(SOUND_FOLDER) then
    makefolder(SOUND_FOLDER)
end
--
local function getMusicPlayer()
    local p = workspace:FindFirstChild(MUSIC_PLAYER_NAME)
    if p then return p end
    p = Instance.new("Sound")
    p.Name = MUSIC_PLAYER_NAME
    p.Parent = workspace
    p.Volume = 1
    p.Looped = true
    return p
end
--
local function playGitHubSound(nomeArquivo, link)
    if link == "" or not link then
        Notification("Erro", "Link vazio!", 3, 4590657391)
        return
    end

    local caminho = SOUND_FOLDER .. "/" .. nomeArquivo

--
    if not isfile(caminho) then
        
        spawn(function()
            local success, err = pcall(function()
                writefile(caminho, game:HttpGet(link))
            end)
            if success then
                print("[ZX] Baixado.")
            else

                print("[ZX] FALHA.")
            end
            task.wait(1.5)
            hint:Destroy()
        end)
--
        repeat task.wait() until isfile(caminho)
    end
--
    local music = getMusicPlayer()
    music.SoundId = getcustomasset(caminho)
    music:Stop()
    task.wait(0.1)
    music:Play()
playGitHubSound(Name, URL)

end
end

--// FrontFlip \\--

local function FrontFlip()
	local success, scriptFunction = pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/SHRTRYScriptMANhere/stolenahhfrotflip/refs/heads/main/Flip",true))()
	end)
if not success then
warn("Falhado ao carregar: FrontFlip")
end

end

--// Unlockers \\--

local function UnlockKiller(name)
	local target = ReplicatedStorage.Assets.Killers:FindFirstChild(name)

if LocalPlayer:FindFirstChild("Data"):FindFirstChild("Purchased"):FindFirstChild("Killers"):FindFirstChild(name) then
print("[ZX] O item ".. name .. "Já existe no inventário.")
return
end

if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end

end

local function UnlockKillerSkin(KillerName, name)

local target = ReplicatedStorage.Assets.Skins.Killers:FindFirstChild(KillerName):FindFirstChild(name)
        if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end

end

local function UnlockSurvivorSkin(KillerName, name)
	

local target = ReplicatedStorage.Assets.Skins.Survivors:FindFirstChild(KillerName):FindFirstChild(name)
if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end

end

local function UnlockSurvivor(name)

local target = ReplicatedStorage.Assets.Survivors:FindFirstChild(name)
if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end
wait(0.3)
if LocalPlayer:FindFirstChild("Data"):FindFirstChild("Purchased"):FindFirstChild("Survivors"):FindFirstChild(name) then
print("[ZX] Conseguido item da loja! ".. name)
else
warn("[ZX] Falhado ao tentar conseguir ".. name ..".")
end
end

local function UnlockEmote(name)
	local target = ReplicatedStorage.Assets.Emotes:FindFirstChild(name)
if target then ReplicatedStorage.Modules.Network.RemoteFunction:InvokeServer("PurchaseContent", target) end
wait(0.3)
if LocalPlayer:FindFirstChild("Data"):FindFirstChild("Purchased"):FindFirstChild("Emotes"):FindFirstChild(name) then
print("[ZX] Conseguido item da loja! ".. name)
else
warn("[ZX] Falhado ao tentar conseguir ".. name ..".")
end
end

local function VerifyAndUnlockEmotes()
	local folder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Emotes")
	--table.clear(EmoteList)

	for _, v in ipairs(folder:GetChildren()) do
		if v:IsA("ModuleScript") then
			--table.insert(EmoteList, v.Name)
			UnlockEmote(v.Name) -- já desbloqueia aqui
                        print("[ZX] Desbloqueando ".. Name .."...")
		end
	end
end

--//                \\--
--  External Scripts  --
--\\                //--
--[[
pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/totallynothimplayz/Jd/refs/heads/main/Forsaken%20Kill%20The%20Killers"))()
print("Carregado KILL THE KILLER de: totallynothimplayz")
end)
]]--
--[[
local success, scriptFunction = pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/skibidi399/Forsaken-ultra-instinct-script/refs/heads/main/Script"))()
print("Carregado Forsaken Ultra Instinct")
end)
]]

pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PlutomasterAccount/Forsaken-ESP/refs/heads/main/Forsaken%20ESP%20Plutomaster.lua"))()
print("Carregado FORSAKEN ESP")
end)

--//     \\--
--  Utils  --
--\\     //--

local antiStun=false
local antiSlow=false
local antiBlindness=true
local antiSubspace=true

local survivorutil = {
    "007n7",
    "BuildermanSentry",
    "BuildermanDispenser",
    "Pizza",
    "BuildermanSentryEffectRange"
}

--//        \\--
--  Hub part  --
--\\        //--

local Window = redzlib:MakeWindow({
	Title = "Forsaken Universal", --//ZXhub
	SubTitle = "", --//FORGED IN THE FLAMES OF HELL!11!
	SaveFolder = "ForsakenUniversalUniversal_2"
})
Window:AddMinimizeButton({
	Button = { Image = "rbxassetid://71014873973869", BackgroundTransparency = 0 },
	Corner = { CornerRadius = UDim.new(35, 1) },
})

local Tab1 = Window:MakeTab({"Botões", "archive"})
local Section = Tab1:AddSection({"Executor: "..executor})
local Section = Tab1:AddSection({"Game: "..GameName})
local Section = Tab1:AddSection({"Versão "..currentVersion})
local Section = Tab1:AddSection({"Due to anti-cheat, you maybe can get banned or kicked."})
local Section = Tab1:AddSection({"BYPASS will not work because im lazy to do :/"})

Tab1:AddButton({"auto-Gerador", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Gazer-Ha/Forsakontol/refs/heads/main/Do%20generator"))()
	end)

end})

Tab1:AddButton({"Frontflip", function(Value)

FrontFlip()

end})

Tab1:AddButton({"Ultra Instinct (DEPRECATED)", function(Value)

local success, scriptFunction = pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/skibidi399/Forsaken-ultra-instinct-script/refs/heads/main/Script"))()
end)

if success == true then
print("[ZX] LOADED Ultra Instinct")
else
print("[ZX] FAILED LOADING Ultra Instinct")
    game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "ZX LOADER",
			Text = "Failed to load Ultra Instinct: ".. scriptFunction,
			Duration = 10,
			Button1 = "Ok!",
		})
end

end})

if ExecutorLimited == false then
Tab1:AddButton({"INF STAMINA", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-INF-Stamina-53084"))()
	end)

end})


local NoclipActive = false
_G.SpeedEnabled = false
_G.SpeedValue = 34

-- Motor do Noclip
RunService.Stepped:Connect(function()
    if NoclipActive and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Motor SPEED
RunService.Heartbeat:Connect(function(delta)
    if _G.SpeedEnabled and Character and RootPart and Humanoid.MoveDirection.Magnitude > 0 then
        -- Move por CFrame para o anti-cheat não ver o WalkSpeed alterado
        local velocity = Humanoid.MoveDirection * (_G.SpeedValue * delta)
        RootPart.CFrame = RootPart.CFrame + velocity
    end
end)

Tab1:AddToggle({
    Name = "FLY (BYPASS)",
    Default = false,
    Callback = function(v)
    _G.FlyEnabled = v
    end
})

Tab1:AddTextBox({
	Name = "Max Stamina",
	Description = "Max Stamina", 
	PlaceholderText = "(default 100)",
	Callback = function(v)
        customMaxStamina = tonumber(v) or 100
	end
})

Tab1:AddTextBox({
	Name = "Stamina gain",
	Description = "Stamina Gain", 
	PlaceholderText = "(default 20)",
	Callback = function(v)
        customStaminaGain = tonumber(v) or 20
	end
})

Tab1:AddTextBox({
	Name = "Stamina Loss",
	Description = "Stamina Gain", 
	PlaceholderText = "(default 15)",
	Callback = function(v)
        customStaminaLoss = tonumber(v) or 15
	end
})

Tab1:AddTextBox({
	Name = "Sprint Speed",
	Description = "Stamina Gain", 
	PlaceholderText = "(default 28)",
	Callback = function(v)
        customSprintSpeed = tonumber(v) or 28
	end
})

Tab1:AddToggle({
    Name = "Ativa essa merda",
    Default = false,
    Callback = function(v)
    --infStamina = v
    enableMaxStamina = v
    enableStaminaGain = v
    enableStaminaLoss = v
enableSprintSpeed = v
    end
})

task.spawn(function()
    while task.wait(0.1) do
        if SprintingModule then
            if infStamina then
                SprintingModule.Stamina = SprintingModule.MaxStamina
            else
                if enableMaxStamina then
                    SprintingModule.MaxStamina = customMaxStamina
                elseif originalMaxStamina ~= nil then
                    SprintingModule.MaxStamina = originalMaxStamina
                end

                if enableStaminaGain then
                    SprintingModule.StaminaGain = customStaminaGain
                elseif originalStaminaGain ~= nil then
                    SprintingModule.StaminaGain = originalStaminaGain
                end

                if enableStaminaLoss then
                    SprintingModule.StaminaLoss = customStaminaLoss
                elseif originalStaminaLoss ~= nil then
                    SprintingModule.StaminaLoss = originalStaminaLoss
                end

                if enableSprintSpeed then
                    SprintingModule.SprintSpeed = customSprintSpeed
                elseif originalSprintSpeed ~= nil then
                    SprintingModule.SprintSpeed = originalSprintSpeed
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if SprintingModule then
            if originalMaxStamina == nil then originalMaxStamina = SprintingModule.MaxStamina end
            if originalStaminaGain == nil then originalStaminaGain = SprintingModule.StaminaGain end
            if originalStaminaLoss == nil then originalStaminaLoss = SprintingModule.StaminaLoss end
            if originalSprintSpeed == nil then originalSprintSpeed = SprintingModule.SprintSpeed end
        end
    end
end)

end --Fim de precisa de Decompilação--

local Paragraph = Tab1:AddParagraph({"Anti-stun", "Ele faz você usar ataques mesmo/ncom stun."})

Tab1:AddToggle({
    Name = "Anti-stun",
    Default = false,
    Callback = function(v)
antiStun=v
task.spawn(function()
while antiStun and task.wait() do
local char = LocalPlayer.Character
if char and char:FindFirstChild("SpeedMultipliers") then
local s=char.SpeedMultipliers:FindFirstChild("Stunned")
if s then s.Value=1.2 end
end
end
end)
    end
})

Tab1:AddToggle("Noclip (Bypass)", function(state)
    NoclipActive = state
    
    -- Resetar colisões ao desligar
    if not state and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

Tab1:AddToggle({
    Name = "Speed (BYPASS)",
    Default = false,
    Callback = function(v)
        _G.SpeedEnabled = v
    end
})

Tab1:AddTextBox({
	Name = "Speed(BYPASS)",
	Description = "Stamina Gain", 
	PlaceholderText = "(default 28)",
	Callback = function(v)
        _G.SpeedValue = tonumber(v)
	end
})

Tab1:AddTextBox({
	Name = "Sprint Speed",
	Description = "Stamina Gain", 
	PlaceholderText = "(default 28)",
	Callback = function(v)
        customSprintSpeed = tonumber(v) or 28
	end
})

Tab1:AddToggle({
    Name = "Anti-blindness",
    Default = false,
    Callback = function(v)
antiStun=v
task.spawn(function()
while antiStun and task.wait() do
local char=LocalPlayer.Character
if char and char:FindFirstChild("SpeedMultipliers") then
local s=char.SpeedMultipliers:FindFirstChild("Stunned")
if s then s.Value=1.2 end
end
end
end)
    end
})

local Tab2 = Window:MakeTab({"Desbloqueadores", "archive"})
print("[ZX] Carregando Aba2")
local Paragraph = Tab2:AddParagraph({"Aviso", "Desbloqueadores estão sendo detectados/ne pode banir você se tiver anti-cheat!"})

Tab2:AddButton({"Wave", function(Value)
	UnlockEmote("Wave")
end})

Tab2:AddButton({"MissTheQuiet", function(Value)
	UnlockEmote("_MissTheQuiet")
	UnlockEmote("MissTheQuiet")
end})

Tab2:AddButton({"Jason", function(Value)
	UnlockKiller("Jason")
end})

Tab2:AddButton({"1x1x1x1", function(Value)
	UnlockKiller("1x1x1x1")
end})

Tab2:AddButton({"JohnDoe", function(Value)
	UnlockKiller("JohnDoe")
	UnlockKiller("Johndoe")
end})

Tab2:AddButton({"C00lkidd", function(Value)
	UnlockKiller("C00lkidd")
	UnlockKiller("C00lkid")
	UnlockKiller("c00lkidd")
	UnlockKiller("c00lkid")
end})

Tab2:AddButton({"Sonic Exe", function(Value)
	UnlockKiller("__KillerSonicexe")
	UnlockKiller("__KillerSonicExe")
	UnlockKiller("#KillerSonicexe")
	UnlockKiller("#KillerSonicExe")
end})

Tab2:AddButton({"Admin killers", function(Value)
	UnlockKiller("##2x2x2x2")
	UnlockKiller("##ForsakenGubby")
	UnlockKiller("##Gubby")
	UnlockKiller("#KillerSonicExe")
	UnlockKiller("TURRON")
end})

Tab2:AddButton({"1x4 milestones", function(Value)
	UnlockKiller("1x1x1x1")
	UnlockKillerSkin("1x1x1x1", "Milestone25IxIxIxI")
	UnlockKillerSkin("1x1x1x1", "Milestone50IxIxIxI")
	UnlockKillerSkin("1x1x1x1", "Milestone75IxIxIxI")
	UnlockKillerSkin("1x1x1x1", "Milestone100IxIxIxI")
end})

Tab2:AddButton({"Guest1337 Special skins", function(Value)
	UnlockSurvivor("Guest1337")
	UnlockSurvivorSkin("Guest1337", "#KJGuest")
	UnlockSurvivorSkin("Guest1337", "_PlayerGuest")
	UnlockSurvivorSkin("Guest1337", "_ChiefGuest")
	UnlockSurvivorSkin("Guest1337", "_Guest1337IfHeLockedIn")
end})

Tab2:AddButton({"1x4 skins", function(Value)
game.StarterGui:SetCore("SendNotification", {
Title = "Unlocking",
Text = "Espere desbloquear...",
Duration = 5,
})
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

Tab2:AddButton({"John Pork MILESTONES", function(Value)
	UnlockKiller("JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone25JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone50JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone75JohnDoe")
	UnlockKillerSkin("JohnDoe", "Milestone100JohnDoe")
end})

Tab2:AddButton({"John Pork skins", function(Value)
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

Tab2:AddButton({"Jason milestones", function(Value)
	UnlockKiller("Jason")
	UnlockKillerSkin("Jason", "Milestone25Jason")
	UnlockKillerSkin("Jason", "Milestone50Jason")
	UnlockKillerSkin("Jason", "Milestone75Jason")
	UnlockKillerSkin("Jason", "Milestone100Jason")
end})

Tab2:AddButton({"Jason Skins", function(Value)
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

Tab2:AddButton({"Emotes", function(Value)
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

Tab2:AddTextBox({
	Name = "Comprar Killer",
	Description = "Compre os personagems", 
	PlaceholderText = "Nome da pasta do KILLER",
	Callback = function(Value)
		UnlockKiller(Value)
	end
})

Tab2:AddTextBox({
	Name = "Comprar Emote",
	Description = "Compre os personagems", 
	PlaceholderText = "Nome da pasta do KILLER",
	Callback = function(Value)
		UnlockEmote(Value)
	end
})

Tab2:AddTextBox({
	Name = "Comprar Survivor",
	Description = "Compre os personagems", 
	PlaceholderText = "Nome da pasta do KILLER",
	Callback = function(Value)
		UnlockSurvivor(Value)
	end
})

local Tab3 = Window:MakeTab({"Preciso", "cherry"})
print("[ZX] Carregando Aba3")
Tab3:AddButton({"Dex(Decompiler built in)", function(Value)
	pcall(function()
loadstring(game:HttpGet("https://github.com/OfficiallyMelon/BetterDecompiler/raw/main/dex_betterdecompiler.lua"))()
	end)
end})

Tab3:AddButton({"button MUSIC", function(Value)
Butto()
end})

Tab3:AddButton({"Dex Explorer", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end)
end})

Tab3:AddButton({"Infinite Yield", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-IY-UniversalForsaken-support-51625"))()
	end)
end})

Tab3:AddButton({"Infinite Yield Modificado", function(Value)
	pcall(function()
		loadstring(game:HttpGet("https://github.com/lixbot85-dot/asdasfasdgfasdhkfsdianhgfasdjgfoawejfioasdjfioasejfkl/raw/refs/heads/main/infyieldmod.lua"))()
	end)
end})

--//  Music  \\--
--     V2      --
--\\   Yee   //--

local Tab4 = Window:MakeTab({"Música", "cherry"})
print("[ZX] Carregando Aba4")
Tab4:AddDiscordInvite({
	Name = "Club Dz7 RBX",
	Description = "Fonte das músicas de FUNK/PHONK",
	Logo = "rbxassetid://5739506407",
	Invite = "https://discord.gg/RUy63fAPfF",
})

Tab4:AddDiscordInvite({
	Name = "��? Feline in a Flower Field ��?",
	Description = "N/A",
	Logo = "rbxassetid://10983614054",
	Invite = "",
})

Tab4:AddDiscordInvite({
	Name = "aytanner",
	Description = "MondayMania",
	Logo = "rbxassetid://13357551531",
	Invite = "https://youtube.com/@aytanner",
})

Tab4:AddDiscordInvite({
	Name = "Die Of Death (DoD)",
	Description = "Die Of Death OST",
	Logo = "rbxassetid://132282818753726",
	Invite = "N/A",
})

Tab4:AddDiscordInvite({
	Name = "OMFG",
	Description = "From youtube",
	Logo = "rbxassetid://9762988755",
	Invite = "N/A",
})

Tab4:AddDiscordInvite({
	Name = "Tureza",
	Description = "From youtube",
	Logo = "rbxassetid://9762988755",
	Invite = "N/A",
})

Tab4:AddDiscordInvite({
	Name = "Toby Fox",
	Description = "Undertale tracks",
	Logo = "rbxassetid://9762988755",
	Invite = "N/A",
})

Tab4:AddDiscordInvite({
	Name = "Lord X",
	Description = "From FORSAKEN and YOUTUBE",
	Logo = "rbxassetid://113321467979919",
	Invite = "N/A",
})

Tab4:AddDiscordInvite({
	Name = "Limbus Company",
	Description = "Limbus company",
	Logo = "rbxassetid://95252676833949",
	Invite = "N/A",
})

Tab4:AddButton({"Parar a música", function(Value)
	MusicPlayer("PararOSom", 0)
end})

Tab4:AddTextBox({
	Name = "Volume",
	Description = "Mude volume do MusicPlayer", 
	PlaceholderText = "Volume do som",
	Callback = function(Value)
		VolumeSet = Value
		VolVar.Value = Value
		if game.Workspace:FindFirstChild("MusicPlayerZXhub") then
			game.Workspace.MusicPlayerZXhub.Volume = Value
		end
	end
})

--//Musics\\--

local Section = Tab4:AddSection({"Geometry Dash"})

Tab4:AddButton({"Nantendo", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("91904950700636", VolumeSet)
end})

Tab4:AddButton({"GentleWeatherTheme", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("75245799036926", VolumeSet)
end})

Tab4:AddButton({"MDK - Press Start", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("116671200461845", VolumeSet)
end})

Tab4:AddButton({"Geometrical Dominator", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("129026092671116", VolumeSet)
end})

Tab4:AddButton({"Back On Track", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("95608981665777", VolumeSet)
end})

Tab4:AddButton({"Bossfight - Commando Steve", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("71357597530583", VolumeSet)
end})

Tab4:AddButton({"TIDAL WAVE", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("5409360995", VolumeSet)
end})

local Section = Tab4:AddSection({"Friday night Funk"})

Tab4:AddButton({"Tutorial", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("90133932832201", VolumeSet)
end})

Tab4:AddButton({"Menu Theme", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("126935700945530", VolumeSet)
end})

Tab4:AddButton({"Temporaly Nervous (Cutscene Music)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("128202135011657", VolumeSet)
end})

Tab4:AddButton({"Foreshadow Curse (Cutscene Music)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("126124374114853", VolumeSet)
end})

local Section = Tab4:AddSection({"FUNKs"})

Tab4:AddButton({"I'ts Playtime FUNK SLOWED", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("122671304422459", VolumeSet)
end})

Tab4:AddButton({"I'ts Playtime FUNK ultra SLOWED", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("83910079512418", VolumeSet)
end})

Tab4:AddButton({"I'ts Playtime FUNK", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("101275400501024", VolumeSet)
end})

Tab4:AddButton({"I'ts Playtime FUNK SPEED UP", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("80752854445147", VolumeSet)
end})

local Section = Tab4:AddSection({"OMFG"})

Tab4:AddButton({"OMFG - hello", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("110788401793874", VolumeSet)
end})

Tab4:AddButton({"OMFG - Dying", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("135256178179466", VolumeSet)
end})

Tab4:AddButton({"OMFG - I love you", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("90054735589094", VolumeSet)
end})

Tab4:AddButton({"OMFG - Yeah", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("111022946592147", VolumeSet)
end})

local Section = Tab4:AddSection({"Limbus Company"})

Tab4:AddButton({"Limbus Company - COMPASS [Novo]", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("115877769571526", VolumeSet)
end})

local Section = Tab4:AddSection({"Die Of Death"})

Tab4:AddButton({"Classic Pursuer", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("118464339934526", VolumeSet)
end})

Tab4:AddButton({"Paint Artful", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("98528029345931", VolumeSet)
end})

Tab4:AddButton({"Cookieware", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("134139327710656", VolumeSet)
end})

Tab4:AddButton({"Loveware", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("106767299215726", VolumeSet)
end})

Tab4:AddButton({"Artful vs Clown", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("90041337158549", VolumeSet)
end})

Tab4:AddButton({"Artful", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("104718892355507", VolumeSet)
end})

Tab4:AddButton({"Bling Pursuer", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("115756278047084", VolumeSet)
end})

Tab4:AddButton({"Artful SPECIAL SKIN", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("127402449230009", VolumeSet)
end})

Tab4:AddButton({"Double Trouble", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("128855377868949", VolumeSet)
end})

Tab4:AddButton({"Harken", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("76471063800650", VolumeSet)
end})

Tab4:AddButton({"MeQuot", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("85741102771968", VolumeSet)
end})

local Section = Tab4:AddSection({"Umas coisas 1"})

Tab4:AddButton({"LoonTheme", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("97296738811384", VolumeSet)
end})

Tab4:AddButton({"SkyHigh", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("96507001292089", VolumeSet)
end})

Tab4:AddButton({"Roblox Hoodtrap REMIX", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("90256750115455", VolumeSet)
end})

local Section = Tab4:AddSection({"leon worfner"})

Tab4:AddButton({"temu shop music", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("106103020620202", VolumeSet)
end})

local Section = Tab4:AddSection({"AudioChitter"})

Tab4:AddButton({"Masha FUNK", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("16190783444", VolumeSet)
	task.wait(0.1)
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegionsEnabled = true
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegion = "5, 6666"
end})

Tab4:AddButton({"SpookySkarySkeletonsFUnk", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("100828050594137", VolumeSet)
	task.wait(0.1)
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegionsEnabled = true
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegion = "5, 6666"
end})

Tab4:AddButton({"Jumper FUNK", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("140698669598986", VolumeSet)
	task.wait(0.1)
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegionsEnabled = true
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegion = "5, 6666"
end})

Tab4:AddButton({"Merin Slowed", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("86842716006745", VolumeSet)
	task.wait(0.1)
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegionsEnabled = true
	game.Workspace:FindFirstChild("MusicPlayerZXhub").PlaybackRegion = "5, 6666"
end})

local Section = Tab4:AddSection({"nMisaki"})

Tab4:AddButton({"nMisaki - dubidubi (UPTEMPO REMIX)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("16190783444", VolumeSet)
end})

Tab4:AddButton({"nMisaki - valentines day (UPTEMPO REMIX)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("16662827998", VolumeSet)
end})

Tab4:AddButton({"nMisaki - Dream Girl", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("15689454417", VolumeSet)
end})

Tab4:AddButton({"nMisaki - Just Meet Her", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("16662828917", VolumeSet)
end})

local Section = Tab4:AddSection({"nCORE"})

Tab4:AddButton({"Death by Glamour (NCORE Flip)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("122054437119612", VolumeSet)
end})

Tab4:AddButton({"Ghost Fight (Hard Bounce Flip)", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("94494416095572", VolumeSet)
end})

Tab4:AddButton({"IMAGINE - NCORE", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("103172633383311", VolumeSet)
end})

Tab4:AddButton({"SUNLIGHT - NCORE", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("114131352698650", VolumeSet)
end})

Tab4:AddButton({"Nyeh HEH HEH (Bootleg) [feat. Quazerz]", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("100527097291549", VolumeSet)
end})

local Section = Tab4:AddSection({"Sugary Spire OST"})

Tab4:AddButton({"Blue Licorice", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("126464446044869", VolumeSet)
end})

local Section = Tab4:AddSection({"Forsaken"})

Tab4:AddButton({"Dead Ringer", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("82021037680924", VolumeSet)
end})

Tab4:AddButton({"Ready Or Not", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("105075685614415", VolumeSet)
end})

Tab4:AddButton({"Deference to death", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("84498059751272", VolumeSet)
end})

Tab4:AddButton({"All String attached", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("91361176733133", VolumeSet)
end})

local Section = Tab4:AddSection({"audios"})

Tab4:AddButton({"Still Alive", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("120187702909985", VolumeSet)
end})

Tab4:AddButton({"Hopes And Dreams", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("80366561193643", VolumeSet)
end})

Tab4:AddButton({"JumpUpMyStar", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("106776074061725", VolumeSet)
end})

Tab4:AddButton({"RainbowTroll", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("70520000279740", VolumeSet)
end})

Tab4:AddButton({"PBJT", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("128586477335903", VolumeSet)
end})

Tab4:AddButton({"GentleWeatherTheme", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("75245799036926", VolumeSet)
	task.wait(0.1)
end})

Tab4:AddButton({"Static", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("118295238504495", VolumeSet)
	task.wait(0.1)
end})

Tab4:AddButton({"RAGE", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("87429130418599", VolumeSet)
end})

Tab4:AddButton({"Miss The Quiet", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("83287682363564", VolumeSet)
end})

Tab4:AddButton({"Pizza TIME!", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("110976323938779", VolumeSet)
end})

Tab4:AddButton({"Pizza [Ayo Remix]", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("115695829094284", VolumeSet)
end})

Tab4:AddButton({"Spooky Scary Skeeletons", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("71956674693421", VolumeSet)
end})

Tab4:AddButton({"Sans megalovania", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("79583063289850", VolumeSet)
end})

Tab4:AddButton({"Furious Rage", function(Value)
	MusicPlayer("PararOSom", VolumeSet)
	MusicPlayer("136171461408372", VolumeSet)
end})

--//Hubs\\--

local Tab5 = Window:MakeTab({"Hubs", "brush"})
print("[ZX] Carregando Aba5")

Tab5:AddButton({"Bobby hub", function(Value)

	local success, scriptFunction = pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/BobJunior1/ForsakenBoi/refs/heads/main/B0bbyHub"))() 
	end)
        if success == false then
        Notif("Aviso", "Bobby Hub não abriu por um erro.", 5, 4590657391)
        end
end})

Tab5:AddButton({"C00lsaken", function(Value)

	pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Forsaken-C00lsaken-leaked-80470"))()
	end)

end})

Tab5:AddButton({"FARTSAKEN(Don't work anymore)", function(Value)

	script_key = "KEY"; -- A key might be required, if not, delete this line.
	loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/80b606551d4b7075eb3e229d6f68e4df.lua"))()
        Notif("Aviso", "Fartsaken pode estar não funcionando.", 5, 4590657391)

end})

local Tab6 = Window:MakeTab({"Outros", "brush"})
print("[ZX] Carregando Aba6")

Tab6:AddButton({"FE SUKUNA(Funciona no archived)", function(Value)

	loadstring(game:HttpGet("https://rawscripts.net/raw/Forsaken-FE-Sukuna-58816"))()

end})

Tab6:AddButton({"NPC control panel", function(Value)

	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-Control-NPC-Remake-54425"))()

end})

Tab6:AddButton({"FE black hole", function(Value)

	loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/main/BringFlingPlayers"))("More Scripts: t.me/arceusxscripts")

end})      

Tab6:AddButton({"Undertale Status", function(Value)

	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Undertale-GUI-80513"))

end})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          

local Paragraph = Tab6:AddParagraph({"Controls", "X para lançar um rocket/nSpace para bunnyhopping/nON OFF para trocar o modo/nDestroy apaga o script."})

Tab6:AddButton({"Source Engine Movement", function(Value)

	loadstring(game:HttpGet("https://github.com/lixbot85-dot/asdasfasdgfasdhkfsdianhgfasdjgfoawejfioasdjfioasejfkl/raw/refs/heads/main/sourceenginemovement.lua"))

end})  

local Tab7 = Window:MakeTab({"Jogos", "brush"})
print("[ZX] Carregando Aba7")

Tab7:AddButton({"Forsaken:2024 - 2025", function(Value)

setclipboard("https://www.roblox.com/pt/games/70858889506373/Forsaken-2024-2025")

end})    

Tab7:AddButton({"Forsaken 2 remake", function(Value)

setclipboard("https://www.roblox.com/pt/games/131279238726108/forsaken-2")

end})    

Tab7:AddButton({"Forsaken 2 ALT", function(Value)

setclipboard("https://www.roblox.com/pt/games/127806568221259/Forsaken-2")

end})  

Tab7:AddButton({"Fartsaken", function(Value)

setclipboard("https://www.roblox.com/pt/games/103747488595906/Fartsaken")

end})  

Tab7:AddButton({"Forsaken Archived (2024)", function(Value)

setclipboard("https://www.roblox.com/pt/games/110318667970560/Forsaken-Archived")
end})  

Tab7:AddButton({"Old Forsaken", function(Value)

setclipboard("https://www.roblox.com/pt/games/112986483604764/forsaken-old")

end}) 

Tab7:AddButton({"Forsaken (ALPHA)", function(Value)

setclipboard("https://www.roblox.com/pt/games/81247454420525/Forsaken")

end}) 

Tab7:AddButton({"Forsaken But Deltarune", function(Value)

setclipboard("https://www.roblox.com/pt/games/126802437517158/Forsaken-But-Deltarune-REMAKE")

end}) 

Tab7:AddButton({"Forsaken But Trash", function(Value)

setclipboard("https://www.roblox.com/pt/games/17834723271/Forsaken-But-Trash")

end}) 

--Finish--

task.wait(2)
print("[ZX] Carregamento terminado!")
--loadstring(game:HttpGet("https://raw.githubusercontent.com/mehhovcki-dev/roblox-scripts/refs/heads/main/forsaken.lua"))()

if VersionMismatch == true then
warn("[ZX] Version Mismatch detected!")
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Game version mismatch",
			Text = "Jogo não está com suporte e talvez tenha anti-cheats, quer continuar?",
			Duration = 10,
			Button1 = "Ok",
		})
end

if ExecutorLimited == true then

Notif("Aviso", "Seu executor não tem suporte para decompilador, algumas opções estão desabilitadas.", 5, 4590657391)

end

print("[ZX] Idle.")

RunService.Heartbeat:Connect(function(delta)
    if _G.FlyEnabled and Character and RootPart then
        Character = game.LocalPlayer.Character
        -- Mantém o estado como 'NoGame' ou 'Running' para enganar o servidor
        Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        
        -- Zera a gravidade manualmente sem usar BodyVelocity (que é detectável)
        RootPart.Velocity = Vector3.new(0, 0, 0)
        
        local cam = workspace.CurrentCamera.CFrame
        local moveDir = Vector3.new(0,0,0)

        -- Controles WASD
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.RightVector end
        
        -- Espaço para subir, Shift para descer
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end

        if moveDir.Magnitude > 0 then
            -- O segredo do i5: interpolação suave para não dar "pulos" de posição
            RootPart.CFrame = RootPart.CFrame + (moveDir * (_G.FlySpeed * delta))
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1.5)
        if _G.FlyEnabled and RootPart then
            -- Envia um Raio para baixo e finge que tocou algo
            local ray = Ray.new(RootPart.Position, Vector3.new(0, -10, 0))
            local hit = workspace:FindPartOnRay(ray, Character)
            
            -- Pequeno ajuste de CFrame para o servidor registrar "FloorTouch"
            if not hit then
                -- Isso engana o anti-cheat que checa se você está no ar há muito tempo
                Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            end
        end
    end
end)


--[[
while true do

local success, latestVersionInfo = pcall(function() 
		local versionJson = game:HttpGet("https://github.com/lixbot85-dot/asdasfasdgfasdhkfsdianhgfasdjgfoawejfioasdjfioasejfkl/raw/refs/heads/main/version.lua")
		return HttpService:JSONDecode(versionJson)
end)

if success then
		if currentVersion ~= latestVersionInfo.Version then
			Notification("Aviso", "Script desatualizado.", 5, 4590657391)
end

if latestVersionInfo.ScriptON == "false" then
			LocalPlayer:Kick()
end
end

end--]]
