class King extends Chesspiece {
  public King(int posx, int posy) {
    super(posx, posy);
    piece = wking;
  }

 public boolean act(int posx, int posy) {
   if(posx == this.posx) {
     if(posy == this.posy -1 || posy == this.posy +1) {
       return true;
     }
   }
   if(posy == this.posy) {
     if(posx == this.posx -1 || posx == this.posx +1) {
       return true;
     }
   }
   if(posy == this.posy+1 || posy == this.posy-1) {
     if(posx == this.posx-1 || posx == this.posx+1) {
       return true;
     }
   }
   if(posx == this.posx+1 || posx == this.posx-1) {
     if(posy == this.posy-1 || posy == this.posy+1) {
       return true;
     }
   }
   return false;
  }
  public void show() {
    if(isO) {
      image(bking, posy*100, posx*100, 100, 100);
    } else
    image(wking, posy*100, posx*100, 100, 100);
  }
}
