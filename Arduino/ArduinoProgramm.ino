#include <SoftwareSerial.h>

SoftwareSerial mySerial(7, 8);
String url = "http://retrorbit.spdns.de/get_Data2.php";  //URL of Server Test "http://testserver.aeq-web.com/sim800_test/sim800.php" our "http://retrorbit.spdns.de/get_Data.php"
String device = "rl651ld6zras4z6jk4d9";
String Feld[20];
void setup()
{
  

   
mySerial.begin(9600);               // the GPRS baud rate   
Serial.begin(9600);               // the GPRS baud rate   
mySerial.println("AT+CMEE=1"); // mehr fehler bericht
  Serial.println("Test");   
 wart(1000);
mySerial.println("AT+CPIN=<1503>"); // pin1503
 wart(1000);


//initalizier GPS
mySerial.println("AT+CGNSPWR=1");
wart(1000);
mySerial.println("AT+CGNSSEQ=RMC");
wart(1000);
 




}
void wart(int warte){
  long int time = millis();   
  String ausgabe = ""; 
  time = millis();   
      while( (time+warte) > millis())
    {
      while(mySerial.available())
      {       
        char nBuchstabe = mySerial.read(); 
        ausgabe+=nBuchstabe;
      }  
    }
    Serial.print(ausgabe);    
    return;
  }


String gpsDaten(void)
{
    String GPS = "";    
    mySerial.println("AT+CGNSINF"); 
    long int time = millis();   
    while( (time+1000) > millis())
    {
      while(mySerial.available())
      {       
        char nBuchstabe = mySerial.read(); 
        GPS+=nBuchstabe;
      }  
    }    



    return GPS;       
}
void SendToServer()
{



String GPS= gpsDaten();
int x=0, n=0;

for (int i=0; i < GPS.length(); i++)
{ 
 if(GPS.charAt(i) == ',') 
  { 
    Feld[n] = GPS.substring(x, i); 
    x=(i+1); 
    n++; 
  }
}


  for (int x = 0; x < 20; x++)
  {
    Serial.print(Feld[x]); 
    Serial.print(';');
  }
Serial.println(GPS);




  mySerial.println("AT");
  delay(3000);
 
  mySerial.println("AT+SAPBR=3,1,\"Contype\",\"GPRS\"");

  wart(6000);
 
  mySerial.println("AT+SAPBR=3,1,\"APN\",\"TM\"");//APN

wart(6000);
 
  mySerial.println("AT+SAPBR=1,1");

 wart(6000);
 
  mySerial.println("AT+SAPBR=2,1");

 wart(6000);
 

mySerial.println("AT+HTTPINIT");
 wart(6000);
  mySerial.println("AT+HTTPPARA=\"CID\",1");
 wart(6000);
mySerial.println("AT+HTTPPARA=URL," + url);
 wart(3000);
  mySerial.println("AT+HTTPPARA=CONTENT,application/x-www-form-urlencoded");//application/x-www-form-urlencoded
   wart(3000);
  mySerial.println("AT+HTTPDATA=192,5000");
     wart(3000);
     //payload = {'device':"+device+", 'Latitude':1, 'Longitude':2}  {\" device\":\"  rl651ld6zras4z6jk4d9  \",\"  Latitude  \" :25, \" Longitude \":26}
  mySerial.println("param={\"device\":\""+device+"\",\"Latitude\":"+Feld[3]+",\"Longitude\":"+Feld[4]+"}");
     wart(3000);
  mySerial.println("AT+HTTPACTION=1");
     wart(3000);
  mySerial.println("AT+HTTPREAD");
     wart(3000);
  mySerial.println("AT+HTTPTERM");
     wart(3000);
  mySerial.println("AT+SAPBR=0,1");// endet verbindung 
     wart(3000);

return;

}
void loop()
{
SendToServer();
}
