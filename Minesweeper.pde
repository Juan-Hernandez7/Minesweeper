

import de.bezier.guido.*;
private int NUM_ROWS =20;
private int NUM_COLS=20;//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
 buttons = new MSButton[NUM_ROWS][NUM_COLS];

 for(int i=0; i<buttons.length; i++)
 {
 for(int iJ=0; iJ<buttons[i].length; iJ++)
 { 
    
    buttons[i][iJ]= new MSButton(i,iJ);               
 }   //your code to declare and initialize buttons goes here
 }  
    
    
    setBombs();
}
 
public void setBombs()
{  
   
    for(int nI=0; nI<=70;nI++)
    { 
        int pop=(int)(Math.random()*20);
    int boom=(int)(Math.random()*20);
    if(!bombs.contains(buttons[pop][boom]))
   {
    bombs.add(buttons[pop][boom]);

   }   
    }
}
 public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
      for(int n=0; n < bombs.size();n++)
      {
        if(bombs.get(n).isMarked() == false)
        {
            return false;
        }
      }
    
    return true;
}
public void displayLosingMessage()
{   
    for(int x=0; x<NUM_ROWS; x++)
    {
        for(int y=0; y<NUM_COLS; y++)
        {
              if(buttons[x][y].isClicked()==true && bombs.contains(buttons[x][y]))
    {
            for (int i=0; i<NUM_ROWS; i++)
    {
      for(int n=0; n<NUM_COLS;n++)
    {       
        
           buttons[i][n].setLabel("x");
    }
    } 
         
    }    //your c
        }
    }

    buttons[10][5].setLabel("G");
    buttons[10][6].setLabel("E");
    buttons[10][7].setLabel("T");
    buttons[10][8].setLabel(" ");
    buttons[10][9].setLabel("R");
    buttons[10][10].setLabel("E");
    buttons[10][11].setLabel("K");
    buttons[10][12].setLabel("T");

    buttons[11][5].setLabel("T");
    buttons[11][6].setLabel("R");
    buttons[11][7].setLabel("Y");
    buttons[11][8].setLabel(" ");
    buttons[11][9].setLabel("A");
    buttons[11][10].setLabel("G");
    buttons[11][11].setLabel("A");
    buttons[11][12].setLabel("I");
    buttons[11][13].setLabel("N");
   
   
    }
public void displayWinningMessage()
{   

     buttons[10][5].setLabel("U");
    buttons[10][6].setLabel("M");
    buttons[10][7].setLabel(".");
    buttons[10][8].setLabel(".");
    buttons[10][9].setLabel(".");
    buttons[10][10].setLabel("W");
    buttons[10][11].setLabel("E");
    buttons[10][12].setLabel("L");
    buttons[10][13].setLabel("L");
    buttons[11][5].setLabel("Y");
    buttons[11][6].setLabel("O");
    buttons[11][7].setLabel("U");
    buttons[11][8].setLabel(" ");
    buttons[11][9].setLabel("W");
    buttons[11][10].setLabel("I");
    buttons[11][11].setLabel("N");
   
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed==true)
        {
           marked=!marked;
        }
            
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if( countBombs(r,c)>0)
        {
            setLabel(new String() + (countBombs(r,c)));
        }
        else
        { 
               if(isValid(r,c-1)  == true   &&  buttons[r][c-1].isClicked() == false)  {buttons[r][c-1].mousePressed();}
               if(isValid(r+1,c-1)== true   &&  buttons[r+1][c-1].isClicked() == false)  {buttons[r+1][c-1].mousePressed();}
               if(isValid(r+1,c)  == true   &&  buttons[r+1][c].isClicked() == false)  {buttons[r+1][c].mousePressed();} 
               if(isValid(r+1,c+1)== true   &&  buttons[r+1][c+1].isClicked()==false)  {buttons[r+1][c+1].mousePressed();}  
               if(isValid(r,c+1)  == true   &&  buttons[r][c+1].isClicked() == false)  {buttons[r][c+1].mousePressed();}
               if(isValid(r-1,c+1)== true   &&  buttons[r-1][c+1].isClicked() == false)  {buttons[r-1][c+1].mousePressed();}  
               if(isValid(r-1,c)  == true   &&  buttons[r-1][c].isClicked() == false)  {buttons[r-1][c].mousePressed();}          
               if(isValid(r-1,c-1)== true   && buttons[r-1][c-1].isClicked() == false)  {buttons[r-1][c-1].mousePressed();}
    }
     }


    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>=0 &&r<NUM_ROWS && c<NUM_COLS && c>=0 ) 
        {
           return true;  
        } //your code here
        return false;

    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        
         if (isValid(r,c-1)==true && bombs.contains(buttons[row][col-1]))    {numBombs++;} //left
        if(isValid(r,c+1)==true && bombs.contains(buttons[row][col+1]))     {numBombs++;} //right
        if(isValid(r-1,c)==true && bombs.contains(buttons[row-1][col]))     {numBombs++;} //up
        if(isValid(r+1,c)==true && bombs.contains(buttons[row+1][col]))     {numBombs++;} //down
        if(isValid(r-1,c-1)==true && bombs.contains(buttons[row-1][col-1])) {numBombs++;} //upper left
        if(isValid(r-1,c+1)==true && bombs.contains(buttons[row-1][col+1])) {numBombs++;} //upper right
        if(isValid(r+1,c-1)==true && bombs.contains(buttons[row+1][col-1])) {numBombs++;}//lower left
        if(isValid(r+1,c+1)==true && bombs.contains(buttons[row+1][col+1])) {numBombs++;}//lower right
        return numBombs;      
    
    }
    }
