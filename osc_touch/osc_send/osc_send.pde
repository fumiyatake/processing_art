import oscP5.*;
import netP5.*;

final int PORT = 12001;
final String ADDRESS = "127.0.0.1";

OscP5 osc;
NetAddress myRemoteLocation;

void setup(){
  size( 500, 500 );
  frameRate( 60 );
  osc = new OscP5( this, PORT + 1 );
  myRemoteLocation = new NetAddress( ADDRESS, PORT );
}

void draw(){
  if( mousePressed ){
    background( 255, 0, 0 ); 
  }else{
    background( 0 );
  }
  
  noFill();
  stroke( 255 );
  ellipse( mouseX, mouseY, 10, 10 );
  
  OscMessage msg = new OscMessage( "/mouse/position" );
  msg.add( mouseX );
  msg.add( mouseY );
  osc.send( msg, myRemoteLocation );
}

void mousePressed(){
  OscMessage msg = new OscMessage( "/mouse/clicked" );
  msg.add( 1 );
  osc.send( msg, myRemoteLocation );
}

void mouseReleased(){
  OscMessage msg = new OscMessage( "/mouse/clicked" );
  msg.add( 0 );
  osc.send( msg, myRemoteLocation );
}
