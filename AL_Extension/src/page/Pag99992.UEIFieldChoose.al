Page 99992 "UEI - Field Choose"
{
    // //
    // // Universal Excel Importer
    // // (c) 2006-2008 Slawek Guzek, sguzek@onet.pl
    // //

    Caption = 'UEI - Field Choose';
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Field";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(FieldName; rec.FieldName)
                {
                    ApplicationArea = Basic;
                }
                field("Field Caption"; rec."Field Caption")
                {
                    ApplicationArea = Basic;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Len; rec.Len)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

