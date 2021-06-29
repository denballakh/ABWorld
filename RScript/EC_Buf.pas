unit EC_Buf;

interface

uses Windows, Messages, Forms, MMSystem, SysUtils, Math, EC_File, EC_Mem;//,EC_Struct;

type
TBufEC = class(TObject)
    public
		m_Len:integer;
        m_Max:integer;
		m_Sme:integer;
		m_Buf:Pointer;
    public
        constructor Create;
        destructor Destroy; override;

        procedure Clear;

		procedure SetLenData(lendata:integer);
		property Buf:Pointer read m_Buf;
        property Len:integer read m_Len write SetLenData;

		function TestStart:boolean;
		function TestEnd:boolean;

		procedure BPointerAdd(zn:integer);
		procedure BPointerSet(zn:integer);
		property BPointer:integer read m_Sme write BPointerSet;

	private
		procedure TestAddLenBuf(addlen:integer); overload;
		procedure TestAddLenBuf(sme,addlen:integer); overload;
		procedure TestGet(len:integer); overload;
		procedure TestGet(sme,len:integer); overload;

    public
		procedure S(sme:integer; b:Pointer; len:Integer); overload;
		procedure S(sme:integer; const str:AnsiString); overload;
		procedure S(sme:integer; const str:WideString); overload;
		procedure SN0(sme:integer; const str:AnsiString); overload;
		procedure SN0(sme:integer; const str:WideString); overload;
		procedure S(sme:integer; zn:BYTE); overload;
		procedure S(sme:integer; zn:AnsiChar); overload;
		procedure S(sme:integer; zn:WideChar); overload;
		procedure S(sme:integer; zn:WORD); overload;
		procedure S(sme:integer; zn:smallint); overload;
		procedure S(sme:integer; zn:DWORD); overload;
		procedure S(sme:integer; zn:integer); overload;
		procedure S(sme:integer; zn:single); overload;
		procedure S(sme:integer; zn:double); overload;

		procedure Add(b:Pointer; len:Integer); overload;
		procedure Add(const str:AnsiString); overload;
		procedure Add(const str:WideString); overload;
		procedure AddN0(const str:AnsiString); overload;
		procedure AddN0(const str:WideString); overload;
		procedure Add(zn:BYTE); overload;
		procedure Add(zn:AnsiChar); overload;
		procedure Add(zn:WideChar); overload;
		procedure Add(zn:WORD); overload;
		procedure Add(zn:smallint); overload;
		procedure Add(zn:DWORD); overload;
		procedure Add(zn:integer); overload;
		procedure Add(zn:single); overload;
		procedure Add(zn:double); overload;

		procedure AddBYTE(zn:BYTE); overload;
		procedure AddWORD(zn:WORD); overload;
		procedure AddDWORD(zn:DWORD); overload;
        procedure AddInteger(zn:integer); overload;
		procedure AddSingle(zn:single); overload;
		procedure AddDouble(zn:double); overload;
        procedure AddBoolean(zn:boolean); overload;
        procedure AddBuf(zn:TBufEC); overload;

		function Get(sme:integer; b:Pointer; len:integer):Pointer; overload;
		function Get(sme:integer; s:PAnsiChar):PAnsiChar; overload;
		function Get(sme:integer; s:PWideChar):PWideChar; overload;
		function GetBYTE(sme:integer):BYTE; overload;
		function GetAnsiChar(sme:integer):AnsiChar; overload;
		function GetWideChar(sme:integer):WideChar; overload;
		function GetWORD(sme:integer):WORD; overload;
		function GetSmallint(sme:integer):smallint; overload;
		function GetDWORD(sme:integer):DWORD; overload;
		function GetInteger(sme:integer):integer; overload;
		function GetSingle(sme:integer):single; overload;
		function GetDouble(sme:integer):double; overload;
        function GetBoolean(sme:integer):boolean; overload;

		function Get(b:Pointer; len:integer):Pointer; overload;
		function Get(s:PAnsiChar):PAnsiChar; overload;
		function Get(s:PWideChar):PWideChar; overload;
		function GetBYTE:BYTE; overload;
		function GetAnsiChar:AnsiChar; overload;
		function GetWideChar:WideChar; overload;
		function GetWORD:WORD; overload;
		function GetSmallint:smallint; overload;
		function GetDWORD:DWORD; overload;
		function GetInteger:integer; overload;
		function GetSingle:single; overload;
		function GetDouble:double; overload;
		function GetBoolean:boolean; overload;
        procedure GetBuf(tbuf:TBufEC); overload;

		function GetLenAnsiStr:integer; overload;
		function GetLenAnsiStr(sme:integer):integer; overload;
		function GetLenWideStr:integer; overload;
		function GetLenWideStr(sme:integer):integer; overload;

		function GetLenAnsiTextStr:integer; overload;
		function GetLenAnsiTextStr(sme:integer):integer; overload;
		function GetLenWideTextStr:integer; overload;
		function GetLenWideTextStr(sme:integer):integer; overload;

        function GetAnsiTextStr(s:PAnsiChar):PAnsiChar; overload;
        function GetAnsiTextStr(sme:integer; s:PAnsiChar):PAnsiChar; overload;
        function GetAnsiTextStr: AnsiString; overload;
        function GetAnsiStr: AnsiString; overload;

        function GetWideTextStr(s:PWideChar):PWideChar; overload;
        function GetWideTextStr(sme:integer; s:PWideChar):PWideChar; overload;
        function GetWideTextStr: WideString; overload;
        function GetWideStr: WideString; overload;

//        function Compress(fSpeed:boolean=false):boolean;
//        function UnCompress:boolean;

//        procedure ProtectRnd(zn:integer); overload;
//        procedure ProtectRnd(zn:integer; smestart,smeend:integer); overload;
//        function CalcCRC:DWORD; overload;
//        function CalcCRC(smestart,smeend:integer):DWORD; overload;

        procedure LoadFromFile(fa:TFileEC; plen:integer); overload;
        procedure LoadFromFile(fa:TFileEC); overload;
        procedure LoadFromFile(filename:PChar); overload;

        procedure SaveInFile(fa:TFileEC; plen:integer); overload;
        procedure SaveInFile(fa:TFileEC); overload;
        procedure SaveInFile(filename:PChar); overload;
end;

implementation

constructor TBufEC.Create;
begin
    inherited Create;
end;

destructor TBufEC.Destroy;
begin
    Clear;
    inherited Destroy;
end;

procedure TBufEC.Clear;
begin
	if m_Buf<>nil then begin
		FreeEC(Buf);
		m_Buf:=nil;
	end;
	m_Len:=0;
    m_Max:=0;
	m_Sme:=0;
end;

procedure TBufEC.SetLenData(lendata:integer);
begin
	if lendata<1 then begin
		Clear();
	end else begin
		m_Len:=lendata;
        m_Max:=lendata+256;
		m_Buf:=ReAllocREC(m_Buf,m_Max);
		if m_Sme>m_Len then m_Sme:=m_Len;
	end;
end;

function TBufEC.TestStart:boolean;
begin
    if m_Sme=0 then Result:=true else Result:=false;
end;

function TBufEC.TestEnd:boolean;
begin
    if m_Sme>=m_Len then Result:=true else Result:=false;
end;

procedure TBufEC.BPointerAdd(zn:integer);
begin
	if (m_Sme+zn<0) or (m_Sme+zn>m_Len) then raise Exception.Create('TBufEC.PointerAdd. zn=' + IntToStr(zn));
	m_Sme:=m_Sme+zn;
end;

procedure TBufEC.BPointerSet(zn:integer);
begin
	if (zn<0) or (zn>m_Len) then raise Exception.Create('TBufEC.PointerSet. zn=' + IntToStr(zn));
	m_Sme:=zn;
end;

procedure TBufEC.TestAddLenBuf(addlen:integer);
begin
	if addlen<1 then raise Exception.Create('TBufEC.TestAddLenBuf. addlen=' + IntToStr(addlen));
	if m_Sme+addlen>m_Len then begin
		m_Len:=m_Sme+addlen;
        if m_Len>m_Max then begin
            m_Max:=m_Len+256;
    		m_Buf:=ReAllocREC(m_Buf,m_Max);
        end;
	end;
end;

procedure TBufEC.TestAddLenBuf(sme,addlen:integer);
begin
	if (addlen<1) or (sme<0) or (sme>m_Len) then raise Exception.Create('TBufEC.TestAddLenBuf. sme=' + IntToStr(sme) + ' addlen=' + IntToStr(addlen));
	if sme+addlen>m_Len then begin
		m_Len:=sme+addlen;
        if m_Len>m_Max then begin
            m_Max:=m_Len+256;
    		m_Buf:=ReAllocREC(m_Buf,m_Max);
        end;
	end;
end;

procedure TBufEC.TestGet(len:integer);
begin
	if (len<1) or ((m_Sme+len)>m_Len) then raise Exception.Create('TBufEC.TestGet. len=' + IntToStr(len));
end;

procedure TBufEC.TestGet(sme,len:integer);
begin
	if (len<1) or ((sme+len)>m_Len) then raise Exception.Create('TBufEC.TestGet. sme=' + IntToStr(sme) + ' len=' + IntToStr(len));
end;

////////////////////////////////////////////////////////////////////////////////
procedure TBufEC.S(sme:integer; b:Pointer; len:Integer);
begin
    TestAddLenBuf(sme,len);
    CopyMemory(Ptr(DWORD(Buf)+DWORD(sme)),b,len);
end;

procedure TBufEC.S(sme:integer; const str:AnsiString);
var
    len:integer;
begin
    len:=Length(str);
    TestAddLenBuf(sme,len+1);
    CopyMemory(Ptr(DWORD(Buf)+DWORD(sme)),PAnsiChar(str),len+1);
end;

procedure TBufEC.S(sme:integer; const str:WideString);
var
    len:integer;
begin
    len:=Length(str)*2;
    TestAddLenBuf(sme,len+2);
    CopyMemory(Ptr(DWORD(Buf)+DWORD(sme)),PWideChar(str),len+2);
end;

procedure TBufEC.SN0(sme:integer; const str:AnsiString);
var
    len:integer;
begin
    len:=Length(str);
    TestAddLenBuf(sme,len);
    CopyMemory(Ptr(DWORD(Buf)+DWORD(sme)),PAnsiChar(str),len);
end;

procedure TBufEC.SN0(sme:integer; const str:WideString);
var
    len:integer;
begin
    len:=Length(str)*2;
    TestAddLenBuf(sme,len);
    CopyMemory(Ptr(DWORD(Buf)+DWORD(sme)),PWideChar(str),len);
end;

procedure TBufEC.S(sme:integer; zn:BYTE);
begin
    TestAddLenBuf(sme,sizeof(BYTE));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:AnsiChar);
begin
    TestAddLenBuf(sme,sizeof(AnsiChar));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:WideChar);
begin
    TestAddLenBuf(sme,sizeof(WideChar));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:WORD);
begin
    TestAddLenBuf(sme,sizeof(WORD));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:smallint);
begin
    TestAddLenBuf(sme,sizeof(smallint));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:DWORD);
begin
    TestAddLenBuf(sme,sizeof(DWORD));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:integer);
begin
    TestAddLenBuf(sme,sizeof(integer));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:single);
begin
    TestAddLenBuf(sme,sizeof(single));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

procedure TBufEC.S(sme:integer; zn:double);
begin
    TestAddLenBuf(sme,sizeof(double));
    PSet(Ptr(DWORD(Buf)+DWORD(sme)),zn);
end;

////////////////////////////////////////////////////////////////////////////////
procedure TBufEC.Add(b:Pointer; len:Integer);
begin
    TestAddLenBuf(len);
    CopyMemory(PAdd(Buf,m_Sme),b,len);
    m_Sme:=m_Sme+len;
end;

procedure TBufEC.Add(const str:AnsiString);
var
    len:integer;
begin
    len:=Length(str);
    TestAddLenBuf(len+1);
    CopyMemory(PAdd(Buf,m_Sme),PAnsiChar(str),len+1);
    m_Sme:=m_Sme+len+1;
end;

procedure TBufEC.Add(const str:WideString);
var
    len:integer;
begin
    len:=Length(str)*2;
    TestAddLenBuf(len+2);
    CopyMemory(PAdd(Buf,m_Sme),PWideChar(str),len+2);
    m_Sme:=m_Sme+len+2;
end;

procedure TBufEC.AddN0(const str:AnsiString);
var
    len:integer;
begin
    len:=Length(str);
    if len>0 then begin
        TestAddLenBuf(len);
        CopyMemory(PAdd(Buf,m_Sme),PAnsiChar(str),len);
        m_Sme:=m_Sme+len;
    end;
end;

procedure TBufEC.AddN0(const str:WideString);
var
    len:integer;
begin
    len:=Length(str)*2;
    if len>0 then begin
        TestAddLenBuf(len);
        CopyMemory(PAdd(Buf,m_Sme),PWideChar(str),len);
        m_Sme:=m_Sme+len;
    end;
end;

procedure TBufEC.Add(zn:BYTE);
begin
    TestAddLenBuf(sizeof(BYTE));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(BYTE);
end;

procedure TBufEC.Add(zn:AnsiChar);
begin
    TestAddLenBuf(sizeof(AnsiChar));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(AnsiChar);
end;

procedure TBufEC.Add(zn:WideChar);
begin
    TestAddLenBuf(sizeof(WideChar));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(WideChar);
end;

procedure TBufEC.Add(zn:WORD);
begin
    TestAddLenBuf(sizeof(WORD));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(WORD);
end;

procedure TBufEC.Add(zn:smallint);
begin
    TestAddLenBuf(sizeof(smallint));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(smallint);
end;

procedure TBufEC.Add(zn:DWORD);
begin
    TestAddLenBuf(sizeof(DWORD));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(DWORD);
end;

procedure TBufEC.Add(zn:integer);
begin
    TestAddLenBuf(sizeof(integer));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(integer);
end;

procedure TBufEC.Add(zn:single);
begin
    TestAddLenBuf(sizeof(single));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(single);
end;

procedure TBufEC.Add(zn:double);
begin
    TestAddLenBuf(sizeof(double));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(double);
end;

procedure TBufEC.AddBYTE(zn:BYTE);
begin
    TestAddLenBuf(sizeof(BYTE));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(BYTE);
end;

procedure TBufEC.AddWORD(zn:WORD);
begin
    TestAddLenBuf(sizeof(WORD));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(WORD);
end;

procedure TBufEC.AddDWORD(zn:DWORD);
begin
    TestAddLenBuf(sizeof(DWORD));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(DWORD);
end;

procedure TBufEC.AddInteger(zn:integer);
begin
    TestAddLenBuf(sizeof(integer));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(integer);
end;

procedure TBufEC.AddSingle(zn:single);
begin
    TestAddLenBuf(sizeof(single));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(single);
end;

procedure TBufEC.AddDouble(zn:double);
begin
    TestAddLenBuf(sizeof(double));
    PSet(PAdd(Buf,m_Sme),zn);
    m_Sme:=m_Sme+sizeof(double);
end;

procedure TBufEC.AddBoolean(zn:boolean);
begin
    TestAddLenBuf(sizeof(BYTE));
    PSet(PAdd(Buf,m_Sme),BYTE(zn));
    m_Sme:=m_Sme+sizeof(BYTE);
end;

procedure TBufEC.AddBuf(zn:TBufEC);
begin
    AddDWORD(zn.Len);
    if zn.Len>0 then begin
        Add(zn.Buf,zn.Len);
    end;
end;

////////////////////////////////////////////////////////////////////////////////
function TBufEC.Get(sme:integer; b:Pointer; len:integer):Pointer;
begin
    TestGet(sme,len);
    CopyMemory(b,Ptr(DWORD(Buf)+DWORD(sme)),len);
    Result:=b;
end;

function TBufEC.Get(sme:integer; s:PAnsiChar):PAnsiChar;
var
    len:integer;
begin
    len:=GetLenAnsiStr(sme);
    if len>0 then begin
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(sme)),len+1);
    end else begin
        s[0]:=char(0);
    end;
    Result:=s;
end;

function TBufEC.Get(sme:integer; s:PWideChar):PWideChar;
var
    len:integer;
begin
    len:=GetLenWideStr(sme);
    if len>0 then begin
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(sme)),len*2+2);
    end else begin
        s[0]:=WideChar(0);
    end;
    Result:=s;
end;

function TBufEC.GetBYTE(sme:integer):BYTE;
begin
    TestGet(sme,sizeof(BYTE));
    Result:=PGetBYTE(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetAnsiChar(sme:integer):AnsiChar;
begin
    TestGet(sme,sizeof(AnsiChar));
    Result:=PGetAnsiChar(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetWideChar(sme:integer):WideChar;
begin
    TestGet(sme,sizeof(WideChar));
    Result:=PGetWideChar(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetWORD(sme:integer):WORD;
begin
    TestGet(sme,sizeof(WORD));
    Result:=PGetWORD(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetSmallint(sme:integer):smallint;
begin
    TestGet(sme,sizeof(smallint));
    Result:=PGetSmallint(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetDWORD(sme:integer):DWORD;
begin
    TestGet(sme,sizeof(DWORD));
    Result:=PGetDWORD(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetInteger(sme:integer):integer;
begin
    TestGet(sme,sizeof(Integer));
    Result:=PGetInteger(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetSingle(sme:integer):single;
begin
    TestGet(sme,sizeof(single));
    Result:=PGetSingle(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetDouble(sme:integer):double;
begin
    TestGet(sme,sizeof(double));
    Result:=PGetDouble(Ptr(DWORD(m_Buf)+DWORD(sme)));
end;

function TBufEC.GetBoolean(sme:integer):boolean;
begin
    TestGet(sme,sizeof(BYTE));
    Result:=Boolean(PGetBYTE(Ptr(DWORD(m_Buf)+DWORD(sme))));
end;

////////////////////////////////////////////////////////////////////////////////
function TBufEC.Get(b:Pointer; len:integer):Pointer;
begin
    TestGet(len);
    CopyMemory(b,PAdd(Buf,m_Sme),len);
    m_Sme:=m_Sme+len;
    Result:=b;
end;

function TBufEC.Get(s:PAnsiChar):PAnsiChar;
var
    len:integer;
begin
    len:=GetLenAnsiStr(m_Sme);
    if len>0 then begin
        TestGet(len+1);
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(m_Sme)),len+1);
        m_Sme:=m_Sme+len+1;
    end else begin
        s[0]:=Char(0);
    end;
    Result:=s;
end;

function TBufEC.Get(s:PWideChar):PWideChar;
var
    len:integer;
begin
    len:=GetLenWideStr(m_Sme);
    if len>0 then begin
        TestGet(len*2+2);
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(m_Sme)),len*2+2);
        m_Sme:=m_Sme+len*2+2;
    end else begin
        m_Sme:=m_Sme+2;
        s[0]:=WideChar(0);
    end;
    Result:=s;
end;

function TBufEC.GetBYTE:BYTE;
begin
    TestGet(sizeof(BYTE));
//    Result:=PGetBYTE(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
//    m_Sme:=m_Sme+sizeof(BYTE);

    asm
        push    eax
        push    ebx
        push    edi

        mov     ebx,self
        mov     eax,TBufEC(ebx).m_Sme
        mov     edi,TBufEC(ebx).m_Buf
        inc     TBufEC(ebx).m_Sme
        mov     al,[edi+eax]
        mov     Result,al

        pop     edi
        pop     ebx
        pop     eax
    end;

end;

function TBufEC.GetAnsiChar:AnsiChar;
begin
    TestGet(sizeof(AnsiChar));
    Result:=PGetAnsiChar(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
    m_Sme:=m_Sme+sizeof(AnsiChar);
end;

function TBufEC.GetWideChar:WideChar;
begin
    TestGet(sizeof(WideChar));
    Result:=PGetWideChar(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
    m_Sme:=m_Sme+sizeof(WideChar);
end;

function TBufEC.GetWORD:WORD;
begin
    TestGet(sizeof(WORD));
//    Result:=PGetWORD(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
//    m_Sme:=m_Sme+sizeof(WORD);
    asm
        push    eax
        push    ebx
        push    edi

        mov     ebx,self
        mov     eax,TBufEC(ebx).m_Sme
        mov     edi,TBufEC(ebx).m_Buf
        add     TBufEC(ebx).m_Sme,2
        mov     ax,[edi+eax]
        mov     Result,ax

        pop     edi
        pop     ebx
        pop     eax
    end;
end;

function TBufEC.GetSmallint:smallint;
begin
    TestGet(sizeof(smallint));
    Result:=PGetSmallint(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
    m_Sme:=m_Sme+sizeof(smallint);
end;

function TBufEC.GetDWORD:DWORD;
begin
    TestGet(sizeof(DWORD));
//    Result:=PGetDWORD(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
//    m_Sme:=m_Sme+sizeof(DWORD);
    asm
        push    eax
        push    ebx
        push    edi

        mov     ebx,self
        mov     eax,TBufEC(ebx).m_Sme
        mov     edi,TBufEC(ebx).m_Buf
        add     TBufEC(ebx).m_Sme,4
        mov     eax,[edi+eax]
        mov     Result,eax

        pop     edi
        pop     ebx
        pop     eax
    end;
end;

function TBufEC.GetInteger:integer;
begin
    TestGet(sizeof(Integer));
//    Result:=PGetInteger(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
//    m_Sme:=m_Sme+sizeof(integer);
    asm
        push    eax
        push    ebx
        push    edi

        mov     ebx,self
        mov     eax,TBufEC(ebx).m_Sme
        mov     edi,TBufEC(ebx).m_Buf
        add     TBufEC(ebx).m_Sme,4
        mov     eax,[edi+eax]
        mov     Result,eax

        pop     edi
        pop     ebx
        pop     eax
    end;
end;

function TBufEC.GetSingle:single;
begin
    TestGet(sizeof(single));
//    Result:=PGetSingle(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
//    m_Sme:=m_Sme+sizeof(single);
    asm
        push    eax
        push    ebx
        push    edi

        mov     ebx,self
        mov     eax,TBufEC(ebx).m_Sme
        mov     edi,TBufEC(ebx).m_Buf
        add     TBufEC(ebx).m_Sme,4
        mov     eax,[edi+eax]
        mov     Result,eax

        pop     edi
        pop     ebx
        pop     eax
    end;
end;

function TBufEC.GetDouble:double;
begin
    TestGet(sizeof(double));
    Result:=PGetDouble(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
    m_Sme:=m_Sme+sizeof(double);
end;

function TBufEC.GetBoolean:boolean;
begin
    TestGet(sizeof(BYTE));
//    Result:=Boolean(PGetBYTE(Ptr(DWORD(m_Buf)+DWORD(m_Sme))));
//    m_Sme:=m_Sme+sizeof(BYTE);
    asm
        push    eax
        push    ebx
        push    edi

        mov     ebx,self
        mov     eax,TBufEC(ebx).m_Sme
        mov     edi,TBufEC(ebx).m_Buf
        inc     TBufEC(ebx).m_Sme
        mov     al,[edi+eax]
        mov     Result,al

        pop     edi
        pop     ebx
        pop     eax
    end;
end;

procedure TBufEC.GetBuf(tbuf:TBufEC);
var
    tlen:integer;
begin
    tlen:=GetDWORD;
    tbuf.Len:=tlen;//Len;
    if tlen>0 then begin
        Get(tbuf.Buf,tlen);
    end;
end;

////////////////////////////////////////////////////////////////////////////////
function TBufEC.GetLenAnsiStr:integer;
begin
    Result:=GetLenAnsiStr(m_Sme);
end;

function TBufEC.GetLenAnsiStr(sme:integer):integer;
var
    len,i:integer;
begin
    i:=sme;
    len:=0;
    while i<m_Len do begin
        if PGetBYTE(PAdd(m_Buf,i))=0 then begin
            Result:=len;
            Exit;
        end;
        Inc(len);
        Inc(i);
    end;
    Result:=len;
end;

function TBufEC.GetLenWideStr:integer;
begin
    Result:=GetLenWideStr(m_Sme);
end;

function TBufEC.GetLenWideStr(sme:integer):integer;
var
    len,i:integer;
begin
    i:=sme;
    len:=0;
    while i+1<m_Len do begin
        if PGetWORD(PAdd(m_Buf,i))=0 then begin
            Result:=len;
            Exit;
        end;
        Inc(len);
        Inc(i,2);
    end;
    Result:=len;
end;

////////////////////////////////////////////////////////////////////////////////
function TBufEC.GetLenAnsiTextStr:integer;
begin
    Result:=GetLenAnsiTextStr(m_Sme);
end;

function TBufEC.GetLenAnsiTextStr(sme:integer):integer;
var
    len,i:integer;
    sim:BYTE;
begin
    i:=sme;
    len:=0;
    while i<m_Len do begin
        sim:=PGetBYTE(PAdd(m_Buf,i));
        if (sim=0) or (sim=$0d) or (sim=$0a) then begin
            Result:=len;
            Exit;
        end;
        Inc(len);
        Inc(i);
    end;
    Result:=len;
end;

function TBufEC.GetLenWideTextStr:integer;
begin
    Result:=GetLenWideTextStr(m_Sme);
end;

function TBufEC.GetLenWideTextStr(sme:integer):integer;
var
    len,i:integer;
    sim:WORD;
begin
    i:=sme;
    len:=0;
    while i+1<m_Len do begin
        sim:=PGetWORD(PAdd(m_Buf,i));
        if (sim=0) or (sim=$0d) or (sim=$0a) then begin
            Result:=len;
            Exit;
        end;
        Inc(len);
        Inc(i,2);
    end;
    Result:=len;
end;

////////////////////////////////////////////////////////////////////////////////
function TBufEC.GetAnsiTextStr(s:PAnsiChar):PAnsiChar;
var
    len:integer;
    sim:BYTE;
begin
    len:=GetLenAnsiTextStr;
    if len>0 then begin
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(m_Sme)),len);
        s[len]:=Char(0);
        m_Sme:=m_Sme+len;

    end else begin
        s[0]:=Char(0);
    end;
    if m_Sme<m_Len then begin
        sim:=PGetByte(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
        if (sim=0) or (sim=$0d) or (sim=$0a) then Inc(m_Sme);
        if m_Sme<m_Len then begin
            sim:=PGetByte(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
            if (sim=0) or (sim=$0d) or (sim=$0a) then Inc(m_Sme);
        end;
    end;
    Result:=s;
end;

function TBufEC.GetAnsiTextStr(sme:integer; s:PAnsiChar):PAnsiChar;
var
    len:integer;
begin
    len:=GetLenAnsiTextStr(sme);
    if len>0 then begin
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(sme)),len);
        s[len]:=Char(0);
    end else begin
        s[0]:=Char(0);
    end;
    Result:=s;
end;

function TBufEC.GetAnsiTextStr: AnsiString;
var
    len:integer;
begin
    len:=GetLenAnsiTextStr;
    if len>0 then begin
        SetLength(Result,len{+1});
        GetAnsiTextStr(PAnsiChar(Result));
    end else begin
        SetLength(Result,2);
        GetAnsiTextStr(PAnsiChar(Result));
        Result:='';
    end;
end;

function TBufEC.GetAnsiStr: AnsiString;
var
    len:integer;
begin
    len:=GetLenAnsiStr;
    if len>0 then begin
        SetLength(Result,len{+1});
        Get(PAnsiChar(Result));
    end else begin
        SetLength(Result,2);
        Get(PAnsiChar(Result));
        Result:='';
    end;
end;

function TBufEC.GetWideTextStr(s:PWideChar):PWideChar;
var
    len:integer;
    sim:WORD;
begin
    len:=GetLenWideTextStr;
    if len>0 then begin
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(m_Sme)),len*2);
        s[len]:=WideChar(0);
        m_Sme:=m_Sme+len*2;

    end else begin
        s[0]:=WideChar(0);
    end;
    if m_Sme+1<m_Len then begin
         sim:=PGetWORD(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
         if (sim=0) or (sim=$0d) or (sim=$0a) then Inc(m_Sme,2);
         if m_Sme+1<m_Len then begin
             sim:=PGetWORD(Ptr(DWORD(m_Buf)+DWORD(m_Sme)));
             if (sim=0) or (sim=$0d) or (sim=$0a) then Inc(m_Sme,2);
         end;
    end;
    Result:=s;
end;

function TBufEC.GetWideTextStr(sme:integer; s:PWideChar):PWideChar;
var
    len:integer;
begin
    len:=GetLenWideTextStr(sme);
    if len>0 then begin
        CopyMemory(s,Ptr(DWORD(m_Buf)+DWORD(sme)),len*2);
        s[len]:=WideChar(0);
    end else begin
        s[0]:=WideChar(0);
    end;
    Result:=s;
end;

function TBufEC.GetWideTextStr: WideString;
var
    len:integer;
begin
    len:=GetLenWideTextStr;
    if len>0 then begin
        SetLength(Result,len{+1});
        GetWideTextStr(PWideChar(Result));
    end else begin
        SetLength(Result,2);
        GetWideTextStr(PWideChar(Result));
        Result:='';
    end;
end;

function TBufEC.GetWideStr: WideString;
var
    len:integer;
begin
    len:=GetLenWideStr;
    if len>0 then begin
        SetLength(Result,len{+1});
        Get(PWideChar(Result));
        SetLength(Result,len);
    end else begin
        SetLength(Result,1);
        Get(PWideChar(@len));
        SetLength(Result,0);
        Result:='';
    end;
end;

{function TBufEC.Compress(fSpeed:boolean=false):boolean;
var
    fs,tlen:integer;
    tbuf:^BYTE;
begin
    fs:=0; if fSpeed=true then fs:=0;

    if m_Len<8 then begin
        Result:=false;
        Exit;
    end;
    tbuf:=AllocEC(m_Len);
    tlen:=OKGF_ZLib_Compress(tbuf,m_Buf,m_Len,fs);
    if tlen=0 then begin
        FreeEC(tbuf);
        Result:=false;
        Exit;
    end;
    FreeEC(m_Buf);
    m_Buf:=tbuf;
    m_Len:=tlen;
    m_Max:=tlen;
    m_Sme:=0;
    Result:=true;
end;

function TBufEC.UnCompress:boolean;
var
    tlen:integer;
    tbuf:^BYTE;
begin
    if m_Len<8 then begin
        Result:=false;
        Exit;
    end;
    tlen:=OKGF_ZLib_UnCompress(nil,0,m_Buf,m_Len);
    if tlen=0 then begin
        Result:=false;
        Exit;
    end;
    tbuf:=AllocEC(tlen);
    tlen:=OKGF_ZLib_UnCompress(tbuf,tlen,m_Buf,m_Len);
    if tlen=0 then begin
        FreeEC(tbuf);
        Result:=false;
        Exit;
    end;
    FreeEC(m_Buf);
    m_Buf:=tbuf;
    m_Len:=tlen;
    m_Max:=tlen;
    m_Sme:=0;
    Result:=true;
end;

procedure TBufEC.ProtectRnd(zn:integer);
var
	i,znRND:integer;
    buf:PBYTE;

    function NRND:integer;
    begin
		znRND:=16807*(znRND mod 127773)-2836*(znRND div 127773);
    	if znRND<=0 then znRND:=znRND+2147483647;
		Result:=znRND-1;
    end;
begin
	znRND:=zn;

    buf:=m_Buf;
    for i:=0 to m_Len-1 do begin
    	buf^:=(buf^) xor BYTE(NRND);
    	buf:=PBYTE(DWORD(buf)+1);
    end;
end;

procedure TBufEC.ProtectRnd(zn:integer; smestart,smeend:integer);
var
	i,znRND:integer;
    buf:PBYTE;

    function NRND:integer;
    begin
		znRND:=16807*(znRND mod 127773)-2836*(znRND div 127773);
    	if znRND<=0 then znRND:=znRND+2147483647;
		Result:=znRND-1;
    end;
begin
	znRND:=zn;

    buf:=PBYTE(DWORD(m_Buf)+DWORD(smestart));
    for i:=smestart to smeend-1 do begin
    	buf^:=(buf^) xor BYTE(NRND);
    	buf:=PBYTE(DWORD(buf)+1);
    end;
end;

function TBufEC.CalcCRC:DWORD;
begin
	Result:=CalcCRC32(m_Buf,m_Len);
end;

function TBufEC.CalcCRC(smestart,smeend:integer):DWORD;
begin
	Result:=CalcCRC32(Pointer(DWORD(m_Buf)+DWORD(smestart)),smeend-smestart);
end;}

////////////////////////////////////////////////////////////////////////////////
{procedure TBufEC.LoadFromFile(fa:TFileEC; plen:integer);
begin
    Clear;
    fa.Open;
    try
        Len:=plen;
        fa.Read(m_Buf,len);
    finally
        fa.Close;
    end;
end;}

procedure TBufEC.LoadFromFile(fa:TFileEC; plen:integer);
var
	zlen:integer;
    zbuf:Pointer;
begin
	Clear;
    fa.Open;
    try
        Len:=plen;
        zbuf:=m_Buf;

    	while plen>0 do begin
			zlen:=min(256*1024,plen);

	        fa.Read(zbuf,zlen);

            zbuf:=PAdd(zbuf,zlen);
            plen:=plen-zlen;
            if plen>0 then Sleep(1);
        end;
    finally
    	fa.Close;
    end;
end;

procedure TBufEC.LoadFromFile(fa:TFileEC);
var
    size:integer;
begin
    Clear;
    fa.Open;
    try
        size:=fa.GetSize-fa.GetPointer;
        Len:=size;
        fa.Read(m_Buf,size);
    finally
        fa.Close;
    end;
end;

procedure TBufEC.LoadFromFile(filename:PChar);
var
    fa:TFileEC;
begin
    fa:=TFileEC.Create;
    try
        fa.Init(filename);
        fa.OpenRead;
        LoadFromFile(fa);
    finally
        fa.Free;
    end;
end;

procedure TBufEC.SaveInFile(fa:TFileEC; plen:integer);
begin
    fa.CreateNew;
    try
        fa.Write(m_Buf,plen);
    finally
        fa.Close;
    end;
end;

procedure TBufEC.SaveInFile(fa:TFileEC);
begin
    fa.Write(m_Buf,m_Len);
end;

procedure TBufEC.SaveInFile(filename:PChar);
var
    fa:TFileEC;
begin
    fa:=TFileEC.Create;
    try
        fa.Init(filename);
        fa.CreateNew;
        SaveInFile(fa);
    finally
        fa.Free;
    end;
end;

end.
