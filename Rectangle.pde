class Rectangle {
  
  public Vector origin;
  public Vector size;
  
  public color rectColor;
  public color collisionColor;
  
  public boolean collides;
  
  public Rectangle(float x, float y, float w, float h) {
    this.origin = new Vector(x, y);
    this.size = new Vector(w, h);
    
    rectColor = color(123, 68, 195, 100);
    collisionColor = color(218, 63, 151, 100);
  }
  
  public void draw() {
    
    fill(collides ? collisionColor : rectColor);
    noStroke();
    rect(origin.x, origin.y, size.x, size.y);
    
    collides = false;
    
  }
  
  public void translate(Vector translation) {
    origin.add(translation);
  }
  
  public boolean overlaps(Rectangle other) {
    boolean coll = origin.x + size.x > other.origin.x && 
    origin.x < other.origin.x + other.size.x &&
    origin.y < other.origin.y + other.size.y && 
    origin.y + size.y > other.origin.y;
    
    if(coll) { 
      collides = true;
      other.collides = true;
    }
    
    return collides;
  }
  
}
