import java.util.ArrayList;

class Particle{
  private PVector _basePosition, _position, _direction;
  private float _speed;
  private color _color;
  private ArrayList<Dust> _dusts = new ArrayList<Dust>();
  private int _diameter = 5;
  
  public Particle( PVector basePositon, color c ){
    _basePosition = basePositon;
    _position     = basePositon.copy();
    _direction    = new PVector( 0, random( -1, 1 ), 0 );
    _direction.normalize();
    
    _color = c;
    _speed = random( 1 );
  }
  
  public void update(){
    _position.add( _direction.copy().mult( (float)Math.cbrt( _speed * 0.1 * ( height / 4 - PVector.dist( _basePosition, _position ) + 1 ) ) ) );
    if( abs( _position.y - _basePosition.y ) > height / 4 ){
      _createDust();
      _position.y = _basePosition.y + ( height / 4 * _direction.y );
      _direction.y *= -1;
    }
    
    noStroke();
    
    pushMatrix();
    
    translate( _position.x, _position.y, _position.z );
    fill( _color );
    sphere( _diameter );
    
    popMatrix();
    
    _updateDusts();
  }
  
  public PVector getPosition(){
    return _position.copy(); 
  }
  
  public PVector getVelocity(){
    return _position.copy().mult( _speed ); 
  }
  
  private void _createDust(){
    int count = (int)map( random( 1 ), 0, 1, 5, 8 );
    for( int i = 0; i < count; i++ ){
      PVector force = new PVector( random( -1, 1 ), random( _direction.y ), random( -1, 1 ) );
      force.normalize().mult( sqrt( _speed ) );
      color c = color( 
        noise( ( _position.x + force.x + frameCount ) * 0.01 ) * 255,
        noise( ( _position.y + force.y + frameCount  ) * 0.01 ) * 255,
        noise( ( _position.z + force.z + frameCount  ) * 0.01 ) * 255 );
      _dusts.add( new Dust( _position.copy(), force, c, sqrt( random( _diameter ) ) ) );
    }
  }
  
  private void _updateDusts(){
    for( Dust dust : _dusts ){
      dust.update();
    }
    
    for( int i = 0; i < _dusts.size(); ){
      if( _dusts.get( i ).isDead() ){
        _dusts.remove( i );
        continue;
      }
      i++;
    }

  }
}
