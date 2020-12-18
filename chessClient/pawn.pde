class Pawn extends Chesspiece {
  public Pawn(int posx, int posy) {
    super(posx, posy);
    piece = wpawn;
  }

  public void act(int posx, int posy) {
    this.posx = posx; 
    this.posy = posy;
  }
  public void show() {
    //System.out.println("HI"); 
    if(isO) {
      image(wpawn, posy*100, posx*100, 100, 100);
    } else
    image(bpawn, posy*100, posx*100, 100, 100);
  }
}
