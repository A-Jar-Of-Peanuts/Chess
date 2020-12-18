class Knight extends Chesspiece {
  public Knight(int posx, int posy) {
    super(posx, posy);
    piece = wknight;
  }

  public void act(int posx, int posy) {
    this.posx = posx; 
    this.posy = posy;
  }
  public void show() {
    if(isO) {
      image(wknight, posy*100, posx*100, 100, 100);
    } else
    image(bknight, posy*100, posx*100, 100, 100);
  }
}
