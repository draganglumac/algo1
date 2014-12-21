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
void construct_graph(Graph &g)
{
	g.add_node(7);
	g.add_edge_to_node(0, 1);
	g.add_edge_to_node(0, 2);
	g.add_edge_to_node(0, 3);
	g.add_edge_to_node(1, 4);
	g.add_edge_to_node(2, 5);
	g.add_edge_to_node(3, 6);
	g.add_edge_to_node(4, 7);
	g.add_edge_to_node(5, 7);
	g.add_edge_to_node(6, 7);
}
void construct_another_graph(Graph &g) {
	g.add_node(6);
	g.add_edge_to_node(0, 1);
	g.add_edge_to_node(0, 3);
	g.add_edge_to_node(0, 5);
	g.add_edge_to_node(1, 2);
	g.add_edge_to_node(1, 3);
	g.add_edge_to_node(2, 4);
	g.add_edge_to_node(3, 5);
	g.add_edge_to_node(4, 3);
	g.add_edge_to_node(4, 6);
	g.add_edge_to_node(5, 6);
}
void construct_cycle(Graph &g) {
	g.add_node(4);
	g.add_edge_to_node(0, 1);
	g.add_edge_to_node(1, 2);
	g.add_edge_to_node(2, 3);
	g.add_edge_to_node(2, 4);
	g.add_edge_to_node(3, 1);
}
TEST(Graph, bfs)
{
	Graph g;
	construct_graph(g);
	
	vector<int> v;
	g.bfs(0, v);

	LONGS_EQUAL(v.size(), 8);
	LONGS_EQUAL(v[0], 0);
	LONGS_EQUAL(v[1], 1);
	LONGS_EQUAL(v[2], 2);
	LONGS_EQUAL(v[3], 3);
	LONGS_EQUAL(v[4], 4);
	LONGS_EQUAL(v[5], 5);
	LONGS_EQUAL(v[6], 6);
	LONGS_EQUAL(v[7], 7);

	v.clear();
	g.bfs(1, v);

	LONGS_EQUAL(v.size(), 3);
	LONGS_EQUAL(v[0], 1);
	LONGS_EQUAL(v[1], 4);
	LONGS_EQUAL(v[2], 7);

	Graph g2;
	construct_another_graph(g2);

	v.clear();
	g2.bfs(0, v);

	LONGS_EQUAL(v.size(), 7);
	LONGS_EQUAL(v[0], 0);
	LONGS_EQUAL(v[1], 1);
	LONGS_EQUAL(v[2], 3);
	LONGS_EQUAL(v[3], 5);
	LONGS_EQUAL(v[4], 2);
	LONGS_EQUAL(v[5], 6);
	LONGS_EQUAL(v[6], 4);

	v.clear();
	g2.bfs(1, v);

	LONGS_EQUAL(v.size(), 6);
	LONGS_EQUAL(v[0], 1);
	LONGS_EQUAL(v[1], 2);
	LONGS_EQUAL(v[2], 3);
	LONGS_EQUAL(v[3], 4);
	LONGS_EQUAL(v[4], 5);
	LONGS_EQUAL(v[5], 6);

	Graph c;
	construct_cycle(c);

	v.clear();
	c.bfs(0, v);

	LONGS_EQUAL(v.size(), 5);
	LONGS_EQUAL(v[0], 0);
	LONGS_EQUAL(v[1], 1);
	LONGS_EQUAL(v[2], 2);
	LONGS_EQUAL(v[3], 3);
	LONGS_EQUAL(v[4], 4);

	v.clear();
	c.bfs(4, v);

	LONGS_EQUAL(v.size(), 1);
	LONGS_EQUAL(v[0], 4);
}
TEST(Graph, dfs)
{
	Graph g;
	construct_graph(g);
	
	vector<int> v;
	g.dfs(0, v);

	LONGS_EQUAL(v.size(), 8);
	LONGS_EQUAL(v[0], 0);
	LONGS_EQUAL(v[1], 1);
	LONGS_EQUAL(v[2], 4);
	LONGS_EQUAL(v[3], 7);
	LONGS_EQUAL(v[4], 2);
	LONGS_EQUAL(v[5], 5);
	LONGS_EQUAL(v[6], 3);
	LONGS_EQUAL(v[7], 6);

	v.clear();
	g.dfs(1, v);

	LONGS_EQUAL(v.size(), 3);
	LONGS_EQUAL(v[0], 1);
	LONGS_EQUAL(v[1], 4);
	LONGS_EQUAL(v[2], 7);

	Graph g2;
	construct_another_graph(g2);
	
	v.clear();
	g2.dfs(0, v);
	
	LONGS_EQUAL(v.size(), 7);
	LONGS_EQUAL(v[0], 0);
	LONGS_EQUAL(v[1], 1);
	LONGS_EQUAL(v[2], 2);
	LONGS_EQUAL(v[3], 4);
	LONGS_EQUAL(v[4], 3);
	LONGS_EQUAL(v[5], 5);
	LONGS_EQUAL(v[6], 6);

	v.clear();
	g2.dfs(1, v);

	LONGS_EQUAL(v.size(), 6);
	LONGS_EQUAL(v[0], 1);
	LONGS_EQUAL(v[1], 2);
	LONGS_EQUAL(v[2], 4);
	LONGS_EQUAL(v[3], 3);
	LONGS_EQUAL(v[4], 5);
	LONGS_EQUAL(v[5], 6);

	Graph c;
	construct_cycle(c);

	v.clear();
	c.dfs(0, v);

	LONGS_EQUAL(v.size(), 5);
	LONGS_EQUAL(v[0], 0);
	LONGS_EQUAL(v[1], 1);
	LONGS_EQUAL(v[2], 2);
	LONGS_EQUAL(v[3], 3);
	LONGS_EQUAL(v[4], 4);

	v.clear();
	c.dfs(4, v);

	LONGS_EQUAL(v.size(), 1);
	LONGS_EQUAL(v[0], 4);
}
