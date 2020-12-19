abstract class Chesspiece {
  PImage piece; 
  int posx, posy; 
  boolean isO = false; 
  public Chesspiece(int posx, int posy) {
    this.posx = posx; 
    this.posy = posy;
  }

  public void show() {
  }
  
  //checks if move is valid
  abstract public boolean act(int posx, int posy);
}
