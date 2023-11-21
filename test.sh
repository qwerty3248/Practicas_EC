# ejecutar tests del acarreo
for i in $(seq 1 8); do
	gcc -x assembler-with-cpp -D TEST=$i -no-pie suma_acarreo.s -o suma_acarreo
    printf "__TEST%02d__%35s\n" $i "" | tr " " "-" ; ./suma_acarreo
done
