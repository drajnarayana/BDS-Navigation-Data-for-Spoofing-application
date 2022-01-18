function [GPS_wk, GPS_sec_wk] = GPS_week(Y,M,D,H,min,sec)

%function [GPSwk,GPSSWK] = GPS_week(Y,M,D,H,min,sec)

% This function finds GPS week and GPS second of the week.

% Inputs are
%      (1-6)   Year, mo, day, hrs (in military time), minutes, seconds.  
%      Example: 1999 5 4 1 0 10 for May 4 1999 hour 1 minute 0 10 seconds

% Outputs are
%      (1-2)	GPS week, and GPS seconds of the week.


format long;



if nargin==4

	
min=0;

	
sec=0;


end;


UT=H+(min/60)+(sec/3600);


if M > 2

	
y=Y;


m=M;


else

	
y=Y-1;

	
m=M+12;


end;


JD=fix(365.25*y) + fix(30.6001*(m+1)) + D + (UT/24) + 1720981.5;


GPS_wk=fix((JD-2444244.5)/7);


%GPSwk=fix((JD-2444244.5)/7);


GPS_sec_wk=round( ( ((JD-2444244.5)/7)-GPS_wk)*7*24*3600);


%GPSSWK=round( ( ((JD-2444244.5)/7)-GPS_wk)*7*24*3600);