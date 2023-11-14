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

void setup() {
  pinMode(led0102, OUTPUT);
  pinMode(led03, OUTPUT);
  pinMode(led04, OUTPUT);
  pinMode(led05, OUTPUT);
  pinMode(led06, OUTPUT);
  pinMode(btn03, INPUT);

}

void loop() {
  int btn03_status = digitalRead(btn03);

  if(btn03_status == HIGH && btn03_clicked == false){
    if(btn03_start1 == 0){
      btn03_start1 = millis();
    }

    btn03_clicked = true;
  }

  if(btn03_status == HIGH && btn03_clicked == true){
    if(millis() - btn03_start1 >= 3000){
      btn03_state = 0;
    }

    if(btn03_start2 == 0 && btn03_end1 != 0){
      btn03_start2 = millis();
    }
  }

  if(btn03_status == LOW && btn03_clicked == true){
    if(btn03_end1 == 0){
      btn03_end1 = millis();
    }

    if(btn03_start2 != 0){
      btn03_end2 = millis();
    }

    if(btn03_end1 - btn03_start1 >= 3000 || (btn03_end1 - btn03_start1 >= 3000 && btn03_start2 != 0)){
      btn03_state = 0;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;
    
      btn03_clicked = false;

      return;
    }

    if(millis() - btn03_end1 >= 1000){
      btn03_state = 1;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;
    
      btn03_clicked = false;
    }

    if(btn03_end2 != 0 && btn03_end2 - btn03_end1 <= 500){
      btn03_state =2;

      btn03_start1 = 0;
      btn03_end1 = 0;
      btn03_start2 = 0;
      btn03_end2 = 0;
    
      btn03_clicked = false;

    }
  }

  switch(btn03_state){
    case 0:{
      digitalWrite(led0102, LOW);
      digitalWrite(led03, LOW);
      digitalWrite(led04, LOW);
      digitalWrite(led05, LOW);
      digitalWrite(led06, LOW);

      break;
    }
    case 1: {
      if(millis() - time1 >= 500){
        digitalWrite(led0102, led_state);
        digitalWrite(led03, led_state);
        digitalWrite(led04, led_state);
        digitalWrite(led05, led_state);
        digitalWrite(led06, led_state);

        led_state = led_state==0?1:0;

        time1 = millis();
      }

      break;
    }
    case 2:{
      digitalWrite(led0102, HIGH);
      digitalWrite(led03, HIGH);
      digitalWrite(led04, HIGH);
      digitalWrite(led05, HIGH);
      digitalWrite(led06, HIGH);

      break;
    }
  }
}
