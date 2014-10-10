#!/usr/bin/env lua

addonData = { ["version"] = "1.0",
}

require "wowTest"

test.outFileName = "testOut.xml"


-- require the file to test
package.path = "../src/?.lua;'" .. package.path
require "RegsLootRoll"


function test.before()
	myParty.raid = 1
	myParty.roster = {
						[ 1]={"name", "rank", 1, 90, "Priest", "PRIEST", "zone", 1, nil, "role", nil},
						[ 2]={"name2", "rank2", 1, 90, "Priest", "PRIEST", "zone", 1, nil, "role", nil},
						[ 3]={"name3", "rank3", 1, 90, "Priest", "PRIEST", "zone", 1, nil, "role", 1},
					}
end
function test.after()
	RLR.raidMasterLooterName = nil
	RLR.raidMasterLooterIndex = nil
end
function test.testIsInRaid_False()
	myParty = {}
	assertIsNil( IsInRaid() )
end
function test.testIsInRaid_True()
	assertEquals( 1, IsInRaid() )
	assertTrue( IsInRaid() )
end
function test.testGetNumGroupMembers()
	assertEquals( 3, GetNumGroupMembers() )
end
function test.testEvent_GROUP_ROSTER_UPDATE_updatesIndex()
	RLR.GROUP_ROSTER_UPDATE()
	assertEquals( 3, RLR.raidMasterLooterIndex )
end
function test.testEvent_GROUP_ROSTER_UPDATE_updatesName()
	RLR.GROUP_ROSTER_UPDATE()
	assertEquals( "name3", RLR.raidMasterLooterName )
end
function test.testEvent_GROUP_ROSTER_UPDATE_firedTwice_noChange_name()
	RLR.GROUP_ROSTER_UPDATE()
	RLR.GROUP_ROSTER_UPDATE()
	assertEquals( "name3", RLR.raidMasterLooterName )
end
function test.testFindLootMaster_index()
	local index, name = RLR.FindLootMaster()
	assertEquals( 3, index )
end
function test.testFindLootMaster_name()
	local index, name = RLR.FindLootMaster()
	assertEquals( "name3", name )
end
function test.testFindLootMaster_index_noGroup()
	myParty = { ["roster"]={} }
	local index, name = RLR.FindLootMaster()
	assertEquals( 0, index )
end
function test.testFindLootMaster_name_noGroup()
	myParty = { ["roster"]={} }
	local index, name = RLR.FindLootMaster()
	assertIsNil( name )
end


test.run()
