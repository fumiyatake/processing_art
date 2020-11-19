abstract class BaseTreeNode{
  
  protected TreeSystem _tree;
  protected int _nodeId;
  protected int _parentCount;
  
  public BaseTreeNode( TreeSystem tree, int nodeId, int parentCount ){
    this._tree = tree;
    this._nodeId = nodeId;
    this._parentCount = parentCount;
  }
  
  protected abstract void update();
  
  public int getParentCount(){
    return _parentCount;
  }
}
