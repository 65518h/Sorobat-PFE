page 52048926 "Salary grid header"
{
    //GL2024  ID dans Nav 2009 : "39001447"
    Caption = 'Grille des salaires';
    PageType = Card;
    SourceTable = "Salary grid header";
    //ABZApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field(Code; rec.Code)
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Date Debut"; rec."Date Debut")
                {
                    ApplicationArea = all;
                }
                field("expiry date"; rec."expiry date")
                {
                    ApplicationArea = all;
                }
                field(Catégorie; Rec.Catégorie)
                {
                    ApplicationArea = all;
                }
            }
            part("Line grille salaires"; "Line grille salaires")
            {
                ApplicationArea = all;
                SubPageLink = Catégorie = FIELD(Catégorie);
            }
            group("Paramétres supp.")
            {
                Caption = 'Paramétres supp.';
                field("Av. auto. Classe"; rec."Av. auto. Classe")
                {
                    ApplicationArea = all;
                }
                field("Av. auto. Echelon"; rec."Av. auto. Echelon")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Fonction&s1")
            {
                Caption = 'Fonction&s';
                actionref("Proposer grille1"; "Proposer grille")
                {

                }

            }
        }
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                action("Proposer grille")
                {
                    Caption = 'Proposer grille';

                    trigger OnAction()
                    var
                        T1: Record "Salary grid header";
                    begin
                        T1.RESET;
                        T1.SETFILTER(Code, rec.Code);
                        REPORT.RUN(52048902, TRUE, FALSE, T1);
                    end;
                }
            }
        }
    }

    var
        MngtSalary: Codeunit "Management of salary";
}

