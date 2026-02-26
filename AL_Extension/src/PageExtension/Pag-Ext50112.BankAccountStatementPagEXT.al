PageExtension 50112 "Bank Account Statement_PagEXT" extends "Bank Account Statement"
{
    layout
    {
        addafter("Statement Ending Balance")
        {
            field("Handing-over Type"; Rec."Handing-over Type")
            {
                Visible = "Handing-over TypeVISIBLE";
                Editable = false;
                ApplicationArea = all;
            }
            field("Nom Banque"; Rec."Nom Banque")
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Category_Process)
        {
            actionref("Print Bills Handing-over1"; "Print Bills Handing-over")
            {

            }
            actionref("Fichier &ETEBAC1"; "Fichier &ETEBAC")
            {

            }
        }
        addafter("St&atement")
        {
            action("Print Bills Handing-over")
            {
                Caption = 'Print Bills Handing-over';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    //+PMT+PAYMENT
                    wBankAcc.TESTFIELD("Bank Type", wBankAcc."Bank Type"::Receivable);
                    wBankStatement.COPY(Rec);
                    wBankStatement.SETRANGE("Bank Account No.", rec."Bank Account No.");
                    wBankStatement.SETRANGE("Statement No.", rec."Statement No.");
                    //DYS REPORT addon non migrer
                    // REPORT.RUNMODAL(REPORT::"Handing-over Receivable Bills", TRUE, FALSE, wBankStatement);
                    //+PMT+PAYMENT//
                end;
            }
            action("Fichier &ETEBAC")
            {
                Caption = 'Fichier &ETEBAC';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lBankAcc: Record "Bank Account";
                BEGIN

                    wBankAcc.TESTFIELD("Bank Type", wBankAcc."Bank Type"::Receivable);
                    //CLEAR(wEtebac);
                    wBankStatement.COPY(Rec);
                    wBankStatement.SETRANGE("Bank Account No.", rec."Bank Account No.");
                    wBankStatement.SETRANGE("Statement No.", rec."Statement No.");
                    IF lBankAcc.GET(wBankStatement."Handing-over Bank Code") THEN;
                    // wEtebac.InitRequest(wBankStatement, lBankAcc."LCR file name");
                    // wEtebac.SETTABLEVIEW(wBankStatement);
                    // wEtebac.RUNMODAL;
                end;
            }
        }
    }
    VAR
        wBankAcc: Record "Bank Account";
        //DYS report addon non migrer
        //wEteba: Report 8004101;
        wBankStatement: Record "Bank Account Statement";
        //GL2024
        "Handing-over TypeVISIBLE": Boolean;

    trigger OnOpenPage()
    begin

        //+PMT+PAYMENT
        IF wBankAcc.GET(rec."Bank Account No.") AND
           (wBankAcc."Bank Type" = wBankAcc."Bank Type"::Receivable) THEN
            "Handing-over TypeVISIBLE" := TRUE
        ELSE
            "Handing-over TypeVISIBLE" := FALSE;
        //+PMT+PAYMENT
    end;
}

