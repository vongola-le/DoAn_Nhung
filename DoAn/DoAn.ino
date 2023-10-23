#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);
// Khai báo biến
int but1 = 2;      // Nút nhấn 1 để chọn ký tự 0
int but2 = 3;      // Nút nhấn 2 để xác nhận ký tự 1
int led = 7;       // chân led
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
int led0102 = 0;
int led03 = 1;
int led04 = 2;
int led05 = 3;
int led07 = 4;
int btn03 = 8;
bool btn03_clicked = false;
// 0 là trạng thái cơ bản, 1 là báo cháy (chớp tắt) (Single click), 2 là mở tất cả đèn (Double click), 3 là tắt hết tất cả đèn (Long-press)
int btn03_state = 0;
int led_state = 0;

unsigned long btn03_start1 = 0;
unsigned long btn03_start2 = 0;
unsigned long btn03_end1 = 0;
unsigned long btn03_end2 = 0;
//LeNgocBaThong
int led_khach_01_02 = 0;
int led_gara = 1;
int btn_khach = 9;
int btn_gara = 10;
int trangthai = 0;
//DangHoangPhuong
int btn08 = 8;
int led06 = 6;
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
  pinMode(but1, INPUT);
  pinMode(but2, INPUT);
  pinMode(led, OUTPUT);
  Serial.begin(9600);
  lcd.print("PASSWORD:");
  lcd.setCursor(0, 1);
  lcd.print("_____");
  //LyAnhHao
  int led0102 = 0;
  int led03 = 1;
  int led04 = 2;
  int led05 = 3;
  int led06 = 6;
  int led07 = 4;

  int btn03 = 8;

  bool btn03_clicked = false;

  // 0 là trạng thái cơ bản, 1 là báo cháy (chớp tắt) (Single click), 2 là mở tất cả đèn (Double click), 3 là tắt hết tất cả đèn (Long-press)
  int btn03_state = 0;
  int led_state = 0;

  unsigned long btn03_start1 = 0;
  unsigned long btn03_start2 = 0;
  unsigned long btn03_end1 = 0;
  unsigned long btn03_end2 = 0;
  unsigned long time1 = 0;
  //LeNgocBaThong
  pinMode(led_khach_01_02, OUTPUT);
  pinMode(led_gara, OUTPUT);
  pinMode(btn_khach, INPUT);
  pinMode(btn_gara, INPUT);
  //DangHoanPhuong
  pinMode(btn08, INPUT);
  pinMode(led06, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  //NguyenThiCamDuyen
  readButtons();    // Đọc giá trị của các nút nhấn
  checkPassword();  // Kiểm tra mật khẩu nhập vào

  kt_luoc();  // Kiểm tra lần sai
}

void readButtons() {
  int docbut1 = digitalRead(but1);  // Đọc trạng thái nút 1
  int docbut2 = digitalRead(but2);  // Đọc trạng thái nút 2
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
  //LyAnhHao
  int btn03_status = digitalRead(btn03);

  if (btn03_status == HIGH && btn03_clicked == false) {
    if (btn03_start1 == 0) {
      btn03_start1 = millis();
    }

    btn03_clicked = true;
  }

  if (btn03_status == HIGH && btn03_clicked == true) {
    if (millis() - btn03_start1 >= 3000) {
      btn03_state = 0;
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
      btn03_state = 0;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;

      return;
    }

    if (millis() - btn03_end1 >= 1000) {
      btn03_state = 1;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;
    }

    if (btn03_end2 != 0 && btn03_end2 - btn03_end1 <= 500) {
      btn03_state = 2;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;

      btn03_clicked = false;
    }
  }

  switch (btn03_state) {
    case 0:
      {
        digitalWrite(led0102, LOW);
        digitalWrite(led03, LOW);
        digitalWrite(led04, LOW);
        digitalWrite(led05, LOW);
        digitalWrite(led06, LOW);

        break;
      }
    case 1:
      {
        if (millis() - time1 >= 500) {
          digitalWrite(led0102, led_state);
          digitalWrite(led03, led_state);
          digitalWrite(led04, led_state);
          digitalWrite(led05, led_state);
          digitalWrite(led06, led_state);

          led_state = led_state == 0 ? 1 : 0;

          time1 = millis();
        }

        break;
      }
    case 2:
      {
        digitalWrite(led0102, HIGH);
        digitalWrite(led03, HIGH);
        digitalWrite(led04, HIGH);
        digitalWrite(led05, HIGH);
        digitalWrite(led06, HIGH);

        break;
      }
  }
  //LeNgocBaThong
  if (digitalRead(btn_khach) == HIGH) {
    if (digitalRead(btn_khach) == HIGH) {
      if (trangthai == 0) {
        trangthai = 1;
        digitalWrite(led_khach_01_02, HIGH);
      } else {
        trangthai = 0;
        digitalWrite(led_khach_01_02, LOW);
      }
    }
    while (digitalRead(btn_khach) == HIGH)
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
  int btn_cur_stt_btn08 = digitalRead(btn08);
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
      if (digitalRead(led06) == HIGH) {
        if (modeled_btn08 == false) {
          led_value_btn08 += 15;
          if (led_value_btn08 > 255) {
            led_value_btn08 = 255;
          }
          analogWrite(led06, led_value_btn08);
        } else {
          led_value_btn08 -= 15;
          if (led_value_btn08 < 0) {
            stt_led_btn08 = false;
            digitalWrite(led06, LOW);
            led_value_btn08 = 255;
          }
          if (digitalRead(led06) == HIGH) {
            analogWrite(led06, led_value_btn08);
          };
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
          digitalWrite(led06, !digitalRead(led06));
          if (digitalRead(led06) == HIGH) {
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
}
