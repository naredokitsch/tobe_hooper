#include <stdio.h>
#include <stdlib.h>

int indx = 0,i;

char *atoms;

void getAtoms(){
	char tmp;
	printf("INTRODUCIR UNA EXPRESION ARITMETICA\n"); 
	do{
    		if (indx == 0){
       			atoms = (char*) calloc(1, sizeof(*atoms));
          		if (!atoms)
              			printf("Problems(calloc)\n");
			indx++;
       			scanf("%c",&tmp);
			*(atoms + indx -1) = tmp;
			
    		}else{ 
       			indx++;
       			char *chk = (char*) realloc(atoms,indx * sizeof(*atoms));
       			if (!chk)
          			printf("Problems(realloc)\n");
       			atoms = chk;
			scanf("%c",&tmp);
			*(atoms + indx -1) = tmp;
		}		
	}while(atoms[indx - 1] != '\n');
	atoms[indx - 1] = '\0';
}

void impr(){
	int i = 1;

	do{
		printf("%c",atoms[i - 1]);
	}while(atoms[(i++) - 1] != '\0');

	printf("\n");
}


int main(){

	getAtoms();
	impr();

	return 0;

}