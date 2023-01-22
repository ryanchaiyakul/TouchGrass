#include "Adafruit_Si7021.h"
#include "Adafruit_VEML6070.h"
#include "BluetoothSerial.h"

#include <math.h>

BluetoothSerial SerialBT;

Adafruit_Si7021 sensor = Adafruit_Si7021();
Adafruit_VEML6070 uv = Adafruit_VEML6070();

void setup() {
  Serial.begin(115200);

  // Serial setup
  SerialBT.begin("TouchGrass"); //Bluetooth device name

  // Si7021 not found (Wiring is bad)
  if (!sensor.begin()) {
    while(true) {
      Serial.println("Si7021 not found");
      delay(1000);
    }
  }

  uv.begin(VEML6070_4_T);  // 500 ms sampling

  // Interrupt button setup
  pinMode(23, INPUT_PULLUP);
  attachInterrupt(23, print_fish, FALLING);
}

/**
 * Print Humidity, Temperature, and UV every second
 */
void debug_sensors() {
  Serial.print("Humidity:    ");
  Serial.print(sensor.readHumidity(), 2);
  Serial.print("\tTemperature: ");
  Serial.println(sensor.readTemperature(), 2);
  Serial.print("UV light level: "); 
  Serial.println(uv.readUV());
  delay(1000);
}

/**
 * Transmit the input to BT and print the output from BT here
 */
void debug_serial() {
  if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  if (SerialBT.available()) {
    Serial.write(SerialBT.read());
  }
  delay(20);
}

/**
 * Println fish (for button interrupt)
 */
void print_fish() {
  Serial.println("fish");
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

void get_json_packet(char* ret, char** strings, int size) {
    *ret = '{';
    int cur_length = 1;
    for (int i = 0; i < size; i++) {
        strcpy(ret + cur_length, strings[i]);
        cur_length += strlen(strings[i]);
    }
    strcpy(ret + cur_length, "}\0");
}

// Reverses a string 'str' of length 'len'
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

// Alternative overload to copy no leading zeros
void intToStr(int x, char str[]) {
    int i = 0;

    // Find the amount of digits
    int temp = x;
    while (temp) {
        i++;
        temp = temp / 10;
    }
    intToStr(x, str, i);
}
 
// Converts a floating-point/double number to a string.
void ftoa(float n, char* res, int afterpoint)
{
    // Extract integer part
    int ipart = (int)n;
 
    // Extract floating part
    float fpart = n - (float)ipart;
 
    // convert integer part to string
    int i = intToStr(ipart, res, 0);
 
    // check for display option after point
    if (afterpoint != 0) {
        res[i] = '.'; // add dot
 
        // Get the value of fraction part upto given no.
        // of points after dot. The third parameter
        // is needed to handle cases like 233.007
        fpart = fpart * pow(10, afterpoint);
 
        intToStr((int)fpart, res + i + 1, afterpoint);
    }
}
 

/*
 * Gets and formats sensor readings into a json packet
 */
void send_json() {
  char uv_val[10];
  intToStr(uv.readUV(), uv_val);
  char tmp_val[10];
  ftoa(sensor.readTemperature(), tmp_val, 2);
  char rh_val[10];
  ftoa(sensor.readHumidity(), rh_val, 2);

  char* str_ar[3];
  str_ar[0] = get_json_string("\"UV\"", uv_val, true);
  str_ar[1] = get_json_string("\"TMP\"", tmp_val, true);
  str_ar[2] = get_json_string("\"RH\"", rh_val);

  char ret[100];
  get_json_packet(ret, str_ar, 3);
  
  int i = 0;
  while (ret[i]) {
    SerialBT.write((unsigned char) (ret[i]));
    delay(20);
    i++;
  }

  delete [] str_ar[0];
  delete [] str_ar[1];
  delete [] str_ar[2];
}


void loop() {
  send_json();
  delay(1000);
}
