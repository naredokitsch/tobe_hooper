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
       tokens = (float*) calloc(2 , sizeof(*tokens));
          if (!tokens)
              printf("Problems creating Token Table  (calloc)\n");
       tokensLength += 2;
       *(tokens) = clase;
       *(tokens + 1) = tok;
    }
    else{ 
       tokensLength += 2;
       float *chk = (float*) realloc(tokens,tokensLength * sizeof(*chk));
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

int *makeSymbolPointer(char *sym){
    int i = 0;
    int symLength = 0;
    int *tmp = NULL;
    do{}while(*(sym + (symLength++)) != '\0');
    tmp = calloc(++symLength, sizeof(tmp));
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
    tmp = calloc(++strLength, sizeof(tmp));
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
                printf("Problems Making Strings Table (calloc)\n");
            stringsLength += tmpLength;
            strings = tmp;
        }
        else{ 
            int *chk = realloc(strings,(stringsLength + tmpLength) * sizeof(chk));
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


int main(int argc,char *argv[]){
    FILE *archivo_fuente = fopen("fuente.txt","r");
    if (!archivo_fuente)
       printf("No se pudo cargar el archivo\n");

    insertToken(1.0,1.0); insertSymbol("simbolo"); insertString("cadena");

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
