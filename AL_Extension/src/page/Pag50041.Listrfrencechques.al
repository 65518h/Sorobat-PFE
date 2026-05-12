Page 50041 "List référence chèques"
{
    //  //>>>MBK:05/02/2010: Référence chèque

    Editable = true;
    PageType = List;
    SourceTable = "Référence Chèques";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'List référence chèques';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code banque"; rec."Code banque")
                {
                    ApplicationArea = all;
                }
                field("Référence Chèques"; rec."Référence Chèques")
                {
                    ApplicationArea = all;
                }
                field("N° début"; rec."N° début")
                {
                    ApplicationArea = all;
                }
                field("N° fin"; rec."N° fin")
                {
                    ApplicationArea = all;
                }
                field("Date création"; rec."Date création")
                {
                    ApplicationArea = all;
                }
                field("Date début utilisation"; rec."Date début utilisation")
                {
                    ApplicationArea = all;
                }
                field("Date fin utilisation"; rec."Date fin utilisation")
                {
                    ApplicationArea = all;
                }
                field(Commentaire; rec.Commentaire)
                {
                    ApplicationArea = all;
                }
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
}

