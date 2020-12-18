class Queen extends Chesspiece {
  public Queen(int posx, int posy) {
    super(posx, posy);
    piece = wqueen;
  }

  public void act(int posx, int posy) {
    this.posx = posx; 
    this.posy = posy;
  }
  public void show() {
    if(isO) {
      image(wqueen, posy*100, posx*100, 100, 100);
    } else
    image(bqueen, posy*100, posx*100, 100, 100);
  }
}
