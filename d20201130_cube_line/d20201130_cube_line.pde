final float CAM_DEG_PER_FRAME = 0.2;
static LineParticleSystem particleSystem;


void setup(){
  size( 1200, 600, P3D );
  background( 0 );
  particleSystem = new LineParticleSystem();
}

void draw(){
  // 半回転で止める場合はture消す
  if( true || frameCount < 90 / CAM_DEG_PER_FRAME ){
    float rad = radians( 90 - frameCount * CAM_DEG_PER_FRAME );
    camera( width / 2, height * sin( rad ), height / 2 + ( height  * cos( rad ) ),
            width / 2, 0, height / 2,
            0, cos( rad ) >= 0 ? 1 : -1, sin( rad ) < 0 ? 1 : -1 );
  }else{
    camera( width / 2, 0, height / 2 - height ,
            width / 2, 0, height / 2,
            0, 1, 1 );
  }
  
  background( 0 );
  ambientLight( 150, 150, 150 );
  directionalLight( 155, 255, 255, -1, 1, 1 );
  particleSystem.update();
}
