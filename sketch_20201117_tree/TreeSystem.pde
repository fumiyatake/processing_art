class TreeSystem{
  private ArrayList<BaseTreeNode> _nodeList = new ArrayList<BaseTreeNode>();
  PVector _position;
  
  public TreeSystem( PVector position ){
    _position = position;
    createTrunk();
  }
  
  public void render(){
    translate( _position.x, _position.y );
    _nodeList.get(0).update();
  }
  
  public BaseTreeNode getNodeFromId( int id ){
    if( id < 0 || id >= _nodeList.size() ) return null;
    return _nodeList.get( id ); 
  }
  
  /**
   * 幹を作ります
   */
  public void createTrunk(){
    if( _nodeList.size() != 0 ) return;
    Branch branch = new Branch( this, 0, 0 );
    _nodeList.add( branch );
  }
  
  /**
   * ノードをを作ります
   */
  public int createNode( int parentNodeId, TreeConfig.Type type ){
    int nodeId = _nodeList.size();
    BaseTreeNode node;
    switch( type ){
      case Branch:
        node = new Branch( this, nodeId, _nodeList.get( parentNodeId ).getParentCount() + 1 );
        break;
      case Leaf:
        node = new Leaf( this, nodeId, _nodeList.get( parentNodeId ).getParentCount() + 1 );
        break;
      case Flower:
      case Petal:
      case Trunk:
        // TODO
      default:
        throw new Error( "undefined type" );
    };
    _nodeList.add( node );
    return nodeId;
  }
}

static class TreeConfig{
 static enum Type{
      Trunk
    , Branch
    , Leaf
    , Flower
    , Petal
  } 
}
