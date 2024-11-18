module aoc::y2015::day06;
import aoc::utils;
import std::io;

enum Command
{
    TURN_ON,
    TURN_OFF,
    TOGGLE,
}

fn void swap(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

fn void! apply_cmd_part1(bool* grid, String line)
{
    String[] groups;
    Command cmd;

    if (try g = utils::get_groups("turn on ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)", line)) {
        cmd = TURN_ON;
        groups = g;
    } else if (try g = utils::get_groups("turn off ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)", line)) {
        cmd = TURN_OFF;
        groups = g;
    } else if (try g = utils::get_groups("toggle ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)", line)) {
        cmd = TOGGLE;
        groups = g;
    } else {
        return;
    }

    int x1 = groups[0].to_int()!;
    int y1 = groups[1].to_int()!;
    int x2 = groups[2].to_int()!;
    int y2 = groups[3].to_int()!;

    if (x1 > x2) swap(&x1, &x2);
    if (y1 > y2) swap(&y1, &y2);

    for (int row = y1; row <= y2; row++) {
        for (int col = x1; col <= x2; col++) {
            switch (cmd) {
            case Command.TURN_ON:
                grid[row*1000+col] = true;
            case Command.TURN_OFF:
                grid[row*1000+col] = false;
            case Command.TOGGLE:
                grid[row*1000+col] = !grid[row*1000+col];
            }
        }
    }
}

fn void! apply_cmd_part2(int* grid, String line)
{
    String[] groups;
    Command cmd;

    if (try g = utils::get_groups("turn on ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)", line)) {
        cmd = TURN_ON;
        groups = g;
    } else if (try g = utils::get_groups("turn off ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)", line)) {
        cmd = TURN_OFF;
        groups = g;
    } else if (try g = utils::get_groups("toggle ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)", line)) {
        cmd = TOGGLE;
        groups = g;
    } else {
        return;
    }

    int x1 = groups[0].to_int()!;
    int y1 = groups[1].to_int()!;
    int x2 = groups[2].to_int()!;
    int y2 = groups[3].to_int()!;

    if (x1 > x2) swap(&x1, &x2);
    if (y1 > y2) swap(&y1, &y2);

    for (int row = y1; row <= y2; row++) {
        for (int col = x1; col <= x2; col++) {
            switch (cmd) {
            case Command.TURN_ON:
                grid[row*1000+col]++;
            case Command.TURN_OFF:
                grid[row*1000+col]--;
                if (grid[row*1000+col] < 0) grid[row*1000+col] = 0;
            case Command.TOGGLE:
                grid[row*1000+col] += 2;
            }
        }
    }
}

fn String! part1()
{
    String[] input = utils::get_lines("input/y2015/day06.txt")!;
    bool* grid = mem::temp_new_array(bool, 1000*1000);
    int lit;

    foreach (line : input) {
        apply_cmd_part1(grid, line)!;
    }

    for (int row = 0; row < 1000; row++) {
        for (int col = 0; col < 1000; col++) {
            if (grid[row*1000+col]) lit++;
        }
    }

    return string::tformat("%d", lit);
}

fn String! part2()
{
    String[] input = utils::get_lines("input/y2015/day06.txt")!;
    int* grid = mem::temp_new_array(int, 1000*1000);
    int brightness;

    foreach (line : input) {
        apply_cmd_part2(grid, line)!;
    }

    for (int row = 0; row < 1000; row++) {
        for (int col = 0; col < 1000; col++) {
            brightness += grid[row*1000+col];
        }
    }

    return string::tformat("%d", brightness);
}
