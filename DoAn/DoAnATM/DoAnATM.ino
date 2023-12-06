#include <Wire.h>
#include <EEPROM.h>
#include <LiquidCrystal_I2C.h>
#include <Servo.h>
#include <string.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);
Servo myservo;  // Khai báo servo

//Khai báo đèn
int led_phongkhach = 2;
int led_gara = 3;
int led_phongan = 4;
int led_phongngu = 5;
int led_wc = 6;

//Khai báo nút
int btn_cua1 = 7;  // Nút nhấn 1 để chọn ký tự 0
int btn_cua2 = 8;  // Nút nhấn 2 để xác nhận ký tự 1
int btn_khancap = 9;
int btn_phongkhach = 10;
int btn_phongan = 11;
int btn_phongngu = 12;
int btn_gara = 13;

// Analog port
int lm5 = A0;      // chân A0
int bientro = A1;  // chân A0
int servo = A2;    // chân số 6
int cambien = A3;

int gtdienap;   //lưu giá trị điện áp
int gtbientro;  //lưu giá trị biến trở
int vtservo;    // lưu giá trị đọc từ biến trở đổi sang góc
int lastvtservo = 0;
int bamxung;
int diachi_gocservo = 2;
int diachi_phongkhach = 3;
int diachi_wc = 4;
int diachi_phongan = 5;
int diachi_gara = 6;
int diachi_phongngu_st = 7;
int diachi_phongngu_value = 8;
int gt;

int mk[5];     // mảng để lưu trữ mật khẩu nhập vào
int dem = -1;  // Chỉ số của chuỗi
int tam = -1;
bool success = false;             // kiểm tra đăng nhập thành công
bool fail = false;                // kiểm tra đăng nhập thất bại
bool ttl = false;                 //
bool tt = 0;                      // trạng thái nút 1
bool tt1 = 0;                     /// trạng thái nút 2
int ss = 0;                       // chỉ số so sánh
int luoc = 0;                     // số lược nhấn
int mk_d[5] = { 1, 0, 0, 1, 1 };  // mật khẩu
int an, an1;
unsigned long time = 0;
unsigned long time1 = 0;
unsigned long time2 = 0;
unsigned long time3 = 0;
unsigned long time4 = 0;
unsigned long time5 = 0;
unsigned long time6 = 0;
unsigned long time7 = 0;
unsigned long time8 = 0;
unsigned long time9 = 0;
unsigned long time10 = 0;
unsigned long time11 = 0;
unsigned long time12 = 0;

bool khancap_clicked = false;
// 0 là trạng thái cơ bản, 1 là báo cháy (chớp tắt) (Single click), 2 là mở tất cả đèn (Double click), 3 là tắt hết tất cả đèn (Long-press)
int khancap_state = 0;
int led_state = 0;
bool alert = false;
unsigned long khancap_start1 = 0;
unsigned long khancap_start2 = 0;
unsigned long khancap_end1 = 0;
unsigned long khancap_end2 = 0;
byte trangthai_phongkhach = 0;
byte trangthai_wc = 0;
byte trangthai_phongan = 0;
byte trangthai_gara = 0;
byte trangthai_phongngu = 0;
byte wc_state = 0;
byte servo_quay = 0;
byte servo_dung = 0;
int servo_state = 3;

unsigned long t_high_btn08 = 0;
unsigned long t_high2_btn08 = 0;
unsigned long t_low_btn08 = 0;
byte led_value_btn08 = 0;
bool stt_led_btn08 = false;
bool modeled_btn08 = false;


String s;

void setup() {
  // put your setup code here, to run once:

  lcd.init();
  lcd.backlight();
  lcd.print("PASSWORD:");
  lcd.setCursor(0, 1);
  lcd.print("_____");

  pinMode(led_phongkhach, OUTPUT);
  pinMode(led_gara, OUTPUT);
  pinMode(led_phongan, OUTPUT);
  pinMode(led_wc, OUTPUT);
  pinMode(led_phongngu, OUTPUT);

  pinMode(btn_cua1, INPUT);
  pinMode(btn_cua2, INPUT);
  pinMode(btn_khancap, INPUT);
  pinMode(btn_phongkhach, INPUT);
  pinMode(btn_phongngu, INPUT);
  pinMode(btn_phongan, INPUT);
  pinMode(btn_gara, INPUT);

  myservo.attach(servo);

  // vtservo = EEPROM.read(diachi_gocservo);
  trangthai_phongkhach = EEPROM.read(diachi_phongkhach);
  trangthai_wc = EEPROM.read(diachi_wc);
  trangthai_gara = EEPROM.read(diachi_gara);
  trangthai_phongan = EEPROM.read(diachi_phongan);
  trangthai_phongngu = EEPROM.read(diachi_phongngu_st);
  led_value_btn08 = EEPROM.read(diachi_phongngu_value);
  digitalWrite(led_phongkhach, trangthai_phongkhach);
  digitalWrite(led_wc, trangthai_wc);
  digitalWrite(led_gara, trangthai_gara);
  digitalWrite(led_phongan, trangthai_phongan);
  digitalWrite(led_phongngu, trangthai_phongngu);

  // if(khancap_state == 2){
  //   alert = true;
  // }

  if (trangthai_wc == 1) {
    wc_state = 1;
  }

  Serial.begin(115200);
  Serial.println("Start");
}

void ReviceData() {
  if (Serial.available()) {
    s = Serial.readStringUntil('\n');
    Serial.println(s);

    if (s == "btn_wc1") {
      trangthai_wc = 1;
      EEPROM.write(diachi_wc, trangthai_wc);
      digitalWrite(led_wc, trangthai_wc);
      s = "";
      wc_state = 1;
    }

    if (s == "btn_wc0") {
      trangthai_wc = 0;
      EEPROM.write(diachi_wc, trangthai_wc);
      digitalWrite(led_wc, trangthai_wc);
      s = "";
      wc_state = 0;
    }

    if (s == "phongkhach_1") {
      trangthai_phongkhach = 1;
      EEPROM.write(diachi_phongkhach, trangthai_phongkhach);
      digitalWrite(led_phongkhach, trangthai_phongkhach);
      s = "";
    }

    if (s == "phongkhach_0") {
      trangthai_phongkhach = 0;
      EEPROM.write(diachi_phongkhach, trangthai_phongkhach);
      digitalWrite(led_phongkhach, trangthai_phongkhach);
      s = "";
    }

    if (s == "phongan_1") {
      trangthai_phongan = 1;
      EEPROM.write(diachi_phongan, trangthai_phongan);
      digitalWrite(led_phongan, trangthai_phongan);
      s = "";
    }

    if (s == "phongan_0") {
      trangthai_phongan = 0;
      EEPROM.write(diachi_phongan, trangthai_phongan);
      digitalWrite(led_phongan, trangthai_phongan);
      s = "";
    }

    if (s == "gara_1") {
      trangthai_gara = 1;
      EEPROM.write(diachi_gara, trangthai_gara);
      digitalWrite(led_gara, trangthai_gara);
      s = "";
    }

    if (s == "gara_0") {
      trangthai_gara = 0;
      EEPROM.write(diachi_gara, trangthai_gara);
      digitalWrite(led_gara, trangthai_gara);
      s = "";
    }

    if (s == "baodong_1") {
      khancap_state = 2;
      alert = true;
      s = "";
    }

    if (s == "baodong_0") {
      alert = false;
      s = "";
    }

    if (s == "phongngu_1") {
      trangthai_phongngu = 1;
      analogWrite(led_phongngu, led_value_btn08);
      EEPROM.write(diachi_phongngu_st, 1);
      s = "";
    }

    if (s == "phongngu_0") {
      trangthai_phongngu = 0;
      digitalWrite(led_phongngu, LOW);
      EEPROM.write(diachi_phongngu_st, 0);
      s = "";
    }

    if (s == "phongngu_15") {
      led_value_btn08 = 15;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_30") {
      led_value_btn08 = 30;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_45") {
      led_value_btn08 = 45;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_60") {
      led_value_btn08 = 60;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_75") {
      led_value_btn08 = 75;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_90") {
      led_value_btn08 = 90;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_105") {
      led_value_btn08 = 105;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_120") {
      led_value_btn08 = 120;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_135") {
      led_value_btn08 = 135;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_150") {
      led_value_btn08 = 150;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_165") {
      led_value_btn08 = 165;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_180") {
      led_value_btn08 = 180;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_195") {
      led_value_btn08 = 195;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_210") {
      led_value_btn08 = 210;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_225") {
      led_value_btn08 = 225;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_240") {
      led_value_btn08 = 250;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "phongngu_255") {
      led_value_btn08 = 255;
      analogWrite(led_phongngu, led_value_btn08);
      s = "";
    }

    if (s == "servo_1") {
      myservo.write(70);
      servo_state = 1;  // Mở
      time9 = millis();
      s = "";
    }

    if (s == "servo_0") {
      myservo.write(110);
      servo_state = 0;  // Đóng
      time9 = millis();
      s = "";
    }
  }
}

void loop() {
  // put your main code here, to run repeatedly:

  readButtons();    // Đọc giá trị của các nút nhấn
  checkPassword();  // Kiểm tra mật khẩu nhập vào
  kt_luoc();        // Kiểm tra lần sai

  ReviceData();

  // Serial.println(khancap_state);

  gtdienap = analogRead(lm5);
  float voltage = gtdienap * (5.0 / 1024.0);
  float temp = voltage * 100.0;  // Chuyển đổi giá trị cảm biến thành nhiệt độ

  gtbientro = analogRead(bientro);
  bamxung = map(gtbientro, 0, 1023, 0, 255);
  gt = analogRead(cambien);

  if (bamxung < 70 && servo_quay == 0) {  // Mở
    myservo.write(70);
    servo_quay = 1;
    servo_dung = 0;
  }

  if (bamxung > 185 && servo_quay == 0) {  // Đóng
    myservo.write(110);
    servo_quay = 1;
    servo_dung = 0;
  }

  if (((bamxung >= 80 && bamxung <= 175) && servo_dung == 0) || servo_state == 2) {  // Dừng
    myservo.write(90);
    servo_quay = 0;
    servo_dung = 1;
    servo_state = 3;
  }

  if ((millis() - time9 >= 5000) && servo_state != 3) {
    servo_state = 2;
  }

  if (millis() - time12 >= 1000) {
    time12 = millis();
    if (temp < 10) {
      lcd.setCursor(14, 1);
      lcd.print("");
      lcd.setCursor(15, 1);
    } else {
      lcd.setCursor(14, 1);
    }
    lcd.print(temp);
  }


  if (temp > 100) {  // Nếu nhiệt độ lớn hơn 100°C
    khancap_state = 2;
    alert = true;
    if (millis() - time12 >= 1000) {
      time12 = millis();
      if (temp < 10) {
        lcd.setCursor(14, 1);
        lcd.print("");
        lcd.setCursor(15, 1);
      } else {
        lcd.setCursor(14, 1);
      }
      lcd.print(temp);
    }

    if (millis() - time8 >= 2000) {
      time8 = millis();
      if (alert == true) {
        Serial.write("baodong_1\n");
      } else if (alert == false) {
        Serial.write("baodong_0\n");
      }
    }
  }

  int khancap_status = digitalRead(btn_khancap);

  if (wc_state == 0) {
    if (gt < 500) {
      if (millis() - time6 >= 500) {
        digitalWrite(led_wc, HIGH);

        time6 = millis();
      }
    } else if (gt >= 500 && alert == false) {
      if (millis() - time6 >= 5000) {
        digitalWrite(led_wc, LOW);

        time6 = millis();
      }
    }
  }

  if (khancap_status == HIGH && khancap_clicked == false) {
    if (khancap_start1 == 0) {
      khancap_start1 = millis();
    }

    khancap_clicked = true;
  }

  if (khancap_status == HIGH && khancap_clicked == true) {
    if (millis() - khancap_start1 >= 3000) {
      khancap_state = 1;
    }

    if (khancap_start2 == 0 && khancap_end1 != 0) {
      khancap_start2 = millis();
    }
  }

  if (khancap_status == LOW && khancap_clicked == true) {
    if (khancap_end1 == 0) {
      khancap_end1 = millis();
    }

    if (khancap_start2 != 0 && khancap_state != 1) {
      khancap_end2 = millis();
    }

    if (khancap_end1 - khancap_start1 >= 3000 || (khancap_end1 - khancap_start1 >= 3000 && khancap_start2 != 0)) {
      khancap_state = 1;

      khancap_start1 = 0;
      khancap_end1 = 0;
      khancap_start2 = 0;
      khancap_end2 = 0;

      khancap_clicked = false;

      return;
    }

    if (millis() - khancap_end1 >= 1000) {
      khancap_state = 2;

      alert = !alert;

      if (alert == true) {
        Serial.write("baodong_1\n");
      } else if (alert == false) {
        Serial.write("baodong_0\n");
      }

      khancap_start1 = 0;
      khancap_end1 = 0;
      khancap_start2 = 0;
      khancap_end2 = 0;

      khancap_clicked = false;
    }

    if (khancap_end2 != 0 && khancap_end2 - khancap_end1 <= 500) {
      khancap_state = 3;

      khancap_start1 = 0;
      khancap_end1 = 0;
      khancap_start2 = 0;
      khancap_end2 = 0;

      khancap_clicked = false;
    }
  }
  switch (khancap_state) {
    case 1:
      {
        digitalWrite(led_phongkhach, LOW);
        digitalWrite(led_gara, LOW);
        digitalWrite(led_phongan, LOW);
        digitalWrite(led_wc, LOW);
        digitalWrite(led_phongngu, LOW);

        khancap_state = 0;

        break;
      }
    case 2:
      {
        if (alert) {
          if (millis() - time1 >= 500) {
            digitalWrite(led_phongkhach, led_state);
            digitalWrite(led_gara, led_state);
            digitalWrite(led_phongan, led_state);
            digitalWrite(led_wc, led_state);
            digitalWrite(led_phongngu, led_state);

            led_state = led_state == 0 ? 1 : 0;

            time1 = millis();
          }
        } else {
          led_state = 0;
          digitalWrite(led_phongkhach, trangthai_phongkhach);
          digitalWrite(led_gara, trangthai_gara);
          digitalWrite(led_phongan, trangthai_phongan);
          digitalWrite(led_wc, trangthai_wc);
          digitalWrite(led_phongngu, trangthai_phongngu);

          khancap_state = 0;
        }

        break;
      }
    case 3:
      {
        digitalWrite(led_phongkhach, HIGH);
        digitalWrite(led_gara, HIGH);
        digitalWrite(led_phongan, HIGH);
        digitalWrite(led_wc, HIGH);
        digitalWrite(led_phongngu, HIGH);

        khancap_state = 0;

        break;
      }
  }

  if (digitalRead(btn_phongkhach) == HIGH) {
    if (millis() - time5 >= 500) {
      if (trangthai_phongkhach == 0) {
        trangthai_phongkhach = 1;
        digitalWrite(led_phongkhach, HIGH);
        Serial.write("phongkhach_1\n");
        EEPROM.write(diachi_phongkhach, trangthai_phongkhach);
      } else {
        trangthai_phongkhach = 0;
        digitalWrite(led_phongkhach, LOW);
        Serial.write("phongkhach_0\n");
        EEPROM.write(diachi_phongkhach, trangthai_phongkhach);
      }
      time5 = millis();
    }
  }

  if (digitalRead(btn_phongan) == HIGH) {
    if (millis() - time2 >= 500) {
      if (trangthai_phongan == 0) {
        trangthai_phongan = 1;
        digitalWrite(led_phongan, HIGH);
        Serial.write("phongan_1\n");
        EEPROM.write(diachi_phongan, trangthai_phongan);
      } else {
        trangthai_phongan = 0;
        digitalWrite(led_phongan, LOW);
        Serial.write("phongan_0\n");
        EEPROM.write(diachi_phongan, trangthai_phongan);
      }

      time2 = millis();
    }
  }

  if (digitalRead(btn_gara) == HIGH) {
    if (millis() - time7 >= 500) {
      if (trangthai_gara == 0) {
        trangthai_gara = 1;
        digitalWrite(led_gara, HIGH);
        Serial.write("gara_1\n");
        EEPROM.write(diachi_gara, trangthai_gara);
      } else {
        trangthai_gara = 0;
        digitalWrite(led_gara, LOW);
        Serial.write("gara_0\n");
        EEPROM.write(diachi_gara, trangthai_gara);
      }

      time7 = millis();
    }
  }

  unsigned long t_cur_btn08 = millis();
  int btn_cur_stt_btn08 = digitalRead(btn_phongngu);
  if (btn_cur_stt_btn08 == 1) {
    if (t_high_btn08 == 0)

    {
      t_high_btn08 = t_cur_btn08;
    } else if (t_low_btn08 != 0 && t_high2_btn08 == 0)

    {
      t_high2_btn08 = t_cur_btn08;
    }
  } else {

    if (t_high_btn08 != 0 && t_high2_btn08 == 0 && t_cur_btn08 - t_high_btn08 >= 3000)

    {
      modeled_btn08 = !modeled_btn08;
      t_high_btn08 = 0;
      t_low_btn08 = 0;

    } else if (t_high2_btn08 != 0 && t_cur_btn08 - t_high_btn08 <= 2000)

    {
      if (digitalRead(led_phongngu) == HIGH) {
        if (modeled_btn08 == false) {
          led_value_btn08 += 15;
          if (led_value_btn08 > 255) {
            led_value_btn08 = 255;
          }
          analogWrite(led_phongngu, led_value_btn08);
        } else {
          led_value_btn08 -= 15;
          if (led_value_btn08 <= 0) {
            led_value_btn08 = 15;
          }
          analogWrite(led_phongngu, led_value_btn08);
        }
        EEPROM.write(diachi_phongngu_value, led_value_btn08);
        if (led_value_btn08 == 15) {
          Serial.write("phongngu_15\n");
        }

        if (led_value_btn08 == 30) {
          Serial.write("phongngu_30\n");
        }

        if (led_value_btn08 == 45) {
          Serial.write("phongngu_45\n");
        }

        if (led_value_btn08 == 60) {
          Serial.write("phongngu_60\n");
        }

        if (led_value_btn08 == 75) {
          Serial.write("phongngu_75\n");
        }

        if (led_value_btn08 == 90) {
          Serial.write("phongngu_90\n");
        }

        if (led_value_btn08 == 105) {
          Serial.write("phongngu_105\n");
        }

        if (led_value_btn08 == 120) {
          Serial.write("phongngu_120\n");
        }

        if (led_value_btn08 == 135) {
          Serial.write("phongngu_135\n");
        }

        if (led_value_btn08 == 150) {
          Serial.write("phongngu_150\n");
        }

        if (led_value_btn08 == 165) {
          Serial.write("phongngu_165\n");
        }

        if (led_value_btn08 == 180) {
          Serial.write("phongngu_180\n");
        }

        if (led_value_btn08 == 195) {
          Serial.write("phongngu_195\n");
        }

        if (led_value_btn08 == 210) {
          Serial.write("phongngu_210\n");
        }

        if (led_value_btn08 == 225) {
          Serial.write("phongngu_225\n");
        }

        if (led_value_btn08 == 240) {
          Serial.write("phongngu_240\n");
        }

        if (led_value_btn08 == 255) {
          Serial.write("phongngu_255\n");
        }
      }
      t_high_btn08 = 0;
      t_high2_btn08 = 0;
      t_low_btn08 = 0;
    } else {
      if (t_high_btn08 != 0 && t_cur_btn08 - t_high_btn08 > 1000) {
        if (t_high2_btn08 != 0 && t_cur_btn08 - t_high2_btn08 >= 3000)

        {
          modeled_btn08 = !modeled_btn08;
          t_high_btn08 = 0;
          t_high2_btn08 = 0;
          t_low_btn08 = 0;
        } else {
          digitalWrite(led_phongngu, !digitalRead(led_phongngu));
          if (digitalRead(led_phongngu) == LOW) {
            Serial.write("phongngu_0\n");
            digitalWrite(led_phongngu, LOW);
            trangthai_phongngu = 0;
          }
          if (digitalRead(led_phongngu) == HIGH) {
            Serial.write("phongngu_1\n");
            analogWrite(led_phongngu, led_value_btn08);
            trangthai_phongngu = 1;
          }
          EEPROM.write(diachi_phongngu_st, trangthai_phongngu);
          if (digitalRead(led_phongngu) == HIGH) {
            modeled_btn08 = true;
            // led_value_btn08 = 255;
          }
          t_high_btn08 = 0;
          t_high2_btn08 = 0;
          t_low_btn08 = 0;
        }
      } else {
        if (t_high_btn08 != 0)

        {
          t_low_btn08 = t_cur_btn08;
        }
      }
    }
  }
}

// read button
void readButtons() {
  int docbut1 = digitalRead(btn_cua1);  // Đọc trạng thái nút 1
  int docbut2 = digitalRead(btn_cua2);  // Đọc trạng thái nút 2

  if (millis() - time > 5000) {
    // tắt LCD vì ko có tác động trong vòng 5s
    if (dem == tam) {
      lcd.clear();
      lcd.noBacklight();
      lcd.noDisplay();

      // reset
      dem = -1;
      ttl = false;
      tt = 0;
      tt1 = 0;
      ss = 0;
      tam = -1;
      if (success == true || fail == true) {
        luoc = 0;
        success = false;
        fail = false;
      }
    }
    if (dem > tam) {
      tam = dem;
    }
  }

  if (ttl) {
    lcd.setCursor(0, 1);
    lcd.print("_____");
    ttl = false;
  }

  if (success == false && fail == false)  // kiểm tra đã đăng nhập thành công hay thất bại
  {
    if (tt1 == 1 && tt == 1) {
      lcd.clear();
      lcd.backlight();
      lcd.display();
      lcd.setCursor(0, 0);
      lcd.print("PASSWORD:");

      // reset
      dem = -1;
      ttl = true;
      tt = 0;
      tt1 = 0;
      ss = 0;
      tam = -1;
    }
    if (docbut1 == 1) {
      an = an - 1;
      //ấn thì trạng thái = 1
      if (an == 5) {
        tt = 1;
      }
      if (an == 0) {
        an = 1;
      }

      time = millis();
    } else {
      an = 20;
      if (tt == 1) {
        dem++;
        mk[dem] = 1;
        if (mk[dem] == mk_d[dem]) {
          ss++;
        }
        if (dem == 4) {
          if (ss != 5) {
            luoc++;
            ss = 0;
            ttl = true;
          }
        }
        if (dem != 5) {
          lcd.setCursor(dem, 1);
          lcd.print(mk[dem]);

        } else {

          dem = -1;
        }
        tt = 0;
      }
    }

    // nut 2
    if (docbut2 == 1) {
      an1 = an1 - 1;
      if (an1 == 5) {
        tt1 = 1;
      }
      if (an1 == 0) {
        an1 = 1;
      }

      time = millis();
    } else {
      an1 = 20;
      if (tt1 == 1) {
        dem++;
        mk[dem] = 0;
        if (mk[dem] == mk_d[dem]) {
          ss++;
        }
        if (dem == 4) {
          if (ss != 5) {
            luoc++;
            ss = 0;
            ttl = true;
          }
        }
        if (dem != 5) {
          lcd.setCursor(dem, 1);
          lcd.print(mk[dem]);

        } else {
          dem = -1;
        }

        tt1 = 0;
      }
    }
  }
}

// kiểm tra mật khẩu
void checkPassword() {
  if (ss == 5) {
    success = true;
    fail = false;
    ss = 0;
    ttl = false;
    lcd.clear();
    lcd.setCursor(3, 0);
    lcd.print("WELCOME!!!!");
    //////xl
    //lcd.clear();
    //asm volatile("jmp 0");
  }
}

void kt_luoc() {
  if (luoc == 5) {
    fail = true;
    success = false;
    luoc = 0;
    ttl = false;
    lcd.clear();
    lcd.setCursor(3, 0);
    lcd.print("!!!!!!!!!!!");
    //xl thoi gian

    //delay(7000);
    //asm volatile("jmp 0");  // reset chương trình
  }
}
