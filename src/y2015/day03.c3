module aoc::y2015::day03;
import aoc::utils;
import std::collections::map;
import std::io;

struct Position
{
    int x;
    int y;
}

fn uint Position.hash(&self)
{
    return self.x.hash() ^ self.y.hash();
}

fn bool Position.equals(&self, Position other)
{
    return self.x == other.x && self.y == other.y;
}

def Houses = HashMap(<Position, int>);

fn void deliver(Houses *houses, Position pos)
{
    int presents = houses.@get_or_set(pos, 0);
    houses.set(pos, presents+1);
}

fn Position move(Houses *houses, Position pos, char dir)
{
    switch (dir) {
        case '<':
            pos.x -= 1;
            deliver(houses, pos);
        case '>':
            pos.x += 1;
            deliver(houses, pos);
        case '^':
            pos.y += 1;
            deliver(houses, pos);
        case 'v':
            pos.y -= 1;
            deliver(houses, pos);
    }

    return pos;
}

fn String! part1()
{
    String input = utils::slurp("input/y2015/day03.txt")!;
    Position pos;
    Houses houses;

    houses.temp_init();

    foreach (dir : input) {
        pos = move(&houses, pos, dir);
    }

    return string::tformat("%s", houses.len());
}

fn String! part2()
{
    String input = utils::slurp("input/y2015/day03.txt")!;
    Position santa;
    Position robo_santa;
    Houses houses;
    bool move_santa = true;

    houses.temp_init();

    foreach (dir : input) {
        if (move_santa) {
            santa = move(&houses, santa, dir);
        } else {
            robo_santa = move(&houses, robo_santa, dir);
        }

        move_santa = !move_santa;
    }

    return string::tformat("%d", houses.len());
}
