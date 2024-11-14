module aoc::y2015::day02;
import aoc::utils;
import std::io;
import std::sort;

fn int box(int a, int b, int c)
{
    int area = 0;

    area = 2*a*b + 2*a*c + 2*b*c;
    area += a*b;

    return area;
}

fn int ribbon(int a, int b, int c)
{
    return 2*(a+b) + a*b*c;
}

fn String! part1()
{
    String[] input = utils::get_lines("input/y2015/day02.txt")!;
    int area = 0;

    foreach (line : input) {
        String[] groups = utils::get_groups("([0-9]+)x([0-9]+)x([0-9]+)", line)!;
        int[] dims = {groups[0].to_int()!, groups[1].to_int()!, groups[2].to_int()! };
        sort::quicksort(dims);
        area += box(dims[0], dims[1], dims[2]);
    }

    return string::tformat("%d", area);
}

fn String! part2()
{
    String[] input = utils::get_lines("input/y2015/day02.txt")!;
    int length = 0;

    foreach (line : input) {
        String[] groups = utils::get_groups("([0-9]+)x([0-9]+)x([0-9]+)", line)!;
        int[] dims = {groups[0].to_int()!, groups[1].to_int()!, groups[2].to_int()! };
        sort::quicksort(dims);
        length += ribbon(dims[0], dims[1], dims[2]);
    }

    return string::tformat("%d", length);
}