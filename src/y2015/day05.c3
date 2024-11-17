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

fn bool nice_part1(String s, bool debug = false)
{
    if (debug) {
        io::printfn("[%s] Vowel count = %s", s, vowel_count(s));
        io::printfn("[%s] Duplicate   = %s", s, utils::match("(.)\\1", s));
        io::printfn("[%s] Exclude     = %s", s, !utils::match("(ab)|(cd)|(pq)|(xy)", s));
    }

    return
        vowel_count(s) >= 3 &&
        utils::match("(.)\\1", s) &&
        !utils::match("(ab)|(cd)|(pq)|(xy)", s);
}

fn String! part1()
{
    String[] input = utils::get_lines("input/y2015/day05.txt")!;
    int nice;
    int line_count;

    io::printn("");

    foreach (line : input) {
        if (nice_part1(line)) {
            io::printfn("Nice [%s] [%s]", line, nice_part1(line));
            nice++;
        }
        line_count++;
    }

    io::printfn("Sanity check = %s", nice_part1("zzousprgrmllxboy", true));
    io::printfn("Sanity check = %s", nice_part1("qboxojoykxvwexav", true));
    io::printfn("Line count = %s", line_count);

    return string::tformat("%d", nice);
}

fn String! part2()
{
    return "<TODO>";
}
