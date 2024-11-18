module aoc::y2015::day05;
import aoc::utils;
import std::io;

const char[] VOWELS = {'a', 'e', 'i', 'o', 'u'};

fn int vowel_count(String s)
{
    int count;

    foreach (ch : s) {
        foreach (vowel : VOWELS) {
            if (ch == vowel) {
                count++;
                break;
            }
        }
    }

    return count;
}

fn bool nice_part1(String s)
{
    return
        vowel_count(s) >= 3 &&
        utils::match("(.)\\1", s) &&
        !utils::match("(ab)|(cd)|(pq)|(xy)", s);
}

fn bool nice_part2(String s)
{
    return utils::match("(.)(.).*\\1\\2", s) && utils::match("(.).\\1", s);
}

fn String! part1()
{
    String[] input = utils::get_lines("input/y2015/day05.txt")!;
    int nice;
    int line_count;

    foreach (line : input) {
        if (nice_part1(line)) {
            nice++;
        }
        line_count++;
    }

    return string::tformat("%d", nice);
}

fn String! part2()
{
    String[] input = utils::get_lines("input/y2015/day05.txt")!;
    int nice;
    int line_count;

    foreach (line : input) {
        if (nice_part2(line)) {
            nice++;
        }
        line_count++;
    }

    return string::tformat("%d", nice);
}
