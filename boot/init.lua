if _G.COSVER then return end

_G.COSVER = _HOST or "ComputerCraft ".._CC_VERSION

-- I love optimization, guys!
local log_premes
local log_fullmes

local log = function(info, level)
  level = level or "verbose"

  log_premes = "["..level.." @ "..tostring(os.clock()).."]"
  log_fullmes = "["..level.." @ "..tostring(os.clock()).."]: "..tostring(info)

  onlyCI("log", level, log_fullmes)
  term.blit( log_fullmes, string.rep("b", #log_premes)..string.rep("3", #log_fullmes-#log_premes), string.rep("f", #log_fullmes) )
  print()
end

log("Swift is starting!", "info")

local libload = fs.list("/lib")

for i=1, #libload do
  log("Loading library from file '"..libload[i].."'", "verbose")
  loadfile( fs.combine( "/lib", libload[i] ) )()
end

onlyCI( "status", "pass", "It worked! Yay! (".._G.COSVER..")" )
onlyCI( "close" )
