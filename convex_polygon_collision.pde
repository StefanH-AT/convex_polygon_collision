
LoopingArrayList<Polygon> polygons = new LoopingArrayList<Polygon>();

Camera camera;
Renderer renderer;

final int mapSize = 10;
final int mapMax = mapSize / 2;
final int mapMin = -mapMax;

void setup() {
  
  size(1200, 800);
  
  camera = new Camera(this);  
  renderer = new Renderer();  
  
  polygons.add( new Polygon(new Vertex[]{new Vertex(-3f, 0f), new Vertex(0f, 0f), new Vertex(-3f, 3f)}) );
  polygons.add( new Polygon(new Vertex[]{new Vertex(0f, -1f), new Vertex(1, -4f), new Vertex(4f, -3f), new Vertex(5f, 3f)}) );
  //polygons.add( new Polygon(new Vertex[]{new Vertex(-5f, 2f), new Vertex(-5, -4f), new Vertex(-3f, -2f), new Vertex(-4f, 3f)}) );
  
}

void draw() {
  
  camera.update();
  renderer.render();
  
  // I'm not proud of this
  int polygonArrayLength = polygons.size();
  for(int i = 0; i < polygonArrayLength; i++) {
    for(int j = 0; j < polygonArrayLength; j++) {
      if(i != j) {
          
        // SAT Collision
        Vector axis = polygons.get(i).collides(polygons.get(j));
        if(axis != null) {
          if(DRAW_PROJECTION_AXES) axis.draw(new Vertex(0, 0));
          i++;
          j++;
        }  
        
      }
    }
  }
  
  for(Polygon poly : polygons) {
    poly.draw();
  }
  
  
}

void keyPressed() {
  if(key == 's') CURSOR_SNAP = !CURSOR_SNAP;
  if(key == 'v') DRAW_VECTORS = !DRAW_VECTORS;
  if(key == 'p') DRAW_VERTECIES = !DRAW_VERTECIES;
  if(key == 'c') SELECTED_INDEX = ++SELECTED_INDEX % polygons.size();
  if(key == 'a') DRAW_PROJECTION_AXES = !DRAW_PROJECTION_AXES;
  if(key == 'b') DRAW_BOUNDING_BOX = !DRAW_BOUNDING_BOX;
  if(key == 'f') FILL_POLY = !FILL_POLY;
}



void mouseWheel(MouseEvent event) {
  camera.zoomToPoint(-event.getCount(), camera.getMouseX(), camera.getMouseY());  
}

@Override
void mouseDragged(MouseEvent event) {
  if (event.getButton() == RIGHT) camera.drag();
  if (event.getButton() == LEFT) polygons.get(SELECTED_INDEX).translate(new Vector((mouseX - pmouseX) / camera.getZoom(), (mouseY - pmouseY) / camera.getZoom()));
}

/** Checks if the coordinates are inside of the grid */
boolean isInbounds(int x, int y) {
  return x >= mapMin && y >= mapMin && x <= mapMax && y <= mapMax;
}

/** Checks if the cursor is inside of the grid */
boolean isCursorInbounds() {
  return isInbounds(camera.getMouseXSnapped(), camera.getMouseYSnapped());
}
