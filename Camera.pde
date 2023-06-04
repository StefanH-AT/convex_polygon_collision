public class Camera {
  
  private PApplet applet;
  private PVector pos;
  private float zoom = 50;
  private final float minZoom = 10;
  private final float maxZoom = 100;
  
  
  /**
   * 
   * A 2D camera for Processing. Features positioning, translating and zooming.
   *  
   *  */
  public Camera(PApplet applet) {
    pos = new PVector(0, 0);
    this.applet = applet;
  }
  
  
  /** 
   * 
   * @return The relative X coordinate of the mouse X
   * 
   * */
  public float getMouseX() {
    return (float) -getAbsolute(applet.width, applet.mouseX - getPosition().x);
  }
  
  /** 
   * 
   * @return The relative Y coordinate of the mouse Y
   * 
   * */
  public float getMouseY() {
    return (float) -getAbsolute(applet.height, applet.mouseY - getPosition().y);
  }
  
  public int getMouseXSnapped() {
    return (int) Math.floor(getMouseX());
  }
  
  public int getMouseYSnapped() {
    return (int) Math.floor(getMouseY());
  }
  
  /** 
   * 
   * This method translates the canvas along the mouse
   * 
   * */
  public void drag() {
    translate(applet.mouseX - applet.pmouseX, applet.mouseY - applet.pmouseY);
  }
  
  public void translate(float f, float g) {
    pos.add(f, g);
  }
  
  public void translateX(int dx) {
    translate(dx, 0);
  }
  
  public void translateY(int dy) {
    translate(0, dy);
  }
  
  /** 
   * Increases or decreases the zoom amount by a given amount
   * (Recommended)
   * 
   * @return The new zoom amount
   * */
  public float zoom(float amount) {
    this.zoom += amount;
    
    this.zoom = constrain(zoom, minZoom, maxZoom);
    return this.zoom;
  }
  
  /** 
   * 
   * Zooms in or out from a point (Relative coordinates)
   * Can be used to zoom in your mouse.
   * 
   * */
  public void zoomToPoint(float amount, float x, float y) {
    
    // Save previous mouse position
    float tx = getMouseX();
    float ty = getMouseY();
    
    // Zoom in
    float zoom = zoom((float) amount);
    
    // Calculate deltas
    float dx = (tx - getMouseX()) * zoom;
    float dy = (ty - getMouseY()) * zoom;
    
    // Translate to the point
    translate(-dx , -dy );
  }

  public PVector getPosition() {
    return pos;
  }
  
  /** 
   * @return The X coordinate at the center of the camera
   */
  public float getPositionAbsoluteX() {
    return pos.x / -zoom;
  }
  
  /** 
   * @return The Y coordinate at the center of the camera
   */
  public float getPositionAbsoluteY() {
    return pos.y / -zoom;
  }
  
  /** 
   * @return The zoom value
   * */
  public float getZoom() {
    return zoom;
  }
  
  /** 
   * NOTE: Higher values equal zooming out
   * @return Sets the zoom
   * */
  public void setZoom(float zoom) {
    this.zoom = zoom;
  }
  
  /** 
   * NOTE: Higher values equal zooming out
   * @return The minimal zoom amount
   * 
   * */
  public float getMinZoom() {
    return minZoom;
  }
  
  /** 
   * NOTE: Higher values equal zooming out
   * @return The maximal zoom amount
   * 
   * */
  public float getMaxZoom() {
    return maxZoom;
  }
  
  /** 
   * 
   * Teleports the camera to a specific position (Relative).
   * 
   * */
  public void teleport(PVector camPos) {
    this.pos = camPos;
  }
  
  /** 
   * 
   * Teleports the camera to a specific position (Relative).
   * 
   * */
  public void teleport(float x, float y) {
    this.pos.x = x;
    this.pos.y = y;
  }
  
  /** 
   * Relative coordinates!
   * @return if the coordinate is visible or not. 
   * 
   **/  
  public boolean isVisible(float x, float y) {
    return isVisibleX(x) && isVisibleY(y);
  }
  
  public boolean isVisibleX(float x) {
    return !(Math.abs(getAbsoluteX(x)) > getViewportWidth() / 2);
  }
  
  public boolean isVisibleY(float y) {
    return !(Math.abs(getAbsoluteY(y)) > getViewportHeight() / 2);
  }
  
  /** 
   * Sets the camera in position.
   * Execute this method in draw()
   * */
  public void update() {
    applet.translate(applet.width / 2 + pos.x, applet.height / 2 + pos.y);
    applet.scale(zoom);
  }
  
  /** 
   * 
   * @return The width of the rendered area
   * 
   * */
  public float getViewportWidth() {
    return applet.width / zoom;
  }
  
  /** 
   * 
   * @return The height of the rendered area
   * 
   * */
  public float getViewportHeight() {
    return applet.height / zoom;
  }
  
  /** 
   * Absolute coordinates are always relative to the camera position (Follow the camera)
   * @return The absolute coordinate on the X axis
   * 
   * */
  public float getAbsoluteX(float relative) {
    return getAbsolute(relative, pos.x);
  }
  
  /** 
   * Absolute coordinates are always relative to the camera position (Follow the camera)
   * @return The absolute coordinate on the Y axis
   * 
   * */
  public float getAbsoluteY(float relative) {
    return getAbsolute(relative, pos.y);
  }
  
  /** 
   * Absolute coordinates are always relative to the camera position (Follow the camera)
   * @return The absolute coordinate on a given axis
   * 
   * */
  public float getAbsolute(float relative, float center) {
    return (center - relative / 2) / -zoom;
  }
}
