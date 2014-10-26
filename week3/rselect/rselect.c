/*
 * =====================================================================================
 *
 *       Filename:  quicksort.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  23/10/14 22:14:22
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (draganglumac), dragan.glumac@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "rselect.h"

int kwikselect(int *array, int first, int last, int order); 
int choose_pivot(int *array, int first, int last);
void swap(int *array, int i, int j);
int partition(int *array, int first, int last);

int rselect(int *array, int size, int order) {
	if (array == 0 || size <= 0) {
		return -1;
	}
	return kwikselect(array, 0, size - 1, order - 1);
}
int kwikselect(int *array, int first, int last, int order) {
	if (first >= last) {
		return array[first];
	}
	int pivot = partition(array, first, last);
	if (pivot == order) {
		return array[pivot];
	}
	else if (pivot > order) {
		return kwikselect(array, first, pivot - 1, order);
	}
	else {
		return kwikselect(array, pivot + 1, last, order);
	}
}
int choose_random(int *array, int first, int last) {
	int pivot = first;
	if (last - first > 1) {
		srand(time(0));	
		pivot = first + rand() % (last - first);
	}
	return pivot;
}
int choose_pivot(int *array, int first, int last) {
	return choose_random(array, first, last);
}
void swap(int *array, int i, int j) {
	if (i != j) {
		array[i] += array[j];
		array[j] = array[i] - array[j];
		array[i] -= array[j];
	}
}
int partition(int *array, int first, int last) {
	int pivot = choose_pivot(array, first, last);
	if (pivot != first) {
		swap(array, first, pivot);
	}
	int i = first + 1, j = first + 1;
	while (j <= last) {
		if (array[j] < array[first]) {
			swap(array, i, j);
			i++;
		}
		j++;
	}
	pivot = i - 1;
	swap(array, first, pivot);
	return pivot;
}
