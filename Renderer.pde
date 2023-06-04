public class Renderer {
  
  private final int gridHintFrequency = 10;
  private final float gridWidth = 1 / 32f;
  
  /** Renders everything*/
  public void render() {

    strokeWeight(gridWidth);
    
    renderBackground();
    if(isCursorInbounds()) renderCursor();
  }
  
  public void gridLineX(float y) {
    line(mapMin, y, mapMax, y);
  }
  
  public void gridLineY(float x) {
    line(x, mapMin, x, mapMax);
  }
  
  public void gridLine(float xy) {
    gridLineX(xy);
    gridLineY(xy);
  }
  
  public void gridLine(float x, float y) {
    gridLineY(x);
    gridLineX(y);
  }
  
  public void renderBackground() {
    
    background(255);
    
    for(int i = mapMin; i <= mapMax; i++) {
      
      stroke(100);
      gridLine(i);
      
      if(i % gridHintFrequency == 0) {
        stroke(50);
        gridLine(i);
      }
    
      // Drawing the 0, 0 cross
      stroke(0);
      gridLine(0);
    }
  }
  
  public void renderCursor() {
    stroke(200, 0, 0);
    
    float x = camera.getMouseX();
    float y = camera.getMouseY();
    
    if(CURSOR_SNAP) {
      x = round(x);
      y = round(y);
    }
    
    gridLine(x, y);
    textSize(0.7);
    fill(50);
    text(x + ", " + y, x, y);
  }
}
