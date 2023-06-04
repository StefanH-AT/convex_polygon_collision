class Vertex extends Vector {
  
  public Vertex(float x, float y) {
    super(x, y);
  }
  
  public void draw() {
    
    if(!DRAW_VERTECIES) return;
    
    noFill();
    stroke(255, 0, 0);
    strokeWeight(0.2);
    point(x, y);
  }
   
}
