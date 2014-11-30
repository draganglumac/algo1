/*
 * =====================================================================================
 *
 *       Filename:  graph_test.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  30/11/14 07:35:09
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (draganglumac), dragan.glumac@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */
#include "graph.h"
#include "CppUnitLite/TestHarness.h"

TEST(Graph, empty_graph)
{
	Graph g;
	int size;
	int *nodes = g.nodes(size); 
	LONGS_EQUAL(0, size);
	CHECK(nodes == NULL);
}
