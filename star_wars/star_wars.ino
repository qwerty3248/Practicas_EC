//www.elegoo.com
//2016.12.08

#include "pitches.h"

int ZumbadorPin=8;

int c=261; 
int d=294;
int e=329;
int f=349;
int g=391;
int gS=415;
int a=440;
int aS=455;
int b=466;
int cH=523;
int cSH=554;
int dH=587;
int dSH=622;
int eH=659;
int fH=698;
int fSH=740;
int gH=783;
int gSH=830;
int aH=880;
// notes in the melody:
int melody[] = {
  c, d, e, f, g, gS, a, aS,b ,cH,cSH, dH, eH, fH, fSH, gH ,gSH, aH};
int duration = 500;  // 500 miliseconds
 
void setup() {
 
}
 //el tono es la cancion de star wars no se puede poner en un vector por que suena distinto 
void loop() {  
  /*for (int thisNote = 0; thisNote < 18; thisNote++) {
    // pin8 output the voice, every scale is 0.5 sencond
    tone(8, melody[thisNote], duration);
     
    // Output the voice after several minutes 
    delay(1000);
  }*/
  tone(8, a, 500);
  delay(500+50);
  tone(ZumbadorPin, a, 500);
  delay(500+50);     
  tone(ZumbadorPin, a, 500); 
  delay(500+50);
  tone(ZumbadorPin, f, 350);  
  delay(350+50);
  tone(ZumbadorPin, cH, 150);
  delay(150+50); 
    
  tone(ZumbadorPin, a, 500);
  delay(500+50);
  tone(ZumbadorPin, f, 350);
  delay(350+50);
  tone(ZumbadorPin, cH, 150);
  delay(150+50);
  tone(ZumbadorPin, a, 1000);   
  delay(1000+50);
   
  tone(8, eH, 500);
  delay(500+50);
  tone(8, eH, 500);
  delay(500+50);
  tone(8, eH, 500); 
  delay(500+50);   
  tone(8, fH, 350);
  delay(350+50); 
  tone(8, cH, 150);
  delay(150+50);
    
    tone(8, gS, 500);
    delay(500+50);
    tone(ZumbadorPin, f, 350);
    delay(350+50);
    tone(ZumbadorPin, cH, 150);
    delay(150+50);
    tone(ZumbadorPin, a, 1000);
    delay(1000+50);
    
    tone(ZumbadorPin, aH, 500);
    delay(500+50);
    tone(ZumbadorPin, a, 350);
    delay(350+50); 
    tone(ZumbadorPin, a, 150);
    delay(150+50);
    tone(ZumbadorPin, aH, 500);
    delay(500+50);
    tone(ZumbadorPin, gSH, 250); 
    delay(250+50);
    tone(ZumbadorPin, gH, 250);
    delay(250+50);
    
    tone(ZumbadorPin, fSH, 125);
    delay(125+50);
    tone(ZumbadorPin, fH, 125);
    delay(125+50);    
    tone(ZumbadorPin, fSH, 250);
    delay(250+50);
    delay(250);
    tone(ZumbadorPin, aS, 250);
    delay(250+50);    
    tone(ZumbadorPin, dSH, 500); 
    delay(500+50); 
    tone(ZumbadorPin, dH, 250); 
    delay(250+50); 
    tone(ZumbadorPin, cSH, 250);
    delay(250+50);  
    
    // virtuosismo :)))
    
    tone(ZumbadorPin, cH, 125);
    delay(125+50);  
    tone(ZumbadorPin, b, 125); 
    delay(125+50); 
    tone(ZumbadorPin, cH, 250); 
    delay(250+50);     
    delay(250);
    tone(ZumbadorPin, f, 125); 
    delay(125+50); 
    tone(ZumbadorPin, gS, 500); 
    delay(500+50); 
    tone(ZumbadorPin, f, 375); 
    delay(375+50); 
    tone(ZumbadorPin, a, 125);
    delay(125+50); 
    
    tone(ZumbadorPin, cH, 500); 
    delay(500+50);
    tone(ZumbadorPin, a, 375);  
    delay(375+50);
    tone(ZumbadorPin, cH, 125); 
    delay(125+50);
    tone(ZumbadorPin, eH, 1000); 
    delay(1000+50);
 
    
    tone(ZumbadorPin, aH, 500);
    delay(500+50);
    tone(ZumbadorPin, a, 350); 
    delay(350+50);
    tone(ZumbadorPin, a, 150);
    delay(150+50);
    tone(ZumbadorPin, aH, 500);
    delay(500+50);
    tone(ZumbadorPin, gSH, 250);
    delay(250+50); 
    tone(ZumbadorPin, gH, 250);
    delay(250+50);
    
    tone(ZumbadorPin, fSH, 125);
    delay(125+50);
    tone(ZumbadorPin, fH, 125);  
    delay(125+50);  
    tone(ZumbadorPin, fSH, 250);
    delay(250+50);
    delay(250);
    tone(ZumbadorPin, aS, 250);  
    delay(250+50);  
    tone(ZumbadorPin, dSH, 500);  
    delay(500+50);
    tone(ZumbadorPin, dH, 250);  
    delay(250+50);
    tone(ZumbadorPin, cSH, 250);
    delay(250+50);  
 
    
    tone(ZumbadorPin, cH, 125);  
    delay(125+50);
    tone(ZumbadorPin, b, 125);  
    delay(125+50);
    tone(ZumbadorPin, cH, 250);
    delay(250+50);      
    delay(250);
    tone(ZumbadorPin, f, 250); 
    delay(250+50); 
    tone(ZumbadorPin, gS, 500); 
    delay(500+50); 
    tone(ZumbadorPin, f, 375);  
    delay(375+50);
    tone(ZumbadorPin, cH, 125); 
    delay(125+50);
           
    tone(ZumbadorPin, a, 500); 
    delay(500+50);           
    tone(ZumbadorPin, f, 375);  
    delay(375+50);          
    tone(ZumbadorPin, c, 125); 
    delay(125+50);  
    tone(ZumbadorPin, a, 1000);
    delay(1000+50);
   
  // restart after two seconds 
  delay(2000);
}
