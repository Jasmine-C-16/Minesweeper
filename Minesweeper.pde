import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
public static int NUM_ROWS = 5;
public static int NUM_COLS = 5;
public static int mineprobablility = 10; // 1/mineprobablility chance of button being a mine

void setup ()
{
    size(400, 400);
    background(0);
    textAlign(CENTER,CENTER);
    
    Interactive.make( this );

    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for (int r=0;r<buttons.length;r++)
        for (int c=0;c<buttons[r].length;c++)
            buttons[r][c]=new MSButton(r,c);

    mines = new ArrayList <MSButton>();
    setMines();
}

public void setMines(){
    int rand=0;
    for (int r=0;r<NUM_ROWS;r++)
        for (int c=0;c<NUM_COLS;c++){
            rand=(int)(Math.random()*mineprobablility);
            if (rand==1){
                mines.add(buttons[r][c]);
                //System.out.println(r + ", " + c);
            }
        }
}

public void draw (){

}
public boolean isWon(){
    for (int r=0;r<buttons.length;r++)   //reveals bombs
        for (int c=0;c<buttons[r].length;c++)
            if (mines.contains(this)==false && buttons[r][c].isClicked()==false)
                return false;
    return true;
    
}
public void displayLosingMessage(){
        fill(210,160,43);
        rect(400,400,200,200);
        text("You Lose!", 200,200);

        for (int r=0;r<buttons.length;r++){     //reveals bombs
            for (int c=0;c<buttons[r].length;c++){
                if(buttons[r][c].isFlagged()==true)
                    buttons[r][c].flagged=false;
                buttons[r][c].clicked=true;
            }
        }
        //System.out.println("lose");
}

public void displayWinningMessage(){
    fill(2,200,43);
    text("You win!", 200,200);
    //System.out.println("win");
}
public boolean isValid(int r, int c){
    if (r<NUM_ROWS && c<NUM_COLS && r>=0 && c>=0)
        return true;
    return false;
}
public int countMines(int row, int col){
    int numMines = 0;
    if (isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
        numMines++;
    if (isValid(row-1,col) && mines.contains(buttons[row-1][col]))
        numMines++;
    if (isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
        numMines++;
    if (isValid(row,col-1) && mines.contains(buttons[row][col-1]))
        numMines++;
    if (isValid(row,col+1) && mines.contains(buttons[row][col+1]))
        numMines++;
    if (isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
        numMines++;
    if (isValid(row+1,col) && mines.contains(buttons[row+1][col]))
        numMines++;
    if (isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
        numMines++;
    return numMines;
}

public class MSButton{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col ){
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); 
    }

    // called by manager
    public void mousePressed() {
        if (mouseButton==LEFT && flagged==false){
            clicked = true;
            if (mines.contains(this)==true)
                displayLosingMessage();
        }
        else if (this.isWon()==true)
            displayWinningMessage();
        else if (clicked==false && mouseButton==RIGHT)
            flagged = !flagged;

        if (clicked==true && countMines(myRow,myCol)==0){ //this only calls one function, does not call the whole block???
            if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].clicked == false)
                buttons[myRow-1][myCol-1].mousePressed();
            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked == false)
                buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked == false)
                buttons[myRow-1][myCol+1].mousePressed();
            if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false)
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked == false)
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked == false)
                buttons[myRow+1][myCol-1].mousePressed();
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked == false )
                buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].clicked == false)
                buttons[myRow+1][myCol+1].mousePressed();
        }
    }
    public void draw () {    
        if (flagged)
            fill(100,50,230);
        else if(clicked && mines.contains(this))
            fill(255,0,15);
        else if(clicked){
            fill( 220,150,100);
            setLabel(countMines(myRow,myCol));
            
           
        }
        else 
            fill( 120,190,40 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel){
        myLabel = newLabel;
    }
    public void setLabel(int newLabel){
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged(){
        return flagged;
    }
    public boolean isClicked(){
        return clicked;
    }
}
