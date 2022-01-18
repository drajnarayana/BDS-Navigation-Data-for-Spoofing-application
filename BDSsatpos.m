% Function bdssatpos=satpos(time,ephemeris)
tic;clc;clear all;close all;
load Navigationfile.mat
load Observation.mat
%%%%%%%%% Change Variable Name I2, I3, ... according to Satellite No. %%% 
Temp=C37(:,1:2);
sv=Temp(:,2);time_all=Temp(:,1);
sv(86400)=[];time_all(86400)=[];
m=length(sv);
for t = 1:m
   col_Eph(t)=findb_eph(Eph,sv(t),time_all(t));
end
sat_p=[];
for k=1:m
    eph=Eph(:,col_Eph(k)); t=time_all(k);                           %%%%%% Input for Satellite Position Algorithm
% I_Pos(k,1:3) = ecef2lla(satpos(time(k), Eph(:,col_Eph(k)))');
%SATPOS Calculation of X,Y,Z coordinates at time t
%	     for given ephemeris eph
%Kai Borre 04-09-96
%Copyright (c) by Kai Borre
%$Revision: 1.1 $  $Date: 1997/12/06  $

GM = 3.986004418e14;  % earth's universal gravitational
                   % parameter m^3/s^2
Omegae_dot = 7.2921150e-5; % earth rotation rate, rad/s

%  Units are either seconds, meters, or radians
%  Assigning the local variables to eph
svprn   =   eph(1);
af2	  =   eph(2);
M0	     =   eph(3);
roota   =   eph(4);
deltan  =   eph(5);
ecc	  =   eph(6);
omega   =   eph(7);
cuc	  =   eph(8);
cus	  =   eph(9);
crc	  =  eph(10);
crs	  =  eph(11);
i0	     =  eph(12);
idot    =  eph(13);
cic	  =  eph(14);
cis	  =  eph(15);
Omega0  =  eph(16);
Omegadot=  eph(17);
toe	  =  eph(18);
af0	  =  eph(19);
af1	  =  eph(20);
toc	  =  eph(21);
tgd =eph(23);

% Procedure for coordinate calculation
A = roota*roota;
tk = bdscheck_t(t-toe);
n0 = sqrt(GM/A^3);
n = n0+deltan;
M = M0+n*tk;
E = M;
OneMinuscosE=0;
for i = 1:10
   E_old = E;
   OneMinuscosE= 1-ecc*cos(E);
   E = M+ecc*sin(E);
   dE = rem(E-E_old,2*pi);
   if abs(dE) < 1.e-12
      break;
   end
end
v = atan2(sqrt(1-ecc^2)*sin(E), cos(E)-ecc);
phi = v+omega;
phi = rem(phi,2*pi);
relativistic = -4.442807633e-10*ecc*sqrt(A)*sin(E);
ekdot= n/OneMinuscosE;
vdot=(sqrt(1-ecc^2))*ekdot/OneMinuscosE;
u = phi + cuc*cos(2*phi)+cus*sin(2*phi);
udot=vdot*(1+2*(cus*cos(2*phi)- cuc*sin(2*phi)));
r = A*(1-ecc*cos(E)) + crc*cos(2*phi)+crs*sin(2*phi);
rdot=A*ecc*sin(E)*ekdot+2.0*vdot*(crs-cos(2*phi)-crc*sin(2*phi));
i = i0+idot*tk	      + cic*cos(2*phi)+cis*sin(2*phi);
idotk=idot+2*vdot*(cis*cos(2*phi)-cic*sin(2*phi));
Omega = Omega0+(Omegadot-Omegae_dot)*tk-Omegae_dot*toe;
x1 = cos(u)*r;
y1 = sin(u)*r;
x1dot=rdot*cos(u)-y1*udot;
y1dot=rdot*sin(u)+x1*udot;
satp(1,1) = x1*cos(Omega)-y1*cos(i)*sin(Omega);
satp(2,1) = x1*sin(Omega)+y1*cos(i)*cos(Omega);
satp(3,1) = y1*sin(i);

sat_p(k,1:3)=satp';

%satellite velocity
tmp=y1dot*cos(i)-y1*sin(i)*idotk;
vel(1,1)= -Omegadot*satp(2,1)+x1dot*cos(Omega)-tmp*sin(Omega);
vel(2,1)= Omegadot*satp(1,1)+x1dot*sin(Omega)+tmp*cos(Omega);
vel(3,1)= y1*cos(i)*idotk+y1dot*sin(i);

vel_b(k,1:3)=vel';

%satellite clock correction
tk=bdscheck_t(t-toc);
clk(1,1)=af0+tk*(af1+tk*af2)+relativistic-tgd;
clk(2,1)=af1+2*tk*af2;

clk_b(k,1:2)=clk';
end
satp_deg=ecef2lla(sat_p);
plot(satp_deg(:,2),satp_deg(:,1)); 
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
%R='C';
title('Footprint of Beidou C37(MEO) Satellite' )

grid on
toc;
