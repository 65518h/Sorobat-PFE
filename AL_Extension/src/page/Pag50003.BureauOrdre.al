page 50003 "Bureau Ordre"
{
    PageType = Card;
    SourceTable = "Bureau Ordre";
    Caption = 'Bureau Ordre';

    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Général)
            {
                Caption = 'General';
                field("Document N°"; rec."Document N°")
                {
                    ApplicationArea = all;
                }
                field("Receptionné Par"; rec."Receptionné Par")
                {
                    ApplicationArea = all;
                    Editable = "Receptionné ParEditable";
                }
                field("Receptionné Le"; rec."Receptionné Le")
                {
                    ApplicationArea = all;
                    Editable = "Receptionné LeEditable";
                }
                field("Livré Par"; rec."Livré Par")
                {
                    ApplicationArea = all;
                    Editable = "Livré ParEditable";
                }
                field("Categorie Document"; rec."Categorie Document")
                {
                    ApplicationArea = all;
                    Editable = "Categorie DocumentEditable";
                }
                field(Urgence; rec.Urgence)
                {
                    ApplicationArea = all;
                    Editable = UrgenceEditable;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Type Tiers"; rec."Type Tiers")
                {
                    ApplicationArea = all;
                    Editable = "Type TiersEditable";
                }
                field(Tiers; rec.Tiers)
                {
                    ApplicationArea = all;
                    Editable = TiersEditable;
                }
                field("Nom Tiers"; rec."Nom Tiers")
                {
                    ApplicationArea = all;
                    Editable = "Nom TiersEditable";
                }
                field(Remarque; rec.Remarque)
                {
                    ApplicationArea = all;
                    Editable = RemarqueEditable;
                }
                field("Envoyé à Service"; rec."Envoyé à Service")
                {
                    ApplicationArea = all;
                }

                field("Reference Document Externe"; rec."Reference Document Externe")
                {
                    ApplicationArea = all;
                    Editable = ReferenceDocumentExterneEditab;
                }
                field(Objet; rec.Objet)
                {
                    ApplicationArea = all;
                    Editable = ObjetEditable;
                    MultiLine = true;
                }
                field("Instruction Par"; rec."Instruction Par")
                {
                    ApplicationArea = all;
                    Editable = "Instruction ParEditable";
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Clôturer1; rec.Clôturer)
                {
                    ApplicationArea = all;
                }
            }
            part(FrmSuivi; "Bureau Ordre Diffusion Detail")
            {
                ApplicationArea = all;

                Editable = FrmSuiviEditable;
                SubPageLink = "Document N°" = FIELD("Document N°");
            }
            group("Envoyé à")
            {
                Caption = 'Sent to';
                part("FrmEnvoyéA"; "Bureau Ordre Envoyé à")
                {
                    Editable = "FrmEnvoyéAEDITABLE";
                    ApplicationArea = all;
                    SubPageLink = "No. Document" = FIELD("Document N°");
                }
            }

            group(P)
            {
                ShowCaption = false;

                field(ImageP1; rec.ImageP1)
                {
                    Caption = 'P1';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ImageP2; rec.ImageP2)
                {
                    Caption = 'P2';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ImageP3; rec.ImageP3)
                {
                    Caption = 'P3';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ImageP4; rec.ImageP4)
                {
                    Caption = 'P4';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ImageP5; rec.ImageP5)
                {
                    Caption = 'P5';
                    ApplicationArea = all;
                    Visible = false;
                }

                field(ImageP6; rec.ImageP6)
                {
                    Caption = 'P6';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ImageP7; rec.ImageP7)
                {
                    Caption = 'P7';
                    ApplicationArea = all;
                    Visible = false;
                }


                field(ImageP8; rec.ImageP8)
                {
                    Caption = 'P8';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ImageP9; rec.ImageP9)
                {
                    Caption = 'P9';
                    ApplicationArea = all;
                    Visible = false;
                }

                field(ImageP10; rec.ImageP10)
                {
                    Caption = 'P10';
                    ApplicationArea = all;
                    Visible = false;
                }
            }






        }
    }

    actions
    {
        area(processing)
        {
            action("Aperçu")
            {
                ApplicationArea = all;
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    RecBureauOrdre.SETRANGE("Document N°", rec."Document N°");
                    REPORT.RUNMODAL(Report::"Documents Bureau D'ordre", TRUE, TRUE, RecBureauOrdre);
                end;
            }
            action("Clôturer")
            {
                Caption = 'Close';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    TextL002: Label 'Clôturer ce document ?';
                begin
                    IF rec.Clôturer THEN EXIT;
                    IF NOT CONFIRM(TextL002, FALSE) THEN EXIT;
                    rec.Clôturer := TRUE;
                    rec.MODIFY;
                    EnablesPanels(NOT rec.Clôturer);
                end;
            }
            action(Transfert)
            {
                Caption = 'Transfer';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    ActionGo(5);
                end;
            }
            action(Rappel)
            {
                Caption = 'Rappel';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    ActionGo(4);
                end;
            }
            action("Relancé")
            {
                Caption = 'Relancé';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                begin
                    ActionGo(3);
                end;
            }
            action("Info Supp")
            {
                Caption = 'Info Supp';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                begin
                    ActionGo(2);
                end;
            }
            action(Diffuser)
            {
                Caption = 'Diffuser';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    ActionGo(1);
                end;
            }
            action(Importer)
            {
                Caption = 'Importer';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                var
                    TextL001: Label 'Importer le document ?';
                begin
                    IF rec.Clôturer THEN EXIT;
                    IF NOT CONFIRM(TextL001, FALSE) THEN EXIT;
                    IF RecGeneralLedgerSetup.GET THEN;
                    FileName := RecGeneralLedgerSetup."Chemin Bureau Ordre";

                    //     IF EXISTS(FileName + '1.BMP') THEN IF rec.ImageP1.IMPORT(FileName + '1.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '2.BMP') THEN IF rec.ImageP2.IMPORT(FileName + '2.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '3.BMP') THEN IF rec.ImageP3.IMPORT(FileName + '3.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '4.BMP') THEN IF rec.ImageP4.IMPORT(FileName + '4.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '5.BMP') THEN IF rec.ImageP5.IMPORT(FileName + '5.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '6.BMP') THEN IF rec.ImageP6.IMPORT(FileName + '6.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '7.BMP') THEN IF rec.ImageP7.IMPORT(FileName + '7.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '8.BMP') THEN IF rec.ImageP8.IMPORT(FileName + '8.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '9.BMP') THEN IF rec.ImageP9.IMPORT(FileName + '9.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '10.BMP') THEN IF rec.ImageP10.IMPORT(FileName + '10.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '11.BMP') THEN IF rec.ImageP11.IMPORT(FileName + '11.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '12.BMP') THEN IF rec.ImageP12.IMPORT(FileName + '12.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '13.BMP') THEN IF rec.ImageP13.IMPORT(FileName + '13.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '14.BMP') THEN IF rec.ImageP14.IMPORT(FileName + '14.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '15.BMP') THEN IF rec.ImageP15.IMPORT(FileName + '15.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '16.BMP') THEN IF rec.ImageP16.IMPORT(FileName + '16.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '17.BMP') THEN IF rec.ImageP17.IMPORT(FileName + '17.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '18.BMP') THEN IF rec.ImageP18.IMPORT(FileName + '18.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '19.BMP') THEN IF rec.ImageP19.IMPORT(FileName + '19.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS(FileName + '20.BMP') THEN IF rec.ImageP20.IMPORT(FileName + '20.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     EXIT;

                    //GL2024 License  //     IF EXISTS('C:\1.BMP') THEN IF rec.ImageP1.IMPORT('C:\1.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\2.BMP') THEN IF rec.ImageP2.IMPORT('C:\2.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\3.BMP') THEN IF rec.ImageP3.IMPORT('C:\3.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\4.BMP') THEN IF rec.ImageP4.IMPORT('C:\4.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\5.BMP') THEN IF rec.ImageP5.IMPORT('C:\5.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\6.BMP') THEN IF rec.ImageP6.IMPORT('C:\6.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\7.BMP') THEN IF rec.ImageP7.IMPORT('C:\7.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\8.BMP') THEN IF rec.ImageP8.IMPORT('C:\8.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\9.BMP') THEN IF rec.ImageP9.IMPORT('C:\9.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\10.BMP') THEN IF rec.ImageP10.IMPORT('C:\10.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\11.BMP') THEN IF rec.ImageP11.IMPORT('C:\11.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\12.BMP') THEN IF rec.ImageP12.IMPORT('C:\12.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\13.BMP') THEN IF rec.ImageP13.IMPORT('C:\13.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\14.BMP') THEN IF rec.ImageP14.IMPORT('C:\14.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\15.BMP') THEN IF rec.ImageP15.IMPORT('C:\15.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\16.BMP') THEN IF rec.ImageP16.IMPORT('C:\16.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\17.BMP') THEN IF rec.ImageP17.IMPORT('C:\17.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\18.BMP') THEN IF rec.ImageP18.IMPORT('C:\18.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\19.BMP') THEN IF rec.ImageP19.IMPORT('C:\19.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD;
                    //     IF EXISTS('C:\20.BMP') THEN IF rec.ImageP20.IMPORT('C:\20.BMP' /*GL2024FALSE*/) = '' THEN;
                    //     CurrPage.SAVERECORD; //GL2024 License*/
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Nom TiersEditable" := TRUE;
        "Receptionné LeEditable" := TRUE;
        "Receptionné ParEditable" := TRUE;
        "Instruction ParEditable" := TRUE;
        ReferenceDocumentExterneEditab := TRUE;
        FrmSuiviEditable := TRUE;
        RemarqueEditable := TRUE;
        ObjetEditable := TRUE;
        "Livré ParEditable" := TRUE;
        TiersEditable := TRUE;
        "Type TiersEditable" := TRUE;
        UrgenceEditable := TRUE;
        "Categorie DocumentEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        EnablesPanels(NOT rec.Clôturer);

        //GL2024 CurrPage.LOGHEIGHT:=FrmHeight+30000;
    end;

    var
        BureauOrdreEnvoyA: Record "Bureau Ordre Envoyé a";
        RecBureauOrdre: Record "Bureau Ordre";
        RecGeneralLedgerSetup: Record "General Ledger Setup";
        PictureExists: Boolean;
        Image1: Variant;
        Image2: Variant;
        FileName: Text[1024];
        FrmHeight: Integer;
        [InDataSet]
        "Categorie DocumentEditable": Boolean;
        [InDataSet]
        UrgenceEditable: Boolean;
        [InDataSet]
        "Type TiersEditable": Boolean;
        [InDataSet]
        TiersEditable: Boolean;
        [InDataSet]
        "Livré ParEditable": Boolean;
        [InDataSet]
        ObjetEditable: Boolean;
        [InDataSet]
        RemarqueEditable: Boolean;
        [InDataSet]
        FrmSuiviEditable: Boolean;
        [InDataSet]
        ReferenceDocumentExterneEditab: Boolean;
        [InDataSet]
        "Instruction ParEditable": Boolean;
        [InDataSet]
        "Receptionné ParEditable": Boolean;
        [InDataSet]
        "Receptionné LeEditable": Boolean;
        [InDataSet]
        "Nom TiersEditable": Boolean;

        FrmEnvoyéAEDITABLE: Boolean;


    procedure ActionGo(TypeAction: Integer)
    var
        RecLBureauOrdreDiffusion: Record "Bureau Ordre Diffusion";
        TextL001: Label 'Confirmer Cette Action ?';
        "RecLBureauOrdreEnvoyéa": Record "Bureau Ordre Envoyé a";
    begin
        IF rec.Clôturer THEN EXIT;
        IF NOT CONFIRM(TextL001, FALSE) THEN EXIT;
        RecLBureauOrdreDiffusion.INIT;
        RecLBureauOrdreDiffusion."Document N°" := rec."Document N°";
        IF rec."Envoyé à Service" <> 0 THEN BEGIN
            RecLBureauOrdreEnvoyéa.SETRANGE(Service, rec."Envoyé à Service");
            IF RecLBureauOrdreEnvoyéa.FINDFIRST THEN
                REPEAT
                    RecLBureauOrdreDiffusion."Type Destination" := RecLBureauOrdreDiffusion."Type Destination"::Service;
                    RecLBureauOrdreDiffusion.Action := TypeAction;
                    RecLBureauOrdreDiffusion."Action Faite Le" := CURRENTDATETIME;
                    RecLBureauOrdreDiffusion."Action Faite Par" := USERID;
                    RecLBureauOrdreDiffusion.Destinataire := RecLBureauOrdreEnvoyéa.Utilisateur;
                    RecLBureauOrdreDiffusion."Service Destinataire" := FORMAT(rec."Envoyé à Service");
                    IF RecLBureauOrdreDiffusion.INSERT THEN;
                UNTIL RecLBureauOrdreEnvoyéa.NEXT = 0;
        END;
        RecLBureauOrdreEnvoyéa.RESET;
        RecLBureauOrdreEnvoyéa.SETRANGE("Envoyé à", TRUE);
        RecLBureauOrdreEnvoyéa.SETRANGE("No. Document", rec."Document N°");
        IF RecLBureauOrdreEnvoyéa.FINDFIRST THEN
            REPEAT
                RecLBureauOrdreDiffusion."Type Destination" := RecLBureauOrdreDiffusion."Type Destination"::Utilisateur;
                RecLBureauOrdreDiffusion.Action := TypeAction;
                RecLBureauOrdreDiffusion."Action Faite Le" := CURRENTDATETIME;
                RecLBureauOrdreDiffusion."Action Faite Par" := USERID;
                RecLBureauOrdreDiffusion.Destinataire := RecLBureauOrdreEnvoyéa.Utilisateur;
                IF RecLBureauOrdreDiffusion.INSERT THEN;
            UNTIL RecLBureauOrdreEnvoyéa.NEXT = 0;
        rec."Envoyé à Service" := 0;
        rec.MODIFY;
        CurrPage.UPDATE;
    end;


    procedure EnablesPanels(ParaEnable: Boolean)
    begin
        "Categorie DocumentEditable" := ParaEnable;
        UrgenceEditable := ParaEnable;
        "Type TiersEditable" := ParaEnable;
        TiersEditable := ParaEnable;
        "Livré ParEditable" := ParaEnable;
        ObjetEditable := ParaEnable;
        RemarqueEditable := ParaEnable;
        FrmSuiviEditable := ParaEnable;

        FrmEnvoyéAEDITABLE := ParaEnable;
        ReferenceDocumentExterneEditab := ParaEnable;
        "Instruction ParEditable" := ParaEnable;
    end;


    procedure EnablesPanelsOpen()
    begin
        "Receptionné ParEditable" := TRUE;
        "Receptionné LeEditable" := TRUE;
        "Categorie DocumentEditable" := TRUE;
        UrgenceEditable := TRUE;
        "Type TiersEditable" := TRUE;
        TiersEditable := TRUE;
        "Nom TiersEditable" := TRUE;
        "Livré ParEditable" := TRUE;
        ObjetEditable := TRUE;
        RemarqueEditable := TRUE;
        FrmSuiviEditable := TRUE;

        FrmEnvoyéAEDITABLE := TRUE;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        EnablesPanels(NOT rec."Clôturer");
    end;
}

