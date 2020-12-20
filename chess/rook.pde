class Rook extends Chesspiece {
  public Rook(int posx, int posy) {
    super(posx, posy);
    piece = wrook;
  }

  public boolean act(int posx, int posy) {
    if(!isO) {
      if(((King)pieces[12]).inCheck(this.posx, this.posy, posx, posy)) {
        return false;
      }
    }
    boolean blocked = false;
    if (posx != this.posx && posy!= this.posy) {
      blocked = true;
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
    return !blocked;
  }
  public void show() {
    if (isO) {
      image(brook, posy*100, posx*100, 100, 100);
    } else
      image(wrook, posy*100, posx*100, 100, 100);
  }
}
