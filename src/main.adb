with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;
with Interfaces; use Interfaces;

procedure Main is
   package Unsigned_32_IO is new Ada.Text_IO.Modular_IO (Unsigned_32);

   type Bit_Array_32_Index is range 0 .. 31;
   type Bit_Array_17_Index is range 0 .. 16;
   type Bit_Array_32 is array (Bit_Array_32_Index) of Boolean with Component_Size => 1, Size => 32;
   type Bit_Array_17 is array (Bit_Array_17_Index) of Boolean with Component_Size => 1, Size => 32;

   generic
      type I is (<>);
      type T is array (I) of Boolean;
   procedure Generic_Put (Item : T; Width : Field; Base : Number_Base);
   procedure Generic_Put (Item : T; Width : Field; Base : Number_Base) is
      function Convert_To_Unsigned_32 is new Ada.Unchecked_Conversion (T, Unsigned_32);
   begin
      Unsigned_32_IO.Put (Convert_To_Unsigned_32 (Item), Width, Base);
   end;

   generic
      type I is (<>);
      type T is array (I) of Boolean;
   function Generic_Shift_Left (Value : Unsigned_32; Amount : Natural) return T;
   function Generic_Shift_Left (Value : Unsigned_32; Amount : Natural) return T is
      function Convert_To_Bit_Array_32 is new Ada.Unchecked_Conversion (Unsigned_32, T);
   begin
      return Convert_To_Bit_Array_32 (Interfaces.Shift_Left (Value, Amount));
   end;

   function Shift_Left is new Generic_Shift_Left (Bit_Array_32_Index, Bit_Array_32);
   function Shift_Left is new Generic_Shift_Left (Bit_Array_17_Index, Bit_Array_17);
   procedure Put is new Generic_Put (Bit_Array_32_Index, Bit_Array_32);
   procedure Put is new Generic_Put (Bit_Array_17_Index, Bit_Array_17);

   B32 : Bit_Array_32 with Volatile;
   B17 : Bit_Array_17 with Volatile;
begin
   B32 := Shift_Left (1, 2) or Shift_Left (1, 5);
   B17 := Shift_Left (1, 2) or Shift_Left (1, 5);
   Put (B17, 0, 2);
   New_Line;
   Put (B32, 0, 2);
end;
