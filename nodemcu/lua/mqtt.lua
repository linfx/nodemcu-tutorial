-------------
-- mqtt
-------------
m = mqtt.Client("Node_MM", 120)
m:on("connect", function(client) print ("connected") end) -- 连接到服务器触发事件
m:on("offline", function(client) print ("offline") end)   -- 掉线触发事件 
m:on("message", function(client, topic, data)             -- 收到消息时触发事件 
  print('onMsg')
  if data == '0' then  -- stop
    stopFlag=true;
  elseif data == '1' then  -- forward
    gpio.write(3,gpio.LOW)
    stopFlag=false;
  elseif data == '2' then  -- backward
    gpio.write(3,gpio.HIGH)
    stopFlag=false;
  elseif data == "6" then --A spdUp
    spdTargetA = spdTargetA+50;if(spdTargetA>1023) then spdTargetA=1023;end;
  elseif data == "7" then --A spdDown
    spdTargetA = spdTargetA-50;if(spdTargetA<0) then spdTargetA=0;end;
  end
end)


m:connect(MQTT_HOST, 
  function(client) 
    print("connected")
--  m:publish("/World", "Hello World!", 0, 0)
    m:subscribe("/World",0, function(client) print("subscribe success") end)
  end,
  function(client, reason) 
    print("fail reason" .. reason) 
  end
)

--Control Program
print("Start DoitRobo Control");

spdTargetA=1023;--target Speed
spdCurrentA=0;--current speed
spdTargetB=1023;--target Speed
spdCurrentB=0;--current speed
stopFlag=true;

tmr.alarm(1, 200, 1, function()
    if stopFlag==false then
        spdCurrentA=spdTargetA;
        spdCurrentB=spdTargetB;
        pwm.setduty(1,spdCurrentA);
        pwm.setduty(2,spdCurrentB);
    else
        pwm.setduty(1,0);
        pwm.setduty(2,0);
    end
end)
