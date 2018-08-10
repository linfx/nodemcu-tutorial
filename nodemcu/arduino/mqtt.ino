#include <ESP8266MQTTClient.h>
#include <ESP8266WiFi.h>
MQTTClient mqtt;
#define relay LED_BUILTIN//定义开发版中的LED

void setup() {
  Serial.begin(115200);
  pinMode(LED_BUILTIN,OUTPUT);//设置输出模式

  WiFi.begin("pc-lin", "123456789");//WiFi名称和密码

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  //topic, data, data is continuing
  mqtt.onData([](String topic, String data, bool cont) {
    Serial.printf("Data received, topic: %s, data: %s\r\n", topic.c_str(), data.c_str());
    //mqtt.unSubscribe("/qos1");

    //处理接收到的数据，接收1就点亮LED，接收到0就关掉LED
    Serial.println("Data received,topic: %s,data:%s\r\n",topic.c_str(),data.c_str());
    if(data=="1")
    {
      digitalWrite(LED_BUILTIN,LOW);
    }
    if(data=="0")
    {
      digitalWrite(LED_BUILTIN,HIGH);
    }


  });

  mqtt.onSubscribe([](int sub_id) {
    Serial.printf("Subscribe topic id: %d ok\r\n", sub_id);
    mqtt.publish("/qos1", "qos0", 0, 0);
  });
  mqtt.onConnect([]() {
    Serial.printf("MQTT: Connected\r\n");
    Serial.printf("Subscribe id: %d\r\n", mqtt.subscribe("/qos1", 0));
//    mqtt.subscribe("/qos1", 1);
//    mqtt.subscribe("/qos2", 2);
  });

  //例子中的程序给的有问题，后面调试发现会执行onDisconnect方法，而这个方法没有定义，所以一直报错，后面发现github上有人提过issue
  mqtt.onDisconnect([}(){
    Serial.println("MQTT:Disconnect");
  }])

  mqtt.begin("mqtt://admin:public@mqtt.wayto.com.cn:1883");//这里将ip换成启动emqtt服务的电脑ip地址
//  mqtt.begin("mqtt://test.mosquitto.org:1883", {.lwtTopic = "hello", .lwtMsg = "offline", .lwtQos = 0, .lwtRetain = 0});
//  mqtt.begin("mqtt://user:pass@mosquito.org:1883");
//  mqtt.begin("mqtt://user:pass@mosquito.org:1883#clientId");

}

void loop() {
  mqtt.handle();
}