for j in $(seq 1 4); do

	printf " -TEST%02d_ %48s\n" $j "" | tr  " " "-"
	rm -rf popcount
	gcc popcount.c -o popcount -Og -D TEST=$j -g
	./popcount
	
done
