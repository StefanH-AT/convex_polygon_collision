import java.util.Arrays;

class Polygon {
  
  public LoopingArrayList<Vertex> vertecies = new LoopingArrayList<Vertex>();
  public LoopingArrayList<Vector> vectors = new LoopingArrayList<Vector>();
  public color polygonColor;
  public color collisionColor;
  public boolean collides = false;
  public Rectangle boundingBox;
  
  public Polygon(Vertex[] vertecies) {
    this.vertecies.addAll(Arrays.asList(vertecies));
    this.vectors = traceVertecies(this.vertecies);
    this.boundingBox = calcBoundingBox(this.vertecies);
    
    this.polygonColor = color(126, 230, 33);
    this.collisionColor = color(247, 72, 67);
  }
  
  public void draw() {
    
    if(DRAW_BOUNDING_BOX) boundingBox.draw();
    
    beginShape();
    
    for(int i = 0; i < vertecies.size(); i++) {
        Vertex vertex = vertecies.get(i);
        Vector vector = vectors.get(i);
        vertex(vertex.x, vertex.y);
        vector.draw(vertex);
        vertex.draw();
        
    }
    
    if(FILL_POLY) {
      fill(collides ? collisionColor : polygonColor);
    } else {
      noFill();
    }
    noStroke();
    endShape(CLOSE);
    
    collides = false;
    
  }
  
  public Vector collides(Polygon polygon) {    
    Vector axis = null;
    boolean bboxCollides = boundingBoxCollides(polygon);
    
    if(bboxCollides)  {
      axis = overlaps(polygon);     
      collides = axis == null;
      polygon.collides = axis == null;
    }
    
    return axis;
      
  }
  
  public boolean boundingBoxCollides(Polygon polygon) {
    return boundingBox.overlaps(polygon.boundingBox);
  }
  
  /**
  Collision detection with separating axis theorem
  */
  public Vector overlaps(Polygon polygon) {
    ArrayList<Vector> edges = new ArrayList<Vector>();
    edges.addAll(vectors);
    edges.addAll(polygon.vectors);
    
    for(int i = 0; i < edges.size(); i++) {
      Vector projectionAxis = edges.get(i).normal();
      
      // Get scalar range of this polygon
      Range thisRange = getProjectedRange(this, projectionAxis);
      Range otherRange = getProjectedRange(polygon, projectionAxis);
      
      if(!thisRange.overlaps(otherRange)) { //<>//
        return projectionAxis;
      } 
      
    }
    
    return null;
    
  }
  
  public Range getProjectedRange(Polygon polygon, Vector axis) {
    
    float[] dotProducts = new float[polygon.vertecies.size()];
    for(int i = 0; i < dotProducts.length; i++) {
        dotProducts[i] = axis.dot(polygon.vertecies.get(i));
    }
    
    return new Range(dotProducts);
  }
  
  public void translate(Vector translation) {
    for(Vertex vertex : vertecies) {
      vertex.add(translation);
    }
    
    vectors = traceVertecies(vertecies);
    boundingBox.translate(translation);
  }
  
  public LoopingArrayList<Vector> traceVertecies(LoopingArrayList<Vertex> verts) {
    
    if(verts.size() < 2) return null;
    
    LoopingArrayList<Vector> vecs = new LoopingArrayList<Vector>();
    
    for(int i = 0; i < verts.size(); i++) {
      Vertex curr = verts.get(i);
      Vertex next = verts.get(i + 1);
      vecs.add(new Vector(next.x - curr.x, next.y - curr.y));
      
    }
    
    return vecs;
  }
  
  public Rectangle calcBoundingBox(LoopingArrayList<Vertex> verts) {
    if(verts.size() < 3) return null;
    Vertex firstVert = verts.get(0);
    float bottom = firstVert.y;
    float top = firstVert.y;
    float left = firstVert.x;
    float right = firstVert.x;
    
    for(Vertex vert : verts) {
      if(vert.y > bottom) bottom = vert.y;
      if(vert.y < top) top = vert.y;
      if(vert.x < left) left = vert.x;
      if(vert.x > right) right = vert.x;
    }
    
    return new Rectangle(left, top, right - left, bottom - top);
  }
  
}
