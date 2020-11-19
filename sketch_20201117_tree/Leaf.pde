class Leaf extends BaseTreeNode{
  
  final PVector _firstPoint = new PVector( 5, -25 );
  final int[][] _bezierPoints = {
      { 0, -20, -6, -15, -5, -10 }
    , { -4, -5, 2, -5, 4, -9 }
    , { 6, -13, 2, -17, 5, -25 }
  };
  
  float _power, _tiltTheta;
  
  public Leaf( TreeSystem tree, int nodeId, int parentCount ){
    super( tree, nodeId, parentCount );
    _power     = 0;
    _tiltTheta = random( -60, 60 );
  }
  
  protected void update(){
    pushMatrix();
    rotate( radians( _tiltTheta ) );
    _power += 0.01;
    
    blendMode( BLEND );
    float sizeRate = sqrt( sqrt( _power ) );
    fill( 100, 160, 75, sqrt( _power ) * 30  );
    beginShape();
    vertex( _firstPoint.x * sizeRate, _firstPoint.y * sizeRate );
    for( int[] p: _bezierPoints ){
      bezierVertex( p[0] * sizeRate, p[1] * sizeRate, p[2] * sizeRate, p[3] * sizeRate, p[4] * sizeRate, p[5] * sizeRate );
    }
    endShape();
    popMatrix();

  }
}
