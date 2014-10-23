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
#include "quicksort.h"

static void kwiksort(int *array, int first, int last); 
static int choose_pivot(int *array, int first, int last);
static void swap(int *array, int i, int j);
static int partition(int *array, int first, int last);

void quicksort(int *array, int size) {
	if (array == 0 || size <= 0) {
		return;
	}

	kwiksort(array, 0, size - 1);
}

void kwiksort(int *array, int first, int last) {
	if (first >= last) {
		return;
	}

	int pivot = partition(array, first, last);
	kwiksort(array, first, pivot - 1);
	kwiksort(array, pivot + 1, last);
}

static int choose_first(int *array, int first, int last) {
	return first;
}

static int choose_last(int *array, int first, int last) {
	return last;
}

static int choose_median_of_three(int *array, int first, int last) {
	return -1;
}

static int choose_random(int *array, int first, int last) {
	return -1;
}

int choose_pivot(int *array, int first, int last) {
	return choose_first(array, first, last);
	//	return choose_last(array, first, last);
	//	return choose_median_of_three(array, first, last);
	//	return choose_random(array, first, last);
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

	int i = 0, j = 0;
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
