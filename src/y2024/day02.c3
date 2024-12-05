module aoc::y2024::day02;
import aoc::utils;
import std::io;

fn bool safe_numbers(int[] numbers)
{
    if (numbers.len < 2) return true;

    bool ascending = (numbers[0] < numbers[1]);

    for (int i = 0; i < numbers.len-1; i++) {
        int a = numbers[i];
        int b = numbers[i+1];

        if (ascending) {
            if (a >= b || (b - a) > 3) return false;
        } else {
            if (a <= b || (a -b ) > 3) return false;
        }
    }

    return true;
}

fn bool mostly_safe_numbers(int[] numbers)
{
    // io::printfn("Mostly safe? %s", numbers);

    if (safe_numbers(numbers)) {
        return true;
    }

    // io::printfn("Not totally safe %s", numbers);

    // int *reduced_numbers = mem::temp_new(int, numbers.len-1);
    int[100] reduced_numbers;

    // io::printfn("Reducing %s", numbers);
    for (int i = 0; i < numbers.len; i++) {
        int pos = 0;
        for (int j = 0; j < numbers.len; j++) {
            if (j != i) {
                reduced_numbers[pos++] = numbers[j];
            }
        }
        // io::printfn("... Checking reduced %s", reduced_numbers[:numbers.len-1]);
        if (safe_numbers(reduced_numbers[:numbers.len-1])) {
            return true;
        }
    }

    return false;
}

fn String! part1()
{
    String[] lines = utils::get_lines("input/y2024/day02.txt")!;
    int safe;

    foreach (line : lines) {
        @pool() {
            String[] parts = line.tsplit(" ");
            int* numbers = mem::temp_new(int, parts.len);
            for (int i = 0; i < parts.len; i++) {
                numbers[i] = parts[i].to_int()!;
            }
            if (safe_numbers(numbers[:parts.len])) safe++;
        };
    }

    return string::tformat("%d", safe);
}

fn String! part2()
{
    String[] lines = utils::get_lines("input/y2024/day02.txt")!;
    int safe;

    foreach (line : lines) {
        @pool() {
            String[] parts = line.tsplit(" ");
            // io::printfn("String parts %s", parts);
            int* numbers = mem::temp_new(int, parts.len);
            for (int i = 0; i < parts.len; i++) {
                numbers[i] = parts[i].to_int()!;
            }
            if (mostly_safe_numbers(numbers[:parts.len])) safe++;
        };
    }

    return string::tformat("%d", safe);
}
