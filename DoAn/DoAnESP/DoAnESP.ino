//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Information about Sign-up quota.
//
// Until this video or project was created, to access the Firebase Realtime Database there is a Sign-up quota. Here's an explanation:
//
//  __________________________________________________________________________________________________________________________________________________________________________
// | Sign-up quota                                                                                                                                                            |
// |                                                                                                                                                                          |
// | To protect your project from abuse, we limit the number of new Email/Password and Anonymous accounts that your application can create in a day from a single IP address. |
// |                                                                                                                                                                          |
// | Current quota per hour: 100                                                                                                                                              |
// |__________________________________________________________________________________________________________________________________________________________________________|
//
// For more information, you can see it at:
// (Open your Firebase project) Authentication -> click the Settings tab -> click Sign-up quota.
// Or you can also see it here: https://firebase.google.com/docs/auth/limits
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 01_Store_Data
/*
 *  Reference : https://randomnerdtutorials.com/esp32-firebase-realtime-database/
 */

//======================================== Including the libraries.
#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include <string.h>
//========================================

//======================================== Insert your network credentials.
#define WIFI_SSID "POCO M3"
#define WIFI_PASSWORD "22222222"
//========================================

//Provide the token generation process info.
#include "addons/TokenHelper.h"

//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

// Insert Firebase project API Key
#define API_KEY "AIzaSyAiXu_xLBlXSwj2NIPWNu0GFcJ-EJ2Nh_U"

#define USER_EMAIL "0306211023@caothang.edu.vn"
#define USER_PASSWORD "@HaoLy123"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "https://appsmarthouse-6b1c5-default-rtdb.firebaseio.com/"

// Define Firebase Data object.
FirebaseData fbdo;

// Define firebase authentication.
FirebaseAuth auth;

// Definee firebase configuration.
FirebaseConfig config;

//======================================== Millis variable to send/store data to firebase database.
unsigned long sendDataPrevMillis = 0;
const long sendDataIntervalMillis = 1000;  //--> Sends/stores data to firebase database every 1 seconds.
//========================================

int btn_wc = 12;

bool btn_wc_pressed = false;

int trang_thai_wc = 0;

String s;

byte store_phongkhach_state;
byte last_phongkhach_state;

byte store_wc_state;
byte last_wc_state;

byte store_phongan_state;
byte last_phongan_state;

//________________________________________________________________________________ VOID SETUP
void setup() {
  // put your setup code here, to run once:

  pinMode(btn_wc, INPUT);

  Serial.begin(115200);
  Serial.println();

  //---------------------------------------- The process of connecting the WiFi on the ESP32 to the WiFi Router/Hotspot.
  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("---------------Connection");
  Serial.print("Connecting to : ");
  Serial.println(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Successfully connected to : ");
  Serial.println(WIFI_SSID);
  //Serial.print("IP : ");
  //Serial.println(WiFi.localIP());
  Serial.println("---------------");
  //----------------------------------------

  // Assign the api key (required).
  config.api_key = API_KEY;

  // Assign the RTDB URL (required).
  config.database_url = DATABASE_URL;

  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  // Assign the callback function for the long running token generation task.
  config.token_status_callback = tokenStatusCallback;  //--> see addons/TokenHelper.h

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}
//________________________________________________________________________________

void ReviceData() {
  s = Serial.readStringUntil('\n');

  if (s != "") {
    if (s == "phongkhach_1") {
      store_phongkhach_state = 1;
    }

    if (s == "phongkhach_0") {
      store_phongkhach_state = 0;
    }

    if(s == "phongan_1"){
      store_phongan_state = 1;
    }

    if(s == "phongan_0"){
      store_phongan_state = 0;
    }
  }
}

//________________________________________________________________________________ VOID LOOP
void loop() {
  // put your main code here, to run repeatedly:

  if(digitalRead(btn_wc) == HIGH && btn_wc_pressed == false){
    btn_wc_pressed = true;
    if(trang_thai_wc == 0){
      Serial.write("btn_wc1");
      trang_thai_wc = 1;
      store_wc_state = 1;
    } else if(trang_thai_wc == 1){
      Serial.write("btn_wc0");
      trang_thai_wc = 0;
      store_wc_state = 0;
    }
  }

  if(digitalRead(btn_wc) == LOW && btn_wc_pressed == true){
    btn_wc_pressed = false;
  }

  if (Firebase.ready() && (millis() - sendDataPrevMillis > sendDataIntervalMillis || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();

    if (Firebase.RTDB.getInt(&fbdo, "Device/1/status")) {
      if (fbdo.dataType() == "int") {
        last_phongkhach_state = fbdo.intData();
        Serial.print("last_phongkhach_state : ");
        Serial.println(last_phongkhach_state);
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/2/status")) {
      if (fbdo.dataType() == "int") {
        last_wc_state = fbdo.intData();
        Serial.print("last_wc_state : ");
        Serial.println(last_wc_state);
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/3/status")) {
      if (fbdo.dataType() == "int") {
        last_phongan_state = fbdo.intData();
        Serial.print("last_phongan_state : ");
        Serial.println(last_phongan_state);
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    ReviceData();
    
    if(last_phongkhach_state != store_phongkhach_state){
      if (Firebase.RTDB.setInt(&fbdo, "Device/1/status", store_phongkhach_state)) {
        Serial.println("PASSED");
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if(store_wc_state != last_wc_state){
      if (Firebase.RTDB.setInt(&fbdo, "Device/2/status", store_wc_state)) {
        Serial.println("PASSED");
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if(store_phongan_state != last_phongan_state){
      if (Firebase.RTDB.setInt(&fbdo, "Device/3/status", store_phongan_state)) {
        Serial.println("PASSED");
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }
  }
}