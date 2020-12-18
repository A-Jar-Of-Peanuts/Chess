class Knight extends Chesspiece {
  public Knight(int posx, int posy) {
    super(posx, posy);
    piece = wknight;
  }

  public boolean act(int posx, int posy) {
   return true;
  }
  public void show() {
    if(isO) {
      image(bknight, posy*100, posx*100, 100, 100);
    } else
    image(wknight, posy*100, posx*100, 100, 100);
  }
}