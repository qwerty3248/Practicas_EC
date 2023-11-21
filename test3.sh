# ejecutar tests del acarreo
for i in $(seq 1 19); do
	gcc -x assembler-with-cpp -D TEST=$i -no-pie media_signo.s -o media_signo
    printf "__TEST%02d__%35s\n" $i "" | tr " " "-" ; ./media_signo
    rm  -fr media_signo
done
