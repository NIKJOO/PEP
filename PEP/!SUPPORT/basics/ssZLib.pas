

unit ssZLib;

interface


{$REGION 'zlib.h translation'}

type
  z_off_t = LongInt;
  z_off64_t = Int64;

  internal_state = record end;
  Pinternal_state = ^internal_state;

const
  ZLIB_VERSION: MarshaledAString = '1.2.7'; 
  ZLIB_VERNUM = $1270;
  ZLIB_VER_MAJOR = 1;
  ZLIB_VER_MINOR = 2;
  ZLIB_VER_REVSION = 7;
  ZLIB_VER_SUBREVISION = 0;




type

  alloc_func = function(opaque: Pointer; Items, Size: Cardinal): Pointer; cdecl;
  free_func = procedure(opaque, address: Pointer); cdecl;

  z_stream = record
    next_in: PByte;      
    avail_in: Cardinal;  
    total_in: LongWord;  
    next_out: PByte;     
    avail_out: Cardinal; 
    total_out: LongWord; 
    msg: MarshaledAString; 
    state: Pinternal_state; 
    zalloc: alloc_func;  
    zfree: free_func;    
    opaque: Pointer;     
    data_type: Integer;  
    adler: LongWord;     
    reserved: LongWord;  
  end;
  z_stream_s = z_stream;
  z_streamp = ^z_stream;



const
  Z_NO_FLUSH       = 0;
  Z_PARTIAL_FLUSH  = 1;
  Z_SYNC_FLUSH     = 2;
  Z_FULL_FLUSH     = 3;
  Z_FINISH         = 4;
  Z_BLOCK          = 5;
  Z_TREES          = 6;
 


  Z_OK             = 0;
  Z_STREAM_END     = 1;
  Z_NEED_DICT      = 2;
  Z_ERRNO          = (-1);
  Z_STREAM_ERROR   = (-2);
  Z_DATA_ERROR     = (-3);
  Z_MEM_ERROR      = (-4);
  Z_BUF_ERROR      = (-5);
  Z_VERSION_ERROR  = (-6);


  Z_NO_COMPRESSION          = 0;
  Z_BEST_SPEED              = 1;
  Z_BEST_COMPRESSION        = 9;
  Z_DEFAULT_COMPRESSION     = (-1);


  Z_FILTERED             = 1;
  Z_HUFFMAN_ONLY         = 2;
  Z_RLE                  = 3;
  Z_FIXED                = 4;
  Z_DEFAULT_STRATEGY     = 0;


  Z_BINARY    = 0;
  Z_TEXT      = 1;
  Z_ASCII     = Z_TEXT;  
  Z_UNKNOWN   = 2;
 


  Z_DEFLATED    = 8;

  Z_NULL   = 0;  


       
{$ENDREGION 'zlib.h translation'}

type
  TZAlloc = alloc_func;
  TZFree = free_func;
  TZCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);
  TCompressionLevel = (clNone = Integer(zcNone), clFastest, clDefault, clMax);

  TZStreamRec = z_stream;


{** zlib public routines ****************************************************}


function deflate(var strm: z_stream; flush: Integer): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'deflate'{$ENDIF};

function deflateEnd(var strm: z_stream): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'deflateEnd'{$ENDIF};

function inflate(var strm: z_stream; flush: Integer): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'inflate'{$ENDIF};

function deflateReset(var strm: z_stream): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'deflateReset'{$ENDIF};

function deflateParams(var strm: z_stream;
  level, strategy: Integer): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'deflateParams'{$ENDIF};

function inflateEnd(var strm: z_stream): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'inflateEnd'{$ENDIF};

function inflateReset(var strm: z_stream): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'inflateReset'{$ENDIF};

function deflateInit_(var strm: z_stream; level: Integer;
  version: MarshaledAString; stream_size: Integer): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'deflateInit_'{$ENDIF};
function inflateInit_(var strm: z_stream;
  version: MarshaledAString; stream_size: Integer): Integer; cdecl;
  external {$IFDEF POSIX} libzlib name _PU + 'inflateInit_'{$ENDIF};

 function deflateInit(var strm: z_stream; level: Integer): Integer;
function inflateInit(var strm: z_stream): Integer;



{$IFNDEF NEXTGEN}
procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TZCompressionLevel = zcDefault); overload;

procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TCompressionLevel); overload; inline;
{$ENDIF !NEXTGEN}


{$IFNDEF NEXTGEN}
procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer; outEstimate: Integer = 0); overload;
{$ENDIF !NEXTGEN}

function zlibAllocMem(AppData: Pointer; Items, Size: Cardinal): Pointer; cdecl;
procedure zlibFreeMem(AppData, Block: Pointer); cdecl;
procedure MoveI32(const Source; var Dest; Count: Integer); deprecated 'use System.Move';


const

  _z_errmsg: array [0..9] of MarshaledAString = (
    'need dictionary',      // Z_NEED_DICT      (2)  //do not localize
    'stream end',           // Z_STREAM_END     (1)  //do not localize
    '',                     // Z_OK             (0)  //do not localize
    'file error',           // Z_ERRNO          (-1) //do not localize
    'stream error',         // Z_STREAM_ERROR   (-2) //do not localize
    'data error',           // Z_DATA_ERROR     (-3) //do not localize
    'insufficient memory',  // Z_MEM_ERROR      (-4) //do not localize
    'buffer error',         // Z_BUF_ERROR      (-5) //do not localize
    'incompatible version', // Z_VERSION_ERROR  (-6) //do not localize
    ''                                               //do not localize
    );

  ZLevels: array[TZCompressionLevel] of Shortint = (
    Z_NO_COMPRESSION,
    Z_BEST_SPEED,
    Z_DEFAULT_COMPRESSION,
    Z_BEST_COMPRESSION
    );

  SZInvalid = 'Invalid ZStream operation!';

implementation

{$IFDEF MSWINDOWS}
  {$L deflate.obj}
  {$L inflate.obj}
  {$L inffast.obj}
  {$L inftrees.obj}
  {$L trees.obj}
  {$L adler32.obj}
  {$L crc32.obj}
  {$L zutil.obj}
{$ENDIF}

function deflateInit(var strm: z_stream; level: Integer): Integer;
begin
  Result := deflateInit_(strm, level,
    ZLIB_VERSION, SizeOf(z_stream));
end;

function inflateInit(var strm: z_stream): Integer;
begin
  Result := inflateInit_(strm,
    ZLIB_VERSION, SizeOf(z_stream));
end;

procedure MoveI32(const Source; var Dest; Count: Integer); register;
begin
  System.Move(Source, Dest, Count);
end;
{****************************************************************************}

function ZCompressCheck(code: Integer): Integer;
begin
  result := code;
end;

function ZDecompressCheck(code: Integer): Integer;
begin
  Result := code;
end;

{$IFNDEF NEXTGEN}
procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TZCompressionLevel);
const
  delta = 256;
var
  zstream: TZStreamRec;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  outSize := ((inSize + (inSize div 10) + 12) + 255) and not 255;
  GetMem(outBuffer, outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZCompressCheck(DeflateInit(zstream, ZLevels[level]));

    try
      while ZCompressCheck(deflate(zstream, Z_FINISH)) <> Z_STREAM_END do
      begin
        Inc(outSize, delta);
        ReallocMem(outBuffer, outSize);
        zstream.next_out := PByte(outBuffer) + zstream.total_out;
        zstream.avail_out := delta;
      end;
    finally
      ZCompressCheck(deflateEnd(zstream));
    end;

    ReallocMem(outBuffer, zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TCompressionLevel);
begin
  ZCompress(inBuffer, inSize, outBuffer, outSize, TZCompressionLevel(Integer(level)));
end;
{$ENDIF !NEXTGEN}







{$IFNDEF NEXTGEN}
procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer; outEstimate: Integer);
var
  zstream: TZStreamRec;
  delta: Integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  delta := (inSize + 255) and not 255;

  if outEstimate = 0 then outSize := delta
  else outSize := outEstimate;

  GetMem(outBuffer, outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZDecompressCheck(InflateInit(zstream));

    try
      while ZDecompressCheck(inflate(zstream, Z_NO_FLUSH)) <> Z_STREAM_END do
      begin
        Inc(outSize, delta);
        ReallocMem(outBuffer, outSize);
        zstream.next_out := PByte(outBuffer) + zstream.total_out;
        zstream.avail_out := delta;
      end;
    finally
      ZDecompressCheck(inflateEnd(zstream));
    end;

    ReallocMem(outBuffer, zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;
{$ENDIF !NEXTGEN}








function zlibAllocMem(AppData: Pointer; Items, Size: Cardinal): Pointer;
begin
  Result := AllocMem(Items * Size);
end;

procedure zlibFreeMem(AppData, Block: Pointer);
begin
  FreeMem(Block);
end;

type
 ULONG_PTR = NativeUInt;
 SIZE_T = ULONG_PTR;

function  malloc(size: size_t): Pointer; cdecl;
begin
  Result := AllocMem(size);
end;

procedure  free(pBlock: Pointer); cdecl;
begin
  FreeMem(pBlock);
end;




function  memset(dest: Pointer; val: Integer; count: size_t): Pointer; cdecl;
begin
 result:=dest;
 FillChar(dest^, count, val);
end;


function  memcpy(dest, src: Pointer; count: size_t): Pointer; cdecl;
begin
 result:=dest;
 Move(src^, dest^, count);
end;



procedure _llmod; cdecl;
asm
  jmp System.@_llmod;
end;


end.
