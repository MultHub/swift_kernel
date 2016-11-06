local a = _G.POLO_ID



local _, mes = proc.ipm.receive()

if mes == "MARCO!" then
  _G.GOTMARCO = true
  print("MARCO!")
end

sleep(0.5)

proc.ipm.send( a, "POLO!" )

return
