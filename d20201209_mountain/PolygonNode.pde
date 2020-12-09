import java.util.ArrayList;

class PolygonNode{
  private PVector _basePosition, _position, _direction;
  private float _speed;
  
  public PolygonNode( PVector basePositon ){
    _basePosition = basePositon;
    _position     = basePositon.copy();
    _direction    = new PVector( 0, random( -1, 1 ), 0 );
    _direction.normalize();
    
    _speed = random( 1 );
  }
  
  public void update(){
    _position.add( _direction.copy().mult( (float)Math.cbrt( _speed * 0.1 * ( height / 4 - PVector.dist( _basePosition, _position ) + 1 ) ) ) );
    if( abs( _position.y - _basePosition.y ) > height / 4 ){
      _position.y = _basePosition.y + ( height / 4 * _direction.y );
      _direction.y *= -1;
    }
  }
  
  public PVector getPosition(){
    return _position.copy(); 
  }
  
  public PVector getVelocity(){
    return _position.copy().mult( _speed ); 
  }
}
