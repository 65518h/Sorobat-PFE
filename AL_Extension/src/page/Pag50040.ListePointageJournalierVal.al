page 50040 "Liste Pointage Journalier Val"
{
    //NEW
    // // << HJ DSFT 21-01-2009: Gestion des Utilisateurs


    Editable = false;
    PageType = List;
    SourceTable = "Entete Pointage Salarié Chan";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Liste Pointage Journalier Validé';
    CardPageId = "Entete Pointage Journalier Val";
    SourceTableView = WHERE(Statut = CONST(Valider));
    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                field("No. Pointage"; Rec."No. Pointage")
                {
                    ApplicationArea = all;

                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    //   Editable = false;
                }
                field(Affectation; Rec.Affectation)
                {
                    ApplicationArea = all;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Annee Attachement"; Rec."Annee Attachement")
                {
                    ApplicationArea = all;


                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Mois Attachement"; Rec."Mois Attachement")
                {
                    ApplicationArea = all;


                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = all;

                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            AffectationCode := UserSetup.Affectation;


            Rec.SetView(STRSUBSTNO('WHERE("Affectation"=FILTER(%1))', AffectationCode));
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            AffectationCode := UserSetup.Affectation;


            Rec.SetView(STRSUBSTNO('WHERE("Affectation"=FILTER(%1))', AffectationCode));
        end;
    end;

    var
        AffectationCode: Code[20];
}

