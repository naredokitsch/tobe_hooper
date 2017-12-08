/*
==PROGRAMA QUE TRADUCE UNA EXPRESION ARITMETICA
==A SU FORMA POLACA POSFIJA. ESTE PROGRAMA SOLO 
==ACEPTA LOS ATOMOS a,c,n,+,-,/,*,(,).
==SE TIENEN ALGUNOS INCONVENIENTES 
==CON APERTUTURAS CONSECUTIVAS DE PARENTESIS.
==AUTOR: NOE MARTINEZ NAREDO
*/


#include <stdio.h>
#include <stdlib.h>

char *atoms;//[] = {'a','(','n','+','n',')','*','c','-','a','\0'};//,'>','a',')','[','a','=','n',';',']','e','[','a','=','n',';',']','\0'};
int indx = 0, correct = 1;

void F();
void E();
void E_();
void T();
void T_();
void getAtoms();

////////////////////////////////////////////////////////////////////////////////////////
void E(){/*
	if (*(atoms + indx) == '\0')
		printf("\$  ->  E\n");
	else
		printf("%c  ->  E\n",*(atoms + indx));
	*/
	T();
	E_();
}
////////////////////////////////////////////////////////////////////////////////////////
void E_(){

	char actChar = *(atoms + indx);

	/*
	if (actChar == '\0')
		printf("\$  ->  E'\n");
	else
		printf("%c  ->  E'\n",actChar);
	*/
	
	if ((actChar == '+') || (actChar == '-')){

		indx++;

		T();
		E_();
		
		if (actChar == '+')
			printf("+");
		else
			printf("-");
		
		return;
	}else{
		if (*(atoms + indx) == '('){
			printf("\nERROR: SE ESPERA UN OPERADOR ARITMETICO PARA LA PRODUCCION E'\n");
			correct = 0;
		}	
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void T(){/*
	if (*(atoms + indx) == '\0')
		printf("\$  ->  T\n");
	else
		printf("%c  ->  T\n",*(atoms + indx));
	*/
	F();
	T_();
}
////////////////////////////////////////////////////////////////////////////////////////
void T_(){

	char actChar = *(atoms + indx);
	/*
	
	if (actChar == '\0')
		printf("\$  ->  T'\n");
	else
		printf("%c  ->  T'\n",actChar);
	*/
	if ((actChar == '*') || (actChar == '/')){
		indx++;
		//printf("dsfa");
		F();
		T_();
		
		if (actChar == '*')
			printf("*");
		else
			printf("/");
		
		return;
	}else{
		if (*(atoms + indx) == '('){
			printf("\nERROR: SE ESPERA UN OPERADOR ARITMETICO PARA LA PRODUCCION T'\n");
			correct = 0;
		}	
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void F(){///*
	//if (*(atoms + indx) == '\0')
//		printf("\$  ->  F\n");
//	else
		printf("%c  ->  F\n",*(atoms + indx));
	//	*/
	if ((*(atoms + indx) == 'a') || (*(atoms + indx) == 'n') || (*(atoms + indx) == 'c')){
		
		if (*(atoms + indx) == 'a')
			printf("a");
		else {
			if (*(atoms + indx) == 'n')
				printf("n");
			else
				printf("c");
		}

		indx++;

		return;
	}

	if (*(atoms + indx) == '('){
		indx++;
		E();
		if (*(atoms + indx) == ')'){
			indx++;
			return;
		}
	}
	printf("ERROR EN LA PRODUCCION F : SIMBOLO DE ENTRADA = %c\n",*(atoms + indx));
	correct = 0;
}
///////////////////////////////////////////////////////////////////////////////////////

void getAtoms(){
	char tmp;
	printf("INTRODUCIR UNA EXPRESION ARITMETICA\nusar\ta:IDENTIFICADORES\n\tc:ENTEROS\n\tn:REALES\n\n"); 
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

	indx = 0;
}

int main(){
	system("clear");
	getAtoms();
	E();

	if (correct == 1)
		printf("\n\nGRAMATICA CORRECTA\n\n");
	else
		printf("\n\nGRAMATICA INCORRECTA\n\n");

	return 1;
}
