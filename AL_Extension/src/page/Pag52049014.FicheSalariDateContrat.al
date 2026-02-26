Page 52049014 "Fiche Salarié Date Contrat"
{//GL2024  ID dans Nav 2009 : "39004803"
    PageType = Card;
    SourceTable = Employee;
    SourceTableView = sorting("No.")
                      where(Blocked = const(false));
    ApplicationArea = All;
    Caption = 'Fiche Salarié Date Contrat';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("First And Last Name"; REC."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("date debut contrat"; REC."date debut contrat")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field(Affectation; REC.Affectation)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field("Deccription Affectation"; REC."Deccription Affectation")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field(Qualification; REC.Qualification)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field("Description Qualification"; REC."Description Qualification")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
            }
        }
    }

    actions
    {
    }
}

