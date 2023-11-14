int led_khach_01_02 = 0;
int led_gara = 1;
int btn_khach = 9;
int btn_gara = 10;
int trangthai = 0;
void setup() {
  pinMode(led_khach_01_02,OUTPUT);
  pinMode(led_gara,OUTPUT);
  pinMode(btn_khach,INPUT);
  pinMode(btn_gara,INPUT);
}

void loop() {
  if(digitalRead(btn_khach)==HIGH)
  {
    if(digitalRead(btn_khach)==HIGH)
    {
      if(trangthai==0)
      {
        trangthai=1;
        digitalWrite(led_khach_01_02,HIGH);
      }
      else
      {
        trangthai =0;
        digitalWrite(led_khach_01_02,LOW);
      }
    }
    while(digitalRead(btn_khach)==HIGH);
  }
  
  if(digitalRead(btn_gara)==HIGH)
  {
    if(digitalRead(btn_gara)==HIGH)
    {
      if(trangthai==0)
      {
        trangthai=1;
        digitalWrite(led_gara,HIGH);
      }
      else
      {
        trangthai =0;
        digitalWrite(led_gara,LOW);
      }
    }
    while(digitalRead(btn_gara)==HIGH);
  }
}
