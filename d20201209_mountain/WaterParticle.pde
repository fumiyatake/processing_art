class WaterParticle{
  private final static float HEIGHT         = 1; // 現在地に加算する高さのあたい
  
  private MountainSystem _mountain;
  private PVector _position, _direction;
  private int[] _currentIndexPair, _targetIndexPair;
  private int _tmpCount;
  private int _countForMove;
  
  public WaterParticle( MountainSystem mountain ){
    _mountain          = mountain;
    _currentIndexPair  = _mountain.getMaxHeightIndex();
    _position          = _mountain.getPutOnPosition( _currentIndexPair );
    _targetIndexPair   = _mountain.getNextPutonIndexPair( _currentIndexPair );
    _mountain.addHeight( _targetIndexPair, HEIGHT );
    _setDirection();
    _countForMove = (int)random( 5, 10 );
  }
  
  public void update(){
    if( _tmpCount == _countForMove ){
      _changeNextTarget();
    }
    _setDirection();
    PVector addVector = _direction.copy().div( _countForMove - _tmpCount );
    addVector.x       *= map( noise( ( _position.x + frameCount ) * 0.1 ), 0, 1, 1/5, 5 );
    addVector.z       *= map( noise( ( _position.z + frameCount ) * 0.1 ), 0, 1, 1/5, 5 );
    _position.add( addVector );
    _floorPosition();
    if( _position.y > 0 ) _position.y = 0;
    pushMatrix();
    noStroke();
    fill( 150, 180, 215, 30 );
    translate( 
      _position.x,
      _position.y,
      _position.z
    );
    sphere(1);
    popMatrix();
    _tmpCount++;
  }
  
  private void _changeNextTarget(){
    // 変更前に元々いた位置の高さを戻しておく
    _mountain.addHeight( _targetIndexPair, -HEIGHT );
    
    // 目標地点を次に変更
    _currentIndexPair = _targetIndexPair;
    
    _targetIndexPair  = _mountain.getNextPutonIndexPair( _targetIndexPair );
    
    _mountain.addHeight( _targetIndexPair, HEIGHT );
    
    _countForMove = (int)random( 5, 10 );
    _tmpCount = 0;
  }
  
  private void _setDirection(){
    _direction         = _mountain.getPutOnPosition( _targetIndexPair ).sub( _position );
  }
  
  private void _floorPosition(){
    if( _position.x < 0 ) _position.x = 0;
    if( _position.x > width ) _position.x = width;
    if( _position.z > 0 ) _position.z = 0;
    if( _position.z < -height ) _position.z = -height;
  }
}
