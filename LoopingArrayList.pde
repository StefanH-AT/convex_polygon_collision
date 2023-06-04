public class LoopingArrayList<E> extends ArrayList<E> {
   
  @Override
  public E get(int index) {
    if(index >= size()) return get(size() - index);
    if(index < 0) return get(size() + index);
    else return super.get(index);
  }
  
}
