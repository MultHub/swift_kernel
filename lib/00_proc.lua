if _G.proc then return end

local se = {}
_G.proc = {}


proc.create = function(func, name)
  se[#se+1] = {
    ["run"] = coroutine.create(func),
    ["name"] = name,
  }
  onlyCI("log", "debug", "Created a process with the id of "..tostring(#se+1))
end

proc.kill = function(id)
  if not se[id] then
    error("A process with an id of '"..tostring(id).."' does not exist, so it cannot be killed.")
  end
  se[id] = nil
  onlyCI("log", "debug", "Killed a process with the id of "..tostring(#se+1))
end

proc.create(loadfile("/boot/init.lua"), "sysboot")

while true do
  for i=1, #se do
    if se[i] and se[i].run and coroutine.status(se[i].run) ~= "dead" then
      coroutine.resume(se[i].run)
    end
  end
  sleep(0)
end
