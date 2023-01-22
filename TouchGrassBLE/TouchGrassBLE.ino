#include "NimBLEDevice.h"
#include "Adafruit_Si7021.h"
#include "Adafruit_VEML6070.h"
#include <math.h>

Adafruit_Si7021 sensor = Adafruit_Si7021();
Adafruit_VEML6070 uv = Adafruit_VEML6070();

const char* SERVICE_UUID = "8e0f4583-7d03-4215-b9af-07aa7a22b50a";
const char* CHARACTERISTIC_UUID = "a01017da-62af-4ef4-aeb7-ac422ab2b525";

void setup() {
  Serial.begin(115200);

   NimBLEDevice::init("TouchGrass");
   
  // Si7021 not found (Wiring is bad)
  if (!sensor.begin()) {
    while(true) {
      Serial.println("Si7021 not found");
      delay(1000);
    }
  }

  uv.begin(VEML6070_4_T);  // 500 ms sampling
}

/**
 * Returns a dynamically allocated c string in the form key: value with or without a comma
 * (MUST ENCAPSULATE KEY WITH "")
 */
char* get_json_string(char* key, char* value, bool comma = false) {
    int key_length = strlen(key);
    int value_length = strlen(value);

    // Calculate resulting string length
    int ret_length = key_length + value_length + 3;
    if (comma) {
        // Two extra characters for ", "
        ret_length += 2;
    }
    char* ret = new char[ret_length];
    
    // ret is in the format key + ": " + value
    strcpy(ret, key);
    strcpy(ret + key_length, ": ");
    strcpy(ret + key_length + 2, value);

    // Append either ", \0" or "\0"
    if (comma) {
        strcpy(ret + key_length + value_length + 2, ", \0");
    } else {
        ret[key_length + value_length + 2] = '\0';
    }

    return ret;
}

/**
 * Append json strings together and encapsulate with {}
 * Writes to c string passed as ret
 * Size is the size of the array of json strings
 */
char* get_json_packet(char** strings, int size) {
    // Space to add "{", "}", and "\0"
    int ret_length = 3;
    int* string_lengths = new int[size];
    for (int i = 0; i < size; i++) {
      string_lengths[i] = strlen(strings[i]);
      ret_length += string_lengths[i];
    }

    char* ret = new char[ret_length];
    
    *ret = '{';
    int cur_length = 1; 
    for (int i = 0; i < size; i++) {
        strcpy(ret + cur_length, strings[i]);
        cur_length += string_lengths[i];
    }
    strcpy(ret + cur_length, "}\0");

    delete [] string_lengths;

    return ret;
}

// Reverses a string 'str' of length 'len'
// Used to reverse floating points
void reverse(char* str, int len)
{
    int i = 0, j = len - 1, temp;
    while (i < j) {
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
        i++;
        j--;
    }
}
 
// Converts a given integer x to string str[].
// d is the number of digits required in the output.
// If d is more than the number of digits in x,
// then 0s are added at the beginning.
int intToStr(int x, char str[], int d)
{
    int i = 0;
    while (x) {
        str[i++] = (x % 10) + '0';
        x = x / 10;
    }
 
    // If number of digits required is more, then
    // add 0s at the beginning
    while (i < d)
        str[i++] = '0';
 
    reverse(str, i);
    str[i] = '\0';
    return i;
}

// Alternative overload to copy no leading zeros and return a str
// d is the number of digits expected after the zero
char* getIntStr(int x, int d = 0) {
    int i = 0;

    // Find the amount of digits
    int temp = x;
    while (temp) {
        i++;
        temp = temp / 10;
    }

    // Plus one for the '\0'
    int ret_length = i + 1;
    if (d > 0) {
      // Number of digits after and the '.'
      ret_length += d + 1;
    }

    char* ret = new char[ret_length];
    intToStr(x, ret, i);
    return ret;
}
 
// Converts a floating-point/double number to a string.
char* ftoa(float n, int afterpoint)
{
    // Extract integer part
    int ipart = (int)n;
 
    // Extract floating part
    float fpart = n - (float)ipart;
 
    char* ret = getIntStr(ipart, afterpoint);

    int end = strlen(ret);
 
    // check for display option after point
    if (afterpoint != 0) {
        ret[end] = '.'; // add dot

        // Get the value of fraction part upto given no.
        // of points after dot. The third parameter
        // is needed to handle cases like 233.007
        fpart = fpart * pow(10, afterpoint);
 
        intToStr((int)fpart, ret + end + 1, afterpoint);
    }

    return ret;
}

/*
 * Gets and formats sensor readings into a json packet
 */
void send_json() {
  char* uv_val = getIntStr(uv.readUV());
  char* tmp_val = ftoa(sensor.readTemperature(), 2);
  char* rh_val = ftoa(sensor.readHumidity(), 2);

  char* str_ar[3];
  str_ar[0] = get_json_string("\"UV\"", uv_val, true);
  str_ar[1] = get_json_string("\"TMP\"", tmp_val, true);
  str_ar[2] = get_json_string("\"RH\"", rh_val);

  char* ret = get_json_packet(str_ar, 3);

  send(ret);

  delete [] uv_val;
  delete [] tmp_val;
  delete [] rh_val;
  delete [] str_ar[0];
  delete [] str_ar[1];
  delete [] str_ar[2];
  delete [] ret;
}

void send(char* value) {
  NimBLEScan *pScan = NimBLEDevice::getScan();
  NimBLEScanResults results = pScan->start(10);
  
  NimBLEUUID serviceUuid(SERVICE_UUID);
  
  for(int i = 0; i < results.getCount(); i++) {
      NimBLEAdvertisedDevice device = results.getDevice(i);

      //Serial.println(device.getAddress());
      
      if (device.isAdvertisingService(serviceUuid)) {
          NimBLEClient *pClient = NimBLEDevice::createClient();

          Serial.println("Found device advertising service");
          
          if (pClient->connect(&device)) {
              NimBLERemoteService *pService = pClient->getService(serviceUuid);
              
              if (pService != nullptr) {
                  NimBLERemoteCharacteristic *pCharacteristic = pService->getCharacteristic(CHARACTERISTIC_UUID);
                  
                  if (pCharacteristic != nullptr) {
                      if (pCharacteristic->writeValue(value)) {
                        Serial.println("Wrote value"); 
                      } else {
                        Serial.println("Failed to write value");
                      }
                  }
              }
          } else {
            Serial.println("Failed to connect or find characteristic");
          }
          
          NimBLEDevice::deleteClient(pClient);
      }
  }
}

void loop() {
  send_json();
  delay(1000);
}