PageExtension 50274 "Payment Lines List_PagEXT" extends "Payment Lines List"
{
    layout
    {
        addfirst(Content)
        {

            field(Amount_gd; Amount_gd)
            {
                Caption = 'Amount_gd';
                ApplicationArea = all;
                ShowCaption = false;
            }
            // field("Header Account No."; rec."Posting Date")
            // {
            //     ApplicationArea = all;
            // }

        }
        addfirst(Control1)
        {
            field("Posting Date"; rec."Posting Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line No.")
        {
            field("N° compte En tête"; rec."N° compte En tête")
            {
                ApplicationArea = all;
            }
            field("Jours Restants"; rec."Jours Restants")
            {
                ApplicationArea = all;
            }
        }
        addafter("Currency Code")
        {
            field("Debit Amount"; rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount"; rec."Credit Amount")
            {
                ApplicationArea = all;
            }
            field("Libellé"; rec.Libellé)
            {
                ApplicationArea = all;
            }
            field("Compte Bancaire"; rec."Compte Bancaire")
            {
                ApplicationArea = all;
            }
        }
        addafter("Payment in Progress")
        {
            field("Header Account No."; rec."Header Account No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            action("Calculer Selection")
            {
                Caption = 'Calculer Selection';
                ApplicationArea = all;

                trigger OnAction()
                begin

                    //>>>MBK:24/11/2010
                    Amount_gd := 0;
                    CurrPage.SetSelectionFilter(PaymentLine_gr);
                    if PaymentLine_gr.FindFirst then
                        repeat
                            Amount_gd += PaymentLine_gr.Amount;
                        until PaymentLine_gr.Next = 0;

                    //>>>MBK:24/11/2010
                end;
            }
        }
    }

    var

        RecUserSetup: Record "User Setup";
        Amount_gd: Decimal;
        PaymentLine_gr: Record "Payment Line";


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

    end;

    trigger OnOpenPage()
    begin

        // << HJ DSFT 21-01-2009
        IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
        IF RecUserSetup.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUserSetup.Niveau = 2) AND (RecUserSetup.Agence <> '') THEN rec.SETRANGE(Agence, RecUserSetup.Agence);
        // << HJ DSFT 21-01-2009

    end;

    trigger OnAfterGetRecord()
    begin

        // << HJ DSFT 21-01-2009
        IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
        IF RecUserSetup.Niveau = 1 THEN rec.SETRANGE(Utilisateur, UPPERCASE(USERID));
        IF (RecUserSetup.Niveau = 2) AND (RecUserSetup.Agence <> '') THEN rec.SETRANGE(Agence, RecUserSetup.Agence);
        // << HJ DSFT 21-01-2009
        //>>IBK DSFT 13 12 2010
        IF rec."Due Date" <> 0D THEN
            rec."Jours Restants" := rec."Due Date" - WORKDATE;
        //<<IBK DSFT 13 12 2010

    end;


}

