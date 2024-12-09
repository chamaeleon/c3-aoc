module aoc::y2024::day08;
import aoc::utils;
import std::io;
import std::collections;

def Location = int[<2>];

fn bool Location.equals(self, Location other)
{
    return self == other;
}

fn int Location.hash(self)
{
    return self.x.hash() + self.y.hash();
}

struct Node
{
    char frequency;
    Location location;
}

def NodeList = List(<Node>);
def AntinodesMap = HashMap(<Location, bool>);

fn void parse_input(String[] lines, NodeList* nodes)
{
    foreach (int y, line : lines) {
        foreach (int x, frequency : line) {
            if (frequency != '.') {
                nodes.push({frequency, {x, y}});
            }
        }
    }
}

fn int count_antinodes(NodeList* nodes, int rows, int cols, bool repeat)
{
    AntinodesMap antinodes;

    antinodes.temp_init();

    for (int i = 0; i < nodes.len(); i++) {
        for (int j = i + 1; j < nodes.len(); j++) {
            Node a = nodes.get(i);
            Node b = nodes.get(j);

            if (a.frequency == b.frequency) {
                if (repeat) {
                    antinodes[a.location] = true;
                    antinodes[b.location] = true;
                }

                Location diff = a.location - b.location;
                int iteration = 1;
                
                while (true) {
                    Location anti1 = a.location + iteration*diff;
                    Location anti2 = b.location - iteration*diff;
                    bool added = false;

                    if (anti1.x >= 0 && anti1.x < cols && anti1.y >= 0 && anti1.y < rows) {
                        antinodes[anti1] = true;
                        added = true;
                    }
                    if (anti2.x >= 0 && anti2.x < cols && anti2.y >= 0 && anti2.y < rows) {
                        antinodes[anti2] = true;
                        added = true;
                    }

                    if (!repeat || !added) break;

                    iteration++;
                }
            }
        }
    }

    return (int)antinodes.len();
}

fn String! part1()
{
    String[] lines = utils::get_lines("input/y2024/day08.txt")!;
    NodeList nodes;
    int antinodes;

    nodes.temp_init();
    parse_input(lines, &nodes);
    antinodes = count_antinodes(&nodes, lines.len, lines[0].len, false);

    return string::tformat("%d", antinodes);
}

fn String! part2()
{
    String[] lines = utils::get_lines("input/y2024/day08.txt")!;
    NodeList nodes;
    int antinodes;

    nodes.temp_init();
    parse_input(lines, &nodes);
    antinodes = count_antinodes(&nodes, lines.len, lines[0].len, true);

    return string::tformat("%d", antinodes);
}
