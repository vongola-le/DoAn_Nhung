#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16,2);
// Khai báo biến
int but1 = 2; // Nút nhấn 1 để chọn ký tự 0
int  but2 = 3; // Nút nhấn 2 để xác nhận ký tự 1
int led = 7; // chân led
int mk[5]; // mảng để lưu trữ mật khẩu nhập vào
int dem = -1; // Chỉ số của chuỗi
bool ttl = false; // 
bool tt = 0; // trạng thái nút 1
bool tt1 = 0; /// trạng thái nút 2
int ss = 0; // chỉ số so sánh
int tam = -1;
int luoc = 0; // số lược nhấn
int mk_d[5]={1,0,0,1,1};// mật khẩu
int an, an1;
unsigned long time = 0 ;
unsigned long time1 = 0 ;



void setup() {
  // put your setup code here, to run once:
  lcd.init();
  lcd.backlight();
  pinMode(but1,INPUT);
  pinMode(but2,INPUT);
  pinMode(led, OUTPUT);
  Serial.begin(9600);
  lcd.print("PASSWORD:");
  lcd.setCursor(0, 1);
  lcd.print("_____");
}

void loop() {
  readButtons(); // Đọc giá trị của các nút nhấn
  checkPassword(); // Kiểm tra mật khẩu nhập vào

  kt_luoc(); // Kiểm tra lần sai
}

void readButtons() {
  int docbut1 = digitalRead(but1);// Đọc trạng thái nút 1
  int docbut2 = digitalRead(but2);// Đọc trạng thái nút 2
  //put your main code here, to run repeatedly:

  if(millis()-time > 5000)
  {
    time = millis();
    if(dem ==  tam)
    {
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
    if(dem> tam)
    {

      tam =dem;
    }
    
    
  }


  if(tt1 ==1 && tt ==1 )
  {
    lcd.clear();
    asm volatile("jmp 0"); // reset chương trình
  }
  if(ttl)
  {
    lcd.setCursor(0, 1);
    lcd.print("_____");
    ttl =false;
  }

  if(docbut1==1)
  {
    
    an=an-1;
    //ấn thì trạng thái = 1
    if(an==5)
    {
      tt=1;
    }
    if(an==0)
    {
      an=1;
    }
  }
  else
  {
      an=20;
    if(tt==1)
    {
      dem++;
      mk[dem]=1;
      if(mk[dem]==mk_d[dem])
      {
        ss++;
       
      }
      if(dem==4)
      {
        if(ss!=5)
        {
          luoc ++;
          Serial.print("luoc = ");
          Serial.print(luoc);
          Serial.print(" ");
          ss = 0;
          ttl = true;
        }
      }
      if(dem!=5)
      {
        lcd.setCursor(dem, 1);
        lcd.print(mk[dem]);
        
      }
      else
      {

        dem=-1;
      }
      tt=0;

    }
  }
  // nut 2
  if(docbut2==1)
  {
      
    an1=an1-1;
    if(an1==5)
    {
      tt1=1;
    }
    if(an1==0)
    {
      an1=1;
    }
  }
  else
  {
    an1 =20;
    if(tt1==1)
    {
      dem++;
      mk[dem]=0;
      if(mk[dem]==mk_d[dem])
      {
        ss++;     
      }
      if(dem==4)
      {
        if(ss!=5)
        {
          luoc ++;
          Serial.print("luoc = ");
          Serial.print(luoc);
          Serial.print(" ");
          ss = 0;
          ttl = true;
        }
      }
      if(dem!=5)
      {
        lcd.setCursor(dem, 1);
        lcd.print(mk[dem]);
        
      }
      else
      {
        dem=-1;
      }
      
      tt1=0;

    }
  }

}

// kiểm tra mật khẩu
void checkPassword() {
  if(ss==5)
  {
    lcd.clear();
    lcd.setCursor(3, 0);
    lcd.print("WECOME!!!!");
    delay(10000);
    lcd.clear();
    asm volatile("jmp 0");
    
  }
    

}

void kt_luoc(){
  if(luoc==5)
  {

    lcd.clear();
    lcd.setCursor(3, 0);
    lcd.print("!!!!!!!!!!!");
    delay(1000);
    asm volatile("jmp 0"); // reset chương trình
  }

}
