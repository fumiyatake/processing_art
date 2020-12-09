import java.util.ArrayList;
final float CAM_DEG_PER_FRAME = 0.2;
static MountainSystem mountainSystem;
ArrayList<WaterParticle> waterList = new ArrayList<WaterParticle>();
float[][] settingList = {
 { 300, 2 }, 
 { 20, 2 }, 
 { 300, 5 }
};
int _type = 0;
boolean _isDisplayMountain = true;
PVector _camCenter;
float _camTheta, _camPhi, _camDist;


void setup(){
  size( 1600, 800, P3D );
  _camTheta = 0;
  _camDist = ( height + width );
  _camCenter = new PVector( width / 2, -( height + width ) / 4 , -height / 2 );
  init(0);
}

void draw(){
  waterList.add( new WaterParticle( mountainSystem ) ); 
  for( WaterParticle water: waterList ){
    water.update();
  }
}

void init( int type ){
  _type = type;
  waterList.clear();
  mountainSystem = new MountainSystem( (int)settingList[type][0], settingList[type][1] );
  
  background( 0 );
  
  PVector camPosition = new PVector( 
    _camCenter.x + _camDist * cos( radians( _camPhi ) ) *  sin( radians( _camTheta ) ),
    _camCenter.y + _camDist * sin( radians( _camPhi ) ) *  sin( radians( _camTheta ) ),
    _camCenter.z + _camDist * cos( radians( _camTheta ) )
  );
  camera( camPosition.x, camPosition.y, camPosition.z,
          _camCenter.x, _camCenter.y, _camCenter.z,
          0, 1, 0);
  directionalLight( 150, 100, 50, 1, 1, -1 );
  directionalLight( 100, 50, 0, -1, 1, 1 );
  if( _isDisplayMountain ) mountainSystem.draw();
}

void switchView(){
  _isDisplayMountain = !_isDisplayMountain;
  init( _type );
}

void changeNoiseSeed(){
  noiseSeed( (long)random(100) ); 
  init( _type );
}

void moveCamera( char key ){
  switch( key ){
    case '1':
      _camDist -= ( height + width ) / 10;
      if( _camDist < 0 ) _camDist = 0;
      break;
    case '2':
      _camDist += ( height + width ) / 10;
      if( _camDist > ( height + width ) ) _camDist = ( height + width );
      break;
    case '3':
      _camTheta -= 10;
      break;
    case '4':
      _camTheta += 10;
      break;
    case '5':
      _camPhi -= 10;
      break;
    case '6':
      _camPhi += 10;
      break;
  }
  init( _type );
}

void keyPressed(){
  switch( key ){
    case 'a':
      init( 0 );
      break;
    case 's':
      init( 1 );
      break;
    case 'd':
      init( 2 );
      break;
    case BACKSPACE:
      switchView();
      break;
    case 'n':
      changeNoiseSeed();
      break;
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
      moveCamera( key );
      break;
  }
}
