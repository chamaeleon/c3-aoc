module aoc::y2024::day10;
import aoc::utils;
import std::io;
import std::collections;

enum Direction : int (int[<2>] offset)
{
    UP = { 0, -1 },
    RIGHT = { 1, 0 },
    DOWN = { 0, 1 },
    LEFT = { -1, 0 }
}

struct Map
{
    usz rows;
    usz cols;
    int *cells;
}

fn int Map.get(self, usz row, usz col)
{
    return self.cells[row * self.cols + col];
}

fn void Map.set(self, usz row, usz col, int n)
{
    self.cells[row * self.cols + col] = n;
}

fn void Map.free(self)
{
    free(self.cells);
}

def Position = int[<2>];
def Positions = List(<Position>);

fn void Position.move(&self, int row, int col)
{
    self.x += col;
    self.y += row;
}

fn void! make_map(String[] input, Map *map)
{
    map.rows = input.len;
    map.cols = input[0].len;
    map.cells = mem::new_array(int, map.rows*map.cols);

    for (usz row = 0; row < map.rows; row++) {
        usz cols = input[row].len;
        for (usz col = 0; col < map.cols; col++) {
            map.set(row, col, input[row][col]-'0');
        }
    }
}

fn Positions find_trailheads(Map *map)
{
    Positions trailheads;
    
    trailheads.temp_init();

    for (int row = 0; row < map.rows; row++) {
        for (int col = 0; col < map.cols; col++) {
            if (map.get(row, col) == 0) {
                trailheads.push({row, col});
            }
        }
    }

    return trailheads;
}

def Reached = HashMap(<Position, int>);

fn int count_distinct(Map *map, Reached *reached, int steps, Position position)
{
    if (steps > 9) return 0;
    if (position.x < 0 || position.x >= map.cols) return 0;
    if (position.y < 0 || position.y >= map.rows) return 0;
    if (steps == 9 && map.get(position.x, position.y) == 9) {
        reached.set(position, 1);
        return 1;
    }
    if (map.get(position.x, position.y) != steps) return 0;

    int sum;

    sum += count_distinct(map, reached, steps+1, position + Direction.UP.offset);
    sum += count_distinct(map, reached, steps+1, position + Direction.RIGHT.offset);
    sum += count_distinct(map, reached, steps+1, position + Direction.DOWN.offset);
    sum += count_distinct(map, reached, steps+1, position + Direction.LEFT.offset);

    return sum;
}

fn int count_paths(Map *map, int steps, Position position)
{
    if (steps > 9) return 0;
    if (position.x < 0 || position.x >= map.cols) return 0;
    if (position.y < 0 || position.y >= map.rows) return 0;
    if (steps == 9 && map.get(position.x, position.y) == 9) {
        return 1;
    }
    if (map.get(position.x, position.y) != steps) return 0;

    int sum;

    sum += count_paths(map, steps+1, position + Direction.UP.offset);
    sum += count_paths(map, steps+1, position + Direction.RIGHT.offset);
    sum += count_paths(map, steps+1, position + Direction.DOWN.offset);
    sum += count_paths(map, steps+1, position + Direction.LEFT.offset);

    return sum;
}

fn String! part1()
{
    String[] input = utils::get_lines("input/y2024/day10.txt")!;
    Map map;
    int sum;

    make_map(input, &map)!;

    Positions trailheads = find_trailheads(&map);
    Reached reached;

    reached.temp_init();

    foreach (trailhead : trailheads) {
        int count = count_distinct(&map, &reached, 0, trailhead);
        sum += reached.count;
        reached.clear();
    }

    map.free();

    return string::tformat("%d", sum);
}

fn String! part2()
{
    String[] input = utils::get_lines("input/y2024/day10.txt")!;
    Map map;
    int sum;

    make_map(input, &map)!;

    Positions trailheads = find_trailheads(&map);

    foreach (trailhead : trailheads) {
        sum += count_paths(&map, 0, trailhead);
    }

    map.free();

    return string::tformat("%d", sum);
}
