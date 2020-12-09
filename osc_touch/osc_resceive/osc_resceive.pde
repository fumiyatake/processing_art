import oscP5.*;
import netP5.*;

final int PORT = 12000;
final String ADDRESS = "127.0.0.1";

OscP5 osc;

PVector mouseLoc;

int clicked;

void setup(){
  size( 500, 500 );
  frameRate( 60 );
  osc = new OscP5( this, PORT );
  mouseLoc = new PVector( width / 2, height / 2 );
  clicked = 0;
}

void draw(){
  if( clicked == 1 ){
    background( 255, 0, 0 ); 
  }else{
    background( 0 );
  }
  
  noFill();
  stroke( 255 );
  ellipse( mouseLoc.x, mouseLoc.y, 10, 10 );
}

void oscEvent( OscMessage msg ){
  if( msg.checkAddrPattern( "/mouse/position" ) == true ){
    mouseLoc.x = msg.get(0).intValue();
    mouseLoc.y = msg.get(1).intValue();
  }
  if( msg.checkAddrPattern( "/mouse/clicked" ) == true ){
    clicked = msg.get(0).intValue();
  }
}
