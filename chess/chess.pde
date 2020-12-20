import processing.net.*; 
import java.util.*;
import javax.swing.*;
import java.awt.Image;

color lightbrown = #FFFFC3;
color darkbrown  = #D8864E;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick, isTurn;
int row1, col1, row2, col2;

//what the last piece taken was
int piecetaken = -1; 
Server server; 

//whether the last turn included a pawn promotion
boolean pawnpromotion = false; 
boolean incheck = false;

//coordinates of currently selected piece
int rselected = -1;
int cselected = -1;

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

    //An opponent pawn has moved to the other side. Pawn promotion to queen
    if (temp.length == 5 && temp[4].equals("q")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      piecetaken = grid[r2][c2]; 
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = -1; 
      opieces[grid[r2][c2]-16] = new Queen(r2, c2); 
      opieces[grid[r2][c2]-16].isO = true; 
      isTurn = true;
      surface.setTitle("White - Your Turn");
      if (((King)pieces[12]).inCheck()) {
        incheck = true;
      } else {
        incheck = false;
      }
    } 

    //An opponent pawn has moved to the other side. Pawn promotion to knight
    else if (temp.length == 5 && temp[4].equals("k")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      piecetaken = grid[r2][c2]; 
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = -1; 
      opieces[grid[r2][c2]-16] = new Knight(r2, c2); 
      opieces[grid[r2][c2]-16].isO = true; 
      isTurn = true;
      surface.setTitle("White - Your Turn");
      if (((King)pieces[12]).inCheck()) {
        incheck = true;
      } else {
        incheck = false;
      }
    } 

    //An opponent pawn has moved to the other side. Pawn promotion to rook
    else if (temp.length == 5 && temp[4].equals("r")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      piecetaken = grid[r2][c2]; 
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = -1; 
      opieces[grid[r2][c2]-16] = new Rook(r2, c2); 
      opieces[grid[r2][c2]-16].isO = true; 
      isTurn = true;
      surface.setTitle("White - Your Turn");
      if (((King)pieces[12]).inCheck()) {
        incheck = true;
      } else {
        incheck = false;
      }
    } 

    //An opponent pawn has moved to the other side. Pawn promotion to bishop
    else if (temp.length == 5 && temp[4].equals("b")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      piecetaken = grid[r2][c2]; 
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = -1; 
      opieces[grid[r2][c2]-16] = new Bishop(r2, c2); 
      opieces[grid[r2][c2]-16].isO = true; 
      isTurn = true;
      surface.setTitle("White - Your Turn");
      if (((King)pieces[12]).inCheck()) {
        incheck = true;
      } else {
        incheck = false;
      }
    } 

    //The opponent has pressed the undo key. No pawn promotion to undo
    else if (temp.length == 5 && temp[4].equals("z")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = piecetaken; 
      opieces[grid[r2][c2]-16].posx = r2;
      opieces[grid[r2][c2]-16].posy = c2; 
      isTurn = false;
      firstClick = true;
      surface.setTitle("White - Opponent's Turn");
      if (((King)pieces[12]).inCheck()) {
        incheck = true;
      } else {
        incheck = false;
      }
    } 

    //The opponent has pressed the undo key. Need to undo the pawn promotion too. 
    else if (temp.length == 5 && temp[4].equals("Z")) {
      int r1 = Integer.parseInt(temp[0]); 
      int c1 = Integer.parseInt(temp[1]); 
      int r2 = Integer.parseInt(temp[2]); 
      int c2 = Integer.parseInt(temp[3]);
      grid[r2][c2] = grid[r1][c1]; 
      grid[r1][c1] = piecetaken; 
      opieces[grid[r2][c2]-16] = new Pawn(r2, c2);     
      opieces[grid[r2][c2]-16].isO = true; 
      isTurn = false;
      firstClick = true;
      surface.setTitle("White - Opponent's Turn");
      if (((King)pieces[12]).inCheck()) {
        incheck = true;
      } else {
        incheck = false;
      }
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
      if (((King)pieces[12]).inCheck()) {
        incheck = true;
      } else {
        incheck = false;
      }
    }
  }

  drawBoard();
  drawPieces();
}

void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) { 
      //highlights selected piece in green
      if (r == rselected && c == cselected) {
        fill(0, 255, 0);
      } 
      //highlights possible moves in blue
      else if (rselected != -1 && cselected != -1 && pieces[grid[rselected][cselected]].act(r, c)&& (grid[r][c]== -1 || grid[r][c]>15)) {
        fill(0, 0, 255);
      } 
      //highlights king in red if in check
      else if (incheck && grid[r][c] == 12) {
        fill(255, 0, 0);
      } else if ( (r%2) == (c%2) ) { 
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
        rselected = row1;
        cselected = col1;
        firstClick = false;
      }
    } else {
      row2 = mouseY/100;
      col2 = mouseX/100;

      if (row2 == row1 && col2 == col1) {
        rselected = -1;
        cselected = -1;
        firstClick = true;
      } else if (grid[row2][col2]<=15 && grid[row2][col2] != -1) {
        row1 = row2;
        col1 = col2;
        rselected = row1;
        cselected = col1;
      }     
      //checking if it is a valid move (not on itself/one of your pieces)
      else if (pieces[grid[row1][col1]].act(row2, col2)) {
        rselected = -1;
        cselected = -1;
        piecetaken = grid[row2][col2]; 

        grid[row2][col2] = grid[row1][col1];
        grid[row1][col1] = -1;

        //Move causes a pawn promotion
        if (row2 == 0 && pieces[grid[row2][col2]] instanceof Pawn) {
          pawnpromotion = true;
          ImageIcon img = new ImageIcon("whitePawn.png");
          String[] choose = {"queen", "rook", "bishop", "knight"};
          String s = (String) JOptionPane.showInputDialog(frame, "Choose your piece", "Pawn Promotion", JOptionPane.PLAIN_MESSAGE, img, choose, "queen");
          switch(s) {
          case "queen":
            pieces[grid[row2][col2]] = new Queen(row2, col2);
            firstClick = true;
            isTurn = false; 
            surface.setTitle("White - Opponent's Turn"); 
            server.write(row1+" "+col1+" "+row2+" "+col2+" q");
            break;
          case "rook":
            pieces[grid[row2][col2]] = new Rook(row2, col2);
            firstClick = true;
            isTurn = false; 
            surface.setTitle("White - Opponent's Turn"); 
            server.write(row1+" "+col1+" "+row2+" "+col2+" r");
            break;
          case "bishop":
            pieces[grid[row2][col2]] = new Bishop(row2, col2);
            firstClick = true;
            isTurn = false; 
            surface.setTitle("White - Opponent's Turn"); 
            server.write(row1+" "+col1+" "+row2+" "+col2+" b");
            break;
          case "knight":
            pieces[grid[row2][col2]] = new Knight(row2, col2);
            firstClick = true;
            isTurn = false; 
            surface.setTitle("White - Opponent's Turn"); 
            server.write(row1+" "+col1+" "+row2+" "+col2+" k");
            break;
          }
        } 
        //Move does not cause a pawn promotion
        else {
          pawnpromotion = false; 
          pieces[grid[row2][col2]].posx = row2; 
          pieces[grid[row2][col2]].posy = col2; 

          firstClick = true;
          isTurn = false; 
          surface.setTitle("White - Opponent's Turn");
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
