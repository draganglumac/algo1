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
#include <string.h>
#include <assert.h>

#include "quicksort.h"

char *filename = 0;
pivot_strategy ps = FIRST;

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
void print_usage() {
	printf("Usage:\n");
	printf("\tquick.bin -f filename [-p first | last | median | random]\n\n");
}
void set_pivot_strategy(char *strategy) {
	if (strcmp(strategy, "last") == 0) {
		ps = LAST;
	}
	else if (strcmp(strategy, "median") == 0) {
		ps = MEDIAN;
	}
	else if (strcmp(strategy, "random") == 0) {
		ps = RANDOM;
	}
	else {
		ps = FIRST;
	}
}
void process_command_line_args(int argc, char **argv) {
	if (argc < 2 || argc % 2 == 0) {
		print_usage();
		exit(1);
	}
	int i;
	for (i = 1; i < argc; i += 2) {
		if (strcmp(argv[i], "-f") == 0) {
			filename = argv[i+1];
		}
		else if (strcmp(argv[i], "-p") == 0) {
			set_pivot_strategy(argv[i+1]);
		}
		else {
			print_usage();
			exit(1);
		}
	}	
}
int main(int argc, char **argv) {
	process_command_line_args(argc, argv);
	int *array;
	int size = array_from_file(&array, filename); 
	int comparisons = 0;
	quicksort(array, size, &comparisons);
	assert_array_sorted(array, size);
	pretty_print(array, size, comparisons);
	return 0;
}
