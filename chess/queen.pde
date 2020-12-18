class Queen extends Chesspiece {
  public Queen(int posx, int posy) {
    super(posx, posy);
    piece = wqueen;
  }

 public boolean act(int posx, int posy) {
   return true;
  }
  public void show() {
    if(isO) {
      image(bqueen, posy*100, posx*100, 100, 100);
    } else
    image(wqueen, posy*100, posx*100, 100, 100);
  }
}
