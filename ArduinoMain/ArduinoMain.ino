byte x;
int j = 0;
int state=0;
int sensorValue=0;
int sensorPin = A0;


void setup() {
 Serial.begin(115200);
 pinMode(10, 'OUTPUT');
 delay(100);
 //digitalWrite(10, HIGH);
 //digitalWrite(10, LOW);
}

void loop() 
{
  sensorValue = analogRead(sensorPin);
  if(Serial.available()>0)
  {
    //Serial.print("I am reading this: ");
    j=Serial.read();
    //Serial.println(j);
    Execute(j);
    //Serial.flush();
  } 
}

void Execute(int t) {
  switch (t)
  {
    case 1:
      Serial.println("Dark");
      state=1;
      digitalWrite(10, HIGH);
      break;
    case 2:
      state=2;
      Serial.println("Light");
      digitalWrite(10, LOW);
      break;
    case 3:
      Serial.print("Last State: ");
      Serial.println(state);
      break;
    case 4:
      Serial.print("Resistance: ");
      Serial.println(sensorValue);
      break;
    default:
      state=0;
      Serial.println("Unknown command");
      break;  
  }   
}
