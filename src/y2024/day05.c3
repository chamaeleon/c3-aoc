module aoc::y2024::day05;
import aoc::utils;
import std::io;
import std::collections;

def StringList = List(<String>);
def PairList = List(<String[]>);

fn void split_input(String[] lines, StringList *rules, StringList *updates)
{
    bool add_rule = true;

    foreach (line : lines) {
        if (line.trim() == "") {
            add_rule = false;
        } else {
            if (add_rule) {
                String[] parts = line.tsplit("|");
                String re_str = string::tformat("%s.*,%s", parts[1], parts[0]);
                rules.push(re_str);
            } else {
                updates.push(line);
            }
        }
    }
}

fn int! middle(String update)
{
    String[] parts = update.tsplit(",");

    return parts[parts.len/2].to_int()!;
}

fn String! part1()
{
    String[] lines = utils::get_lines("input/y2024/day05.txt")!;
    StringList rules;
    StringList updates;
    int sum;

    rules.temp_init();
    updates.temp_init();

    split_input(lines, &rules, &updates);

    foreach (update : updates) {
        bool invalid_rule = false;

        foreach (re_str : rules) {
            if (utils::match(re_str, update)) {
                invalid_rule = true;
                break;
            }
        }

        if (!invalid_rule) sum += middle(update)!;
    }

    return string::tformat("%d", sum);
}

fn void split_input_2(String[] lines, PairList *pairs, StringList *updates)
{
    bool add_rule = true;

    foreach (line : lines) {
        if (line.trim() == "") {
            add_rule = false;
        } else {
            if (add_rule) {
                pairs.push(line.tsplit("|"));
            } else {
                updates.push(line);
            }
        }
    }
}

fn int! sorted_middle(String update, PairList rules)
{
    String[] pages = update.tsplit(",");
    StringList sorted;

    sorted.temp_init();

    foreach (page_idx, page : pages) {
        int pos = 0;

        while (pos < sorted.len()) {
            bool valid = true;
            foreach (rule : rules) {
                if (sorted[pos] == rule[0] && page == rule[1]) {
                    pos++;
                    valid = false;
                    break;
                }
            }

            if (valid) break;
        }

        sorted.insert_at(pos, page);
    }

    return sorted[sorted.len()/2].to_int()!;
}

fn String! part2()
{
    String[] lines = utils::get_lines("input/y2024/day05.txt")!;
    PairList rules;
    StringList updates;
    int sum;

    rules.temp_init();
    updates.temp_init();

    split_input_2(lines, &rules, &updates);

    foreach (update : updates) {
        foreach (rule : rules) {
            String re_str = string::tformat("%s.*,%s", rule[1], rule[0]);
            if (utils::match(re_str, update)) {
                sum += sorted_middle(update, rules)!;
                break;
            }
        }
    }

    return string::tformat("%d", sum);
}
