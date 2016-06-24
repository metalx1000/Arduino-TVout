#include <TVout.h>
#include <fontALL.h>
#include "skull2.h"
#include "skull.h"

TVout TV;

int zOff = 150;
int xOff = 0;
int yOff = 0;
int cSize = 50;
int view_plane = 64;
float angle = PI/60;


void setup() {

  unsigned char w;
  w = pgm_read_byte(skull);
  TV.begin(NTSC,120,96);
  TV.select_font(font6x8);
  TV.bitmap(0,0,skull2);
  TV.delay(2500);
  TV.clear_screen();
  intro();
  TV.println("Frank Castle is\nTHE PUNISHER!!!");
  TV.delay(1500);
  TV.clear_screen();
  TV.bitmap((TV.hres() - w)/2,0,skull2);
  TV.delay(10000);
  TV.clear_screen();

}



void intro() {
unsigned char w,l,wb;
  int index;
  w = pgm_read_byte(skull);
  l = pgm_read_byte(skull+1);
  if (w&7)
    wb = w/8 + 1;
  else
    wb = w/8;
  index = wb*(l-1) + 2;
  for ( unsigned char i = 1; i < l; i++ ) {
    TV.bitmap((TV.hres() - w)/2,0,skull,index,w,i);
    index-= wb;
    TV.delay(50);
  }
  for (unsigned char i = 0; i < (TV.vres() - l)/2; i++) {
    TV.bitmap((TV.hres() - w)/2,i,skull);
    TV.delay(50);
  }
  TV.delay(3000);
  TV.clear_screen();
}

void loop(){
  unsigned char w,l,wb;
  int index;
  
  index = wb*(l-1) + 2;
  for (unsigned char i = 0; i < (TV.hres()); i++) {
    TV.bitmap(i,5,skull);
    TV.delay(50);
  }
  
}

