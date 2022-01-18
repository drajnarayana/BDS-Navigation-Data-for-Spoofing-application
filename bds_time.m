function [week,sec_of_week] = bds_time(juldayeas)
% GPS_TIME   Conversion of Julian Day number to GPS week and
%	                Seconds of Week as reckoned from midnight between 
%                  Saturday  and Sunday

% Written by Kai Borre
% January 7, 2016

    a = floor(juldayeas+.5);
    b = a+1537;
    c = floor((b-122.1)/365.25);
    e = floor(365.25*c);
    f = floor((b-e)/30.6001);
    d = b-e-floor(30.6001*f)+rem(juldayeas+.5,1);
    day_of_week = rem(floor(juldayeas+.5),7);
    week = floor((juldayeas-2444244.5)/7);
    % We add +1 as the GPS week starts at Saturday midnight
    sec_of_week = (rem(d,1)+day_of_week+1)*86400;
%%%%%%% end gps_time.m	%%%%%%%%%%%%%
