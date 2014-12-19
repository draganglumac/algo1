MAIN=main.cpp
SRC=graph.cpp
TESTS=driver.cpp graph_test.cpp
TEST_FRAMEWORK=CppUnitLite/*.cpp
OBJECTS:=$(wildcard *.o)

all: clean $(SRC) $(MAIN)
	c++ -o graph $(SRC) $(MAIN)

clean: $(OBJECTS) graph 
	rm $(OBJECTS) graph

.PHONY: test
test: 
	mkdir -p build
	cd test && for f in $(TESTS); do cp $$f ../build/; done
	for f in $(SRC); do cp $$f build/; done
	cd build && c++ -I.. -Wno-format -Wno-write-strings -o driver ../$(TEST_FRAMEWORK) $(TESTS) $(SRC)
	build/driver
	rm -rf build

