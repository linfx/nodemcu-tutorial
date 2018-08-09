IO_LED = 1
IO_LED_AP = 2
IO_BTN_CFG = 3

gpio.mode(IO_LED, gpio.OUTPUT)
gpio.mode(IO_LED_AP, gpio.OUTPUT)
gpio.mode(IO_BTN_CFG, gpio.INT)

TMR_BTN = 6

function onBtnEvent()
    gpio.trig(IO_BTN_CFG)
    tmr.alarm(TMR_BTN, 500, tmr.ALARM_SINGLE, function()
        gpio.trig(IO_BTN_CFG, 'up', onBtnEvent)
    end)

    print('up~')
    dofile('pwm.lua')
end
gpio.trig(IO_BTN_CFG, 'up', onBtnEvent)
