--[[
init.lua | Eduard Bohacek
inicializacny modul a spustenie podmodulov
podla https://www.foobarflies.io/a-simple-connected-object-with-nodemcu-and-mqtt/
--]]
uart.setup(0, 115200, 8, 0, 1, 1 )
dofile("config.lua")
dofile('blik.lua')

FileToExecute="apps.lua"
print("You have 15 second to enter file.remove('init.lua') to abort")
tmr.alarm(0, 15000, 0, function()
  print("Executing: ".. FileToExecute)
  dofile(FileToExecute)
end)
