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

#include "rselect.h"

char *filename = 0;
int order = 0;

void assert_ith_order_statistic(int statistic, int i, int array_size) {
	assert(statistic <= array_size);
	assert(statistic == i);
}
void pretty_print(int i, int statistic) {
    printf("%d. order statistic = %d\n", i, statistic);
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
	printf("\trselect.bin -f filename -i order\n\n");
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
		else if (strcmp(argv[i], "-i") == 0) {
			order = atoi((argv[i+1]));
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
	int statistic = rselect(array, size, order);
	assert_ith_order_statistic(statistic, order, size);
	pretty_print(order, statistic);
	return 0;
}
