PvPWarning_ChatFrame_OnEvent = ChatFrame_OnEvent
local PvPWarningFlagged = false
local PvPWarned = GetTime()
local PvPMasterVolume = false
local PvPMasterSoundEffects = false

--Creating the warning frame
PvPWarningGUI = CreateFrame("Frame", "PvPWarningGUI", UIParent)

PvPWarningGUI:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
PvPWarningGUI:SetWidth(50)
PvPWarningGUI:SetHeight(50)

--Adding text to the warning frame
PvPWarningGUI.warning = CreateFrame("Frame", "PvPWarningGUIWarning", PvPWarningGUI)
PvPWarningGUI.warning:SetPoint("TOP", PvPWarningGUI, "TOP", 0, 0)
PvPWarningGUI.warning:SetWidth(10)
PvPWarningGUI.warning:SetHeight(10)

PvPWarningGUI.warning.text = PvPWarningGUI.warning:CreateFontString(nil, "ARTWORK", "GameFontRedLarge")
PvPWarningGUI.warning.text:SetPoint("TOP", 0, 0)
PvPWarningGUI.warning.text:SetText("!!! YOU ARE PVP FLAGGED !!!")

--Adding sound that plays when the frame is first shown
table.insert(UISpecialFrames, "PvPWarningGUI")
PvPWarningGUI:Hide()

function ChatFrame_OnEvent(event)

	if (UnitIsPVP("player")) then
		if not PvPWarningFlagged then
			PvPWarningGUI:Show()
			PvPWarningFlagged = true
			if GetCVar("MasterSoundEffects") == "0" then
				SetCVar("MasterSoundEffects", 1)
				PvPMasterSoundEffects = true
				PvPWarned = GetTime()
				PvPWarningSound:Show()
			end
			if GetCVar("MasterVolume") == "0" then
				SetCVar("MasterVolume", 1)
				PvPMasterVolume = true
				PvPWarned = GetTime()
				PvPWarningSound:Show()
			end
			local sound = "Sound\\Interface\\PVPFlagTakenHordeMono.wav"
			if UnitFactionGroup("player") == "Alliance" then sound = "Sound\\Interface\\PVPFlagTakenMono.wav" end
			PlaySoundFile(sound,"master")
		end
	else
		if (PvPWarningGUI:IsVisible()) then
			PvPWarningGUI:Hide()
			PvPWarningFlagged = false
		end
	end
	

	PvPWarning_ChatFrame_OnEvent(event);

end

PvPWarningSound = CreateFrame("Frame")
PvPWarningSound:Hide()
PvPWarningSound:SetScript("OnUpdate", function()
	local plus = 2 --seconds
	local gt = GetTime() * 1000
	local st = (PvPWarned + plus) * 1000
	if gt >= st then
		if PvPMasterSoundEffects == true then
			PvPMasterSoundEffects = false
			SetCVar("MasterSoundEffects",0)
		end
		if PvPMasterVolume == true then
			SetCVar("MasterVolume", 0)
			PvPMasterVolume = false
		end
		PvPWarningSound:Hide()
	end
end)