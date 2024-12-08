module aoc::y2024::day06;
import aoc::utils;
import std::io;
import std::collections;

fault Day06Fault
{
    INVALID_START_POSITION
}

enum Direction { UP, RIGHT, DOWN, LEFT }

struct Position
{
    Direction dir;
    int row;
    int col;
}

def PositionList = List(<Position>);

fn Position! find_guard(String[] map)
{
    foreach (int row, line : map) {
        foreach (int col, ch : line) {
            if (ch == '^') {
                return {UP, row, col};
            }
        }
    }

    return Day06Fault.INVALID_START_POSITION?;
}

fn void move(String[] map, Position guard, PositionList *positions)
{
    while (true) {
        map[guard.row][guard.col] = 'X';
        positions.push(guard);

        switch (guard.dir) {
        case UP:
            if (guard.row-1 < 0) return;
            if (map[guard.row-1][guard.col] == '#') {
                guard.dir = RIGHT;
            } else {
                guard.row--;
            }
        case RIGHT:
            if (guard.col+1 >= map[guard.row].len) return;
            if (map[guard.row][guard.col+1] == '#') {
                guard.dir = DOWN;
            } else {
                guard.col++;
            }
        case DOWN:
            if (guard.row+1 >= map.len) return;
            if (map[guard.row+1][guard.col] == '#') {
                guard.dir = LEFT;
            } else {
                guard.row++;
            }
        case LEFT:
            if (guard.col-1 < 0) return;
            if (map[guard.row][guard.col-1] == '#') {
                guard.dir = UP;
            } else {
                guard.col--;
            }
        }
    }
}

fn String! part1()
{
    String[] map = utils::get_lines("input/y2024/day06.txt")!;
    PositionList positions;
    Position guard = find_guard(map)!;
    int visited;

    positions.temp_init();

    move(map, guard, &positions);

    foreach (row : map) {
        foreach (ch : row) {
            if (ch == 'X') visited++;
        }
    }

    return string::tformat("%d", visited);
}

fn void debug(Position a, Position b)
{
    io::printfn("%5s %d %d  X  %5s %d %d", a.dir, a.row, a.col, b.dir, b.row, b.col);
}

fn bool found(PositionList *positions, Position start)
{

    return false;
}

struct Obstruction
{
    int row;
    int col;
}

fn int Obstruction.hash(self)
{
    return self.row*317+self.col;
}

fn bool Obstruction.equals(self, Obstruction other)
{
    return self.row == other.row && self.col == other.col;
}

def Obstructions = HashMap(<Obstruction, bool>);

fn String! part2()
{
    String[] map = utils::get_lines("input/y2024/small06.txt")!;
    PositionList positions;
    Obstructions obstructions;
    Position guard = find_guard(map)!;
    int candidates;

    positions.temp_init();
    obstructions.temp_init();

    move(map, guard, &positions);

    io::printn();

    for (int i = 0; i < positions.len()-1; i++) {
        Position current = positions[i];
    }

    return string::tformat("%d", candidates);
}
