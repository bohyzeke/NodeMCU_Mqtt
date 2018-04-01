--[[
blik.lua | Eduard Bohacek
modul blikania ledkou
--]]


lighton=0  --docasna premenna pre led

gpio.mode(LED_pin,gpio.OUTPUT) -- Assign GPIO to Output

 function blink()
    if (lighton==0) then
        lighton=1
        gpio.write(LED_pin,gpio.HIGH)     -- Assign GPIO On
        --print('on')
    else
        lighton=0
         gpio.write(LED_pin,gpio.LOW)     -- Assign GPIO off
         --print('off')
    end
end


tmr.alarm(4,LED_time,1,blink)
