%{
/*
Analizador Lexico

Lee un archivo fuente, proporcionado como argumento
y clasifica sus componentes lexicos, segun ciertas
clases definidas previamente.

Por ultimo muestra las tablas creadas. Tambien se crean
los archivos correspondientes de cada tabla.

Autor: Noe Martinez Naredo
septiembre 2017
version 0.0

*/
#include <stdio.h>
#include <stdlib.h>
int tokensLength = 0;
float *tokens = NULL;
int symbolsLength = 0;
int *symbols = NULL;   
int symQuantity = 0;
int stringsLength = 0;
int *strings = NULL;   
int strQuantity = 0;
int *atoms = NULL;   
int atomsLength = 0;
int atomsIndex = 0;
float tokens_0 = 0;
int indx = 0;
int atoms_0 = 0;
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
void errr();

void insertToken(float clase,float tok){	 
    if (tokensLength == 0){
    	 tokens_0 = clase;
       tokens = (float*) calloc(2 , sizeof(*tokens));
          if (!tokens)
              printf("Problems creating Token Table  (calloc)\n");
       *(tokens) = clase;
       *(tokens + 1) = tok;
       tokensLength += 2;
       
    }
    else{
       tokensLength += 2;
       float *chk = (float *) realloc(tokens,tokensLength * sizeof(*chk));
       if (!chk)
          printf("Problems Moving Token Table (realloc)\n");
       tokens = chk;
       *(tokens + (tokensLength - 2)) = clase;
       *(tokens + (tokensLength - 1)) = tok;
       *tokens = tokens_0;
    }
}


void insertAtom(int atm){
    if (atomsLength == 0){
    	 atoms_0 = atm;
       atoms = (int*) calloc(1 , sizeof(*atoms));
          if (!atoms)
              printf("Problems creating Atom Table  (calloc)\n");
       *(tokens) = atm;
       atomsLength++;
    }
    else{ 
       atomsLength++;
       int *chk = (int*) realloc(atoms,atomsLength * sizeof(*chk));
       if (!chk)
          printf("Problems Moving Atom Table (realloc)\n");
       atoms = chk;
       *(atoms + (atomsLength - 1)) = atm;
       *atoms = atoms_0;
    }
}

int compara(char *cad1,char *cad2){
    int i = 0;
    while((*(cad1 + i) != '\0') || *(cad2 + i) != '\0'){
        if (*(cad1 + i) != *(cad2 + i))
            return(0);
        i++;
    }
    return(1);
}

void operadorAritmetico(char *op){
    char divide[] = {'D','I','V','I','D','E','\0'};
    char mas[] = {'M','A','S','\0'};
    char menos[] = {'M','E','N','O','S','\0'};
    char multiplica[] = {'M','U','L','T','I','P','L','I','C','A','\0'};
    if (compara(op,divide)){
        insertToken(4,0);
        insertAtom('/');
        return;
       }
    if (compara(op,mas)){
        insertToken(4,1);
        insertAtom('+');
        return;
       }
    if (compara(op,menos)){
        insertToken(4,2);
        insertAtom('-');
        return;
       }
    if (compara(op,multiplica)){
        insertToken(4,3);
        insertAtom('*');
        return;
       }
    return;
}

void operadorRelacional(char *op){
    char masque[] = {'>','\0'};
    char masoigualque[] = {'>','=','\0'};
    char menosque[] = {'<','\0'};
    char menosoigualque[] = {'<','=','\0'};
    char igual[] = {'=','=','\0'};
    char noigual[] = {'!','=','\0'};
    if (compara(op,masque)){
        insertToken(3,0);
        insertAtom('>');
        return;
       }
    if (compara(op,masoigualque)){
        insertToken(3,1);
        insertAtom('g');
        return;
       }
    if (compara(op,menosque)){
        insertToken(3,2);
        insertAtom('<');
        return;
       }
    if (compara(op,menosoigualque)){
        insertToken(3,3);
        insertAtom('p');
        return;
       }
    if (compara(op,igual)){
        insertToken(3,4);
        insertAtom('q');
        return;
       }
    if (compara(op,noigual)){
        insertToken(3,5);
        insertAtom('!');
        return;
       }
    return;
}

void palabraReservada(char *op){
    char ent[] = {'E','N','T','\0'};
    char escribe[] = {'E','S','C','R','I','B','E','\0'};
    char haz[] = {'H','A','Z','\0'};
    char lee[] = {'L','E','E','\0'};
    char mientras[] = {'M','I','E','N','T','R','A','S','\0'};
    char real[] = {'R','E','A','L','\0'};
    char si[] = {'S','I','\0'};
    char sino[] = {'S','I','N','O','\0'};
    if (compara(op,ent)){
        insertToken(1,0);
        insertAtom('t');
        return;
       }
    if (compara(op,escribe)){
        insertToken(1,1);
        insertAtom('w');
        return;
       }
    if (compara(op,haz)){
        insertToken(1,2);
        insertAtom('h');
        return;
       }
    if (compara(op,lee)){
        insertToken(1,3);
        insertAtom('l');
        return;
       }
    if (compara(op,mientras)){
        insertToken(1,4);
        insertAtom('m');
        return;
       }
    if (compara(op,real)){
        insertToken(1,5);
        insertAtom('r');
        return;
       }
    if (compara(op,si)){
        insertToken(1,6);
        insertAtom('i');
        return;
       }
    if (compara(op,sino)){
        insertToken(1,7);
        insertAtom('e');
        return;
       }
    return;
}

int *makeSymbolPointer(char *sym){
    int i = 0;
    int symLength = 0;
    int *tmp = NULL;
    do{}while(*(sym + (symLength++)) != '\0');
    tmp = calloc(++symLength, sizeof(*tmp));
       if (!tmp)
          printf("Problems Creating Pointer to Symbol (calloc)\n");
    *tmp = (symQuantity + 1);
    for (i = 0; i < (symLength);i++)
       *(tmp + i + 1) = *(sym + i); 
   return(tmp);

}

int okInsertSymbol(int *findThis){
    int i = 0,j = 0,k = 0,findThisLength = 0,matches = 0,index = 0;
    do{}while(*(findThis + (findThisLength++)) != '\0');
    for (i = 0;i < symbolsLength; i++){
        if (j == 0)
            j++;
         else{
            if (*(symbols + i) != '\0')
                j++;
            else{
                if ((++j) == findThisLength){
                    for (k = 1;k < findThisLength;k++){
                        if (*(symbols + index + k) == *(findThis + k))
                           matches++;
                        else{}
                    }


                    if (matches == (findThisLength - 1)){
                        insertToken(0,*(symbols + index) - 1);
                        return 0; 
                    }else{}

                    matches = 0;

                }else{}
                index += j;
                j=0;
            }
       }
    }
   return 1;
}

void insertSymbol(char *sym){
    int i = 0;
    int tmpLength = 0;
    int *tmp = makeSymbolPointer(sym);
    if (okInsertSymbol(tmp)){
        do{}while(*(tmp + (tmpLength++)) != '\0');
        if (symQuantity == 0){
            symbols = (int*) calloc(tmpLength, sizeof(*symbols));
           if (!symbols)
               printf("Problems Creating Symbol Table (calloc)\n");
            symbolsLength += tmpLength;
            symbols = tmp;
        }
        else{ 
            
            int *chk = realloc(symbols,(symbolsLength + tmpLength) * sizeof(*chk));
            if (!chk)
               printf("Problems moving Symbol Table (realloc)\n");
            symbols = chk;
            for (i = 0; i < tmpLength; i++)
               *(symbols + symbolsLength + i) = *(tmp + i);
            symbolsLength+=tmpLength;
       }
       insertToken(0,symQuantity++);

    }else{
        //El simbolo ya existe en la tabla de simbolos
        //free(sym);
    }
}

int *makeStringPointer(char *str){
    int i = 0;
    int strLength = 0;
    int *tmp = NULL;
    do{}while(*(str + (strLength++)) != '\0');
    tmp = calloc(++strLength, sizeof(int));
       if (!tmp)
           printf("Problems Creating Pointer to String (calloc)\n");
    *tmp = (strQuantity + 1);
    for (i = 0; i < (strLength);i++)
       *(tmp + i + 1) = *(str + i); 
   
    return(tmp);
}

int okInsertString(int *findThisStr){
    int i = 0,j = 0,k = 0,findThisStrLength = 0,matches = 0,index = 0;
    do{}while(*(findThisStr + (findThisStrLength++)) != '\0');
    for (i = 0;i < stringsLength; i++){
        if (j == 0)
            j++;
         else{
            if (*(strings + i) != '\0')
                j++;
            else{
                if ((++j) == findThisStrLength){
                    for (k = 1;k < findThisStrLength;k++){
                        if (*(strings + index + k) == *(findThisStr + k))
                           matches++;
                        else{}
                    }


                    if (matches == (findThisStrLength - 1)){
                        insertToken(8,*(strings + index) - 1);
                        return 0; 
                    }else{}

                    matches = 0;

                }else{}
                index += j;
                j=0;
            }
       }
    }
   return 1;
}

void insertString(char *str){
    int i = 0;
    int tmpLength = 0;
    int *tmp = makeStringPointer(str);
    if (okInsertString(tmp)){
        do{}while(*(tmp + (tmpLength++)) != '\0');
        if (strQuantity == 0){
            strings = (int*) calloc(tmpLength, sizeof(*strings));
            if (!strings)
                printf("Problems Meking Strings Table (calloc)\n");
            stringsLength += tmpLength;
            strings = tmp;
        }
        else{ 
            int *chk = realloc(strings,(stringsLength + tmpLength) * sizeof(*chk));
            if (!chk)
               printf("Problems Moving String Table (realloc)\n");
            strings = chk;
            for (i = 0; i < tmpLength; i++)
               *(strings + stringsLength + i) = *(tmp + i);
            stringsLength+=tmpLength;
       }
       insertToken(8,strQuantity++);

    }else{
        //El simbolo ya existe en la tabla de simbolos
        //free(str);
    }
}

void showStringsTable(){
    int i = 0,j = 0;
    FILE *fichier = fopen("StringsTable.txt","w");
    printf("\n----------------\nTABLA DE CADENAS\n----------------\n");
 
    for (i = 0;i < stringsLength; i++){
        if (j == 0){
            printf("%i ",*(strings + i) - 1);
            fprintf(fichier,"%i ",*(strings + i) - 1);
            j++;
        }
        else{
            if (*(strings + i) != '\0'){
                printf("%c",*(strings + i));
                fprintf(fichier,"%c",*(strings + i));
                j++;
            }
            else{
                printf("\n");
                fprintf(fichier,"\n");
                j=0;
            }
       }
    }
    fclose(fichier);
}

void showSymbolsTable(){
    int i = 0,j = 0;
    FILE *fichier = fopen("SymbolsTable.txt","w");
    printf("\n-----------------\nTABLA DE SIMBOLOS\n-----------------\n");
    for (i = 0;i < symbolsLength; i++){
        if (j == 0){
            printf("%i ",*(symbols + i) - 1);
            fprintf(fichier,"%i ",*(symbols + i) - 1);
            j++;
        }
        else{
            if (*(symbols + i) != '\0'){
                printf("%c",*(symbols + i));
                fprintf(fichier,"%c",*(symbols + i));
                j++;
            }
            else{
                printf("\n");
                fprintf(fichier,"\n");
                j=0;
            }
       }
    }
    fclose(fichier);
}

void showTokenTable(){
    int i;
    FILE *fichier = fopen("TokensTable.txt","w");
    printf("\n\n---------------\nTABLA DE TOKENS\n---------------\n");
    for (i = 0; i < tokensLength; i += 2)
    {
       if ((int)*(tokens + i) == 7){
           printf("%i %f\n",(int)*(tokens + i),*(tokens + 1 + i));
           fprintf(fichier,"%i %f\n",(int)*(tokens + i),*(tokens + 1 + i));
       }else{
           printf("%i %i\n",(int)*(tokens + i),(int)*(tokens + 1 + i));
           fprintf(fichier,"%i %i\n",(int)*(tokens + i),(int)*(tokens + 1 + i));
       }
    }

    fclose(fichier);
}

void showAtomsTable(){
   int i;
   FILE *fichier = fopen("AtomsTable.txt","w");
   printf("\n\n---------------\nTABLA DE ATOMOS\n---------------\n");
   for (i = 0; i < atomsLength; i++){
     printf("%c\n",(int)*(atoms + i));
     fprintf(fichier,"%c\n",(int)*(atoms + i));
   }

   fclose(fichier);
}

void comment(char *comm){
//int i = 0;
//printf("COMMENT : ");
//do{
//    printf("%c",*(comm + i));
//}while (*(comm + (i++)) != '\0');
//printf("\n");
}

void unrecogHandler(char *comm){
if(*comm != ' '){
        int i = 0;
        printf("NO SE RECONOCE : ");
        do{
            printf("%c",*(comm + i));
        }while (*(comm + (i++)) != '\0');
        printf("\n");
    }
}

//////////PARSER//////////////

void parser (){
  P();
    if ((*(atoms + indx) == '\0') || (*(atoms + indx + 1) == 0))
    printf("\nCADENA RECONOCIDA SATISFACTORIAMENTE\n\n");
  else {
    printf("\nATOMOS OMITIDOS: ");
    do{
      printf("%c",*(atoms + indx));
    }while(*(atoms + (indx++)) != '\0');
    printf("\n\n");
  }
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
        errr();
      }
    }else{
      printf("ERROR EN LA PRODUCCION <FUN> : SIMBOLO = %c\n",*(atoms + indx));  
      errr();
    }
  }else{
      printf("ERROR EN LA PRODUCCION <FUN> : SIMBOLO = %c\n",*(atoms + indx));
      errr();
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
      errr();
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
      errr();
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
      errr();
    }
  }
  else{
    printf("ERROR EN LA PRODUCCION D : SIMBOLO = %c\n",*(atoms + indx));
    errr();
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
    errr();
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
    errr();
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
    errr();
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
  errr();
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
        errr();
      }
      return;
    }
  }else{
    printf("ERROR EN LA PRODUCCION S : SIMBOLO = %c\n",*(atoms + indx));
    errr();
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
      errr();
    }
  }else{
    printf("ERROR EN LA PRODUCCION <PC> : SIMBOLO = %c\n",*(atoms + indx));
    errr();
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
      errr();
    }
  }else{
    printf("ERROR EN LA PRODUCCION A : SIMBOLO = %c\n",*(atoms + indx));
    errr();
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
    errr();
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
    errr();
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
        errr();
      }
    }else{
      printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
      errr();
    }
  }else{
    printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
    errr();
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
      errr();
    }
  }else{
    printf("ERROR EN LA PRODUCCION M : SIMBOLO = %c\n",*(atoms + indx));
    errr();
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
        errr();
      }
    }else{
      printf("ERROR EN LA PRODUCCION I : SIMBOLO = %c\n",*(atoms + indx));
      errr();
    }
  }else{
    printf("ERROR EN LA PRODUCCION I : SIMBOLO DE ENTRADA = %c\n",*(atoms + indx));
    errr();
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
  errr();

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
  errr();
}

///////////////////////////////////////////////////////////////////////////////////////


void errr(){

    printf("\n\n\nSE HA ENCONTRADO UN ERROR!!!!!!!. EJECUCION DETENIDA\n");
    if(tokens != NULL)
      free(tokens);
    if(symbols != NULL)
      free (symbols);
    if(strings != NULL)
      free(strings);

    exit(0);

}

///////////////////////////////////////////////////////////////////////////////////////


%}
dig [0-9]
dignz [1-9]
min [a-z]
comentario \$\$.*$
cadena \".*\"
reservadas ENT|ESCRIBE|HAZ|LEE|MIENTRAS|REAL|SI|SINO 
simbolo {min}+
simbesp [,;()\[\]]
oparit DIVIDE|MAS|MENOS|MULTIPLICA
oprel \=\=|<\=|<|>|>\=|!\=
opasig \=
numreal {dig}+\.{dig}+
nument {dignz}?{dig}*

%%
{comentario} {comment(yytext);}
{cadena} {insertString(yytext); insertAtom('s');}
{simbolo} {insertSymbol(yytext); insertAtom('a');}
{oprel} {operadorRelacional(yytext);}
{opasig} {insertToken(2,'='); insertAtom('=');}
{simbesp} {insertToken(5,*(yytext)); insertAtom(*(yytext));}
{oparit} {operadorAritmetico(yytext);}
{reservadas} {palabraReservada(yytext);}
{numreal} {insertToken(7,atof(yytext)); insertAtom('n');}
{nument} {insertToken(6,atoi(yytext)); insertAtom('c');}
. {unrecogHandler(yytext);}
%%
int main(int argc,char *argv[]){
    FILE *archivo_fuente = fopen(argv[1],"r");
    if (!archivo_fuente)
       printf("No se pudo cargar el archivo\n");
    yyin = archivo_fuente;
    yylex();
    showAtomsTable();
    showTokenTable();
    showSymbolsTable();
    showStringsTable();
    fclose(archivo_fuente);
    printf("\n----------------\nEJECUCION PARSER\n----------------\n");
    parser();
    printf("\n\n");
    if(tokens != NULL)
      free(tokens);
    if(symbols != NULL)
      free (symbols);
    if(strings != NULL)
      free(strings);
    
    
    return 0;
}
