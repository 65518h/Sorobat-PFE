TableExtension 50023 "Invoice Post. BufferEXT" extends "Invoice Post. Buffer"
{
    fields
    {
        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        /*  field(50000; "Salarié"; Code[20])
          {
              Description = 'HJ SORO 08-03-2016';
          }*/
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
        }
        field(8003900; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(8003901; "Line Discount %"; Decimal)
        {
            Caption = '% remise ligne';
        }
    }


}

