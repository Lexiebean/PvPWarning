PvPWarning_ChatFrame_OnEvent = ChatFrame_OnEvent
local PvPWarningFlagged = false

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
PvPWarningGUI:SetScript("OnShow", function()
PlaySound("ReadyCheck","SFX")

end)

PvPWarningGUI:Hide()

function ChatFrame_OnEvent(event)

	if (UnitIsPVP("player")) then
		if not PvPWarningFlagged then
			PvPWarningGUI:Show()
			PvPWarningFlagged = true
		end
	else
		if (PvPWarningGUI:IsVisible()) then
			PvPWarningGUI:Hide()
			PvPWarningFlagged = false
		end
	end
	

	PvPWarning_ChatFrame_OnEvent(event);

end