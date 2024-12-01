module aoc::y2024::day01;
import std::io;
import aoc::utils;
import std::collections;
import std::sort;
import std::math;

def IntList = List(<int>);
def Frequency = HashMap(<int, int>);

fn void! get_int_lists(String[] lines, IntList *left, IntList *right)
{
    foreach (line : lines) {
        String[] pair = utils::get_groups("^(\\w+)\\s+(\\w+)$", line)!;
        left.push(pair[0].to_int())!;
        right.push(pair[1].to_int())!;
    }
}

fn String! part1()
{
    String[] lines = utils::get_lines("input/y2024/day01.txt")!;
    IntList left;
    IntList right;

    left.temp_init();
    right.temp_init();

    get_int_lists(lines, &left, &right)!;

    sort::quicksort(left);
    sort::quicksort(right);

    int sum = 0;
    for (int i = 0; i < left.len(); i++) {
        sum += math::abs(left[i] - right[i]);
    }

    return string::tformat("%d", sum);
}

fn String! part2()
{
    String[] lines = utils::get_lines("input/y2024/day01.txt")!;
    IntList left;
    IntList right;
    Frequency frequency;

    left.temp_init();
    right.temp_init();
    frequency.temp_init();

    get_int_lists(lines, &left, &right)!;

    for (int i = 0; i < right.len(); i++) {
        frequency[right[i]] = (frequency[right[i]] ?? 0) + 1;
    }

    int sum;

    for (int i = 0; i < left.len(); i++) {
        sum += left[i] * (frequency[left[i]] ?? 0);
    }

    return string::tformat("%d", sum);
}
