unit FunForFR;

interface

uses SysUtils, Classes, fs_iinterpreter, Math;

type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass; const
      MethodName: String; var Params: Variant): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;

function DateOfPeriod(Index: integer): double;

implementation

//Деньги строкой

var
  NumEd: array[1..19] of string = ('один ', 'два ', 'три ', 'четыре ', 'пять ',
    'шесть ', 'семь ', 'восемь ', 'девять ', 'десять ', 'одинадцать ',
    'двенадцать ', 'тринадцать ', 'четырнадцать ', 'пятнадцать ', 'шестнадцать ',
    'семнадцать ', 'восемнадцать ', 'девятнадцать ');
  NumEd1: array[1..2] of string = ('одна ', 'две ');
  NumDec: array[2..9] of string = ('двадцать ', 'тридцать ', 'сорок ', 'пятьдесят ', 'шестьдесят ', 'семьдесят ', 'восемьдесят ', 'девяносто ');
  NumSot: array[1..9] of string = ('сто ', 'двести ', 'триста ', 'четыреста ', 'пятьсот ', 'шестьсот ', 'семьсот ', 'восемьсот ', 'девятьсот ');
  Xlion0: array[1..3] of string = ('тысяч ', 'миллионов ', 'миллиардов ');
  Xlion1: array[1..3] of string = ('тысяча ', 'миллион ', 'миллиард ');
  Xlion2: array[1..3] of string = ('тысячи ', 'миллиона ', 'миллиарда ');

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

function Propis(Value: int64): string;
var
  Rend: boolean;
  ValueTemp, ValueOst: int64;

  procedure Num(Value: byte);
  begin
    case Value of
      1: if Rend = true then Result := Result + 'один ' else Result := Result + 'одна ';
      2: if Rend = true then Result := Result + 'два ' else Result := Result + 'две ';
      3: Result := Result + 'три ';
      4: Result := Result + 'четыре ';
      5: Result := Result + 'пять ';
      6: Result := Result + 'шесть ';
      7: Result := Result + 'семь ';
      8: Result := Result + 'восемь ';
      9: Result := Result + 'девять ';
      10: Result := Result + 'десять ';
      11: Result := Result + 'одиннадцать ';
      12: Result := Result + 'двенадцать ';
      13: Result := Result + 'тринадцать ';
      14: Result := Result + 'четырнадцать ';
      15: Result := Result + 'пятнадцать ';
      16: Result := Result + 'шестнадцать ';
      17: Result := Result + 'семнадцать ';
      18: Result := Result + 'восемнадцать ';
      19: Result := Result + 'девятнадцать ';
    end
  end;

  procedure Num10(Value: byte);
  begin
    case Value of
      2: Result := Result + 'двадцать ';
      3: Result := Result + 'тридцать ';
      4: Result := Result + 'сорок ';
      5: Result := Result + 'пятьдесят ';
      6: Result := Result + 'шестьдесят ';
      7: Result := Result + 'семьдесят ';
      8: Result := Result + 'восемьдесят ';
      9: Result := Result + 'девяносто ';
    end;
  end;

  procedure Num100(Value: byte);
  begin
    case Value of
      1: Result := Result + 'сто ';
      2: Result := Result + 'двести ';
      3: Result := Result + 'триста ';
      4: Result := Result + 'четыреста ';
      5: Result := Result + 'пятьсот ';
      6: Result := Result + 'шестьсот ';
      7: Result := Result + 'семьсот ';
      8: Result := Result + 'восемьсот ';
      9: Result := Result + 'девятьсот ';
    end
  end;

  procedure Num00;
  begin
    Num100(ValueTemp div 100);
    ValueTemp := ValueTemp mod 100;
    if ValueTemp < 20 then Num(ValueTemp)
    else
    begin
      Num10(ValueTemp div 10);
      ValueTemp := ValueTemp mod 10;
      Num(ValueTemp);
    end;
  end;

  procedure NumMult(Mult: int64; s1, s2, s3: string);
  var ValueRes: int64;
  begin
    if Value >= Mult then
    begin
      ValueTemp := Value div Mult;
      ValueRes := ValueTemp;
      Num00;
      if ValueTemp = 1 then Result := Result + s1
      else if (ValueTemp > 1) and (ValueTemp < 5) then Result := Result + s2
      else Result := Result + s3;
      Value := Value - Mult * ValueRes;
    end;
  end;

begin
  if (Value = 0) then Result := 'ноль'
  else
  begin
    Result := '';
    Rend := true;
    NumMult(1000000000000, 'триллион ', 'триллиона ', 'триллионов ');
    NumMult(1000000000, 'миллиард ', 'миллиарда ', 'миллиардов ');
    NumMult(1000000, 'миллион ', 'миллиона ', 'миллионов ');
    Rend := false;
    NumMult(1000, 'тысяча ', 'тысячи ', 'тысяч ');
    Rend := true;
    ValueTemp := Value;
    Num00;
  end;
end;

procedure Fst(S: string; Var  S1: string; Var  S2: string; Var  S3: string);
var
  pos: integer;
begin
  S1 := '';
  S2 := '';
  S3 := '';

  pos := 1;

  while ((pos <= Length(S))and(S[pos] <> ';'))do
  begin
    S1 := S1 + S[pos];
    inc(pos);
  end;
  inc(pos);

  while ((pos <= Length(S))and(S[pos] <> ';'))do
  begin
    S2 := S2 + S[pos];
    inc(pos);
  end;
  inc(pos);

  while ((pos <= Length(S))and(S[pos] <> ';'))do
  begin
    S3 := S3 + S[pos];
    inc(pos);
  end;
  inc(pos);
end;

function Ruble(Value: int64; Skl: string): string;
var
  hk10, hk20: integer;
  Skl1,Skl2,Skl3: string;
begin
  Fst(Skl,Skl1,Skl2,Skl3);
  Result:=Propis(Value);
  hk10 := Value mod 10;
  hk20 := Value mod 100;
  if (hk20 > 10) and (hk20 < 20) then result := result + Skl3
  else if (hk10 = 1) then result := result + Skl1
  else if (hk10 > 1) and (hk10 < 5) then result := result + Skl2
  else result := result + Skl3;
end;

function Kopeika(Value: integer; Skp: string): string;
var
  hk10, hk20: integer;
  Skp1,Skp2,Skp3: string;
begin
  Fst(Skp,Skp1,Skp2,Skp3);
  Result:=Propis(Value);
  hk10 := Value mod 10;
  hk20 := Value mod 100;
  if (hk20 > 10) and (hk20 < 20) then result := result + Skp3
  else if (hk10 = 1) then result := result + Skp1
  else if (hk10 > 1) and (hk10 < 5) then result := result + Skp2
  else result := result + Skp3;
end;

function MoneyStr(Money: Double; Skl, Skp: string; PrintKop: Boolean = False): string;
var
  Money3, MoneyI, MoneyK, Digit, LastDigit, T: Integer;
  hr10, hr20, hk10, hk20: Integer;
  Skl1,Skl2,Skl3: string;
  Skp1,Skp2,Skp3: string;
  Sto, Kop: string;
begin
  Result := '';
  MoneyI := Trunc(Money);
  MoneyK := Round((Money - MoneyI) * 100);
  T := 0;
  while MoneyI > 0 do begin
    Money3 := MoneyI mod 1000;
    MoneyI := MoneyI div 1000;
    Sto := '';
    if (Money3 mod 100) < 20 then begin
      LastDigit := Money3 mod 20;
      if LastDigit > 0 then
        if (T = 1) and (LastDigit in [1..2]) then Sto := NumEd1[LastDigit]
        else Sto := NumEd[LastDigit];
      Money3 := Money3 div 100;
    end else begin
      LastDigit := Money3 mod 10;
      if LastDigit > 0 then
        if (T = 1) and (LastDigit in [1..2]) then Sto := NumEd1[LastDigit]
        else Sto := NumEd[LastDigit];
      Money3 := Money3 div 10;
      Digit := Money3 mod 10;
      if Digit > 0 then Sto := NumDec[Digit] + Sto;
      Money3 := Money3 div 10;
    end;
    if Money3 > 0 then Sto := NumSot[Money3] + Sto;
    if T > 0 then begin
      if LastDigit = 1 then Sto := Sto + Xlion1[T]
      else if LastDigit in [2..4] then Sto := Sto + Xlion2[T]
      else Sto := Sto + Xlion0[T];
    end;
    T := T + 1;
    Result := Sto + Result;
  end;
  Kop := IntToStr(MoneyK mod 10);
  MoneyK := MoneyK div 10;
  Kop := IntToStr(MoneyK) + Kop;
  //Result := Result + 'руб. ' + Kop + ' коп.';

  Fst(Skl, Skl1, Skl2, Skl3);
  MoneyI := Trunc(Money);
  hr10 := MoneyI mod 10;
  hr20 := MoneyI mod 100;
  if (hr20 > 10) and (hr20 < 20) then
    Result := Result + Skl3
  else if (hr10 = 1) then
    Result := Result + Skl1
  else if (hr10 > 1) and (hr10 < 5) then
    Result := Result + Skl2
  else
    Result := Result + Skl3;

  MoneyK := Round((Money - MoneyI) * 100);
  if (not PrintKop) or (Skp = '') then begin
    Fst(Skp, Skp1, Skp2, Skp3);
    hk10 := MoneyK mod 10;
    hk20 := MoneyK mod 100;
    if (hk20 > 10) and (hk20 < 20) then
      Result := Result + ' ' + Kop + ' ' + Skp3
    else if (hk10 = 1) and (hk20 <> 11) then
      Result := Result + ' ' + Kop + ' ' + Skp1
    else if (hk10 > 1) and (hk10 < 5) then
      Result := Result + ' ' + Kop + ' ' + Skp2
    else
      Result := Result + ' ' + Kop + ' ' + Skp3;
    Exit;
  end else begin
    Result := Result + ' ' + Kopeika(MoneyK, Skp);
  end;
end;

{ TFunctions }
constructor TFunctions.Create;
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddMethod('function Propis(Value: Int64): string',
      CallMethod, 'Мои функции', 'Функция Propis возвращает число прописью');
    AddMethod('function Ruble(Value: int64; Skl: string): string',
      CallMethod, 'Мои функции', 'Функция Ruble возвращает деньги прописью');
    AddMethod('function Kopeika(Value: integer; Skp: string): string',
      CallMethod, 'Мои функции', 'Функция Kopeika возвращает копейки прописью');
    AddMethod('function Money(Value: Double; Skl, Skp: string; PrintKop: Boolean): string',
      CallMethod, 'Мои функции', 'Функция Money возвращает сумму прописью');
    AddMethod('function DateOfPeriod(Value: Integer): Double',
      CallMethod, 'Мои функции', 'Функция DateOfPeriod возвращает дату по индексу периода');
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; var Params: Variant): Variant;
begin
  if MethodName = 'PROPIS' then
    Result := Propis(Params[0]);
  if MethodName = 'RUBLE' then
    Result := Ruble(Params[0], Params[1]);
  if MethodName = 'KOPEIKA' then
    Result := Kopeika(Params[0], Params[1]);
  if MethodName = 'MONEY' then
    Result := MoneyStr(Params[0], Params[1], Params[2], Params[3]);
  if MethodName = 'DATEOFPERIOD' then
    Result := DateOfPeriod(Params[0]);
end;

initialization
  fsRTTIModules.Add(TFunctions);
end.

