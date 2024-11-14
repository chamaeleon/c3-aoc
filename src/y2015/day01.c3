module aoc::y2015::day01;
import aoc::utils;

fn String! part1()
{
    String input = utils::slurp("input/y2015/day01.txt")!;
    int floor = 0;

    foreach (ch : input) {
        if (ch == '(') { floor++; }
        else if (ch == ')') { floor--; }
    }

    return string::tformat("%d", floor);
}

fn String! part2()
{
    String input = utils::slurp("input/y2015/day01.txt")!;
    int floor = 0;
    int position = 1;
    
    foreach (ch : input) {
        if (ch == '(') { floor++; }
        else if (ch == ')') { floor--; }
        if (floor == -1) break;
        position++;
    }

    return string::tformat("%d", position);
}
