#include <Servo.h>
Servo myservo; // biến tên myservo của động cơ servo

//cảm biến đèn
int cambien = 5;
int led_den = 2; 
int gt;
int btn_khancap = 1;
int cambien_last_state = 0;

unsigned long time = 0;

bool btn_khancap_clicked = false;
// 0 là trạng thái cơ bản, 1 là báo cháy (chớp tắt) (Single click), 2 là mở tất cả đèn (Double click), 3 là tắt hết tất cả đèn (Long-press)
int btn03_state = 0;
int led_state = 0;
bool alert = false;

//Cửa
int servo = 6; // chân số 6
int bientro = A0; // chân A0
int gtbientro; //lưu giá trị biến trở
int vtservo; // lưu giá trị đọc từ biến trở đổi sang góc
int lastvtservo = 0;
int bamxung;


void setup() {
  //led
  pinMode(cambien,INPUT);
  pinMode(led_den,OUTPUT);
  pinMode(btn_khancap, INPUT);
   //servo
  myservo.attach(6);

  cambien_last_state = digitalRead(cambien);
}

void loop() {
  // biến chung
  gtbientro = analogRead(bientro);
  bamxung = map(gtbientro,0,1023,0,255);
  gt = digitalRead(cambien);
  //cảm biến đèn
  if(gt==0)
  {
    if(millis() - time >= 500){
      digitalWrite(led_den, HIGH);

      cambien_last_state = gt;

      time = millis();
    }
  }
  else if(gt == 1)
  {
    if(millis() - time >= 5000){
      digitalWrite(led_den, LOW);

      cambien_last_state = gt;

      time = millis();
    }
  }

  if(bamxung <= 50){
    myservo.write(85);
  }

  if(bamxung > 50 && bamxung < 205){
    myservo.write(90);
  }

  if(bamxung >= 205){
    myservo.write(100);
  }
}
