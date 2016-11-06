if not howlci then return end

-- Marco/Polo process test. This ensures process launching AND the IPM system works.
local TestA = proc.create( loadfile("/sbin/tests/00_proc_test.lua"), "citest-proc" )

while proc.status( TestA ) ~= "dead" then -- we wait for the first test to die.
  sleep(1)
end

-- do other tests

return
