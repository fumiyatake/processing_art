TreeSystem tree;
void setup(){
 size(800, 800); 
 background(0);
 tree = new TreeSystem( new PVector( width / 2, height ) );
}

void draw(){
  background(0);
  tree.render();
}
