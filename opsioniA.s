.data                                               #deklarimi i data - ketu deklarojme emrat e variablave te perdorur në program
textoutput: .asciiz "Enter a non-negative number: " #variabla textoutput qe permban nje string per ta printuar "Enter a non-negative number"
anothertext: .asciiz "\nFactorial of "              #variabla anothertext qe permban nje string per ta printuar "Factorial of"
equalto: .asciiz " = "                              #variabla equalto qe permban nje string per ta printuar shenjen e barazimit
number: .word 0                                     #vlera e number fillimisht 0
answer: .word 0                                     #vlera e answer fillimisht 0
valueofa: .word 1                                   #variabla valueofa qe ka vleren 1


.text
.globl main

main:                    #pika e fillimit per ekzekutimin e kodit
lw $s0, valueofa         #ruajme vleren e valueofa(a=1) ne regjistrin $s0


li $v0, 4
la $a0, textoutput       #printimi i textoutput
syscall

li $v0, 5                #vlera nga perdoruesi
syscall

sw $v0, number          #vleren e shkruar nga perdoruesi e zhvendosim ne 'number'
lw $a0, number          #ruhet tek $a0
jal factorial           #jal- jump and link, kercen tek funksioni "factorial" dhe ruan return address($ra) adresen kthyese te instruksionit te ardhshem
sw $v0, answer          #answer qe vjen nga funksioni e ruajtur tek $v0, e zhvendosim tek 'answer'

li $v0, 4
la $a0, anothertext     #printimi i anothertext
syscall

li $v0, 1
lw $a0, number          #printimi i numrit te shtypur nga perdoruesi
syscall

li $v0, 4
la $a0, equalto         #printimi i equalto
syscall

li $v0, 1
lw $a0, answer          #printimi i llogaritjes nga funksioni      
syscall

li $v0, 10           
syscall


factorial:              #funksioni factorial

addi $sp, $sp, -12      #marrim 3 vende nga stack pointeri, 3 vende per shkak se kemi te bejme me integers pra nje integer ze hapesire prej 4 bytes
sw $s0, 8($sp)          #ruajme $s0 tek 4 bytet e larte nga 12 sa kemi marre tek $sp
sw $s1, 4($sp)          #ruajme $t0 tek 4 bytet e poshtem nga 8 sa kemi marre tek $sp
sw $ra, 0($sp)          #ruajme return address ($ra) ne 4 bytet e larte nga 8 sa kemi marre tek $sp


li $v0, 1               #japim vleren e 'number' regjistrit $v0 (kjo vlen edhe kur perdoruesi e shfaq 0 rezultati del 1
beq $a0, 0, exitprogram #krahasojme $a0 ose numrin e shkruar nga perdoruesi me 0 nese jane te barabarte kalojme tek 'exitprogram', nese jo atehere vazhdon ekzekutimimi programit

move $s1, $a0           #kopjohet vlera e numrit
sub $a0, $a0, 1         #zbresim vleren e regjistrit $t0 per -1
jal factorial           #kercen tek funksioni 'factorial'

mul $v0, $s0, $v0       #shumezojme rezultatin me numrin
mul $v0, $s1, $v0    
    
exitprogram:                
lw $ra, 0($sp)          #mbushim stackun
lw $s1, 4($sp)   
lw $s0, 8($sp)  
addi $sp, $sp, 12
jr $ra                  #kthemi tek $ra return address tek main nje instruksion me tutje se jal
