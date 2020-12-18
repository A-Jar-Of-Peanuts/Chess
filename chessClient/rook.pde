class Rook extends Chesspiece {
  public Rook(int posx, int posy) {
    super(posx, posy);
    piece = wrook;
  }

  public void act(int posx, int posy) {
    if (posx == this.posx) {
      if (posx>this.posx) {
        boolean blocked = false;
        for (int i = this.posx+1; i<posx-1; i++) {
          if (grid[i][posy] != -1) {
            blocked = true;
            break;
          }
          if (!blocked) {
            this.posx = posx; 
            this.posy = posy;
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
          this.posx = posx; 
          this.posy = posy; 
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
            this.posx = posx; 
            this.posy = posy; 
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
          this.posx = posx; 
          this.posy = posy; 
        }
      }
    }
  }
  public void show() {
    if(isO) {
      image(wrook, posy*100, posx*100, 100, 100);
    } else
    image(brook, posy*100, posx*100, 100, 100);
  }
}
