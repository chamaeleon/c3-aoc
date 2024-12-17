module aoc::y2024::day11;
import aoc::utils;
import aoc::map;
import std::io;
import std::collections;
import libc;

def Stones = List(<long>);
def StoneKey = long[<2>];
def BlinkMap = HashMap(<StoneKey, long>);

fn uint StoneKey.hash(self)
{
    return self[0].hash() + self[1].hash();
}

fn long to_long(String s) {
    return s.to_long()!!;
}

fn bool even_digits(long stone, char[64] *str)
{
    libc::snprintf(str, 64, "%lld", stone);

    return ((ZString)str).len() % 2 == 0;
}

fn long count_stones(BlinkMap *blink_map, int blinks, long stone)
{
    char[64] str;

    if (blinks == 0) {
        return 1;
    }
    StoneKey key = {blinks, stone};
    if (try count = blink_map.get(key)) {
        return count;
    }
    if (stone == 0) {
        long count = count_stones(blink_map, blinks-1, 1);
        blink_map.set(key, count);
        return count;
    } else if (even_digits(stone, &str)) {
        usz digits = ((ZString)&str).len();
        int splitter = 1;

        for (usz i = 0; i < digits/2; i++) splitter *= 10;

        long left = stone / splitter;
        long right = stone % splitter;

        long left_count = count_stones(blink_map, blinks-1, left);
        long right_count = count_stones(blink_map, blinks-1, right);

        blink_map.set(key, left_count + right_count);

        return left_count + right_count;
    } else {
        long count = count_stones(blink_map, blinks-1, 2024 * stone);
        blink_map.set(key, count);
        return count;
    }
}

fn String! part1()
{
    String input = utils::slurp("input/y2024/day11.txt")!;
    Stones stones = map::map_slice(<String, long>)(&to_long, input.split(" "));
    BlinkMap blink_map;
    long sum;

    blink_map.temp_init();

    foreach (stone : stones) {
        sum += count_stones(&blink_map, 25, stone);
    }

    return string::tformat("%d", sum);
}

fn String! part2()
{
    String input = utils::slurp("input/y2024/day11.txt")!;
    Stones stones = map::map_slice(<String, long>)(&to_long, input.split(" "));
    BlinkMap blink_map;
    long sum;

    blink_map.temp_init();

    foreach (stone : stones) {
        sum += count_stones(&blink_map, 75, stone);
    }

    return string::tformat("%d", sum);
}
