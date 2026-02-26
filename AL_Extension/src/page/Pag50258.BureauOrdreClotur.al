page 50258 "Bureau Ordre Cloturé"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Bureau Ordre";
    SourceTableView = WHERE(Clôturer = FILTER(true));

    UsageCategory = Administration;
    Caption = 'Bureau Ordre Cloturé';
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("Document N°"; rec."Document N°")
                {
                    ApplicationArea = all;
                }
                field("Receptionné Par"; rec."Receptionné Par")
                {
                    ApplicationArea = all;
                    Caption = 'Utilisateur';
                }
                field("Date Reception"; rec."Date Reception")
                {
                    ApplicationArea = all;
                    Caption = 'Date Récéption';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Categorie Document"; rec."Categorie Document")
                {
                    ApplicationArea = all;
                }
                field("Envoyé à Service"; rec."Envoyé à Service")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Clôturer; rec.Clôturer)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field(Objet; rec.Objet)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
            part(FrmSuivi; "Bureau Ord Diff Dest. Detail")
            {
                ApplicationArea = all;
                SubPageLink = "Document N°" = FIELD("Document N°");
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
                Caption = 'Transfert';
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
                Visible = false;

                trigger OnAction()
                begin
                    ActionTranfert(2)
                end;
            }
            action("Clôturer2")
            {
                ApplicationArea = all;
                Caption = 'Clôturer';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    TextL002: Label 'Clôturer Ce Document ?';
                begin
                    IF rec.Clôturer THEN EXIT;
                    IF NOT CONFIRM(TextL002, FALSE) THEN EXIT;
                    rec.Clôturer := TRUE;
                    rec.MODIFY;

                    BureauOrdreDiffusion.RESET;
                    BureauOrdreDiffusion.SETRANGE("Document N°", rec."Document N°");
                    IF BureauOrdreDiffusion.FINDFIRST THEN
                        REPEAT

                            BureauOrdreDiffusion.Clôturer := TRUE;
                            BureauOrdreDiffusion.MODIFY;
                        UNTIL BureauOrdreDiffusion.NEXT = 0;
                end;
            }
            action(Imprimer)
            {
                ApplicationArea = all;
                Caption = 'Imprimer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecBureauOrdre.SETRANGE("Document N°", rec."Document N°");
                    REPORT.RUNMODAL(Report::"Documents Bureau D'ordre", TRUE, TRUE, RecBureauOrdre);
                end;
            }
        }
    }

    var
        RecBureauOrdre: Record "Bureau Ordre";
        PictureExists: Boolean;
        Image1: Variant;
        Image2: Variant;
        BureauOrdreDiffusion: Record "Bureau Ordre Diffusion";


    procedure ActionTranfert(TypeAction: Integer)
    var
        RecLBureauOrdreDiffusion: Record "Bureau Ordre Diffusion";
        TextL001: Label 'Confirmer Cette Action ?';
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
    end;


    procedure EnablesPanelsOpen()
    begin
    end;
}

