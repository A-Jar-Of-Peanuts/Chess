class Bishop extends Chesspiece {

  public Bishop(int posx, int posy) {
    super(posx, posy);
    piece = wbishop;
  }

   public boolean act(int posx, int posy) {
   return true;
  }

  public void show() {
    if(isO) {
      image(bbishop, posy*100, posx*100, 100, 100);
    } else
    image(wbishop, posy*100, posx*100, 100, 100);
  }
}
