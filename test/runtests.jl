using CheckExpect
using Base.Test

# write your own tests here
# @test 1 == 2

param1 = [1,2];
param2 = [23,2];
function Add(num1::Int64, num2::Int64)
	return num1 + num2;
end
@test 3 == checkExpect(Add, param1,3);
@test 25 == checkExpect(Add, param2, 23 + 2, "Add two numbers");
