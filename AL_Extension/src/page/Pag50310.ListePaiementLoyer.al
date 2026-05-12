Page 50310 "Liste Paiement Loyer"
{//GL2024 NEW PAGE
    Caption = 'Liste Paiement Loyer';
    PageType = list;
    RefreshOnActivate = true;
    SourceTable = "Payment Header";
    SourceTableView = WHERE("Payment Class" = CONST('LOYER'));
    ApplicationArea = all;
    UsageCategory = Lists;
    // CardPageId = "Paiement Loyer";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("No."; rec."No.")
                {
                    AssistEdit = false;
                    Editable = false;
                    ApplicationArea = all;

                }
                field("Payment Class"; rec."Payment Class")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Lookup = false;
                }
                field("Payment Class Name"; rec."Payment Class Name")
                {
                    ApplicationArea = all;
                    DrillDown = false;
                    Editable = false;
                }
                field("Status Name"; rec."Status Name")
                {
                    ApplicationArea = all;
                    DrillDown = false;
                    Editable = false;
                }
                field(Utilisateur; rec.Utilisateur)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Validé Par"; rec."Validé Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }

                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;


                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;

                    DecimalPlaces = 3 : 3;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;

                    DecimalPlaces = 3 : 3;
                }


                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Presentation; rec.Presentation)
                {
                }

                field("N° CI"; rec."N° CI")
                {
                    ApplicationArea = all;
                }
                field("DATE D'EMBARQUEMENT"; rec."DATE D'EMBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("DATE D'EXPIRATION"; rec."DATE D'EXPIRATION")
                {
                    ApplicationArea = all;
                }
                field("CONDITION DE VENTE"; rec."CONDITION DE VENTE")
                {
                    ApplicationArea = all;
                }
                field("PORT EMBARQUEMENT"; rec."PORT EMBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("PORT DEBARQUEMENT"; rec."PORT DEBARQUEMENT")
                {
                    ApplicationArea = all;
                }
                field("Mode Echéance"; rec."Mode Echéance")
                {
                    ApplicationArea = all;
                }
                field("Objet Lettre"; rec."Objet Lettre")
                {
                    ApplicationArea = all;
                }
                field("N° Brouillard"; rec."N° Brouillard")
                {
                    ApplicationArea = all;
                }
                field(Destinataire; rec.Destinataire)
                {
                    ApplicationArea = all;
                }
                field("Tomber FED"; rec."Tomber FED")
                {
                    ApplicationArea = all;
                }


                field(TAUX; rec.TAUX)
                {
                    ApplicationArea = all;
                }
                field(Durée; rec.Durée)
                {
                    ApplicationArea = all;
                }
                field("Comm Bancaire"; rec."Comm Bancaire")
                {
                    ApplicationArea = all;
                }
                field(Bénéficiaire; rec.Bénéficiaire)
                {
                    ApplicationArea = all;
                }
                field(Période; rec.Période)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, USERID);
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);
    end;

    trigger OnOpenPage()
    begin
        // << HJ DSFT 21-01-2009
        RecUser.GET(UPPERCASE(USERID));
        IF RecUser.Niveau = 0 THEN ERROR(Text0011);
        IF RecUser.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUser.Niveau = 2) AND (RecUser.Agence <> '') THEN
            rec.SETRANGE(Agence, RecUser.Agence)
        ELSE
            rec.SETRANGE(Agence);

        // << HJ DSFT 21-01-2009
    end;

    var
        RecUser: Record "User Setup";
        Text011: Label 'Check No. %1 used more than once.';

        Text0011: Label 'You are not authorized for the Cash Collection - Disbursement module.';
}