module aoc;
import std::io;
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
};

fn void run(Part part)
{
    @pool()
    {
        String! result = part.solver();

        if (try result) {
            io::printfn("%16s", result);
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
