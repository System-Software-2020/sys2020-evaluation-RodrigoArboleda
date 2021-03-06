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
	$(CC) $(CPP_FLAGS) $(C_FLAGS) $(C_FLAGS_BIN) $(obj) -l$(lib:lib%.so=%) \
	-Wl,-rpath='$$ORIGIN' -Wl,-rpath='$$ORIGIN/../lib'  -o $(bin) 


$(lib): $(lib:lib%.so=%.o)
	$(CC) $(C_FLAGS) $(C_FLAGS_LIB) $< -o $(lib)

%.o: %.c
	$(CC) $(CPP_FLAGS) $(C_FLAGS) -c $<


install: $(bin) $(lib) $(lib:lib%.so=%.h)
	mkdir -p $(PREFIX)/bin && cp $(bin) $(PREFIX)/bin/$(bin)
	mkdir -p $(PREFIX)/lib && cp $(lib) $(PREFIX)/lib/$(lib)
	mkdir -p $(PREFIX)/include && cp $(lib:lib%.so=%.h) $(PREFIX)/include/$(lib:lib%.so=%.h)


uninstall:
	rm $(PREFIX)/bin/$(bin)
	rm $(PREFIX)/lib/$(lib)
	rm $(PREFIX)/include/$(lib:lib%.so=%.h)

.PHONY: clean

clean:
	rm -f $(bin) $(obj) $(lib) $(lib:lib%.so=%.o)
