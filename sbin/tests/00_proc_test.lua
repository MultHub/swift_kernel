
_G.MARCO_ID = proc.create( loadfile("/sbin/tests/marco.lua"), "Marco" )
_G.POLO_ID = proc.create( loadfile("/sbin/tests/polo.lua"), "Polo" )

local done = false

for i=1, 5 do
  print("waiting 2 secs to check for marco/polo completion... (try "..tostring(i)..")")
  sleep(2)
  if _G.GOTMARCO and _G.GOTPOLO then
    done = true
    break
  end
end

if done then
  howlci.status("pass", "Marco/Polo process test completed")
else
  howlci.status("fail", "Marco/Polo process test failed!")
  printError("Marco/Polo process test failed!")
end
