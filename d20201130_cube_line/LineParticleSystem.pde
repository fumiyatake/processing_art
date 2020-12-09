
class LineParticleSystem{
  final int PARTICLE_COUNT = 10;
  // 線をつなぐ対象の位置の設定(各パーティクル毎にから見たときの{ row, column }の相対位置)
  final int[][] CONNECT_SETTING = {
      { 0, 1 }
    , { 1, -1 }
    , { 1, 0 }
    , { 1, 1 }
  };
  Particle[][] particles = new Particle[PARTICLE_COUNT][PARTICLE_COUNT];
  
  public LineParticleSystem(){
    for( int row = 0; row < PARTICLE_COUNT; row++ ){
      for( int column = 0; column < PARTICLE_COUNT; column++ ){
        particles[row][column] = new Particle( new PVector( width / ( PARTICLE_COUNT - 1 )* column, 0, height / ( PARTICLE_COUNT - 1 ) * row ), color( 255 ) );
      }
    }
  }
  
  public void update(){
    for( int row = 0; row < PARTICLE_COUNT; row++ ){
      for( int column = 0; column < PARTICLE_COUNT; column++ ){
        particles[row][column].update();
      }
    }
    
    stroke( 255 );
    strokeWeight( 0.3 );
    for( int row = 0; row < PARTICLE_COUNT; row++ ){
      for( int column = 0; column < PARTICLE_COUNT; column++ ){
        PVector selfPosition = particles[row][column].getPosition();
        for( int i = 0; i < CONNECT_SETTING.length; i++ ){
          if( row    + CONNECT_SETTING[i][0] < 0 || row    + CONNECT_SETTING[i][0] >= PARTICLE_COUNT ) continue;
          if( column + CONNECT_SETTING[i][1] < 0 || column + CONNECT_SETTING[i][1] >= PARTICLE_COUNT ) continue;
          
          PVector targetPosition = particles[row + CONNECT_SETTING[i][0]][column + CONNECT_SETTING[i][1]].getPosition();
          line( selfPosition.x, selfPosition.y, selfPosition.z
              , targetPosition.x, targetPosition.y, targetPosition.z );
        }
      }
    }
  }
}
