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

// Insert Authentication
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
const long sendDataIntervalMillis = 5000;  //--> Sends/stores data to firebase database every 5 seconds.
//========================================

int btn_wc = 12;

bool btn_wc_pressed = false;

byte trang_thai_wc = 0;

String s;

byte store_phongkhach_state;
byte last_phongkhach_state;
byte phongkhach_change = 0;

byte store_baodong_state;
byte last_baodong_state;
byte baodong_change = 0;

byte store_wc_state;
byte last_wc_state;
byte wc_change = 0;

byte store_phongan_state;
byte last_phongan_state;
byte phongan_change = 0;

byte store_phongngu_state;
byte last_phongngu_state;
byte phongngu_change = 0;

int store_phongngu_value;
int last_phongngu_value;
byte phongngu_value_change = 0;

byte store_gara_state;
byte last_gara_state;
byte gara_change = 0;

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

  if (s == "phongkhach_1") {
    store_phongkhach_state = 1;
    phongkhach_change = 1;
  }

  if (s == "phongkhach_0") {
    store_phongkhach_state = 0;
    phongkhach_change = 1;
  }

  if (s == "phongan_1") {
    store_phongan_state = 1;
    phongan_change = 1;
  }

  if (s == "phongan_0") {
    store_phongan_state = 0;
    phongan_change = 1;
  }

  if (s == "phongngu_1") {
    store_phongngu_state = 1;
    phongngu_change = 1;
  }

  if (s == "phongngu_0") {
    store_phongngu_state = 0;
    phongngu_change = 1;
  }

  if (s == "gara_1") {
    store_gara_state = 1;
    gara_change = 1;
  }

  if (s == "gara_0") {
    store_gara_state = 0;
    gara_change = 1;
  }

  if (s == "baodong_1") {
    store_baodong_state = 1;
    baodong_change = 1;
  }

  if (s == "baodong_0") {
    store_baodong_state = 0;
    baodong_change = 1;
  }

  if (s == "phongngu_15") {
    store_phongngu_value = 15;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_30") {
    store_phongngu_value = 30;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_45") {
    store_phongngu_value = 45;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_60") {
    store_phongngu_value = 60;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_75") {
    store_phongngu_value = 75;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_90") {
    store_phongngu_value = 90;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_105") {
    store_phongngu_value = 105;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_120") {
    store_phongngu_value = 120;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_135") {
    store_phongngu_value = 135;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_150") {
    store_phongngu_value = 150;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_165") {
    store_phongngu_value = 165;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_180") {
    store_phongngu_value = 180;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_195") {
    store_phongngu_value = 195;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_210") {
    store_phongngu_value = 210;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_225") {
    store_phongngu_value = 225;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_240") {
    store_phongngu_value = 240;
    phongngu_value_change = 1;
  }

  if (s == "phongngu_255") {
    store_phongngu_value = 255;
    phongngu_value_change = 1;
  }
}

//________________________________________________________________________________ VOID LOOP
void loop() {
  // put your main code here, to run repeatedly:

  if (digitalRead(btn_wc) == HIGH && btn_wc_pressed == false) {
    btn_wc_pressed = true;
    if (trang_thai_wc == 0) {
      Serial.write("btn_wc1\n");
      trang_thai_wc = 1;
      store_wc_state = 1;
      wc_change = 1;
    } else if (trang_thai_wc == 1) {
      Serial.write("btn_wc0\n");
      trang_thai_wc = 0;
      store_wc_state = 0;
      wc_change = 1;
    }
  }


  if (digitalRead(btn_wc) == LOW && btn_wc_pressed == true) {
    btn_wc_pressed = false;
  }

  if (Serial.available()) {
    ReviceData();
  }

  if (Firebase.ready() && (millis() - sendDataPrevMillis > sendDataIntervalMillis || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();

    if (Firebase.RTDB.getInt(&fbdo, "Device/0/status")) {
      if (fbdo.dataType() == "int") {
        last_phongngu_state = fbdo.intData();

        if (last_phongngu_state != store_phongngu_state && phongngu_change == 0) {
          if (last_phongngu_state == 1) {
            Serial.write("phongngu_1\n");
          }
          if (last_phongngu_state == 0) {
            Serial.write("phongngu_0\n");
          }
          store_phongngu_state = last_phongngu_state;
        }
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/0/effect")) {
      if (fbdo.dataType() == "int") {
        last_phongngu_value = fbdo.intData();

        if (last_phongngu_value != store_phongngu_value && phongngu_value_change == 0 && last_phongngu_state == 1) {
          if (last_phongngu_value == 15) {
            Serial.write("phongngu_15\n");
          }

          if (last_phongngu_value == 30) {
            Serial.write("phongngu_30\n");
          }

          if (last_phongngu_value == 45) {
            Serial.write("phongngu_45\n");
          }

          if (last_phongngu_value == 60) {
            Serial.write("phongngu_60\n");
          }

          if (last_phongngu_value == 75) {
            Serial.write("phongngu_75\n");
          }

          if (last_phongngu_value == 90) {
            Serial.write("phongngu_90\n");
          }

          if (last_phongngu_value == 105) {
            Serial.write("phongngu_105\n");
          }

          if (last_phongngu_value == 120) {
            Serial.write("phongngu_120\n");
          }

          if (last_phongngu_value == 135) {
            Serial.write("phongngu_135\n");
          }

          if (last_phongngu_value == 150) {
            Serial.write("phongngu_150\n");
          }

          if (last_phongngu_value == 165) {
            Serial.write("phongngu_165\n");
          }

          if (last_phongngu_value == 180) {
            Serial.write("phongngu_180\n");
          }

          if (last_phongngu_value == 195) {
            Serial.write("phongngu_195\n");
          }

          if (last_phongngu_value == 210) {
            Serial.write("phongngu_210\n");
          }

          if (last_phongngu_value == 225) {
            Serial.write("phongngu_225\n");
          }

          if (last_phongngu_value == 240) {
            Serial.write("phongngu_240\n");
          }

          if (last_phongngu_value == 255) {
            Serial.write("phongngu_255\n");
          }
          store_phongngu_value = last_phongngu_value;
        }
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/1/status")) {
      if (fbdo.dataType() == "int") {
        last_phongkhach_state = fbdo.intData();

        if (last_phongkhach_state != store_phongkhach_state && phongkhach_change == 0) {
          if (last_phongkhach_state == 1) {
            Serial.write("phongkhach_1\n");
          }
          if (last_phongkhach_state == 0) {
            Serial.write("phongkhach_0\n");
          }
          store_phongkhach_state = last_phongkhach_state;
        }
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/1/mode")) {
      if (fbdo.dataType() == "int") {
        last_baodong_state = fbdo.intData();

        if (last_baodong_state != store_baodong_state && baodong_change == 0) {
          if (last_baodong_state == 1) {
            Serial.write("baodong_1\n");
          }
          if (last_baodong_state == 0) {
            Serial.write("baodong_0\n");
          }
          store_baodong_state = last_baodong_state;
        }
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/2/status")) {
      if (fbdo.dataType() == "int") {
        last_wc_state = fbdo.intData();

        if (last_wc_state != store_wc_state && wc_change == 0) {
          if (last_wc_state == 1) {
            Serial.write("btn_wc1\n");
          }
          if (last_wc_state == 0) {
            Serial.write("btn_wc0\n");
          }
          store_wc_state = last_wc_state;
        }
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/3/status")) {
      if (fbdo.dataType() == "int") {
        last_phongan_state = fbdo.intData();

        if (last_phongan_state != store_phongan_state && phongan_change == 0) {
          if (last_phongan_state == 1) {
            Serial.write("phongan_1\n");
          }
          if (last_phongan_state == 0) {
            Serial.write("phongan_0\n");
          }
          store_phongan_state = last_phongan_state;
        }
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (Firebase.RTDB.getInt(&fbdo, "Device/7/status")) {
      if (fbdo.dataType() == "int") {
        last_gara_state = fbdo.intData();

        if (last_gara_state != store_gara_state && gara_change == 0) {
          if (last_gara_state == 1) {
            Serial.write("gara_1\n");
          }
          if (last_gara_state == 0) {
            Serial.write("gara_0\n");
          }
          store_gara_state = last_gara_state;
        }
      }
    } else {
      Serial.println(fbdo.errorReason());
    }

    if (last_phongngu_state != store_phongngu_state) {
      if (Firebase.RTDB.setInt(&fbdo, "Device/0/status", store_phongngu_state)) {
        Serial.println("PASSED");
        phongngu_change = 0;
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if (last_phongngu_value != store_phongngu_value && last_phongngu_state == 1) {
      if (Firebase.RTDB.setInt(&fbdo, "Device/0/effect", store_phongngu_value)) {
        Serial.println("PASSED");
        phongngu_value_change = 0;
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if (last_phongkhach_state != store_phongkhach_state) {
      if (Firebase.RTDB.setInt(&fbdo, "Device/1/status", store_phongkhach_state)) {
        Serial.println("PASSED");
        phongkhach_change = 0;
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if (last_baodong_state != store_baodong_state) {
      if (Firebase.RTDB.setInt(&fbdo, "Device/1/mode", store_baodong_state)) {
        Serial.println("PASSED");
        baodong_change = 0;
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if (store_wc_state != last_wc_state) {
      if (Firebase.RTDB.setInt(&fbdo, "Device/2/status", store_wc_state)) {
        Serial.println("PASSED");
        wc_change = 0;
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if (store_phongan_state != last_phongan_state) {
      if (Firebase.RTDB.setInt(&fbdo, "Device/3/status", store_phongan_state)) {
        Serial.println("PASSED");
        phongan_change = 0;
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }

    if (store_gara_state != last_gara_state) {
      if (Firebase.RTDB.setInt(&fbdo, "Device/7/status", store_gara_state)) {
        Serial.println("PASSED");
        gara_change = 0;
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }
  }
}