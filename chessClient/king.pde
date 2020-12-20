class King extends Chesspiece {
  public King(int posx, int posy) {
    super(posx, posy);
    piece = wking;
  }

  public boolean act(int posx, int posy) {
    if (!isO) {
      if (((King)pieces[12]).inCheck(this.posx, this.posy, posx, posy)) {
        return false;
      }
    }
    if (posx == this.posx) {
      if (posy == this.posy -1 || posy == this.posy +1) {
        return true;
      }
    }
    if (posy == this.posy) {
      if (posx == this.posx -1 || posx == this.posx +1) {
        return true;
      }
    }
    if (posy == this.posy+1 || posy == this.posy-1) {
      if (posx == this.posx-1 || posx == this.posx+1) {
        return true;
      }
    }
    if (posx == this.posx+1 || posx == this.posx-1) {
      if (posy == this.posy-1 || posy == this.posy+1) {
        return true;
      }
    }
    return false;
  }
  public void show() {
    if (isO) {
      image(wking, posy*100, posx*100, 100, 100);
    } else
      image(bking, posy*100, posx*100, 100, 100);
  }

  public boolean inCheck() {
    for (int i = 0; i<grid.length; i++) {
      for (int j = 0; j<grid[0].length; j++) {
        if (grid[i][j]>15) {
          if (opieces[grid[i][j]-16].act(this.posx, this.posy)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  public boolean inCheck(int cx, int cy, int fx, int fy) {
    int temp = grid[cx][cy];
    int temp2 = grid[fx][fy];
    grid[fx][fy] = temp;
    grid[cx][cy] = -1;
    for (int i = 0; i<grid.length; i++) {
      for (int j = 0; j<grid[0].length; j++) {
        if (grid[i][j]>15) {
          if (opieces[grid[i][j]-16].act(posx, posy)) {
            grid[fx][fy] = temp2;
            grid[cx][cy] = temp;
            return true;
          }
        }
      }
    }
    grid[fx][fy] = temp2;
    grid[cx][cy] = temp;
    return false;
  }
}
