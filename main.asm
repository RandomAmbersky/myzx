DEVICE zxspectrum48
org #6000;
begin
  ld hl,04000h
  ld (hl),%10101010
  ld de,04001h
  ld bc,17FFh
  ldir
  di
  halt
end

display begin
SAVESNA "myzx.sna",begin
