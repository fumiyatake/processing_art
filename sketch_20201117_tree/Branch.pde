import java.util.*;

class Branch extends BaseTreeNode{
  float _tiltTheta;
  float _branchPointPer;
  HashMap<Integer,Float> _childPosList = new HashMap<Integer,Float>();
  float _power, _maxPower;
  
  public Branch( TreeSystem tree, int nodeId, int parentCount ){
    super( tree, nodeId, parentCount );
    _tiltTheta    = _parentCount == 0 ? 0 : random( -30, 30 );
    _power        = 0.1;
    _maxPower     = random( 5 - pow( 1.2 , _parentCount ), 7 - pow( 1.2 , _parentCount ) );
  }
  
  public void update(){
    pushMatrix();
    rotate( radians( _tiltTheta ) );
    
    if( _power < _maxPower ) _power += 0.01;
    fill( 225, 205, 120, 30 * _power );
    noStroke();
    blendMode( SCREEN );
    rect( -sqrt(_power*3/(_parentCount+1)), 0, sqrt(_power*3/(_parentCount+1)), -_power * 30  );
    
    if( _parentCount < 15 && _childPosList.size() <= 10 - pow( 1.2 , _parentCount ) &&  random( 100 ) > 100 - _power / 2 ){
      _childPosList.put( _tree.createNode( _nodeId, TreeConfig.Type.Branch ), random( 0.3, 0.9 ) );
    }
    if( _parentCount > 2 && _childPosList.size() <= 30 - pow( 1.2 , _parentCount ) &&  random( 100 ) > 100 - _power / 2 ){
      _childPosList.put( _tree.createNode( _nodeId, TreeConfig.Type.Leaf ), random( 0.5, 0.9 ) );
    }
    
    for( int branchId : _childPosList.keySet() ){
      BaseTreeNode branch = _tree.getNodeFromId( branchId );
      pushMatrix();
      translate( 0, _childPosList.get( branchId ) * -_power * 30 );
      branch.update();
      popMatrix();
    }
    popMatrix();
  }
  
  public int getParentCount(){
    return _parentCount;
  }
  
  
}
