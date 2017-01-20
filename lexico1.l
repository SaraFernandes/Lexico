
/*
    
  [0-9] => Reconhece um dígito
  [a-zA-Z] => Reconhece uma letra (comum = sem acentos)
  [\ \t\n] => Reconhece um espaço em branco ou um tab ou uma nova linha
  {letra} ({letra}|{digito})*
  {digito}+(\.{digito}+)?(E[+-]?{digito}+)?

*/

/****************************************************/
/* File: lexico1.l                                  */
/* Implemantação do Analizador Léxico               */
/* Para C usando Flex                               */
/* Sara Fernandes, Tayla Souza						*/
/* Data: 24/02/2015								    */
/****************************************************/
lexico1.l
%{
#include<stdio.h>
#include<math.h>
%}

digito       [0-9] 
letra        [a-zA-Z] 
espaco       [\ \t\n] 
id           {letra} ({letra}|{digito})*
numero       {digito}+(\.{digito}+)?(E[+-]?{digito}+)?

%%

{digito}+("E"("+"|"-")?{digito}+)? printf("\n%s\t E numero inteiro",yytext);  

{digito}+(\.{digito}+)?(E[+-]?{digito}+)? printf("\n%s\t E um numero Real",yytext);

"if"|"else"|"int"|"char"|"scanf"|"printf"|"switch"|"return"|"struct"|"do"|"while"|"void"|"for"|"float" printf("\n%s\t Palavras Reservadas",yytext);  /* reconhece palavras reservadas*/

"\a"|"\\n"|"\\b"|"\t"|"\\t"|"\b"|"\\a" printf("\n%s\t E um Escape",yytext);  

{letra}({letra}|{digito})* printf("\n%s\t E identificador",yytext);  

[-+]*[0-9]* {printf("\n%s\t Constante",yytext);}
[\ \t\n] {printf("\n%s\t Espaco",yytext);}

"&&"|"<"|">"|"<="|">="|"="|"+"|"-"|"?"|"*"|"/"|"%"|"&"|"||" printf("\n%s\t Operador ",yytext); /* Reconhece operadores */ 
"{"|"}"|"["|"]"|"("|")"|"#"|"'"|"."|"\""|"\\"|";"|"," printf("\n%s\t E um caractere especial",yytext);  
"%d"|"%s"|"%c"|"%f"|"%e" printf("\n%s\t E um especificador de formato especial ",yytext);  

%%

main() {
	
	// Abre um identificador de arquivo para um arquivo específico:
	FILE *myfile = fopen("helloworld.c", "r");
	// Certifica-se de que é válido:
	if (!myfile) {
		
		printf("O arquivo não pode ser aberto!");  

		return -1;
	}
	// set lex para lê-lo em vez de padronização para STDIN:
	yyin = myfile;
	
	// lex através da entrada:
	yylex();
	exit(0);
}



