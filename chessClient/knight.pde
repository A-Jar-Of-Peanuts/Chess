class Knight extends Chesspiece {
  public Knight(int posx, int posy) {
    super(posx, posy);
    piece = wknight;
  }

  public boolean act(int posx, int posy) {
    if (this.posx+2 == posx) {
      if (this.posy+1 == posy) {
        return true;
      } else if (this.posy-1 == posy) {
        return true;
      }
    } else if (this.posx-2 == posx) {
      if (this.posy+1 == posy) {
        return true;
      } else if (this.posy-1 == posy) {
        return true;
      }
    } else if (this.posy+2 == posy) {
      if (this.posx+1 == posx) {
        return true;
      } else if (this.posx-1 == posx) {
        return true;
      }
    } else if (this.posy-2 == posy) {
      if (this.posx+1 == posx) {
        return true;
      } else if (this.posx-1 == posx) {
        return true;
      }
    }
    return false;
  }
  
  public void show() {
    if (isO) {
      image(wknight, posy*100, posx*100, 100, 100);
    } else
      image(bknight, posy*100, posx*100, 100, 100);
  }
}
