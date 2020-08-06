lib = libex2.so
obj = ex1.o
bin = ex1

CC = gcc
CPP_FLAGS =
C_FLAGS = -m32
C_FLAGS_LIB = --share
C_FLAGS_BIN = -L.
# Recipe

all: $(bin)


$(bin): $(obj) $(lib)
	$(CC) $(CPP_FLAGS) $(C_FLAGS) $(C_FLAGS_BIN) $(obj) -l$(lib:lib%.so=%) -o $(bin) 


$(lib): $(lib:lib%.so=%.o)
	$(CC) $(C_FLAGS) $(C_FLAGS_LIB) $< -o $(lib)

%.o: %.c
	$(CC) $(CPP_FLAGS) $(C_FLAGS) -c $<


install: $(bin) $(lib) $(lib:lib%.so=%.h)
	mkdir -p $(PREFIX)/bin && cp $(bin) $(PREFIX)/bin/$(bin)
	mkdir -p $(PREFIX)/lib && cp $(lib) $(PREFIX)/lib/$(lib)
	mkdir -p $(PREFIX)/include && cp $(lib:lib%.a=%.h) $(PREFIX)/include/$(lib:lib%.a=%.h)


uninstall:
	rm $(PREFIX)/bin/$(bin)
	rm $(PREFIX)/lib/$(lib)
	rm $(PREFIX)/include/$(lib:lib%.a=%.h)

.PHONY: clean

clean:
	rm -f $(bin) $(obj) $(lib:lib%.a=%.o)