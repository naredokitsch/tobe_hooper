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

void insertToken(float clase,float tok){
    if (tokensLength == 0){
       tokens = (float*) calloc(2 , sizeof(float));
          if (!tokens)
              printf("Problems creating Token Table  (calloc)\n");
       tokensLength += 2;
       *(tokens) = clase;
       *(tokens + 1) = tok;
    }
    else{ 
       tokensLength += 2;
       float *chk = (float*) realloc(tokens,tokensLength * sizeof(float));
       if (!chk)
          printf("Problems Moving Token Table (realloc)\n");
       tokens = chk;
       *(tokens + (tokensLength - 2)) = clase;
       *(tokens + (tokensLength - 1)) = tok;
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
        return;
       }
    if (compara(op,mas)){
        insertToken(4,1);
        return;
       }
    if (compara(op,menos)){
        insertToken(4,2);
        return;
       }
    if (compara(op,multiplica)){
        insertToken(4,3);
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
        return;
       }
    if (compara(op,masoigualque)){
        insertToken(3,1);
        return;
       }
    if (compara(op,menosque)){
        insertToken(3,2);
        return;
       }
    if (compara(op,menosoigualque)){
        insertToken(3,3);
        return;
       }
    if (compara(op,igual)){
        insertToken(3,4);
        return;
       }
    if (compara(op,noigual)){
        insertToken(3,5);
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
        return;
       }
    if (compara(op,escribe)){
        insertToken(1,1);
        return;
       }
    if (compara(op,haz)){
        insertToken(1,2);
        return;
       }
    if (compara(op,lee)){
        insertToken(1,3);
        return;
       }
    if (compara(op,mientras)){
        insertToken(1,4);
        return;
       }
    if (compara(op,real)){
        insertToken(1,5);
        return;
       }
    if (compara(op,si)){
        insertToken(1,6);
        return;
       }
    if (compara(op,sino)){
        insertToken(1,7);
        return;
       }
    return;
}

int *makeSymbolPointer(char *sym){
    int i = 0;
    int symLength = 0;
    int *tmp = NULL;
    do{}while(*(sym + (symLength++)) != '\0');
    tmp = calloc(++symLength, sizeof(int));
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
            symbols = (int*) calloc(tmpLength, sizeof(int));
           if (!symbols)
               printf("Problems Creating Symbol Table (calloc)\n");
            symbolsLength += tmpLength;
            symbols = tmp;
        }
        else{ 
            
            int *chk = realloc(symbols,(symbolsLength + tmpLength) * sizeof(int));
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
            strings = (int*) calloc(tmpLength, sizeof(int));
            if (!strings)
                printf("Problems Meking Strings Table (calloc)\n");
            stringsLength += tmpLength;
            strings = tmp;
        }
        else{ 
            int *chk = realloc(strings,(stringsLength + tmpLength) * sizeof(int));
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
    *strings = 1;
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
    *symbols = 1;
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

void comment(char *comm){
//int i = 0;
//printf("COMMENT : ");
//do{
//    printf("%c",*(comm + i));
//}while (*(comm + (i++)) != '\0');
//printf("\n");
}

void unrecogHandler(char *comm){
int i = 0;
printf("NO SE RECONOCE : ");
do{
    printf("%c",*(comm + i));
}while (*(comm + (i++)) != '\0');
printf("\n");
}

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
{cadena} {insertString(yytext);}
{simbolo} {insertSymbol(yytext);}
{oprel} {operadorRelacional(yytext);}
{opasig} {insertToken(2,'=');}
{simbesp} {insertToken(5,*(yytext));}
{oparit} {operadorAritmetico(yytext);}
{reservadas} {palabraReservada(yytext);}
{numreal} {insertToken(7,atof(yytext));}
{nument} {insertToken(6,atoi(yytext));}
. {unrecogHandler(yytext);}
%%
int main(int argc,char *argv[]){
    FILE *archivo_fuente = fopen("fuente.txt","r");
    if (!archivo_fuente)
       printf("No se pudo cargar el archivo\n");
    yyin = archivo_fuente;
    yylex();
    showTokenTable();
    showSymbolsTable();
    showStringsTable();
    printf("\n\n");
    free(tokens);
    free (symbols);
    free(strings);
    fclose(archivo_fuente);
    return 0;
}
