local a = _G.MARCO_ID

sleep( 0.5 )

proc.ipm.send( a, "MARCO!" )

local _, mes = proc.ipm.receive()

if mes == "POLO!" then
  _G.GOTPOLO = true
  print("POLO!")
  os.queueEvent("POLO!")
end

return
