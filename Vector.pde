class Vector extends Point {
  
  final float arrowSize = 0.02;
  
  public Vector(int x, int y) {
    this((float) x, (float) y);
  }
  
  public Vector(float x, float y) {
    super(x, y);
  }
  
  public void draw(Vertex origin) {
    
    if(!DRAW_VECTORS) return;
    
    noFill();
    stroke(0, 0, 255);
    strokeWeight(0.05);
    line(origin.x, origin.y, origin.x + x, origin.y + y);
    strokeWeight(0.2);
    /*
    pushMatrix();
    translate(origin.x + x, origin.y + y);
    //rotate(getRotation());
    triangle(-arrowSize, 0, arrowSize, 0, 0, -arrowSize);
    
    popMatrix();*/
    
  }
  
  public Vector scale(float factor) {
    x *= factor;
    y *= factor;
    return this;
  }
  
  public Vector add(Vector vector) {
    x += vector.x;
    y += vector.y;
    
    return this;
  }
  
  public void add(float x, float y) {
    this.x += x;
    this.y += y;
  }
  
  public Vector inverse() {
    x = -x;
    y = -y;
    
    return this;
  }
  
  public float length() {
    return sqrt(x * x + y * y);
  }
  
  public Vector copy() {
    return new Vector(x, y);
  }
  
  public float dot(Vector vector) {
    return x * vector.x + y * vector.y;
  }
  
  public Vector normal() {
    return new Vector(-y, x);
  }
  
  public Vector unit() {
    Vector vec = copy();
    vec.scale(1 / vec.length());
    return vec;
  }
  
  @Override
  public boolean equals(Object obj) {
    if(obj instanceof Point) {
      Point point = (Point) obj;
      
      return point.x == x && point.y == y;
    } else return false;
  }
  
  public float getRotation() {
    return asin(length());
  }
  
}
