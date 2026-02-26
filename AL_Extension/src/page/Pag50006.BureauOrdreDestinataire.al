page 50006 "Bureau Ordre Destinataire"
{
    PageType = Card;
    SourceTable = "Bureau Ordre";
    // SourceTableView = WHERE(Clôturer = FILTER(false)); 
    Caption = 'Bureau Ordre Destinataire';

    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("Document N°"; rec."Document N°")
                {
                    ApplicationArea = all;
                }
                field("Receptionné Par"; rec."Receptionné Par")
                {
                    Caption = 'User';
                }
                field("receptionné Le"; rec."receptionné Le")
                {
                    ApplicationArea = all;
                    //Caption = 'Received On';
                }
                field("Date Reception"; rec."Date Reception")
                {
                    ApplicationArea = all;
                    Caption = 'Reception Date';
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field("Envoyé à Service"; rec."Envoyé à Service")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                part("Bureau Ord Diff Dest. Detail"; "Bureau Ord Diff Dest. Detail")
                {
                    ApplicationArea = all;
                    Caption = 'Bureau Ord Diff Dest. Detail';
                    SubPageLink = "Document N°" = FIELD("Document N°");
                }
                field("Categorie Document"; rec."Categorie Document")
                {
                    ApplicationArea = all;
                    Editable = ParaEnableFields;
                }
                field("urgence"; rec."urgence")
                {
                    ApplicationArea = all;
                    Editable = ParaEnableFields;
                }
                field("Type Tiers"; rec."Type Tiers")
                {
                    ApplicationArea = all;
                    Editable = ParaEnableFields;
                }
                field("Tiers"; rec."Tiers")
                {
                    ApplicationArea = all;
                    Editable = ParaEnableFields;
                }
                field("Nom Tiers"; rec."Nom Tiers")
                {
                    ApplicationArea = all;

                }
                field("Livré Par"; rec."Livré Par")
                {
                    ApplicationArea = all;
                    Editable = ParaEnableFields;
                }

                field(Clôturer; rec.Clôturer)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Reference Document Externe"; rec."Reference Document Externe")
                {
                    ApplicationArea = all;
                    Editable = ParaEnableFields;
                }
                field("Instruction Par"; rec."Instruction Par")
                {
                    ApplicationArea = all;
                    Editable = ParaEnableFields;
                }

                field(Objet; rec.Objet)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    Editable = ParaEnableFields;
                }
            }
            part("Bureau Ordre Envoyé à"; "Bureau Ordre Envoyé à")
            {
                ApplicationArea = all;
                Caption = '"Bureau Ordre Envoyé à"';
                SubPageLink = "No. Document" = FIELD("Document N°");
            }
            field(Image1; Rec.ImageP1)
            {
                ApplicationArea = all;

            }
            field(Image2; Rec.ImageP2)
            {
                ApplicationArea = all;
            }
            field(Image3; Rec.ImageP3)
            {
                ApplicationArea = all;
            }
            field(Image4; Rec.ImageP4)
            {
                ApplicationArea = all;
            }
            field(Image5; Rec.ImageP5)
            {
                ApplicationArea = all;
            }
            field(Image6; Rec.ImageP6)
            {
                ApplicationArea = all;
            }
            field(Image7; Rec.ImageP7)
            {
                ApplicationArea = all;
            }
            field(Image8; Rec.ImageP8)
            {
                ApplicationArea = all;
            }
            field(Image9; Rec.ImageP9)
            {
                ApplicationArea = all;
            }
            field(Image10; Rec.ImageP10)
            {
                ApplicationArea = all;
            }
            field(Image11; Rec.ImageP11)
            {
                ApplicationArea = all;
            }
            field(Image12; Rec.ImageP12)
            {
                ApplicationArea = all;
            }
            field(Image13; Rec.ImageP13)
            {
                ApplicationArea = all;
            }
            field(Image14; Rec.ImageP14)
            {
                ApplicationArea = all;
            }
            field(Image15; Rec.ImageP15)
            {
                ApplicationArea = all;
            }
            field(Image16; Rec.ImageP16)
            {
                ApplicationArea = all;
            }
            field(Image17; Rec.ImageP17)
            {
                ApplicationArea = all;
            }
            field(Image18; Rec.ImageP18)
            {
                ApplicationArea = all;
            }
            field(Image19; Rec.ImageP19)
            {
                ApplicationArea = all;
            }
            field(Image20; Rec.ImageP20)
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        area(processing)
        {
            action(Transfert)
            {
                ApplicationArea = all;
                Caption = 'Transfer';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    ActionGo(5);
                end;
            }
            action("Info Supp")
            {
                ApplicationArea = all;
                Caption = 'Info Supp';
                Promoted = true;
                PromotedCategory = Process;
                //  Visible = false;

                trigger OnAction()
                begin
                    ActionTranfert(2)
                end;
            }
            action(Imprimer)
            {
                ApplicationArea = all;
                Caption = 'Print';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecBureauOrdre.SETRANGE("Document N°", rec."Document N°");
                    REPORT.RUNMODAL(Report::"Documents Bureau D'ordre", TRUE, TRUE, RecBureauOrdre);
                end;
            }
            action("Clôturer ")
            {
                ApplicationArea = all;
                Caption = 'Clôturer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TextL002: Label 'Clôturer ce document ?';
                begin
                    IF rec.Clôturer THEN EXIT;
                    /* IF rec."Date Reception" = 0D THEN ERROR(Text001);

                     BureauOrdreDiffusion2.RESET;
                     BureauOrdreDiffusion2.SETRANGE("Document N°", rec."Document N°");

                     IF BureauOrdreDiffusion2.FINDFIRST THEN
                         REPEAT

                             IF BureauOrdreDiffusion2."Numero Facture" = '' THEN ERROR(Text002);

                         UNTIL BureauOrdreDiffusion2.NEXT = 0;

                     BureauOrdreDiffusion3.RESET;
                     BureauOrdreDiffusion3.SETRANGE("Document N°", rec."Document N°");

                     IF BureauOrdreDiffusion3.FINDFIRST THEN
                         REPEAT

                             IF BureauOrdreDiffusion3."Date Facture Fournisseur" = 0D THEN ERROR(Text003);

                         UNTIL BureauOrdreDiffusion3.NEXT = 0;*/



                    IF NOT CONFIRM(TextL002, FALSE) THEN EXIT;
                    rec.Clôturer := TRUE;
                    rec.MODIFY;
                    EnablesPanels(NOT Rec."Clôturer");
                    /*  BureauOrdreDiffusion.RESET;
                      BureauOrdreDiffusion.SETRANGE("Document N°", rec."Document N°");
                      IF BureauOrdreDiffusion.FINDFIRST THEN
                          REPEAT

                              BureauOrdreDiffusion.Clôturer := TRUE;
                              BureauOrdreDiffusion.MODIFY;
                          UNTIL BureauOrdreDiffusion.NEXT = 0;*/
                end;
            }
        }
    }

    var
        [InDataSet]
        ParaEnableFields: Boolean;
        RecBureauOrdre: Record "Bureau Ordre";
        PictureExists: Boolean;
        Image1: Variant;
        Image2: Variant;
        BureauOrdreDiffusion: Record "Bureau Ordre Diffusion";
        Text001: Label 'Please Enter Reception Date for Order Office';
        Text002: Label 'There are lines with an empty vendor invoice number';
        BureauOrdreDiffusion2: Record "Bureau Ordre Diffusion";
        BureauOrdreDiffusion3: Record "Bureau Ordre Diffusion";
        Text003: Label 'There are lines with an empty vendor invoice date';

    procedure ActionTranfert(TypeAction: Integer)
    var
        RecLBureauOrdreDiffusion: Record "Bureau Ordre Diffusion";
        TextL001: Label 'Confirmer cette action ?';
        "RecLBureauOrdreEnvoyéa": Record "Bureau Ordre Envoyé a";
    begin
        IF rec.Clôturer THEN EXIT;
        IF NOT CONFIRM(TextL001, FALSE) THEN EXIT;
        RecLBureauOrdreDiffusion."Type Destination" := RecLBureauOrdreDiffusion."Type Destination"::Utilisateur;
        RecLBureauOrdreDiffusion.Action := TypeAction;
        RecLBureauOrdreDiffusion."Action Faite Le" := CURRENTDATETIME;
        RecLBureauOrdreDiffusion."Action Faite Par" := USERID;
        RecLBureauOrdreDiffusion.Destinataire := rec."Receptionné Par";
        IF RecLBureauOrdreDiffusion.INSERT THEN;
        CurrPage.UPDATE;
    end;


    procedure ActionGo(TypeAction: Integer)
    var
        RecLBureauOrdreDiffusion: Record "Bureau Ordre Diffusion";
        TextL001: Label 'Confirmer cette action ?';
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
        ParaEnableFields := ParaEnable;
        // CurrPage."Categorie Document".EDITABLE := ParaEnable;
        // CurrPage.Urgence.EDITABLE := ParaEnable;
        //  CurrPage."Type Tiers".EDITABLE := ParaEnable;
        //   CurrPage.Tiers.EDITABLE := ParaEnable;
        //  CurrPage."Livré Par".EDITABLE := ParaEnable;
        //  CurrPage.Objet.EDITABLE := ParaEnable;
        // CurrPage.Remarque.EDITABLE := ParaEnable;
        CurrPage."Bureau Ordre Envoyé à".page.EDITABLE := ParaEnable;
        CurrPage."Bureau Ord Diff Dest. Detail".page.EDITABLE := ParaEnable;
        // CurrPage."Reference Document Externe".EDITABLE := ParaEnable;
        // CurrPage."Instruction Par".EDITABLE := ParaEnable;
    end;

    trigger OnOpenPage()
    begin
        ParaEnableFields := TRUE;
    end;

    procedure EnablesPanelsOpen()
    begin
        /*    CurrPage."Categorie Document".EDITABLE := TRUE;
            CurrPage.Urgence.EDITABLE := TRUE;
            CurrPage."Type Tiers".EDITABLE := TRUE;
            CurrPage.Tiers.EDITABLE := TRUE;
            CurrPage."Livr‚ Par".EDITABLE := TRUE;
            CurrPage.Objet.EDITABLE := TRUE;
            CurrPage.Remarque.EDITABLE := TRUE;
            CurrPage.FrmSuivi.EDITABLE := TRUE;
            CurrPage.FrmEnvoy‚A.EDITABLE := TRUE;*/
    end;
}

