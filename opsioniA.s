.data                                               #deklarimi i data - ketu deklarojme emrat e variablave te perdorur në program
textoutput: .asciiz "Enter a non-negative number: " #variabla textoutput qe permban nje string per ta printuar "Enter a non-negative number"
anothertext: .asciiz "\nFactorial of "              #variabla anothertext qe permban nje string per ta printuar "Factorial of"
equalto: .asciiz " = "                              #variabla equalto qe permban nje string per ta printuar shenjen e barazimit
number: .word 0                                     #vlera e number fillimisht 0
answer: .word 0                                     #vlera e answer fillimisht 0
valueofa: .word 1                                   #variabla valueofa qe ka vleren 1


.text
.globl main

main:                    #Pika e fillimit per ekzekutimin e kodit
lw $s0, valueofa         #Ruajme vleren e valueofa(a=1) ne regjistrin $s0


li $v0, 4
la $a0, textoutput       #Printimi i textoutput
syscall

li $v0, 5                #Vlera nga perdoruesi
syscall

sw $v0, number          #Vleren e shkruar nga perdoruesi e zhvendosim ne 'number'
lw $a0, number          #Ruhet tek $a0
jal factorial           #jal- jump and link, kercen tek funksioni "factorial" dhe ruan return address($ra) adresen kthyese te instruksionit te ardhshem
sw $v0, answer          #answer qe vjen nga funksioni e ruajtur tek $v0, e zhvendosim tek 'answer'

li $v0, 4
la $a0, anothertext     #Printimi i anothertext
syscall

li $v0, 1
lw $a0, number          #Printimi i numrit te shtypur nga perdoruesi
syscall

li $v0, 4
la $a0, equalto         #Printimi i equalto
syscall

li $v0, 1
lw $a0, answer          #Printimi i llogaritjes nga funksioni      
syscall

li $v0, 10           
syscall


factorial:              #Funksioni(procedura) factorial

addi $sp, $sp, -12      #Marrim 3 vende nga stack pointeri, 3 vende per shkak se kemi te bejme me integers pra nje integer ze hapesire prej 4 bytes
sw $s0, 8($sp)          #Ruajme $s0 tek 4 bytet e larte nga 12 sa kemi marre tek $sp
sw $s1, 4($sp)          #Ruajme $t0 tek 4 bytet e poshtem nga 8 sa kemi marre tek $sp
sw $ra, 0($sp)          #Ruajme return address ($ra) ne 4 bytet e larte nga 8 sa kemi marre tek $sp


li $v0, 1               #Japim vleren e 'number' regjistrit $v0 (kjo vlen edhe kur perdoruesi e shfaq 0 rezultati del 1
beq $a0, 0, exitprogram #krahasojme $a0 ose numrin e shkruar nga perdoruesi me 0 nese jane te barabarte kalojme tek 'exitprogram', nese jo atehere vazhdon ekzekutimimi programit

move $s1, $a0           #Kopjohet vlera e numrit
sub $a0, $a0, 1         #Zbresim vleren e regjistrit $t0 per -1
jal factorial           #Kercen tek funksioni 'factorial'

mul $v0, $s0, $v0       #Shumezojme rezultatin me numrin
mul $v0, $s1, $v0    
    
exitprogram:                
lw $ra, 0($sp)          #Mbushim stackun
lw $s1, 4($sp)   
lw $s0, 8($sp)  
addi $sp, $sp, 12
jr $ra                  #Kthemi tek $ra return address tek main nje instruksion me tutje se jal
