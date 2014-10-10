RLR_MSG_ADDONNAME = "RegsLootRoll"
RLR_MSG_VERSION   = GetAddOnMetadata(RLR_MSG_ADDONNAME,"Version")
RLR_MSG_AUTHOR    = GetAddOnMetadata(RLR_MSG_ADDONNAME,"Author")

-- Colours
COLOR_RED = "|cffff0000";
COLOR_GREEN = "|cff00ff00";
COLOR_BLUE = "|cff0000ff";
COLOR_PURPLE = "|cff700090";
COLOR_YELLOW = "|cffffff00";
COLOR_ORANGE = "|cffff6d00";
COLOR_GREY = "|cff808080";
COLOR_GOLD = "|cffcfb52b";
COLOR_NEON_BLUE = "|cff4d4dff";
COLOR_END = "|r";

RLR = {}
RLR.inRaid = false
RLR.raidMasterLooter = {}

-- Events
function RLR.OnLoad()
	SLASH_RLR1 = "/RLR"
	SlashCmdList["RLR"] = function(msg) RLR.Command( msg ); end
	RLR_Frame:RegisterEvent("GROUP_ROSTER_UPDATE");
	RLR.Print("is Loaded")
	--[[

	"CHAT_MSG_PARTY"
	"CHAT_MSG_PARTY_LEADER"
	"CHAT_MSG_RAID"
	"CHAT_MSG_RAID_LEADER"
	"CHAT_MSG_RAID_WARNING"
	]]
end
function RLR.GROUP_ROSTER_UPDATE()  -- Once debug is done, have these functions alias UpdatePartyInfo
	--RLR.Print("GROUP_ROSTER_UPDATE")
	RLR.UpdatePartyInfo()
end
-- End Events

-- Code
function RLR.UpdatePartyInfo()
	local previousName = RLR.raidMasterLooterName
	RLR.raidMasterLooterIndex, RLR.raidMasterLooterName = RLR.FindLootMaster()
	if (not previousName) and not (previousName == RLR.raidMasterLooterName)   then
		RLR.Print( string.format( "%s (% 2i) is the MasterLooter", RLR.raidMasterLooterName, RLR.raidMasterLooterIndex ) )
	end
end
function RLR.FindLootMaster()
	-- returns the index, and their name
	local numGroupMembers = GetNumGroupMembers()
	--RLR.Print("numGroupMembers: "..numGroupMembers )
	local mlName = nil
	local index = 0
	for i= 1, numGroupMembers do
		mlName, _, _, _, _, _, _, _, _, _, isML = GetRaidRosterInfo( i )
		if isML then index = i; break end
	end

--	RLR.Print( string.format( "% 2i Members. %s is the MasterLooter", numGroupMembers, ( mlName or "nil" ) ) )
	return index, mlName
end

-- End Code

-- Support Code
function RLR.Print( msg, showName)
	-- print to the chat frame
	-- set showName to false to suppress the addon name printing
	if (showName == nil) or (showName) then
		msg = COLOR_PURPLE..RLR_MSG_ADDONNAME.."> "..COLOR_END..msg
	end
	DEFAULT_CHAT_FRAME:AddMessage( msg )
end
function RLR.PrintHelp()
	RLR.Print(RLR_MSG_ADDONNAME.." by "..RLR_MSG_AUTHOR.." version: "..RLR_MSG_VERSION);
	for cmd, info in pairs(RLR.CommandList) do
		RLR.Print(string.format("%s %s %s -> %s",
			SLASH_RLR1, cmd, info.help[1], info.help[2]));
	end
end
function RLR.ParseCmd(msg)
	if msg then
		msg = string.lower(msg)
		local a,b,c = strfind(msg, "(%S+)")  --contiguous string of non-space characters
		if a then
			-- c is the matched string, strsub is everything after that, skipping the space
			return c, strsub(msg, b+2)
		else
			return ""
		end
	end
end
function RLR.Command(msg)
	local cmd, param = RLR.ParseCmd(msg);
	--INEED.Print("cl:"..cmd.." p:"..(param or "nil") )
	local cmdFunc = RLR.CommandList[cmd];
	if cmdFunc then
		cmdFunc.func(param);
	else
		RLR.PrintHelp()
	end
end

-- this needs to be at the end because it is referencing functions
RLR.CommandList = {
	["help"] = {
		["func"] = RLR.PrintHelp,
		["help"] = {"","Print this help."},
	},
	["test"] = {
		["func"] = RLR.UpdatePartyInfo,
		["help"] = {"","Show info."},
	},
}