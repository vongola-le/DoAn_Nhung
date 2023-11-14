int btn08=8;
int led06=6;
unsigned long t_high_btn08 = 0;
unsigned long t_high2_btn08 = 0;
unsigned long t_low_btn08 = 0;
int led_value_btn08=0;
bool stt_led_btn08=false;
bool modeled_btn08=false;
void setup() {

  pinMode(btn08,INPUT);
  pinMode(led06, OUTPUT);
}

void loop() {
unsigned long t_cur_btn08 = millis();
int btn_cur_stt_btn08 = digitalRead(btn08);
if (btn_cur_stt_btn08 == 1)
{
  if (t_high_btn08 == 0)

  {
    t_high_btn08 = t_cur_btn08;
  } else if (t_low_btn08 != 0 && t_high2_btn08==0)

  {
    t_high2_btn08 = t_cur_btn08;
  }
}
else
{

  if (t_high_btn08 != 0 && t_high2_btn08 == 0 && t_cur_btn08 - t_high_btn08 >= 3000)

  {
    modeled_btn08=!modeled_btn08;
    t_high_btn08 = 0;
    t_low_btn08 = 0;

  }
  else if (t_high2_btn08 != 0 && t_cur_btn08 - t_high_btn08 <= 1000)

  {
     if(digitalRead(led06)==HIGH){
        if(modeled_btn08==false){
          led_value_btn08+=15;
          if(led_value_btn08>255){
          led_value_btn08=255;
          }
          analogWrite(led06,led_value_btn08);
        }else{
          led_value_btn08-=15;
          if(led_value_btn08<0){
            stt_led_btn08=false;
            digitalWrite(led06,LOW);
            led_value_btn08=255;
        }
        if(digitalRead(led06)==HIGH){
          analogWrite(led06,led_value_btn08);
        };
      }
      }
    t_high_btn08 = 0;
    t_high2_btn08 = 0;
    t_low_btn08 = 0;
  }
  else {
    if (t_high_btn08 != 0 && t_cur_btn08 - t_high_btn08 > 1000)

    {
      if (t_high2_btn08 != 0 && t_cur_btn08 - t_high2_btn08 >= 3000)

      {
        modeled_btn08=!modeled_btn08;
        t_high_btn08 = 0;
        t_high2_btn08 = 0;
        t_low_btn08 = 0;
      }
      else {
       digitalWrite(led06,!digitalRead(led06));
       if(digitalRead(led06)==HIGH){
         modeled_btn08=true;
         led_value_btn08=255;
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
