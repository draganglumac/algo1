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

using namespace std;

TEST(Graph, empty_graph)
{
	Graph g;
	LONGS_EQUAL(0, g.num_nodes());
}
TEST(Graph, single_node)
{
	Graph g;
	g.add_node(0);

	LONGS_EQUAL(1, g.num_nodes());
	LONGS_EQUAL(0, g.edges_for_node(0).size());
}
TEST(Graph, disconnected_nodes)
{
	Graph g;
	g.add_node(3);

	LONGS_EQUAL(4, g.num_nodes());
	for (int i=0; i < 4; i++) {
		LONGS_EQUAL(0, g.edges_for_node(i).size());
	}
}
TEST(Graph, undirected_node_one_edge)
{
	Graph g;
	g.add_node(1);
	g.add_edge_to_node(0, 1);

	LONGS_EQUAL(2, g.num_nodes());

	LONGS_EQUAL(1, g.edges_for_node(0).size());
	list<int>& edges = g.edges_for_node(0);
	LONGS_EQUAL(1, *edges.begin());

	LONGS_EQUAL(0, g.edges_for_node(1).size());
}
TEST(Graph, directed_node_one_edge)
{
	Graph g;
	g.add_node(1);
	g.add_edge_to_node(0, 1);
	g.add_edge_to_node(1, 0);

	LONGS_EQUAL(2, g.num_nodes());
	
	list<int>& edges = g.edges_for_node(0);
	LONGS_EQUAL(1, edges.size());
	LONGS_EQUAL(1, *edges.begin());

	edges = g.edges_for_node(1);
	LONGS_EQUAL(1, edges.size());
	LONGS_EQUAL(0, *edges.begin());	
}
TEST(Graph, directed_graph)
{
	Graph g;
	g.add_node(2);
	g.add_edge_to_node(0, 1);
	g.add_edge_to_node(0, 2);
	g.add_edge_to_node(1, 2);

	LONGS_EQUAL(2, g.edges_for_node(0).size());
	LONGS_EQUAL(1, g.edges_for_node(1).size());
	LONGS_EQUAL(0, g.edges_for_node(2).size());

	LONGS_EQUAL(2, *g.edges_for_node(1).begin());
	list<int>& edges = g.edges_for_node(0);
	int i = 1;
	for (list<int>::iterator it = edges.begin(); it != edges.end(); i++, it++) {
		LONGS_EQUAL(i, *it);
	}
}
TEST(Graph, undirected_graph)
{
	Graph g;
	g.add_node(2);
	g.add_edge_to_node(0, 1);
	g.add_edge_to_node(0, 2);
	g.add_edge_to_node(1, 0);
	g.add_edge_to_node(1, 2);
	g.add_edge_to_node(2, 0);
	g.add_edge_to_node(2, 1);

	LONGS_EQUAL(2, g.edges_for_node(0).size());
	LONGS_EQUAL(2, g.edges_for_node(1).size());
	LONGS_EQUAL(2, g.edges_for_node(2).size());
	
	list<int> edges = g.edges_for_node(0);
	LONGS_EQUAL(1, *edges.begin());
	LONGS_EQUAL(2, *(++edges.begin()));

	edges = g.edges_for_node(1);
	LONGS_EQUAL(0, *edges.begin());
	LONGS_EQUAL(2, *(++edges.begin()));

	edges = g.edges_for_node(2);
	LONGS_EQUAL(0, *edges.begin());
	LONGS_EQUAL(1, *(++edges.begin()));
}
TEST(Graph, bfs)
{
	LONGS_EQUAL(0, 1);
}
TEST(Graph, dfs)
{
	LONGS_EQUAL(0, 1);
}
