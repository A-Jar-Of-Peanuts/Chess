class Pawn extends Chesspiece {
  public Pawn(int posx, int posy) {
    super(posx, posy);
    piece = wpawn;
  }

   public boolean act(int posx, int posy) {
     if(!isO) {
      if(((King)pieces[12]).inCheck(this.posx, this.posy, posx, posy)) {
        return false;
      }
    }
    if (posy == this.posy && posx == this.posx + 1 && grid[posx][posy] == -1) {
      //System.out.println("moving pawn");
      return true;
    } else if (posx == this.posx+1 && (posy == this.posy-1 || posy == this.posy+1) && grid[posx][posy] !=-1) {
      return true;
    }
    return false;
  }
  
  public void show() {
    //System.out.println("HI"); 
    if(isO) {
      image(wpawn, posy*100, posx*100, 100, 100);
    } else
    image(bpawn, posy*100, posx*100, 100, 100);
  }
}
