module aoc::y2024::day04;
import aoc::utils;
import std::io;

String word = "XMAS";

fn int xmas(String[] lines, int row_offset, int col_offset)
{
    int sum;

    for (int row = 0; row < lines.len; row++) {
        if ((row + row_offset*(word.len-1)) < 0 || (row + row_offset*(word.len-1)) >= lines.len) {
            continue;
        }

        for (int col = 0; col < lines[row].len; col++) {
            if ((col + col_offset*(word.len-1) < 0) || (col + col_offset*(word.len-1)) >= lines[row].len) {
                continue;
            }

            bool found = true;

            for (int i = 0; i < word.len; i++) {
                if (lines[row + i*row_offset][col + i*col_offset] != word[i]) {
                    found = false;
                    break;
                }
            }

            if (found) {
                sum++;
            }
        }
    }

    return sum;
}

fn int x_max(String[] lines)
{
    int sum;

    for (int row = 1; row < lines.len-1; row++) {
        for (int col = 1; col < lines[row].len-1; col++) {
            if (lines[row][col] == 'A') {
                char c1 = lines[row-1][col-1];
                char c2 = lines[row+1][col+1];
                char c3 = lines[row-1][col+1];
                char c4 = lines[row+1][col-1];

                bool diag1 = (c1 == 'M' && c2 == 'S' || c1 == 'S' && c2 == 'M');
                bool diag2 = (c3 == 'M' && c4 == 'S' || c3 == 'S' && c4 == 'M');

                if (diag1 && diag2) sum++;
            }
        }
    }

    return sum;
}

fn String! part1()
{
    String[] lines = utils::get_lines("input/y2024/day04.txt")!;
    int sum;

    for (int row_offset = -1; row_offset <= 1; row_offset++) {
        for (int col_offset = -1; col_offset <= 1; col_offset++) {
            if (col_offset != 0 || row_offset != 0) {
                sum += xmas(lines, row_offset, col_offset);
            }
        }
    }

    return string::tformat("%d", sum);
}

fn String! part2()
{
    String[] lines = utils::get_lines("input/y2024/day04.txt")!;

    return string::tformat("%d", x_max(lines));
}
