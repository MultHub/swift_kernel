

local marco = loadfile("/sbin/tests/marco.lua")
local polo = loadfile("/sbin/tests/polo.lua")

setfenv(marco, getfenv(0))
setfenv(polo, getfenv(0))

_G.MARCO_ID = proc.create( marco, "Marco" )
_G.POLO_ID = proc.create( polo, "Polo" )


howlci.log("debug", "Current running processes:")
local procyon = proc.list() --I was gonna name the var "procl" but then I saw a huge chance to name it "procyon"! Procyon is a star, also know as Alpha Canis Minoris.
for k,v in pairs(procyon) do
  howlci.log("debug", "ID: "..tostring(k).." / Name: "..tostring(v.name).." / Status: "..tostring(v.status))
end

print("waiting for marco/polo completion...")
os.pullEvent("POLO!")
if (_G.GOTMARCO == true) and (_G.GOTPOLO == true) then
  proc.kill( _G.MARCO_ID )
  proc.kill( _G.POLO_ID )
  print("marco/polo success!")
  howlci.log("info", "Marco/Polo success!")
  howci.log("debug", "exiting proc test")
else
  howlci.status("fail", "Marco/Polo process test failed!")
  printError("Marco/Polo process test failed!")
end
return "something, i dunno, what am I supposed to return?! am I supposed to take over mars or something?!"
