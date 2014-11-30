/*
 * =====================================================================================
 *
 *       Filename:  driver.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  30/11/14 07:37:25
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (draganglumac), dragan.glumac@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */
#include "../CppUnitLite/TestHarness.h"

int main() {
	TestResult tr;
	TestRegistry::runAllTests(tr);
	return 0;
}

