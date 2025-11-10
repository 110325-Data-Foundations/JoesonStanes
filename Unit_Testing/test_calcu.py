#pytest accepts certain conventions 
#Name the file with your test for a specific module
#test_module.py Or "Module_tes.py
# #finding your test automatically
# "in order to find tests automatically, pytest will look for files that match the following patterns:
# 1. python tests itself
# 2. the code from the module you are testing
# unit test directly calls the code under test this introduces
# some considerations whrer your test code should be located
 
import pytest

from calcu import add, subtract, multiply, divide
#"within the test file, you can import the functions or classes you want to test from the module under test
def test_divide_calcu():
    #unit test generally follows a A-A-A pattern Arrange - Act - Assert
    #Arrange any variables or tst data that we need to set up the test
    x=4
    y=2
    #Act call the function or method under test with the arranged data
    result=divide(x,y)
    #Assert verify that the result is as expected
    assert result==2
 
def test_divide_by_zero_exception():
#     #Arrange
     x=4
     y=0
     #ACT
     with pytest.raises(ValueError) as ex:
         divide(x,y)
     assert str(ex.value) == "Cannot divide by zero"
def test_add():
    x=3
    y=5
    result=add(x,y)
    assert result==8