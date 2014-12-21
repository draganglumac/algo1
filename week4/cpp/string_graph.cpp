/*
 * =====================================================================================
 *
 *       Filename:  string_graph.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  21/12/14 10:42:41
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (draganglumac), dragan.glumac@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */
#include "string_graph.h"

using namespace std;

StringGraph::StringGraph() {}
StringGraph::~StringGraph() {}
void StringGraph::add_nodes(const vector<string>& node_names) {
	nodes.assign(node_names.begin(), node_names.end());
	add_node(node_names.size() - 1);
}

