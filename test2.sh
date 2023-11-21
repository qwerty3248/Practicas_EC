# ejecutar tests del acarreo
for i in $(seq 1 19); do
	gcc -x assembler-with-cpp -D TEST=$i -no-pie suma_negativos.s -o suma_negativos
    printf "__TEST%02d__%35s\n" $i "" | tr " " "-" ; ./suma_negativos
done
