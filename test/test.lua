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

test.run()
