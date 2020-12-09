class Dust{
  private PVector _position, _velocity;
  private float _diameter, _friction;
  private color _color;
  private boolean _isDead;
  
  public Dust( PVector position, PVector force, color c, float diameter ){
    _position  = position;
    _velocity  = force;
    _color     = c;
    _diameter  = diameter;
    _friction  = 0.01;
    _isDead    = false;
  }
  
  public void update(){
    if( _isDead ) return;
    
    pushMatrix();
    
    translate( _position.x, _position.y, _position.z );
    fill( _color );
    sphere( _diameter );
    popMatrix();
    
    _velocity.div( 1 - _friction );
    _position.add( _velocity );
    _diameter *= ( 1 - _friction );
    if( _diameter < 1 )_isDead = true;
  }
  
  public boolean isDead(){
    return _isDead;
  }
}
