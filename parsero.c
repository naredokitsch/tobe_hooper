#include <stdio.h>
#include <stdlib.h>

char atoms[] = {'i','(','a','>','a',')','[','a','=','n',';',']','e','[','a','=','n',';',']','\0'};
int indx = 0;

void F();
void E();
void E_();
void T();
void T_();
void REL();
void OR();
void LP();
void LPA();
void A();
void W();
void R();
void H();
void M();
void I();
void BP();
void PR();
void PC();
void S();


void BP(){
	printf("<BP>\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'a') || (*(atoms + indx) == 'w') || (*(atoms + indx) == 'r') || (*(atoms + indx) == 'h') || (*(atoms + indx) == 'm') || (*(atoms + indx) == 'i') || (*(atoms + indx) == '@') || (*(atoms + indx) == '[')){
		PR();
		return;
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void PR(){
	printf("<PR>\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'a') || (*(atoms + indx) == 'w') || (*(atoms + indx) == 'r') || (*(atoms + indx) == 'h') || (*(atoms + indx) == 'm') || (*(atoms + indx) == 'i') || (*(atoms + indx) == '@')){
		S();
		return;
	}
	if (*(atoms + indx) == '['){
		PC();
		return;
	}
	printf("ERROR EN LA PRODUCCION <PR> : SIMBOLO = %c\n",*(atoms + indx));
}
////////////////////////////////////////////////////////////////////////////////////////
void S(){
	printf("S\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'a') || (*(atoms + indx) == 'w') || (*(atoms + indx) == 'r') || (*(atoms + indx) == 'h') || (*(atoms + indx) == 'm') || (*(atoms + indx) == 'i') || (*(atoms + indx) == '@')){
		if (*(atoms + indx) == 'a'){
			A();
			return;
		}
		if (*(atoms + indx) == 'w'){
			W();
			return;
		}
		if (*(atoms + indx) == 'r'){
			R();
			return;
		}
		if (*(atoms + indx) == 'h'){
			H();
			return;
		}
		if (*(atoms + indx) == 'm'){
			M();
			return;
		}
		if (*(atoms + indx) == 'i'){
			I();
			return;
		}
		if ((*(atoms + indx) == '@') && (*(atoms + indx + 1) == 'a') && (*(atoms + indx + 2) == '(')){
			indx+=3;
			LP();
			if (*(atoms + indx) == ')'){
				indx++;
			}else{
				printf("ERROR EN LA PRODUCCION S : SIMBOLO = %c\n",*(atoms + indx));
			}
			return;
		}
	}else{
		printf("ERROR EN LA PRODUCCION S : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void PC(){
	printf("<PC>\tindx -> %c\n",*(atoms + indx));
	if (*(atoms + indx) == '['){
		indx+=1;
		BP();
		if (*(atoms + indx) == ']'){
			indx++;
			return;
		}else{
			printf("ERROR EN LA PRODUCCION <PC> : SIMBOLO = %c\n",*(atoms + indx));
		}
	}else{
		printf("ERROR EN LA PRODUCCION <PC> : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void A(){
	printf("A\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'a') && (*(atoms + indx + 1) == '=')){
		indx+=2;
		E();
		if (*(atoms + indx) == ';'){
			indx++;
			return;
		}else{
			printf("ERROR EN LA PRODUCCIdfsdON A : SIMBOLO = %c\n",*(atoms + indx));
		}
	}else{
		printf("ERROR EN LA PRODUCCION A : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void W(){
	printf("W\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'w') && (*(atoms + indx + 1) == 'a') && (*(atoms + indx + 2) == ';')){
		indx+=3;
	}else{
		printf("ERROR EN LA PRODUCCION W : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void R(){
	printf("R\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'r') && (*(atoms + indx + 1) == 'a') && (*(atoms + indx + 2) == ';')){
		indx+=3;
	}else{
		printf("ERROR EN LA PRODUCCION R : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void H(){
	printf("H\tindx -> %c\n",*(atoms + indx));
	if (*(atoms + indx) == 'h'){
		indx++;
		PC();
		if ((*(atoms + indx) == 'm') && (*(atoms + indx + 1) == '(')){
			indx+=2;
			REL();
			if ((*(atoms + indx) == ')') && (*(atoms + indx + 1) == ';')){
				indx+=2;
				return;
			}else{
				printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
			}
		}else{
			printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
		}
	}else{
		printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void M(){
	printf("M\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'm') && (*(atoms + indx + 1) == '(')){
		indx+=2;
		REL();
		if (*(atoms + indx) == ')'){
			indx++;
			PR();
		}else{
			printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
		}
	}else{
		printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void I(){
	printf("I\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'i') && (*(atoms + indx + 1) == '(')){
		indx+=2;
		REL();
		if (*(atoms + indx) == ')'){
			indx++;
			PC();
			if (*(atoms + indx) == 'e'){
				indx++;
				PC();
				return;
			}else{
				printf("ERROR EN LA PRODUCCION I : SIMBOLO = %c\n",*(atoms + indx));
			}
		}else{
			printf("ERROR EN LA PRODUCCION I : SIMBOLO = %c\n",*(atoms + indx));
		}
	}else{
		printf("ERROR EN LA PRODUCCION I : SIMBOLO DE ENTRADA = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void REL(){
	printf("<REL>\tindx -> %c\n",*(atoms + indx));
	E();
	OR();
	E();
}
////////////////////////////////////////////////////////////////////////////////////////
void OR(){
	printf("<OR>\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == '>') || (*(atoms + indx) == 'g') || (*(atoms + indx) == '<') || (*(atoms + indx) == 'p') || (*(atoms + indx) == 'q') || (*(atoms + indx) == '!')){
		indx++;
		return;
	}
	printf("ERROR EN LA PRODUCCION <OR> : SIMBOLO DE ENTRADA = %c\n",*(atoms + indx));
}
////////////////////////////////////////////////////////////////////////////////////////
void LP(){
	printf("<LP>\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == '@') || (*(atoms + indx) == '(') || (*(atoms + indx) == 'a') || (*(atoms + indx) == 'n') || (*(atoms + indx) == 'c')){
		E();
		LPA();
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void LPA(){
	printf("<LPA>\tindx -> %c\n",*(atoms + indx));
	if (*(atoms + indx) == ','){
		indx++;
		E();
		LPA();
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void E(){
	printf("E\tindx -> %c\n",*(atoms + indx));
	T();
	E_();
}
////////////////////////////////////////////////////////////////////////////////////////
void E_(){
	printf("E_\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == '+') || (*(atoms + indx) == '-')){
		indx++;
		T();
		E_();
		return;
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void T(){
	printf("T\tindx -> %c\n",*(atoms + indx));
	F();
	T_();
}
////////////////////////////////////////////////////////////////////////////////////////
void T_(){
	printf("T_\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == '*') || (*(atoms + indx) == '/')){
		indx++;
		F();
		T_();
		return;
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void F(){
	printf("F\tindx -> %c\n",*(atoms + indx));
	if ((*(atoms + indx) == 'a') || (*(atoms + indx) == 'n') || (*(atoms + indx) == 'c')){
		indx++;
		return;
	}
	if ((*(atoms + indx) == '@') && (*(atoms + indx + 1) == 'a')){
		indx+=2;
		LP();
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
}
///////////////////////////////////////////////////////////////////////////////////////

int main(){
	printf("MAIN\tindx -> %c\n",*(atoms + indx));
	BP();
	return 1;
}