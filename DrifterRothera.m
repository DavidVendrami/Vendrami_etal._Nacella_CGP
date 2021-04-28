% Code from HJV to read Rothera drifter data, including GPS.
% Small adaptations by MPM, 2021.

clear

day1=input('enter first day\n');
day2=input('enter last day\n');
for day=day1:day2
    clear ('-regexp','[^day ^day1 ^day2]');

if day<=81;
    file=['./RotheraDrifterData/101827_',num2str(day),'0112.txt'];
elseif day>81 & day<100
    file=['./RotheraDrifterData/101827_0',num2str(day),'_2012.txt'];
else
file=['./RotheraDrifterData/101827_',num2str(day),'_2012.txt'];
end;

fid = fopen(file,'r');
if fid>0
f=0;
for ic=1:2000
t{ic}= fgets(fid);     % reads strings from file into variable t, up to 2000 strings
if t{ic}==-1; f = ic;break; end
end
end
fclose(fid);

j=0;
for i=1:length(t)-1     % scrolls through to t using variable i as count
st=t{i};if length(st)>38&st(39)=='Y'   % checks for Y character; signifier of GPS fix
j=j+1;
u{j}=t{i};  % four lines of hex into u,v,w,x
v{j}=t{i+1};
w{j}=t{i+2};
x{j}=t{i+3};
for ib=1:20
z{j}=t{i-ib};
ids=z{j};
if length(ids)>=9
idt=ids(7:9);
if idt=='101'; break; end
end
end
end
end


for i=1:length(u)    % i scrolls up to length(u)
BAll=[];
jt=1;
stu=u{i};
stv=v{i};
stw=w{i};
stx=x{i};
ids=z{i};
id{i}=ids(7:12);

test{jt}=' Y'; jt=jt+1;
test{jt}=stu(51:52); jt=jt+1;
test{jt}=stu(64:65); jt=jt+1;
test{jt}=stu(77:78); jt=jt+1;
test{jt}=stv(38:39); jt=jt+1;
test{jt}=stv(51:52); jt=jt+1;
test{jt}=stv(64:65); jt=jt+1;
test{jt}=stv(77:78); jt=jt+1;
test{jt}=stw(38:39); jt=jt+1;
test{jt}=stw(51:52); jt=jt+1;
test{jt}=stw(64:65); jt=jt+1;
test{jt}=stw(77:78); jt=jt+1; 
test{jt}=stx(38:39); jt=jt+1;
test{jt}=stx(51:52); jt=jt+1;
test{jt}=stx(64:65); jt=jt+1;
test{jt}=stx(77:78); jt=jt+1;
  
for j=2:length(test)
B=num2str(dec2bin(hex2dec(test{j})));    % reads data into B
while length(B)<8
        B=['0',B,];
    end
BAll=[BAll B];    % appends data in B to BAll
end

V2=bin2dec(BAll(17:41));
dayfrac(i)=V2/86400;   % decimal day of year (V2 in seconds)
V3=bin2dec(BAll(42:65));
lat(i)=-90+0.0000128*V3;  %latitude
V4=bin2dec(BAll(66:90));
lon(i)=-180+0.0000128*V4;   %longitude
V5=bin2dec(BAll(91:97));
batt(i)=4+0.1*V5;   % battery
V6=bin2dec(BAll(98:103));
strain(i)=4*V6;   % strain (drogue presence indicator)
V7=bin2dec(BAll(104:108));
FOM(i)=V7;
V8=bin2dec(BAll(109:120));
SST(i)=-5+0.01*V8;   % sea surface temp

end

idu=unique(id);   % run through data fixes for separate drifters
for ic=1:length(idu);  % does one drifter at a time
idut=str2num(idu{ic});
idc=str2num(char(id));
    ii=find(idc==idut);      % ii = finds drifter based on platform ID
if idut==101562    % idut = drifter platform ID
    markercol=[1 0 0];
elseif idut==101827
    markercol=[0 1 0];
elseif idut==101959
   markercol=[0 0 1];
else
   markercol=[0 0 0];
end

    if idut==101827 | idut==101562 | idut==101959
    latsave = lat(ii);
    lonsave = lon(ii);
    dayfracsave = dayfrac(ii);    
    fname = ['drifter_data_day',num2str(day),'_',num2str(idut),'.mat']; % save output in matlab format
    eval(['save ', fname, ' latsave lonsave dayfracsave '])
    end;

end
end