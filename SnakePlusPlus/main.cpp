#include <iostream>
#include<time.h>
#include <conio.h>

#include <vector>
using std::vector;

//Game Properties
bool isRunning;
const int screen_width = 30;
const int  screen_height = 20;
//Snake Properties
int snake_x, snake_y;
int snakeXPrev;
int snakeYPrev; 
int snake_tail_y[100];
int snake_tail_x[100];
int snake_segment;

char snake_dir;
//Fruit Properties;
int food_x, food_y;

void ResetFood(){
     food_x = rand() % screen_width -1;
    food_y = rand() % screen_height - 1;
}
void CommitGameReset(){
    system("cls");
    std::cout << "You Lost!";
    system("pause");
}

//Based on what i learned in love2d
void Game_Load(){
    srand(time(0));  
    snake_x = screen_width /2;
    snake_y = screen_height/2;
    snake_dir = 'u';
    isRunning = true;
   
   
    //waht rand() % x does is find the random range between 0-x
    food_x = rand() % screen_width -1;
    food_y = rand() % screen_height - 1;

}

void Game_Update(){
   
    //captures previous movements of snake before it moves
    //Rule is simple, make sure to remove from the back and add back to the front so that it only ofllows one
    snake_tail_x[0] = snake_x;
    snake_tail_y[0] = snake_y;
    snakeXPrev = snake_tail_x[0];
    snakeYPrev = snake_tail_y[0];
    int newSegmentX, newSegmentY;
    for (int i=1;i<snake_segment;i++){
        //To create new segment of new segment lah
        newSegmentX = snake_tail_x[i];
        newSegmentY = snake_tail_y[i];
        //it takes previously value of newsegment and places snakeXPrevious value
        snake_tail_x[i] = snakeXPrev;
        snake_tail_y[i] = snakeYPrev;
        //now it takes on new value to keep it going
        snakeXPrev = newSegmentX;
        snakeYPrev = newSegmentY;

    }


  





    //Food Collide
    if (snake_x == food_x && snake_y == food_y){
        snake_segment++;
        ResetFood();
    }
    //Wall Collide
    if (snake_x > screen_width - 1 || snake_x < 0){
            CommitGameReset();
    }else if(snake_y > screen_height || snake_y < 0){
            CommitGameReset();
    }
    //Snake Movements
    if (snake_dir == 'u' && snake_dir != 'd'){
        snake_y--;
    }else if(snake_dir == 'd' && snake_dir != 'u'){
        snake_y++;
    }else if(snake_dir == 'l'  && snake_dir != 'r'){
        snake_x--;
    }else if(snake_dir == 'r'  && snake_dir != 'l'){
        snake_x++;
    }
}
void Game_Draw(){

    system("cls");
    
    std::cout << "Welcome To Snake" << std::endl;
    //Draw the game
    for (int r=0;r<screen_width;r++){
        std::cout << "="; 
    }   
    std::cout << std::endl;
    //Draw the Middle Canvas
    for (int c=0;c<screen_height;c++)
    {
      for (int r=0;r<screen_width;r++)
      {
        //Draw the snake
        if (c==snake_y && r==snake_x){
          std::cout << "0";
        }
        //Draw the tail 
        for (int i=0;i<snake_segment;i++){
            if(r == snake_tail_x[i] && c == snake_tail_y[i]){
               std:: cout << "Z";
            }

        }
         
        //Draw the food
        if (c==food_y && r==food_x){
          std::cout <<"@";
        }

        //Draw the holes and left and right walls
        if (r==0 || r==screen_width -1)
        {
          std::cout << "=";
        }else{
          std::cout << " ";
        }


      }
      std::cout << std::endl;
    }
     for (int r=0;r<screen_width;r++){
        std::cout << "="; 
    }   
    std::cout << std::endl;
    

}



void Keyboard_Input(){
    if (_kbhit()){
        switch (_getch()){
            case 'w':
                snake_dir = 'u';
                break;
            case 'a':
                snake_dir = 'l';
                break;
            case 's':
                snake_dir = 'd';
                break;
            case 'd':
                snake_dir = 'r';
                break;
            
        }
    }
}



int main(){
    Game_Load();

    while(isRunning){
      
        Game_Draw();
        Keyboard_Input();
        Game_Update();
       
    }
   
  
    return 0;
}

