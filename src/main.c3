module aoc;
import std::io;
import std::time::clock;
import aoc::y2015;

def Solver = fn String!();

struct Part
{
    String description;
    Solver solver;
}

struct Year
{
    int year;
    Part[] parts;
}

const Year[] YEARS = {
    y2015::PROBLEMS,
    y2024::PROBLEMS,
};

fn void run(Part part)
{
    @pool()
    {
        Clock t1 = clock::now();
        String! result = part.solver();
        Clock t2 = clock::now();

        if (try result) {
            io::printfn("%16s [%.2fs]", result, (double)(t2-t1)/1000000000.0);
        } else {
            io::printfn("%16s", "<ERROR>");
        }
    };
}

fn void main(String[] args)
{
    foreach (year : YEARS) {
        foreach (part : year.parts) {
            io::printf("%s %s : ", year.year, part.description);
            run(part);
        }
    }
}
