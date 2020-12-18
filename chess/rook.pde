class Rook extends Chesspiece {
  public Rook(int posx, int posy) {
    super(posx, posy);
    piece = wrook;
  }

  public boolean act(int posx, int posy) {
    if (posx == this.posx) {
      if (posx>this.posx) {
        boolean blocked = false;
        for (int i = this.posx+1; i<posx-1; i++) {
          if (grid[i][posy] != -1) {
            blocked = true;
            break;
          }
          if (!blocked) {
            return true;
          }
        }
      } else if (posx<this.posx) {
        boolean blocked = false; 
        for (int i = posx+1; i<this.posx-1; i++) {
          if (grid[i][posy] != -1) {
            blocked = true;
            break;
          }
        }
        if(!blocked) {
          return true;
        }
      }
      
    } else if (posy == this.posy) {
      if(posy>this.posy) {
        boolean blocked = false; 
        for(int i = this.posy+1; i<posy-1; i++) {
          if(grid[posx][i] != -1) {
            blocked = true; 
            break; 
          }
          if(!blocked) {
            return true;
          }
        }
      }
      else if(posy<this.posy) {
        boolean blocked = false; 
        for(int i = posy+1; i<this.posy-1; i++) {
          if(grid[posx][i] != -1) {
            blocked = true; 
            break;
          }
        }
        if(!blocked) {
          return true;
        }
      }
    }
    return false;
  }
  public void show() {
    if (isO) {
      image(brook, posy*100, posx*100, 100, 100);
    } else
      image(wrook, posy*100, posx*100, 100, 100);
  }
}
