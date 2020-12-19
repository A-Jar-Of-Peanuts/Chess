class Bishop extends Chesspiece {

  public Bishop(int posx, int posy) {
    super(posx, posy);
    piece = wbishop;
  }

  public boolean act(int posx, int posy) {
    boolean blocked = false;
    if (!(Math.abs(posx-this.posx) == Math.abs(posy-this.posy))) {
      blocked = true;
    } else {
      if (posx < this.posx) {
        if (posy <this.posy) {
          for (int i = 1; i<Math.abs(posx-this.posx); i++) {
            if (grid[this.posx-i][this.posy-i] != -1) {
              blocked = true;
            }
          }
        } else if (posy > this.posy) {
          for (int i = 1; i<Math.abs(posx-this.posx); i++) {
            if (grid[this.posx-i][this.posy+i] != -1) {
              blocked = true;
            }
          }
        }
      } else if (posx > this.posx) {
        if (posy<this.posy) {
          for (int i = 1; i<Math.abs(posx-this.posx); i++) {
            if (grid[this.posx+i][this.posy-i] != -1) {
              blocked = true;
            }
          }
        } else if (posy > this.posy) {
          for (int i = 1; i<Math.abs(posx-this.posx); i++) {
            if (grid[this.posx+i][this.posy+i] != -1) {
              blocked = true;
            }
          }
        }
      }
    }
    return !blocked;
  }


  public void show() {
    if (isO) {
      image(bbishop, posy*100, posx*100, 100, 100);
    } else
      image(wbishop, posy*100, posx*100, 100, 100);
  }
}
