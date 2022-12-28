--repeat wait() until game:IsLoaded();
-- FULL SCREEN FIX
spawn(function()
	local GameSettings = UserSettings().GameSettings
	local GuiService = game:GetService("GuiService")
	if GameSettings:InFullScreen() then
		GuiService:ToggleFullscreen()
	end
end)


-- GIVE RANK 255 TO PLAYER! 
local meta = getrawmetatable(game)
setreadonly(meta,false)
local oldnmc = meta.__namecall

meta.__namecall = newcclosure(function(Self,...)
local Args = {...}
local ncm = tostring(getnamecallmethod())
if ncm == "GetRankInGroup" then
    return 255
    end
return oldnmc(Self,...)
end)



-- KICK DETECTOR (Shuts game down if you get kicked from game.)
spawn(function()
	wait(15);
	local prompt = assert(game:GetService("CoreGui"):FindFirstChild("promptOverlay", true), "Lol it should work :/")
	assert(not prompt:FindFirstChild("ErrorPrompt"), prompt:FindFirstChild("ErrorPrompt") and wait(2) and game:shutdown())
	prompt.ChildAdded:Connect(function(child)
   		assert(child, typeof(child) == "Instance" and child.Name == "ErrorPrompt" and child.ClassName == "Frame" and wait(2) and game:shutdown())
	end)
end)



--ERROR CATCHER (Shuts game down if script errors)
_G.gettingScriptName = false;
spawn(function()
	wait(15);
	local Script_Name = "";
	game.ScriptContext.ErrorDetailed:Connect(function(message, stacktrace)
		if(G_gettingScriptName == true) then
			print("ERROR FOUND");
			if stacktrace then
				for token in string.gmatch(stacktrace, "[^%s]+") do
					_G.gettingScriptName = false;
   					Script_Name = token;
					print("SCRIPT_NAME_COLLECTED");
					return;
				end
			end
		else
			if stacktrace then
				for token in string.gmatch(stacktrace, "[^%s]+") do
					if(token == Script_Name) then
						game:shutdown();
						return;
					end
				end
			end
		end
	end)
	print("WAITING TO DETECT SCRIPT ERROR");
end)





-- WAIT FOR PLAYER TO ENTER GAME
repeat wait() until game:GetService('Players').LocalPlayer ~= nil



-- ANTI AFK
spawn(function()
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		game:GetService("VirtualUser"):CaptureController()
		game:GetService("VirtualUser"):Button1Up(Vector2.new(0.5,0.5)); wait(0.2)
		game:GetService("VirtualUser"):CaptureController()
		game:GetService("VirtualUser"):Button1Down(Vector2.new(0.5,0.5)); wait(0.2)
		game:GetService("VirtualUser"):CaptureController()
		game:GetService("VirtualUser"):Button1Up(Vector2.new(0.5,0.5))
	end)
end)



-- SOUNDS STOPPER AND REMOVAL
local c = 0 -- remove all sounds
for _, d in ipairs(game:GetDescendants()) do 
if (d:IsA("Sound")) then d:Stop() d:Destroy() c = c + 1 end end 




-- RENDERLESS CLIENT
game:GetService("RunService"):Set3dRenderingEnabled(false);



-- CAPPED FRAMES PER SECOND
setfpscap(8);


-- ANTI STUCK
-- (works by detecting changes in key values that Should have changed within X seconds example currency)
if(game.PlaceId == 6984315364) then -- ROPETS 
	repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("GameHud") ~= nil
	wait(5);
	local Currency = game:GetService("Players").LocalPlayer.PlayerGui.GameHud.SeasonalCurrency.TextLabel.Text;
	spawn(function()
		while true do
			wait(300);
			if(Currency == game:GetService("Players").LocalPlayer.PlayerGui.GameHud.SeasonalCurrency.TextLabel.Text) then
				game:shutdown();
			else	
				Currency = game:GetService("Players").LocalPlayer.PlayerGui.GameHud.SeasonalCurrency.TextLabel.Text;
			end
		end
	end)
elseif(game.PlaceId == 920587237) then -- ADOPT ME


end




--REMOVE TEXTURES/ENVIOURMENT EFFECTS
spawn(function()
	local decalsyeeted = true
	local g = game
	local w = g.Workspace
	local l = g.Lighting
	local t = w.Terrain
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = false
	l.FogEnd = 9e9
	l.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"
	for i, v in pairs(g:GetDescendants()) do
    		if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        		v.Material = "Plastic"
        		v.Reflectance = 0
    		elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        		v.Transparency = 1
    		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        		v.Lifetime = NumberRange.new(0)
    		elseif v:IsA("Explosion") then
        		v.BlastPressure = 1
        		v.BlastRadius = 1
    		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        		v.Enabled = false
    		elseif v:IsA("MeshPart") then
        		v.Material = "Plastic"
        		v.Reflectance = 0
        		v.TextureID = 10385902758728957
    		end
	end
	for i, e in pairs(l:GetChildren()) do
    		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        		e.Enabled = false
		end
    	end
end)


--REMOVE ALL SEATS
for i,v in pairs(game:GetService("Workspace"):GetDescendants())  do --Destory seats so player doesn't get stuck
	if v.Name == "Seat" or v.Name == "ParkBench" then
		v:Destroy()       
 	end   
end
