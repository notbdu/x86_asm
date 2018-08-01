BINARIES=$(addprefix bin/, $(notdir $(wildcard cmd/*)))

all: $(BINARIES)

bin/%: cmd/%/*.o
	ld $< -melf_i386 -o $@

cmd/%/*.o: cmd/%/*.s
	as -g --32 $< -o $@

clean:
	rm -r *.o
