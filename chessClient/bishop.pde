class Bishop extends Chesspiece {

  public Bishop(int posx, int posy) {
    super(posx, posy);
    piece = bbishop;
  }

  public void act(int posx, int posy) {
    this.posx = posx; 
    this.posy = posy;
  }

  public void show() {
    if(isO) {
      image(wbishop, posy*100, posx*100, 100, 100);
    } else
    image(bbishop, posy*100, posx*100, 100, 100);
  }
}
