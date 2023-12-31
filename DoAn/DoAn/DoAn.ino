#include <Wire.h>
// #include <EEPROM.h>
#include <LiquidCrystal_I2C.h>
#include <Servo.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);
Servo myservo;  // biến tên myservo của động cơ servo
//Khai báo nút
int btn_cua1 = 5;  // Nút nhấn 1 để chọn ký tự 0
int btn_cua2 = 7;  // Nút nhấn 2 để xác nhận ký tự 1
int btn_khancap = 8;
int btn_phongkhach = 9;
int btn_gara = 10;
int btn_phongan = 11;
int btn_wc = 12;
int btn_phongngu = 13;
//Khai báo đèn
int led_phongkhach = 0;
int led_gara = 1;
int led_phongan = 2;
int led_wc1 = 3;
int led_phongngu = 6;
int led_wc2 = 4;  // chân led
// Khai báo biến

int lm5 = A0;   // chân A0
int gtdienap;   //lưu giá trị điện áp
int gtbientro;  //lưu giá trị biến trở
int vtservo;    // lưu giá trị đọc từ biến trở đổi sang góc
int lastvtservo = 0;
int bamxung;
int last_bamxung;
int diachi_khancap = 0;
int diachi_solansaimk = 1;
int diachi_gocservo = 1;
int servo = A2;    // chân số 6
int bientro = A1;  // chân A0
int cambien_last_state = 0;
int cambien = A3;
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
//LyAnhHao
bool btn03_clicked = false;
// 0 là trạng thái cơ bản, 1 là báo cháy (chớp tắt) (Single click), 2 là mở tất cả đèn (Double click), 3 là tắt hết tất cả đèn (Long-press)
int btn03_state = 0;
int led_state = 0;
bool alert = false;
unsigned long btn03_start1 = 0;
unsigned long btn03_start2 = 0;
unsigned long btn03_end1 = 0;
unsigned long btn03_end2 = 0;
//LeNgocBaThong
int trangthai = 0;
//DangHoangPhuong

unsigned long t_high_btn08 = 0;
unsigned long t_high2_btn08 = 0;
unsigned long t_low_btn08 = 0;
int led_value_btn08 = 0;
bool stt_led_btn08 = false;
bool modeled_btn08 = false;



void setup() {
  // put your setup code here, to run once:
  //NguyenThiCamDuyen
  lcd.init();
  lcd.backlight();
  pinMode(btn_cua1, INPUT);
  pinMode(btn_cua2, INPUT);
  pinMode(led_wc2, OUTPUT);
  lcd.print("PASSWORD:");
  lcd.setCursor(0, 1);
  lcd.print("_____");
  //LyAnhHao
  pinMode(led_phongkhach, OUTPUT);
  pinMode(led_gara, OUTPUT);
  pinMode(led_phongan, OUTPUT);
  pinMode(led_wc1, OUTPUT);
  pinMode(led_phongngu, OUTPUT);
  pinMode(btn_khancap, INPUT);
  //LeNgocBaThong
  pinMode(led_gara, OUTPUT);
  pinMode(btn_phongkhach, INPUT);
  pinMode(btn_gara, INPUT);
  //DangHoanPhuong
  pinMode(btn_phongngu, INPUT);
  pinMode(led_phongngu, OUTPUT);
  //LeHoangDe
  pinMode(led_wc1, OUTPUT);
  pinMode(btn_wc, INPUT);
  myservo.attach(servo);

  // btn03_state = EEPROM.read(diachi_khancap);
  // luoc = EEPROM.read(diachi_solansaimk);
  // vtservo = EEPROM.read(diachi_gocservo);

  if (btn03_state == 2) {
    alert = true;
  }

  gtbientro = analogRead(bientro);
  last_bamxung = map(gtbientro, 0, 1023, 0, 255);
}

void loop() {
  // put your main code here, to run repeatedly:
  //NguyenThiCamDuyen
  readButtons();    // Đọc giá trị của các nút nhấn
  checkPassword();  // Kiểm tra mật khẩu nhập vào

  kt_luoc();  // Kiểm tra lần sai

  int reading = analogRead(gtdienap);
  float voltage = reading * (5.0 / 1024.0);
  float temp = voltage * 100.0;  // Chuyển đổi giá trị cảm biến thành nhiệt độ

  gtbientro = analogRead(bientro);
  bamxung = map(gtbientro, 0, 1023, 0, 255);
  vtservo = map(gtbientro, 0, 1023, 0, 180);
  gt = analogRead(cambien);

  if (last_bamxung != bamxung) {
    myservo.write(vtservo);
    last_bamxung = bamxung;
    // EEPROM.write(diachi_gocservo, vtservo);
  }

  if (temp > 100) { // Nếu nhiệt độ lớn hơn 40°C
    btn03_state = 2;
    alert = true;
  }

  if (gt < 500) {
    if (millis() - time >= 500) {
      digitalWrite(led_wc2, HIGH);

      time = millis();
    }
  } else if (gt >= 500 && alert == false) {
    if (millis() - time >= 5000) {
      digitalWrite(led_wc2, LOW);

      time = millis();
    }
  }

  //LyAnhHao
  int btn03_status = digitalRead(btn_khancap);

  if (btn03_status == HIGH && btn03_clicked == false) {
    if (btn03_start1 == 0) {
      btn03_start1 = millis();
    }

    btn03_clicked = true;
  }

  if (btn03_status == HIGH && btn03_clicked == true) {
    if (millis() - btn03_start1 >= 3000) {
      btn03_state = 1;
      // EEPROM.write(diachi_khancap, btn03_state);
    }

    if (btn03_start2 == 0 && btn03_end1 != 0) {
      btn03_start2 = millis();
    }
  }

  if (btn03_status == LOW && btn03_clicked == true) {
    if (btn03_end1 == 0) {
      btn03_end1 = millis();
    }

    if (btn03_start2 != 0 && btn03_state != 1) {
      btn03_end2 = millis();
    }

    if (btn03_end1 - btn03_start1 >= 3000 || (btn03_end1 - btn03_start1 >= 3000 && btn03_start2 != 0)) {
      btn03_state = 1;
      // EEPROM.write(diachi_khancap, btn03_state);

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;

      return;
    }

    if (millis() - btn03_end1 >= 1000) {
      btn03_state = 2;
      // EEPROM.write(diachi_khancap, btn03_state);

      alert = !alert;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;
    }

    if (btn03_end2 != 0 && btn03_end2 - btn03_end1 <= 500) {
      btn03_state = 3;
      // EEPROM.write(diachi_khancap, btn03_state);

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;
    }
  }
  switch (btn03_state) {
    case 1:
      {
        digitalWrite(led_phongkhach, LOW);
        digitalWrite(led_gara, LOW);
        digitalWrite(led_phongan, LOW);
        digitalWrite(led_wc1, LOW);
        digitalWrite(led_phongngu, LOW);
        digitalWrite(led_wc2, LOW);

        btn03_state = 0;
        // EEPROM.write(diachi_khancap, btn03_state);

        break;
      }
    case 2:
      {
        if (alert) {
          if (millis() - time1 >= 500) {
            digitalWrite(led_phongkhach, led_state);
            digitalWrite(led_gara, led_state);
            digitalWrite(led_phongan, led_state);
            digitalWrite(led_wc1, led_state);
            digitalWrite(led_phongngu, led_state);
            digitalWrite(led_wc2, led_state);

            led_state = led_state == 0 ? 1 : 0;

            time1 = millis();
          }
        } else {
          led_state = 0;
          digitalWrite(led_phongkhach, led_state);
          digitalWrite(led_gara, led_state);
          digitalWrite(led_phongan, led_state);
          digitalWrite(led_wc1, led_state);
          digitalWrite(led_phongngu, led_state);
          digitalWrite(led_wc2, led_state);

          btn03_state = 0;
          // EEPROM.write(diachi_khancap, btn03_state);
        }

        break;
      }
    case 3:
      {
        digitalWrite(led_phongkhach, HIGH);
        digitalWrite(led_gara, HIGH);
        digitalWrite(led_phongan, HIGH);
        digitalWrite(led_wc1, HIGH);
        digitalWrite(led_phongngu, HIGH);
        digitalWrite(led_wc2, HIGH);

        btn03_state = 0;
        // EEPROM.write(diachi_khancap, btn03_state);

        break;
      }
  }
  //LeNgocBaThong
  if (digitalRead(btn_phongkhach) == HIGH) {
    if (millis() - time5 >= 500) {
      if (trangthai == 0) {
        trangthai = 1;
        digitalWrite(led_phongkhach, HIGH);
      } else {
        trangthai = 0;
        digitalWrite(led_phongkhach, LOW);
      }
      time5 = millis();
    }
  }

  if (digitalRead(btn_gara) == HIGH) {
    if (millis() - time4 >= 500) {
      if (trangthai == 0) {
        trangthai = 1;
        digitalWrite(led_gara, HIGH);
      } else {
        trangthai = 0;
        digitalWrite(led_gara, LOW);
      }
      time4 = millis();
    }
  }
  //DangHoangPhuong
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
          led_value_btn08 += 30;
          if (led_value_btn08 > 255) {
            led_value_btn08 = 255;
          }
          analogWrite(led_phongngu, led_value_btn08);
        } else {
          led_value_btn08 -= 30;
          if (led_value_btn08 <= 0) {
            led_value_btn08 = 30;
          }
          analogWrite(led_phongngu, led_value_btn08);
        }
      }
      t_high_btn08 = 0;
      t_high2_btn08 = 0;
      t_low_btn08 = 0;
    } else {
      if (t_high_btn08 != 0 && t_cur_btn08 - t_high_btn08 > 1000)
      {
        if (t_high2_btn08 != 0 && t_cur_btn08 - t_high2_btn08 >= 3000)
        {
          modeled_btn08 = !modeled_btn08;
          t_high_btn08 = 0;
          t_high2_btn08 = 0;
          t_low_btn08 = 0;
        } else {
          digitalWrite(led_phongngu, !digitalRead(led_phongngu));
          if (digitalRead(led_phongngu) == HIGH) {
            modeled_btn08 = true;
            led_value_btn08 = 255;
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
  //LeHoangDe
  if (digitalRead(btn_wc) == HIGH) {
    if (millis() - time3 >= 500) {
      if (trangthai == 0) {
        trangthai = 1;
        digitalWrite(led_wc1, HIGH);
      } else {
        trangthai = 0;
        digitalWrite(led_wc1, LOW);
      }
      time3 = millis();
    }
  }
  if (digitalRead(btn_phongan) == HIGH) {
    if (millis() - time2 >= 500) {
      digitalWrite(led_phongan, digitalRead(led_phongan) == HIGH ? LOW : HIGH);

      time2 = millis();
    }
  }
}

// read button
void readButtons() {
  int docbut1 = digitalRead(btn_cua1);  // Đọc trạng thái nút 1
  int docbut2 = digitalRead(btn_cua2);  // Đọc trạng thái nút 2

  if (millis() - time6 > 5000) {
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
        // EEPROM.write(diachi_solansaimk, luoc);
        success = false;
        fail = false;
      }
    }
    if (dem > tam) {
      tam = dem;
    }

    time6 = millis();
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

      time6 = millis();
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
            // EEPROM.write(diachi_solansaimk, luoc);
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

      time6 = millis();
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
            // EEPROM.write(diachi_solansaimk, luoc);
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
    lcd.print("WECOME!!!!");
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
    // EEPROM.write(diachi_solansaimk, luoc);
    ttl = false;
    lcd.clear();
    lcd.setCursor(3, 0);
    lcd.print("!!!!!!!!!!!");
    //xl thoi gian

    //delay(7000);
    //asm volatile("jmp 0");  // reset chương trình
  }
}
