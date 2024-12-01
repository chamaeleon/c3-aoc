module aoc::y2015::day04;
import aoc::utils;
import std::hash::md5;
import std::encoding;

fn String hex_hash(String s)
{
    char[md5::HASH_BYTES] data = md5::hash(s);

    return hex::encode_temp(&data);
}

fn String! part1()
{
    long n = 0;

    while (true) {
        @pool()
        {
            String s = string::tformat("bgvyzdsv%s", n);
            if (hex_hash(s).starts_with("00000")) break;
            n++;
        };
    }

    return string::tformat("%s", n);
}

fn String! part2()
{
    long n = 0;

    while (true) {
        @pool()
        {
            String s = string::tformat("bgvyzdsv%s", n);
            if (hex_hash(s).starts_with("000000")) break;
            n++;
        };
    }

    return string::tformat("%s", n);
}
