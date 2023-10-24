#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);
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
int led_wc = 3;
int led_phongngu = 6;
int led_cua = 4;  // chân led
// Khai báo biến

int mk[5];         // mảng để lưu trữ mật khẩu nhập vào
int dem = -1;      // Chỉ số của chuỗi
bool ttl = false;  //
bool tt = 0;       // trạng thái nút 1
bool tt1 = 0;      /// trạng thái nút 2
int ss = 0;        // chỉ số so sánh
int tam = -1;
int luoc = 0;                     // số lược nhấn
int mk_d[5] = { 1, 0, 0, 1, 1 };  // mật khẩu
int an, an1;
unsigned long time = 0;
unsigned long time1 = 0;
//LyAnhHao
bool btn03_clicked = false;
// 0 là trạng thái cơ bản, 1 là báo cháy (chớp tắt) (Single click), 2 là mở tất cả đèn (Double click), 3 là tắt hết tất cả đèn (Long-press)
int btn03_state = 0;
int led_state = 0;
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
  pinMode(led_cua, OUTPUT);
  lcd.print("PASSWORD:");
  lcd.setCursor(0, 1);
  lcd.print("_____");
  //LyAnhHao
  pinMode(led_phongkhach, OUTPUT);
  pinMode(led_gara, OUTPUT);
  pinMode(led_phongan, OUTPUT);
  pinMode(led_wc, OUTPUT);
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
  pinMode(led_wc, OUTPUT);
  pinMode(btn_wc, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  //NguyenThiCamDuyen
  readButtons();    // Đọc giá trị của các nút nhấn
  checkPassword();  // Kiểm tra mật khẩu nhập vào

  kt_luoc();  // Kiểm tra lần sai
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
    }

    if (btn03_start2 == 0 && btn03_end1 != 0) {
      btn03_start2 = millis();
    }
  }

  if (btn03_status == LOW && btn03_clicked == true) {
    if (btn03_end1 == 0) {
      btn03_end1 = millis();
    }

    if (btn03_start2 != 0) {
      btn03_end2 = millis();
    }

    if (btn03_end1 - btn03_start1 >= 3000 || (btn03_end1 - btn03_start1 >= 3000 && btn03_start2 != 0)) {
      btn03_state = 1;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;

      return;
    }

    if (millis() - btn03_end1 >= 1000) {
      btn03_state = 2;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;
    }

    if (btn03_end2 != 0 && btn03_end2 - btn03_end1 <= 500) {
      btn03_state = 3;

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
        digitalWrite(led_wc, LOW);
        digitalWrite(led_phongngu, LOW);

        btn03_state = 0;

        break;
      }
    case 2:
      {
        if (millis() - time1 >= 500) {
          digitalWrite(led_phongkhach, led_state);
          digitalWrite(led_gara, led_state);
          digitalWrite(led_phongan, led_state);
          digitalWrite(led_wc, led_state);
          digitalWrite(led_phongngu, led_state);

          led_state = led_state == 0 ? 1 : 0;

          time1 = millis();
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

        btn03_state = 0;

        break;
      }
  }
  //LeNgocBaThong
  if (digitalRead(btn_phongkhach) == HIGH) {
    if (digitalRead(btn_phongkhach) == HIGH) {
      if (trangthai == 0) {
        trangthai = 1;
        digitalWrite(led_phongkhach, HIGH);
      } else {
        trangthai = 0;
        digitalWrite(led_phongkhach, LOW);
      }
    }
    while (digitalRead(btn_phongkhach) == HIGH)
      ;
  }

  if (digitalRead(btn_gara) == HIGH) {
    if (digitalRead(btn_gara) == HIGH) {
      if (trangthai == 0) {
        trangthai = 1;
        digitalWrite(led_gara, HIGH);
      } else {
        trangthai = 0;
        digitalWrite(led_gara, LOW);
      }
    }
    while (digitalRead(btn_gara) == HIGH)
      ;
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

    } else if (t_high2_btn08 != 0 && t_cur_btn08 - t_high_btn08 <= 1000)

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
  if (digitalRead(btn_wc) == HIGH) {
    if (digitalRead(btn_wc) == HIGH) {
      if (trangthai == 0) {
        trangthai = 1;
        digitalWrite(led_wc, HIGH);
      } else {
        trangthai = 0;
        digitalWrite(led_wc, LOW);
      }
    }
    while (digitalRead(btn_wc) == HIGH)
      ;
  }
}

void readButtons() {
  int docbut1 = digitalRead(btn_cua1);  // Đọc trạng thái nút 1
  int docbut2 = digitalRead(btn_cua2);  // Đọc trạng thái nút 2
  //put your main code here, to run repeatedly:

  if (millis() - time > 5000) {
    time = millis();
    if (dem == tam) {
      // lcd.setCursor(0, 1);
      // lcd.print("_____");
      // dem = -1; // Chỉ số của chuỗi
      // ttl = false; //
      // tt = 0; // trạng thái nút 1
      // tt1 = 0; /// trạng thái nút 2
      // ss = 0; // chỉ số so sánh
      // tam = -1;
      // luoc = 0;
      lcd.clear();
      lcd.noBacklight();
    }
    if (dem > tam) {

      tam = dem;
    }
  }


  if (tt1 == 1 && tt == 1) {
    lcd.clear();
    asm volatile("jmp 0");  // reset chương trình
  }
  if (ttl) {
    lcd.setCursor(0, 1);
    lcd.print("_____");
    ttl = false;
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
          Serial.print("luoc = ");
          Serial.print(luoc);
          Serial.print(" ");
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
          Serial.print("luoc = ");
          Serial.print(luoc);
          Serial.print(" ");
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

  if(digitalRead(btn_phongan) == HIGH){
    if(millis() - time1 >= 500){
      digitalWrite(led_phongan, digitalRead(led_phongan)==HIGH?LOW:HIGH);

      time1 = millis();
    }
  }
}

// kiểm tra mật khẩu
void checkPassword() {
  if (ss == 5) {
    lcd.clear();
    lcd.setCursor(3, 0);
    lcd.print("WECOME!!!!");
    delay(10000);
    lcd.clear();
    asm volatile("jmp 0");
  }
}

void kt_luoc() {
  if (luoc == 5) {

    lcd.clear();
    lcd.setCursor(3, 0);
    lcd.print("!!!!!!!!!!!");
    delay(1000);
    asm volatile("jmp 0");  // reset chương trình
  }
}
