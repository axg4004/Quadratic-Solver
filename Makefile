SRC = QuadraticSolver.c
PROG = qs
OUT = out.txt
MEM = mem.txt
EQ1 = 2 2392.2 -766267.2
EQ2 = 1 -1 1
EQ3 = 0 1 -10
VALGRIND = valgrind --tool=memcheck --leak-check=yes --track-origins=yes
C = gcc
COMPILE = -std=c99 -O1 -Wall -pedantic -g -lm

.SILENT:
all: $(PROG)
$(PROG) : $(SRC)
	@echo "Compiling QuadraticSolver.c"
	$(C) $(COMPILE) $(SRC) -o $(PROG)

.PHONY: test
test: all
		@echo "Testing"
		./$(PROG) $(EQ1) > $(OUT)
		./$(PROG) $(EQ2) >> $(OUT)
		./$(PROG) $(EQ3) >> $(OUT)
		cat $(OUT)

memr: $(PROG)
	@echo "Valgrind QuadraticSolver.c memory Report"
	$(VALGRIND) ./$(PROG) $(EQ1) > $(MEM) 2>&1
	$(VALGRIND) ./$(PROG) $(EQ2) >> $(MEM) 2>&1
	$(VALGRIND) ./$(PROG) $(EQ3) >> $(MEM) 2>&1
	cat $(MEM)

.PHONY: help
help:
	@echo "All makefile targets: all, test, memr, clean, help"

.PHONY: clean 
clean:
	@echo "Removing temp file"
	rm -f $(PROG)
	rm -f $(MEM)
	rm -f $(OUT)
