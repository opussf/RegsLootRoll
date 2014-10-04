#!/usr/bin/env lua

addonData = { ["version"] = "1.0",
}

require "wowTest"

test.outFileName = "testOut.xml"


-- require the file to test
package.path = "../src/?.lua;'" .. package.path
require "RegsLootRoll"


function test.before()
end
function test.after()
end
function test.testNoOp()
end

test.run()
