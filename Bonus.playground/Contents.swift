//  Bonus assignment
//  David N. Cohron
//  submitted: July 19, 2016

import UIKit


//  Days between January 1, 1900 and date given
//  Assume that count is to include both starting and ending day
//  If you want more robust code that checks for out of range input, will require more lines


// Function isLeap to determine if year is a leap year
// Code is one line in the function

func isLeap(year:Int) ->  Bool {
    return ((year%4 == 0) && ((year%100 != 0) || (year%400 == 0))) ? true : false
}

//  Function julianDate calculates the number of days since 1/1/1990
//  Included in the count is the starting and ending days
//  Code is two lines in the function
//  First line sets the generator for the number of full years elapsed since 1/1/1990
//  Second line is return of the sum of:
//     days in each year, including leap year, up to but not including this year (which is not complete)
//     the number of days elapsed in the year so far based on the full months completed,
//     the days elapsed in the current month, and
//     check to see if we had a leap day so far this year (past February and this is a leap year)

func julianDate(year: Int, month: Int, day: Int) -> Int {
    let yearsSince = 1900..<year
    return yearsSince.reduce(0){ $0+(isLeap($1) ? 366:365)} + cumulativeMonthDays[month-1]! + day + ((month>=3) && (isLeap(year)) ? 1:0)
}

//  Data structure (dictionary) to look up number of days elapsed up to this month, given this month as key

let cumulativeMonthDays: Dictionary = [0: 0, 1: 31, 2: 59, 3: 90, 4: 120, 5: 151, 6: 181, 7: 212, 8: 243, 9: 273, 10: 304, 11: 334, 12: 365]




// checks from assignment specifications
julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)
isLeap(1960)
isLeap(1900)
isLeap(2000)


