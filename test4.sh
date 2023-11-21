# ejecutar tests de la media
for i in $(seq 1 19); do
	gcc -x assembler-with-cpp -D TEST=$i -no-pie suma_media.s -o suma_media
    printf "_TEST%02d_%35s\n" $i "" | tr " " "-" ; ./suma_media
    rm -fr suma_media
done
