class King extends Chesspiece {
  public King(int posx, int posy) {
    super(posx, posy);
    piece = wking;
  }

  public void act(int posx, int posy) {
    this.posx = posx; 
    this.posy = posy;
  }
  public void show() {
    if(isO) {
      image(wking, posy*100, posx*100, 100, 100);
    } else
    image(bking, posy*100, posx*100, 100, 100);
  }
}
