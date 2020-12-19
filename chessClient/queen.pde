class Queen extends Chesspiece {
  public Queen(int posx, int posy) {
    super(posx, posy);
    piece = wqueen;
  }

  public boolean act(int posx, int posy) {
    boolean blocked = false;
    if (!(Math.abs(posx-this.posx) == Math.abs(posy-this.posy)) && (posx != this.posx && posy!= this.posy)) {
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
        } else if (posx == this.posx) {
          if (posy > this.posy) {
            for (int i = this.posy+1; i<posy; i++) {
              if (grid[posx][i] != -1) {
                blocked = true;
                break;
              }
            }
          } else if (posy < this.posy) {
            for (int i = posy+1; i<this.posy; i++) {
              if (grid[posx][i] != -1) {
                blocked = true;
                break;
              }
            }
          }
        } else if (posy == this.posy) {
          if (posx> this.posx) {
            for (int i = this.posx+1; i<posx; i++) {
              if (grid[i][posy] != -1) {
                blocked = true;
                break;
              }
            }
          } else if (posx < this.posx) {
            for (int i = posx+1; i<this.posx; i++) {
              if (grid[i][posy] != -1) {
                blocked = true;
                break;
              }
            }
          }
        }
      }
    }
    return !blocked;
  }
  public void show() {
    if (isO) {
      image(wqueen, posy*100, posx*100, 100, 100);
    } else
      image(bqueen, posy*100, posx*100, 100, 100);
  }
}
