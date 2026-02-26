page 50028 "Ecriture Pointage Journalier"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Ecriture Pointage Journalier";
    Caption = 'Ecritures Pointage Journalier';
    Editable = false;


    layout
    {
        area(content)
        {

            repeater(Control1)
            {
                //Editable = false;
                ShowCaption = false;
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("week Number"; Rec."week Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the week Number field.', Comment = '%';
                }
                field(week; Rec.week)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the week field.', Comment = '%';
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Day field.', Comment = '%';
                }
                field("Day Number"; Rec."Day Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Day Number field.', Comment = '%';
                }

                field(Heure; Rec.Heure)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Heure field.', Comment = '%';
                }
                field("HSup 15"; Rec."HSup 15")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HSup 15 field.', Comment = '%';
                }
                field("HSup 35"; Rec."HSup 35")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HSup 35 field.', Comment = '%';
                }

                field("Mois Attachement"; Rec."Mois Attachement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mois Attachement field.', Comment = '%';
                }
                field("Annee Attachement"; Rec."Annee Attachement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Annee Attachement field.', Comment = '%';
                }
                field(Matricule; Rec.Matricule)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Matricule field.', Comment = '%';
                }
            }
        }
    }


}

