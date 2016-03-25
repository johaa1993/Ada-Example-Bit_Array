with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Unchecked_Conversion;
with Interfaces;

procedure Main is

   use Interfaces;
   use Ada.Text_IO;
   use Ada.Integer_Text_IO;

   function One_Bit (Index : Natural) return Unsigned_32 is (Shift_Left (1, Index));

   type Bit_Array_32_Index is range 0 .. 31;
   type Bit_Array_17_Index is range 0 .. 16;
   type Bit_Array_32 is array (Bit_Array_32_Index) of Boolean with Component_Size => 1, Size => 32;
   type Bit_Array_17 is array (Bit_Array_17_Index) of Boolean with Component_Size => 1, Size => 17;

   -- For every new array type instantiate a convert function.
   function Convert is new Ada.Unchecked_Conversion (Unsigned_32, Bit_Array_32);
   function Convert is new Ada.Unchecked_Conversion (Unsigned_32, Bit_Array_17);

   B32 : Bit_Array_32 with Volatile;
   B17 : Bit_Array_17 with Volatile;

begin

   B17 := Convert (One_Bit (2)) or Convert (One_Bit (5));
   B32 := Convert (One_Bit (2) or One_Bit (5));

   for E of B17 loop
      Put (Boolean'Pos (E), 1);
   end loop;

   New_Line;

   for E of B32 loop
      Put (Boolean'Pos (E), 1);
   end loop;

end;
