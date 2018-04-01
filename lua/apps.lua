--[[
wifi.lua | Eduard Bohacek
modul pripojenia na wifi
--]]

connected = 0
station_cfg={}
station_cfg.ssid=wifi_ssid
station_cfg.pwd=wifi_password


print("Wifi Start")
wifi.setmode(wifi.STATION)
wifi.sta.config(station_cfg)
wifi.sta.connect()
count =0

m = nil
mqtt_count=0
relay = "OFF"
-- Sends a simple ping to the broker
function read_door()
    local check = gpio.read(door_pin)
    if (check == 1) then 
        door = "OFF"
    else
        door = "ON"
    end
end
function send_ping() 
    --mqtt_count = mqtt_count + 1
    --m:publish(mqtt_ENDPOINT .. "ping",mqtt_count,0,0)
    read_door()
    m:publish(mqtt_ENDPOINT .. "temp",dht_temp,0,0)
    m:publish(mqtt_ENDPOINT .. "humid",dht_humi,0,0)
    m:publish(mqtt_ENDPOINT .. "door",door,0,0)
    m:publish(mqtt_ENDPOINT .. "light",adc.read(0),0,0)
    m:publish(mqtt_ENDPOINT .. "relay",relay,0,0 )
--    print(dht_humi .. ", " .. dht_temp)
end

function receive_mqtt()
    m:subscribe(mqtt_ENDPOINT .. "command",0,function (conn)
        --print("received Edo")
    end)
end
-- poslanie IP na broker pre registaciu
function register_myself()
    m:subscribe(mqtt_ENDPOINT .. mqtt_ID,0,function(conn)
        print("Successfully subscribed to data endpoint")
    end)
end


function mqtt_start()
    print ("mqtt Start")
    m = mqtt.Client(mqtt_ID, 120)
    -- register message callback beforehand
        m:on("message", function(conn, topic, data) 
      if data ~= nil then
        if (data ~= "1")then
            print(topic .. ": " .. data)
        end    
        if (data == "2" )then
           gpio.write(Rele_pin,gpio.HIGH)
           relay = "OFF"
           print("receive relay 2 = off") 
        end
        if (data == "3")then
            gpio.write(Rele_pin,gpio.LOW)
            relay = "ON"
            print("receive relay 3 =on")
        end
        if (data == "9")then 
            m:publish(mqtt_ENDPOINT .. "ip",ip,0,0 )
            print("receive ip") 
        end
        -- do something, we have received a message
      end
    end)
    -- Connect to broker
    m:connect(mqtt_HOST, mqtt_PORT, 0, 1, function(con) 
        register_myself()
        m:publish(mqtt_ENDPOINT .. "ip",ip,0,0 )
        -- And then pings each 1000 milliseconds
        tmr.stop(6)
        tmr.alarm(6, 5000, 1, send_ping)
        tmr.stop(5)
        tmr.alarm(5, 2500, 1, receive_mqtt)
    end) 

end

function func_read_dht()
--  print("sem1")
  status, temp, humi, temp_dec, humi_dec = dht.read(dht_pin)
  if( status == dht.OK ) then
-- Integer firmware use this code
    dht_temp = math.floor(temp).."."..temp_dec
    dht_humi = math.floor(humi).."."..humi_dec
--    print("DHT Temperature: "..math.floor(temp).."."..temp_dec.." C")
--    print("DHT Humidity: "..math.floor(humi).."."..humi_dec.." %")  
-- Float firmware uuse this code
--[[    dht_temp = temp
    dht_humi = humi
    print("DHT Temperature: "..temp.." C")
    print("DHT Humidity:    "..humi.." %")
--]]    
  elseif( dht_status == dht.ERROR_CHECKSUM ) then          
    print( "DHT Checksum error" )
  elseif( dht_status == dht.ERROR_TIMEOUT ) then
    print( "DHT Time out" )
  end
--   print("konec")
end

function func_exec_loop()
  if wifi.sta.status() == 5 then  --STA_GOTIP
    if connected == 0 then
      tmr.stop(4)
      LED_time=1000
      tmr.interval(4,LED_time)
      tmr.start(4)
      print("Connected to "..wifi.sta.getip())
      ip = wifi.sta.getip()
      connected = 1
      mqtt_start()
    end
    if count >= 10 then
      func_read_dht()
      count = 0
    else
      count = count + 1
    end
  else
    --tmr.stop(1)
    if connected == 1 then
      tmr.stop(4)
      LED_time=100
      tmr.interval(4,LED_time)
      tmr.start(4)
    end
    count = 0
    connected = 0
    print("Still connecting...")
  end
end


tmr.alarm(2,500,1,func_exec_loop)
--tmr.alarm(5,1200,1,plot)
