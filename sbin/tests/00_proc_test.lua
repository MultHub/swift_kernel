
_G.MARCO_ID = proc.create( loadfile("/sbin/tests/marco.lua"), "Marco" )
_G.POLO_ID = proc.create( loadfile("/sbin/tests/polo.lua"), "Polo" )

local done = false

howlci.log("debug", "Current running processes:")
local procyon = proc.list() --I was gonna name the var "procl" but then I saw a huge chance to name it "procyon"! Procyon is a star, also know as Alpha Canis Minoris.
for k,v in pairs(procyon) do
  howlci.log("debug", "ID: "..tostring(k).." / Name: "..tostring(v.name).." / Status: "..tostring(v.status))
end

for i=1, 5 do
  print("waiting 2 secs to check for marco/polo completion... (try "..tostring(i)..")")
  sleep(2)
  if _G.GOTMARCO and _G.GOTPOLO then
    proc.kill( _G.MARCO_ID )
    proc.kill( _G.POLO_ID )
    done = true
    print("marco/polo success!")
    howlci.log("info", "Marco/Polo success!")
    break
  end
end

if done then
  howci.log("debug", "exiting proc test")
  return
else
  howlci.status("fail", "Marco/Polo process test failed!")
  printError("Marco/Polo process test failed!")
end
error()
