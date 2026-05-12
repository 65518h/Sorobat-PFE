page 52048911 "Loan Advance lines"
{
    //GL2024  ID dans Nav 2009 : "39001432"
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Loan & Advance Lines";
    Caption = 'Ligne Prêt Avance';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("Payment No."; Rec."Payment No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° paie';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° séquence';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Montant Ligne';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                }
                field("Line %"; Rec."Line %")
                {
                    ApplicationArea = Basic;
                    Caption = '% Ligne';
                }
                field(Paid; Rec.Paid)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payé';
                }
                // field("Remboursement Anticipé"; Rec."Remboursement Anticipé")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Remboursement Anticipé';
                // }
            }
        }
    }

    actions
    {
    }

    var
        T1: Record "Loan & Advance Lines";


    procedure ImprPRecette()
    begin
        T1.Reset;
        T1.SetFilter("No.", Rec."No.");
        T1.SetRange("Entry No.", Rec."Entry No.");
        Report.RunModal(50182, true, false, T1);
    end;
}

