/*
 * =====================================================================================
 *
 *       Filename:  main.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  23/10/2014 14:27:12
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (), 
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "quicksort.h"

void assert_array_sorted(int *array, int size) {
	int i;
	for (i = 0; i < size-2; i++) {
		assert(array[i] <= array[i + 1]);
	}
}
void pretty_print(int *a, int size, int comparisons) {
    printf("Stats:\n");
    printf("--------------------\n");
    printf("%s: %13d\n", "First", a[0]);
    printf("%s: %12d\n", "Middle", a[size/2 - 1]);
    printf("%s: %14d\n", "Last", a[size - 1]);
    printf("--------------------\n");
    printf("%s: %14d\n", "Size", size);
    printf("--------------------\n");
	printf("%s: %7d\n", "Comparisons", comparisons);
}
int determine_size(char *filename) {
	char line[16];
	int num_lines = 0;
	FILE *f = fopen(filename, "r");
	while (fgets(line, sizeof line, f) != NULL) {
		num_lines++;
	}
	fclose(f);
	return num_lines;
}
int array_from_file(int **array, char *filename) {
	int size = determine_size(filename);
	*array = malloc(sizeof(int) * size);
	char line[16];
	FILE *f = fopen(filename, "r");
	int next_index = 0, next_number;
	while (fgets(line, sizeof line, f) != NULL) {
		next_number = atoi(line);
		(*array)[next_index] = next_number;
		next_index++;
	}
	fclose(f);
	return next_index;
}
int main() {
	int *array;
	int size = 0;
//	size = array_from_file(&array, "IntegerArray.txt");
//	size = array_from_file(&array, "IntegerArraySmall.txt");
	size = array_from_file(&array, "QuickSort.txt");
//	size = array_from_file(&array, "10.txt");
//	size = array_from_file(&array, "100.txt");
//	size = array_from_file(&array, "1000.txt");
//	size = array_from_file(&array, "QuickSort100.txt");
//	size = array_from_file(&array, "QuickSort1000.txt");
	int comparisons = 0;
	quicksort(array, size, &comparisons);
	assert_array_sorted(array, size);
	pretty_print(array, size, comparisons);
	return 0;
}
