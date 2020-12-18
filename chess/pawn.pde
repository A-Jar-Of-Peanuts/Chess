class Pawn extends Chesspiece {
  public Pawn(int posx, int posy) {
    super(posx, posy);
    piece = wpawn;
  }

  public boolean act(int posx, int posy) {
    if (posy == this.posy && posx == this.posx + 1) {
      System.out.println("moving pawn");
     return true;
    }
    return false;
  }
  public void show() {
    //System.out.println("HI"); 
    if (isO) {
      image(bpawn, posy*100, posx*100, 100, 100);
    } else
      image(wpawn, posy*100, posx*100, 100, 100);
  }
}
