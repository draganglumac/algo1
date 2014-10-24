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
#include "quicksort.h"

void kwiksort(int *array, int first, int last); 
int choose_pivot(int *array, int first, int last);
void swap(int *array, int i, int j);
int partition(int *array, int first, int last);

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
int choose_first(int *array, int first, int last) {
	return first;
}
int choose_last(int *array, int first, int last) {
	return last;
}
int calculate_midpoint(int first, int last) {
	int size = last - first + 1;
	if (size % 2 == 0) {
		return first + size/2 - 1;
	}
	else {
		return first + size/2;
	}
}
int choose_median_of_three(int *array, int first, int last) {
	if (last - first > 1) {
		int smallest = first, median = first;
		int midpoint = calculate_midpoint(first, last);
		if (array[first] < array[midpoint]) {
			median = midpoint;
		}
		else {
			smallest = midpoint;
		}
		if (array[last] < array[smallest]) {
			median = smallest;
		}
		else if (array[last] < array[median]) {
			median = last;
		}
		return median;
	}
	else {
		return first;
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
//	return choose_first(array, first, last);
//	return choose_last(array, first, last);
//	return choose_median_of_three(array, first, last);
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
