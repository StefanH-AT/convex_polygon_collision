class Range {
  
  public float min = Float.MAX_VALUE;
  public float max = -Float.MAX_VALUE;
  
  public Range(float min, float max) {
    this.min = min;
    this.max = max;
  }
  
  public Range(float... values) {
    for(float val : values) {
      if(val > max) max = val;
      if(val < min) min = val;
    }
  }
  
  public boolean overlaps(Range r) {
    return r.min < max;
  }
  
  @Override
  public String toString() {
    return "[min: " + min + ", max: " + max + "]";
  }

}
