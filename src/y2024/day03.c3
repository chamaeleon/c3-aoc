module aoc::y2024::day03;
import aoc::utils;
import pcre2::posix;
import std::collections;
import std::io;

def StringList = List(<String>);

ZString re_mul = "mul[(]([0-9]+),([0-9]+)[)]";

fn int! get_sum(String s, bool conditional)
{
    Regex_t re;
    ZString zs = s.zstr_copy();
    Regmatch_t[4] matches;

    CInt result = posix::regcomp(&re, re_mul, 0);

    if (result != 0) {
        io::printn("Failed to compile regex");
        return AoCFault.INVALID_REGEX?;
    }

    int sum;
    int dont_offset = 0;

    while ((result = posix::regexec(&re, zs, matches.len, &matches, 0)) == 0) {
        if (conditional && dont_offset != -1) {
            dont_offset = (int)(zs.str_view().index_of("don't()")) ?? -1;
            if (dont_offset < matches[0].rm_so) {
                int do_offset = (int)(zs.str_view().index_of("do()")) ?? -1;
                if (do_offset == -1) return sum;
                zs = zs + (do_offset + 4);
                continue;
            }
        }
        int a = ((String)(zs[matches[1].rm_so..matches[1].rm_eo-1])).to_int()!;
        int b = ((String)(zs[matches[2].rm_so..matches[2].rm_eo-1])).to_int()!;
        sum += a * b;
        zs = zs + (matches[0].rm_eo);
    }

    return sum;
}

fn String! part1()
{
    String input = utils::slurp("input/y2024/day03.txt")!;
    int sum = get_sum(input, false)!;
    return string::tformat("%d", sum);
}

fn String! part2()
{
    String input = utils::slurp("input/y2024/day03.txt")!;
    int sum = get_sum(input, true)!;
    return string::tformat("%d", sum);
}
