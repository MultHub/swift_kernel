if _G.COSVER then return end

_G.COSVER = _HOST or "ComputerCraft ".._CC_VERSION

-- I love optimization, guys!
local log_premes
local log_fullmes

local log = function(info, level)
  level = level or "verbose"

  log_premes = "["..level.."]"
  log_fullmes = log_premes..": "..tostring(info)

  onlyCI("log", level, log_fullmes)
  term.blit( log_fullmes, string.rep("b", #log_premes)..string.rep("3", #log_fullmes-#log_premes), string.rep("f", #log_fullmes) )
  print()
end

log("Swift is starting!", "info")

local libload = fs.list("/lib")
local testload = fs.list("/sbin/tests")

for i=1, #libload do
  log("Loading library from file '"..libload[i].."'", "debug")
  loadfile( fs.combine( "/lib", libload[i] ) )()
end

if howlci then
  for i=1, #testload do
    if string.sub(testload[i], 3, 3) == "_" then
      log("Running test '"..testload[i].."'!", "info")
      proc.create( loadfile( fs.combine("/sbin/tests", testload[i]) ), "TEST_"..testload[i] )
    end
  end
end


onlyCI( "status", "pass", "Boot success! (".._G.COSVER..")" )
onlyCI( "close" )
