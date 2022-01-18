%function navdata=RENIXreadNAV 
navdata=struct('prn',NaN,'year',NaN,'month',NaN,'day',NaN,'hour',NaN,'minute',NaN,'second',NaN,... 
               'af0',NaN,'af1',NaN,'af2',NaN,'aode',NaN,'crs',NaN,'deltan',NaN,'M0',NaN,'cuc',NaN, 'ecc',NaN,... 
               'cus',NaN,'art',NaN,'toe',NaN,'cic',NaN,'Omega',NaN,'cis',NaN,'i0',NaN,'crc',NaN,  'omega',NaN,'Omegadot',NaN,... 
               'idot',NaN,'cflg12',NaN,'weekno',NaN,'pflg12',NaN,'svaccuracy',NaN,'svhealth',NaN, 'tgd',NaN,'aodc',NaN,... 
               'transmit',NaN,'spare1',NaN,'spare2',NaN,'spare3',NaN); 
fide=fopen('IISC00IND_R_20211090000_01D_CN.rnx'); %BDSrinexnavigationfile
head_lines = 0; 
while 1  
   head_lines = head_lines+1; 
   line = fgetl(fide); 
   answer = findstr(line,'END OF HEADER'); 
   if ~isempty(answer); 
       break;	 
   end; 
end; 
head_lines 
noeph = -1; 
while 1 
   noeph = noeph+1; 
   line = fgetl(fide); 
   if line == -1; 
      break;   
   end; 
end; 
noeph = ceil((noeph/8)); 
frewind(fide); 
for l = 1:head_lines; 
    line = fgetl(fide);  
end;
for i=1:noeph; 
    line=fgetl(fide);%first line 
    navdata(i).prn=str2num(line(2:3)); 
    navdata(i).year=str2num(line(5:8)); 
     

    navdata(i).month=str2num(line(10:11)); 
    navdata(i).day=str2num(line(13:15)); 
    navdata(i).hour=str2num(line(16:18)); 
    navdata(i).minute=str2num(line(19:21)); 
    navdata(i).second=str2num(line(22:23)); 
    navdata(i).af0=str2num(line(24:42));
   
    navdata(i).af1=str2num(line(43:61)); 
    navdata(i).af2=str2num(line(62:80)); 
    line=fgetl(fide);%second line 
    navdata(i).iode=str2num(line(5:23)); 
    navdata(i).crs=str2num(line(24:42)); 
    navdata(i).deltan=str2num(line(43:61)); 
    navdata(i).M0=str2num(line(62:80)); 
    line=fgetl(fide); 
    navdata(i).cuc=str2num(line(5:23)); 
    navdata(i).ecc=str2num(line(24:42)); 
    navdata(i).cus=str2num(line(43:61)); 
    navdata(i).art=str2num(line(62:80)); 
    line=fgetl(fide); 
    navdata(i).toe=str2num(line(5:23)); 
    navdata(i).cic=str2num(line(24:42)); 
    navdata(i).Omega=str2num(line(43:61)); 
    navdata(i).cis=str2num(line(62:80)); 
    line=fgetl(fide); 
    navdata(i).i0=str2num(line(5:23)); 
    navdata(i).crc=str2num(line(24:42)); 
    navdata(i).omega=str2num(line(43:61)); 
    navdata(i).Omegadot=str2num(line(62:80)); 
    line=fgetl(fide); 
    navdata(i).idot=str2num(line(5:23)); 
    navdata(i).cflag12=str2num(line(24:42)); 
    navdata(i).weekno=str2num(line(43:61)); 
    %navdata(i).pflag12=str2num(line(62:80)); 
    line=fgetl(fide); 
    navdata(i).svaccuracy=str2num(line(5:23)); 
    navdata(i).svhealth=str2num(line(24:42)); 
    navdata(i).tgd=str2num(line(43:61)); 
    %navdata(i).aodc=str2num(line(62:80)); 
    line=fgetl(fide); 
    navdata(i).transmit=str2num(line(5:23)); 
    %navdata(i).spare1=str2num(line(24:42)); 
    %navdata(i).spare2=str2num(line(43:61)); 
    %navdata(i).spare3=str2num(line(62:80)); 
    end; 
status=fclose(fide); 
%navdata=zeros(1,585)
%navdata=navdata{27:37};
 eph={};
 eph=cell(1,585);
 for i=27:585
     eph{1,i}=navdata(i);
    
 end
% navbits={};
% navbits=cell(1,40);
%  %C37 
%  navbits{1,1}=factor(eph{1,28}.prn,0,6);
%      
%      navbits{1,2}=factor(eph{1,28}.weekno,0,13);
%       
%       navbits{1,3}=factor(eph{1,28}.iode,0,8);
%     navbits{1,4}=factor(eph{1,28}.toe/300,0,11);
%       navbits{1,5}=factor(eph{1,28}.deltan,44,17);
%       navbits{1,6}=factor(eph{1,28}.M0/pi,32,33);
%       navbits{1,7}=factor(eph{1,28}.ecc,34,33);
%       navbits{1,8}=factor(eph{1,28}.omega/pi,32,33);
% %      
% % %     %EphemerisII
%      navbits{1,9}=factor(eph{1,28}.Omega/pi,32,33);
%       navbits{1,10}=factor(eph{1,28}.i0/pi,32,33);
%      navbits{1,11}=factor(eph{1,28}.Omegadot/pi,44,19);
%      navbits{1,12}=factor(eph{1,28}.idot/pi,44,15);
%      navbits{1,13}=factor(eph{1,28}.cis,30,16);
%       navbits{1,14}=factor(eph{1,28}.cic,30,16);
%      navbits{1,15}=factor(eph{1,28}.crs,8,24);
%       navbits{1,16}=factor(eph{1,28}.crc,8,24); 
%       navbits{1,17}=factor(eph{1,28}.cus,30,21);
%       navbits{1,18}=factor(eph{1,28}.cuc,30,21);
%      %EphemerisIC38
%      
%      navbits{2,1}=factor(eph{1,112}.prn,0,6);
%      
%      navbits{2,2}=factor(eph{1,112}.weekno,0,13);
%       
%       navbits{2,3}=factor(eph{1,112}.iode,0,8);
%     navbits{2,4}=factor(eph{1,112}.toe/300,0,11);
%       navbits{2,5}=factor(eph{1,112}.deltan,44,17);
%       navbits{2,6}=factor(eph{1,112}.M0/pi,32,33);
%       navbits{2,7}=factor(eph{1,112}.ecc,34,33);
%       navbits{2,8}=factor(eph{1,112}.omega/pi,32,33);
% %      
% % %     %EphemerisII
%      navbits{2,9}=factor(eph{1,112}.Omega/pi,32,33);
%       navbits{2,10}=factor(eph{1,112}.i0/pi,32,33);
%      navbits{2,11}=factor(eph{1,112}.Omegadot/pi,44,19);
%      navbits{2,12}=factor(eph{1,112}.idot/pi,44,15);
%      navbits{2,13}=factor(eph{1,112}.cis,30,16);
%       navbits{2,14}=factor(eph{1,112}.cic,30,16);
%      navbits{2,15}=factor(eph{1,112}.crs,8,24);
%       navbits{2,16}=factor(eph{1,112}.crc,8,24); 
%       navbits{2,17}=factor(eph{1,112}.cus,30,21);
%       navbits{2,18}=factor(eph{1,112}.cuc,30,21);
%  %C20  
%  navbits{2,1}=factor(eph{1,30}.prn,0,6);
%      
%      navbits{2,2}=factor(eph{1,30}.weekno,0,13);
%       
%       navbits{2,3}=factor(eph{1,112}.iode,0,8);
%     navbits{2,4}=factor(eph{1,112}.toe/300,0,11);
%       navbits{2,5}=factor(eph{1,112}.deltan,44,17);
%       navbits{2,6}=factor(eph{1,112}.M0/pi,32,33);
%       navbits{2,7}=factor(eph{1,112}.ecc,34,33);
%       navbits{2,8}=factor(eph{1,112}.omega/pi,32,33);
% %      
% % %     %EphemerisII
%      navbits{2,9}=factor(eph{1,112}.Omega/pi,32,33);
%       navbits{2,10}=factor(eph{1,112}.i0/pi,32,33);
%      navbits{2,11}=factor(eph{1,112}.Omegadot/pi,44,19);
%      navbits{2,12}=factor(eph{1,112}.idot/pi,44,15);
%      navbits{2,13}=factor(eph{1,112}.cis,30,16);
%       navbits{2,14}=factor(eph{1,112}.cic,30,16);
%      navbits{2,15}=factor(eph{1,112}.crs,8,24);
%       navbits{2,16}=factor(eph{1,112}.crc,8,24); 
%       navbits{2,17}=factor(eph{1,112}.cus,30,21);
%       navbits{2,18}=factor(eph{1,112}.cuc,30,21);
