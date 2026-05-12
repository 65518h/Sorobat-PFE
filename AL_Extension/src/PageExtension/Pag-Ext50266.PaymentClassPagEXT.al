PageExtension 50266 "Payment Class_PagEXT" extends "Payment Class"
{


    layout
    {

        addafter(Name)
        {
            // field("Verifier Affectation Financier"; Rec."Verifier Affectation Financier")
            // {
            //     ApplicationArea = all;
            // }
            // field("Affectation Financier"; Rec."Affectation Financier")
            // {
            //     ApplicationArea = all;
            // }
            // field("Verifier Compte Ligne"; Rec."Verifier Compte Ligne")
            // {
            //     ApplicationArea = all;
            // }
            field("Caisse Par Defaut"; Rec."Caisse Par Defaut")
            {
                ApplicationArea = all;
            }
        }
        // addafter("Header No. Series")
        // {
        //     field("Type de Paiement"; Rec."Type de Paiement")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        addafter("Line No. Series")
        {
            field("Affectation"; CdeAffectaionTypeRegelemnt)
            {
                ApplicationArea = all;
                Caption = 'Affectation';
                trigger OnAssistEdit()
                begin

                    //>> HJ DSFT 10 12 2010
                    RecAutorisationEtapes.SETRANGE("Type réglement", rec.Code);
                    page.RUNMODAL(Page::"Autorisation Type Réglement", RecAutorisationEtapes);
                    //>> HJ DSFT 10 12 2010
                end;

            }
            field("Banque Bénéficiaire Obligatoir"; Rec."Banque Bénéficiaire Obligatoir")
            {
                ApplicationArea = all;

            }
            field("Piece De Paiement Obligatoire"; Rec."Piece De Paiement Obligatoire")
            {
                ApplicationArea = all;

            }
            field("Credit Bancaire Avec Echeancie"; Rec."Credit Bancaire Avec Echeancie")
            {
                ApplicationArea = all;

            }
            field(EXT; Rec.EXT)
            {
                ApplicationArea = all;

            }
            field("Communication XRT"; Rec."Communication XRT")
            {
                ApplicationArea = all;

            }
            field(Caisse; Rec.Caisse)
            {
                ApplicationArea = all;

            }
            field("Header Account Type"; Rec."Header Account Type")
            {
                ApplicationArea = all;

            }
        }
    }
    actions
    {


    }
    trigger OnOpenPage()
    begin
        // HJ DSFT 04-10-2012
        GetABK;
        // HJ DSFT 04-10-2012
    end;

    trigger OnAfterGetRecord()
    begin
        // HJ DSFT 04-10-2012
        GetABK;
        // HJ DSFT 04-10-2012
    end;


    var
        RecAutorisationEtapes: Record "Autorisation Types Réglement";
        CdeAffectaionTypeRegelemnt: Code[20];



    PROCEDURE GetABK();
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN
        // >> HJ DSFT 04-10-2012
        IF RecLUserSetup.GET(UPPERCASE(USERID)) THEN;
        IF NOT RecLUserSetup."Compte EX" THEN
            rec.SETRANGE(EXT, FALSE);
        // >> HJ DSFT 04-10-2012
    END;
}

