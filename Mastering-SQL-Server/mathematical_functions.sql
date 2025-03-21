----------------------- Mathematical Functions --------------------------------

/* ABS(numeric_expression):- ABS stands for absolute and returns, the absolute
                            positive number.
*/

select abs(-101.5) as absolute --- returns 101.5 without the - sign

/* ceiling(numeric_expression) and floor(numeric_expression)
Ceiling and Floor functions accept a numeric expression as a single parameter.
Ceiling() returns the smallest integer value greater than or equal to the
parameter whereas floor() returns the largest integer less than or equal to
the parameter*/

select ceiling(15.2)
select ceiling(-15.2)

select floor(15.2)
select floor(-15.2)

/*
Power(expression,power):- 
It returns the power value of the specified expression to the
specified power*/

select power(2,3)---- Returns 8

/*
Square(Number):- returns the square of the given number*/

select square(9)---- Returns 81

/* SQRT(Number):- Returns the square root of the given  number*/

select sqrt(81)-- Returns 9

select sqrt(16)--- Returns 4

/* Rand([Seed_Value]):- Returns a random float number between 0 and 1.
                        Rand() function takes an optional seed parameter.
						When seed value is supplied, the RAND() function
						always returns the same value for the same seed.
*/

select rand() ---- Always get different random values without seed

select rand(1) ---- Always returns the same value

select floor(rand()*100)--- to get only the decimal value

----- Loop to print 10 random numbers (the decimal part only)----------
Declare @Counter int
set @Counter=1
while(@Counter<=10)
Begin
     Print Floor(Rand()*100)
	 set @Counter=@Counter+1
End

--------------------- Round() Function--------------------------------------
/*

Round(numeric_expression,length[,function]):-
Rounds the given numeric expression based on the given length. The function
takes 3 parameters:-

1) numeric_expression:- It is the number that we want to round.
2) Length:-  This parameter specifies the number of digits we want to round to.
             If the length is a positive number, then the rounding is applied 
			 for the decimal part, whereas if the length is negative then the
			 rounding is applied to the number before decimal.

3) The optional function parameter:- It is used to indicate rounding or truncation
                                     operations. 0 indicates rounding , non-zero
									 indicates truncation. Defualt, if not specified
									 is 0.


*/

---- Round to 2 places after(to the right) the decimal point----

select round(850.556,2)--- Returns 850.560 

--- Truncate anything after 2 places, afer (to the right) the decimal point

select round(850.556,2,1)---- Returns 850.550

--- Round to 1 place after ( to the right) the decimal point
select round(850.556,1)------ Returns 850.600

--- Truncate anything after 1 place, after (to the right) the decimal point
select round(850.556,1,1)----- Returns 850.500

--- Round the last 2 places before ( to the left) the decimal point
select round(850.556,-2)----- Returns 900.000

---- Round the last 1 place before ( to the left) the decimal point
select round(850.556,-1)---- Returns 850.000

















