if not howlci then return end

-- Marco/Polo process test. This ensures process launching AND the IPM system works.
loadfile("/sbin/tests/00_proc_test.lua")()
