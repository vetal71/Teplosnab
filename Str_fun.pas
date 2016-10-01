unit Str_fun;

interface

uses SysUtils, DateUtils, Variants, Classes, Math;

function UlicaStr(adres:string):string;
function DomStr(adres:string):string;
function KvStr(adres:string):string;
function StartNextMonth(Data: double): double;
function EndOfMonth(Data: double): double;
function PeriodStr(Data1,Data2:Variant):string;
procedure GetItemsPeriod(List:TStrings);
procedure GetItemsPeriodNew(List:TStrings; EndDate:double);
function DateOfPeriod(Index: integer): double;
procedure get2str(value:string;var hi,lo:string);
function SumToStrin(Value : String) : string;
function sumtostring(value:string):string;
function GetIndexOfDate(Data:double):integer;

Const
  mes:array[0..11] of string=
('Январь ','Февраль ','Март ','Апрель ','Май ',
'Июнь ','Июль ','Август ','Сентябрь ','Октябрь ','Ноябрь ','Декабрь ');
  a:array[0..8,0..9] of string=(
('','один ','два ','три ','четыре ','пять ','шесть ','семь ','восемь ','девять '),
('','','двадцать ','тридцать ','сорок ','пятьдесят ','шестьдесят ','семьдесят ','восемьдесят ','девяносто '),
('','сто ','двести ','триста ','четыреста ','пятьсот ','шестьсот ','семьсот ','восемьсот ','девятьсот '),
('тысяч ','одна тысяча ','две тысячи ','три тысячи ','четыре тысячи ','пять тысяч ','шесть тысяч ','семь тысяч ','восемь тысяч ','девять тысяч '),
('','','двадцать ','тридцать ','сорок ','пятьдесят ','шестьдесят ','семьдесят ','восемьдесят ','девяносто '),
('','сто ','двести ','триста ','четыреста ','пятьсот ','шестьсот ','семьсот ','восемьсот ','девятьсот '),
('миллионов ','один миллион ','два миллиона ','три миллиона ','четыре миллиона ','пять миллионов ','шесть миллионов ','семь миллионов ','восемь миллионов ','девять миллионов '),
('','','двадцать ','тридцать ','сорок ','пятьдесят ','шестьдесят ','семьдесят ','восемьдесят ','девяносто '),
('','сто ','двести ','триста ','четыреста ','пятьсот ','шестьсот ','семьсот ','восемьсот ','девятьсот '));
  c:array[0..8,0..9] of string=(
('','одна ','две ','три ','четыре ','пять ','шесть ','семь ','восемь ','девять '),
('','','двадцать ','тридцать ','сорок ','пятьдесят ','шестьдесят ','семьдесят ','восемьдесят ','девяносто '),
('','сто ','двести ','триста ','четыреста ','пятьсот ','шестьсот ','семьсот ','восемьсот ','девятьсот '),
('тысячь ','одна тысяча ','две тысячи ','три тысячи ','четыре тысячи ','пять тысяч ','шесть тысяч ','семь тысяч ','восемь тысяч ','девять тысяч '),
('','','двадцать ','тридцать ','сорок ','пятьдесят ','шестьдесят ','семьдесят ','восемьдесят ','девяносто '),
('','сто ','двести ','триста ','четыреста ','пятьсот ','шестьсот ','семьсот ','восемьсот ','девятьсот '),
('миллионов ','один миллион ','два миллиона ','три миллиона ','четыре миллиона ','пять миллионов ','шесть миллионов ','семь миллионов ','восемь миллионов ','девять миллионов '),
('','','двадцать ','тридцать ','сорок ','пятьдесят ','шестьдесят ','семьдесят ','восемьдесят ','девяносто '),
('','сто ','двести ','триста ','четыреста ','пятьсот ','шестьсот ','семьсот ','восемьсот ','девятьсот '));
  b:array[0..9] of string=
('десять ','одинадцать ','двенадцать ','тринадцать ','четырнадцать ','пятнадцать ','шестнадцать ','семнадцать ','восемнадцать ','девятнадцать ');



implementation

function UlicaStr(adres:string):string;
Var
  Poz:integer;
begin
  {Ищем позицию пробела в адресе}
  poz:=pos(' ', adres);
  if poz>0 then
    result:=copy(adres,1,poz-1)
  else
    result:='';
end;

function DomStr(adres:string):string;
Var
  Poz:integer;
begin
  {Ищем позицию пробела в адресе}
  poz:=pos(' ', adres);
  if poz>0 then
    adres:=copy(adres,poz+1,Length(adres)-poz)
  else
    result:='';
  poz:=pos('/', adres);
  if poz>0 then
    adres:=copy(adres,1,poz-1)
  else
    result:=adres;
  while pos('0',adres)>0 do
    adres[pos('0',adres)]:=' ';
  result:=Trim(adres);
end;

function KvStr(adres:string):string;
Var
  Poz:integer;
begin
  {Ищем позицию / в адресе}
  poz:=pos('/', adres);
  if poz>0 then
    adres:=copy(adres,poz+1,Length(adres)-poz)
  else
    result:='';
  while pos('0',adres)>0 do
    adres[pos('0',adres)]:=' ';
  result:=Trim(adres);
end;

function StartNextMonth(Data: double): double;
Var
  den,mes,god:integer;
begin
  den:=1;
  if MonthOf(Data)<12 then
  begin
    mes:=MonthOf(Data)+1;
    god:=YearOf(Data);
  end
  else
  begin
    mes:=1;
    god:=YearOf(Data)+1;
  end;
  result:=DateOf(EncodeDateTime(god,mes,den,23,59,59,999));
end;

function EndOfMonth(Data: double): double;
Var
  den,mes,god:integer;
begin
  den:=DaysInMonth(Data);
  mes:=MonthOf(Data);
  god:=YearOf(Data);
  result:=DateOf(EncodeDateTime(god,mes,den,23,59,59,999));
end;

function PeriodStr(Data1,Data2:Variant):string;
begin
  if VarIsNull(data2) then
    result:=FormatDateTime('mmmm yyyy "г."',VarToDateTime(Data1))
  else
    result:=FormatDateTime('mmmm yyyy "г."',VarToDateTime(Data1))+' по '+
    FormatDateTime('mmmm yyyy "г."',VarToDateTime(Data2));
end;

procedure GetItemsPeriod(List:TStrings);
Var
  i,j:integer;
begin
  for j:=2004 to YearOf(Date()) do
  begin
    for i:=0 to 11 do
      with List do
        Add(mes[i]+IntToStr(j));
  end;
end;

function DateOfPeriod(Index: integer): double;
Var
  mes,god:integer;
begin
  god:=Floor(Index/12)+2004;
  mes:=(Index+1)-Floor(Index/12)*12;
  if mes<10 then
  result:=StrToDate('01.'+'0'+IntToStr(mes)+'.'+IntToStr(god))
  else
  result:=StrToDate('01.'+IntToStr(mes)+'.'+IntToStr(god));
end;

procedure get2str(value:string;var hi,lo:string);
var p:integer;
begin
        p:=pos(',',value);
        lo:='';hi:='';
        if p=0 then p:=pos('.',value);
        if p<>0 then delete(value,p,1);
        if p=0 then begin hi:=value;lo:='00';exit;end;
        if p>length(value) then begin hi:=value;lo:='00';exit;end;
        if p=1 then begin hi:='0';lo:=value;exit;end;
        begin
        hi:=copy(value,1,p-1);
        lo:=copy(value,p,length(value));
        if length(lo)<2 then lo:=lo+'0';
        end;
end;

function SumToStrin(Value : String) : string;
var s,t:string;
    p,pp,i,k:integer;
begin
        s:=value;
        if s='0' then t:='Ноль ' else begin
        p:=length(s);
        pp:=p;
        if p>1 then
        if (s[p-1]='1') and (s[p]>='0') then begin
        t:=b[strtoint(s[p])];pp:=pp-2;end;
        i:=pp;
        while i>0 do begin
        if (i=p-3) and (p>4) then
        if s[p-4]='1' then begin
        t:=b[strtoint(s[p-3])]+'тысяч '+t;i:=i-2;end;
        if (i=p-6) and (p>7) then
        if s[p-7]='1' then begin
        t:=b[strtoint(s[p-6])]+'миллионов '+t;
        i:=i-2;end;
        if i>0 then begin k:=strtoint(s[i]);
        t:=a[p-i,k]+t;
        i:=i-1;end;
        end;end;
        result:=t;
end;

function sumtostring(value:string):string;
var hi,lo,valut:string;
    pr,er:integer;
begin
        get2str(value,hi,lo);
        if (hi='') or (lo='') then begin result:='';exit;end;
        val(hi,pr,er);if er<>0 then begin result:='';exit;end;
        if hi[length(hi)]='1' then valut:='белорусский рубль';
        if (hi[length(hi)]>='2') and (hi[length(hi)]<='4') then valut:='белорусских рубля';
        if (hi[length(hi)]='0') or (hi[length(hi)]>='5') or
        ((strtoint(copy(hi,length(hi)-1,2))>10) and (strtoint(copy(hi,length(hi)-1,2))<15)) then valut:='белорусских рублей';
        hi:=sumtostrin(inttostr(pr))+valut;
        hi[1]:=AnsiUpperCase(hi[1])[1];
        result:=hi;
end;

procedure GetItemsPeriodNew(List:TStrings; EndDate:double);
Var
  i,j:integer;
begin
  for j:=2004 to YearOf(EndDate) do
  begin
    for i:=0 to 11 do
      with List do
        Add(mes[i]+IntToStr(j));
  end;
end;

function GetIndexOfDate(Data:double):integer;
begin
  Result:=(YearOf(Data)-2004)*12+MonthOf(Data)-1;
end;

end.
 