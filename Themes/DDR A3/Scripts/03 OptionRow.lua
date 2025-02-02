function OptionRowAppearancePlus()
	local t = {
		Name="AppearancePlus",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Visible", 'Hidden', 'Sudden', 'Stealth', 'Hidden+', 'Sudden+', 'Hidden+&Sudden+', },
		LoadSelections = function(self, list, pn)
			local AppearancePlusValue = "Visible";
			local pf = PROFILEMAN:GetProfile(pn);
			local PlayerUID = "";
			
			if pf then 
				PlayerUID = pf:GetGUID()  
				AppearancePlusValue = ReadOrCreateAppearancePlusValueForPlayer(PlayerUID,AppearancePlusValue);
			else
				PlayerUID = "UnknownPlayerUID"
				AppearancePlusValue = "Visible";
			end
			
			if AppearancePlusValue ~= nil then
				if AppearancePlusValue == "Hidden" then
					list[2] = true
				elseif AppearancePlusValue == "Sudden" then
					list[3] = true
				elseif AppearancePlusValue == "Stealth" then
					list[4] = true
				elseif AppearancePlusValue == "Hidden+" then
					list[5] = true
				elseif AppearancePlusValue == "Sudden+" then
					list[6] = true
				elseif AppearancePlusValue == "Hidden+&Sudden+" then
					list[7] = true
				else
					list[1] = true
				end
			else
				SaveAppearancePlusValueForPlayer(PlayerUID,"Visible")
				list[1] = true
			end
			
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			local PlayerUID = "";
			local pf = PROFILEMAN:GetProfile(pn);
			
			if pf then 
				PlayerUID = pf:GetGUID()  
			else
				PlayerUID = "UnknownPlayerUID"
			end
			
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = "Visible";
						if i==2 then
							val = "Hidden";
						elseif i==3 then
							val = "Sudden";
						elseif i==4 then
							val = "Stealth";
						elseif i==5 then
							val = "Hidden+";
						elseif i==6 then
							val = "Sudden+";
						elseif i==7 then
							val = "Hidden+&Sudden+";
						else
							val = "Visible";
						end
						setenv("AppearancePlus"..pName,val)
						SaveAppearancePlusValueForPlayer(PlayerUID,val)
						found = true
						break;
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end

function OptionRowFastSlow()
	local t = {
		Name = "FastSlow";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true,
		Choices = {"Off", "On", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowFastSlow") ~= nil then
				if GetUserPref("OptionRowFastSlow")=='Off' then
					list[1] = true
				elseif GetUserPref("OptionRowFastSlow")=='On' then
					list[2] = true
				else
					list[2] = true
				end
			else
				WritePrefToFile("OptionRowFastSlow",'On');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowFastSlow",'Off');
			elseif list[2] then
				WritePrefToFile("OptionRowFastSlow",'On');
			else
				WritePrefToFile("OptionRowFastSlow",'On');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowLanguage()
	local t = {
		Name = "Language";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"jp", "en", "kor", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowLanguage") ~= nil then
				if GetUserPref("OptionRowLanguage")=='jp' then
					list[1] = true
				elseif GetUserPref("OptionRowLanguage")=='en' then
					list[2] = true
				elseif GetUserPref("OptionRowLanguage")=='kor' then
					list[3] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowLanguage",'en');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowLanguage",'jp');
			elseif list[2] then
				WritePrefToFile("OptionRowLanguage",'en');
			elseif list[3] then
				WritePrefToFile("OptionRowLanguage",'kor');
			else
				WritePrefToFile("OptionRowLanguage",'en');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowComboUnderField()
	local t = {
		Name = "ComboUnderField";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Background", "Foreground", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowComboUnderField") ~= nil then
				if GetUserPref("OptionRowComboUnderField")=='true' then
					list[1] = true
				elseif GetUserPref("OptionRowComboUnderField")=='false'then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowComboUnderField",true);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowComboUnderField",true);
			elseif list[2] then
				WritePrefToFile("OptionRowComboUnderField",false);
			else
				WritePrefToFile("OptionRowComboUnderField",true);
			end;
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowGuideLines()
	local t = {
		Name = "GuideLines";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Off", "On", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowGuideLines") ~= nil then
				if GetUserPref("OptionRowGuideLines")=='true' then
					list[2] = true
				elseif GetUserPref("OptionRowGuideLines")=='false' then
					list[1] = true
				else
					list[2] = true
				end
			else
				WritePrefToFile("OptionRowGuideLines",true);
				list[2] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[2] then
				WritePrefToFile("OptionRowGuideLines",true);
			elseif list[1] then
				WritePrefToFile("OptionRowGuideLines",false);
			else
				WritePrefToFile("OptionRowGuideLines",true);
			end;
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowShockArrows()
	local t = {
		Name = "ShockArrows";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Off", "On", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowShockArrows") ~= nil then
				if GetUserPref("OptionRowShockArrows")=='false' then
					list[1] = true
				elseif GetUserPref("OptionRowShockArrows")=='true' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowShockArrows",false);
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowShockArrows",false);
			elseif list[2] then
				WritePrefToFile("OptionRowShockArrows",true);
			else
				WritePrefToFile("OptionRowShockArrows",false);
			end;
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowScreenFilter()
	local t = {
		Name = "ScreenFilter";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = false;
		ExportOnChange = true;
		Choices = {"Off", "Dark", "Darker", "Darkest", };
		LoadSelections = function(self, list, pn)
		local pName = ToEnumShortString(pn)
			if ReadPrefFromFile("OptionRowScreenFilter"..pName) ~= nil then
				if GetUserPref("OptionRowScreenFilter"..pName)=='Off' then
					list[1] = true
				elseif GetUserPref("OptionRowScreenFilter"..pName)=='DARK' then
					list[2] = true
				elseif GetUserPref("OptionRowScreenFilter"..pName)=='Darker' then
					list[3] = true
				elseif GetUserPref("OptionRowScreenFilter"..pName)=='Darkest' then
					list[4] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowScreenFilter"..pName,'Darker');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			if list[1] then
				WritePrefToFile("OptionRowScreenFilter"..pName,'Off');
			elseif list[2] then
				WritePrefToFile("OptionRowScreenFilter"..pName,'DARK');
			elseif list[3] then
				WritePrefToFile("OptionRowScreenFilter"..pName,'Darker');
			elseif list[4] then
				WritePrefToFile("OptionRowScreenFilter"..pName,'Darkest');
			else
				WritePrefToFile("OptionRowScreenFilter"..pName,'Darker');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowBPM()
	local t = {
		Name = "BPM";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Name", "BPM", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowBPM") ~= nil then
				if GetUserPref("OptionRowBPM")=='Name' then
					list[1] = true
				elseif GetUserPref("OptionRowBPM")=='BPM' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowBPM",'Name');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowBPM",'Name');
			elseif list[2] then
				WritePrefToFile("OptionRowBPM",'BPM');
			else
				WritePrefToFile("OptionRowBPM",'Name');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowSpeedDisplay()
	local t = {
		Name = "SpeedDisplay";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Off" ,"On" };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowSpeedDisplay") ~= nil then
				if GetUserPref("OptionRowSpeedDisplay")=='Off' then
					list[1] = true
				elseif GetUserPref("OptionRowSpeedDisplay")=='On' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowSpeedDisplay",'Off');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowSpeedDisplay",'Off');
			elseif list[2] then
				WritePrefToFile("OptionRowSpeedDisplay",'On');
			else
				WritePrefToFile("OptionRowSpeedDisplay",'Off');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowGameplayBackground()
	local t = {
		Name = "GameplayBackground";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = false;
		Choices = {"Background", "DanceStages", "SNCharacters" };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowGameplayBackground") ~= nil then
				if GetUserPref("OptionRowGameplayBackground")=='Background' then
					list[1] = true
				elseif GetUserPref("OptionRowGameplayBackground")=='DanceStages' then
					list[2] = true
				elseif GetUserPref("OptionRowGameplayBackground")=='SNCharacters' then
					list[3] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowGameplayBackground",'Background');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowGameplayBackground",'Background');
			elseif list[2] then
				WritePrefToFile("OptionRowGameplayBackground",'DanceStages');
			elseif list[3] then
				WritePrefToFile("OptionRowGameplayBackground",'SNCharacters');
			else
				WritePrefToFile("OptionRowGameplayBackground",'Background');
			end;
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowCutIns()
	local t = {
		Name = "CutIns";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = false;
		Choices = {"Off", "On", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowCutIns") ~= nil then
				if GetUserPref("OptionRowCutIns")=='Off' then
					list[1] = true
				elseif GetUserPref("OptionRowCutIns")=='On'then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowCutIns",'Off');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowCutIns",'Off');
			elseif list[2] then
				WritePrefToFile("OptionRowCutIns",'On');
			else
				WritePrefToFile("OptionRowCutIns",'Off');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowModel()
	local t = {
		Name = "Model";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = false;
		Choices = {"Gold", "White", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowModel") ~= nil then
				if GetUserPref("OptionRowModel")=='Gold' then
					list[1] = true
				elseif GetUserPref("OptionRowModel")=='White' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowModel",'Gold');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowModel",'Gold');
			elseif list[2] then
				WritePrefToFile("OptionRowModel",'White');
			else
				WritePrefToFile("OptionRowModel",'Gold');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowGoldenLeague()
	local t = {
		Name = "GoldenLeague";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = false;
		Choices = {"Off" ,"Bronze", "Silver", "Gold" };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowGoldenLeague") ~= nil then
				if GetUserPref("OptionRowGoldenLeague")=='Off' then
					list[1] = true
				elseif GetUserPref("OptionRowGoldenLeague")=='Bronze' then
					list[2] = true
				elseif GetUserPref("OptionRowGoldenLeague")=='Silver' then
					list[3] = true
				elseif GetUserPref("OptionRowGoldenLeague")=='Gold' then
					list[4] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowGoldenLeague",'Off');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowGoldenLeague",'Off');
			elseif list[2] then
				WritePrefToFile("OptionRowGoldenLeague",'Bronze');
			elseif list[3] then
				WritePrefToFile("OptionRowGoldenLeague",'Silver');
			elseif list[4] then
				WritePrefToFile("OptionRowGoldenLeague",'Gold');
			else
				WritePrefToFile("OptionRowGoldenLeague",'Off');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowStreamMode()
	local t = {
		Name = "StreamMode";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Off", "On", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowStreamMode") ~= nil then
				if GetUserPref("OptionRowStreamMode")=='Off' then
					list[1] = true
				elseif GetUserPref("OptionRowStreamMode")=='On' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowStreamMode",'Off');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowStreamMode",'Off');
			elseif list[2] then
				WritePrefToFile("OptionRowStreamMode",'On');
			else
				WritePrefToFile("OptionRowStreamMode",'Off');
			end;
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowJudgementAnimation()
	local t = {
		Name = "JudgementAnimation";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Normal", "Simple", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowJudgementAnimation") ~= nil then
				if GetUserPref("OptionRowJudgementAnimation")=='Normal' then
					list[1] = true
				elseif GetUserPref("OptionRowJudgementAnimation")=='Simple' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowJudgementAnimation",'Normal');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowJudgementAnimation",'Normal');
			elseif list[2] then
				WritePrefToFile("OptionRowJudgementAnimation",'Simple');
			else
				WritePrefToFile("OptionRowJudgementAnimation",'Normal');
			end;
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowDanCourse()
	local t = {
		Name = "DanCourse";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = false;
		Choices = {"None" ,"1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "Kaiden", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowDanCourse") ~= nil then
				if GetUserPref("OptionRowDanCourse")=='None' then
					list[1] = true
				elseif GetUserPref("OptionRowDanCourse")=='1st' then
					list[2] = true
				elseif GetUserPref("OptionRowDanCourse")=='2nd' then
					list[3] = true
				elseif GetUserPref("OptionRowDanCourse")=='3rd' then
					list[4] = true
				elseif GetUserPref("OptionRowDanCourse")=='4th' then
					list[5] = true
				elseif GetUserPref("OptionRowDanCourse")=='5th' then
					list[6] = true
				elseif GetUserPref("OptionRowDanCourse")=='6th' then
					list[7] = true
				elseif GetUserPref("OptionRowDanCourse")=='7th' then
					list[8] = true
				elseif GetUserPref("OptionRowDanCourse")=='8th' then
					list[9] = true
				elseif GetUserPref("OptionRowDanCourse")=='9th' then
					list[10] = true
				elseif GetUserPref("OptionRowDanCourse")=='10th' then
					list[11] = true
				elseif GetUserPref("OptionRowDanCourse")=='Kaiden' then
					list[12] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowDanCourse",'None');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowDanCourse",'None');
			elseif list[2] then
				WritePrefToFile("OptionRowDanCourse",'1st');
			elseif list[3] then
				WritePrefToFile("OptionRowDanCourse",'2nd');
			elseif list[4] then
				WritePrefToFile("OptionRowDanCourse",'3rd');
			elseif list[5] then
				WritePrefToFile("OptionRowDanCourse",'4th');
			elseif list[6] then
				WritePrefToFile("OptionRowDanCourse",'5th');
			elseif list[7] then
				WritePrefToFile("OptionRowDanCourse",'6th');
			elseif list[8] then
				WritePrefToFile("OptionRowDanCourse",'7th');
			elseif list[9] then
				WritePrefToFile("OptionRowDanCourse",'8th');
			elseif list[10] then
				WritePrefToFile("OptionRowDanCourse",'9th');
			elseif list[11] then
				WritePrefToFile("OptionRowDanCourse",'10th');
			elseif list[12] then
				WritePrefToFile("OptionRowDanCourse",'Kaiden');
			else
				WritePrefToFile("OptionRowDanCourse",'None');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowArrowType()
 	local t = {
		Name = "ArrowType";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = false;
		ExportOnChange = true;
		Choices = {"Normal" ,"Classic", "Cyber", "X", "Medium", "Small", "Dot" };
		LoadSelections = function(self, list, pn)
		local pName = ToEnumShortString(pn)
			if ReadPrefFromFile("OptionRowArrowType"..pName) ~= nil then
				if GetUserPref("OptionRowArrowType"..pName)=='Normal' then
					list[1] = true
				elseif GetUserPref("OptionRowArrowType"..pName)=='Classic' then
					list[2] = true
				elseif GetUserPref("OptionRowArrowType"..pName)=='Cyber' then
					list[3] = true
				elseif GetUserPref("OptionRowArrowType"..pName)=='X' then
					list[4] = true
				elseif GetUserPref("OptionRowArrowType"..pName)=='Medium' then
					list[5] = true
				elseif GetUserPref("OptionRowArrowType"..pName)=='Small' then
					list[6] = true
				elseif GetUserPref("OptionRowArrowType"..pName)=='Dot' then
					list[7] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowArrowType"..pName,'Normal');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			if list[1] then
				WritePrefToFile("OptionRowArrowType"..pName,'Normal');
			elseif list[2] then
				WritePrefToFile("OptionRowArrowType"..pName,'Classic');
			elseif list[3] then
				WritePrefToFile("OptionRowArrowType"..pName,'Cyber');
			elseif list[4] then
				WritePrefToFile("OptionRowArrowType"..pName,'X');
			elseif list[5] then
				WritePrefToFile("OptionRowArrowType"..pName,'Medium');
			elseif list[6] then
				WritePrefToFile("OptionRowArrowType"..pName,'Small');
			elseif list[7] then
				WritePrefToFile("OptionRowArrowType"..pName,'Dot');
			else
				WritePrefToFile("OptionRowArrowType"..pName,'Normal');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowArrowColor()
 	local t = {
		Name = "ArrowColor";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = false;
		ExportOnChange = true;
		Choices = {"Rainbow" ,"Note", "Vivid", "Flat", "SMNote" };
		LoadSelections = function(self, list, pn)
		local pName = ToEnumShortString(pn)
			if ReadPrefFromFile("OptionRowArrowColor"..pName) ~= nil then
				if GetUserPref("OptionRowArrowColor"..pName)=='Rainbow' then
					list[1] = true
				elseif GetUserPref("OptionRowArrowColor"..pName)=='Note' then
					list[2] = true
				elseif GetUserPref("OptionRowArrowColor"..pName)=='Vivid' then
					list[3] = true
				elseif GetUserPref("OptionRowArrowColor"..pName)=='Flat' then
					list[4] = true
				elseif GetUserPref("OptionRowArrowColor"..pName)=='SMNote' then
					list[5] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowArrowColor"..pName,'Rainbow');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			if list[1] then
				WritePrefToFile("OptionRowArrowColor"..pName,'Rainbow');
			elseif list[2] then
				WritePrefToFile("OptionRowArrowColor"..pName,'Note');
			elseif list[3] then
				WritePrefToFile("OptionRowArrowColor"..pName,'Vivid');
			elseif list[4] then
				WritePrefToFile("OptionRowArrowColor"..pName,'Flat');
			elseif list[5] then
				WritePrefToFile("OptionRowArrowColor"..pName,'SMNote');
			else
				WritePrefToFile("OptionRowArrowColor"..pName,'Rainbow');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowNTOption()
	local t = {
		Name = "NTOption";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Off", "On", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("NTOption") ~= nil then
				if GetUserPref("NTOption")=='Off' then
					list[1] = true
				elseif GetUserPref("NTOption")=='On' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("NTOption",'Off');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("NTOption",'Off');
			elseif list[2] then
				WritePrefToFile("NTOption",'On');
			else
				WritePrefToFile("NTOption",'Off');
			end;
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowEXScore()
	local t = {
		Name = "EXScore";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = true;
		Choices = {"Off", "On", };
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("OptionRowEXScore") ~= nil then
				if GetUserPref("OptionRowEXScore")=='Off' then
					list[1] = true
				elseif GetUserPref("OptionRowEXScore")=='On' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("OptionRowEXScore",'Off');
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("OptionRowEXScore",'Off');
			elseif list[2] then
				WritePrefToFile("OptionRowEXScore",'On');
			else
				WritePrefToFile("OptionRowEXScore",'Off');
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end

function OptionRowGauge()
	local t = {
		Name="Gauge",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = true,
		Choices = {"NORMAL", "LIFE4", "RISKY"};
		LoadSelections = function(self, list, pn)
			local po = GAMESTATE:GetPlayerState(pn):GetPlayerOptionsArray("ModsLevel_Preferred")
				if table.search(po, "4Lives") then
					list[2] = true
				elseif table.search(po, "1Lives") then
					list[3] = true
				else
					list[1] = true
				end
		end,
		SaveSelections = function(self, list, pn)
			local mod
			if list[2] then
				mod = "4 lives,battery,failimmediate"
			elseif list[3] then
				mod = "1 lives,battery,failimmediate"
			else
				mod = "bar,failimmediate"
			end
			if mod ~= "" then
				GAMESTATE:ApplyPreferredModifiers(pn, mod)
			end
		end,
	};
	setmetatable(t, t);
	return t;
end

--CODE BY Simply Love
function EditorNoteskin()
	local skins = NOTESKIN:GetNoteSkinNames()
	return {
		Name = "EditorNoteSkin",
		LayoutType = "ShowOneInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = skins,
		LoadSelections = function(self, list, pn)
			local skin = PREFSMAN:GetPreference("EditorNoteSkinP1") or
				PREFSMAN:GetPreference("EditorNoteSkinP2") or
				THEME:GetMetric("Common", "DefaultNoteSkinName")
			if not skin then return end

			local i = FindInTable(skin, skins) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1, #skins do
				if list[i] then
					PREFSMAN:SetPreference("EditorNoteSkinP1", skins[i])
					PREFSMAN:SetPreference("EditorNoteSkinP2", skins[i])
					break
				end
			end
		end,
	}
end
--CODE BY Simply Love