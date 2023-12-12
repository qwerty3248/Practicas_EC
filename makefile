###############################################################################
# makefile
###############################################################################

SHELL := /bin/bash
.ONESHELL:

###############################################################################

ATT = $(EXE:=.att)
SRC = $(sort $(wildcard *.cc))
EXE = $(basename $(SRC))
DAT = $(EXE:=.dat)
PNG = $(EXE:=.png) $(EXE:=-log.png)
SVG = $(EXE:=.svg) $(EXE:=-log.svg)
PER = $(EXE:=.perf)
REP = $(EXE:=.rep)

###############################################################################

CXXFLAGS = -march=native -O3 -Wall

PLT = set terminal svg enhanced; \
	  set output '$@'; \
	  set nokey; \
	  set grid; \
	  set xlabel 'line size (B)'; \
	  set ylabel 'time (µs)'; \
	  set logscale x 2; \
	  set xtics rotate; \
	  set xtics (1, 2, 4, 8, 16, 32, 64, 128, 256, 512, '1K' 1024, '2K' 2048, '4K' 4096, '8K' 8192, '16K' 16384, '32K' 32768, '64K' 65526, '128K' 131072, '256K' 262144, '512K' 524288, '1M' 1048576, '2M' 2097152, '4M' 4194304, '8M' 8388608, '16M' 16777216, '32M' 33554432, '64M' 67108864, '128M' 134217728, '256M' 268435456, '512M' 536870912, '1G' 1073741824); \
	  plot '$<' u 1:2 w lp lc 1 pt 7

###############################################################################

all: att svg

att: $(ATT)

clean:
	-rm -fv $(ATT) $(DAT) $(EXE) $(PER) $(PNG) $(SVG) governor.txt *~
	if [ -e governor.txt ]; then
		sudo cpupower frequency-set --governor $$(cat governor.txt)
	fi

dat: $(DAT)

exe: $(EXE) | tools

info: /sys/devices/system/cpu/cpu0/cache
	@printf "%5s %12s %8s %8s %9s\n" level type line size instances
	printf "%46s\n" | tr ' ' '-'
	for ((i=0; i<$$(ls $< | grep "index[[:digit:]]\+" | wc -l); ++i)); do
		j=$$((i + 1))
		printf "%5s %12s %8s %8s %9s\n" $$(cat $</index$$i/{level,type,coherency_line_size,size}) $$(lscpu | grep -o ". instancia" | cut -d' ' -f 1 | sed -n $$((i + 1))p)
	done

png : $(PNG)

svg: $(SVG)

tools:
	@for i in cpupower g++ gnuplot google-benchmark; do \
		if [ -z $$(which $$i 2> /dev/null) ]; then \
			echo necesito que instales $$i!!!; \
			exit 1; \
		fi \
	done

###############################################################################

governor.txt:
	@governor="$$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
	if [ "$$governor" == "performance" ]; then
		governor="schedutil"
	fi
	echo $$governor > $@

%.att:	%
	objdump -CdS $< > $@

%.dat: % | governor.txt
	@sudo cpupower frequency-set --governor performance &> /dev/null
	./$< | tee $@
	sudo cpupower frequency-set --governor $$(cat governor.txt) &> /dev/null

%.png: %.dat makefile
	@gnuplot <<< "$(PLT:svg=pngcairo)"

%-log.png: %.dat makefile
	@gnuplot <<< "set logscale y 10; $(PLT:svg=pngcairo)"

%.svg: %.dat makefile
	gnuplot <<< "$(PLT)"

%-log.svg: %.dat makefile
	gnuplot <<< "set logscale y 10; $(PLT)"

###############################################################################

%.perf: %
	perf record -g -o $@ -- ./$<

%.report: %.perf
	perf report -g 'graph,0.5,caller' -i $<

###############################################################################

.PHONY: all att clean exe info png svg tools
.PRECIOUS: $(DAT)
.NOEXPORT:

###############################################################################

