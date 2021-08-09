#include <iostream>
#include <conio.h>
#include <cmath>
#include <cstdlib>

bool gameRunning = true;
int game_width, game_height;
int wizard_x, wizard_y;
int currentFireballAmount;
//Rounds
int score;
int game_round = 1;
bool new_round = true;
int baseHealth = 3;
//fireball
int fireballxList[3];
int fireballyList[3];
bool fireballboolList[3];
//enemy
int enemyxList[10];
int enemyyList[10];

bool enemyStatus[10];
int enemyCount = 0;

class Bullet{
public:
	int _x,_y;
	bool isShoot=false;
	Bullet(){
		_x = wizard_x;
		_y = wizard_y;
	}
};
class Enemy{
public:
	int _x,_y;
	Enemy(){
		_x = game_width - 1;
		_y = rand() % game_height;
	}

};
void Game_Load(){
	currentFireballAmount = 3;
	game_width = 50;
	game_height = 10;
	wizard_x = 1;
	wizard_y = game_height/2;
}

void Game_Update(){
	//player wall collision
	if (wizard_y <0){
		wizard_y =0;
	}else if (wizard_y > game_height){
		wizard_y = game_height - 1;
	}
	//moves fireball logic
	for (int i=0;i<3;i++)
	{
		if (fireballboolList[i] == true){
			
				fireballxList[i]++;
		}
	}
	//Enemies Section
	//Spawn Enemies
	if (new_round)
	{
		for (int r=0;r<game_round;r++){
			Enemy newEnemy;
			enemyxList[r] = newEnemy._x;
			enemyyList[r] = newEnemy._y;
			enemyStatus[r] = true;
			enemyCount++;
		}
		new_round = false;
	}
	//Move Enemies + Logic
	for(int m=0;m<10;m++)
	{
		if (enemyStatus[m]==true)//if status is true, go left
		{
			enemyxList[m]--;
		}
		//When fireball hits the enemy
		for(int i=0;i<3;i++)
		{
			if (enemyxList[m] == fireballxList[i] && enemyyList[m] == fireballyList[i] && enemyStatus[m])
			{
				enemyxList[m] = 0;
				enemyyList[m] = 0;
				enemyStatus[m] = false;
				fireballboolList[i]= false;	
				enemyCount--;
				currentFireballAmount++;
			}
		}
		if (enemyxList[m] < 0)
		{
			enemyxList[m] = 0;
			enemyyList[m] = 0;
			enemyStatus[m] = false;
			enemyCount--;
			baseHealth--;
		}
	}
	//New Round
	if (enemyCount==0)
	{
		if (game_round < 6)
		{
			game_round++;
		}
		new_round = true;
	}
	if (baseHealth <=0)
	{
		exit(0);
	}


}

void Game_Draw(){

	for (int i=0;i<game_width;i++) {
		std::cout << "#";
	}
	for (int c=0;c<game_height;c++)
	{
		std::cout << std::endl; 
		for (int r=0;r<game_width;r++)
		{

			if (r==0 || r==game_width - 1){
				std::cout << "#";
			}else if (c==wizard_y && r==wizard_x){
				std::cout << "[";
			}
			else{
				std::cout << " ";
			}

			//Enemy
		
			for(int i=0;i<enemyCount;i++)
			{	
				if (c==enemyyList[i] && r==enemyxList[i] && enemyStatus[i])
				{
					std::cout << "Z";
				}
			}
			
			//Fireball
			for(int i=0;i<3;i++)
			{	
				if (c==fireballyList[i] && r==fireballxList[i] && fireballboolList[i])
				{
					std::cout << "0";
				}
			}
			
		}	
	}
	std::cout << std::endl;
	for (int i=0;i<game_width;i++) {
		std::cout << "#";
	}
	std::cout << std::endl;
	std::cout << "score:" << score;
	std::cout << "fireball_left:";
	for(int i=0;i<currentFireballAmount;i++){
		std::cout << "0";
	}
	std::cout << "round:" << game_round;
	std::cout << "enemy_count:" << enemyCount;
	std::cout << std::endl;
	std::cout << "Base_Health:" << baseHealth;
}

void Keyboard_Input()
{
	if (_kbhit()){
		switch(_getch()){
			case 'w':
			wizard_y--;
			break;
			case 's':
			wizard_y++;
			break;
			case ' ':		
			if (currentFireballAmount > 0)
			{
				currentFireballAmount--;
				Bullet newBullet;
				fireballxList[currentFireballAmount] = newBullet._x;
				fireballyList[currentFireballAmount] = newBullet._y;
				newBullet.isShoot = true;	
				fireballboolList[currentFireballAmount] = newBullet.isShoot;
			}
			break;
		}
	}
}
int main()
{

	Game_Load();
	while (gameRunning){
		system("cls");
		Game_Update();
		Keyboard_Input();
		Game_Draw();
	}
	return 0;
}
