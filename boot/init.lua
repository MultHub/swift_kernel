local function onlyCI(func, ...)
  if howlci then howlci[func](...) end
end

-- I love optimization, guys!
local log_premes
local log_fullmes

local function log(info, level)
  level = level or "verbose"

  log_premes = "["..level.." @ "..tostring(os.clock()).."]"
  log_fullmes = "["..level.." @ "..tostring(os.clock()).."]: "..tostring(info)

  onlyCI("log", level, log_fullmes)
  term.blit( log_fullmes, string.rep("b", #log_premes)..string.rep("3", #log_fullmes-#log_premes), string.rep("f", #log_fullmes) )
end

log("Swift is starting!", "info")
onlyCI( "status", "pass", "this boot worked! yey!" )
onlyCI( "close" )
