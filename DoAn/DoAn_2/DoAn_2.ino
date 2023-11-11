#include <Servo.h>
Servo myservo; // biến tên myservo của động cơ servo

//cảm biến đèn
int cambien = 5;
int led_den = 7;
int gt;
// cảm biến nhiệt
int led_nhiet = 8; // Chân kết nối với đèn LED
//Cửa
int servo = 6; // chân số 6
int bientro = A0; // chân A0
int gtbientro; //lưu giá trị biến trở
int vtservo; // lưu giá trị đọc từ biến trở đổi sang góc


void setup() {
  //led
  pinMode(cambien,INPUT);
  pinMode(led_den,OUTPUT);
  //nhiệt
  pinMode(led_nhiet, OUTPUT);
   //servo
  myservo.attach(servo);
  Serial.begin(9600); // Thiết lập chân ledPin là OUTPUT
 
 
}

void loop() {
  // biến chung
  gtbientro = analogRead(bientro);
  gt = digitalRead(cambien);
  vtservo = map(gtbientro,0,1023,0,180);
  float temp = (gtbientro *5.0/1024.0)*100.0 ; // Chuyển đổi giá trị cảm biến thành nhiệt độ
  //cảm biến đèn
  if(gt==1)
  {
    Serial.print("gt: ");
    Serial.println(gt);
    Serial.print(" led - off");
    delay(1000);
    digitalWrite(led_den,0);
  }
  else
  {
    Serial.print("gt: ");
    Serial.println(gt);
    Serial.print(" led - on");
    digitalWrite(led_den,1);
  }
  //cảm biến nhiệt
  Serial.print("temp: ");
  Serial.println(temp);
  if (temp > 40) { // Nếu nhiệt độ lớn hơn 40°C
    digitalWrite(led_nhiet, 1); // Bật đèn LED
  } else {
    digitalWrite(led_nhiet, 0); // Tắt đèn LED
  }
  delay(1000); // Đợi 1 giây
  //servo
  myservo.write(vtservo);
  Serial.print("góc: ");
  Serial.println(vtservo);
  delay(500);
}
