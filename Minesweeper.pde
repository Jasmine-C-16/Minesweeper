import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
public static int NUM_ROWS = 5;
public static int NUM_COLS = 5;

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
            rand=(int)(Math.random()*10);
            //System.out.println(rand);
            if (rand==1){
                mines.add(buttons[r][c]);
                System.out.println(r + ", " + c);
            }
        }
}

public void draw (){
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();

}
public boolean isWon(){
 //  if ()
    return false;
}
public void displayLosingMessage(){
    fill(210,160,43);
    text("You Lose!", 200,200);
}
public void displayWinningMessage(){
    fill(2,200,43);
    text("You win!", 200,200);
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
    public void mousePressed () {
        if (mouseButton==LEFT)
            clicked = true;
        if (mouseButton==RIGHT)
            flagged = !flagged;
    }
    public void draw () {    
        if (flagged)
            fill(100,50,230);
        else if( clicked && mines.contains(this) ) {
            fill(255,0,15);
           // isWon=false;
        }
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
}


 // fill(0);
 //    rect(0,0,400,400);
 //    displayLosingMessage();