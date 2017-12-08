
#include <stdio.h>
#include <stdlib.h>

char atoms[] = {'i','(','a','>','a',')','[','a','=','n',';',']','e','[','a','=','n',';',']','w','a',',','a',',','a',',','a',',','a',',','a',',','a',';','r','a',',','a',',','a',',','a',',','a',',','a',',','a',';','\0'};
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
void D();
void L();
void V();
void C();
void LD();
void LA();
void LAP();
void FUN();
void LF();
void P();



//////////PARSER//////////////

void parser (){
  P();
}
///////////////////////////////////////////////////////////////////////////////////////
void P(){
  LF();
}
///////////////////////////////////////////////////////////////////////////////////////
void LF(){
	printf("%c  ->  <LF>\n",*(atoms + indx));
  if ((*(atoms + indx) == 'a') || (*(atoms + indx) == 't') || (*(atoms + indx) == 'r')){
    FUN();
    LF();
  }else{}
}
///////////////////////////////////////////////////////////////////////////////////////
void FUN(){
	printf("%c  ->  <FUN>\n",*(atoms + indx));
  if ((*(atoms + indx) == 't') || (*(atoms + indx) == 'r')){
    V();
  }
  if ((*(atoms + indx) == 'a') && (*(atoms + indx + 1) == '(')){
    indx+=2;
    LA();
    if ((*(atoms + indx) == ')') && (*(atoms + indx + 1) == '[')){
      indx+=2;
      LD();
      BP();
      if (*(atoms + indx) == ']'){
        indx++;
        return;
      }else{
        printf("ERROR EN LA PRODUCCION <FUN> : SIMBOLO = %c\n",*(atoms + indx));
      }
    }else{
      printf("ERROR EN LA PRODUCCION <FUN> : SIMBOLO = %c\n",*(atoms + indx));  
    }
  }else{
      printf("ERROR EN LA PRODUCCION <FUN> : SIMBOLO = %c\n",*(atoms + indx));
  }
}

////////////////////////////////////////////////////////////////////////////////////////
void LA(){
	printf("%c  ->  <LA>\n",*(atoms + indx));
  if ((*(atoms + indx) == 't') || (*(atoms + indx) == 'r')){
    V();
    if (*(atoms + indx) == 'a'){
      indx++;
      LAP();
      return;
    }else{
      printf("ERROR EN LA PRODUCCION <LA> : SIMBOLO = %c\n",*(atoms + indx));
    }
  }
  else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void LAP(){
	printf("%c  ->  <LAP>\n",*(atoms + indx));
  if (*(atoms + indx) == ','){
    indx++;
    V();
    if (*(atoms + indx) == 'a'){
      indx++;
      LAP();
      return;
    }else{
      printf("ERROR EN LA PRODUCCION <LAP> : SIMBOLO = %c\n",*(atoms + indx));
    }
    return;
  }
  else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void LD(){
	printf("%c  ->  <LD>\n",*(atoms + indx));
  if ((*(atoms + indx) == 't') || (*(atoms + indx) == 'r')){
    D();
    LD();
    return;
  }
  else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void D(){
	printf("%c  ->  D\n",*(atoms + indx));
  if ((*(atoms + indx) == 't') || (*(atoms + indx) == 'r')){
    V();
    if (*(atoms + indx) == 'a'){
      indx++;
      C();
      L();
      return;
    }else{
      printf("ERROR EN LA PRODUCCION D : SIMBOLO = %c\n",*(atoms + indx));
    }
  }
  else{
    printf("ERROR EN LA PRODUCCION D : SIMBOLO = %c\n",*(atoms + indx));
  }
}
////////////////////////////////////////////////////////////////////////////////////////
void V(){
	printf("%c  ->  V\n",*(atoms + indx));
  if ((*(atoms + indx) == 't') || (*(atoms + indx) == 'r')){
    indx++;
    return;
  }
  else{
    printf("ERROR EN LA PRODUCCION V : SIMBOLO = %c\n",*(atoms + indx));
  }
}
////////////////////////////////////////////////////////////////////////////////////////
void N(){
	printf("%c  ->  N\n",*(atoms + indx));
  if ((*(atoms + indx) == 'n') || (*(atoms + indx) == 'c')){
    indx++;
    return;
  }
  else{
    printf("ERROR EN LA PRODUCCION N : SIMBOLO = %c\n",*(atoms + indx));
  }
}
////////////////////////////////////////////////////////////////////////////////////////
void C(){
	printf("%c  ->  C\n",*(atoms + indx));
  if (*(atoms + indx) == '='){
    indx++;
    N();
    return;
  }
  else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void L(){
	printf("%c  ->  L\n",*(atoms + indx));
  if ((*(atoms + indx) == ',') && (*(atoms + indx + 1) == 'a')){
    indx+=2;
    C();
    L();
    return;
  }
  if (*(atoms + indx) == ';'){
    indx++;
    return;
  }
  else{
    printf("ERROR EN LA PRODUCCION L : SIMBOLO = %c\n",*(atoms + indx));
  }
}
////////////////////////////////////////////////////////////////////////////////////////

void BP(){
	printf("%c  ->  <BP>\n",*(atoms + indx));
	if ((*(atoms + indx) == 'a') || (*(atoms + indx) == 'w') || (*(atoms + indx) == 'r') || (*(atoms + indx) == 'h') || (*(atoms + indx) == 'm') || (*(atoms + indx) == 'i') || (*(atoms + indx) == '@') || (*(atoms + indx) == '[')){
		PR();
		BP();
		return;
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void PR(){
	printf("%c  ->  <PR>\n",*(atoms + indx));
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
	printf("%c  ->  S\n",*(atoms + indx));
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
	printf("%c  ->  <PC>\n",*(atoms + indx));
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
	printf("%c  ->  A\n",*(atoms + indx));
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
	printf("%c  ->  W\n",*(atoms + indx));
	if ((*(atoms + indx) == 'w') && (*(atoms + indx + 1) == 'a')){
		indx+=2;
		L();
	}else{
		printf("ERROR EN LA PRODUCCION W : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void R(){
	printf("%c  ->  R\n",*(atoms + indx));
	if ((*(atoms + indx) == 'r') && (*(atoms + indx + 1) == 'a')){
		indx+=2;
		L();
	}else{
		printf("ERROR EN LA PRODUCCION R : SIMBOLO = %c\n",*(atoms + indx));
	}
}
////////////////////////////////////////////////////////////////////////////////////////
void H(){
	printf("%c  ->  H\n",*(atoms + indx));
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
	printf("%c  ->  M\n",*(atoms + indx));
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
	printf("%c  ->  I\n",*(atoms + indx));
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
	printf("%c  ->  <REL>\n",*(atoms + indx));
	E();
	OR();
	E();
}
////////////////////////////////////////////////////////////////////////////////////////
void OR(){
	printf("%c  ->  <BP>\n",*(atoms + indx));
	if ((*(atoms + indx) == '>') || (*(atoms + indx) == 'g') || (*(atoms + indx) == '<') || (*(atoms + indx) == 'p') || (*(atoms + indx) == 'q') || (*(atoms + indx) == '!')){
		indx++;
		return;
	}
	printf("ERROR EN LA PRODUCCION <OR> : SIMBOLO DE ENTRADA = %c\n",*(atoms + indx));
}
////////////////////////////////////////////////////////////////////////////////////////
void LP(){
	printf("%c  ->  <LP>\n",*(atoms + indx));
	if ((*(atoms + indx) == '@') || (*(atoms + indx) == '(') || (*(atoms + indx) == 'a') || (*(atoms + indx) == 'n') || (*(atoms + indx) == 'c')){
		E();
		LPA();
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void LPA(){
	printf("%c  ->  <LPA>\n",*(atoms + indx));
	if (*(atoms + indx) == ','){
		indx++;
		E();
		LPA();
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void E(){
	printf("%c  ->  E\n",*(atoms + indx));
	T();
	E_();
}
////////////////////////////////////////////////////////////////////////////////////////
void E_(){
	printf("%c  ->  E'\n",*(atoms + indx));
	if ((*(atoms + indx) == '+') || (*(atoms + indx) == '-')){
		indx++;
		T();
		E_();
		return;
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void T(){
	printf("%c  ->  T\n",*(atoms + indx));
	F();
	T_();
}
////////////////////////////////////////////////////////////////////////////////////////
void T_(){
	printf("%c  ->  T'\n",*(atoms + indx));
	if ((*(atoms + indx) == '*') || (*(atoms + indx) == '/')){
		indx++;
		F();
		T_();
		return;
	}else{}
}
////////////////////////////////////////////////////////////////////////////////////////
void F(){
	printf("%c  ->  F\n",*(atoms + indx));
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
	BP();

	if (*(atoms + indx) == '\0')
		printf("\nCADENA RECONOCIDA SATISFACTORIAMENTE\n\n");
	else {
		printf("\nATOMOS OMITIDOS: ");
		do{
			printf("%c",*(atoms + indx));
		}while(*(atoms + (indx++)) != '\0');
		printf("\n\n");
	}

	return 1;
}