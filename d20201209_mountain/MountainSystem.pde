class MountainSystem{
  // 線をつなぐ対象の位置の設定(各パーティクル毎にから見たときの{ row, column }の相対位置)
  final private int[][][] CONNECT_SETTING = {
        { { -1, 0 }, { -1, 1 } }
      , { { 0, 1 } , { -1, 1 } }
  };
  private PolygonNode[][] _nodes;
  private float[][] _addHeights;
  private int[] _maxHeightIndex = {0,0};
  
  private int _nodeCount;  // 大きいほどポリゴンが細かくなる
  private float _noiseLevel;   // 大きいほど起伏のある地形になる
  
  public MountainSystem( int nodeCount, float noiseLevel ){
    _nodeCount  = nodeCount;
    _noiseLevel = noiseLevel;
    _nodes = new PolygonNode[_nodeCount][_nodeCount];
    _addHeights = new float[_nodeCount][_nodeCount];
    
    for( int row = 0; row < _nodeCount; row++ ){
      for( int column = 0; column < _nodeCount; column++ ){
        float positionY = -( ( column + row ) * height / _nodeCount );
        positionY = positionY * noise( row / (float)_nodeCount * _noiseLevel, column / (float)_nodeCount * _noiseLevel );
        _nodes[row][column] = new PolygonNode( new PVector( width / ( _nodeCount - 1 ) * column, positionY, -height / ( _nodeCount - 1 ) * row ) );
        if( positionY < _nodes[_maxHeightIndex[0]][_maxHeightIndex[1]].getPosition().y ){
          _maxHeightIndex[0] = row;
          _maxHeightIndex[1] = column;
        }
      }
    }
  }
  
  public void draw(){
    noStroke();
    fill( 255, 200 );
    for( int row = 1; row < _nodeCount; row++ ){
      for( int column = 0; column < _nodeCount - 1; column++ ){
        PVector selfPosition = _nodes[row][column].getPosition();
        for( int shapeIndex = 0; shapeIndex < CONNECT_SETTING.length; shapeIndex++ ){
          beginShape();
          vertex( selfPosition.x, selfPosition.y, selfPosition.z );
          for( int pointIndex = 0; pointIndex < CONNECT_SETTING[shapeIndex].length; pointIndex++ ){
            PVector targetPosition = _nodes[row + CONNECT_SETTING[shapeIndex][pointIndex][0]][column + CONNECT_SETTING[shapeIndex][pointIndex][1]].getPosition();
            vertex( targetPosition.x, targetPosition.y, targetPosition.z );
          }
          endShape();
        }
      }
    }
    _createWall();
  }
  
  public int[] getMaxHeightIndex(){
    return _maxHeightIndex.clone(); 
  }
  
  public PVector getPosition( int[] indexPair ){
    if( !_isValidIndexPair( indexPair ) ){
      println( "invalid pair " + indexPair[0] + "," + indexPair[1] );
      return null;
    }
    return _nodes[indexPair[0]][indexPair[1]].getPosition(); 
  }
  
  public PVector getPutOnPosition( int[] indexPair ){
    if( !_isValidIndexPair( indexPair ) ){
      println( "invalid pair " + indexPair[0] + "," + indexPair[1] );
      return null;
    }
    PVector basePosition = _nodes[indexPair[0]][indexPair[1]].getPosition(); 
    basePosition.y -= _addHeights[indexPair[0]][indexPair[1]];
    return basePosition;
  }
  public void addHeight( int[] indexPair, float value ){
    if( !_isValidIndexPair( indexPair ) ){
      println( "invalid pair " + indexPair[0] + "," + indexPair[1] );
      return;
    }
    _addHeights[indexPair[0]][indexPair[1]] += value;
  }
  
  /**
   * 指定された行列ペアの地点から次に向かうべき行列ペアを取得します
   */
  public int[] getNextPutonIndexPair( int[] currentIndexPair ){
    int[] nextIndexPair = currentIndexPair.clone();
    for( int row = -1; row <= 1; row++ ){
      int targetRow = currentIndexPair[0] + row;
      for( int column = -1; column <= 1; column++ ){
        int targetColumn = currentIndexPair[1] + column;
        int[] targetIndexPair = { targetRow, targetColumn };
        
        if( !_isValidIndexPair( targetIndexPair ) ) continue;

        // よりYが大きい = 下にある場所へ移動 
        if( getPutOnPosition( targetIndexPair ).y > getPutOnPosition( nextIndexPair ).y ){
          nextIndexPair[0] = targetRow;
          nextIndexPair[1] = targetColumn;
        }
      }
    }
    return nextIndexPair;
  }
  
  private boolean _isValidIndexPair( int[] indexPair ){
    if( indexPair[0] < 0 ) return false;
    if( indexPair[1] < 0 ) return false;
    if( indexPair[0] >= _nodeCount ) return false;
    if( indexPair[1] >= _nodeCount ) return false;
    return true;
  }
  
  public void _createWall(){
    fill( 200 );
    for( int row = 0; row < _nodeCount - 1; row++ ){
      int[] columnList = { 0, _nodeCount - 1 };
      for( int i = 0; i < columnList.length; i++ ){
        PVector selfPosition = _nodes[row][columnList[i]].getPosition();
        PVector nextPosition = _nodes[row + 1][columnList[i]].getPosition();
        beginShape();
        vertex( selfPosition.x, 0, selfPosition.z );
        vertex( selfPosition.x, selfPosition.y, selfPosition.z );
        vertex( nextPosition.x, nextPosition.y, nextPosition.z );
        vertex( nextPosition.x, 0, nextPosition.z );
        endShape();
      }
    }
    for( int column = 0; column < _nodeCount - 1; column++ ){
      int[] rowList = { 0, _nodeCount - 1 };
      for( int i = 0; i < rowList.length; i++ ){
        PVector selfPosition = _nodes[rowList[i]][column].getPosition();
        PVector nextPosition = _nodes[rowList[i]][column + 1].getPosition();
        beginShape();
        vertex( selfPosition.x, 0, selfPosition.z );
        vertex( selfPosition.x, selfPosition.y, selfPosition.z );
        vertex( nextPosition.x, nextPosition.y, nextPosition.z );
        vertex( nextPosition.x, 0, nextPosition.z );
        endShape();
      }
    }
  }
}
