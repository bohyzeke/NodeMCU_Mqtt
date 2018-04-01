--[[
config.lua | Eduard Bohacek
globalne premenne pre skripty
--]]

--[[
GPIO nastavenia
io   
4   LED na doske 



--]]

--wifi modul
wifi_ssid = "bohacek2_4G"
--wifi_password = "123456789"
wifi_password = "bohyzeke24"

--DHT modul
dht_pin = 2      -- Pin pre DHT22 senzor(D2)
dht_temp = 0     -- vypocitana teplota
dht_humi = 0     -- vypocitana vlhkost
DHT_time = 3000  -- cas nacitavania snimaca

-- LED Pin
LED_pin = 4
LED_time = 100

-- Rele Pin
Rele_pin = 0 
gpio.mode(Rele_pin,gpio.OUTPUT) -- Assign GPIO to Output

-- door Pin
door_pin = 1
gpio.mode(door_pin,gpio.INPUT,gpio.PULLUPP)
gpio.write(door_pin,gpio.HIGH)
--mqtt
mqtt_HOST = "192.168.0.105"
--mqtt_HOST = "192.168.0.100"
mqtt_PORT = 1883
mqtt_ID = node.chipid()
mqtt_ENDPOINT = "home/mcu1/"


-- Stavovy odkaz
print("Globalne premenne nacitane")
