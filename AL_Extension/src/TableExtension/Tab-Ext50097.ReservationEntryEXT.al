TableExtension 50097 "Reservation EntryEXT" extends "Reservation Entry"
{
    fields
    {

        field(8003900; "Sales Doc. Type"; Option)
        {
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(8003901; "Sales Doc. No."; Code[20])
        {
        }
        field(8003902; "Sales Doc. Line No."; Integer)
        {
        }
    }


}

