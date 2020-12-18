import processing.net.*; 

color lightbrown = #FFFFC3;
color darkbrown  = #D8864E;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick, isTurn;
int row1, col1, row2, col2;
int piecetaken = -1; 
Server server; 
boolean pawnpromotion = false; 

//Grid showing where all the pieces are. Numbers correspond to index of pieces + opieces. -1 indicates that there is no piece there. 
int grid[][] = {
  {24, 25, 26, 27, 28, 29, 30, 31}, 
  {16, 17, 18, 19, 20, 21, 22, 23}, 
  {-1, -1, -1, -1, -1, -1, -1, -1}, 
  {-1, -1, -1, -1, -1, -1, -1, -1}, 
  {-1, -1, -1, -1, -1, -1, -1, -1}, 
  {-1, -1, -1, -1, -1, -1, -1, -1}, 
  {0, 1, 2, 3, 4, 5, 6, 7}, 
  {8, 9, 10, 11, 12, 13, 14, 15}, 
};

//Array of your pieces
Chesspiece pieces[] = {new Pawn(6, 0), new Pawn(6, 1), new Pawn(6, 2), new Pawn(6, 3), new Pawn(6, 4), new Pawn(6, 5), new Pawn(6, 6), new Pawn(6, 7), 
  new Rook(7, 0), new Knight(7, 1), new Bishop(7, 2), new Queen(7, 3), new King(7, 4), new Bishop(7, 5), new Knight(7, 6), new Rook(7, 7)}; 

//Array of opponent's pieces
Chesspiece opieces[] = {new Pawn(1, 0), new Pawn(1, 1), new Pawn(1, 2), new Pawn(1, 3), new Pawn(1, 4), new Pawn(1, 5), new Pawn(1, 6), new Pawn(1, 7), 
  new Rook(0, 0), new Knight(0, 1), new Bishop(0, 2), new Queen(0, 3), new King(0, 4), new Bishop(0, 5), new Knight(0, 6), new Rook(0, 7)}; 

void setup() {
  size(800, 800);
  surface.setTitle("White - Your Turn"); 
  firstClick = true;
  isTurn = true;
  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");

  server = new Server(this, 1234);

  for (int i = 0; i<opieces.length; i++) {
    opieces[i].isO = true;
  }
}

void draw() {
  Client c = server.available(); 
  if (c != null) {
    String[] temp = c.readString().split(" "); 

    //An opponent pawn has moved to the other side. Pawn promotion
    if (temp.length == 5 && temp[4].equals("p")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      System.out.println(r1+" "+c1+" "+r2+" "+c2);
      piecetaken = grid[r2][c2]; 
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = -1; 
      opieces[grid[r2][c2]-16] = new Queen(r2, c2); 
      opieces[grid[r2][c2]-16].isO = true; 
      isTurn = true;
      surface.setTitle("White - Your Turn");
    } 

    //The opponent has pressed the undo key. No pawn promotion to undo
    else if (temp.length == 5 && temp[4].equals("z")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      System.out.println(r1+" "+c1+" "+r2+" "+c2);
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = piecetaken; 
      opieces[grid[r2][c2]-16].posx = r2;
      opieces[grid[r2][c2]-16].posy = c2; 
      isTurn = false;
      firstClick = true;
      surface.setTitle("White - Opponent's Turn");
    } 

    //The opponent has pressed the undo key. Need to undo the pawn promotion too. 
    else if (temp.length == 5 && temp[4].equals("Z")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      System.out.println(r1+" "+c1+" "+r2+" "+c2);
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = piecetaken; 
      opieces[grid[r2][c2]-16] = new Pawn(r2, c2);     
      opieces[grid[r2][c2]-16].isO = true; 
      isTurn = false;
      firstClick = true;
      surface.setTitle("White - Opponent's Turn");
    }

    //A regular move by the opponent
    else {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      System.out.println(r1+" "+c1+" "+r2+" "+c2);
      piecetaken = grid[r2][c2]; 
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = -1; 
      opieces[grid[r2][c2]-16].posx = r2;
      opieces[grid[r2][c2]-16].posy = c2; 
      isTurn = true;
      surface.setTitle("White - Your Turn");
    }
  }

  drawBoard();
  drawPieces();
}

void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) { 
      if ( (r%2) == (c%2) ) { 
        fill(lightbrown);
      } else { 
        fill(darkbrown);
      }
      rect(c*100, r*100, 100, 100);
    }
  }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[r][c] != -1 && grid[r][c]<16) {
        pieces[grid[r][c]].show();
      } else if (grid[r][c] >=16) {
        opieces[grid[r][c]-16].show();
      }
    }
  }
}

void mouseReleased() {
  if (isTurn) {
    if (firstClick) {
      row1 = mouseY/100;
      col1 = mouseX/100;
      if (grid[row1][col1]!=-1 && grid[row1][col1]<16) {
        firstClick = false;
        System.out.println("select");
      }
    } else {
      row2 = mouseY/100;
      col2 = mouseX/100;
      //checking if it is a valid move (not on itself/one of your pieces)
      if (!(row2 == row1 && col2 == col1) && (grid[row2][col2] == -1 || grid[row2][col2]>15) && pieces[grid[row1][col1]].act(row2, col2)) {
        System.out.println("move"); 

        piecetaken = grid[row2][col2]; 

        grid[row2][col2] = grid[row1][col1];
        grid[row1][col1] = -1;

        //Move causes a pawn promotion
        if (row2 == 0 && pieces[grid[row2][col2]] instanceof Pawn) {
          pawnpromotion = true;
          pieces[grid[row2][col2]] = new Queen(row2, col2);
          firstClick = true;
          isTurn = false; 
          surface.setTitle("White - Opponent's Turn"); 
          System.out.println(row1+" "+col1+" "+row2+" "+col2);
          server.write(row1+" "+col1+" "+row2+" "+col2+" p");
        } 
        //Move does not cause a pawn promotion
        else {
          pawnpromotion = false; 
          pieces[grid[row2][col2]].posx = row2; 
          pieces[grid[row2][col2]].posy = col2; 

          firstClick = true;
          isTurn = false; 
          surface.setTitle("White - Opponent's Turn");
          System.out.println(row1+" "+col1+" "+row2+" "+col2);
          server.write(row1+" "+col1+" "+row2+" "+col2);
        }
      }
    }
  }
}
void keyReleased() {
  if (key == 'Z' || key == 'z') {
    if (!isTurn) {
      if (pawnpromotion) {
        grid[row1][col1]  = grid[row2][col2];
        grid[row2][col2] = piecetaken;
        isTurn = true;
        surface.setTitle("White - Your Turn"); 
        pieces[grid[row1][col1]] = new Pawn(row1, col1);      
        server.write(row2+" "+col2+" "+row1+" "+col1+" Z");
      } else {
        grid[row1][col1]  = grid[row2][col2];
        grid[row2][col2] = piecetaken;
        isTurn = true;
        surface.setTitle("White - Your Turn"); 
        pieces[grid[row1][col1]].posx = row1;
        pieces[grid[row1][col1]].posy = col1;
        server.write(row2+" "+col2+" "+row1+" "+col1+" "+"z");
      }
    }
  }
}