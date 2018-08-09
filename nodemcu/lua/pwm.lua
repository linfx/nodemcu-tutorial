--GPIO Define
function initGPIO()
--1,2EN     D1 GPIO5
--3,4EN     D2 GPIO4
--1A  ~2A   D3 GPIO0
--3A  ~4A   D4 GPIO2

gpio.mode(0,gpio.OUTPUT);--LED Light on
gpio.write(0,gpio.LOW);

gpio.mode(1,gpio.OUTPUT);gpio.write(1,gpio.LOW);
gpio.mode(2,gpio.OUTPUT);gpio.write(2,gpio.LOW);

gpio.mode(3,gpio.OUTPUT);gpio.write(3,gpio.HIGH);
gpio.mode(4,gpio.OUTPUT);gpio.write(4,gpio.HIGH);

pwm.setup(1,1000,1023);--PWM 1KHz, Duty 1023
pwm.start(1);pwm.setduty(1,0);
pwm.setup(2,1000,1023);
pwm.start(2);pwm.setduty(2,0);
end

--Control Program
print("Start Pwm Control");
initGPIO();

spdTargetA=1023;--target Speed
spdCurrentA=0;--current speed
spdTargetB=1023;--target Speed
spdCurrentB=0;--current speed
stopFlag=false;

tmr.alarm(1, 200, 1, function()
    if stopFlag==false then
        spdCurrentA=spdTargetA;
        spdCurrentB=spdTargetB;
        pwm.setduty(1,800);
        pwm.setduty(2,800);
    else
        pwm.setduty(1,0);
        pwm.setduty(2,0);
    end
end)

