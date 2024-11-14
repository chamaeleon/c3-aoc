module aoc::utils;
import std::io;
import std::collections::list;
import std::core::mem;
import pcre2::posix;

fault AoCFault
{
    INVALID_INPUT,
    INVALID_REGEX,
}

<*
    Read in a whole file. Returns "" if the loading fails for any reason.
    The content is allocated temporarily, and will be freed by @pool().

    @param [in] filename
*>
fn String! slurp(String filename)
{
    char[] bytes = file::load_temp(filename)!;

    return (String)bytes[:bytes.len];
}

<*
    Read in lines of text from a file and return an array of the lines.
    The content is allocated temporarily and freed by @pool().

    @param [in] filename
*>
fn String[]! get_lines(String filename)
{
    String bytes = slurp(filename)!;
    String[] lines = bytes.tsplit("\n");

    // Eliminate trailing \r due to Windows, if present at the end of a line
    foreach (i, line : lines) {
        if (line.len > 0 && line[line.len-1] == '\r') {
            lines[i] = line[:line.len-1];
        }
    }

    return lines;
}

<*
    Takes a regular expression and a string, and returns an array of
    the matched groups. The content is allocated temporarily and freed by @pool()

    @param [in] re_str "Regular expression"
    @param [in] s "String to find groups in"
*>
fn String[]! get_groups(String re_str, String s)
{
    String* groups;
    Regex_t re;
    char[1024] errbuf;

    CInt result = posix::regcomp(&re, re_str, 0);
    if (result != 0) {
        posix::regerror(result, &re, &errbuf, 1024);
        io::printfn("regcomp error: %s", (ZString)&errbuf);
        return AoCFault.INVALID_REGEX?;
    }

    Regmatch_t[16] matches;
    result = posix::regexec(&re, s, matches.len, &matches, 0);
    if (result != 0) {
        posix::regerror(result, &re, &errbuf, 1024);
        io::printfn("regexec error: %s", (ZString)&errbuf);
        return AoCFault.INVALID_INPUT?;
    }

    groups = mem::temp_new_array(String, matches.len-1);
    foreach (i, match : matches[1..]) {
        if (match.rm_so == -1) continue;
        groups[i] = s[match.rm_so..match.rm_eo-1];
    }

    return groups[:matches.len-1];
}
