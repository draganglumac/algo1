TEST_HARNESS=..
TESTS=StackTest.cpp StackMain.cpp

test_harnes:
	for cpp_file in $(TEST_HARNESS)/*.cpp; do \
		g++ -c -Wno-write-strings $$cpp_file; \
	done

test: test_harnes $(TESTS)
	g++ -g -o test -I.. *.o $(TESTS)
	./test
	rm test *.o

