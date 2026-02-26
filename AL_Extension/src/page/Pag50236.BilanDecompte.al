Page 50236 "Bilan Decompte"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Bilan Decompte";
    ApplicationArea = all;
    Caption = 'Bilan Decompte';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Marché"; REC."Code Marché")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Date; REC.Date)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Niveau; REC.Niveau)
                {
                    ApplicationArea = all;
                }
                field(Designatiion; REC.Designatiion)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Mantant HTVA"; REC."Mantant HTVA")
                {
                    ApplicationArea = all;
                }
                field(Taux; REC.Taux)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

