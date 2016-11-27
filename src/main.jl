# import packages
using PyPlot
using AnsiColor

## add path to project files
dirname = "/Users/dajohnson/Desktop/Julia/Projects/UTest";
push!(LOAD_PATH, dirname);

## include clear
include("clear.jl");

## Clear and Close Figures
clear();
cla();                               # clear current axis
clf();                               # clear current plot
close();                             # close figure window

## include external functions
include("joinString.jl");
#include("gradientDescentMulti.jl");
#include("computeCostMulti.jl");

# prints out array values
showprintln(x) = (show(x); println("\n"));
showprint(x) = (show(x); print());
showinfoln(u,x) = (begin @sprintf("%s ", u); show(x); println("\n") end);

## functions
function Add(num1::Int64, num2::Int64)
	return num1 + num2;
end

# Adds 2 or more numbers (integers)
function addNum(args...) 
	begin 
		total = 0
		num = 0
		numArgs = size(args,1)
		#@show(numArgs)
		for i = 1:numArgs 
			num = args[i] 
			total += num
		end	
		return total
	end
end	

# concatenating two strings together
function stringTogether(args...)
	begin
		newStr = ""
		str = []
		numArgs = size(args,1)
        @show(numArgs)
		for i = 1:numArgs
			push!(str, args[i])
			newStr += str * " "
		end
		return newStr	
	end
end

# test suite Data Definitions and Functions
results = Dict();
results["total"] = 0;
#results["good"] = 0;
results["bad"] = 0;

## report
# https://libraries.io/julia/AnsiColor
function report()
   begin
        total = results["total"];
        #good = results["good"];
        bad =  results["bad"];
        passed = total - bad;
        if total >= 1 && passed >= 1
            println(colorize(:light_white,"Of $total tests, $bad failed, $passed passed.", background="light_black", mode="blink"))
        else
            println(colorize(:red,"Of $total test, $bad failed, $passed passed.", background="light_black", mode="blink"))
        end    
   end
end

# an anonymous block of code
#=
function codeblock(code)
    return code
end
=#

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
        return result 
    end
end

# Data Type Definitions

## examples:
# Add 1, 2 should produce 3
# Add 23, 2 should produce 25
param1 = [1,2];
param2 = [23,2];
param4 = [1,2,3];

# stringTogether Darel, Johnson should produce Darel Johnson
param3 = ["Darel","Johnson"];

# use a partial codeblock for the Add function template
# parameters
num1 = 23
num2 = 2
# template
func_for_add = begin 
                    ans = 0; 
                    ans = num1 + num2; 
                end

# use a partial codeblock for the stringTogether function template
# parameters
firstName = "Darel"
lastName = "Johnson"
# template
func_for_stringtogether = begin
                            result = ""
                            if strwidth(firstName) > 1 && strwidth(lastName) > 1
                                result = strip(firstName) * " " * strip(lastName)
                            end    
                          end

checkExpect(Add, param1,3);
checkExpect(Add, param1, 1 + 3, "Add two numbers");
checkExpect(Add, param2, 23 + 2, "Add two numbers");
checkExpect(joinString, param3, "Darel Johnson", "Concatenating two strings");
#checkExpect(stringTogether, param3, "Darel Johnson", "Concatenating two strings");
checkExpect(addNum, param4, 6, "Add three numbers");
checkExpect(Add, param2, func_for_add, "Add two numbers with algorithm in func_def");
checkExpect(Add, param2, func_for_add, "testing codeblock")
checkExpect(joinString, param3, func_for_stringtogether, "Concatenating two strings with algorithm in func_def");

# report test results
report();