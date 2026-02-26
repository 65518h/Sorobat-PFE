Page 99993 "UEI - Table List"
{
    // //
    // // Universal Excel Importer
    // // (c) 2006-2008 Slawek Guzek, sguzek@onet.pl
    // //

    Caption = 'Choose destination table';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = AllObj;
    UsageCategory = Lists;
    SourceTableView = sorting("Object Type", "Object Name", "Object ID")
                      where("Object Type" = const(Table));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(ID; rec."Object ID")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec."Object Name")
                {
                    ApplicationArea = Basic;
                }
                /*GL2024  field(Caption;rec.Caption)
                  {
                      ApplicationArea = Basic;
                  }*/
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;


    procedure GetTableNo(): Integer
    begin
        exit(rec."Object ID");
    end;


}

