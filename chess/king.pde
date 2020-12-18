class King extends Chesspiece {
  public King(int posx, int posy) {
    super(posx, posy);
    piece = wking;
  }

  public boolean act(int posx, int posy) {
   return true;
  }
  public void show() {
    if(isO) {
      image(bking, posy*100, posx*100, 100, 100);
    } else
    image(wking, posy*100, posx*100, 100, 100);
  }
}
