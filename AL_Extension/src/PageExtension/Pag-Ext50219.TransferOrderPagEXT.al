PageExtension 50219 "Transfer Order_PagEXT" extends "Transfer Order"

{
    layout
    {
        modify("Transfer-from Code")
        {
            Editable = CodeProvEdtable;
            ApplicationArea = all;
        }
        // modify("In-Transit Code")
        // {
        //     //  Editable = false;
        // }
        addafter(Status)
        {
            field("Date Saisie"; Rec."Date Saisie")
            {
                Editable = FALSE;
                ApplicationArea = all;
            }
            field(Observation; Rec.Observation)
            {
                ApplicationArea = all;
            }
            field("N° Demande Achat"; Rec."N° Demande Achat")
            {
                Editable = FALSE;
                ApplicationArea = all;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
            field("Id Expediteur"; Rec."Id Expediteur")
            {
                Editable = FALSE;
                ApplicationArea = all;
            }
            field("Id Receptioneur"; Rec."Id Receptioneur")
            {
                //  Editable = FALSE;
                ApplicationArea = all;
            }
            field("Chantier Origine"; Rec."Chantier Origine")
            {
                ApplicationArea = all;
            }
            field("Chantier Destination"; Rec."Chantier Destination")
            {
                ApplicationArea = all;
            }
            field("Last Shipment No."; Rec."Last Shipment No.")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        modify("Create Whse. S&hipment")
        {
            Visible = false;
        }
        modify("Create &Whse. Receipt")
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        modify("Get Bin Content")
        {
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action("Imprimer")
            {
                ApplicationArea = all;
                Caption = 'Imprimer A4';
                Image = Print;

                trigger OnAction()
                var
                    TransHeader: record "Transfer Header";
                    OrdreDetransfertA4: Report "Transfer Order A4";
                begin
                    TransHeader.SetRange("No.", Rec."No.");
                    OrdreDetransfertA4.SetTableView(TransHeader);
                    OrdreDetransfertA4.Run();
                end;
            }
            action("ImprimerMat")
            {
                ApplicationArea = all;
                Caption = 'Imprimer';
                Image = Print;

                trigger OnAction()
                var
                    TransHeader: record "Transfer Header";
                    OrdreDetransfertA4: Report "Transfer Order mat";
                begin
                    TransHeader.SetRange("No.", Rec."No.");
                    OrdreDetransfertA4.SetTableView(TransHeader);
                    OrdreDetransfertA4.Run();
                end;
            }
        }

        addafter(Post)
        {
            action("&Validate receipt")
            {
                ApplicationArea = all;
                Caption = '&Validate receipt';

                Image = PostOrder;

                trigger OnAction()
                var
                    Text001: Label 'Do you want to receive the items ?';
                    erere: Report 5703;

                begin

                    IF NOT CONFIRM(Text001) THEN EXIT;
                    TransferPostReceipt.RUN(Rec);

                end;
            }
        }
        addafter(Post_Promoted)
        {
            actionref("&Validate receipt1"; "&Validate receipt")
            {

            }
        }
        addafter(Category_Category8)
        {

            actionref("ImprimerOrdre"; imprimer)
            {
            }
            actionref("ImprimerOrdreMat"; ImprimerMat)
            {
            }
        }
    }
    trigger OnOpenPage()
    begin
        // RB SORO 30/05/2015
        CodeProvEdtable := true;
        IF RecUserSetup.GET(USERID) THEN;
        // IF RecUserSetup."Mgasin Origine Transf" <> '' THEN
        //     CodeProvEdtable := false;
        // RB SORO 30/05/2015
    end;

    trigger OnAfterGetRecord()
    begin

        // RB SORO 30/05/2015

        /* IF rec."Transfer-from Code" = '' THEN BEGIN
             rec."Date Saisie" := TODAY;
             IF RecUserSetup.GET(USERID) THEN;
             IF RecUserSetup."Mgasin Origine Transf" <> '' THEN
                 rec."Transfer-from Code" := RecUserSetup."Mgasin Origine Transf";
         END;*/

        // RB SORO 30/05/2015

    end;

    var
        CodeProvEdtable: Boolean;
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        RecUserSetup: Record "User Setup";
}

