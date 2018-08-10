// const int buttonPin = 0;
// const int ledPin =  16;
// int buttonState = 0;

// // 对Arduino电路板或相关状态进行初始化方法
// void setup() {
//   // 设置ledPin端口为输出端口
//   pinMode(ledPin, OUTPUT);
//   // 设置buttonPin端口为输入端口
//   pinMode(buttonPin, INPUT);
// }

// // 系统调用，无限循环方法
// void loop() {
//   // 读取按键状态
//   buttonState = digitalRead(buttonPin);

//   // 检查按键状态，
//   // 如果为HIGH，
//   // 则点亮LED神灯，
//   // 否则熄灭LED神灯。
//   if (buttonState == HIGH) {
//     // 点亮LED神灯
//     digitalWrite(ledPin, HIGH);
//   } else {
//     // 熄灭LED神灯
//     digitalWrite(ledPin, LOW);
//   }
// }