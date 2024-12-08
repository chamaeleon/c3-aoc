module aoc::y2024::day07;
import aoc::utils;
import std::io;

fn int128 apply_1(int128 target, int128 accum, int128[] values)
{
    if (target == accum && values.len == 0) {
        return target;
    } else if (accum > target || values.len == 0) {
        return 0;
    } else {
        if (apply_1(target, accum + values[0], values[1..])) {
            return target;
        } else if (apply_1(target, accum * values[0], values[1..])) {
            return target;
        } else {
            return 0;
        }
    }
}

fn int128! process_1(String line)
{
    @pool()
    {
        String[] parts = line.tsplit(":");
        int128 target = parts[0].to_int128()!;
        String[] values_str = (parts[1]).trim().tsplit(" ");
        int128* values = mem::temp_new(int128, values_str.len);
        int128 sum;

        for (int i = 0; i < values_str.len; i++) {
            values[i] = values_str[i].to_int128()!;
        }

        return apply_1(target, 0, values[0..values_str.len-1]);
    };
}

fn String! part1()
{
    String[] lines = utils::get_lines("input/y2024/day07.txt")!;
    int128 sum;

    foreach (line : lines) {
        sum += process_1(line)!;
    }

    return string::tformat("%s", sum);
}

fn int128 concat(int128 a, int128 b) {
    int128 b_tmp = b;

    if (b > 0) {
        while (b_tmp > 0) {
            b_tmp /= 10;
            a *= 10;
        }
        return a + b;
    } else {
        return a * 10;
    }
}

fn int128 apply_2(int128 target, int128 accum, int128[] values)
{
    if (target == accum && values.len == 0) {
        return target;
    } else if (accum > target || values.len == 0) {
        return 0;
    } else {
        if (apply_2(target, accum + values[0], values[1..])) {
            return target;
        } else if (apply_2(target, accum * values[0], values[1..])) {
            return target;
        } else if (apply_2(target, concat(accum, values[0]), values[1..])) {
            return target;
        } else {
            return 0;
        }
    }
}

fn int128! process_2(String line)
{
    @pool()
    {
        String[] parts = line.tsplit(":");
        int128 target = parts[0].to_int128()!;
        String[] values_str = (parts[1]).trim().tsplit(" ");
        int128* values = mem::temp_new(int128, values_str.len);
        int128 sum;

        for (int i = 0; i < values_str.len; i++) {
            values[i] = values_str[i].to_int128()!;
        }

        return apply_2(target, 0, values[0..values_str.len-1]);
    };
}

fn String! part2()
{
    String[] lines = utils::get_lines("input/y2024/day07.txt")!;
    int128 sum;

    foreach (line : lines) {
        sum += process_2(line)!;
    }

    return string::tformat("%s", sum);
}
