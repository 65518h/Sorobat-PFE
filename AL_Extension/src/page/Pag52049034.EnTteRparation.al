page 52049034 "En-Tête Réparation"
{//GL2024  ID dans Nav 2009 : "39004697"
    PageType = Card;
    SourceTable = "Réparation Véhicule";
    SourceTableView = WHERE(Valider = CONST(false));


    Caption = 'En-Tête Réparation';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Reparation"; REC."N° Reparation")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE(FALSE);
                    end;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                }
                field(Affectation; REC.Affectation)
                {
                    ApplicationArea = all;
                }
                field("Statut Materiel"; REC."Statut Materiel")
                {
                    ApplicationArea = all;
                }
                field("Date Acceptation"; REC."Date Acceptation")
                {
                    ApplicationArea = all;
                }
                field("Heure Acceptation"; REC."Heure Acceptation")
                {
                    ApplicationArea = all;
                }
                field(Index; REC.Index)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Nature Panne"; REC."Nature Panne")
                {
                    ApplicationArea = all;
                }
                field("Sous Nature Panne"; REC."Sous Nature Panne")
                {
                    ApplicationArea = all;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Date Prevision Réparation"; REC."Date Prevision Réparation")
                {
                    ApplicationArea = all;
                }
                field("Descriptif Panne"; REC."Descriptif Panne")
                {
                    ApplicationArea = all;
                }
                field("Heure Prevision Réparation"; REC."Heure Prevision Réparation")
                {
                    ApplicationArea = all;
                }
                field("Date Début Réparation"; REC."Date Début Réparation")
                {
                    ApplicationArea = all;
                }
                field("Heure Debut Réparation"; REC."Heure Debut Réparation")
                {
                    ApplicationArea = all;
                }
                field("Date Fin réparation"; REC."Date Fin réparation")
                {
                    ApplicationArea = all;
                }
                field("Heure Fin Réparation"; REC."Heure Fin Réparation")
                {
                    ApplicationArea = all;
                }
                field("Motif  Ecart"; REC."Motif  Ecart")
                {
                    ApplicationArea = all;
                }
                // label()
                // {
                //     CaptionClass = Text19024074;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                field("Total Cout réparation"; REC."Total Cout réparation")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Opération Realisées"; REC."Opération Realisées")
                {
                    ApplicationArea = all;
                }
                field(Garentie; REC.Garentie)
                {
                    ApplicationArea = all;
                }
                field(Accidentée; REC.Accidentée)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Degré d'Urgence"; REC."Degré d'Urgence")
                {
                    ApplicationArea = all;
                }
            }
            part(reppar; "PR Reparation")
            {
                ApplicationArea = all;
                SubPageLink = "N° Reparation" = FIELD("N° Reparation");
            }
        }
    }

    actions
    {
        area(Promoted)

        {



            actionref("Fiche Véhicule1"; "Fiche Véhicule") { }
            actionref(Imprimer1; Imprimer) { }
            actionref(Valider1; Valider) { }


            actionref("Créer DA1"; "Créer DA") { }
            actionref("Créer Bon Sortie1"; "Créer Bon Sortie") { }

        }
        area(navigation)
        {
            group("Réparation")
            {
                Caption = 'Réparation';

                action("Fiche Véhicule")
                {
                    ApplicationArea = all;
                    Image = Card;
                    Caption = 'Fiche Véhicule';
                    RunObject = Page "Fiche Véhicule";
                    RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
                }
                action("Fiche Intervenant")
                {
                    ApplicationArea = all;
                    Image = Card;
                    Caption = 'Fiche Intervenant';
                    RunObject = Page "Vendor List";
                    Visible = false;
                }
                action(Imprimer)
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer';
                    Image = print;

                    trigger OnAction()
                    begin
                        Reparation.RESET;
                        Reparation.SETRANGE("N° Reparation", REC."N° Reparation");
                        IF Reparation.FIND('-') THEN
                            REPORT.RunModal(report::"Fiche Réparation", TRUE, FALSE, Reparation);
                    end;
                }
                action(Valider)
                {
                    ApplicationArea = all;
                    Caption = 'Valider';
                    ShortCutKey = 'F9';
                    Image = Post;

                    trigger OnAction()
                    begin
                        REC.TESTFIELD("Date Acceptation");
                        REC.TESTFIELD("Date Début Réparation");
                        REC.TESTFIELD("Date Fin réparation");
                        IF REC.Statut <> REC.Statut::Clôturé THEN ERROR('Vous Devez Cloturé La Fiche');
                        IF NOT CONFIRM('Souhaitez-Vous Valider la fiche réparation !!!', TRUE) THEN EXIT;
                        PR.SETRANGE(PR."N° Reparation", REC."N° Reparation");
                        IF PR.FINDFIRST THEN
                            REPEAT
                                PR.Statut := REC.Statut;
                                PR.MODIFY;
                            UNTIL PR.NEXT = 0;
                        REC.Valider := TRUE;
                        REC.MODIFY;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Créer DA")
            {
                ApplicationArea = all;
                Caption = 'Créer DA';
                Image = Insert;
                trigger OnAction()
                begin
                    //HS
                    IF NOT CONFIRM(Text001) THEN EXIT;
                    Ligne := 0;
                    IF Vehicule.GET(rec."N° Véhicule") THEN;
                    //  Vehicule.CalcFields("Designation Sous Affaire");
                    EnteteDa.INIT;
                    //EnteteDa."Document Type":=EnteteDa."Document Type"::Order;
                    //EnteteDa."Order Type":=EnteteDa."Order Type"::"Supply Order";
                    EnteteDa.VALIDATE("Document Date", WORKDATE);
                    EnteteDa.VALIDATE("Posting Date", WORKDATE);
                    EnteteDa.VALIDATE("Due Date", WORKDATE);
                    EnteteDa.VALIDATE("Job No.", Vehicule.marche);
                    EnteteDa.VALIDATE(Engin, rec."N° Véhicule");
                    //GL2024    EnteteDa."Date Debut Decompte":=rec."N° Reparation";
                    EnteteDa.INSERT(TRUE);
                    PRRéparation.SETRANGE("N° Reparation", rec."N° Reparation");
                    PRRéparation.SETRANGE(Type, PRRéparation.Type::Article);
                    PRRéparation.SETRANGE(Valider, FALSE);
                    PRRéparation.SETRANGE(DA, TRUE);
                    IF PRRéparation.FINDFIRST THEN
                        REPEAT
                            PRRéparation.TESTFIELD(Magasin);
                            Ligne += 10000;
                            LigneDa."Document Type" := EnteteDa."Document Type";
                            LigneDa."Document No." := EnteteDa."No.";
                            LigneDa.Type := LigneDa.Type::Item;
                            LigneDa.VALIDATE("No.", PRRéparation."No.");
                            LigneDa."Line No." := Ligne;
                            LigneDa.VALIDATE("Location Code", PRRéparation.Magasin);
                            LigneDa.VALIDATE(Quantity, PRRéparation.Quantité);
                            IF NOT LigneDa.INSERT THEN LigneDa.MODIFY;
                            PRRéparation.Valider := TRUE;
                            PRRéparation.MODIFY;
                        UNTIL PRRéparation.NEXT = 0;
                    IF EnteteDa."No." <> '' THEN MESSAGE(Text002, EnteteDa."No.");


                    //HS
                    //GL2024
                    /*     IF NOT CONFIRM(Text001) THEN EXIT;
                         Ligne := 0;
                         IF Vehicule.GET(rec."N° Véhicule") THEN;
                         //GL2024 Meme dans nav non compiler     EnteteDa2.SETRANGE("Date Debut Decompte",rec."N° Reparation") ;
                         IF NOT EnteteDa2.FINDFIRST THEN BEGIN
                             EnteteDa.INIT;
                             EnteteDa."No." := '';
                             //EnteteDa."Document Type":=EnteteDa."Document Type"::Order;
                             //EnteteDa."Order Type":=EnteteDa."Order Type"::"Supply Order";
                             EnteteDa.VALIDATE("Document Date", WORKDATE);
                             EnteteDa.VALIDATE("Posting Date", WORKDATE);
                             EnteteDa.VALIDATE("Due Date", WORKDATE);

                             EnteteDa.VALIDATE("Job No.", Vehicule."Designation Sous Affaire");
                             EnteteDa.VALIDATE(Engin, rec."N° Véhicule");
                             //GL2024    EnteteDa."Date Debut Decompte":=rec."N° Reparation";
                             EnteteDa.INSERT(TRUE);
                             PRRéparation.SETRANGE("N° Reparation", rec."N° Reparation");
                             PRRéparation.SETRANGE(Type, PRRéparation.Type::Article);
                             PRRéparation.SETRANGE(Valider, FALSE);
                             PRRéparation.SETRANGE(DA, TRUE);
                             IF PRRéparation.FINDFIRST THEN
                                 REPEAT
                                     PRRéparation.TESTFIELD(Magasin);
                                     Ligne += 10000;
                                     LigneDa."Document Type" := EnteteDa."Document Type";
                                     LigneDa."Document No." := EnteteDa."No.";
                                     LigneDa.Type := LigneDa.Type::Item;
                                     LigneDa.VALIDATE("No.", PRRéparation."No.");
                                     LigneDa."Line No." := Ligne;
                                     LigneDa.VALIDATE("Location Code", PRRéparation.Magasin);
                                     LigneDa.VALIDATE(Quantity, PRRéparation.Quantité);
                                     IF NOT LigneDa.INSERT THEN LigneDa.MODIFY;
                                     PRRéparation.Valider := TRUE;
                                     PRRéparation.MODIFY;
                                 UNTIL PRRéparation.NEXT = 0;
                             IF EnteteDa."No." <> '' THEN MESSAGE(Text002, EnteteDa."No.");
                         END
                         ELSE BEGIN
                             PRRéparation.SETRANGE("N° Reparation", rec."N° Reparation");
                             PRRéparation.SETRANGE(Type, PRRéparation.Type::Article);
                             PRRéparation.SETRANGE(Valider, FALSE);
                             PRRéparation.SETRANGE(DA, TRUE);

                             IF PRRéparation.FINDFIRST THEN
                                 REPEAT
                                     PRRéparation.TESTFIELD(Magasin);
                                     Ligne += 10000;
                                     LigneDa."Document Type" := EnteteDa2."Document Type";
                                     LigneDa."Document No." := EnteteDa2."No.";
                                     LigneDa.Type := LigneDa.Type::Item;
                                     LigneDa.VALIDATE("No.", PRRéparation."No.");
                                     LigneDa."Line No." := Ligne;
                                     LigneDa.VALIDATE("Location Code", PRRéparation.Magasin);
                                     LigneDa.VALIDATE(Quantity, PRRéparation.Quantité);
                                     IF NOT LigneDa.INSERT THEN LigneDa.MODIFY;
                                     PRRéparation.Valider := TRUE;
                                     PRRéparation.MODIFY;
                                 UNTIL PRRéparation.NEXT = 0;
                             IF EnteteDa2."No." <> '' THEN MESSAGE(Text002, EnteteDa2."No.");
                         END;*/

                end;
            }
            action("Créer Bon Sortie")
            {
                ApplicationArea = all;
                Visible = false;
                Caption = 'Créer Bon Sortie';


                trigger OnAction()
                begin
                    IF NOT CONFIRM(Text001) THEN EXIT;
                    Ligne := 0;
                    ItemJournalLine.SETRANGE("Journal Template Name", ParamétreParc."Journal Template");
                    ItemJournalLine.SETRANGE("Journal Batch Name", ParamétreParc."Journal Batch");
                    ItemJournalLine.DELETEALL;

                    IF Vehicule.GET(REC."N° Véhicule") THEN;
                    IF ParamétreParc.GET THEN;
                    PRRéparation.SETRANGE(Type, PRRéparation.Type::Article);
                    PRRéparation.SETRANGE("Bon Sortie", TRUE);
                    PRRéparation.SETRANGE("N° Reparation", REC."N° Reparation");
                    PRRéparation.SETRANGE(Valider, FALSE);
                    IF PRRéparation.FINDFIRST THEN
                        REPEAT
                            PRRéparation.TESTFIELD(Magasin);
                            Ligne += 10000;
                            ItemJournalLine."Journal Template Name" := ParamétreParc."Journal Template";
                            ItemJournalLine."Journal Batch Name" := ParamétreParc."Journal Batch";
                            ItemJournalLine."Line No." := Ligne;
                            ItemJournalLine."Document No." := REC."N° Reparation";
                            ItemJournalLine.VALIDATE("Item No.", PRRéparation."No.");
                            ItemJournalLine.VALIDATE("Posting Date", WORKDATE);
                            ItemJournalLine.VALIDATE("Location Code", PRRéparation.Magasin);
                            ItemJournalLine.VALIDATE(Quantity, PRRéparation.Quantité);
                            ItemJournalLine."Job No." := Vehicule.marche;
                            ItemJournalLine."N° Materiel" := REC."N° Véhicule";
                            ItemJournalLine."External Document No." := REC."N° Reparation";
                            IF NOT ItemJournalLine.INSERT THEN ItemJournalLine.MODIFY;
                            PRRéparation.Valider := TRUE;
                            PRRéparation.MODIFY;
                        UNTIL PRRéparation.NEXT = 0;
                    COMMIT;
                    ItemJournalLine.SETRANGE("Journal Template Name", ParamétreParc."Journal Template");
                    ItemJournalLine.SETRANGE("Journal Batch Name", ParamétreParc."Journal Batch");
                    Page.RUNMODAL(Page::"Item Journal 2", ItemJournalLine);
                end;
            }
        }
    }

    var
        DetailRep: Record "Détail Reparation";
        REpEnreg: Record "Réparation Véhicule Enreg.";
        DetailEnreg: Record "Détail Reparation Enreg.";
        Window: Dialog;
        PR: Record "PR Réparation";
        Pneu: Record "Reparation Pneu";
        PrEnreg: Record "PR Réparation Enreg.";
        //GL3900     PneuEnreg: Record "Reparation Pneu Enreg.";
        Reparation: Record "Réparation Véhicule";
        //GL3900    PnVeh: Record "Pneumatique Véhicule";
        Veh: Record "Véhicule";
        RecMission: Record Missions;
        RecItemEntry: Record "Item Journal Line";
        CUItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        RecParamétreParc: Record "Paramétre Parc";
        Compteur: Integer;
        Text001: Label 'Lancer Cette Action ?';
        EnteteDa: Record "Purchase Request";
        EnteteDa2: Record "Purchase Request";
        LigneDa: Record "Purchase request Line";
        ItemJournalLine: Record "Item Journal Line";
        PRRéparation: Record "PR Réparation";
        Ligne: Integer;
        Text002: Label 'DA Créer N° %1';
        Vehicule: Record "Véhicule";
        ParamétreParc: Record "Paramétre Parc";

        FrmItemJournal: Page "Item Journal";

        Text19024074: Label 'Opérations Realisées';


    procedure InsertItemEntry()
    var
        RecItemEntry: Record "Item Journal Line";
        CUItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        "RecParamétreParc": Record "Paramétre Parc";
        Text001: Label 'Sortie Sur Reparation N° : ';
        Text002: Label 'Erreur Insertion';
    begin
    end;
}

