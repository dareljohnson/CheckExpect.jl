module CheckExpect

    # package code goes here

    # import packages
    using AnsiColor

    ## include clear
    include("clear.jl");

    ## Clear and Close Figures
    clear();
    cla();                               # clear current axis
    clf();                               # clear current plot
    close();                             # close figure window

    # test suite Data Definitions and Functions
    results = Dict();
    results["total"] = 0;
    results["bad"] = 0;

    ## report
    # https://libraries.io/julia/AnsiColor
    function report()
    begin
            total = results["total"];
            bad =  results["bad"];
            passed = total - bad;
            if total >= 1 && passed >= 1
                println(colorize(:light_white,"Of $total tests, $bad failed, $passed passed.", background="light_black", mode="blink"))
            else
                println(colorize(:red,"Of $total test, $bad failed, $passed passed.", background="light_black", mode="blink"))
            end    
    end
    end

    function checkExpect(f::Function, params::Any, expected::Any, name::AbstractString ="")
        begin
            # run unit test
            result = f(params...);
            
            if strwidth(chomp(name)) < 0 || chomp(name) != ""
                println("for unit test: " * "$name")
            else
                println("for unit test: " * "test description unknown")
            end
                        
            if result != expected
                println("test: " * colorize(:red, "failed", background="black", mode="bold"))
                println("Expected $expected" * ", but was $result")
                println("info: " * colorize(:light_yellow, "Algorithm design is not well formed!", background="black", mode="bold"))
                println("")
                results["bad"] += 1;
                results["total"] += 1;
            else
                println("test: " * colorize(:green,"passed", background="black", mode="bold"))
                println("Function: $f consumed the following argument(s) $params, and produced $result, which matches $expected the expected result.")
                println("info: " * colorize(:light_blue, "Algorithm is well formed!", background="black", mode="default"))
                println("")
                #results["good"] += 1;
                results["total"] += 1;
            end
            # report test results
            report();
            
            return result 
        end
    end

end # module
