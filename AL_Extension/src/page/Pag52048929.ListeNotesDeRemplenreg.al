
page 52048929 "Liste Notes De Rempl. enreg."
{
    //GL2024  ID dans Nav 2009 : "39001491"
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Note Remplacement Enreg";
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Liste Notes De Rempl. enreg.';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Date Remplacement"; Rec."Date Remplacement")
                {
                    ApplicationArea = Basic;
                }
                field("N° Salariée"; Rec."N° Salariée")
                {
                    ApplicationArea = Basic;
                }
                field("N° Remplacant"; Rec."N° Remplacant")
                {
                    ApplicationArea = Basic;
                }
                field("Heure Début"; Rec."Heure Début")
                {
                    ApplicationArea = Basic;
                }
                field("Heure Fin"; Rec."Heure Fin")
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

