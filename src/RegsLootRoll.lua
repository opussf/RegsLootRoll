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

-- Events
function RLR.OnLoad()
	SLASH_RLR1 = "/RLR"
	SlashCmdList["RLR"] = function(msg) RLR.Command( msg ); end
	RLR_Frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	RLR_Frame:RegisterEvent("GROUP_ROSTER_UPDATE");
end
function RLR.PARTY_MEMBERS_CHANGED()
	RLR.Print("PARTY_MEMBERS_CHANGED")
end
function RLR.GROUP_ROSTER_UPDATE()
	RLR.Print("GROUP_ROSTER_UPDATE")
end
-- End Events

-- Code
function RLR.FindLootMaster()
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
end
function RLR.ParseCmd(msg)
	if msg then
		local i,c = strmatch(msg, "^(|c.*|r)%s*(%d*)$")
		if i then  -- i is an item, c is a count or nil
			return i, c
		else  -- Not a valid item link
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
}