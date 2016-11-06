if _G.proc then return end




local se = {}
_G.proc = {}
_G.proc.ipm = {}


local re

proc.create = function(func, name)
  if type(func) == "string" then
    func = loadfile(func)
  end
  if type(func) ~= "function" then
    error("Expected function, got "..type(func).." instead. 0/10 would not wrongly execute again", 2)
  end
  ret = #se+1
  se[ret] = {
    ["run"] = coroutine.create(func),
    ["name"] = name,
  }
  onlyCI("log", "debug", "Created a process with the id of "..tostring(#se+1))
  return ret
end

proc.kill = function(id)
  if not se[id] then
    error("A process with an id of '"..tostring(id).."' does not exist, so it cannot be killed.", 2)
  end
  if se[id].veryImportant then
    error("The process with an id of '"..tostring(id).."' is important and cannot be killed!", 2)
  end
  se[id] = nil
  onlyCI("log", "debug", "Killed a process with the id of "..tostring(#se+1))
end

local list
local idunno

local yieldTime
local yield = function()
        if yieldTime then -- check if it already yielded
                if os.clock() - yieldTime > 2 then -- if it were more than 2 seconds since the last yield
                        os.queueEvent("someFakeEvent") -- queue the event
                        os.pullEvent("someFakeEvent") -- pull it
                        yieldTime = nil -- reset the counter
                end
        else
                yieldTime = os.clock() -- store the time
        end
end

proc.list = function()
  list = {}
  for i=1, #se do
    idunno = se[i]
    list[i] = {
      ["name"] = idunno.name,
      ["status"] = coroutine.status(idunno.run),
      ["veryImportant"] = idunno.veryImportant
    }
  end
  return list
end

proc.status = function(id)
  if not se[id] then
    error("A process with an id of '"..tostring(id).."' does not exist, so the status for it cannot be fetched.", 2)
  end
  return coroutine.status( se[id].run )
end

proc["end"] = function(id, reason)
  if not se[id] then
    error("A process with an id of '"..tostring(id).."' does not exist, so it cannot be asked to end itself.", 2)
  end

  coroutine.resume( se[id].run, "end", reason )

end

proc.idExists = function(id)
  return (se.id.run ~= nil)
end


proc.ipm.queueEvent = function(id, ...)
  if not se[id] then
    error("A process with an id of '"..tostring(id).."' does not exist, so I don't know who to text.", 2)
  end

  coroutine.resume( se[id].run, ... )
end

proc.ipm.send = function(id, ...)
  proc.ipm.queueEvent( id, "ipm_receive", ... )
end

proc.ipm.receive = function()
  return os.pullEventRaw("ipm_receive")
end


local sysboot = proc.create("/boot/init.lua", "sysboot")
se[sysboot]["veryImportant"] = true

local ok
local err

local function update()
  local evt = {coroutine.yield()}
  for i=1, #se do
    if se[i] and se[i].run then
      if coroutine.status(se[i].run) ~= "dead" then
        ok, err = coroutine.resume(se[i].run, unpack(evt))
        if ok ~= nil and ok ~= true then
          -- now son, don't touch that cactus
          table.remove( se[i] ) -- YOU'RE DEAD TO ME.
        end
      else
        table.remove( se[i] ) -- let's save the garbage collector some work.. he'll appreciate it!
      end
    end
  end
end

while true do
  update()
  yield()
end
