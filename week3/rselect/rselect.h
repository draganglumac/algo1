/*
 * =====================================================================================
 *
 *       Filename:  quicksort.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  23/10/2014 14:28:35
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (), 
 *   Organization:  
 *
 * =====================================================================================
 */

#ifndef __QUICKSORT_H__
#define __QUICKSORT_H__

typedef enum { FIRST, LAST, MEDIAN, RANDOM } pivot_strategy;

void rselect(int *a, int size, int *comparisons);

#endif // __QUICKSORT_H__
