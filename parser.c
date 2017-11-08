#include <stdio.h>
#include <stdlib.h>

float *stack = NULL;
int tos = 0; //valor real tos - 1
float atomsTable[] = {'a','+','(','a','*','a',')'};
int atomsLength = 7;
int atomsIndex = 0;

void push_one(float atom){
   if (tos == 0){
      stack = (float*) calloc (1 , sizeof(*stack));
         if (!stack)
            printf("Problems creating the stack (calloc)\n");
      tos++;
      *(stack) = atom;
   }else{ 
      tos++;
      float *chk = (float*) realloc(stack, tos * sizeof(*chk));
      if (!chk)
         printf("Problems Moving The Stack (realloc)\n");
      stack = chk;
      *(stack + (tos - 1)) = atom;
   }
}

void pop(){
   tos--;
   float *chk = (float*) realloc(stack, tos * sizeof(*chk));
   if (!chk)
      printf("Problems Moving The Stack (realloc)\n");
   stack = chk;
}

char *reverse(char *cadena){
	int i = 0, j = 0, ii = 0;
   while(*(cadena + (++i)) != '\0'){}
   char *tmp =(char *) calloc(i,sizeof(*tmp));
   ii = (i--);
	for (;i >= 0;i--)
		tmp[j++] = *(cadena + i);
	tmp[ii] = '\0';
	return tmp;
}

void push(char *cadena){
	int i = 0;
	char *andeac = reverse(cadena);
	while(*(andeac + i) != '\0')
		push_one((int) *(andeac + (i++)));
}

void replace(char *cadena){
	pop();
	push(cadena);
}

void move_pop(){
	pop();
	atomsIndex++;
}

void move_replace(char *cadena){
	replace(cadena);
	atomsIndex++;
}

void imprimir(){
	int i = 0;

	printf("STACK:\n");
	for(i = 0; i < tos; i++)
		printf("%c",(int) *(stack + i));
	printf("\nATOMS:\n");
	for(i = atomsIndex; i < atomsLength; i++)
		printf("%c",(int) *(atomsTable + i));
	printf("\n\n\n");
}

int main(){

	push("hola");
	push("me");
	push("llamo");
	push("Noe");

	imprimir();

	pop();
	imprimir();
	replace("TE");
	imprimir();
	move_replace("FG");
	imprimir();
	move_replace("$&#");
	imprimir();





}
