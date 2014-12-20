/*
 * =====================================================================================
 *
 *       Filename:  union_find.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  07/12/14 20:30:36
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (draganglumac), dragan.glumac@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#include "graph.h"

struct UnionFindNode {
	int leader;
}

class UnionFind : public Graph {
	std::vector<UnionFindNode> nodes;
}
